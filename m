Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA9E46FBED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhLJHog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:44:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:38667 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhLJHof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639122060; x=1670658060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jSg26lMiD/ylbUgJeCpAwqMB9yxZJJLzx0NBFo+0ihA=;
  b=AQLqF/a5XA8kphqUKdZNiOq21i3oXdolD8XOIEzgM+bjsatAOU2+aDJL
   DRE6bxKDu9N41RghfZr+ZdHQTNIoyblZjFwzpUSx0ohhXnkG3LkHqzxsk
   ZSdYTO6gEU+/hjKT7batgX0ug8ld1LPZUprYPDjW5rkStFJhFZMF8u7du
   BoEQCrx0Sxxe2Q6YmUWDbF4eMLB4zOvZCfutnYMT+o/xJKFg/ocuSzZd2
   W1a6MX/KGEVBqQsWh5TSfwa91bMI/TPHGs3fSgVJ18jmxT4TK9+7DZSni
   AbVutQsG6GtXmXZ4j3h8cYVZY4ihVaHkhksaZMI7cX10hOrwu4J6s1Rf/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="262405915"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="262405915"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 23:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="463579639"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2021 23:40:58 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvaWX-0002ux-2w; Fri, 10 Dec 2021 07:40:57 +0000
Date:   Fri, 10 Dec 2021 15:40:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless()
 warn: inconsistent indenting
