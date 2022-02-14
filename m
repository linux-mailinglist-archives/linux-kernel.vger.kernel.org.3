Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073BF4B47F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244855AbiBNJrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:47:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245324AbiBNJpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:45:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C417706F4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644831534; x=1676367534;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AES3eIOCUpZrYw0dvwAB6fUslqFi0xAv4XVqJP1sJCI=;
  b=AZJx7q0J4lQu/FWymox73kc0Zlh68z4gD4KFo7pvMX9aXb7YPb3a2tpN
   AGmBR34YkNmhxecgvNKRJjehhIfv1kp1Py5w0mmv/e+ABji69TCLiIN4i
   ZGrUwipYfRk4btMAS3+PzZ+RzCWVpPydZOMW/JPgoPVvsckg14D8dzpk1
   qGcF+L69XqSGVmI54qYEqpzms9lCilGXb5iA87rE0NYtX8gElPDXzgjdR
   oEEjKV1mN143Mui8QwPxl8i90x4HP2bXw1cNs2oWuWHb5bHo3gYvkptx+
   ag08iwOJ6F8abMu5+xDtzAOXmccPKNsmutGZXNbBdlVcv+5RuNfU1aRvO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="230017092"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="230017092"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:38:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="501666545"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Feb 2022 01:38:51 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJXoo-0008M9-F5; Mon, 14 Feb 2022 09:38:50 +0000
Date:   Mon, 14 Feb 2022 17:38:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 60/64]
 drivers/soc/sifive/sifive_l2_cache.c:158:17: error: implicit declaration of
 function 'writeq'; did you mean 'writel'?
Message-ID: <202202141742.K9YE1JCn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

First bad commit (maybe != root cause):

tree:   https://github.com/esmil/linux visionfive
head:   a29d7d9e1f688baf4c70b3a1d2244193e3323e0d
commit: d9a4a3d985ace9a7d6edd6f60ed765443f0c8ae5 [60/64] RISC-V: Enable SIFIVE_L2_FLUSH for StarFive SoCs
config: riscv-randconfig-r031-20220213 (https://download.01.org/0day-ci/archive/20220214/202202141742.K9YE1JCn-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/d9a4a3d985ace9a7d6edd6f60ed765443f0c8ae5
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout d9a4a3d985ace9a7d6edd6f60ed765443f0c8ae5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/soc/sifive/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/sifive/sifive_l2_cache.c: In function 'sifive_l2_flush64_range':
>> drivers/soc/sifive/sifive_l2_cache.c:158:17: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
     158 |                 writeq(line, l2_base + SIFIVE_L2_FLUSH64);
         |                 ^~~~~~
         |                 writel
   cc1: some warnings being treated as errors


vim +158 drivers/soc/sifive/sifive_l2_cache.c

a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah          2019-05-06  126  
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  127  #ifdef CONFIG_SIFIVE_L2_FLUSH
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  128  void sifive_l2_flush64_range(unsigned long start, unsigned long len)
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  129  {
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  130  	unsigned long line;
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  131  
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  132  	if(!l2_base) {
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  133  		pr_warn("L2CACHE: base addr invalid, skipping flush\n");
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  134  		return;
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  135  	}
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  136  
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  137  	/* TODO: if (len == 0), skipping flush or going on? */
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  138  	if(!len) {
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  139  		pr_debug("L2CACHE: flush64 range @ 0x%lx(len:0)\n", start);
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  140  		return;
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  141  	}
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  142  
53c88578fe7510 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  143  	len = len + (start % SIFIVE_L2_FLUSH64_LINE_LEN);
53c88578fe7510 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  144  	start = ALIGN_DOWN(start, SIFIVE_L2_FLUSH64_LINE_LEN);
53c88578fe7510 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  145  
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  146  	/* make sure the address is in the range */
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  147  	if(start < CONFIG_SIFIVE_L2_FLUSH_START ||
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  148  	   (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  149  			     CONFIG_SIFIVE_L2_FLUSH_SIZE)) {
402885eef783d5 drivers/soc/sifive/sifive_l2_cache.c Geert Uytterhoeven 2021-05-21  150  		WARN(1, "L2CACHE: flush64 out of range: %lx(%lx), skip flush\n",
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  151  		     start, len);
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  152  		return;
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  153  	}
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  154  
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  155  	mb();	/* sync */
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  156  	for (line = start; line < start + len;
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  157  	     line += SIFIVE_L2_FLUSH64_LINE_LEN) {
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08 @158  		writeq(line, l2_base + SIFIVE_L2_FLUSH64);
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  159  		mb();
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  160  	}
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  161  }
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  162  EXPORT_SYMBOL_GPL(sifive_l2_flush64_range);
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  163  #endif
9ca187fca0e9da drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  164  

:::::: The code at line 158 was first introduced by commit
:::::: 9ca187fca0e9da3c005a260c74f75494eef2aa5f sifive/sifive_l2_cache: Add sifive_l2_flush64_range function

:::::: TO: Tom <support@vamrs.com>
:::::: CC: Emil Renner Berthing <kernel@esmil.dk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
