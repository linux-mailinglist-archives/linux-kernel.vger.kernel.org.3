Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ECB57C878
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiGUKCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiGUKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:01:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77E717AA8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658397709; x=1689933709;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ekTFfjFxOEU6SgxvA0IKdqUSzANr20w0q2A4SXC2h60=;
  b=ni1haMjY8cJTITc//D7QYh9IWJ1h94nx+rvat2yJeSyNagpvT3TSl6sD
   yoWI8s3rSejUfEsXIZ0vkzHXJknjB+9QZz57mWchg1lUA4mgrtT2qqdhD
   +D5vJkIjmauSHYj2W53YxjrBcGCFzPzClan6MQWs0ysG+x0wYjTyphqfg
   cQDyRmujDrn27wE7ROv1MoZ4UxAasSN/9PRBkio3mcX0mGvPA8tDIooJL
   IxjS8sdK1p6Rxxkd2cdmr/l0+x4HxZd+I1rY6rZV/6zwOANwg15tXAW0a
   hVWMxmSvJz01SKV/flx7x/w5D04KnGwI0oq38UwsxT7mwLT3Hw1rrehVH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="312715719"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="312715719"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 03:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="656675724"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2022 03:01:47 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oET06-0001ht-Ur;
        Thu, 21 Jul 2022 10:01:46 +0000
Date:   Thu, 21 Jul 2022 18:00:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 40/45]
 arch/x86/net/bpf_jit_comp.c:2101:47: error: '__fentry__' undeclared; did you
 mean 'fentry'?
