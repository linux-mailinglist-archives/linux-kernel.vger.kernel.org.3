Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3075837FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 06:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiG1Ejl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 00:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiG1Eji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 00:39:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5696F49B5F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 21:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658983177; x=1690519177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aV4uxwdZjbiNyhwrmiFMvGYCNKLvLJmd0wQnE8pAKG4=;
  b=Zk2usbaVW4K0QY3ztvU3jMf3zWhqBKLGVNss/U2bF+wl/AfdskBKx8Gm
   uPiRIVgaO4aa8v+rOjKSymljyC5vmbBNMvaXz7a14RSzniSCuwxwfDr86
   /6DCYOf4UN6JVXEwQChGFG1o/4ayeYRFNDy5TOCIBfN++/5mvXs6DWpxp
   MaMafLQfLOwDpwcCKKChP7GKuHwhCCIWL8e4Cx/xSYumNvdrUljacZ3L5
   p7ZIzmquvE4ISXh5qhc/LkBvdWPzbrjMLuCyVF6tXzJqDP5bsZFzJsCFI
   hXXiDeSBNeszdCqg6KxT/7NuVr+FY0P43Ca2F/Cuparxz0SiuOr2zbGjj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="374721088"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="374721088"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 21:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="690128689"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2022 21:39:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGvJ8-0009ed-2x;
        Thu, 28 Jul 2022 04:39:34 +0000
Date:   Thu, 28 Jul 2022 12:38:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 14/34] kernel/bpf/syscall.c:2522:15:
 error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do
 not support implicit function declarations
Message-ID: <202207281247.02G79Ah0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_4
head:   1637b6b5bec11596e52cdc0a6eadfa45a15276c3
commit: bea966904e542c1a3a8d12a19f56042211d4e302 [14/34] bpf: Add multi tracing attach types
config: hexagon-randconfig-r041-20220728 (https://download.01.org/0day-ci/archive/20220728/202207281247.02G79Ah0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=bea966904e542c1a3a8d12a19f56042211d4e302
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_4
        git checkout bea966904e542c1a3a8d12a19f56042211d4e302
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/bpf/syscall.c:2522:15: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           multi_func = is_tracing_multi(attr->expected_attach_type);
                        ^
   1 error generated.
--
>> kernel/bpf/verifier.c:15099:13: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           } else if (is_tracing_multi(prog->expected_attach_type))
                      ^
   1 error generated.


vim +/is_tracing_multi +2522 kernel/bpf/syscall.c

  2472	
  2473	static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
  2474	{
  2475		enum bpf_prog_type type = attr->prog_type;
  2476		struct bpf_prog *prog, *dst_prog = NULL;
  2477		struct btf *attach_btf = NULL;
  2478		int err;
  2479		char license[128];
  2480		bool multi_func;
  2481		bool is_gpl;
  2482	
  2483		if (CHECK_ATTR(BPF_PROG_LOAD))
  2484			return -EINVAL;
  2485	
  2486		if (attr->prog_flags & ~(BPF_F_STRICT_ALIGNMENT |
  2487					 BPF_F_ANY_ALIGNMENT |
  2488					 BPF_F_TEST_STATE_FREQ |
  2489					 BPF_F_SLEEPABLE |
  2490					 BPF_F_TEST_RND_HI32 |
  2491					 BPF_F_XDP_HAS_FRAGS))
  2492			return -EINVAL;
  2493	
  2494		if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
  2495		    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
  2496		    !bpf_capable())
  2497			return -EPERM;
  2498	
  2499		/* copy eBPF program license from user space */
  2500		if (strncpy_from_bpfptr(license,
  2501					make_bpfptr(attr->license, uattr.is_kernel),
  2502					sizeof(license) - 1) < 0)
  2503			return -EFAULT;
  2504		license[sizeof(license) - 1] = 0;
  2505	
  2506		/* eBPF programs must be GPL compatible to use GPL-ed functions */
  2507		is_gpl = license_is_gpl_compatible(license);
  2508	
  2509		if (attr->insn_cnt == 0 ||
  2510		    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
  2511			return -E2BIG;
  2512		if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
  2513		    type != BPF_PROG_TYPE_CGROUP_SKB &&
  2514		    !bpf_capable())
  2515			return -EPERM;
  2516	
  2517		if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable(CAP_SYS_ADMIN))
  2518			return -EPERM;
  2519		if (is_perfmon_prog_type(type) && !perfmon_capable())
  2520			return -EPERM;
  2521	
