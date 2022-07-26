Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9875808F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 03:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiGZBM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 21:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGZBMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 21:12:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24F1286E7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658797943; x=1690333943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8N5qaxRry5EHUG+RRq57yRTICY/Twv5artgSQiFOL6k=;
  b=L5UnTiFcFlGTy9n++ADAS5dB/QcCNGbGH1FeipUmH22g/XaXeSOrusjM
   qFHG0J24pslxhdrLfCmo37LnF4xxI+8bV2ub76R035XWT3XsESCq6Whs+
   NrsjiSNzhWTPeJwjvfpB41SJy27kQ8ID+v36wSUBDgdNWIW2Sil6qooKi
   lxTTHS3pVnW/YHeSb8cBS/o+ZEIx2z0H6FNRr06BMHHZjF0pBHEt2fAQ0
   2PK9e+MMrFIGJd0dEiJpbt8Vuk0UvaFVrpXhGifZIvYHIWR8NG5Nj0Kbo
   yXV8IIO5kXVkbF3Vp572QB7n7a8dhjIKM85Nf+CDhHV50m/wlZoeIPP1E
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="270866014"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="270866014"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 18:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="742028958"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2022 18:12:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oG97U-0005ls-0w;
        Tue, 26 Jul 2022 01:12:20 +0000
Date:   Tue, 26 Jul 2022 09:12:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 176/176]
 arch/x86/include/asm/extable_fixup_types.h:49: warning:
 "EX_TYPE_DEFAULT_MCE_SAFE" redefined
