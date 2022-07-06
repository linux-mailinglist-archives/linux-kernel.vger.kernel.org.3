Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406DD56948B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiGFVgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiGFVgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:36:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66269243
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657143394; x=1688679394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dLbXioWPHahHmJvm0LlbnXLettEnRRGEgB5M2kkP+hk=;
  b=bpMC7nTGg/rfdUqYL3MZl7dfw0Ac10k2EFeK+LYJvry93RGII2IiZksp
   fUMu3QWxUu85pkPHBkRXlBKQQycBr0EP0aXGZ8QdHCAJX9QYsfZmkYtco
   hoW4EcPBjv77j3y5vcOgN50FCNJTJ02cOdFD5jijwGlbtJ2Wn74zRet+j
   29uZ/7nti7rOhbmdFuG/2wtjey2/Oski8JaKSbDV4LcjAzCk7ftnLh8w6
   HhpXuTN5cCECv2WWJFpPd2OCMtQZJU/g5s6bBUWWDkRWi6Ew6nSkNAFDk
   JgWe/Jz1IA1uK2iPeljbz3tGb5kH50kiY41XV9sUSOsRfpvgFi8RRTIPq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="281422110"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="281422110"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 14:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="620501191"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2022 14:36:26 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9Ch7-000L4A-PV;
        Wed, 06 Jul 2022 21:36:25 +0000
Date:   Thu, 7 Jul 2022 05:35:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_22 20/21] kernel/bpf/syscall.c:3306:7: error:
 call to undeclared function 'bpf_tramp_id_alloc'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202207070530.sgflrE6n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_22
head:   1d891c46bb689a24985cea58f4eddb053d6b1331
commit: 70d8bfe245ee929757e1dcdf280f9e27786047a9 [20/21] bpf: Add support for tracing multi link
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220707/202207070530.sgflrE6n-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=70d8bfe245ee929757e1dcdf280f9e27786047a9
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_22
        git checkout 70d8bfe245ee929757e1dcdf280f9e27786047a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c:3128:26: error: field has incomplete type 'struct bpf_tramp_attach'
           struct bpf_tramp_attach attach;
                                   ^
   kernel/bpf/syscall.c:3128:9: note: forward declaration of 'struct bpf_tramp_attach'
           struct bpf_tramp_attach attach;
                  ^
   kernel/bpf/syscall.c:3136:15: error: call to undeclared function 'bpf_trampoline_detach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           WARN_ON_ONCE(bpf_trampoline_detach(&tr_link->attach));
                        ^
   kernel/bpf/syscall.c:3136:15: note: did you mean 'bpf_trampoline_get'?
   include/linux/bpf.h:993:38: note: 'bpf_trampoline_get' declared here
   static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
                                        ^
>> kernel/bpf/syscall.c:3306:7: error: call to undeclared function 'bpf_tramp_id_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           id = bpf_tramp_id_alloc(cnt);
                ^
   kernel/bpf/syscall.c:3306:5: warning: incompatible integer to pointer conversion assigning to 'struct bpf_tramp_id *' from 'int' [-Wint-conversion]
           id = bpf_tramp_id_alloc(cnt);
              ^ ~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/syscall.c:3347:8: error: call to undeclared function 'bpf_trampoline_attach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           err = bpf_trampoline_attach(&link->attach);
                 ^
   1 warning and 4 errors generated.


vim +/bpf_tramp_id_alloc +3306 kernel/bpf/syscall.c

  3290	
  3291	static int bpf_tracing_multi_attach(struct bpf_prog *prog,
  3292					    const union bpf_attr *attr)
  3293	{
  3294		void __user *uids = u64_to_user_ptr(attr->link_create.tracing_multi.btf_ids);
  3295		u32 cnt_size, cnt = attr->link_create.tracing_multi.btf_ids_cnt;
  3296		struct bpf_tracing_multi_link *link = NULL;
  3297		struct bpf_link_primer link_primer;
  3298		struct bpf_tramp_id *id = NULL;
  3299		int err = -EINVAL;
  3300	
  3301		if (check_multi_prog_type(prog))
  3302			return -EINVAL;
  3303		if (!cnt || !uids)
  3304			return -EINVAL;
  3305	
> 3306		id = bpf_tramp_id_alloc(cnt);
  3307		if (!id)
  3308			return -ENOMEM;
  3309	
  3310		err = -EFAULT;
  3311		cnt_size = cnt * sizeof(id->id[0]);
  3312		if (copy_from_user(id->id, uids, cnt_size))
  3313			goto out_free_id;
  3314	
  3315		id->cnt = cnt;
  3316		id->obj_id = btf_obj_id(prog->aux->attach_btf);
  3317	
  3318		/* Sort user provided BTF ids, so we can use memcmp
  3319		 * and bsearch on top of it later.
  3320		 */
  3321		sort(id->id, cnt, sizeof(u32), btf_ids_cmp, NULL);
  3322	
  3323		err = bpf_tramp_id_resolve(id, prog);
  3324		if (err)
  3325			goto out_free_id;
  3326	
  3327		link = kzalloc(sizeof(*link), GFP_KERNEL);
  3328		if (!link) {
  3329			err = -ENOMEM;
  3330			goto out_free_id;
  3331		}
  3332	
  3333		bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING_MULTI,
  3334			      &bpf_tracing_multi_link_lops, prog);
  3335		link->attach_type = prog->expected_attach_type;
  3336	
  3337		err = bpf_link_prime(&link->link, &link_primer);
  3338		if (err) {
  3339			kfree(link);
  3340			goto out_free_id;
  3341		}
  3342	
  3343		link->attach.id = id;
  3344		link->attach.tp.cookie = 0;
  3345		link->attach.tp.prog = prog;
  3346	
  3347		err = bpf_trampoline_attach(&link->attach);
  3348		if (err) {
  3349			bpf_link_cleanup(&link_primer);
  3350			goto out_free_id;
  3351		}
  3352		return bpf_link_settle(&link_primer);
  3353	out_free_id:
  3354		kfree(id);
  3355		return err;
  3356	}
  3357	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
