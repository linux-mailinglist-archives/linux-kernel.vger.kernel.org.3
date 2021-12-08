Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AE546CADA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbhLHC1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:27:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:32801 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233825AbhLHC1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:27:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298534797"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="298534797"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 18:24:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="749309371"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 07 Dec 2021 18:24:21 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mumd3-000NGX-6W; Wed, 08 Dec 2021 02:24:21 +0000
Date:   Wed, 8 Dec 2021 10:23:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:memcpy/step2/next-20211206 7/19]
 include/linux/fortify-string.h:275:25: warning: call to
 '__read_overflow2_field' declared with attribute warning: detected read
 beyond size of field (2nd parameter); maybe use struct_group()?
Message-ID: <202112081044.KfVvTrmn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git memcpy/step2/next-20211206
head:   082faead4a3c2e5d9f541f97d8d4d5fa0f88dce0
commit: a91965903a44bf236856efc7e20c6334c4e07388 [7/19] fortify: Detect struct member overflows in memcpy() at compile-time
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20211208/202112081044.KfVvTrmn-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=a91965903a44bf236856efc7e20c6334c4e07388
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees memcpy/step2/next-20211206
        git checkout a91965903a44bf236856efc7e20c6334c4e07388
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from arch/mips/include/asm/cpu-type.h:12,
                    from arch/mips/include/asm/timex.h:19,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/staging/wlan-ng/hfa384x_usb.c:114,
                    from drivers/staging/wlan-ng/prism2usb.c:2:
   In function 'fortify_memcpy_chk',
       inlined from 'mkpdrlist.constprop' at drivers/staging/wlan-ng/prism2fw.c:625:4:
>> include/linux/fortify-string.h:275:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     275 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'fortify_memcpy_chk',
       inlined from 'mkpdrlist.constprop' at drivers/staging/wlan-ng/prism2fw.c:634:4:
>> include/linux/fortify-string.h:275:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     275 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from arch/mips/include/asm/processor.h:15,
                    from arch/mips/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from drivers/staging/rtl8723bs/include/drv_types.h:17,
                    from drivers/staging/rtl8723bs/core/rtw_security.c:8:
   In function 'fortify_memcpy_chk',
       inlined from 'rtw_BIP_verify' at drivers/staging/rtl8723bs/core/rtw_security.c:1425:3:
