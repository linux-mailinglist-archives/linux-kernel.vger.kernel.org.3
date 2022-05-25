Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E44533FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiEYPEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiEYPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:04:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB5BA55D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653490987; x=1685026987;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2WEHTkAKQ8I56RwPl2u9phhDHzaIh3NBVFOIGsl1cHg=;
  b=Y1bhQJIAmk8fQCnOwxVOe7ORfggF2T/ukerhaZGGoDdxUHTlXdCoRh7w
   5P9Fivi///jfW67/kJ47lcph3ujHQ6Sg2YGxPk8/6heVDtieIJEejVW7r
   49GOdQTdVoWODkdJ640z74zeEUIKgA3zwZs5eVJoOkEuksAShKXoy4+fG
   yUe+37NPM4HbF2kQbtTEWGRRIkUScNUYlTTjUh48wn21uW2V+7xDWnDUz
   f2xTy1CdC8RsZ8ea7RnubT4/V6n/lqS9ccP0o3OW/neq3n7vH2eks0LxP
   W6/S6iRE4Axr/eFwCYZRlV4fS/I3+dI6zUSrBTFjXj1OHGlXl0sdXktLX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="254333837"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="254333837"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 08:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="745779216"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 May 2022 08:02:56 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntsXI-00034k-6q;
        Wed, 25 May 2022 15:02:56 +0000
Date:   Wed, 25 May 2022 23:02:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [vireshk-pm:opp/config 33/33] drivers/opp/core.c:1961:19: warning:
 no previous prototype for 'dev_pm_opp_set_supported_hw'
