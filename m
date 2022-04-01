Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F854EEB0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244874AbiDAKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243938AbiDAKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:13:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547BB26E012
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648807909; x=1680343909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1B2kYDU3Img6Pt/wdwoOR4IguuFtckbX5iLYO4yHPrI=;
  b=ApJ5YJu8nxYVKADIHf8p7APL9IBgMVOecnfm30JD4EL4/KpLaNuR7xKV
   z5Q4Gh5bY4LWgEeLSm2Zjt//N+KCizZiPJnHGuuIU39MxSSXmLjxxLEap
   zuGOsYfX8DyzsMLYZrBuo9ytCnaJrBXSH3PunnJFkudmsTtpyRw6YbBLj
   m6fsV7D/mxJb18j0n5Em/Jov5uTkwMRtkYUjfJeqGurjNOb0CGgKvUNCe
   ISa6S5Dtrh0u/Yd5HyhgrcP2n9enqP298v5wdCr4oz3nXiGmfHsLI4ItS
   0SyeFa+6v/fSKPvdTG5hcEGzw74o+swW36eGJy6zv9cSluivY/KCEdO3t
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="259800452"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="259800452"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 03:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="586798234"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2022 03:11:47 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naEFu-00018u-HH;
        Fri, 01 Apr 2022 10:11:46 +0000
