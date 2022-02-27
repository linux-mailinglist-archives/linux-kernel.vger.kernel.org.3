Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD64C5E7B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 20:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiB0TwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 14:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiB0TwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 14:52:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C324B33A1B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 11:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645991504; x=1677527504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QQ/Nrw3Gdo6dX9SuTohdk3UBtUwaqOaYtCxuaZPrYEA=;
  b=nMuxniVbjK2CpXHiPqt1wJGiA8F7Bs/yLvJyhVJ7SqKbsSzConeDCQUC
   QKTLs7D4Te6JTpRmUb3NDl866sSRjkoIErwhPcQArsnewm794FbkxXbb7
   Hlx+avVMaDx44f5b188itFLQvSSXMQOFqM8Blwz6lB6AMih/Z+/QtlXw0
   PL2Ns3rk+ZbEzA4dBtOh8ZYmNvbFVleQOscEXqH9WSwJd7zU5TWAHPiYA
   hr+LrNTVNgHnHcKltClCLz0h7ra1WwF/PR6RoCPIwcjXYPy+ZnHON483E
   hAdkwXymKISpl8B/cqojxhYnArirJtYKzUAC+f6uZg4FwG2CIRiBA+y88
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="252683389"
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="252683389"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 11:51:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="640677487"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2022 11:51:42 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOPa1-0006lK-Ko; Sun, 27 Feb 2022 19:51:41 +0000
Date:   Mon, 28 Feb 2022 03:50:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bert Vermeulen <bert@biot.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sander Vanheule <sander@svanheule.net>
Subject: arch/mips/kernel/vpe-mt.c:178:7: warning: no previous prototype for
 function 'vpe_alloc'
Message-ID: <202202280331.yb2wf0qs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bert,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2293be58d6a18cab800e25e42081bacb75c05752
commit: 4042147a0cc6af5a400b5e12a7855e893dec01b4 MIPS: Add Realtek RTL838x/RTL839x support as generic MIPS system
date:   1 year, 1 month ago
config: mips-randconfig-r025-20220228 (https://download.01.org/0day-ci/archive/20220228/202202280331.yb2wf0qs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4042147a0cc6af5a400b5e12a7855e893dec01b4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4042147a0cc6af5a400b5e12a7855e893dec01b4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/kernel/vpe-mt.c:178:7: warning: no previous prototype for function 'vpe_alloc' [-Wmissing-prototypes]
   void *vpe_alloc(void)
         ^
   arch/mips/kernel/vpe-mt.c:178:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *vpe_alloc(void)
   ^
   static 
>> arch/mips/kernel/vpe-mt.c:196:5: warning: no previous prototype for function 'vpe_start' [-Wmissing-prototypes]
   int vpe_start(void *vpe, unsigned long start)
       ^
   arch/mips/kernel/vpe-mt.c:196:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vpe_start(void *vpe, unsigned long start)
   ^
   static 
>> arch/mips/kernel/vpe-mt.c:206:5: warning: no previous prototype for function 'vpe_stop' [-Wmissing-prototypes]
   int vpe_stop(void *vpe)
       ^
   arch/mips/kernel/vpe-mt.c:206:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vpe_stop(void *vpe)
   ^
   static 
>> arch/mips/kernel/vpe-mt.c:227:5: warning: no previous prototype for function 'vpe_free' [-Wmissing-prototypes]
   int vpe_free(void *vpe)
       ^
   arch/mips/kernel/vpe-mt.c:227:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vpe_free(void *vpe)
   ^
   static 
   4 warnings generated.


vim +/vpe_alloc +178 arch/mips/kernel/vpe-mt.c

1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  175  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  176  /* module wrapper entry points */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  177  /* give me a vpe */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30 @178  void *vpe_alloc(void)
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  179  {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  180  	int i;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  181  	struct vpe *v;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  182  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  183  	/* find a vpe */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  184  	for (i = 1; i < MAX_VPES; i++) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  185  		v = get_vpe(i);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  186  		if (v != NULL) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  187  			v->state = VPE_STATE_INUSE;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  188  			return v;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  189  		}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  190  	}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  191  	return NULL;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  192  }
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  193  EXPORT_SYMBOL(vpe_alloc);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  194  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  195  /* start running from here */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30 @196  int vpe_start(void *vpe, unsigned long start)
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  197  {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  198  	struct vpe *v = vpe;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  199  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  200  	v->__start = start;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  201  	return vpe_run(v);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  202  }
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  203  EXPORT_SYMBOL(vpe_start);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  204  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  205  /* halt it for now */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30 @206  int vpe_stop(void *vpe)
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  207  {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  208  	struct vpe *v = vpe;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  209  	struct tc *t;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  210  	unsigned int evpe_flags;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  211  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  212  	evpe_flags = dvpe();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  213  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  214  	t = list_entry(v->tc.next, struct tc, tc);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  215  	if (t != NULL) {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  216  		settc(t->index);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  217  		write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() & ~VPECONF0_VPA);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  218  	}
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  219  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  220  	evpe(evpe_flags);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  221  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  222  	return 0;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  223  }
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  224  EXPORT_SYMBOL(vpe_stop);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  225  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  226  /* I've done with it thank you */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30 @227  int vpe_free(void *vpe)
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  228  {
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  229  	struct vpe *v = vpe;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  230  	struct tc *t;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  231  	unsigned int evpe_flags;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  232  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  233  	t = list_entry(v->tc.next, struct tc, tc);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  234  	if (t == NULL)
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  235  		return -ENOEXEC;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  236  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  237  	evpe_flags = dvpe();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  238  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  239  	/* Put MVPE's into 'configuration state' */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  240  	set_c0_mvpcontrol(MVPCONTROL_VPC);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  241  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  242  	settc(t->index);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  243  	write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() & ~VPECONF0_VPA);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  244  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  245  	/* halt the TC */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  246  	write_tc_c0_tchalt(TCHALT_H);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  247  	mips_ihb();
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  248  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  249  	/* mark the TC unallocated */
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  250  	write_tc_c0_tcstatus(read_tc_c0_tcstatus() & ~TCSTATUS_A);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  251  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  252  	v->state = VPE_STATE_UNUSED;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  253  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  254  	clear_c0_mvpcontrol(MVPCONTROL_VPC);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  255  	evpe(evpe_flags);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  256  
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  257  	return 0;
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  258  }
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  259  EXPORT_SYMBOL(vpe_free);
1a2a6d7e8816ed Dengcheng Zhu 2013-10-30  260  

:::::: The code at line 178 was first introduced by commit
:::::: 1a2a6d7e8816ed2b2679a0c4f7ba4019cd31dd62 MIPS: APRP: Split VPE loader into separate files.

:::::: TO: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
