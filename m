Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6475546454B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 04:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbhLADP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:15:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:28277 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhLADP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:15:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="299764938"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="299764938"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 19:12:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="511818514"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 30 Nov 2021 19:12:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msG2K-000E7y-4a; Wed, 01 Dec 2021 03:12:00 +0000
Date:   Wed, 1 Dec 2021 11:11:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:for-next-maybe 1/1] mm/usercopy.c:134:2: warning:
 this 'if' clause does not guard...
Message-ID: <202112011144.adv9Pf3v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next-maybe
head:   4d7b3620412d727e09bf0eef942be42da363260d
commit: 4d7b3620412d727e09bf0eef942be42da363260d [1/1] usercopy: Do not fail if memory is from the init section
config: i386-randconfig-r033-20211129 (https://download.01.org/0day-ci/archive/20211201/202112011144.adv9Pf3v-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=4d7b3620412d727e09bf0eef942be42da363260d
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc for-next-maybe
        git checkout 4d7b3620412d727e09bf0eef942be42da363260d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/usercopy.c: In function 'check_kernel_text_object':
   mm/usercopy.c:134:56: error: expected ')' before 'return'
     134 |  if (inside_init_area(ptr, n, __init_begin, __init_end)
         |     ~                                                  ^
         |                                                        )
     135 |   return;
         |   ~~~~~~                                                
>> mm/usercopy.c:134:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     134 |  if (inside_init_area(ptr, n, __init_begin, __init_end)
         |  ^~
   mm/usercopy.c:324: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     324 | late_initcall(set_hardened_usercopy);
         | 
   mm/usercopy.c:324:1: error: expected declaration or statement at end of input
     324 | late_initcall(set_hardened_usercopy);
         | ^~~~~~~~~~~~~
   mm/usercopy.c:131:32: warning: unused variable 'texthigh_linear' [-Wunused-variable]
     131 |  unsigned long textlow_linear, texthigh_linear;
         |                                ^~~~~~~~~~~~~~~
   mm/usercopy.c:131:16: warning: unused variable 'textlow_linear' [-Wunused-variable]
     131 |  unsigned long textlow_linear, texthigh_linear;
         |                ^~~~~~~~~~~~~~
   mm/usercopy.c:130:16: warning: unused variable 'texthigh' [-Wunused-variable]
     130 |  unsigned long texthigh = (unsigned long)_etext;
         |                ^~~~~~~~
   mm/usercopy.c:129:16: warning: unused variable 'textlow' [-Wunused-variable]
     129 |  unsigned long textlow = (unsigned long)_stext;
         |                ^~~~~~~
   At top level:
   mm/usercopy.c:103:13: warning: 'overlaps' defined but not used [-Wunused-function]
     103 | static bool overlaps(const unsigned long ptr, unsigned long n,
         |             ^~~~~~~~
   mm/usercopy.c:34:21: warning: 'check_stack_object' defined but not used [-Wunused-function]
      34 | static noinline int check_stack_object(const void *obj, unsigned long len)
         |                     ^~~~~~~~~~~~~~~~~~


vim +/if +134 mm/usercopy.c

   124	
   125	/* Is this address range in the kernel text area? */
   126	static inline void check_kernel_text_object(const unsigned long ptr,
   127						    unsigned long n, bool to_user)
   128	{
   129		unsigned long textlow = (unsigned long)_stext;
   130		unsigned long texthigh = (unsigned long)_etext;
   131		unsigned long textlow_linear, texthigh_linear;
   132	
   133		/* Ok if inside the former init sections */
 > 134		if (inside_init_area(ptr, n, __init_begin, __init_end)
   135			return;
   136		if (inside_init_area(ptr, n, _sinittext, _einittext)
   137			return;
   138	
   139		if (overlaps(ptr, n, textlow, texthigh))
   140			usercopy_abort("kernel text", NULL, to_user, ptr - textlow, n);
   141	
   142		/*
   143		 * Some architectures have virtual memory mappings with a secondary
   144		 * mapping of the kernel text, i.e. there is more than one virtual
   145		 * kernel address that points to the kernel image. It is usually
   146		 * when there is a separate linear physical memory mapping, in that
   147		 * __pa() is not just the reverse of __va(). This can be detected
   148		 * and checked:
   149		 */
   150		textlow_linear = (unsigned long)lm_alias(textlow);
   151		/* No different mapping: we're done. */
   152		if (textlow_linear == textlow)
   153			return;
   154	
   155		/* Check the secondary mapping... */
   156		texthigh_linear = (unsigned long)lm_alias(texthigh);
   157		if (overlaps(ptr, n, textlow_linear, texthigh_linear))
   158			usercopy_abort("linear kernel text", NULL, to_user,
   159				       ptr - textlow_linear, n);
   160	}
   161	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
