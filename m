Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576365708A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiGKRHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKRHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:07:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A41A2AC5C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657559257; x=1689095257;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=32o8jpubEsCdGxFCMs0q5aPKG/YgP9ivdQ0EzzAFqmc=;
  b=lRicx8JpE2Ukymk7X69hILKgFLVITfjM2RgNRyoorT/ATO2dhsuOcWc3
   eCTZqKZO18IkyJKDObeXajhuwSDMCU1++3NbGS2jP9/iRT5/UY7MZcGIh
   EC+ZYrqRklOw542rqDl+08IAsm6w38gOt+po+nNmloFslyqS1FZ+7AMpH
   AYNoNwSpIPLQQDGHPxbF98485GmViPB4kjKM0SeI3g42UCsYNHIFJwYXp
   EobOKu+cdUS1u6DOpZ7gYb2KC9KRJnYii79NX3GVlm9dIAsHvoiyX4xqg
   84vBJ2rad8YGmzy9Qm4ft+Q5d/AzG1uWIlW+utvzCV1zP+Ek6QgwCk3VQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="267757668"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="267757668"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 10:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="622157900"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2022 10:07:35 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAwsg-0000z7-G7;
        Mon, 11 Jul 2022 17:07:34 +0000
Date:   Tue, 12 Jul 2022 01:07:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_29 10/32]
 samples/ftrace/ftrace-direct-set.c:101:9: error: implicit declaration of
 function 'ftrace_test_0'; did you mean 'ftrace_stub'?
Message-ID: <202207120003.bGKOxSi0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_29
head:   ec522c20e55e48f561146afbb81513e20870ee12
commit: c85abdd3bce521c008055a9741254fc7e6d90017 [10/32] ftrace/samples: Add a sample module that implements set_ftrace_direct
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220712/202207120003.bGKOxSi0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=c85abdd3bce521c008055a9741254fc7e6d90017
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_29
        git checkout c85abdd3bce521c008055a9741254fc7e6d90017
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash samples/ftrace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   samples/ftrace/ftrace-direct-set.c: In function 'runall':
>> samples/ftrace/ftrace-direct-set.c:101:9: error: implicit declaration of function 'ftrace_test_0'; did you mean 'ftrace_stub'? [-Werror=implicit-function-declaration]
     101 |         ftrace_test_0();
         |         ^~~~~~~~~~~~~
         |         ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:102:9: error: implicit declaration of function 'ftrace_test_1'; did you mean 'ftrace_stub'? [-Werror=implicit-function-declaration]
     102 |         ftrace_test_1();
         |         ^~~~~~~~~~~~~
         |         ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:103:9: error: implicit declaration of function 'ftrace_test_2'; did you mean 'ftrace_stub'? [-Werror=implicit-function-declaration]
     103 |         ftrace_test_2();
         |         ^~~~~~~~~~~~~
         |         ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:104:9: error: implicit declaration of function 'ftrace_test_3'; did you mean 'ftrace_stub'? [-Werror=implicit-function-declaration]
     104 |         ftrace_test_3();
         |         ^~~~~~~~~~~~~
         |         ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:105:9: error: implicit declaration of function 'ftrace_test_4'; did you mean 'ftrace_stub'? [-Werror=implicit-function-declaration]
     105 |         ftrace_test_4();
         |         ^~~~~~~~~~~~~
         |         ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:106:9: error: implicit declaration of function 'ftrace_test_5'; did you mean 'ftrace_stub'? [-Werror=implicit-function-declaration]
     106 |         ftrace_test_5();
         |         ^~~~~~~~~~~~~
         |         ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:107:9: error: implicit declaration of function 'ftrace_test_6'; did you mean 'ftrace_stub'? [-Werror=implicit-function-declaration]
     107 |         ftrace_test_6();
         |         ^~~~~~~~~~~~~
         |         ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:108:9: error: implicit declaration of function 'ftrace_test_7'; did you mean 'ftrace_stub'? [-Werror=implicit-function-declaration]
     108 |         ftrace_test_7();
         |         ^~~~~~~~~~~~~
         |         ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:109:9: error: implicit declaration of function 'ftrace_test_8'; did you mean 'ftrace_stub'? [-Werror=implicit-function-declaration]
     109 |         ftrace_test_8();
         |         ^~~~~~~~~~~~~
         |         ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:110:9: error: implicit declaration of function 'ftrace_test_9'; did you mean 'ftrace_stub'? [-Werror=implicit-function-declaration]
     110 |         ftrace_test_9();
         |         ^~~~~~~~~~~~~
         |         ftrace_stub
   samples/ftrace/ftrace-direct-set.c: In function 'ftrace_direct_set_init':
>> samples/ftrace/ftrace-direct-set.c:134:18: error: 'ftrace_test_0' undeclared (first use in this function); did you mean 'ftrace_stub'?
     134 |         hash_set(ftrace_test_0, tramp_0);
         |                  ^~~~~~~~~~~~~
         |                  ftrace_stub
   samples/ftrace/ftrace-direct-set.c:134:18: note: each undeclared identifier is reported only once for each function it appears in
