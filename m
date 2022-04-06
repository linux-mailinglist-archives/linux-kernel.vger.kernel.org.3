Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825314F5BA9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345474AbiDFK1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347298AbiDFK0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:26:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5E41BD9B4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649227733; x=1680763733;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fe1HvuydVZpIx/fapGwC9n83OxyAvhBPFz+zlKxSRM4=;
  b=iRpTLHvN8SGULHrDwU++9c8XaO63wvy8FVsdixGsBdmlCCSvbBC1Q6Wb
   X/fslRybmmn7fyFH0uUhXbEayN+9PnEqqUDBeQCdDADYdOGRoJI/Sd+R/
   81SCwniMDQj5UKUAgCsc7FpcfV9tXpKA3NEBOKBwh7hv/cb8Eu3xXiXWX
   yZg+Uby9/0mzzzbwj9iusGMXayM5XiMGc2btfKrOy/uMqDFzJowl6Xk2L
   1WiJUzOIynF8ZwNfFxCZVpyaj+uL5UUyrLmJcHgGWLQwjDLicKK1AXW6F
   A4LGY9CzI2pAH9zHQPoMfgphm5SjwcEymk6Cj5a6SRhfU3f7Egcwlwtm2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260664301"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="260664301"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 23:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="524335040"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 23:48:51 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbzTG-00049N-KP;
        Wed, 06 Apr 2022 06:48:50 +0000
Date:   Wed, 6 Apr 2022 14:47:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-v2 13/15] drivers/opp/core.c:2252:34:
 error: 'np' undeclared; did you mean 'up'?