Message-ID: <202112101559.gQTLUnTO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c741e49150dbb0c0aebe234389f4aa8b47958fa8
commit: a18b14d8886614b3c7d290c4cfc33389822b0535 riscv: Disable STACKPROTECTOR_PER_TASK if GCC_PLUGIN_RANDSTRUCT is enabled
date:   4 months ago
config: riscv-randconfig-m031-20211210 (https://download.01.org/0day-ci/archive/20211210/202112101559.gQTLUnTO-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:225 arch_atomic64_fetch_add_unless() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:225 arch_atomic64_fetch_add_unless() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:225 arch_atomic64_fetch_add_unless() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:317 arch_atomic_sub_if_positive() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:225 arch_atomic64_fetch_add_unless() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless() warn: inconsistent indenting
drivers/crypto/cavium/cpt/cptpf_mbox.c:31 cpt_clear_mbox_intr() warn: should '1 << vf' be a 64 bit type?
sound/soc/rockchip/rockchip_i2s.c:690 rockchip_i2s_probe() warn: 'i2s->hclk' not released on lines: 618,623,630.
sound/soc/stm/stm32_sai_sub.c:503 stm32_sai_isr() error: uninitialized symbol 'sr'.
sound/soc/stm/stm32_sai_sub.c:503 stm32_sai_isr() error: uninitialized symbol 'imr'.
sound/soc/stm/stm32_sai_sub.c:790 stm32_sai_startup() error: uninitialized symbol 'cr2'.
sound/soc/stm/stm32_sai_sub.c:869 stm32_sai_set_slots() error: uninitialized symbol 'slotr'.
drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:1295 create_engine_group() error: we previously assumed 'mirrored_eng_grp' could be null (see line 1251)
drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:1348 ucode_load_store() warn: variable dereferenced before check 'val' (see line 1341)
drivers/video/fbdev/riva/riva_hw.c:1823 SetStartAddress3() warn: inconsistent indenting
sound/soc/qcom/qdsp6/q6afe.c:1001 q6afe_set_param() warn: is 'p' large enough for 'struct apr_pkt'? 0
arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless() warn: inconsistent indenting
arch/riscv/kernel/signal.c:42 restore_fp_state() warn: maybe return -EFAULT instead of the bytes remaining?
arch/riscv/kernel/signal.c:70 save_fp_state() warn: maybe return -EFAULT instead of the bytes remaining?
drivers/net/wireless/ath/wcn36xx/main.c:574 wcn36xx_set_key() error: we previously assumed 'sta' could be null (see line 516)
drivers/net/wireless/ath/wcn36xx/smd.c:515 wcn36xx_smd_load_nv() error: we previously assumed 'wcn->nv' could be null (see line 506)
drivers/net/wireless/ath/wcn36xx/smd.c:1898 wcn36xx_smd_send_beacon() warn: potential spectre issue 'msg_body.beacon' [w]
drivers/net/wireless/ath/wcn36xx/smd.c:2910 wcn36xx_smd_gtk_offload_get_info_rsp() warn: inconsistent indenting
drivers/net/usb/hso.c:1399 hso_serial_set_termios() error: we previously assumed 'old' could be null (see line 1389)
arch/riscv/kernel/perf_event.c:160 riscv_map_cache_event() warn: inconsistent indenting
drivers/net/wireless/ath/ath10k/ahb.c:92 ath10k_ahb_clock_init() warn: passing zero to 'PTR_ERR'
lib/test_kasan.c:174 kmalloc_pagealloc_oob_right() error: buffer overflow 'ptr' 8202 <= 8202
arch/riscv/include/asm/atomic.h:339 arch_atomic64_sub_if_positive() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:317 arch_atomic_sub_if_positive() warn: inconsistent indenting

Old smatch warnings:
drivers/net/wireless/ath/ath11k/wmi.c:6146 ath11k_mgmt_rx_event() warn: 'rx_ev.snr + -95' 4294967201 can't fit into 127 'status->signal'
sound/soc/stm/stm32_sai_sub.c:1503 stm32_sai_sub_parse_of() warn: 'sai->pdata->pclk' not released on lines: 1498.
drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:1363 ucode_load_store() warn: variable dereferenced before check 'val' (see line 1341)
drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:1375 ucode_load_store() warn: variable dereferenced before check 'val' (see line 1341)
drivers/video/fbdev/riva/riva_hw.c:979 nv10CalcArbitration() warn: inconsistent indenting
drivers/video/fbdev/riva/riva_hw.c:1825 SetStartAddress3() warn: inconsistent indenting
sound/soc/qcom/qdsp6/q6afe.c:1055 q6afe_port_set_param_v2() warn: is 'p' large enough for 'struct apr_pkt'? 0
arch/riscv/kernel/signal.c:95 restore_sigcontext() warn: maybe return -EFAULT instead of the bytes remaining?
arch/riscv/kernel/signal.c:148 setup_sigcontext() warn: maybe return -EFAULT instead of the bytes remaining?
drivers/net/wireless/ath/ath10k/ahb.c:99 ath10k_ahb_clock_init() warn: passing zero to 'PTR_ERR'
drivers/net/wireless/ath/ath10k/ahb.c:106 ath10k_ahb_clock_init() warn: passing zero to 'PTR_ERR'
lib/test_kasan.c:130 kmalloc_oob_right() error: buffer overflow 'ptr' 123 <= 123
lib/test_kasan.c:154 kmalloc_node_oob_right() error: buffer overflow 'ptr' 4096 <= 4096
lib/test_kasan.c:281 krealloc_more_oob_helper() warn: potentially one past the end of array 'ptr2[size2]'
lib/test_kasan.c:281 krealloc_more_oob_helper() warn: potentially one past the end of array 'ptr2[size2]'
lib/test_kasan.c:310 krealloc_less_oob_helper() warn: potentially one past the end of array 'ptr2[size2]'
lib/test_kasan.c:310 krealloc_less_oob_helper() warn: potentially one past the end of array 'ptr2[size2]'
lib/test_kasan.c:324 krealloc_less_oob_helper() warn: potentially one past the end of array 'ptr2[middle]'
lib/test_kasan.c:324 krealloc_less_oob_helper() warn: potentially one past the end of array 'ptr2[middle]'
lib/test_kasan.c:373 krealloc_uaf() warn: passing freed memory 'ptr1'
lib/test_kasan.c:411 kmalloc_uaf_16() error: dereferencing freed memory 'ptr2'
lib/test_kasan.c:513 kmalloc_uaf_memset() warn: passing freed memory 'ptr'
lib/test_kasan.c:665 kasan_global_oob() error: buffer overflow 'array' 10 <= 13
lib/test_kasan.c:684 ksize_unpoisons_memory() error: buffer overflow 'ptr' 123 <= 123
lib/test_kasan.c:705 ksize_uaf() warn: passing freed memory 'ptr'
lib/test_kasan.c:769 kmem_cache_double_free() error: double free of 'p'
lib/test_kasan.c:844 kasan_memcmp() error: memcmp() 'ptr' too small (24 vs 25)

vim +204 arch/riscv/include/asm/atomic.h

fab957c11efe2f Palmer Dabbelt 2017-07-10  198  
5ce6c1f3535fa8 Andrea Parri   2018-03-09  199  /* This is required to provide a full barrier on success. */
9efbb355831014 Mark Rutland   2021-05-25  200  static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
fab957c11efe2f Palmer Dabbelt 2017-07-10  201  {
fab957c11efe2f Palmer Dabbelt 2017-07-10  202         int prev, rc;
fab957c11efe2f Palmer Dabbelt 2017-07-10  203  
fab957c11efe2f Palmer Dabbelt 2017-07-10 @204  	__asm__ __volatile__ (
5ce6c1f3535fa8 Andrea Parri   2018-03-09  205  		"0:	lr.w     %[p],  %[c]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  206  		"	beq      %[p],  %[u], 1f\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  207  		"	add      %[rc], %[p], %[a]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  208  		"	sc.w.rl  %[rc], %[rc], %[c]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  209  		"	bnez     %[rc], 0b\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  210  		"	fence    rw, rw\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  211  		"1:\n"
fab957c11efe2f Palmer Dabbelt 2017-07-10  212  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
fab957c11efe2f Palmer Dabbelt 2017-07-10  213  		: [a]"r" (a), [u]"r" (u)
fab957c11efe2f Palmer Dabbelt 2017-07-10  214  		: "memory");
fab957c11efe2f Palmer Dabbelt 2017-07-10  215  	return prev;
fab957c11efe2f Palmer Dabbelt 2017-07-10  216  }
9efbb355831014 Mark Rutland   2021-05-25  217  #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
fab957c11efe2f Palmer Dabbelt 2017-07-10  218  
fab957c11efe2f Palmer Dabbelt 2017-07-10  219  #ifndef CONFIG_GENERIC_ATOMIC64
9efbb355831014 Mark Rutland   2021-05-25  220  static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
fab957c11efe2f Palmer Dabbelt 2017-07-10  221  {
0754211847d7a2 Mark Rutland   2019-05-22  222         s64 prev;
0754211847d7a2 Mark Rutland   2019-05-22  223         long rc;
fab957c11efe2f Palmer Dabbelt 2017-07-10  224  
fab957c11efe2f Palmer Dabbelt 2017-07-10 @225  	__asm__ __volatile__ (
5ce6c1f3535fa8 Andrea Parri   2018-03-09  226  		"0:	lr.d     %[p],  %[c]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  227  		"	beq      %[p],  %[u], 1f\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  228  		"	add      %[rc], %[p], %[a]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  229  		"	sc.d.rl  %[rc], %[rc], %[c]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  230  		"	bnez     %[rc], 0b\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  231  		"	fence    rw, rw\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  232  		"1:\n"
fab957c11efe2f Palmer Dabbelt 2017-07-10  233  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
fab957c11efe2f Palmer Dabbelt 2017-07-10  234  		: [a]"r" (a), [u]"r" (u)
fab957c11efe2f Palmer Dabbelt 2017-07-10  235  		: "memory");
fab957c11efe2f Palmer Dabbelt 2017-07-10  236  	return prev;
fab957c11efe2f Palmer Dabbelt 2017-07-10  237  }
9efbb355831014 Mark Rutland   2021-05-25  238  #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
fab957c11efe2f Palmer Dabbelt 2017-07-10  239  #endif
fab957c11efe2f Palmer Dabbelt 2017-07-10  240  
fab957c11efe2f Palmer Dabbelt 2017-07-10  241  /*
fab957c11efe2f Palmer Dabbelt 2017-07-10  242   * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
5ce6c1f3535fa8 Andrea Parri   2018-03-09  243   * {cmp,}xchg and the operations that return, so they need a full barrier.
fab957c11efe2f Palmer Dabbelt 2017-07-10  244   */
5ce6c1f3535fa8 Andrea Parri   2018-03-09  245  #define ATOMIC_OP(c_t, prefix, size)					\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  246  static __always_inline							\
9efbb355831014 Mark Rutland   2021-05-25  247  c_t arch_atomic##prefix##_xchg_relaxed(atomic##prefix##_t *v, c_t n)	\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  248  {									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  249  	return __xchg_relaxed(&(v->counter), n, size);			\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  250  }									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  251  static __always_inline							\
9efbb355831014 Mark Rutland   2021-05-25  252  c_t arch_atomic##prefix##_xchg_acquire(atomic##prefix##_t *v, c_t n)	\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  253  {									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  254  	return __xchg_acquire(&(v->counter), n, size);			\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  255  }									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  256  static __always_inline							\
9efbb355831014 Mark Rutland   2021-05-25  257  c_t arch_atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)	\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  258  {									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  259  	return __xchg_release(&(v->counter), n, size);			\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  260  }									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  261  static __always_inline							\
9efbb355831014 Mark Rutland   2021-05-25  262  c_t arch_atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)		\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  263  {									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  264  	return __xchg(&(v->counter), n, size);				\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  265  }									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  266  static __always_inline							\
9efbb355831014 Mark Rutland   2021-05-25  267  c_t arch_atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,	\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  268  				     c_t o, c_t n)			\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  269  {									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  270  	return __cmpxchg_relaxed(&(v->counter), o, n, size);		\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  271  }									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  272  static __always_inline							\
9efbb355831014 Mark Rutland   2021-05-25  273  c_t arch_atomic##prefix##_cmpxchg_acquire(atomic##prefix##_t *v,	\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  274  				     c_t o, c_t n)			\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  275  {									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  276  	return __cmpxchg_acquire(&(v->counter), o, n, size);		\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  277  }									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  278  static __always_inline							\
9efbb355831014 Mark Rutland   2021-05-25  279  c_t arch_atomic##prefix##_cmpxchg_release(atomic##prefix##_t *v,	\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  280  				     c_t o, c_t n)			\
fab957c11efe2f Palmer Dabbelt 2017-07-10  281  {									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  282  	return __cmpxchg_release(&(v->counter), o, n, size);		\
fab957c11efe2f Palmer Dabbelt 2017-07-10  283  }									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  284  static __always_inline							\
9efbb355831014 Mark Rutland   2021-05-25  285  c_t arch_atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
fab957c11efe2f Palmer Dabbelt 2017-07-10  286  {									\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  287  	return __cmpxchg(&(v->counter), o, n, size);			\
fab957c11efe2f Palmer Dabbelt 2017-07-10  288  }
fab957c11efe2f Palmer Dabbelt 2017-07-10  289  
fab957c11efe2f Palmer Dabbelt 2017-07-10  290  #ifdef CONFIG_GENERIC_ATOMIC64
5ce6c1f3535fa8 Andrea Parri   2018-03-09  291  #define ATOMIC_OPS()							\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  292  	ATOMIC_OP(int,   , 4)
fab957c11efe2f Palmer Dabbelt 2017-07-10  293  #else
5ce6c1f3535fa8 Andrea Parri   2018-03-09  294  #define ATOMIC_OPS()							\
5ce6c1f3535fa8 Andrea Parri   2018-03-09  295  	ATOMIC_OP(int,   , 4)						\
0754211847d7a2 Mark Rutland   2019-05-22  296  	ATOMIC_OP(s64, 64, 8)
fab957c11efe2f Palmer Dabbelt 2017-07-10  297  #endif
fab957c11efe2f Palmer Dabbelt 2017-07-10  298  
5ce6c1f3535fa8 Andrea Parri   2018-03-09  299  ATOMIC_OPS()
fab957c11efe2f Palmer Dabbelt 2017-07-10  300  
9efbb355831014 Mark Rutland   2021-05-25  301  #define arch_atomic_xchg_relaxed	arch_atomic_xchg_relaxed
9efbb355831014 Mark Rutland   2021-05-25  302  #define arch_atomic_xchg_acquire	arch_atomic_xchg_acquire
9efbb355831014 Mark Rutland   2021-05-25  303  #define arch_atomic_xchg_release	arch_atomic_xchg_release
9efbb355831014 Mark Rutland   2021-05-25  304  #define arch_atomic_xchg		arch_atomic_xchg
9efbb355831014 Mark Rutland   2021-05-25  305  #define arch_atomic_cmpxchg_relaxed	arch_atomic_cmpxchg_relaxed
9efbb355831014 Mark Rutland   2021-05-25  306  #define arch_atomic_cmpxchg_acquire	arch_atomic_cmpxchg_acquire
9efbb355831014 Mark Rutland   2021-05-25  307  #define arch_atomic_cmpxchg_release	arch_atomic_cmpxchg_release
9efbb355831014 Mark Rutland   2021-05-25  308  #define arch_atomic_cmpxchg		arch_atomic_cmpxchg
8b699616f399b5 Andrea Parri   2018-12-01  309  
fab957c11efe2f Palmer Dabbelt 2017-07-10  310  #undef ATOMIC_OPS
fab957c11efe2f Palmer Dabbelt 2017-07-10  311  #undef ATOMIC_OP
fab957c11efe2f Palmer Dabbelt 2017-07-10  312  
9efbb355831014 Mark Rutland   2021-05-25  313  static __always_inline int arch_atomic_sub_if_positive(atomic_t *v, int offset)
fab957c11efe2f Palmer Dabbelt 2017-07-10  314  {
fab957c11efe2f Palmer Dabbelt 2017-07-10  315         int prev, rc;
fab957c11efe2f Palmer Dabbelt 2017-07-10  316  
fab957c11efe2f Palmer Dabbelt 2017-07-10 @317  	__asm__ __volatile__ (
5ce6c1f3535fa8 Andrea Parri   2018-03-09  318  		"0:	lr.w     %[p],  %[c]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  319  		"	sub      %[rc], %[p], %[o]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  320  		"	bltz     %[rc], 1f\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  321  		"	sc.w.rl  %[rc], %[rc], %[c]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  322  		"	bnez     %[rc], 0b\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  323  		"	fence    rw, rw\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  324  		"1:\n"
fab957c11efe2f Palmer Dabbelt 2017-07-10  325  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
fab957c11efe2f Palmer Dabbelt 2017-07-10  326  		: [o]"r" (offset)
fab957c11efe2f Palmer Dabbelt 2017-07-10  327  		: "memory");
fab957c11efe2f Palmer Dabbelt 2017-07-10  328  	return prev - offset;
fab957c11efe2f Palmer Dabbelt 2017-07-10  329  }
fab957c11efe2f Palmer Dabbelt 2017-07-10  330  
9efbb355831014 Mark Rutland   2021-05-25  331  #define arch_atomic_dec_if_positive(v)	arch_atomic_sub_if_positive(v, 1)
fab957c11efe2f Palmer Dabbelt 2017-07-10  332  
fab957c11efe2f Palmer Dabbelt 2017-07-10  333  #ifndef CONFIG_GENERIC_ATOMIC64
9efbb355831014 Mark Rutland   2021-05-25  334  static __always_inline s64 arch_atomic64_sub_if_positive(atomic64_t *v, s64 offset)
fab957c11efe2f Palmer Dabbelt 2017-07-10  335  {
0754211847d7a2 Mark Rutland   2019-05-22  336         s64 prev;
0754211847d7a2 Mark Rutland   2019-05-22  337         long rc;
fab957c11efe2f Palmer Dabbelt 2017-07-10  338  
fab957c11efe2f Palmer Dabbelt 2017-07-10 @339  	__asm__ __volatile__ (
5ce6c1f3535fa8 Andrea Parri   2018-03-09  340  		"0:	lr.d     %[p],  %[c]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  341  		"	sub      %[rc], %[p], %[o]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  342  		"	bltz     %[rc], 1f\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  343  		"	sc.d.rl  %[rc], %[rc], %[c]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  344  		"	bnez     %[rc], 0b\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  345  		"	fence    rw, rw\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  346  		"1:\n"
fab957c11efe2f Palmer Dabbelt 2017-07-10  347  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
fab957c11efe2f Palmer Dabbelt 2017-07-10  348  		: [o]"r" (offset)
fab957c11efe2f Palmer Dabbelt 2017-07-10  349  		: "memory");
fab957c11efe2f Palmer Dabbelt 2017-07-10  350  	return prev - offset;
fab957c11efe2f Palmer Dabbelt 2017-07-10  351  }
fab957c11efe2f Palmer Dabbelt 2017-07-10  352  

:::::: The code at line 204 was first introduced by commit
:::::: fab957c11efe2f405e08b9f0d080524bc2631428 RISC-V: Atomic and Locking Code

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@dabbelt.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