Message-ID: <202207211816.FZcp0xTY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   714d29e3e7e3faac27142424ae2533163ddd3a46
commit: 535725e29620b0ff196424841bcd944b6866da11 [40/45] x86/ftrace: Make it call depth tracking aware
config: x86_64-randconfig-a014-20220718 (https://download.01.org/0day-ci/archive/20220721/202207211816.FZcp0xTY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/535725e29620b0ff196424841bcd944b6866da11
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout 535725e29620b0ff196424841bcd944b6866da11
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/net/bpf_jit_comp.c: In function 'arch_prepare_bpf_trampoline':
   arch/x86/net/bpf_jit_comp.c:2101:9: error: implicit declaration of function 'x86_call_depth_emit_accounting' [-Werror=implicit-function-declaration]
    2101 |         x86_call_depth_emit_accounting(&prog, __fentry__);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/net/bpf_jit_comp.c:2101:47: error: '__fentry__' undeclared (first use in this function); did you mean 'fentry'?
    2101 |         x86_call_depth_emit_accounting(&prog, __fentry__);
         |                                               ^~~~~~~~~~
         |                                               fentry
   arch/x86/net/bpf_jit_comp.c:2101:47: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +2101 arch/x86/net/bpf_jit_comp.c

  1965	
  1966	/* Example:
  1967	 * __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
  1968	 * its 'struct btf_func_model' will be nr_args=2
  1969	 * The assembly code when eth_type_trans is executing after trampoline:
  1970	 *
  1971	 * push rbp
  1972	 * mov rbp, rsp
  1973	 * sub rsp, 16                     // space for skb and dev
  1974	 * push rbx                        // temp regs to pass start time
  1975	 * mov qword ptr [rbp - 16], rdi   // save skb pointer to stack
  1976	 * mov qword ptr [rbp - 8], rsi    // save dev pointer to stack
  1977	 * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
  1978	 * mov rbx, rax                    // remember start time in bpf stats are enabled
  1979	 * lea rdi, [rbp - 16]             // R1==ctx of bpf prog
  1980	 * call addr_of_jited_FENTRY_prog
  1981	 * movabsq rdi, 64bit_addr_of_struct_bpf_prog  // unused if bpf stats are off
  1982	 * mov rsi, rbx                    // prog start time
  1983	 * call __bpf_prog_exit            // rcu_read_unlock, preempt_enable and stats math
  1984	 * mov rdi, qword ptr [rbp - 16]   // restore skb pointer from stack
  1985	 * mov rsi, qword ptr [rbp - 8]    // restore dev pointer from stack
  1986	 * pop rbx
  1987	 * leave
  1988	 * ret
  1989	 *
  1990	 * eth_type_trans has 5 byte nop at the beginning. These 5 bytes will be
  1991	 * replaced with 'call generated_bpf_trampoline'. When it returns
  1992	 * eth_type_trans will continue executing with original skb and dev pointers.
  1993	 *
  1994	 * The assembly code when eth_type_trans is called from trampoline:
  1995	 *
  1996	 * push rbp
  1997	 * mov rbp, rsp
  1998	 * sub rsp, 24                     // space for skb, dev, return value
  1999	 * push rbx                        // temp regs to pass start time
  2000	 * mov qword ptr [rbp - 24], rdi   // save skb pointer to stack
  2001	 * mov qword ptr [rbp - 16], rsi   // save dev pointer to stack
  2002	 * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
  2003	 * mov rbx, rax                    // remember start time if bpf stats are enabled
  2004	 * lea rdi, [rbp - 24]             // R1==ctx of bpf prog
  2005	 * call addr_of_jited_FENTRY_prog  // bpf prog can access skb and dev
  2006	 * movabsq rdi, 64bit_addr_of_struct_bpf_prog  // unused if bpf stats are off
  2007	 * mov rsi, rbx                    // prog start time
  2008	 * call __bpf_prog_exit            // rcu_read_unlock, preempt_enable and stats math
  2009	 * mov rdi, qword ptr [rbp - 24]   // restore skb pointer from stack
  2010	 * mov rsi, qword ptr [rbp - 16]   // restore dev pointer from stack
  2011	 * call eth_type_trans+5           // execute body of eth_type_trans
  2012	 * mov qword ptr [rbp - 8], rax    // save return value
  2013	 * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
  2014	 * mov rbx, rax                    // remember start time in bpf stats are enabled
  2015	 * lea rdi, [rbp - 24]             // R1==ctx of bpf prog
  2016	 * call addr_of_jited_FEXIT_prog   // bpf prog can access skb, dev, return value
  2017	 * movabsq rdi, 64bit_addr_of_struct_bpf_prog  // unused if bpf stats are off
  2018	 * mov rsi, rbx                    // prog start time
  2019	 * call __bpf_prog_exit            // rcu_read_unlock, preempt_enable and stats math
  2020	 * mov rax, qword ptr [rbp - 8]    // restore eth_type_trans's return value
  2021	 * pop rbx
  2022	 * leave
  2023	 * add rsp, 8                      // skip eth_type_trans's frame
  2024	 * ret                             // return to its caller
  2025	 */
  2026	int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
  2027					const struct btf_func_model *m, u32 flags,
  2028					struct bpf_tramp_links *tlinks,
  2029					void *orig_call)
  2030	{
  2031		int ret, i, nr_args = m->nr_args;
  2032		int regs_off, ip_off, args_off, stack_size = nr_args * 8, run_ctx_off;
  2033		struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
  2034		struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
  2035		struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
  2036		u8 **branches = NULL;
  2037		u8 *prog;
  2038		bool save_ret;
  2039	
  2040		/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
  2041		if (nr_args > 6)
  2042			return -ENOTSUPP;
  2043	
  2044		if (!is_valid_bpf_tramp_flags(flags))
  2045			return -EINVAL;
  2046	
  2047		/* Generated trampoline stack layout:
  2048		 *
  2049		 * RBP + 8         [ return address  ]
  2050		 * RBP + 0         [ RBP             ]
  2051		 *
  2052		 * RBP - 8         [ return value    ]  BPF_TRAMP_F_CALL_ORIG or
  2053		 *                                      BPF_TRAMP_F_RET_FENTRY_RET flags
  2054		 *
  2055		 *                 [ reg_argN        ]  always
  2056		 *                 [ ...             ]
  2057		 * RBP - regs_off  [ reg_arg1        ]  program's ctx pointer
  2058		 *
  2059		 * RBP - args_off  [ args count      ]  always
  2060		 *
  2061		 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
  2062		 *
  2063		 * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
  2064		 */
  2065	
  2066		/* room for return value of orig_call or fentry prog */
  2067		save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
  2068		if (save_ret)
  2069			stack_size += 8;
  2070	
  2071		regs_off = stack_size;
  2072	
  2073		/* args count  */
  2074		stack_size += 8;
  2075		args_off = stack_size;
  2076	
  2077		if (flags & BPF_TRAMP_F_IP_ARG)
  2078			stack_size += 8; /* room for IP address argument */
  2079	
  2080		ip_off = stack_size;
  2081	
  2082		stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
  2083		run_ctx_off = stack_size;
  2084	
  2085		if (flags & BPF_TRAMP_F_SKIP_FRAME) {
  2086			/* skip patched call instruction and point orig_call to actual
  2087			 * body of the kernel function.
  2088			 */
  2089			if (is_endbr(*(u32 *)orig_call))
  2090				orig_call += ENDBR_INSN_SIZE;
  2091			orig_call += X86_PATCH_SIZE;
  2092		}
  2093	
  2094		prog = image;
  2095	
  2096		EMIT_ENDBR();
  2097		/*
  2098		 * This is the direct-call trampoline, as such it needs accounting
  2099		 * for the __fentry__ call.
  2100		 */
> 2101		x86_call_depth_emit_accounting(&prog, __fentry__);
  2102		EMIT1(0x55);		 /* push rbp */
  2103		EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
  2104		EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
  2105		EMIT1(0x53);		 /* push rbx */
  2106	
  2107		/* Store number of arguments of the traced function:
  2108		 *   mov rax, nr_args
  2109		 *   mov QWORD PTR [rbp - args_off], rax
  2110		 */
  2111		emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_args);
  2112		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -args_off);
  2113	
  2114		if (flags & BPF_TRAMP_F_IP_ARG) {
  2115			/* Store IP address of the traced function:
  2116			 * mov rax, QWORD PTR [rbp + 8]
  2117			 * sub rax, X86_PATCH_SIZE
  2118			 * mov QWORD PTR [rbp - ip_off], rax
  2119			 */
  2120			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
  2121			EMIT4(0x48, 0x83, 0xe8, X86_PATCH_SIZE);
  2122			emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
  2123		}
  2124	
  2125		save_regs(m, &prog, nr_args, regs_off);
  2126	
  2127		if (flags & BPF_TRAMP_F_CALL_ORIG) {
  2128			/* arg1: mov rdi, im */
  2129			emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
  2130			if (emit_call(&prog, __bpf_tramp_enter, prog)) {
  2131				ret = -EINVAL;
  2132				goto cleanup;
  2133			}
  2134		}
  2135	
  2136		if (fentry->nr_links)
  2137			if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
  2138				       flags & BPF_TRAMP_F_RET_FENTRY_RET))
  2139				return -EINVAL;
  2140	
  2141		if (fmod_ret->nr_links) {
  2142			branches = kcalloc(fmod_ret->nr_links, sizeof(u8 *),
  2143					   GFP_KERNEL);
  2144			if (!branches)
  2145				return -ENOMEM;
  2146	
  2147			if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
  2148					       run_ctx_off, branches)) {
  2149				ret = -EINVAL;
  2150				goto cleanup;
  2151			}
  2152		}
  2153	
  2154		if (flags & BPF_TRAMP_F_CALL_ORIG) {
  2155			restore_regs(m, &prog, nr_args, regs_off);
  2156	
  2157			/* call original function */
  2158			if (emit_call(&prog, orig_call, prog)) {
  2159				ret = -EINVAL;
  2160				goto cleanup;
  2161			}
  2162			/* remember return value in a stack for bpf prog to access */
  2163			emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
  2164			im->ip_after_call = prog;
  2165			memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
  2166			prog += X86_PATCH_SIZE;
  2167		}
  2168	
  2169		if (fmod_ret->nr_links) {
  2170			/* From Intel 64 and IA-32 Architectures Optimization
  2171			 * Reference Manual, 3.4.1.4 Code Alignment, Assembly/Compiler
  2172			 * Coding Rule 11: All branch targets should be 16-byte
  2173			 * aligned.
  2174			 */
  2175			emit_align(&prog, 16);
  2176			/* Update the branches saved in invoke_bpf_mod_ret with the
  2177			 * aligned address of do_fexit.
  2178			 */
  2179			for (i = 0; i < fmod_ret->nr_links; i++)
  2180				emit_cond_near_jump(&branches[i], prog, branches[i],
  2181						    X86_JNE);
  2182		}
  2183	
  2184		if (fexit->nr_links)
  2185			if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, false)) {
  2186				ret = -EINVAL;
  2187				goto cleanup;
  2188			}
  2189	
  2190		if (flags & BPF_TRAMP_F_RESTORE_REGS)
  2191			restore_regs(m, &prog, nr_args, regs_off);
  2192	
  2193		/* This needs to be done regardless. If there were fmod_ret programs,
  2194		 * the return value is only updated on the stack and still needs to be
  2195		 * restored to R0.
  2196		 */
  2197		if (flags & BPF_TRAMP_F_CALL_ORIG) {
  2198			im->ip_epilogue = prog;
  2199			/* arg1: mov rdi, im */
  2200			emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
  2201			if (emit_call(&prog, __bpf_tramp_exit, prog)) {
  2202				ret = -EINVAL;
  2203				goto cleanup;
  2204			}
  2205		}
  2206		/* restore return value of orig_call or fentry prog back into RAX */
  2207		if (save_ret)
  2208			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
  2209	
  2210		EMIT1(0x5B); /* pop rbx */
  2211		EMIT1(0xC9); /* leave */
  2212		if (flags & BPF_TRAMP_F_SKIP_FRAME)
  2213			/* skip our return address and return to parent */
  2214			EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
  2215		emit_return(&prog, prog);
  2216		/* Make sure the trampoline generation logic doesn't overflow */
  2217		if (WARN_ON_ONCE(prog > (u8 *)image_end - BPF_INSN_SAFETY)) {
  2218			ret = -EFAULT;
  2219			goto cleanup;
  2220		}
  2221		ret = prog - (u8 *)image;
  2222	
  2223	cleanup:
  2224		kfree(branches);
  2225		return ret;
  2226	}
  2227	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