Message-ID: <202204061419.k57I1cIf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-v2
head:   fff8a3e9335a828deb502bbcf983c4316d27c74e
commit: 92622915a3dd2035b67cef4ef60bea1f941b3876 [13/15] PM wip
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220406/202204061419.k57I1cIf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/krzk/linux/commit/92622915a3dd2035b67cef4ef60bea1f941b3876
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-v2
        git checkout 92622915a3dd2035b67cef4ef60bea1f941b3876
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/opp/core.c: In function 'dev_pm_opp_set_clkname':
   drivers/opp/core.c:2185:16: error: implicit declaration of function 'dev_pm_opp_set_clknames'; did you mean 'dev_pm_opp_set_clkname'? [-Werror=implicit-function-declaration]
    2185 |         return dev_pm_opp_set_clknames(dev, &name, 1);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
         |                dev_pm_opp_set_clkname
   drivers/opp/core.c:2185:16: warning: returning 'int' from a function with return type 'struct opp_table *' makes pointer from integer without a cast [-Wint-conversion]
    2185 |         return dev_pm_opp_set_clknames(dev, &name, 1);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/opp/core.c: In function 'dev_pm_opp_put_clkname':
   drivers/opp/core.c:2195:16: error: implicit declaration of function 'dev_pm_opp_put_clknames'; did you mean 'dev_pm_opp_put_clkname'? [-Werror=implicit-function-declaration]
    2195 |         return dev_pm_opp_put_clknames(opp_table);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
         |                dev_pm_opp_put_clkname
   drivers/opp/core.c:2195:16: error: 'return' with a value, in function returning void [-Werror=return-type]
    2195 |         return dev_pm_opp_put_clknames(opp_table);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/opp/core.c:2193:6: note: declared here
    2193 | void dev_pm_opp_put_clkname(struct opp_table *opp_table)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/opp/core.c: At top level:
   drivers/opp/core.c:2204:19: warning: no previous prototype for 'dev_pm_opp_set_clknames' [-Wmissing-prototypes]
    2204 | struct opp_table *dev_pm_opp_set_clknames(struct device *dev,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/opp/core.c:2204:19: error: conflicting types for 'dev_pm_opp_set_clknames'; have 'struct opp_table *(struct device *, const char * const*, unsigned int)'
   drivers/opp/core.c:2185:16: note: previous implicit declaration of 'dev_pm_opp_set_clknames' with type 'int()'
    2185 |         return dev_pm_opp_set_clknames(dev, &name, 1);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:29,
                    from include/linux/clk.h:13,
                    from drivers/opp/core.c:13:
   drivers/opp/core.c: In function 'dev_pm_opp_set_clknames':
>> drivers/opp/core.c:2252:34: error: 'np' undeclared (first use in this function); did you mean 'up'?
    2252 |                of_node_full_name(np), count, opp_table->clk_count);
         |                                  ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'printk'
     489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/opp/core.c:2251:9: note: in expansion of macro 'pr_err'
    2251 |         pr_err("AAA %s:%d - read %s - %d clocks (count %d)\n", __func__, __LINE__,
         |         ^~~~~~
   drivers/opp/core.c:2252:34: note: each undeclared identifier is reported only once for each function it appears in
    2252 |                of_node_full_name(np), count, opp_table->clk_count);
         |                                  ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'printk'
     489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/opp/core.c:2251:9: note: in expansion of macro 'pr_err'
    2251 |         pr_err("AAA %s:%d - read %s - %d clocks (count %d)\n", __func__, __LINE__,
         |         ^~~~~~
   drivers/opp/core.c: At top level:
   drivers/opp/core.c:2271:6: warning: no previous prototype for 'dev_pm_opp_put_clknames' [-Wmissing-prototypes]
    2271 | void dev_pm_opp_put_clknames(struct opp_table *opp_table)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/opp/core.c:2271:6: warning: conflicting types for 'dev_pm_opp_put_clknames'; have 'void(struct opp_table *)'
   drivers/opp/core.c:2195:16: note: previous implicit declaration of 'dev_pm_opp_put_clknames' with type 'void(struct opp_table *)'
    2195 |         return dev_pm_opp_put_clknames(opp_table);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +2252 drivers/opp/core.c

  2203	
  2204	struct opp_table *dev_pm_opp_set_clknames(struct device *dev,
  2205						  const char * const names[],
  2206						  unsigned int count)
  2207	{
  2208		struct opp_table *opp_table;
  2209		struct clk *clk;
  2210		int ret, i;
  2211	
  2212		opp_table = _add_opp_table(dev, false, OPP_TABLE_VERSION_2);
  2213		if (IS_ERR(opp_table))
  2214			return opp_table;
  2215	
  2216		/* This should be called before OPPs are initialized */
  2217		if (WARN_ON(!list_empty(&opp_table->opp_list))) {
  2218			ret = -EBUSY;
  2219			goto err;
  2220		}
  2221	
  2222		/* clk shouldn't be initialized at this point */
  2223		if (WARN_ON(opp_table->clks)) {
  2224			ret = -EBUSY;
  2225			goto err;
  2226		}
  2227	
  2228		if (!names) {
  2229			
  2230		}
  2231		opp_table->clks = kmalloc_array(count, sizeof(*opp_table->clks),
  2232						GFP_KERNEL);
  2233		if (!opp_table->clks) {
  2234			ret = -ENOMEM;
  2235			goto err;
  2236		}
  2237	
  2238		for (i = 0; i < count; i++) {
  2239			clk = clk_get(dev, names[i]);
  2240			if (IS_ERR(clk)) {
  2241				ret =  dev_err_probe(dev, PTR_ERR(clk),
  2242						     "%s: Couldn't find clock %s\n",
  2243						     __func__, names[i]);
  2244				goto free_clks;
  2245			}
  2246			pr_err("AAA getting clock %s=%px\n", names[i], clk);
  2247	
  2248			opp_table->clks[i] = clk;
  2249		}
  2250	
  2251		pr_err("AAA %s:%d - read %s - %d clocks (count %d)\n", __func__, __LINE__,
> 2252		       of_node_full_name(np), count, opp_table->clk_count);
  2253		opp_table->clk_count = count;
  2254	
  2255		return opp_table;
  2256	
  2257	free_clks:
  2258		while (i != 0)
  2259			clk_put(opp_table->clks[--i]);
  2260	
  2261		kfree(opp_table->clks);
  2262		opp_table->clks = NULL;
  2263		opp_table->clk_count = -1;
  2264	err:
  2265		dev_pm_opp_put_opp_table(opp_table);
  2266	
  2267		return ERR_PTR(ret);
  2268	}
  2269	EXPORT_SYMBOL_GPL(dev_pm_opp_set_clknames);
  2270	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
