Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A0F557A96
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiFWMpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiFWMon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:44:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAB93FBE6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655988281; x=1687524281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EODAoLTKKQPN2J0vle71EAPJKgDQrgZC/9hwHAtsMqc=;
  b=POq1g61RwaX48n3JrLRrMFCxk1cjmWY8+OPz3BssAF1UYrPAbllOb0GO
   jmNefMaLigHwWRq65Nky8KmkJ0uBl9JBFn5YsBUHRVXlaJsh/qffw5Rps
   XsEd2VdyCuAgn0a23qV641FWVJsD4GmI/2vBmeTxDjTfdEg2mO/K0Uyrl
   Iio8/huGJ0ZXPwgzI0bRT6cUpC/u5OgjbZj2uRCvso+uCaQzA74bC2byZ
   RDfxvAa6PM5iBLh4U92A80IpfD0oswSOxvTi0U0h7kpBDpk1KElzKP3zx
   rApk1cNbgUkIu4Vxcooe5QOkK7o01uT3WNhBI4xtwHLIOYNlKwmbvUYDe
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281437810"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="281437810"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 05:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="615562079"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Jun 2022 05:44:38 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4MCM-0001GR-6y;
        Thu, 23 Jun 2022 12:44:38 +0000
Date:   Thu, 23 Jun 2022 20:44:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_11 17/21] kernel/bpf/syscall.c:2994:8: error:
 call to undeclared function 'bpf_tramp_id_alloc'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202206231904.F79Q8wfi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_11
head:   c807110aa605281263da02a78af57847f5c4275e
commit: ac6153f8956b357b52e16ea68b70ea51aff1752c [17/21] bpf: Use bpf_tramp_id object in attach
config: hexagon-randconfig-r041-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231904.F79Q8wfi-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 46be5faaf03466c3751f8a2882bef5a217e15926)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=ac6153f8956b357b52e16ea68b70ea51aff1752c
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_11
        git checkout ac6153f8956b357b52e16ea68b70ea51aff1752c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> kernel/bpf/syscall.c:2994:8: error: call to undeclared function 'bpf_tramp_id_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   id = bpf_tramp_id_alloc();
                        ^
   kernel/bpf/syscall.c:2994:8: note: did you mean 'bpf_map_kzalloc'?
   include/linux/bpf.h:1656:1: note: 'bpf_map_kzalloc' declared here
   bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
   ^
>> kernel/bpf/syscall.c:2994:6: warning: incompatible integer to pointer conversion assigning to 'struct bpf_tramp_id *' from 'int' [-Wint-conversion]
                   id = bpf_tramp_id_alloc();
                      ^ ~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/syscall.c:3007:3: error: call to undeclared function 'bpf_tramp_id_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   bpf_tramp_id_init(id, tgt_prog, NULL, btf_id);
                   ^
   kernel/bpf/syscall.c:3053:8: error: call to undeclared function 'bpf_tramp_id_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   id = bpf_tramp_id_alloc();
                        ^
   kernel/bpf/syscall.c:3053:6: warning: incompatible integer to pointer conversion assigning to 'struct bpf_tramp_id *' from 'int' [-Wint-conversion]
                   id = bpf_tramp_id_alloc();
                      ^ ~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/syscall.c:3059:3: error: call to undeclared function 'bpf_tramp_id_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   bpf_tramp_id_init(id, NULL, prog->aux->attach_btf, btf_id);
                   ^
