Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886C6584458
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiG1Qqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiG1Qqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:46:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A9542AE8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659026793; x=1690562793;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AS5n6hugPL/5ZECWTaAmC48T1RB2vebY4lHpq3xywLw=;
  b=j1fqd9plf43e9SRB3syqSAt/2OMsKmiIms9rpdqUfeIGKctO1vYXQupf
   U22oLS9OvD6hcyS5idXFkvw+Oh6exn6Ap4SALdHb2AkNkOf7UFH5j14PZ
   mRBuMGyXrH9kExR3evrC3jfjNpvb3P+wFalvFI2B1E1rS94RtMmEicYEV
   V5bXZcFg+leodaNKmsBLzudtf3+/ZNmuMnxOJMZ+U8hkvC3h2gN7HOtOc
   QK0qhJ86PLs/BTvYknGcHnbYgWsNF4jcojQJk1rhQyM67fMZPFKasIukR
   oBdPbllx5hEZ8SLQZ2/HErxqkUze0dk8aymbP2yLX3hfFx8z+/X6vKRLj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="268943511"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="268943511"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 09:46:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="576550226"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2022 09:46:31 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH6ed-000ANz-0f;
        Thu, 28 Jul 2022 16:46:31 +0000
Date:   Fri, 29 Jul 2022 00:46:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Garnier <thgarnie@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 7414/9999]
 security/container/process.c:44:31: error: 'struct linux_binprm' has no
 member named 'vma'
Message-ID: <202207290033.VXKH5hwO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 92dff21f44ad18e109b6e086a29141fe474b3782 [7414/9999] CHROMIUM: security: Container Monitoring LSM
config: sh-randconfig-c041-20220728 (https://download.01.org/0day-ci/archive/20220729/202207290033.VXKH5hwO-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/92dff21f44ad18e109b6e086a29141fe474b3782
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 92dff21f44ad18e109b6e086a29141fe474b3782
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash security/container/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   security/container/process.c: In function 'kmap_argument_stack':
>> security/container/process.c:44:31: error: 'struct linux_binprm' has no member named 'vma'
      44 |         count = vma_pages(bprm->vma);
         |                               ^~
   In file included from include/linux/kernel.h:10,
                    from security/container/monitor.h:10,
                    from security/container/process.c:8:
   security/container/process.c: In function 'kunmap_argument_stack':
   security/container/process.c:93:34: error: 'struct linux_binprm' has no member named 'vma'
      93 |         if (likely(vma_pages(bprm->vma) == 1)) {
         |                                  ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   security/container/process.c: In function 'encode_current_argv':
   security/container/process.c:150:43: error: 'struct linux_binprm' has no member named 'vma'
     150 |         unsigned long end = vma_pages(bprm->vma) * PAGE_SIZE;
         |                                           ^~
   security/container/process.c: In function 'encode_current_envp':
   security/container/process.c:234:43: error: 'struct linux_binprm' has no member named 'vma'
     234 |         unsigned long end = vma_pages(bprm->vma) * PAGE_SIZE;
         |                                           ^~
   security/container/process.c: At top level:
   security/container/process.c:367:5: warning: no previous prototype for 'csm_set_contid' [-Wmissing-prototypes]
     367 | u64 csm_set_contid(struct task_struct *task)
         |     ^~~~~~~~~~~~~~


vim +44 security/container/process.c

    34	
    35	static void *kmap_argument_stack(struct linux_binprm *bprm, void **ctx)
    36	{
    37		char *argv;
    38		int err;
    39		unsigned long i, pos, count;
    40		void *map;
    41		struct page *page;
    42	
    43		/* vma_pages() returns the number of pages reserved for the stack */
  > 44		count = vma_pages(bprm->vma);
    45	
    46		if (likely(count == 1)) {
    47			err = get_user_pages_remote(current, bprm->mm, bprm->p, 1,
    48						    FOLL_FORCE, &page, NULL, NULL);
    49			if (err != 1)
    50				return NULL;
    51	
    52			argv = kmap(page);
    53			*ctx = page;
    54		} else {
    55			/*
    56			 * If more than one pages is needed, copy all of them to a set
    57			 * of pages. Parsing the argument across kmap pages in different
    58			 * addresses would make it impractical.
    59			 */
    60			argv = vmalloc(count * PAGE_SIZE);
    61			if (!argv)
    62				return NULL;
    63	
    64			for (i = 0; i < count; i++) {
    65				pos = ALIGN_DOWN(bprm->p, PAGE_SIZE) + i * PAGE_SIZE;
    66				err = get_user_pages_remote(current, bprm->mm, pos, 1,
    67							    FOLL_FORCE, &page, NULL,
    68							    NULL);
    69				if (err <= 0) {
    70					vfree(argv);
    71					return NULL;
    72				}
    73	
    74				map = kmap(page);
    75				memcpy(argv + i * PAGE_SIZE, map, PAGE_SIZE);
    76				kunmap(page);
    77				put_page(page);
    78			}
    79			*ctx = bprm;
    80		}
    81	
    82		return argv;
    83	}
    84	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
