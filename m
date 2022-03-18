Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462374DE2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbiCRUvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbiCRUvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:51:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED17F8EF2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647636590; x=1679172590;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E811DToh17tZwFWm35DVb8cXnku1vQMTytB2vtQh3AE=;
  b=ihQ3Tbh2Ozq5SyGQMTgkGRkgphAV/9g71FSvbJn6mdRkOxOUq04VHFnc
   KEXt8Z9Bv7IeI6BrriqAsd4itO8XyAj+k9EA/Cb9lrRCQD6aefv4L18E/
   LPQ4cI9eRDgwOWLpWL8FK55ESklVSVZXEgNWowqhHboGiSUmB5c4S1+AQ
   oIpAEJ29s9Fg0F3YTlsi6K7/IOTvuxuXnYppfyw3z0JMqb9gBIPN/N4US
   orP7rh/tCtaJzC4L+UaW5iX3alOLfsVdasrTnXVx481IYbZQPrDBfAMot
   k8De3m56TBv45G9t4juNAoIe70hoXd/xNG31V6dLjksSrh6bhK7QXFB+i
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="343657753"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343657753"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 13:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715645077"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 13:49:48 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVJXg-000F8u-6m; Fri, 18 Mar 2022 20:49:48 +0000
Date:   Sat, 19 Mar 2022 04:49:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 306/307] drivers/scsi/ufs/ufshcd.c:8314:21:
 warning: variable 'name' set but not used
Message-ID: <202203190421.HAgrodHA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   366c4aa8768b5193b782c809d7aba916d4e382da
commit: a8a69970d87f778e000ae1b15e18061c09aa0f7b [306/307] scsi: ufs: Remove unused constants and code
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220319/202203190421.HAgrodHA-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/a8a69970d87f778e000ae1b15e18061c09aa0f7b
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next
        git checkout a8a69970d87f778e000ae1b15e18061c09aa0f7b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/scsi/ufs/ sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/ufs/ufshcd.c: In function 'ufshcd_config_vreg':
>> drivers/scsi/ufs/ufshcd.c:8314:21: warning: variable 'name' set but not used [-Wunused-but-set-variable]
    8314 |         const char *name;
         |                     ^~~~


vim +/name +8314 drivers/scsi/ufs/ufshcd.c

57d104c153d3d6d Subhash Jadavani    2014-09-25  8308  
aa497613093412e Sujit Reddy Thumma  2014-09-25  8309  static int ufshcd_config_vreg(struct device *dev,
aa497613093412e Sujit Reddy Thumma  2014-09-25  8310  		struct ufs_vreg *vreg, bool on)
aa497613093412e Sujit Reddy Thumma  2014-09-25  8311  {
aa497613093412e Sujit Reddy Thumma  2014-09-25  8312  	int ret = 0;
727535903bea924 Gustavo A. R. Silva 2017-11-20  8313  	struct regulator *reg;
727535903bea924 Gustavo A. R. Silva 2017-11-20 @8314  	const char *name;
a8a69970d87f778 Bart Van Assche     2021-12-08  8315  	int uA_load;
aa497613093412e Sujit Reddy Thumma  2014-09-25  8316  
aa497613093412e Sujit Reddy Thumma  2014-09-25  8317  	BUG_ON(!vreg);
aa497613093412e Sujit Reddy Thumma  2014-09-25  8318  
727535903bea924 Gustavo A. R. Silva 2017-11-20  8319  	reg = vreg->reg;
727535903bea924 Gustavo A. R. Silva 2017-11-20  8320  	name = vreg->name;
727535903bea924 Gustavo A. R. Silva 2017-11-20  8321  
aa497613093412e Sujit Reddy Thumma  2014-09-25  8322  	if (regulator_count_voltages(reg) > 0) {
90d88f47e8d03b2 Asutosh Das         2020-02-10  8323  		uA_load = on ? vreg->max_uA : 0;
90d88f47e8d03b2 Asutosh Das         2020-02-10  8324  		ret = ufshcd_config_vreg_load(dev, vreg, uA_load);
3b141e8cfd54ba3 Stanley Chu         2019-03-28  8325  	}
a8a69970d87f778 Bart Van Assche     2021-12-08  8326  
aa497613093412e Sujit Reddy Thumma  2014-09-25  8327  	return ret;
aa497613093412e Sujit Reddy Thumma  2014-09-25  8328  }
aa497613093412e Sujit Reddy Thumma  2014-09-25  8329  

:::::: The code at line 8314 was first introduced by commit
:::::: 727535903bea924c4f73abb202c4b3e85fff0ca4 scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_config_vreg

:::::: TO: Gustavo A. R. Silva <garsilva@embeddedor.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
