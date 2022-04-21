Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA950984F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385205AbiDUGu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385170AbiDUGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6C715722
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523435; x=1682059435;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tGDwsRSfzzAl2tPyM5e0CqzjFlQNTdW0Hf+Zc8ssoIU=;
  b=ZklVmwRxf4BFRd2FwU/ltfWUB0yYa4xY2SnCvee8wDNwxZLD04qDNt7W
   ZHpr2iR0Z1m6R5ShvDq0qcoo/bFPrzlMgY3JWH9mSceAOHu3R5RBXc/0/
   nZMjqqUwfjYXU7ufHCB/8YfytN8SYpverboHtE0bSpw0C4YTNrITdES1C
   q/0Q5Q/N4tDhj0XM2hZ6WZsmbfnNbZpaZL61zw0TBDUZ6Vmf1XRPis6sP
   jlwzCbi1lArq5CimDxrD62yN5pH8Tnaj/QB3smj7mn9/AQoRVVe9EFo+L
   cM17+WkWmYZ4SIfPXlVRy8rrFgk0CGSCah+fGFmvHJhhIy1OrDjkhMXOL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="289369461"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="289369461"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="670049057"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2022 23:43:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQXf-00080v-3y;
        Thu, 21 Apr 2022 06:43:51 +0000
Date:   Thu, 21 Apr 2022 14:42:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: arch/parisc/kernel/traps.c:806:14: warning: variable 'hpmcp' set but
 not used
Message-ID: <202204210504.e7yvq7aa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: c70919bd9d0782a6078ccd37d7f861d514f5481e parisc: Fix IVT checksum calculation wrt HPMC
date:   1 year, 2 months ago
config: parisc-randconfig-r031-20220420 (https://download.01.org/0day-ci/archive/20220421/202204210504.e7yvq7aa-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c70919bd9d0782a6078ccd37d7f861d514f5481e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c70919bd9d0782a6078ccd37d7f861d514f5481e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/parisc/kernel/traps.c: In function 'initialize_ivt':
>> arch/parisc/kernel/traps.c:806:14: warning: variable 'hpmcp' set but not used [-Wunused-but-set-variable]
     806 |         u32 *hpmcp;
         |              ^~~~~


vim +/hpmcp +806 arch/parisc/kernel/traps.c

^1da177e4c3f415 Linus Torvalds    2005-04-16  797  
^1da177e4c3f415 Linus Torvalds    2005-04-16  798  
4182d0cdf853fb0 Helge Deller      2015-11-20  799  void __init initialize_ivt(const void *iva)
^1da177e4c3f415 Linus Torvalds    2005-04-16  800  {
c3d4ed4e3e5aa8d Kyle McMartin     2007-06-04  801  	extern const u32 os_hpmc[];
c3d4ed4e3e5aa8d Kyle McMartin     2007-06-04  802  
^1da177e4c3f415 Linus Torvalds    2005-04-16  803  	int i;
^1da177e4c3f415 Linus Torvalds    2005-04-16  804  	u32 check = 0;
^1da177e4c3f415 Linus Torvalds    2005-04-16  805  	u32 *ivap;
^1da177e4c3f415 Linus Torvalds    2005-04-16 @806  	u32 *hpmcp;
c70919bd9d0782a Sven Schnelle     2020-10-02  807  	u32 instr;
^1da177e4c3f415 Linus Torvalds    2005-04-16  808  
4182d0cdf853fb0 Helge Deller      2015-11-20  809  	if (strcmp((const char *)iva, "cows can fly"))
4182d0cdf853fb0 Helge Deller      2015-11-20  810  		panic("IVT invalid");
^1da177e4c3f415 Linus Torvalds    2005-04-16  811  
^1da177e4c3f415 Linus Torvalds    2005-04-16  812  	ivap = (u32 *)iva;
^1da177e4c3f415 Linus Torvalds    2005-04-16  813  
^1da177e4c3f415 Linus Torvalds    2005-04-16  814  	for (i = 0; i < 8; i++)
^1da177e4c3f415 Linus Torvalds    2005-04-16  815  	    *ivap++ = 0;
^1da177e4c3f415 Linus Torvalds    2005-04-16  816  
8d771b143fe2e39 Helge Deller      2017-09-17  817  	/*
8d771b143fe2e39 Helge Deller      2017-09-17  818  	 * Use PDC_INSTR firmware function to get instruction that invokes
8d771b143fe2e39 Helge Deller      2017-09-17  819  	 * PDCE_CHECK in HPMC handler.  See programming note at page 1-31 of
8d771b143fe2e39 Helge Deller      2017-09-17  820  	 * the PA 1.1 Firmware Architecture document.
8d771b143fe2e39 Helge Deller      2017-09-17  821  	 */
8d771b143fe2e39 Helge Deller      2017-09-17  822  	if (pdc_instr(&instr) == PDC_OK)
8d771b143fe2e39 Helge Deller      2017-09-17  823  		ivap[0] = instr;
8d771b143fe2e39 Helge Deller      2017-09-17  824  
41dbee81c875300 Helge Deller      2018-04-18  825  	/*
41dbee81c875300 Helge Deller      2018-04-18  826  	 * Rules for the checksum of the HPMC handler:
41dbee81c875300 Helge Deller      2018-04-18  827  	 * 1. The IVA does not point to PDC/PDH space (ie: the OS has installed
41dbee81c875300 Helge Deller      2018-04-18  828  	 *    its own IVA).
41dbee81c875300 Helge Deller      2018-04-18  829  	 * 2. The word at IVA + 32 is nonzero.
41dbee81c875300 Helge Deller      2018-04-18  830  	 * 3. If Length (IVA + 60) is not zero, then Length (IVA + 60) and
41dbee81c875300 Helge Deller      2018-04-18  831  	 *    Address (IVA + 56) are word-aligned.
41dbee81c875300 Helge Deller      2018-04-18  832  	 * 4. The checksum of the 8 words starting at IVA + 32 plus the sum of
41dbee81c875300 Helge Deller      2018-04-18  833  	 *    the Length/4 words starting at Address is zero.
41dbee81c875300 Helge Deller      2018-04-18  834  	 */
41dbee81c875300 Helge Deller      2018-04-18  835  
1138b6718ff74d2 John David Anglin 2018-10-06  836  	/* Setup IVA and compute checksum for HPMC handler */
1138b6718ff74d2 John David Anglin 2018-10-06  837  	ivap[6] = (u32)__pa(os_hpmc);
^1da177e4c3f415 Linus Torvalds    2005-04-16  838  
^1da177e4c3f415 Linus Torvalds    2005-04-16  839  	hpmcp = (u32 *)os_hpmc;
^1da177e4c3f415 Linus Torvalds    2005-04-16  840  
^1da177e4c3f415 Linus Torvalds    2005-04-16  841  	for (i=0; i<8; i++)
^1da177e4c3f415 Linus Torvalds    2005-04-16  842  	    check += ivap[i];
^1da177e4c3f415 Linus Torvalds    2005-04-16  843  
^1da177e4c3f415 Linus Torvalds    2005-04-16  844  	ivap[5] = -check;
c70919bd9d0782a Sven Schnelle     2020-10-02  845  	pr_debug("initialize_ivt: IVA[6] = 0x%08x\n", ivap[6]);
^1da177e4c3f415 Linus Torvalds    2005-04-16  846  }
^1da177e4c3f415 Linus Torvalds    2005-04-16  847  	
4182d0cdf853fb0 Helge Deller      2015-11-20  848  

:::::: The code at line 806 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
