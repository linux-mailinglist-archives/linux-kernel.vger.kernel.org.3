Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206D7595A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiHPLmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiHPLmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:42:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FDA644E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660648316; x=1692184316;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LQs6BuDub4D74+xuZc/7OFqZ9mtwzh8I5LriMmsETD0=;
  b=TjGF6CIqllmlI7An5G11BNNlLqo+mUPiOH88pH8hcjeohCTSYnU3nIhS
   w5nAk2dEX1+r9bQddxbtsBAjZ2qGJgR0ynBtD9mnFXx0DHsTsOYGrqxvf
   WFzzIncATQE24wKj6z0sapP3Z0wV6AkDuFyhwj8uWZwqkcRlomNjFFJi6
   F9c7o3kvNsbdzH4Y3lY7NtnuP5lSTd+rp4ZAN9ykp1PVhnWNtiWdIT/Xc
   tDHtLgMt1vHOBNVAVct3ziJLgbZmFiKctbjaDB/Iq8DWvHMKUfjhln6op
   4KEqT1eJnH8HIij3P2mp9Bp03yZyrpg8YgFzq00v5bmQ256cpWwBhHuan
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292188277"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="292188277"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="934865453"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2022 04:11:53 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNuUD-0001ip-0H;
        Tue, 16 Aug 2022 11:11:53 +0000
Date:   Tue, 16 Aug 2022 19:11:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 58/59]
 arch/x86/net/bpf_jit_comp.c:2103:47: error: '__fentry__' undeclared; did you
 mean 'fentry'?
Message-ID: <202208161936.uyt6ETT9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   9bbf33b92f4c755dd56f4d9bc1b40e94fdd1fff7
commit: 5f5bcd6ccea80ee1fa71477dbf80d43d9cbbf30a [58/59] x86/ftrace: Make it call depth tracking aware
config: x86_64-randconfig-a005-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161936.uyt6ETT9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/5f5bcd6ccea80ee1fa71477dbf80d43d9cbbf30a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout 5f5bcd6ccea80ee1fa71477dbf80d43d9cbbf30a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/net/bpf_jit_comp.c: In function 'arch_prepare_bpf_trampoline':
>> arch/x86/net/bpf_jit_comp.c:2103:47: error: '__fentry__' undeclared (first use in this function); did you mean 'fentry'?
    2103 |         x86_call_depth_emit_accounting(&prog, __fentry__);
         |                                               ^~~~~~~~~~
         |                                               fentry
   arch/x86/net/bpf_jit_comp.c:2103:47: note: each undeclared identifier is reported only once for each function it appears in


