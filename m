Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BABA50C877
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiDWJCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiDWJCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:02:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF8B1928F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650704357; x=1682240357;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2g1itbMXUBjxlnYgS7qtTM0GHhuc5H/xv43AoxZPRS0=;
  b=aniTd7f9VUQiU1PcH41FYfTXvn5wi7hVZxXMWSDI0/1gn45sFAuuEHKt
   Mx0+N4JM0xTESszarCckNXzjwD1L+tSwQZc5Tb0Li9YSe8HP/lQu03dVD
   vvm9hgn7QC65WicYMBOCRVyh7BmPES2ytM5tPWtWQSKAJfkvLchyx1beQ
   Y3+6oo7gzwW+mjJ/bMc+Df0Iqx2CcbCH6SY1YWLLRX5I6CBjYiDui+N2N
   Ol97Toe8T8ds7k9/BY5fM52Uq9GF6/+mPTuMxCOh6HsbNqlLeUjJ5qWqQ
   lYesN2P2bOugXlGmHceGgyL8Y7yjU+VPWBhzixLty+ooQ6J8u7857HLs/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289999726"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="289999726"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 01:59:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="594485765"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Apr 2022 01:59:13 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niBbk-00005i-I3;
        Sat, 23 Apr 2022 08:59:12 +0000
Date:   Sat, 23 Apr 2022 16:59:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/nvdimm/namespace_devs.c:1991:10: warning: Local variable
 'uuid' shadows outer variable [shadowVariable]
Message-ID: <202204231623.UPDSSd2R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c00c5e1d157bec0ef0b0b59aa5482eb8dc7e8e49
commit: d1c6e08e7503649e4a4f3f9e700e2c05300b6379 libnvdimm/labels: Add uuid helpers
date:   7 months ago
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout d1c6e08e7503649e4a4f3f9e700e2c05300b6379
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
   drivers/nvdimm/namespace_devs.c:913:20: warning: Local variable 'res' shadows outer variable [shadowVariable]
     struct resource *res;
                      ^
   drivers/nvdimm/namespace_devs.c:901:19: note: Shadowed declaration
    struct resource *res = &nspm->nsio.res;
                     ^
   drivers/nvdimm/namespace_devs.c:913:20: note: Shadow variable
     struct resource *res;
                      ^
>> drivers/nvdimm/namespace_devs.c:1991:10: warning: Local variable 'uuid' shadows outer variable [shadowVariable]
     uuid_t uuid;
            ^
   drivers/nvdimm/namespace_devs.c:1959:9: note: Shadowed declaration
    uuid_t uuid;
           ^
   drivers/nvdimm/namespace_devs.c:1991:10: note: Shadow variable
     uuid_t uuid;
            ^
   drivers/nvdimm/namespace_devs.c:2031:26: warning: Local variable 'ndd' shadows outer variable [shadowVariable]
     struct nvdimm_drvdata *ndd;
                            ^
   drivers/nvdimm/namespace_devs.c:1949:25: note: Shadowed declaration
    struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
                           ^
   drivers/nvdimm/namespace_devs.c:2031:26: note: Shadow variable
     struct nvdimm_drvdata *ndd;
                            ^
   drivers/nvdimm/namespace_devs.c:2427:26: warning: Local variable 'e' shadows outer variable [shadowVariable]
      struct list_head *l, *e;
                            ^
   drivers/nvdimm/namespace_devs.c:2334:35: note: Shadowed declaration
    struct nd_label_ent *label_ent, *e;
                                     ^
   drivers/nvdimm/namespace_devs.c:2427:26: note: Shadow variable
      struct list_head *l, *e;
                            ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   drivers/nvdimm/namespace_devs.c:1236:9: warning: Uninitialized variable: nd_label [uninitvar]
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:1232:51: note: Assignment 'nd_label=label_ent->label', assigned value is <Uninit>
      struct nd_namespace_label *nd_label = label_ent->label;
                                                     ^
   drivers/nvdimm/namespace_devs.c:1236:9: note: Uninitialized variable: nd_label
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:1853:9: warning: Uninitialized variable: nd_label [uninitvar]
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:1850:51: note: Assignment 'nd_label=label_ent->label', assigned value is <Uninit>
      struct nd_namespace_label *nd_label = label_ent->label;
                                                     ^
   drivers/nvdimm/namespace_devs.c:1853:9: note: Uninitialized variable: nd_label
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:1903:9: warning: Uninitialized variable: nd_label [uninitvar]
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:1902:24: note: Assignment 'nd_label=label_ent->label', assigned value is <Uninit>
      nd_label = label_ent->label;
                          ^
   drivers/nvdimm/namespace_devs.c:1903:9: note: Uninitialized variable: nd_label
      if (!nd_label)
           ^
   drivers/nvdimm/namespace_devs.c:2345:8: warning: Uninitialized variable: nd_label [uninitvar]
     if (!nd_label)
          ^
   drivers/nvdimm/namespace_devs.c:2341:50: note: Assignment 'nd_label=label_ent->label', assigned value is <Uninit>
     struct nd_namespace_label *nd_label = label_ent->label;
                                                    ^
   drivers/nvdimm/namespace_devs.c:2345:8: note: Uninitialized variable: nd_label
     if (!nd_label)
          ^

