import { FC } from 'react';
import ComponentCard from '../../components/common/ComponentCard';
import PageBreadCrumb from '../../components/common/PageBreadCrumb';
import PageMeta from '../../components/common/PageMeta';

const DataInsights: FC = () => {
  return (
    <div>
      <PageMeta title="Data Insights" />
      <PageBreadCrumb
        pageName="Data Insights"
        description="Showing data insights and charts"
      />
      <div className="grid grid-cols-1 gap-4 md:grid-cols-2 md:gap-6 xl:grid-cols-4 2xl:gap-7.5"></div>

      <div className="mt-4 grid grid-cols-12 gap-4 md:mt-6 md:gap-6 2xl:mt-7.5">
        <div className="col-span-12">
          <ComponentCard title="Charts">
            <div></div>
          </ComponentCard>
        </div>
      </div>
    </div>
  );
};

export default DataInsights;