Message-ID: <202207260945.pRWSVmFg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
head:   9780829ed8d15de556424bed96704c95dfc357f6
commit: 9780829ed8d15de556424bed96704c95dfc357f6 [176/176] x86/extable: Provide EX_TYPE_DEFAULT_MCE_SAFE and EX_TYPE_FAULT_MCE_SAFE
config: x86_64-randconfig-c002 (https://download.01.org/0day-ci/archive/20220726/202207260945.pRWSVmFg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/9780829ed8d15de556424bed96704c95dfc357f6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
        git checkout 9780829ed8d15de556424bed96704c95dfc357f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/asm.h:125,
                    from arch/x86/include/asm/alternative.h:7,
                    from arch/x86/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:261,
                    from arch/x86/include/asm/string_64.h:6,
                    from arch/x86/include/asm/string.h:5,
                    from include/linux/string.h:20,
                    from include/linux/uuid.h:12,
                    from include/linux/mod_devicetable.h:13,
                    from scripts/mod/devicetable-offsets.c:3:
>> arch/x86/include/asm/extable_fixup_types.h:49: warning: "EX_TYPE_DEFAULT_MCE_SAFE" redefined
      49 | #define EX_TYPE_DEFAULT_MCE_SAFE        12
         | 
   arch/x86/include/asm/extable_fixup_types.h:42: note: this is the location of the previous definition
      42 | #define EX_TYPE_DEFAULT_MCE_SAFE        14
         | 
>> arch/x86/include/asm/extable_fixup_types.h:50: warning: "EX_TYPE_FAULT_MCE_SAFE" redefined
      50 | #define EX_TYPE_FAULT_MCE_SAFE          13
         | 
   arch/x86/include/asm/extable_fixup_types.h:43: note: this is the location of the previous definition
      43 | #define EX_TYPE_FAULT_MCE_SAFE          15
         | 
--
   In file included from arch/x86/include/asm/asm.h:125,
                    from arch/x86/include/asm/alternative.h:7,
                    from arch/x86/include/asm/bitops.h:17,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:12,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from include/linux/uaccess.h:8,
                    from arch/x86/mm/extable.c:3:
>> arch/x86/include/asm/extable_fixup_types.h:49: warning: "EX_TYPE_DEFAULT_MCE_SAFE" redefined
      49 | #define EX_TYPE_DEFAULT_MCE_SAFE        12
         | 
   arch/x86/include/asm/extable_fixup_types.h:42: note: this is the location of the previous definition
      42 | #define EX_TYPE_DEFAULT_MCE_SAFE        14
         | 
>> arch/x86/include/asm/extable_fixup_types.h:50: warning: "EX_TYPE_FAULT_MCE_SAFE" redefined
      50 | #define EX_TYPE_FAULT_MCE_SAFE          13
         | 
   arch/x86/include/asm/extable_fixup_types.h:43: note: this is the location of the previous definition
      43 | #define EX_TYPE_FAULT_MCE_SAFE          15
         | 
   arch/x86/mm/extable.c: In function 'fixup_exception':
   arch/x86/mm/extable.c:200:9: error: duplicate case value
     200 |         case EX_TYPE_WRMSR_IN_MCE:
         |         ^~~~
   arch/x86/mm/extable.c:177:9: note: previously used here
     177 |         case EX_TYPE_DEFAULT_MCE_SAFE:
         |         ^~~~
   arch/x86/mm/extable.c:203:9: error: duplicate case value
     203 |         case EX_TYPE_RDMSR_IN_MCE:
         |         ^~~~
   arch/x86/mm/extable.c:180:9: note: previously used here
     180 |         case EX_TYPE_FAULT_MCE_SAFE:
         |         ^~~~
--
   In file included from arch/x86/include/asm/asm.h:125,
                    from arch/x86/include/asm/alternative.h:7,
                    from arch/x86/include/asm/bitops.h:17,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:12,
                    from include/linux/list.h:9,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:9,
                    from security/security.c:13:
>> arch/x86/include/asm/extable_fixup_types.h:49: warning: "EX_TYPE_DEFAULT_MCE_SAFE" redefined
      49 | #define EX_TYPE_DEFAULT_MCE_SAFE        12
         | 
   arch/x86/include/asm/extable_fixup_types.h:42: note: this is the location of the previous definition
      42 | #define EX_TYPE_DEFAULT_MCE_SAFE        14
         | 
>> arch/x86/include/asm/extable_fixup_types.h:50: warning: "EX_TYPE_FAULT_MCE_SAFE" redefined
      50 | #define EX_TYPE_FAULT_MCE_SAFE          13
         | 
   arch/x86/include/asm/extable_fixup_types.h:43: note: this is the location of the previous definition
      43 | #define EX_TYPE_FAULT_MCE_SAFE          15
         | 
   include/linux/lsm_hook_defs.h:403:18: warning: 'perf_event_write_default' defined but not used [-Wunused-const-variable=]
     403 | LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
         |                  ^~~~~~~~~~~~~~~~
   security/security.c:708:32: note: in definition of macro 'LSM_RET_DEFAULT'
     708 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
         |                                ^~~~
   security/security.c:713:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
     713 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lsm_hook_defs.h:403:1: note: in expansion of macro 'LSM_HOOK'
     403 | LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
         | ^~~~~~~~
   include/linux/lsm_hook_defs.h:402:18: warning: 'perf_event_read_default' defined but not used [-Wunused-const-variable=]
     402 | LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
         |                  ^~~~~~~~~~~~~~~
   security/security.c:708:32: note: in definition of macro 'LSM_RET_DEFAULT'
     708 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
         |                                ^~~~
   security/security.c:713:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
     713 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lsm_hook_defs.h:402:1: note: in expansion of macro 'LSM_HOOK'
     402 | LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
         | ^~~~~~~~
   include/linux/lsm_hook_defs.h:400:18: warning: 'perf_event_alloc_default' defined but not used [-Wunused-const-variable=]
     400 | LSM_HOOK(int, 0, perf_event_alloc, struct perf_event *event)
         |                  ^~~~~~~~~~~~~~~~
   security/security.c:708:32: note: in definition of macro 'LSM_RET_DEFAULT'
     708 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
         |                                ^~~~
   security/security.c:713:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
     713 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lsm_hook_defs.h:400:1: note: in expansion of macro 'LSM_HOOK'
     400 | LSM_HOOK(int, 0, perf_event_alloc, struct perf_event *event)
         | ^~~~~~~~
   include/linux/lsm_hook_defs.h:399:18: warning: 'perf_event_open_default' defined but not used [-Wunused-const-variable=]
     399 | LSM_HOOK(int, 0, perf_event_open, struct perf_event_attr *attr, int type)
         |                  ^~~~~~~~~~~~~~~
   security/security.c:708:32: note: in definition of macro 'LSM_RET_DEFAULT'
     708 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
         |                                ^~~~
   security/security.c:713:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
     713 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lsm_hook_defs.h:399:1: note: in expansion of macro 'LSM_HOOK'
     399 | LSM_HOOK(int, 0, perf_event_open, struct perf_event_attr *attr, int type)
         | ^~~~~~~~
   include/linux/lsm_hook_defs.h:396:18: warning: 'locked_down_default' defined but not used [-Wunused-const-variable=]
     396 | LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
         |                  ^~~~~~~~~~~
   security/security.c:708:32: note: in definition of macro 'LSM_RET_DEFAULT'
     708 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
         |                                ^~~~
   security/security.c:713:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
     713 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lsm_hook_defs.h:396:1: note: in expansion of macro 'LSM_HOOK'
     396 | LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
         | ^~~~~~~~
   include/linux/lsm_hook_defs.h:392:18: warning: 'bpf_prog_alloc_security_default' defined but not used [-Wunused-const-variable=]
     392 | LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   security/security.c:708:32: note: in definition of macro 'LSM_RET_DEFAULT'
     708 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
         |                                ^~~~
   security/security.c:713:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
     713 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lsm_hook_defs.h:392:1: note: in expansion of macro 'LSM_HOOK'
     392 | LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
         | ^~~~~~~~
   include/linux/lsm_hook_defs.h:390:18: warning: 'bpf_map_alloc_security_default' defined but not used [-Wunused-const-variable=]
     390 | LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
         |                  ^~~~~~~~~~~~~~~~~~~~~~
   security/security.c:708:32: note: in definition of macro 'LSM_RET_DEFAULT'
     708 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
         |                                ^~~~
   security/security.c:713:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
     713 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lsm_hook_defs.h:390:1: note: in expansion of macro 'LSM_HOOK'
     390 | LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
         | ^~~~~~~~
   include/linux/lsm_hook_defs.h:389:18: warning: 'bpf_prog_default' defined but not used [-Wunused-const-variable=]
     389 | LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
         |                  ^~~~~~~~
   security/security.c:708:32: note: in definition of macro 'LSM_RET_DEFAULT'
     708 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
         |                                ^~~~
   security/security.c:713:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
     713 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lsm_hook_defs.h:389:1: note: in expansion of macro 'LSM_HOOK'
     389 | LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
--
   In file included from arch/x86/include/asm/asm.h:125,
                    from arch/x86/include/asm/alternative.h:7,
                    from arch/x86/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:261,
                    from arch/x86/include/asm/string_64.h:6,
                    from arch/x86/include/asm/string.h:5,
                    from include/linux/string.h:20,
                    from include/linux/uuid.h:12,
                    from include/linux/mod_devicetable.h:13,
                    from scripts/mod/devicetable-offsets.c:3:
>> arch/x86/include/asm/extable_fixup_types.h:49: warning: "EX_TYPE_DEFAULT_MCE_SAFE" redefined
      49 | #define EX_TYPE_DEFAULT_MCE_SAFE        12
         | 
   arch/x86/include/asm/extable_fixup_types.h:42: note: this is the location of the previous definition
      42 | #define EX_TYPE_DEFAULT_MCE_SAFE        14
         | 
>> arch/x86/include/asm/extable_fixup_types.h:50: warning: "EX_TYPE_FAULT_MCE_SAFE" redefined
      50 | #define EX_TYPE_FAULT_MCE_SAFE          13
         | 
   arch/x86/include/asm/extable_fixup_types.h:43: note: this is the location of the previous definition
      43 | #define EX_TYPE_FAULT_MCE_SAFE          15
         | 
   In file included from arch/x86/include/asm/asm.h:125,
                    from arch/x86/include/asm/alternative.h:7,
                    from arch/x86/include/asm/bitops.h:17,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> arch/x86/include/asm/extable_fixup_types.h:49: warning: "EX_TYPE_DEFAULT_MCE_SAFE" redefined
      49 | #define EX_TYPE_DEFAULT_MCE_SAFE        12
         | 
   arch/x86/include/asm/extable_fixup_types.h:42: note: this is the location of the previous definition
      42 | #define EX_TYPE_DEFAULT_MCE_SAFE        14
         | 
>> arch/x86/include/asm/extable_fixup_types.h:50: warning: "EX_TYPE_FAULT_MCE_SAFE" redefined
      50 | #define EX_TYPE_FAULT_MCE_SAFE          13
         | 
   arch/x86/include/asm/extable_fixup_types.h:43: note: this is the location of the previous definition
      43 | #define EX_TYPE_FAULT_MCE_SAFE          15
         | 
   In file included from arch/x86/include/asm/asm.h:125,
                    from arch/x86/include/asm/alternative.h:7,
                    from arch/x86/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/crypto.h:15,
                    from arch/x86/kernel/asm-offsets.c:9:
>> arch/x86/include/asm/extable_fixup_types.h:49: warning: "EX_TYPE_DEFAULT_MCE_SAFE" redefined
      49 | #define EX_TYPE_DEFAULT_MCE_SAFE        12
         | 
   arch/x86/include/asm/extable_fixup_types.h:42: note: this is the location of the previous definition
      42 | #define EX_TYPE_DEFAULT_MCE_SAFE        14
         | 
>> arch/x86/include/asm/extable_fixup_types.h:50: warning: "EX_TYPE_FAULT_MCE_SAFE" redefined
      50 | #define EX_TYPE_FAULT_MCE_SAFE          13
         | 
   arch/x86/include/asm/extable_fixup_types.h:43: note: this is the location of the previous definition
      43 | #define EX_TYPE_FAULT_MCE_SAFE          15
         | 


vim +/EX_TYPE_DEFAULT_MCE_SAFE +49 arch/x86/include/asm/extable_fixup_types.h

    48	
  > 49	#define	EX_TYPE_DEFAULT_MCE_SAFE	12
  > 50	#define	EX_TYPE_FAULT_MCE_SAFE		13
    51	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