Date:   Fri, 1 Apr 2022 18:11:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: arch/nios2/kernel/misaligned.c:111:42: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202204011821.XHt4bDMK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8b767f5e04097aaedcd6e06e2270f9fe5282696
commit: 90997c128049c75a74bd9ebb852b17e359066541 nios2: drop access_ok() check from __put_user()
date:   5 weeks ago
config: nios2-randconfig-s032-20220330 (https://download.01.org/0day-ci/archive/20220401/202204011821.XHt4bDMK-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=90997c128049c75a74bd9ebb852b17e359066541
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 90997c128049c75a74bd9ebb852b17e359066541
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/nios2/kernel/misaligned.c:98:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__gu_ptr @@     got unsigned char [usertype] * @@
   arch/nios2/kernel/misaligned.c:98:34: sparse:     expected unsigned char const [noderef] __user *__gu_ptr
   arch/nios2/kernel/misaligned.c:98:34: sparse:     got unsigned char [usertype] *
   arch/nios2/kernel/misaligned.c:99:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__gu_ptr @@     got unsigned char [usertype] * @@
   arch/nios2/kernel/misaligned.c:99:34: sparse:     expected unsigned char const [noderef] __user *__gu_ptr
   arch/nios2/kernel/misaligned.c:99:34: sparse:     got unsigned char [usertype] *
>> arch/nios2/kernel/misaligned.c:111:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned char [usertype] *__pu_ptr @@
   arch/nios2/kernel/misaligned.c:111:42: sparse:     expected void [noderef] __user *to
   arch/nios2/kernel/misaligned.c:111:42: sparse:     got unsigned char [usertype] *__pu_ptr
   arch/nios2/kernel/misaligned.c:112:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned char [usertype] *__pu_ptr @@
   arch/nios2/kernel/misaligned.c:112:42: sparse:     expected void [noderef] __user *to
   arch/nios2/kernel/misaligned.c:112:42: sparse:     got unsigned char [usertype] *__pu_ptr
   arch/nios2/kernel/misaligned.c:116:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__gu_ptr @@     got unsigned char [usertype] * @@
   arch/nios2/kernel/misaligned.c:116:34: sparse:     expected unsigned char const [noderef] __user *__gu_ptr
   arch/nios2/kernel/misaligned.c:116:34: sparse:     got unsigned char [usertype] *
   arch/nios2/kernel/misaligned.c:117:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__gu_ptr @@     got unsigned char [usertype] * @@
   arch/nios2/kernel/misaligned.c:117:34: sparse:     expected unsigned char const [noderef] __user *__gu_ptr
   arch/nios2/kernel/misaligned.c:117:34: sparse:     got unsigned char [usertype] *
   arch/nios2/kernel/misaligned.c:133:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned char [usertype] *__pu_ptr @@
   arch/nios2/kernel/misaligned.c:133:42: sparse:     expected void [noderef] __user *to
   arch/nios2/kernel/misaligned.c:133:42: sparse:     got unsigned char [usertype] *__pu_ptr
   arch/nios2/kernel/misaligned.c:134:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned char [usertype] *__pu_ptr @@
   arch/nios2/kernel/misaligned.c:134:42: sparse:     expected void [noderef] __user *to
   arch/nios2/kernel/misaligned.c:134:42: sparse:     got unsigned char [usertype] *__pu_ptr
   arch/nios2/kernel/misaligned.c:135:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned char [usertype] *__pu_ptr @@
   arch/nios2/kernel/misaligned.c:135:42: sparse:     expected void [noderef] __user *to
   arch/nios2/kernel/misaligned.c:135:42: sparse:     got unsigned char [usertype] *__pu_ptr
   arch/nios2/kernel/misaligned.c:136:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned char [usertype] *__pu_ptr @@
   arch/nios2/kernel/misaligned.c:136:42: sparse:     expected void [noderef] __user *to
   arch/nios2/kernel/misaligned.c:136:42: sparse:     got unsigned char [usertype] *__pu_ptr
   arch/nios2/kernel/misaligned.c:140:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__gu_ptr @@     got unsigned char [usertype] * @@
   arch/nios2/kernel/misaligned.c:140:34: sparse:     expected unsigned char const [noderef] __user *__gu_ptr
   arch/nios2/kernel/misaligned.c:140:34: sparse:     got unsigned char [usertype] *
   arch/nios2/kernel/misaligned.c:141:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__gu_ptr @@     got unsigned char [usertype] * @@
   arch/nios2/kernel/misaligned.c:141:34: sparse:     expected unsigned char const [noderef] __user *__gu_ptr
   arch/nios2/kernel/misaligned.c:141:34: sparse:     got unsigned char [usertype] *
   arch/nios2/kernel/misaligned.c:142:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__gu_ptr @@     got unsigned char [usertype] * @@
   arch/nios2/kernel/misaligned.c:142:34: sparse:     expected unsigned char const [noderef] __user *__gu_ptr
   arch/nios2/kernel/misaligned.c:142:34: sparse:     got unsigned char [usertype] *
   arch/nios2/kernel/misaligned.c:143:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__gu_ptr @@     got unsigned char [usertype] * @@
   arch/nios2/kernel/misaligned.c:143:34: sparse:     expected unsigned char const [noderef] __user *__gu_ptr
   arch/nios2/kernel/misaligned.c:143:34: sparse:     got unsigned char [usertype] *

vim +111 arch/nios2/kernel/misaligned.c

82ed08dd1b0e0e Ley Foon Tan  2014-11-06   62  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   63  /*
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   64   * (mis)alignment handler
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   65   */
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   66  asmlinkage void handle_unaligned_c(struct pt_regs *fp, int cause)
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   67  {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   68  	u32 isn, addr, val;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   69  	int in_kernel;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   70  	u8 a, b, d0, d1, d2, d3;
db5a7e55468147 Bernd Weiberg 2015-09-04   71  	s16 imm16;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   72  	unsigned int fault;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   73  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   74  	/* back up one instruction */
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   75  	fp->ea -= 4;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   76  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   77  	if (fixup_exception(fp)) {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   78  		return;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   79  	}
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   80  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   81  	in_kernel = !user_mode(fp);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   82  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   83  	isn = *(unsigned long *)(fp->ea);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   84  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   85  	fault = 0;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   86  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   87  	/* do fixup if in kernel or mode turned on */
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   88  	if (in_kernel || (ma_usermode & UM_FIXUP)) {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   89  		/* decompose instruction */
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   90  		a = (isn >> 27) & 0x1f;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   91  		b = (isn >> 22) & 0x1f;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   92  		imm16 = (isn >> 6) & 0xffff;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   93  		addr = get_reg_val(fp, a) + imm16;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   94  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   95  		/* do fixup to saved registers */
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   96  		switch (isn & 0x3f) {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   97  		case INST_LDHU:
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   98  			fault |= __get_user(d0, (u8 *)(addr+0));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06   99  			fault |= __get_user(d1, (u8 *)(addr+1));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  100  			val = (d1 << 8) | d0;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  101  			put_reg_val(fp, b, val);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  102  			break;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  103  		case INST_STH:
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  104  			val = get_reg_val(fp, b);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  105  			d1 = val >> 8;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  106  			d0 = val >> 0;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  107  			if (in_kernel) {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  108  				*(u8 *)(addr+0) = d0;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  109  				*(u8 *)(addr+1) = d1;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  110  			} else {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06 @111  				fault |= __put_user(d0, (u8 *)(addr+0));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  112  				fault |= __put_user(d1, (u8 *)(addr+1));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  113  			}
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  114  			break;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  115  		case INST_LDH:
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  116  			fault |= __get_user(d0, (u8 *)(addr+0));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  117  			fault |= __get_user(d1, (u8 *)(addr+1));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  118  			val = (short)((d1 << 8) | d0);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  119  			put_reg_val(fp, b, val);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  120  			break;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  121  		case INST_STW:
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  122  			val = get_reg_val(fp, b);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  123  			d3 = val >> 24;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  124  			d2 = val >> 16;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  125  			d1 = val >> 8;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  126  			d0 = val >> 0;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  127  			if (in_kernel) {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  128  				*(u8 *)(addr+0) = d0;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  129  				*(u8 *)(addr+1) = d1;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  130  				*(u8 *)(addr+2) = d2;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  131  				*(u8 *)(addr+3) = d3;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  132  			} else {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  133  				fault |= __put_user(d0, (u8 *)(addr+0));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  134  				fault |= __put_user(d1, (u8 *)(addr+1));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  135  				fault |= __put_user(d2, (u8 *)(addr+2));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  136  				fault |= __put_user(d3, (u8 *)(addr+3));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  137  			}
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  138  			break;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  139  		case INST_LDW:
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  140  			fault |= __get_user(d0, (u8 *)(addr+0));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  141  			fault |= __get_user(d1, (u8 *)(addr+1));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  142  			fault |= __get_user(d2, (u8 *)(addr+2));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  143  			fault |= __get_user(d3, (u8 *)(addr+3));
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  144  			val = (d3 << 24) | (d2 << 16) | (d1 << 8) | d0;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  145  			put_reg_val(fp, b, val);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  146  			break;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  147  		}
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  148  	}
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  149  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  150  	addr = RDCTL(CTL_BADADDR);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  151  	cause >>= 2;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  152  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  153  	if (fault) {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  154  		if (in_kernel) {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  155  			pr_err("fault during kernel misaligned fixup @ %#lx; addr 0x%08x; isn=0x%08x\n",
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  156  				fp->ea, (unsigned int)addr,
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  157  				(unsigned int)isn);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  158  		} else {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  159  			pr_err("fault during user misaligned fixup @ %#lx; isn=%08x addr=0x%08x sp=0x%08lx pid=%d\n",
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  160  				fp->ea,
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  161  				(unsigned int)isn, addr, fp->sp,
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  162  				current->pid);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  163  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  164  			_exception(SIGSEGV, fp, SEGV_MAPERR, fp->ea);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  165  			return;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  166  		}
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  167  	}
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  168  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  169  	/*
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  170  	 * kernel mode -
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  171  	 *  note exception and skip bad instruction (return)
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  172  	 */
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  173  	if (in_kernel) {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  174  		fp->ea += 4;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  175  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  176  		if (ma_usermode & KM_WARN) {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  177  			pr_err("kernel unaligned access @ %#lx; BADADDR 0x%08x; cause=%d, isn=0x%08x\n",
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  178  				fp->ea,
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  179  				(unsigned int)addr, cause,
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  180  				(unsigned int)isn);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  181  			/* show_regs(fp); */
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  182  		}
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  183  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  184  		return;
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  185  	}
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  186  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  187  	/*
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  188  	 * user mode -
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  189  	 *  possibly warn,
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  190  	 *  possibly send SIGBUS signal to process
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  191  	 */
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  192  	if (ma_usermode & UM_WARN) {
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  193  		pr_err("user unaligned access @ %#lx; isn=0x%08lx ea=0x%08lx ra=0x%08lx sp=0x%08lx\n",
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  194  			(unsigned long)addr, (unsigned long)isn,
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  195  			fp->ea, fp->ra, fp->sp);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  196  	}
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  197  
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  198  	if (ma_usermode & UM_SIGNAL)
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  199  		_exception(SIGBUS, fp, BUS_ADRALN, fp->ea);
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  200  	else
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  201  		fp->ea += 4;	/* else advance */
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  202  }
82ed08dd1b0e0e Ley Foon Tan  2014-11-06  203  

:::::: The code at line 111 was first introduced by commit
:::::: 82ed08dd1b0e0e0728f9188f66795c49dffe437d nios2: Exception handling

:::::: TO: Ley Foon Tan <lftan@altera.com>
:::::: CC: Ley Foon Tan <lftan@altera.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