>> include/linux/fortify-string.h:275:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     275 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from arch/mips/include/asm/cpu-type.h:12,
                    from arch/mips/include/asm/timex.h:19,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/nvme/target/core.c:7:
   In function 'strncpy',
       inlined from '__assign_req_name' at drivers/nvme/target/trace.h:56:2,
       inlined from 'trace_event_raw_event_nvmet_req_init' at drivers/nvme/target/./trace.h:61:1:
   include/linux/fortify-string.h:50:33: warning: '__builtin_strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      50 | #define __underlying_strncpy    __builtin_strncpy
         |                                 ^
   include/linux/fortify-string.h:61:16: note: in expansion of macro '__underlying_strncpy'
      61 |         return __underlying_strncpy(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/./trace.h: In function 'trace_event_raw_event_nvmet_req_init':
   include/linux/fortify-string.h:48:33: note: length computed here
      48 | #define __underlying_strlen     __builtin_strlen
         |                                 ^
   include/linux/fortify-string.h:104:24: note: in expansion of macro '__underlying_strlen'
     104 |                 return __underlying_strlen(p);
         |                        ^~~~~~~~~~~~~~~~~~~
   In function 'fortify_memcpy_chk',
       inlined from 'trace_event_raw_event_nvmet_req_init' at drivers/nvme/target/./trace.h:61:1:
>> include/linux/fortify-string.h:275:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     275 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'strncpy',
       inlined from '__assign_req_name' at drivers/nvme/target/trace.h:56:2,
       inlined from 'perf_trace_nvmet_req_complete' at drivers/nvme/target/./trace.h:103:1:
   include/linux/fortify-string.h:50:33: warning: '__builtin_strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      50 | #define __underlying_strncpy    __builtin_strncpy
         |                                 ^
   include/linux/fortify-string.h:61:16: note: in expansion of macro '__underlying_strncpy'
      61 |         return __underlying_strncpy(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/./trace.h: In function 'perf_trace_nvmet_req_complete':
   include/linux/fortify-string.h:48:33: note: length computed here
      48 | #define __underlying_strlen     __builtin_strlen
         |                                 ^
   include/linux/fortify-string.h:104:24: note: in expansion of macro '__underlying_strlen'
     104 |                 return __underlying_strlen(p);
         |                        ^~~~~~~~~~~~~~~~~~~
   In function 'strncpy',
       inlined from '__assign_req_name' at drivers/nvme/target/trace.h:56:2,
       inlined from 'perf_trace_nvmet_req_init' at drivers/nvme/target/./trace.h:61:1:
   include/linux/fortify-string.h:50:33: warning: '__builtin_strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      50 | #define __underlying_strncpy    __builtin_strncpy
         |                                 ^
   include/linux/fortify-string.h:61:16: note: in expansion of macro '__underlying_strncpy'
      61 |         return __underlying_strncpy(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/./trace.h: In function 'perf_trace_nvmet_req_init':
   include/linux/fortify-string.h:48:33: note: length computed here
      48 | #define __underlying_strlen     __builtin_strlen
         |                                 ^
   include/linux/fortify-string.h:104:24: note: in expansion of macro '__underlying_strlen'
     104 |                 return __underlying_strlen(p);
         |                        ^~~~~~~~~~~~~~~~~~~
   In function 'fortify_memcpy_chk',
       inlined from 'perf_trace_nvmet_req_init' at drivers/nvme/target/./trace.h:61:1:
>> include/linux/fortify-string.h:275:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     275 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'strncpy',
       inlined from '__assign_req_name' at drivers/nvme/target/trace.h:56:2,
       inlined from 'trace_event_raw_event_nvmet_req_complete' at drivers/nvme/target/./trace.h:103:1:
   include/linux/fortify-string.h:50:33: warning: '__builtin_strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      50 | #define __underlying_strncpy    __builtin_strncpy
         |                                 ^
   include/linux/fortify-string.h:61:16: note: in expansion of macro '__underlying_strncpy'
      61 |         return __underlying_strncpy(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/./trace.h: In function 'trace_event_raw_event_nvmet_req_complete':
   include/linux/fortify-string.h:48:33: note: length computed here
      48 | #define __underlying_strlen     __builtin_strlen
         |                                 ^
   include/linux/fortify-string.h:104:24: note: in expansion of macro '__underlying_strlen'
     104 |                 return __underlying_strlen(p);
         |                        ^~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:3835:5: warning: no previous prototype for 'sienna_cichlid_stb_get_data_direct' [-Wmissing-prototypes]
    3835 | int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from arch/mips/include/asm/processor.h:15,
                    from arch/mips/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/firmware.h:7,
                    from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:26:
   In function 'fortify_memcpy_chk',
       inlined from 'sienna_cichlid_append_powerplay_table' at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:404:2,
       inlined from 'sienna_cichlid_setup_pptable' at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:436:8:
>> include/linux/fortify-string.h:275:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     275 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from arch/mips/include/asm/cpu-type.h:12,
                    from arch/mips/include/asm/timex.h:19,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/netdevice.h:24,
                    from net/mac80211/wpa.c:9:
   In function 'fortify_memcpy_chk',
       inlined from 'bip_aad.isra' at net/mac80211/wpa.c:914:2:
>> include/linux/fortify-string.h:275:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     275 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'fortify_memcpy_chk',
       inlined from 'gcmp_special_blocks.isra' at net/mac80211/wpa.c:599:2:
>> include/linux/fortify-string.h:275:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     275 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'fortify_memcpy_chk',
       inlined from 'ccmp_special_blocks.isra' at net/mac80211/wpa.c:365:2:
>> include/linux/fortify-string.h:275:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     275 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__read_overflow2_field +275 include/linux/fortify-string.h

   213	
   214	/*
   215	 * To make sure the compiler can enforce protection against buffer overflows,
   216	 * memcpy(), memmove(), and memset() must not be used beyond individual
   217	 * struct members. If you need to copy across multiple members, please use
   218	 * struct_group() to create a named mirror of an anonymous struct union.
   219	 * (e.g. see struct sk_buff.)
   220	 *
   221	 * Mitigation coverage
   222	 *					Bounds checking at:
   223	 *					+-------+-------+-------+-------+
   224	 *					| Compile time  | Run time      |
   225	 * memcpy() argument sizes:		| write | read  | write | read  |
   226	 *					+-------+-------+-------+-------+
   227	 * memcpy(known,   known,   constant)	|   y   |   y   |  n/a  |  n/a  |
   228	 * memcpy(unknown, known,   constant)	|   n   |   y   |   V   |  n/a  |
   229	 * memcpy(known,   unknown, constant)	|   y   |   n   |  n/a  |   V   |
   230	 * memcpy(unknown, unknown, constant)	|   n   |   n   |   V   |   V   |
   231	 * memcpy(known,   known,   dynamic)	|   n   |   n   |   b   |   B   |
   232	 * memcpy(unknown, known,   dynamic)	|   n   |   n   |   V   |   B   |
   233	 * memcpy(known,   unknown, dynamic)	|   n   |   n   |   b   |   V   |
   234	 * memcpy(unknown, unknown, dynamic)	|   n   |   n   |   V   |   V   |
   235	 *					+-------+-------+-------+-------+
   236	 *
   237	 * y = deterministic compile-time bounds checking
   238	 * n = cannot do deterministic compile-time bounds checking
   239	 * n/a = no run-time bounds checking needed since compile-time deterministic
   240	 * b = perform run-time bounds checking
   241	 * B = can perform run-time bounds checking, but current unenforced
   242	 * V = vulnerable to run-time overflow
   243	 *
   244	 */
   245	__FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
   246						 const size_t p_size,
   247						 const size_t q_size,
   248						 const size_t p_size_field,
   249						 const size_t q_size_field,
   250						 const char *func)
   251	{
   252		if (__builtin_constant_p(size)) {
   253			/*
   254			 * Length argument is a constant expression, so we
   255			 * can perform compile-time bounds checking where
   256			 * buffer sizes are known.
   257			 */
   258	
   259			/* Error when size is larger than enclosing struct. */
   260			if (p_size > p_size_field && p_size < size)
   261				__write_overflow();
   262			if (q_size > q_size_field && q_size < size)
   263				__read_overflow2();
   264	
   265			/* Warn when write size argument larger than dest field. */
   266			if (p_size_field < size)
   267				__write_overflow_field(p_size_field, size);
   268			/*
   269			 * Warn for source field over-read when building with W=1
   270			 * or when an over-write happened, so both can be fixed at
   271			 * the same time.
   272			 */
   273			if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
   274			    q_size_field < size)
 > 275				__read_overflow2_field(q_size_field, size);
   276		}
   277		/*
   278		 * At this point, length argument may not be a constant expression,
   279		 * so run-time bounds checking can be done where buffer sizes are
   280		 * known. (This is not an "else" because the above checks may only
   281		 * be compile-time warnings, and we want to still warn for run-time
   282		 * overflows.)
   283		 */
   284	
   285		/*
   286		 * Always stop accesses beyond the struct that contains the
   287		 * field, when the buffer's remaining size is known.
   288		 * (The -1 test is to optimize away checks where the buffer
   289		 * lengths are unknown.)
   290		 */
   291		if ((p_size != (size_t)(-1) && p_size < size) ||
   292		    (q_size != (size_t)(-1) && q_size < size))
   293			fortify_panic(func);
   294	}
   295	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