>> kernel/bpf/syscall.c:3062:29: error: call to undeclared function 'bpf_tramp_id_is_equal'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (!prog->aux->dst_id || !bpf_tramp_id_is_equal(id, prog->aux->dst_id)) {
                                      ^
   2 warnings and 5 errors generated.
--
>> kernel/bpf/verifier.c:15073:7: error: call to undeclared function 'bpf_tramp_id_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           id = bpf_tramp_id_alloc();
                ^
   kernel/bpf/verifier.c:15073:7: note: did you mean 'bpf_map_kzalloc'?
   include/linux/bpf.h:1656:1: note: 'bpf_map_kzalloc' declared here
   bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
   ^
>> kernel/bpf/verifier.c:15073:5: warning: incompatible integer to pointer conversion assigning to 'struct bpf_tramp_id *' from 'int' [-Wint-conversion]
           id = bpf_tramp_id_alloc();
              ^ ~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/verifier.c:15077:2: error: call to undeclared function 'bpf_tramp_id_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           bpf_tramp_id_init(id, tgt_prog, prog->aux->attach_btf, btf_id);
           ^
   1 warning and 2 errors generated.


vim +/bpf_tramp_id_alloc +2994 kernel/bpf/syscall.c

  2942	
  2943	static int bpf_tracing_prog_attach(struct bpf_prog *prog,
  2944					   int tgt_prog_fd,
  2945					   u32 btf_id,
  2946					   u64 bpf_cookie)
  2947	{
  2948		struct bpf_attach_target_info tgt_info_buf = {};
  2949		struct bpf_attach_target_info *tgt_info = &tgt_info_buf;
  2950		struct bpf_link_primer link_primer;
  2951		struct bpf_prog *tgt_prog = NULL;
  2952		struct bpf_tramp_id *id = NULL;
  2953		struct bpf_tracing_link *link;
  2954		int err;
  2955	
  2956		switch (prog->type) {
  2957		case BPF_PROG_TYPE_TRACING:
  2958			if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
  2959			    prog->expected_attach_type != BPF_TRACE_FEXIT &&
  2960			    prog->expected_attach_type != BPF_MODIFY_RETURN) {
  2961				err = -EINVAL;
  2962				goto out_put_prog;
  2963			}
  2964			break;
  2965		case BPF_PROG_TYPE_EXT:
  2966			if (prog->expected_attach_type != 0) {
  2967				err = -EINVAL;
  2968				goto out_put_prog;
  2969			}
  2970			break;
  2971		case BPF_PROG_TYPE_LSM:
  2972			if (prog->expected_attach_type != BPF_LSM_MAC) {
  2973				err = -EINVAL;
  2974				goto out_put_prog;
  2975			}
  2976			break;
  2977		default:
  2978			err = -EINVAL;
  2979			goto out_put_prog;
  2980		}
  2981	
  2982		if (!!tgt_prog_fd != !!btf_id) {
  2983			err = -EINVAL;
  2984			goto out_put_prog;
  2985		}
  2986	
  2987		if (tgt_prog_fd) {
  2988			/* For now we only allow new targets for BPF_PROG_TYPE_EXT */
  2989			if (prog->type != BPF_PROG_TYPE_EXT) {
  2990				err = -EINVAL;
  2991				goto out_put_prog;
  2992			}
  2993	
> 2994			id = bpf_tramp_id_alloc();
  2995			if (!id) {
  2996				err = -ENOMEM;
  2997				goto out_put_prog;
  2998			}
  2999	
  3000			tgt_prog = bpf_prog_get(tgt_prog_fd);
  3001			if (IS_ERR(tgt_prog)) {
  3002				err = PTR_ERR(tgt_prog);
  3003				tgt_prog = NULL;
  3004				goto out_put_prog;
  3005			}
  3006	
> 3007			bpf_tramp_id_init(id, tgt_prog, NULL, btf_id);
  3008		}
  3009	
  3010		link = kzalloc(sizeof(*link), GFP_USER);
  3011		if (!link) {
  3012			err = -ENOMEM;
  3013			goto out_put_prog;
  3014		}
  3015		bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING,
  3016			      &bpf_tracing_link_lops, prog);
  3017		link->attach_type = prog->expected_attach_type;
  3018		link->attach.tp.cookie = bpf_cookie;
  3019		link->attach.tp.prog = prog;
  3020	
  3021		mutex_lock(&prog->aux->dst_mutex);
  3022	
  3023		/* There are a few possible cases here:
  3024		 *
  3025		 * - if prog->aux->dst_key is set, the program was just loaded
  3026		 *   and not yet attached to anything, so we can use the values stored
  3027		 *   in prog->aux
  3028		 *
  3029		 * - if prog->aux->dst_key is NULL, the program has already been
  3030	         *   attached to a target and its initial target was cleared (below)
  3031		 *
  3032		 * - if tgt_prog != NULL, the caller specified tgt_prog_fd +
  3033		 *   target_btf_id using the link_create API.
  3034		 *
  3035		 * - if tgt_prog == NULL when this function was called using the old
  3036		 *   raw_tracepoint_open API, and we need a target from prog->aux
  3037		 *
  3038		 * - if prog->aux->dst_key and tgt_prog is NULL, the program
  3039		 *   was detached and is going for re-attachment.
  3040		 */
  3041		if (!prog->aux->dst_id && !tgt_prog) {
  3042			/*
  3043			 * Allow re-attach for TRACING and LSM programs. If it's
  3044			 * currently linked, bpf_trampoline_link_prog will fail.
  3045			 * EXT programs need to specify tgt_prog_fd, so they
  3046			 * re-attach in separate code path.
  3047			 */
  3048			if (prog->type != BPF_PROG_TYPE_TRACING &&
  3049			    prog->type != BPF_PROG_TYPE_LSM) {
  3050				err = -EINVAL;
  3051				goto out_unlock;
  3052			}
> 3053			id = bpf_tramp_id_alloc();
  3054			if (!id) {
  3055				err = -ENOMEM;
  3056				goto out_unlock;
  3057			}
  3058			btf_id = prog->aux->attach_btf_id;
  3059			bpf_tramp_id_init(id, NULL, prog->aux->attach_btf, btf_id);
  3060		}
  3061	
