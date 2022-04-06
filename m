Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F1A4F565B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243242AbiDFF5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbiDFFsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 01:48:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E443B47C3DC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 22:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649221551; x=1680757551;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eV54akyHGKuAFjoV5dc7eN0JPzBZbl8aFLdXfqqArbw=;
  b=Inbl1S+AZiAFnxnvt/9X/PO7EW2H6P8trN5QsE1wNIcbymvwLOoGrl6h
   IzjM0Kv8R+iGnSvClD6THJ/eUpBKRMaGJ1SutgbAF+GSVjRX8CzHdW19j
   A2G49E2wbE8ZDxkoZySrHTG+4tuU2Iv+XXiuYdVSNrB5OAOxvSqnbdLyy
   vaFESo5LO77SaTTsbc2RCaquby+2Xd+dWntRJ7BNQKzrJJ5eMPUs8/AbL
   D7EKBTJahNrBPYLoHinkSN8Ma7khAFidNu5p3wD8g2V4ICGW5OwdLsZXb
   /fRM5jgpoQSimDRDQ6MsRJqH6Bkot3wEQX24jL/aOhMPYEhDKCLTO2Ct8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="261127740"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="261127740"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 22:05:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="588226626"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 22:05:48 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbxrY-00044t-6S;
        Wed, 06 Apr 2022 05:05:48 +0000
Date:   Wed, 6 Apr 2022 13:04:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-v2 15/15]
 drivers/scsi/ufs/ufshcd-pltfrm.c:383:44: error: passing 'char *[32]' to
 parameter of type 'const char *const *' discards qualifiers in nested
 pointer types