>> samples/ftrace/ftrace-direct-set.c:135:18: error: 'ftrace_test_1' undeclared (first use in this function); did you mean 'ftrace_stub'?
     135 |         hash_set(ftrace_test_1, tramp_1);
         |                  ^~~~~~~~~~~~~
         |                  ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:156:18: error: 'ftrace_test_2' undeclared (first use in this function); did you mean 'ftrace_stub'?
     156 |         hash_set(ftrace_test_2, tramp_0);
         |                  ^~~~~~~~~~~~~
         |                  ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:157:18: error: 'ftrace_test_3' undeclared (first use in this function); did you mean 'ftrace_stub'?
     157 |         hash_set(ftrace_test_3, tramp_0);
         |                  ^~~~~~~~~~~~~
         |                  ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:158:18: error: 'ftrace_test_4' undeclared (first use in this function); did you mean 'ftrace_stub'?
     158 |         hash_set(ftrace_test_4, tramp_4);
         |                  ^~~~~~~~~~~~~
         |                  ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:159:18: error: 'ftrace_test_5' undeclared (first use in this function); did you mean 'ftrace_stub'?
     159 |         hash_set(ftrace_test_5, tramp_5);
         |                  ^~~~~~~~~~~~~
         |                  ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:160:18: error: 'ftrace_test_6' undeclared (first use in this function); did you mean 'ftrace_stub'?
     160 |         hash_set(ftrace_test_6, tramp_6);
         |                  ^~~~~~~~~~~~~
         |                  ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:161:18: error: 'ftrace_test_7' undeclared (first use in this function); did you mean 'ftrace_stub'?
     161 |         hash_set(ftrace_test_7, tramp_7);
         |                  ^~~~~~~~~~~~~
         |                  ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:162:18: error: 'ftrace_test_8' undeclared (first use in this function); did you mean 'ftrace_stub'?
     162 |         hash_set(ftrace_test_8, tramp_8);
         |                  ^~~~~~~~~~~~~
         |                  ftrace_stub
>> samples/ftrace/ftrace-direct-set.c:163:18: error: 'ftrace_test_9' undeclared (first use in this function); did you mean 'ftrace_stub'?
     163 |         hash_set(ftrace_test_9, tramp_9);
         |                  ^~~~~~~~~~~~~
         |                  ftrace_stub
   cc1: some warnings being treated as errors


vim +101 samples/ftrace/ftrace-direct-set.c

    87	
    88	static void runall(const char *str)
    89	{
    90		tramp_0_cnt = 0;
    91		tramp_1_cnt = 0;
    92		tramp_2_cnt = 0;
    93		tramp_3_cnt = 0;
    94		tramp_4_cnt = 0;
    95		tramp_5_cnt = 0;
    96		tramp_6_cnt = 0;
    97		tramp_7_cnt = 0;
    98		tramp_8_cnt = 0;
    99		tramp_9_cnt = 0;
   100	
 > 101		ftrace_test_0();
 > 102		ftrace_test_1();
 > 103		ftrace_test_2();
 > 104		ftrace_test_3();
 > 105		ftrace_test_4();
 > 106		ftrace_test_5();
 > 107		ftrace_test_6();
 > 108		ftrace_test_7();
 > 109		ftrace_test_8();
 > 110		ftrace_test_9();
   111	
   112		printk("%40s - %d%d%d%d%d%d%d%d%d%d\n",
   113			str,
   114			tramp_0_cnt,
   115			tramp_1_cnt,
   116			tramp_2_cnt,
   117			tramp_3_cnt,
   118			tramp_4_cnt,
   119			tramp_5_cnt,
   120			tramp_6_cnt,
   121			tramp_7_cnt,
   122			tramp_8_cnt,
   123			tramp_9_cnt);
   124	}
   125	
   126	static int __init ftrace_direct_set_init(void)
   127	{
   128		int err;
   129	
   130		hash = ftrace_hash_alloc(FTRACE_HASH_DEFAULT_BITS);
   131		if (!hash)
   132			return -ENOMEM;
   133	
 > 134		hash_set(ftrace_test_0, tramp_0);
 > 135		hash_set(ftrace_test_1, tramp_1);
   136		hash_printk();
   137	
   138		err = set_ftrace_direct(hash);
   139		if (err)
   140			goto out_free;
   141	
   142		runall("tramp_0|1");
   143	
   144		hash_set(ftrace_test_0, tramp_2);
   145		hash_set(ftrace_test_1, tramp_3);
   146		hash_printk();
   147	
   148		err = set_ftrace_direct(hash);
   149		if (err)
   150			goto out_free;
   151	
   152		runall("tramp_2|3");
   153	
   154		hash_set(ftrace_test_0, tramp_0);
   155		hash_set(ftrace_test_1, tramp_0);
 > 156		hash_set(ftrace_test_2, tramp_0);
 > 157		hash_set(ftrace_test_3, tramp_0);
 > 158		hash_set(ftrace_test_4, tramp_4);
 > 159		hash_set(ftrace_test_5, tramp_5);
 > 160		hash_set(ftrace_test_6, tramp_6);
 > 161		hash_set(ftrace_test_7, tramp_7);
 > 162		hash_set(ftrace_test_8, tramp_8);
 > 163		hash_set(ftrace_test_9, tramp_9);
   164		hash_printk();
   165	
   166		err = set_ftrace_direct(hash);
   167		if (err)
   168			goto out_free;
   169	
   170		runall("tramp_0(4)|4|5|6|7|8|9");
   171	
   172		hash_set(ftrace_test_0, tramp_1);
   173		hash_set(ftrace_test_1, tramp_1);
   174		hash_set(ftrace_test_2, tramp_1);
   175		hash_set(ftrace_test_3, tramp_2);
   176		hash_set(ftrace_test_4, tramp_2);
   177		hash_set(ftrace_test_5, tramp_2);
   178		hash_set(ftrace_test_6, tramp_3);
   179		hash_set(ftrace_test_7, tramp_3);
   180		hash_set(ftrace_test_8, tramp_3);
   181		hash_set(ftrace_test_9, tramp_4);
   182		hash_printk();
   183	
   184		err = set_ftrace_direct(hash);
   185		if (err)
   186			goto out_free;
   187	
   188		runall("tramp_1(3)|2(3)|3(3)|4");
   189		return 0;
   190	
   191	out_free:
   192		ftrace_hash_free(hash);
   193		return -ENOMEM;
   194	}
   195	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