> 3062		if (!prog->aux->dst_id || !bpf_tramp_id_is_equal(id, prog->aux->dst_id)) {
  3063			/* If there is no saved target, or the specified target is
  3064			 * different from the destination specified at load time, we
  3065			 * need a new trampoline and a check for compatibility
  3066			 */
  3067	
  3068			err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
  3069						      tgt_info);
  3070			if (err)
  3071				goto out_unlock;
  3072		} else {
  3073			/* The caller didn't specify a target, or the target was the
  3074			 * same as the destination supplied during program load. This
  3075			 * means we can reuse the trampoline and reference from program
  3076			 * load time, and there is no need to allocate a new one. This
  3077			 * can only happen once for any program, as the saved values in
  3078			 * prog->aux are cleared below.
  3079			 */
  3080			id = prog->aux->dst_id;
  3081			tgt_prog = prog->aux->dst_prog;
  3082			tgt_info = &prog->aux->dst_tgt_info;
  3083		}
  3084	
  3085		link->attach.id = id;
  3086	
  3087		err = bpf_link_prime(&link->link, &link_primer);
  3088		if (err)
  3089			goto out_unlock;
  3090	
  3091		err = bpf_trampoline_attach(&link->attach, tgt_info);
  3092		if (err) {
  3093			bpf_link_cleanup(&link_primer);
  3094			link = NULL;
  3095			goto out_unlock;
  3096		}
  3097	
  3098		link->tgt_prog = tgt_prog;
  3099	
  3100		/* Always clear the trampoline and target prog from prog->aux to make
  3101		 * sure the original attach destination is not kept alive after a
  3102		 * program is (re-)attached to another target.
  3103		 */
  3104		if (prog->aux->dst_prog &&
  3105		    (tgt_prog_fd || !bpf_tramp_id_is_equal(id, prog->aux->dst_id)))
  3106			/* got extra prog ref from syscall, or attaching to different prog */
  3107			bpf_prog_put(prog->aux->dst_prog);
  3108	
  3109		prog->aux->dst_prog = NULL;
  3110		prog->aux->dst_id = NULL;
  3111		mutex_unlock(&prog->aux->dst_mutex);
  3112	
  3113		return bpf_link_settle(&link_primer);
  3114	out_unlock:
  3115		mutex_unlock(&prog->aux->dst_mutex);
  3116		kfree(link);
  3117	out_put_prog:
  3118		if (tgt_prog_fd && tgt_prog)
  3119			bpf_prog_put(tgt_prog);
  3120		return err;
  3121	}
  3122	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
