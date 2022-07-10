Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55F256D0FD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 21:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiGJTK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 15:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGJTK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 15:10:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D3914D0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657480225; x=1689016225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t2XcbGyIrqUmfBGCwlmu3GJABMuHHakSthRRvH22AtI=;
  b=mdMbAq7iCUQpJfNbnsm3DEWfKT8S81NqEjAi09HzBCeZa4X0BlqZTYQa
   AUUFIxP1G8BhJx11IPFOejJvyMWxMQ3MFwbdgzBuTMmeXG8cxf7MJ393o
   eEcMjb0P2yHSX2+7u2PEIvBbHHIBRiGMbLBn3hkaKU8Bw/YzRayfUftts
   i8QdP+FrtZj8DXOunwVyjxzWEI6LYZmKm/uRl19ZWf8ttRTPgvs2XVnJG
   n0EgCO4/qkhCrBgzzzpJyw2fNYL6Q+ZYyYqwmeCrDzHzoxzeDOdarRAJh
   hyi6AKo7YTq+aaGM4ApxP/4dPZh0+wHvY7Xra7/OJb6KYbfn8Li7v2iph
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="346220075"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="346220075"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 12:10:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="652200145"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2022 12:10:23 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAcJz-000Q7A-AV;
        Sun, 10 Jul 2022 19:10:23 +0000
Date:   Mon, 11 Jul 2022 03:10:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_27 15/33] kernel/bpf/syscall.c:2502:15: error:
 call to undeclared function 'is_tracing_multi'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202207110356.TVfdcPeq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_27
head:   08201713df8992b94d140b43fd4f20f1ad4aedb3
commit: ceab99fad55af7d8b76d900a15176ed8672f9191 [15/33] bpf: Add multi tracing attach types
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220711/202207110356.TVfdcPeq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6ce63e267aab79ca87bf63453d34dd3909ab978d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=ceab99fad55af7d8b76d900a15176ed8672f9191
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_27
        git checkout ceab99fad55af7d8b76d900a15176ed8672f9191
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/bpf/syscall.c:2502:15: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           multi_func = is_tracing_multi(attr->expected_attach_type);
                        ^
   1 error generated.
--
>> kernel/bpf/verifier.c:15098:13: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           } else if (is_tracing_multi(prog->expected_attach_type))
                      ^
   1 error generated.


vim +/is_tracing_multi +2502 kernel/bpf/syscall.c

  2452	
  2453	static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
  2454	{
  2455		enum bpf_prog_type type = attr->prog_type;
  2456		struct bpf_prog *prog, *dst_prog = NULL;
  2457		struct btf *attach_btf = NULL;
  2458		int err;
  2459		char license[128];
  2460		bool multi_func;
  2461		bool is_gpl;
  2462	
  2463		if (CHECK_ATTR(BPF_PROG_LOAD))
  2464			return -EINVAL;
  2465	
  2466		if (attr->prog_flags & ~(BPF_F_STRICT_ALIGNMENT |
  2467					 BPF_F_ANY_ALIGNMENT |
  2468					 BPF_F_TEST_STATE_FREQ |
  2469					 BPF_F_SLEEPABLE |
  2470					 BPF_F_TEST_RND_HI32 |
  2471					 BPF_F_XDP_HAS_FRAGS))
  2472			return -EINVAL;
  2473	
  2474		if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
  2475		    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
  2476		    !bpf_capable())
  2477			return -EPERM;
  2478	
  2479		/* copy eBPF program license from user space */
  2480		if (strncpy_from_bpfptr(license,
  2481					make_bpfptr(attr->license, uattr.is_kernel),
  2482					sizeof(license) - 1) < 0)
  2483			return -EFAULT;
  2484		license[sizeof(license) - 1] = 0;
  2485	
  2486		/* eBPF programs must be GPL compatible to use GPL-ed functions */
  2487		is_gpl = license_is_gpl_compatible(license);
  2488	
  2489		if (attr->insn_cnt == 0 ||
  2490		    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
  2491			return -E2BIG;
  2492		if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
  2493		    type != BPF_PROG_TYPE_CGROUP_SKB &&
  2494		    !bpf_capable())
  2495			return -EPERM;
  2496	
  2497		if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable(CAP_SYS_ADMIN))
  2498			return -EPERM;
  2499		if (is_perfmon_prog_type(type) && !perfmon_capable())
  2500			return -EPERM;
  2501	