vim +/uuid +1991 drivers/nvdimm/namespace_devs.c

  1938	
  1939	/**
  1940	 * create_namespace_pmem - validate interleave set labelling, retrieve label0
  1941	 * @nd_region: region with mappings to validate
  1942	 * @nspm: target namespace to create
  1943	 * @nd_label: target pmem namespace label to evaluate
  1944	 */
  1945	static struct device *create_namespace_pmem(struct nd_region *nd_region,
  1946						    struct nd_mapping *nd_mapping,
  1947						    struct nd_namespace_label *nd_label)
  1948	{
  1949		struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
  1950		struct nd_namespace_index *nsindex =
  1951			to_namespace_index(ndd, ndd->ns_current);
  1952		u64 cookie = nd_region_interleave_set_cookie(nd_region, nsindex);
  1953		u64 altcookie = nd_region_interleave_set_altcookie(nd_region);
  1954		struct nd_label_ent *label_ent;
  1955		struct nd_namespace_pmem *nspm;
  1956		resource_size_t size = 0;
  1957		struct resource *res;
  1958		struct device *dev;
  1959		uuid_t uuid;
  1960		int rc = 0;
  1961		u16 i;
  1962	
  1963		if (cookie == 0) {
  1964			dev_dbg(&nd_region->dev, "invalid interleave-set-cookie\n");
  1965			return ERR_PTR(-ENXIO);
  1966		}
  1967	
  1968		if (!nsl_validate_isetcookie(ndd, nd_label, cookie)) {
  1969			dev_dbg(&nd_region->dev, "invalid cookie in label: %pUb\n",
  1970				nsl_uuid_raw(ndd, nd_label));
  1971			if (!nsl_validate_isetcookie(ndd, nd_label, altcookie))
  1972				return ERR_PTR(-EAGAIN);
  1973	
  1974			dev_dbg(&nd_region->dev, "valid altcookie in label: %pUb\n",
  1975				nsl_uuid_raw(ndd, nd_label));
  1976		}
  1977	
  1978		nspm = kzalloc(sizeof(*nspm), GFP_KERNEL);
  1979		if (!nspm)
  1980			return ERR_PTR(-ENOMEM);
  1981	
  1982		nspm->id = -1;
  1983		dev = &nspm->nsio.common.dev;
  1984		dev->type = &namespace_pmem_device_type;
  1985		dev->parent = &nd_region->dev;
  1986		res = &nspm->nsio.res;
  1987		res->name = dev_name(&nd_region->dev);
  1988		res->flags = IORESOURCE_MEM;
  1989	
  1990		for (i = 0; i < nd_region->ndr_mappings; i++) {
> 1991			uuid_t uuid;
  1992	
  1993			nsl_get_uuid(ndd, nd_label, &uuid);
  1994			if (has_uuid_at_pos(nd_region, &uuid, cookie, i))
  1995				continue;
  1996			if (has_uuid_at_pos(nd_region, &uuid, altcookie, i))
  1997				continue;
  1998			break;
  1999		}
  2000	
  2001		if (i < nd_region->ndr_mappings) {
  2002			struct nvdimm *nvdimm = nd_region->mapping[i].nvdimm;
  2003	
  2004			/*
  2005			 * Give up if we don't find an instance of a uuid at each
  2006			 * position (from 0 to nd_region->ndr_mappings - 1), or if we
  2007			 * find a dimm with two instances of the same uuid.
  2008			 */
  2009			dev_err(&nd_region->dev, "%s missing label for %pUb\n",
  2010				nvdimm_name(nvdimm), nsl_uuid_raw(ndd, nd_label));
  2011			rc = -EINVAL;
  2012			goto err;
  2013		}
  2014	
  2015		/*
  2016		 * Fix up each mapping's 'labels' to have the validated pmem label for
  2017		 * that position at labels[0], and NULL at labels[1].  In the process,
  2018		 * check that the namespace aligns with interleave-set.  We know
  2019		 * that it does not overlap with any blk namespaces by virtue of
  2020		 * the dimm being enabled (i.e. nd_label_reserve_dpa()
  2021		 * succeeded).
  2022		 */
  2023		nsl_get_uuid(ndd, nd_label, &uuid);
  2024		rc = select_pmem_id(nd_region, &uuid);
  2025		if (rc)
  2026			goto err;
  2027	
  2028		/* Calculate total size and populate namespace properties from label0 */
  2029		for (i = 0; i < nd_region->ndr_mappings; i++) {
  2030			struct nd_namespace_label *label0;
  2031			struct nvdimm_drvdata *ndd;
  2032	
  2033			nd_mapping = &nd_region->mapping[i];
  2034			label_ent = list_first_entry_or_null(&nd_mapping->labels,
  2035					typeof(*label_ent), list);
  2036			label0 = label_ent ? label_ent->label : NULL;
  2037	
  2038			if (!label0) {
  2039				WARN_ON(1);
  2040				continue;
  2041			}
  2042	
  2043			ndd = to_ndd(nd_mapping);
  2044			size += nsl_get_rawsize(ndd, label0);
  2045			if (nsl_get_position(ndd, label0) != 0)
  2046				continue;
  2047			WARN_ON(nspm->alt_name || nspm->uuid);
  2048			nspm->alt_name = kmemdup(nsl_ref_name(ndd, label0),
  2049						 NSLABEL_NAME_LEN, GFP_KERNEL);
  2050			nsl_get_uuid(ndd, label0, &uuid);
  2051			nspm->uuid = kmemdup(&uuid, sizeof(uuid_t), GFP_KERNEL);
  2052			nspm->lbasize = nsl_get_lbasize(ndd, label0);
  2053			nspm->nsio.common.claim_class =
  2054				nsl_get_claim_class(ndd, label0);
  2055		}
  2056	
  2057		if (!nspm->alt_name || !nspm->uuid) {
  2058			rc = -ENOMEM;
  2059			goto err;
  2060		}
  2061	
  2062		nd_namespace_pmem_set_resource(nd_region, nspm, size);
  2063	
  2064		return dev;
  2065	 err:
  2066		namespace_pmem_release(dev);
  2067		switch (rc) {
  2068		case -EINVAL:
  2069			dev_dbg(&nd_region->dev, "invalid label(s)\n");
  2070			break;
  2071		case -ENODEV:
  2072			dev_dbg(&nd_region->dev, "label not found\n");
  2073			break;
  2074		default:
  2075			dev_dbg(&nd_region->dev, "unexpected err: %d\n", rc);
  2076			break;
  2077		}
  2078		return ERR_PTR(rc);
  2079	}
  2080	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