vim +2103 arch/x86/net/bpf_jit_comp.c

  1970	
  1971	/* Example:
  1972	 * __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
  1973	 * its 'struct btf_func_model' will be nr_args=2
  1974	 * The assembly code when eth_type_trans is executing after trampoline:
  1975	 *
  1976	 * push rbp
  1977	 * mov rbp, rsp
  1978	 * sub rsp, 16                     // space for skb and dev
  1979	 * push rbx                        // temp regs to pass start time
  1980	 * mov qword ptr [rbp - 16], rdi   // save skb pointer to stack
  1981	 * mov qword ptr [rbp - 8], rsi    // save dev pointer to stack
  1982	 * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
  1983	 * mov rbx, rax                    // remember start time in bpf stats are enabled
  1984	 * lea rdi, [rbp - 16]             // R1==ctx of bpf prog
  1985	 * call addr_of_jited_FENTRY_prog
  1986	 * movabsq rdi, 64bit_addr_of_struct_bpf_prog  // unused if bpf stats are off
  1987	 * mov rsi, rbx                    // prog start time
  1988	 * call __bpf_prog_exit            // rcu_read_unlock, preempt_enable and stats math
  1989	 * mov rdi, qword ptr [rbp - 16]   // restore skb pointer from stack
  1990	 * mov rsi, qword ptr [rbp - 8]    // restore dev pointer from stack
  1991	 * pop rbx
  1992	 * leave
  1993	 * ret
  1994	 *
  1995	 * eth_type_trans has 5 byte nop at the beginning. These 5 bytes will be
  1996	 * replaced with 'call generated_bpf_trampoline'. When it returns
  1997	 * eth_type_trans will continue executing with original skb and dev pointers.
  1998	 *
  1999	 * The assembly code when eth_type_trans is called from trampoline:
  2000	 *
  2001	 * push rbp
  2002	 * mov rbp, rsp
  2003	 * sub rsp, 24                     // space for skb, dev, return value
  2004	 * push rbx                        // temp regs to pass start time
  2005	 * mov qword ptr [rbp - 24], rdi   // save skb pointer to stack
  2006	 * mov qword ptr [rbp - 16], rsi   // save dev pointer to stack
  2007	 * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
  2008	 * mov rbx, rax                    // remember start time if bpf stats are enabled
  2009	 * lea rdi, [rbp - 24]             // R1==ctx of bpf prog
  2010	 * call addr_of_jited_FENTRY_prog  // bpf prog can access skb and dev
  2011	 * movabsq rdi, 64bit_addr_of_struct_bpf_prog  // unused if bpf stats are off
  2012	 * mov rsi, rbx                    // prog start time
  2013	 * call __bpf_prog_exit            // rcu_read_unlock, preempt_enable and stats math
  2014	 * mov rdi, qword ptr [rbp - 24]   // restore skb pointer from stack
  2015	 * mov rsi, qword ptr [rbp - 16]   // restore dev pointer from stack
  2016	 * call eth_type_trans+5           // execute body of eth_type_trans
  2017	 * mov qword ptr [rbp - 8], rax    // save return value
  2018	 * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
  2019	 * mov rbx, rax                    // remember start time in bpf stats are enabled
  2020	 * lea rdi, [rbp - 24]             // R1==ctx of bpf prog
  2021	 * call addr_of_jited_FEXIT_prog   // bpf prog can access skb, dev, return value
  2022	 * movabsq rdi, 64bit_addr_of_struct_bpf_prog  // unused if bpf stats are off
  2023	 * mov rsi, rbx                    // prog start time
  2024	 * call __bpf_prog_exit            // rcu_read_unlock, preempt_enable and stats math
  2025	 * mov rax, qword ptr [rbp - 8]    // restore eth_type_trans's return value
  2026	 * pop rbx
  2027	 * leave
  2028	 * add rsp, 8                      // skip eth_type_trans's frame
  2029	 * ret                             // return to its caller
  2030	 */
  2031	int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
  2032					const struct btf_func_model *m, u32 flags,
  2033					struct bpf_tramp_links *tlinks,
  2034					void *orig_call)
  2035	{
  2036		int ret, i, nr_args = m->nr_args;
  2037		int regs_off, ip_off, args_off, stack_size = nr_args * 8, run_ctx_off;
  2038		struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
  2039		struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
  2040		struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
  2041		u8 **branches = NULL;
  2042		u8 *prog;
  2043		bool save_ret;
  2044	
  2045		/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
  2046		if (nr_args > 6)
  2047			return -ENOTSUPP;
  2048	
  2049		/* Generated trampoline stack layout:
  2050		 *
  2051		 * RBP + 8         [ return address  ]
  2052		 * RBP + 0         [ RBP             ]
  2053		 *
  2054		 * RBP - 8         [ return value    ]  BPF_TRAMP_F_CALL_ORIG or
  2055		 *                                      BPF_TRAMP_F_RET_FENTRY_RET flags
  2056		 *
  2057		 *                 [ reg_argN        ]  always
  2058		 *                 [ ...             ]
  2059		 * RBP - regs_off  [ reg_arg1        ]  program's ctx pointer
  2060		 *
  2061		 * RBP - args_off  [ args count      ]  always
  2062		 *
  2063		 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
  2064		 *
  2065		 * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
  2066		 */
  2067	
  2068		/* room for return value of orig_call or fentry prog */
  2069		save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
  2070		if (save_ret)
  2071			stack_size += 8;
  2072	
  2073		regs_off = stack_size;
  2074	
  2075		/* args count  */
  2076		stack_size += 8;
  2077		args_off = stack_size;
  2078	
  2079		if (flags & BPF_TRAMP_F_IP_ARG)
  2080			stack_size += 8; /* room for IP address argument */
  2081	
  2082		ip_off = stack_size;
  2083	
  2084		stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
  2085		run_ctx_off = stack_size;
  2086	
  2087		if (flags & BPF_TRAMP_F_SKIP_FRAME) {
  2088			/* skip patched call instruction and point orig_call to actual
  2089			 * body of the kernel function.
  2090			 */
  2091			if (is_endbr(*(u32 *)orig_call))
  2092				orig_call += ENDBR_INSN_SIZE;
  2093			orig_call += X86_PATCH_SIZE;
  2094		}
  2095	
  2096		prog = image;
  2097	
  2098		EMIT_ENDBR();
  2099		/*
  2100		 * This is the direct-call trampoline, as such it needs accounting
  2101		 * for the __fentry__ call.
  2102		 */
> 2103		x86_call_depth_emit_accounting(&prog, __fentry__);
  2104		EMIT1(0x55);		 /* push rbp */
  2105		EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
  2106		EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
  2107		EMIT1(0x53);		 /* push rbx */
  2108	
  2109		/* Store number of arguments of the traced function:
  2110		 *   mov rax, nr_args
  2111		 *   mov QWORD PTR [rbp - args_off], rax
  2112		 */
  2113		emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_args);
  2114		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -args_off);
  2115	
  2116		if (flags & BPF_TRAMP_F_IP_ARG) {
  2117			/* Store IP address of the traced function:
  2118			 * mov rax, QWORD PTR [rbp + 8]
  2119			 * sub rax, X86_PATCH_SIZE
  2120			 * mov QWORD PTR [rbp - ip_off], rax
  2121			 */
  2122			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
  2123			EMIT4(0x48, 0x83, 0xe8, X86_PATCH_SIZE);
  2124			emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
  2125		}
  2126	
  2127		save_regs(m, &prog, nr_args, regs_off);
  2128	
  2129		if (flags & BPF_TRAMP_F_CALL_ORIG) {
  2130			/* arg1: mov rdi, im */
  2131			emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
  2132			if (emit_rsb_call(&prog, __bpf_tramp_enter, prog)) {
  2133				ret = -EINVAL;
  2134				goto cleanup;
  2135			}
  2136		}
  2137	
  2138		if (fentry->nr_links)
  2139			if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
  2140				       flags & BPF_TRAMP_F_RET_FENTRY_RET))
  2141				return -EINVAL;
  2142	
  2143		if (fmod_ret->nr_links) {
  2144			branches = kcalloc(fmod_ret->nr_links, sizeof(u8 *),
  2145					   GFP_KERNEL);
  2146			if (!branches)
  2147				return -ENOMEM;
  2148	
  2149			if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
  2150					       run_ctx_off, branches)) {
  2151				ret = -EINVAL;
  2152				goto cleanup;
  2153			}
  2154		}
  2155	
  2156		if (flags & BPF_TRAMP_F_CALL_ORIG) {
  2157			restore_regs(m, &prog, nr_args, regs_off);
  2158	
  2159			if (flags & BPF_TRAMP_F_ORIG_STACK) {
  2160				emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
  2161				EMIT2(0xff, 0xd0); /* call *rax */
  2162			} else {
  2163				/* call original function */
  2164				if (emit_rsb_call(&prog, orig_call, prog)) {
  2165					ret = -EINVAL;
  2166					goto cleanup;
  2167				}
  2168			}
  2169			/* remember return value in a stack for bpf prog to access */
  2170			emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
  2171			im->ip_after_call = prog;
  2172			memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
  2173			prog += X86_PATCH_SIZE;
  2174		}
  2175	
  2176		if (fmod_ret->nr_links) {
  2177			/* From Intel 64 and IA-32 Architectures Optimization
  2178			 * Reference Manual, 3.4.1.4 Code Alignment, Assembly/Compiler
  2179			 * Coding Rule 11: All branch targets should be 16-byte
  2180			 * aligned.
  2181			 */
  2182			emit_align(&prog, 16);
  2183			/* Update the branches saved in invoke_bpf_mod_ret with the
  2184			 * aligned address of do_fexit.
  2185			 */
  2186			for (i = 0; i < fmod_ret->nr_links; i++)
  2187				emit_cond_near_jump(&branches[i], prog, branches[i],
  2188						    X86_JNE);
  2189		}
  2190	
  2191		if (fexit->nr_links)
  2192			if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, false)) {
  2193				ret = -EINVAL;
  2194				goto cleanup;
  2195			}
  2196	
  2197		if (flags & BPF_TRAMP_F_RESTORE_REGS)
  2198			restore_regs(m, &prog, nr_args, regs_off);
  2199	
  2200		/* This needs to be done regardless. If there were fmod_ret programs,
  2201		 * the return value is only updated on the stack and still needs to be
  2202		 * restored to R0.
  2203		 */
  2204		if (flags & BPF_TRAMP_F_CALL_ORIG) {
  2205			im->ip_epilogue = prog;
  2206			/* arg1: mov rdi, im */
  2207			emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
  2208			if (emit_rsb_call(&prog, __bpf_tramp_exit, prog)) {
  2209				ret = -EINVAL;
  2210				goto cleanup;
  2211			}
  2212		}
  2213		/* restore return value of orig_call or fentry prog back into RAX */
  2214		if (save_ret)
  2215			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
  2216	
  2217		EMIT1(0x5B); /* pop rbx */
  2218		EMIT1(0xC9); /* leave */
  2219		if (flags & BPF_TRAMP_F_SKIP_FRAME)
  2220			/* skip our return address and return to parent */
  2221			EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
  2222		emit_return(&prog, prog);
  2223		/* Make sure the trampoline generation logic doesn't overflow */
  2224		if (WARN_ON_ONCE(prog > (u8 *)image_end - BPF_INSN_SAFETY)) {
  2225			ret = -EFAULT;
  2226			goto cleanup;
  2227		}
  2228		ret = prog - (u8 *)image;
  2229	
  2230	cleanup:
  2231		kfree(branches);
  2232		return ret;
  2233	}
  2234	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