Message-ID: <202204061323.ynOnjrOZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-v2
head:   fff8a3e9335a828deb502bbcf983c4316d27c74e
commit: fff8a3e9335a828deb502bbcf983c4316d27c74e [15/15] pm wip
config: hexagon-randconfig-r045-20220405 (https://download.01.org/0day-ci/archive/20220406/202204061323.ynOnjrOZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/fff8a3e9335a828deb502bbcf983c4316d27c74e
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-v2
        git checkout fff8a3e9335a828deb502bbcf983c4316d27c74e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/scsi/ufs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/scsi/ufs/ufshcd-pltfrm.c:373:23: error: use of undeclared identifier 'clki'
                   list_for_each_entry(clki, head, list) {
                                       ^
   drivers/scsi/ufs/ufshcd-pltfrm.c:373:23: error: use of undeclared identifier 'clki'
   drivers/scsi/ufs/ufshcd-pltfrm.c:373:23: error: use of undeclared identifier 'clki'
   drivers/scsi/ufs/ufshcd-pltfrm.c:373:23: error: use of undeclared identifier 'clki'
   drivers/scsi/ufs/ufshcd-pltfrm.c:373:23: error: use of undeclared identifier 'clki'
   drivers/scsi/ufs/ufshcd-pltfrm.c:373:23: error: use of undeclared identifier 'clki'
   drivers/scsi/ufs/ufshcd-pltfrm.c:373:23: error: use of undeclared identifier 'clki'
   drivers/scsi/ufs/ufshcd-pltfrm.c:373:23: error: use of undeclared identifier 'clki'
   drivers/scsi/ufs/ufshcd-pltfrm.c:373:23: error: use of undeclared identifier 'clki'
   drivers/scsi/ufs/ufshcd-pltfrm.c:374:24: error: use of undeclared identifier 'clki'
                           if (!IS_ERR_OR_NULL(clki->clk)) {
                                               ^
   drivers/scsi/ufs/ufshcd-pltfrm.c:379:18: error: use of undeclared identifier 'clki'
                                   names[i++] = clki->name;
                                                ^
>> drivers/scsi/ufs/ufshcd-pltfrm.c:383:44: error: passing 'char *[32]' to parameter of type 'const char *const *' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                   opp_table = dev_pm_opp_set_clknames(dev, names, i);
                                                            ^~~~~
   include/linux/pm_opp.h:178:27: note: passing argument to parameter 'names' here
                                             const char * const names[],
                                                                ^
   drivers/scsi/ufs/ufshcd-pltfrm.c:385:4: error: use of undeclared identifier 'ret'
                           ret = PTR_ERR(opp_table);
                           ^
   13 errors generated.


vim +383 drivers/scsi/ufs/ufshcd-pltfrm.c

65858014ee20c84 Stanley Chu         2020-11-16  314  
03b1781aa978aab Vinayak Holikatti   2013-02-26  315  /**
47555a5c8a11a42 Yaniv Gardi         2015-10-28  316   * ufshcd_pltfrm_init - probe routine of the driver
03b1781aa978aab Vinayak Holikatti   2013-02-26  317   * @pdev: pointer to Platform device handle
47555a5c8a11a42 Yaniv Gardi         2015-10-28  318   * @vops: pointer to variant ops
03b1781aa978aab Vinayak Holikatti   2013-02-26  319   *
03b1781aa978aab Vinayak Holikatti   2013-02-26  320   * Returns 0 on success, non-zero value on failure
03b1781aa978aab Vinayak Holikatti   2013-02-26  321   */
47555a5c8a11a42 Yaniv Gardi         2015-10-28  322  int ufshcd_pltfrm_init(struct platform_device *pdev,
176eb927744201b Arnd Bergmann       2019-03-04  323  		       const struct ufs_hba_variant_ops *vops)
03b1781aa978aab Vinayak Holikatti   2013-02-26  324  {
03b1781aa978aab Vinayak Holikatti   2013-02-26  325  	struct ufs_hba *hba;
03b1781aa978aab Vinayak Holikatti   2013-02-26  326  	void __iomem *mmio_base;
2953f850c3b80bd Seungwon Jeon       2013-06-27  327  	int irq, err;
03b1781aa978aab Vinayak Holikatti   2013-02-26  328  	struct device *dev = &pdev->dev;
03b1781aa978aab Vinayak Holikatti   2013-02-26  329  
0b27555166241cb YueHaibing          2019-09-04  330  	mmio_base = devm_platform_ioremap_resource(pdev, 0);
645b8ef5943f95b Tomas Winkler       2017-03-14  331  	if (IS_ERR(mmio_base)) {
645b8ef5943f95b Tomas Winkler       2017-03-14  332  		err = PTR_ERR(mmio_base);
2953f850c3b80bd Seungwon Jeon       2013-06-27  333  		goto out;
03b1781aa978aab Vinayak Holikatti   2013-02-26  334  	}
03b1781aa978aab Vinayak Holikatti   2013-02-26  335  
2953f850c3b80bd Seungwon Jeon       2013-06-27  336  	irq = platform_get_irq(pdev, 0);
2953f850c3b80bd Seungwon Jeon       2013-06-27  337  	if (irq < 0) {
339c9b63cc7ce77 Sergey Shtylyov     2021-03-29  338  		err = irq;
2953f850c3b80bd Seungwon Jeon       2013-06-27  339  		goto out;
03b1781aa978aab Vinayak Holikatti   2013-02-26  340  	}
03b1781aa978aab Vinayak Holikatti   2013-02-26  341  
5c0c28a84af9f9b Sujit Reddy Thumma  2014-09-25  342  	err = ufshcd_alloc_host(dev, &hba);
5c0c28a84af9f9b Sujit Reddy Thumma  2014-09-25  343  	if (err) {
f0cbb6efa2cf4b2 Krzysztof Kozlowski 2022-03-31  344  		dev_err(dev, "Allocation failed\n");
5c0c28a84af9f9b Sujit Reddy Thumma  2014-09-25  345  		goto out;
5c0c28a84af9f9b Sujit Reddy Thumma  2014-09-25  346  	}
5c0c28a84af9f9b Sujit Reddy Thumma  2014-09-25  347  
47555a5c8a11a42 Yaniv Gardi         2015-10-28  348  	hba->vops = vops;
5c0c28a84af9f9b Sujit Reddy Thumma  2014-09-25  349  
c6e79dacd86fd7d Sujit Reddy Thumma  2014-09-25  350  	err = ufshcd_parse_clock_info(hba);
c6e79dacd86fd7d Sujit Reddy Thumma  2014-09-25  351  	if (err) {
f0cbb6efa2cf4b2 Krzysztof Kozlowski 2022-03-31  352  		dev_err(dev, "%s: clock parse failed %d\n",
c6e79dacd86fd7d Sujit Reddy Thumma  2014-09-25  353  				__func__, err);
47555a5c8a11a42 Yaniv Gardi         2015-10-28  354  		goto dealloc_host;
c6e79dacd86fd7d Sujit Reddy Thumma  2014-09-25  355  	}
aa497613093412e Sujit Reddy Thumma  2014-09-25  356  	err = ufshcd_parse_regulator_info(hba);
aa497613093412e Sujit Reddy Thumma  2014-09-25  357  	if (err) {
f0cbb6efa2cf4b2 Krzysztof Kozlowski 2022-03-31  358  		dev_err(dev, "%s: regulator init failed %d\n",
aa497613093412e Sujit Reddy Thumma  2014-09-25  359  				__func__, err);
47555a5c8a11a42 Yaniv Gardi         2015-10-28  360  		goto dealloc_host;
aa497613093412e Sujit Reddy Thumma  2014-09-25  361  	}
aa497613093412e Sujit Reddy Thumma  2014-09-25  362  
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  363  	if (devm_pm_opp_of_add_table(dev)) {
c56c108a9c3ae79 Krzysztof Kozlowski 2022-04-01  364  		dev_dbg(dev, "no OPP table (%d), no performance state control\n",
c56c108a9c3ae79 Krzysztof Kozlowski 2022-04-01  365  			err);
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  366  	} else {
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  367  		struct list_head *head = &hba->clk_list_head;
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  368  		char *names[32];
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  369  		unsigned int i = 0;
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  370  		struct opp_table *opp_table;
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  371  
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  372  		pr_err("AAA USING OPP\n");
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  373  		list_for_each_entry(clki, head, list) {
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  374  			if (!IS_ERR_OR_NULL(clki->clk)) {
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  375  				if (i == ARRAY_SIZE(names)) {
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  376  					pr_err("AAA BBBB too many\n");
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  377  					goto dealloc_host;
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  378  				}
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  379  				names[i++] = clki->name;
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  380  			}
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  381  		}
c56c108a9c3ae79 Krzysztof Kozlowski 2022-04-01  382  		hba->use_pm_opp = true;
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05 @383  		opp_table = dev_pm_opp_set_clknames(dev, names, i);
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  384  		if (IS_ERR(opp_table)) {
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  385  			ret = PTR_ERR(opp_table);
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  386  			goto dealloc_host;
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  387  		}
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  388  		// FIXME: put table
ae883f49d1137ae Krzysztof Kozlowski 2022-04-05  389  	}
c56c108a9c3ae79 Krzysztof Kozlowski 2022-04-01  390  
54b879b76ea2531 Yaniv Gardi         2016-03-10  391  	ufshcd_init_lanes_per_dir(hba);
54b879b76ea2531 Yaniv Gardi         2016-03-10  392  
5c0c28a84af9f9b Sujit Reddy Thumma  2014-09-25  393  	err = ufshcd_init(hba, mmio_base, irq);
03b1781aa978aab Vinayak Holikatti   2013-02-26  394  	if (err) {
bad9764cfaaa15b Colin Ian King      2015-11-28  395  		dev_err(dev, "Initialization failed\n");
24e2e7a19f7e4b8 Stanley Chu         2019-06-12  396  		goto dealloc_host;
03b1781aa978aab Vinayak Holikatti   2013-02-26  397  	}
03b1781aa978aab Vinayak Holikatti   2013-02-26  398  
f0cbb6efa2cf4b2 Krzysztof Kozlowski 2022-03-31  399  	pm_runtime_set_active(dev);
f0cbb6efa2cf4b2 Krzysztof Kozlowski 2022-03-31  400  	pm_runtime_enable(dev);
24e2e7a19f7e4b8 Stanley Chu         2019-06-12  401  
62694735ca95c74 Sujit Reddy Thumma  2013-07-30  402  	return 0;
62694735ca95c74 Sujit Reddy Thumma  2013-07-30  403  
47555a5c8a11a42 Yaniv Gardi         2015-10-28  404  dealloc_host:
47555a5c8a11a42 Yaniv Gardi         2015-10-28  405  	ufshcd_dealloc_host(hba);
2953f850c3b80bd Seungwon Jeon       2013-06-27  406  out:
03b1781aa978aab Vinayak Holikatti   2013-02-26  407  	return err;
03b1781aa978aab Vinayak Holikatti   2013-02-26  408  }
47555a5c8a11a42 Yaniv Gardi         2015-10-28  409  EXPORT_SYMBOL_GPL(ufshcd_pltfrm_init);
03b1781aa978aab Vinayak Holikatti   2013-02-26  410  

:::::: The code at line 383 was first introduced by commit
:::::: ae883f49d1137ae5f4997c5287dbf35f9bdd0272 ufs wip

:::::: TO: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
:::::: CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