Message-ID: <202205252210.GxZfRn3E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/config
head:   d730dc101c586defb49eeafd8eea9b7bb0baa01b
commit: d730dc101c586defb49eeafd8eea9b7bb0baa01b [33/33] OPP: Remove unused APIs
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220525/202205252210.GxZfRn3E-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?id=d730dc101c586defb49eeafd8eea9b7bb0baa01b
        git remote add vireshk-pm https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
        git fetch --no-tags vireshk-pm opp/config
        git checkout d730dc101c586defb49eeafd8eea9b7bb0baa01b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/opp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/opp/core.c:1961:19: warning: no previous prototype for 'dev_pm_opp_set_supported_hw' [-Wmissing-prototypes]
    1961 | struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:1998:6: warning: no previous prototype for 'dev_pm_opp_put_supported_hw' [-Wmissing-prototypes]
    1998 | void dev_pm_opp_put_supported_hw(struct opp_table *opp_table)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2026:5: warning: no previous prototype for 'devm_pm_opp_set_supported_hw' [-Wmissing-prototypes]
    2026 | int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2050:19: warning: no previous prototype for 'dev_pm_opp_set_prop_name' [-Wmissing-prototypes]
    2050 | struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2083:6: warning: no previous prototype for 'dev_pm_opp_put_prop_name' [-Wmissing-prototypes]
    2083 | void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2107:19: warning: no previous prototype for 'dev_pm_opp_set_regulators' [-Wmissing-prototypes]
    2107 | struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2186:6: warning: no previous prototype for 'dev_pm_opp_put_regulators' [-Wmissing-prototypes]
    2186 | void dev_pm_opp_put_regulators(struct opp_table *opp_table)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2238:5: warning: no previous prototype for 'devm_pm_opp_set_regulators' [-Wmissing-prototypes]
    2238 | int devm_pm_opp_set_regulators(struct device *dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2265:19: warning: no previous prototype for 'dev_pm_opp_set_clkname' [-Wmissing-prototypes]
    2265 | struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
         |                   ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2309:6: warning: no previous prototype for 'dev_pm_opp_put_clkname' [-Wmissing-prototypes]
    2309 | void dev_pm_opp_put_clkname(struct opp_table *opp_table)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2336:5: warning: no previous prototype for 'devm_pm_opp_set_clkname' [-Wmissing-prototypes]
    2336 | int devm_pm_opp_set_clkname(struct device *dev, const char *name)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2359:19: warning: no previous prototype for 'dev_pm_opp_register_set_opp_helper' [-Wmissing-prototypes]
    2359 | struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2408:6: warning: no previous prototype for 'dev_pm_opp_unregister_set_opp_helper' [-Wmissing-prototypes]
    2408 | void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2438:5: warning: no previous prototype for 'devm_pm_opp_register_set_opp_helper' [-Wmissing-prototypes]
    2438 | int devm_pm_opp_register_set_opp_helper(struct device *dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2493:19: warning: no previous prototype for 'dev_pm_opp_attach_genpd' [-Wmissing-prototypes]
    2493 | struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2570:6: warning: no previous prototype for 'dev_pm_opp_detach_genpd' [-Wmissing-prototypes]
    2570 | void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/opp/core.c:2603:5: warning: no previous prototype for 'devm_pm_opp_attach_genpd' [-Wmissing-prototypes]
    2603 | int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/dev_pm_opp_set_supported_hw +1961 drivers/opp/core.c

38393409da345cd drivers/base/power/opp.c      Viresh Kumar        2014-11-25  1949  
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1950  /**
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1951   * dev_pm_opp_set_supported_hw() - Set supported platforms
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1952   * @dev: Device for which supported-hw has to be set.
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1953   * @versions: Array of hierarchy of versions to match.
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1954   * @count: Number of elements in the array.
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1955   *
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1956   * This is required only for the V2 bindings, and it enables a platform to
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1957   * specify the hierarchy of versions it supports. OPP layer will then enable
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1958   * OPPs, which are available for those versions, based on its 'opp-supported-hw'
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1959   * property.
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1960   */
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23 @1961  struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1962  			const u32 *versions, unsigned int count)
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1963  {
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1964  	struct opp_table *opp_table;
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1965  
32439ac7535a8ed drivers/opp/core.c            Viresh Kumar        2021-01-28  1966  	opp_table = _add_opp_table(dev, false);
dd461cd9183fe80 drivers/opp/core.c            Stephan Gerhold     2020-07-27  1967  	if (IS_ERR(opp_table))
dd461cd9183fe80 drivers/opp/core.c            Stephan Gerhold     2020-07-27  1968  		return opp_table;
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1969  
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1970  	/* Make sure there are no concurrent readers while updating opp_table */
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1971  	WARN_ON(!list_empty(&opp_table->opp_list));
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1972  
25419de1b8dda24 drivers/opp/core.c            Viresh Kumar        2018-05-22  1973  	/* Another CPU that shares the OPP table has set the property ? */
25419de1b8dda24 drivers/opp/core.c            Viresh Kumar        2018-05-22  1974  	if (opp_table->supported_hw)
25419de1b8dda24 drivers/opp/core.c            Viresh Kumar        2018-05-22  1975  		return opp_table;
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1976  
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1977  	opp_table->supported_hw = kmemdup(versions, count * sizeof(*versions),
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1978  					GFP_KERNEL);
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1979  	if (!opp_table->supported_hw) {
25419de1b8dda24 drivers/opp/core.c            Viresh Kumar        2018-05-22  1980  		dev_pm_opp_put_opp_table(opp_table);
25419de1b8dda24 drivers/opp/core.c            Viresh Kumar        2018-05-22  1981  		return ERR_PTR(-ENOMEM);
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1982  	}
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1983  
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1984  	opp_table->supported_hw_count = count;
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1985  
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1986  	return opp_table;
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1987  }
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1988  EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1989  
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1990  /**
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1991   * dev_pm_opp_put_supported_hw() - Releases resources blocked for supported hw
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  1992   * @opp_table: OPP table returned by dev_pm_opp_set_supported_hw().
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1993   *
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1994   * This is required only for the V2 bindings, and is called for a matching
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  1995   * dev_pm_opp_set_supported_hw(). Until this is called, the opp_table structure
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1996   * will not be freed.
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1997   */
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23 @1998  void dev_pm_opp_put_supported_hw(struct opp_table *opp_table)
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  1999  {
c7bf8758c955e62 drivers/opp/core.c            Viresh Kumar        2020-11-06  2000  	if (unlikely(!opp_table))
c7bf8758c955e62 drivers/opp/core.c            Viresh Kumar        2020-11-06  2001  		return;
c7bf8758c955e62 drivers/opp/core.c            Viresh Kumar        2020-11-06  2002  
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2003  	kfree(opp_table->supported_hw);
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2004  	opp_table->supported_hw = NULL;
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2005  	opp_table->supported_hw_count = 0;
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2006  
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  2007  	dev_pm_opp_put_opp_table(opp_table);
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2008  }
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2009  EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
7de36b0aa51a5a5 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2010  
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2011  static void devm_pm_opp_supported_hw_release(void *data)
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2012  {
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2013  	dev_pm_opp_put_supported_hw(data);
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2014  }
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2015  
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2016  /**
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2017   * devm_pm_opp_set_supported_hw() - Set supported platforms
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2018   * @dev: Device for which supported-hw has to be set.
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2019   * @versions: Array of hierarchy of versions to match.
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2020   * @count: Number of elements in the array.
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2021   *
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2022   * This is a resource-managed variant of dev_pm_opp_set_supported_hw().
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2023   *
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2024   * Return: 0 on success and errorno otherwise.
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2025   */
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14 @2026  int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2027  				 unsigned int count)
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2028  {
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2029  	struct opp_table *opp_table;
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2030  
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2031  	opp_table = dev_pm_opp_set_supported_hw(dev, versions, count);
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2032  	if (IS_ERR(opp_table))
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2033  		return PTR_ERR(opp_table);
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2034  
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2035  	return devm_add_action_or_reset(dev, devm_pm_opp_supported_hw_release,
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2036  					opp_table);
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2037  }
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2038  EXPORT_SYMBOL_GPL(devm_pm_opp_set_supported_hw);
9c4f220f3dc260e drivers/opp/core.c            Yangtao Li          2021-03-14  2039  
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2040  /**
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2041   * dev_pm_opp_set_prop_name() - Set prop-extn name
a5da64477ee79ef drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2042   * @dev: Device for which the prop-name has to be set.
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2043   * @name: name to postfix to properties.
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2044   *
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2045   * This is required only for the V2 bindings, and it enables a platform to
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2046   * specify the extn to be used for certain property names. The properties to
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2047   * which the extension will apply are opp-microvolt and opp-microamp. OPP core
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2048   * should postfix the property name with -<name> while looking for them.
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2049   */
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23 @2050  struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2051  {
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2052  	struct opp_table *opp_table;
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2053  
32439ac7535a8ed drivers/opp/core.c            Viresh Kumar        2021-01-28  2054  	opp_table = _add_opp_table(dev, false);
dd461cd9183fe80 drivers/opp/core.c            Stephan Gerhold     2020-07-27  2055  	if (IS_ERR(opp_table))
dd461cd9183fe80 drivers/opp/core.c            Stephan Gerhold     2020-07-27  2056  		return opp_table;
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2057  
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2058  	/* Make sure there are no concurrent readers while updating opp_table */
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2059  	WARN_ON(!list_empty(&opp_table->opp_list));
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2060  
878ec1a9f0e5a6b drivers/opp/core.c            Viresh Kumar        2018-05-22  2061  	/* Another CPU that shares the OPP table has set the property ? */
878ec1a9f0e5a6b drivers/opp/core.c            Viresh Kumar        2018-05-22  2062  	if (opp_table->prop_name)
878ec1a9f0e5a6b drivers/opp/core.c            Viresh Kumar        2018-05-22  2063  		return opp_table;
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2064  
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2065  	opp_table->prop_name = kstrdup(name, GFP_KERNEL);
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2066  	if (!opp_table->prop_name) {
878ec1a9f0e5a6b drivers/opp/core.c            Viresh Kumar        2018-05-22  2067  		dev_pm_opp_put_opp_table(opp_table);
878ec1a9f0e5a6b drivers/opp/core.c            Viresh Kumar        2018-05-22  2068  		return ERR_PTR(-ENOMEM);
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2069  	}
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2070  
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  2071  	return opp_table;
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2072  }
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2073  EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2074  
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2075  /**
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2076   * dev_pm_opp_put_prop_name() - Releases resources blocked for prop-name
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  2077   * @opp_table: OPP table returned by dev_pm_opp_set_prop_name().
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2078   *
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2079   * This is required only for the V2 bindings, and is called for a matching
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2080   * dev_pm_opp_set_prop_name(). Until this is called, the opp_table structure
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2081   * will not be freed.
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2082   */
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23 @2083  void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2084  {
c7bf8758c955e62 drivers/opp/core.c            Viresh Kumar        2020-11-06  2085  	if (unlikely(!opp_table))
c7bf8758c955e62 drivers/opp/core.c            Viresh Kumar        2020-11-06  2086  		return;
c7bf8758c955e62 drivers/opp/core.c            Viresh Kumar        2020-11-06  2087  
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2088  	kfree(opp_table->prop_name);
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2089  	opp_table->prop_name = NULL;
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2090  
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  2091  	dev_pm_opp_put_opp_table(opp_table);
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2092  }
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2093  EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
01fb4d3c39d35b7 drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2094  
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2095  /**
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2096   * dev_pm_opp_set_regulators() - Set regulator names for the device
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2097   * @dev: Device for which regulator name is being set.
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2098   * @names: Array of pointers to the names of the regulator.
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2099   * @count: Number of regulators.
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2100   *
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2101   * In order to support OPP switching, OPP layer needs to know the name of the
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2102   * device's regulators, as the core would be required to switch voltages as
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2103   * well.
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2104   *
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2105   * This must be called before any OPPs are initialized for the device.
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2106   */
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01 @2107  struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2108  					    const char * const names[],
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2109  					    unsigned int count)
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2110  {
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2111  	struct dev_pm_opp_supply *supplies;
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2112  	struct opp_table *opp_table;
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2113  	struct regulator *reg;
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2114  	int ret, i;
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2115  
32439ac7535a8ed drivers/opp/core.c            Viresh Kumar        2021-01-28  2116  	opp_table = _add_opp_table(dev, false);
dd461cd9183fe80 drivers/opp/core.c            Stephan Gerhold     2020-07-27  2117  	if (IS_ERR(opp_table))
dd461cd9183fe80 drivers/opp/core.c            Stephan Gerhold     2020-07-27  2118  		return opp_table;
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2119  
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2120  	/* This should be called before OPPs are initialized */
2c2709dc6921c5d drivers/base/power/opp/core.c Viresh Kumar        2016-02-16  2121  	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2122  		ret = -EBUSY;
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2123  		goto err;
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2124  	}
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2125  
779b783cfaa726c drivers/opp/core.c            Viresh Kumar        2018-05-22  2126  	/* Another CPU that shares the OPP table has set the regulators ? */
779b783cfaa726c drivers/opp/core.c            Viresh Kumar        2018-05-22  2127  	if (opp_table->regulators)
779b783cfaa726c drivers/opp/core.c            Viresh Kumar        2018-05-22  2128  		return opp_table;
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2129  
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2130  	opp_table->regulators = kmalloc_array(count,
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2131  					      sizeof(*opp_table->regulators),
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2132  					      GFP_KERNEL);
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2133  	if (!opp_table->regulators) {
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2134  		ret = -ENOMEM;
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2135  		goto err;
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2136  	}
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2137  
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2138  	for (i = 0; i < count; i++) {
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2139  		reg = regulator_get_optional(dev, names[i]);
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2140  		if (IS_ERR(reg)) {
543256d239b4156 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-08  2141  			ret = dev_err_probe(dev, PTR_ERR(reg),
543256d239b4156 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-08  2142  					    "%s: no regulator (%s) found\n",
543256d239b4156 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-08  2143  					    __func__, names[i]);
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2144  			goto free_regulators;
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2145  		}
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2146  
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2147  		opp_table->regulators[i] = reg;
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2148  	}
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2149  
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2150  	opp_table->regulator_count = count;
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2151  
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2152  	supplies = kmalloc_array(count * 2, sizeof(*supplies), GFP_KERNEL);
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2153  	if (!supplies) {
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2154  		ret = -ENOMEM;
947355850fcb3bb drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2155  		goto free_regulators;
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2156  	}
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2157  
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2158  	mutex_lock(&opp_table->lock);
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2159  	opp_table->sod_supplies = supplies;
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2160  	if (opp_table->set_opp_data) {
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2161  		opp_table->set_opp_data->old_opp.supplies = supplies;
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2162  		opp_table->set_opp_data->new_opp.supplies = supplies + count;
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2163  	}
38bb34393804b79 drivers/opp/core.c            Viresh Kumar        2021-01-19  2164  	mutex_unlock(&opp_table->lock);
947355850fcb3bb drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2165  
91291d9ad92faa6 drivers/base/power/opp/core.c Stephen Boyd        2016-11-30  2166  	return opp_table;
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2167  
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2168  free_regulators:
24957db10043533 drivers/opp/core.c            Marek Szyprowski    2019-10-17  2169  	while (i != 0)
24957db10043533 drivers/opp/core.c            Marek Szyprowski    2019-10-17  2170  		regulator_put(opp_table->regulators[--i]);
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2171  
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2172  	kfree(opp_table->regulators);
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2173  	opp_table->regulators = NULL;
46f48aca2e5aef3 drivers/opp/core.c            Viresh Kumar        2018-12-11  2174  	opp_table->regulator_count = -1;
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2175  err:
fa30184d192ec78 drivers/base/power/opp/core.c Viresh Kumar        2017-01-23  2176  	dev_pm_opp_put_opp_table(opp_table);
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2177  
91291d9ad92faa6 drivers/base/power/opp/core.c Stephen Boyd        2016-11-30  2178  	return ERR_PTR(ret);
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2179  }
dfbe4678d709e25 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2180  EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulators);
9f8ea969d5cfdd4 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2181  

:::::: The code at line 1961 was first introduced by commit
:::::: fa30184d192ec78d443cf6d3abc37d9eb3b9253e PM / OPP: Return opp_table from dev_pm_opp_set_*() routines

:::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
