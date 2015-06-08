<?php

class Mage_Catalog_Block_Product_Popular extends Mage_Catalog_Block_Product_Abstract
{
    protected $_productsCount = null;
    protected $_productCollection = null;

    protected function _getProductCollection()
    {
        if (is_null($this->_productCollection)) {
            $categoryId = $this->getCategoryId();
            $category = Mage::getModel('catalog/category')->load($categoryId);
            $storeId = Mage::app()->getStore()->getId();
            $product = Mage::getModel('catalog/product');
            $visibility = array(
                Mage_Catalog_Model_Product_Visibility::VISIBILITY_BOTH,
                Mage_Catalog_Model_Product_Visibility::VISIBILITY_IN_CATALOG
            );

            $this->_productCollection = $product->setStoreId($storeId)
                ->getCollection()
                ->addAttributeToFilter('visibility', $visibility)
                ->addCategoryFilter($category)
                ->addAttributeToSelect('*');

            $this->prepareSortableFieldsByCategory($category);

            if ($sort = $this->getSortBy()) {
                $this->_productCollection->setOrder($sort);
            }

            if ($count = $this->getProductsCount()) {
                $this->_productCollection
                    ->setPageSize($count)
                    ->setCurPage(1)
                    ->load()
                ;
            }
            Mage::getModel('review/review')->appendSummary($this->_productCollection);
        }

        return $this->_productCollection;
    }

    /**
     * Retrieve loaded category collection
     *
     * @return Mage_Eav_Model_Entity_Collection_Abstract
     */
    public function getLoadedProductCollection()
    {
        return $this->_getProductCollection();
    }

    /**
     * Retrieve Catalog Config object
     *
     * @return Mage_Catalog_Model_Config
     */
    protected function _getConfig()
    {
        return Mage::getSingleton('catalog/config');
    }

    /**
     * Prepare Sort By fields from Category Data
     *
     * @param Mage_Catalog_Model_Category $category
     * @return Mage_Catalog_Block_Product_List
     */
    public function prepareSortableFieldsByCategory($category)
    {
        if (!$this->getAvailableOrders()) {
            $this->setAvailableOrders($category->getAvailableSortByOptions());
        }
        $availableOrders = $this->getAvailableOrders();
        if (!$this->getSortBy()) {
            if ($categorySortBy = $category->getDefaultSortBy()) {
                if (!$availableOrders) {
                    $availableOrders = $this->_getConfig()->getAttributeUsedForSortByArray();
                }
                if (isset($availableOrders[$categorySortBy])) {
                    $this->setSortBy($categorySortBy);
                }
            }
        }
        return $this;
    }

    public function setProductsCount($count)
    {
        $this->_productsCount = $count;
        return $this;
    }

    public function getProductsCount()
    {
        return $this->_productsCount;
    }
}