> 2522		multi_func = is_tracing_multi(attr->expected_attach_type);
  2523	
  2524		/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
  2525		 * or btf, we need to check which one it is
  2526		 */
  2527		if (attr->attach_prog_fd) {
  2528			dst_prog = bpf_prog_get(attr->attach_prog_fd);
  2529			if (IS_ERR(dst_prog)) {
  2530				dst_prog = NULL;
  2531				attach_btf = btf_get_by_fd(attr->attach_btf_obj_fd);
  2532				if (IS_ERR(attach_btf))
  2533					return -EINVAL;
  2534				if (!btf_is_kernel(attach_btf)) {
  2535					/* attaching through specifying bpf_prog's BTF
  2536					 * objects directly might be supported eventually
  2537					 */
  2538					btf_put(attach_btf);
  2539					return -ENOTSUPP;
  2540				}
  2541			}
  2542		} else if (attr->attach_btf_id || multi_func) {
  2543			/* fall back to vmlinux BTF, if BTF type ID is specified */
  2544			attach_btf = bpf_get_btf_vmlinux();
  2545			if (IS_ERR(attach_btf))
  2546				return PTR_ERR(attach_btf);
  2547			if (!attach_btf)
  2548				return -EINVAL;
  2549			btf_get(attach_btf);
  2550		}
  2551	
  2552		bpf_prog_load_fixup_attach_type(attr);
  2553		if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
  2554					       attach_btf, attr->attach_btf_id,
  2555					       dst_prog, multi_func)) {
  2556			if (dst_prog)
  2557				bpf_prog_put(dst_prog);
  2558			if (attach_btf)
  2559				btf_put(attach_btf);
  2560			return -EINVAL;
  2561		}
  2562	
  2563		/* plain bpf_prog allocation */
  2564		prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER);
  2565		if (!prog) {
  2566			if (dst_prog)
  2567				bpf_prog_put(dst_prog);
  2568			if (attach_btf)
  2569				btf_put(attach_btf);
  2570			return -ENOMEM;
  2571		}
  2572	
  2573		prog->expected_attach_type = attr->expected_attach_type;
  2574		prog->aux->attach_btf = attach_btf;
  2575		prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
  2576		prog->aux->dst_prog = dst_prog;
  2577		prog->aux->offload_requested = !!attr->prog_ifindex;
  2578		prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
  2579		prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
  2580	
  2581		err = security_bpf_prog_alloc(prog->aux);
  2582		if (err)
  2583			goto free_prog;
  2584	
  2585		prog->aux->user = get_current_user();
  2586		prog->len = attr->insn_cnt;
  2587	
  2588		err = -EFAULT;
  2589		if (copy_from_bpfptr(prog->insns,
  2590				     make_bpfptr(attr->insns, uattr.is_kernel),
  2591				     bpf_prog_insn_size(prog)) != 0)
  2592			goto free_prog_sec;
  2593	
  2594		prog->orig_prog = NULL;
  2595		prog->jited = 0;
  2596	
  2597		atomic64_set(&prog->aux->refcnt, 1);
  2598		prog->gpl_compatible = is_gpl ? 1 : 0;
  2599	
  2600		if (bpf_prog_is_dev_bound(prog->aux)) {
  2601			err = bpf_prog_offload_init(prog, attr);
  2602			if (err)
  2603				goto free_prog_sec;
  2604		}
  2605	
  2606		/* find program type: socket_filter vs tracing_filter */
  2607		err = find_prog_type(type, prog);
  2608		if (err < 0)
  2609			goto free_prog_sec;
  2610	
  2611		prog->aux->load_time = ktime_get_boottime_ns();
  2612		err = bpf_obj_name_cpy(prog->aux->name, attr->prog_name,
  2613				       sizeof(attr->prog_name));
  2614		if (err < 0)
  2615			goto free_prog_sec;
  2616	
  2617		/* run eBPF verifier */
  2618		err = bpf_check(&prog, attr, uattr);
  2619		if (err < 0)
  2620			goto free_used_maps;
  2621	
  2622		prog = bpf_prog_select_runtime(prog, &err);
  2623		if (err < 0)
  2624			goto free_used_maps;
  2625	
  2626		err = bpf_prog_alloc_id(prog);
  2627		if (err)
  2628			goto free_used_maps;
  2629	
  2630		/* Upon success of bpf_prog_alloc_id(), the BPF prog is
  2631		 * effectively publicly exposed. However, retrieving via
  2632		 * bpf_prog_get_fd_by_id() will take another reference,
  2633		 * therefore it cannot be gone underneath us.
  2634		 *
  2635		 * Only for the time /after/ successful bpf_prog_new_fd()
  2636		 * and before returning to userspace, we might just hold
  2637		 * one reference and any parallel close on that fd could
  2638		 * rip everything out. Hence, below notifications must
  2639		 * happen before bpf_prog_new_fd().
  2640		 *
  2641		 * Also, any failure handling from this point onwards must
  2642		 * be using bpf_prog_put() given the program is exposed.
  2643		 */
  2644		bpf_prog_kallsyms_add(prog);
  2645		perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_LOAD, 0);
  2646		bpf_audit_prog(prog, BPF_AUDIT_LOAD);
  2647	
  2648		err = bpf_prog_new_fd(prog);
  2649		if (err < 0)
  2650			bpf_prog_put(prog);
  2651		return err;
  2652	
  2653	free_used_maps:
  2654		/* In case we have subprogs, we need to wait for a grace
  2655		 * period before we can tear down JIT memory since symbols
  2656		 * are already exposed under kallsyms.
  2657		 */
  2658		__bpf_prog_put_noref(prog, prog->aux->func_cnt);
  2659		return err;
  2660	free_prog_sec:
  2661		free_uid(prog->aux->user);
  2662		security_bpf_prog_free(prog->aux);
  2663	free_prog:
  2664		if (prog->aux->attach_btf)
  2665			btf_put(prog->aux->attach_btf);
  2666		bpf_prog_free(prog);
  2667		return err;
  2668	}
  2669	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
