Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFF0583FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiG1NTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiG1NTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:19:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5805358B71
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659014354; x=1690550354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ugswIBzj4UgV8ad2zHGrAO7QptfPM1PDoktgmKU3pwI=;
  b=XFf8/4Ufzh6im67lwmYXjFBummA5b2XJP//LKXLNDQYAcjRByLjSce45
   KdK+/eBFYzL9ulKArZZr51H1q7H97GPNwb+Tj5uLZL2FVeer/T/wWptlP
   EOGWU2jaHv2ns9Z/fZlEFzEfF1Y3/LWNuLqvwW+Su9rlOkn9crp70wvW+
   HHqgvzxGytxgQdAHnCWgPSdnHM9DmBMTWeDHgwAnX7ZmMzlh1TChjg6wb
   3daLa5wdA3y5A/K6FNNJkXG3a+8bxkt0jXDmIerM3I7AhsU78S3FPKFY5
   biDFBtinXZReGqqXHCh7l0uywS8RL4jsWMjNFCJpbhZnSpxzbzTmiLfde
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="275390338"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="275390338"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 06:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="628888380"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2022 06:19:12 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH3Pz-000A2M-36;
        Thu, 28 Jul 2022 13:19:11 +0000
Date:   Thu, 28 Jul 2022 21:18:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 24/34] kernel/bpf/syscall.c:3328:12:
 warning: assignment to 'struct bpf_tramp_id *' from 'int' makes pointer from
 integer without a cast
Message-ID: <202207282122.eP6T0wNr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_4
head:   1637b6b5bec11596e52cdc0a6eadfa45a15276c3
commit: ddb4a6defabce7658e7c6be7397bd5e714279b48 [24/34] bpf: Add support for tracing multi link
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220728/202207282122.eP6T0wNr-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=ddb4a6defabce7658e7c6be7397bd5e714279b48
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_4
        git checkout ddb4a6defabce7658e7c6be7397bd5e714279b48
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_prog_load':
   kernel/bpf/syscall.c:2523:22: error: implicit declaration of function 'is_tracing_multi' [-Werror=implicit-function-declaration]
    2523 |         multi_func = is_tracing_multi(attr->expected_attach_type);
         |                      ^~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/cpumask.h:14,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:10,
                    from kernel/bpf/syscall.c:4:
   kernel/bpf/syscall.c: In function 'bpf_tracing_multi_link_release':
   kernel/bpf/syscall.c:3157:22: error: implicit declaration of function 'bpf_trampoline_multi_detach' [-Werror=implicit-function-declaration]
    3157 |         WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON_ONCE'
     110 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
   kernel/bpf/syscall.c: In function 'bpf_tracing_multi_link_dealloc':
   kernel/bpf/syscall.c:3165:9: error: implicit declaration of function 'bpf_tramp_id_put'; did you mean 'bpf_trampoline_put'? [-Werror=implicit-function-declaration]
    3165 |         bpf_tramp_id_put(tr_link->id);
         |         ^~~~~~~~~~~~~~~~
         |         bpf_trampoline_put
   kernel/bpf/syscall.c: In function 'bpf_tracing_multi_attach':
   kernel/bpf/syscall.c:3328:14: error: implicit declaration of function 'bpf_tramp_id_alloc'; did you mean 'bpf_tramp_id_resolve'? [-Werror=implicit-function-declaration]
    3328 |         id = bpf_tramp_id_alloc(cnt);
         |              ^~~~~~~~~~~~~~~~~~
         |              bpf_tramp_id_resolve
>> kernel/bpf/syscall.c:3328:12: warning: assignment to 'struct bpf_tramp_id *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    3328 |         id = bpf_tramp_id_alloc(cnt);
         |            ^
   kernel/bpf/syscall.c:3369:15: error: implicit declaration of function 'bpf_trampoline_multi_attach'; did you mean 'bpf_tracing_multi_attach'? [-Werror=implicit-function-declaration]
    3369 |         err = bpf_trampoline_multi_attach(&link->tp, id);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               bpf_tracing_multi_attach
   cc1: some warnings being treated as errors


vim +3328 kernel/bpf/syscall.c

  3312	
  3313	static int bpf_tracing_multi_attach(struct bpf_prog *prog,
  3314					    const union bpf_attr *attr)
  3315	{
  3316		void __user *uids = u64_to_user_ptr(attr->link_create.tracing_multi.btf_ids);
  3317		u32 cnt_size, cnt = attr->link_create.tracing_multi.btf_ids_cnt;
  3318		struct bpf_tracing_multi_link *link = NULL;
  3319		struct bpf_link_primer link_primer;
  3320		struct bpf_tramp_id *id = NULL;
  3321		int err = -EINVAL;
  3322	
  3323		if (check_multi_prog_type(prog))
  3324			return -EINVAL;
  3325		if (!cnt || !uids)
  3326			return -EINVAL;
  3327	
> 3328		id = bpf_tramp_id_alloc(cnt);
  3329		if (!id)
  3330			return -ENOMEM;
  3331	
  3332		err = -EFAULT;
  3333		cnt_size = cnt * sizeof(id->id[0]);
  3334		if (copy_from_user(id->id, uids, cnt_size))
  3335			goto out_free_id;
  3336	
  3337		id->cnt = cnt;
  3338		id->obj_id = btf_obj_id(prog->aux->attach_btf);
  3339	
  3340		/* Sort user provided BTF ids, so we can use memcmp
  3341		 * and bsearch on top of it later.
  3342		 */
  3343		sort(id->id, cnt, sizeof(u32), btf_ids_cmp, NULL);
  3344	
  3345		err = bpf_tramp_id_resolve(id, prog);
  3346		if (err)
  3347			goto out_free_id;
  3348	
  3349		link = kzalloc(sizeof(*link), GFP_KERNEL);
  3350		if (!link) {
  3351			err = -ENOMEM;
  3352			goto out_free_id;
  3353		}
  3354	
  3355		bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING_MULTI,
  3356			      &bpf_tracing_multi_link_lops, prog);
  3357		link->attach_type = prog->expected_attach_type;
  3358	
  3359		err = bpf_link_prime(&link->link, &link_primer);
  3360		if (err) {
  3361			kfree(link);
  3362			goto out_free_id;
  3363		}
  3364	
  3365		link->id = id;
  3366		link->tp.cookie = 0;
  3367		link->tp.prog = prog;
  3368	
  3369		err = bpf_trampoline_multi_attach(&link->tp, id);
  3370		if (err) {
  3371			bpf_link_cleanup(&link_primer);
  3372			goto out_free_id;
  3373		}
  3374		return bpf_link_settle(&link_primer);
  3375	out_free_id:
  3376		kfree(id);
  3377		return err;
  3378	}
  3379	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