> 2502		multi_func = is_tracing_multi(attr->expected_attach_type);
  2503	
  2504		/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
  2505		 * or btf, we need to check which one it is
  2506		 */
  2507		if (attr->attach_prog_fd) {
  2508			dst_prog = bpf_prog_get(attr->attach_prog_fd);
  2509			if (IS_ERR(dst_prog)) {
  2510				dst_prog = NULL;
  2511				attach_btf = btf_get_by_fd(attr->attach_btf_obj_fd);
  2512				if (IS_ERR(attach_btf))
  2513					return -EINVAL;
  2514				if (!btf_is_kernel(attach_btf)) {
  2515					/* attaching through specifying bpf_prog's BTF
  2516					 * objects directly might be supported eventually
  2517					 */
  2518					btf_put(attach_btf);
  2519					return -ENOTSUPP;
  2520				}
  2521			}
  2522		} else if (attr->attach_btf_id || multi_func) {
  2523			/* fall back to vmlinux BTF, if BTF type ID is specified */
  2524			attach_btf = bpf_get_btf_vmlinux();
  2525			if (IS_ERR(attach_btf))
  2526				return PTR_ERR(attach_btf);
  2527			if (!attach_btf)
  2528				return -EINVAL;
  2529			btf_get(attach_btf);
  2530		}
  2531	
  2532		bpf_prog_load_fixup_attach_type(attr);
  2533		if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
  2534					       attach_btf, attr->attach_btf_id,
  2535					       dst_prog, multi_func)) {
  2536			if (dst_prog)
  2537				bpf_prog_put(dst_prog);
  2538			if (attach_btf)
  2539				btf_put(attach_btf);
  2540			return -EINVAL;
  2541		}
  2542	
  2543		/* plain bpf_prog allocation */
  2544		prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER);
  2545		if (!prog) {
  2546			if (dst_prog)
  2547				bpf_prog_put(dst_prog);
  2548			if (attach_btf)
  2549				btf_put(attach_btf);
  2550			return -ENOMEM;
  2551		}
  2552	
  2553		prog->expected_attach_type = attr->expected_attach_type;
  2554		prog->aux->attach_btf = attach_btf;
  2555		prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
  2556		prog->aux->dst_prog = dst_prog;
  2557		prog->aux->offload_requested = !!attr->prog_ifindex;
  2558		prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
  2559		prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
  2560	
  2561		err = security_bpf_prog_alloc(prog->aux);
  2562		if (err)
  2563			goto free_prog;
  2564	
  2565		prog->aux->user = get_current_user();
  2566		prog->len = attr->insn_cnt;
  2567	
  2568		err = -EFAULT;
  2569		if (copy_from_bpfptr(prog->insns,
  2570				     make_bpfptr(attr->insns, uattr.is_kernel),
  2571				     bpf_prog_insn_size(prog)) != 0)
  2572			goto free_prog_sec;
  2573	
  2574		prog->orig_prog = NULL;
  2575		prog->jited = 0;
  2576	
  2577		atomic64_set(&prog->aux->refcnt, 1);
  2578		prog->gpl_compatible = is_gpl ? 1 : 0;
  2579	
  2580		if (bpf_prog_is_dev_bound(prog->aux)) {
  2581			err = bpf_prog_offload_init(prog, attr);
  2582			if (err)
  2583				goto free_prog_sec;
  2584		}
  2585	
  2586		/* find program type: socket_filter vs tracing_filter */
  2587		err = find_prog_type(type, prog);
  2588		if (err < 0)
  2589			goto free_prog_sec;
  2590	
  2591		prog->aux->load_time = ktime_get_boottime_ns();
  2592		err = bpf_obj_name_cpy(prog->aux->name, attr->prog_name,
  2593				       sizeof(attr->prog_name));
  2594		if (err < 0)
  2595			goto free_prog_sec;
  2596	
  2597		/* run eBPF verifier */
  2598		err = bpf_check(&prog, attr, uattr);
  2599		if (err < 0)
  2600			goto free_used_maps;
  2601	
  2602		prog = bpf_prog_select_runtime(prog, &err);
  2603		if (err < 0)
  2604			goto free_used_maps;
  2605	
  2606		err = bpf_prog_alloc_id(prog);
  2607		if (err)
  2608			goto free_used_maps;
  2609	
  2610		/* Upon success of bpf_prog_alloc_id(), the BPF prog is
  2611		 * effectively publicly exposed. However, retrieving via
  2612		 * bpf_prog_get_fd_by_id() will take another reference,
  2613		 * therefore it cannot be gone underneath us.
  2614		 *
  2615		 * Only for the time /after/ successful bpf_prog_new_fd()
  2616		 * and before returning to userspace, we might just hold
  2617		 * one reference and any parallel close on that fd could
  2618		 * rip everything out. Hence, below notifications must
  2619		 * happen before bpf_prog_new_fd().
  2620		 *
  2621		 * Also, any failure handling from this point onwards must
  2622		 * be using bpf_prog_put() given the program is exposed.
  2623		 */
  2624		bpf_prog_kallsyms_add(prog);
  2625		perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_LOAD, 0);
  2626		bpf_audit_prog(prog, BPF_AUDIT_LOAD);
  2627	
  2628		err = bpf_prog_new_fd(prog);
  2629		if (err < 0)
  2630			bpf_prog_put(prog);
  2631		return err;
  2632	
  2633	free_used_maps:
  2634		/* In case we have subprogs, we need to wait for a grace
  2635		 * period before we can tear down JIT memory since symbols
  2636		 * are already exposed under kallsyms.
  2637		 */
  2638		__bpf_prog_put_noref(prog, prog->aux->func_cnt);
  2639		return err;
  2640	free_prog_sec:
  2641		free_uid(prog->aux->user);
  2642		security_bpf_prog_free(prog->aux);
  2643	free_prog:
  2644		if (prog->aux->attach_btf)
  2645			btf_put(prog->aux->attach_btf);
  2646		bpf_prog_free(prog);
  2647		return err;
  2648	}
  2649	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
