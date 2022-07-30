Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F9A585B76
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiG3R5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 13:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiG3R5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 13:57:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BCB13F0E
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659203838; x=1690739838;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z9LLupgPTjFUzoIrUhUi293eeoL1/wHUh/jwKwUhLlk=;
  b=gdj0AvYPa2phkuRcljTdoPyBE9XLKtulUJvMUr2BAGaWV9Rj3RIH9qJc
   ZDlKA+USzVBRZiasEmc9254OVyc3Glva3kHx+fXf5YDKKLfqyT/sOeFdq
   nR/su179LL6ERpsU/1ZJwlTKcQVd/Hivuyr/uDG8Q43AcCQsuxRvzg4pi
   pzjqJtL35rVHPUxHukLuAKyocD6H7JvpPLOazUmGunsYVePQmdZf3HXS2
   uGvZ9hlLL2o4fpmNzRxT9cnC2ctl7vFynnmv0yJm6D0dYYc+o2NcFNr/J
   XkZ/33FpIvHrkB9VOGnzHy+UO5FXdHF4b1gSecdwzhChH7w6tjxQ1gHl0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="350640929"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="350640929"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 10:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="669590426"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2022 10:57:17 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHqiC-000D2n-1q;
        Sat, 30 Jul 2022 17:57:16 +0000
Date:   Sun, 31 Jul 2022 01:56:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 24/35] kernel/bpf/syscall.c:3157:22:
 error: implicit declaration of function 'bpf_trampoline_multi_detach'
Message-ID: <202207310100.xQT6NlLP-lkp@intel.com>
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
head:   a63fc296e166a76b3f7250a966df4651e3a846f1
commit: 2792d334c3d8d0f27276319d17dcb166c41794b7 [24/35] bpf: Add support for tracing multi link
config: m68k-amiga_defconfig (https://download.01.org/0day-ci/archive/20220731/202207310100.xQT6NlLP-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=2792d334c3d8d0f27276319d17dcb166c41794b7
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_4
        git checkout 2792d334c3d8d0f27276319d17dcb166c41794b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_prog_load':
   kernel/bpf/syscall.c:2523:22: error: implicit declaration of function 'is_tracing_multi' [-Werror=implicit-function-declaration]
    2523 |         multi_func = is_tracing_multi(attr->expected_attach_type);
         |                      ^~~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:7,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/ktime.h:26,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:10,
                    from kernel/bpf/syscall.c:4:
   kernel/bpf/syscall.c: In function 'bpf_tracing_multi_link_release':
>> kernel/bpf/syscall.c:3157:22: error: implicit declaration of function 'bpf_trampoline_multi_detach' [-Werror=implicit-function-declaration]
    3157 |         WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/once_lite.h:15:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      15 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   kernel/bpf/syscall.c:3157:9: note: in expansion of macro 'WARN_ON_ONCE'
    3157 |         WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
         |         ^~~~~~~~~~~~
   kernel/bpf/syscall.c: In function 'bpf_tracing_multi_link_dealloc':
>> kernel/bpf/syscall.c:3165:9: error: implicit declaration of function 'bpf_tramp_id_put'; did you mean 'bpf_trampoline_put'? [-Werror=implicit-function-declaration]
    3165 |         bpf_tramp_id_put(tr_link->id);
         |         ^~~~~~~~~~~~~~~~
         |         bpf_trampoline_put
   kernel/bpf/syscall.c: In function 'bpf_tracing_multi_attach':
>> kernel/bpf/syscall.c:3328:14: error: implicit declaration of function 'bpf_tramp_id_alloc'; did you mean 'bpf_tramp_id_resolve'? [-Werror=implicit-function-declaration]
    3328 |         id = bpf_tramp_id_alloc(cnt);
         |              ^~~~~~~~~~~~~~~~~~
         |              bpf_tramp_id_resolve
   kernel/bpf/syscall.c:3328:12: warning: assignment to 'struct bpf_tramp_id *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    3328 |         id = bpf_tramp_id_alloc(cnt);
         |            ^
>> kernel/bpf/syscall.c:3369:15: error: implicit declaration of function 'bpf_trampoline_multi_attach'; did you mean 'bpf_tracing_multi_attach'? [-Werror=implicit-function-declaration]
    3369 |         err = bpf_trampoline_multi_attach(&link->tp, id);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               bpf_tracing_multi_attach
   cc1: some warnings being treated as errors


vim +/bpf_trampoline_multi_detach +3157 kernel/bpf/syscall.c

  3151	
  3152	static void bpf_tracing_multi_link_release(struct bpf_link *link)
  3153	{
  3154		struct bpf_tracing_multi_link *tr_link =
  3155			container_of(link, struct bpf_tracing_multi_link, link);
  3156	
> 3157		WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
  3158	}
  3159	
  3160	static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
  3161	{
  3162		struct bpf_tracing_multi_link *tr_link =
  3163			container_of(link, struct bpf_tracing_multi_link, link);
  3164	
> 3165		bpf_tramp_id_put(tr_link->id);
  3166		kfree(tr_link);
  3167	}
  3168	
  3169	static void bpf_tracing_multi_link_show_fdinfo(const struct bpf_link *link,
  3170						       struct seq_file *seq)
  3171	{
  3172		struct bpf_tracing_multi_link *tr_link =
  3173			container_of(link, struct bpf_tracing_multi_link, link);
  3174	
  3175		seq_printf(seq, "attach_type:\t%d\n", tr_link->attach_type);
  3176	}
  3177	
  3178	static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
  3179							 struct bpf_link_info *info)
  3180	{
  3181		struct bpf_tracing_multi_link *tr_link =
  3182			container_of(link, struct bpf_tracing_multi_link, link);
  3183	
  3184		info->tracing.attach_type = tr_link->attach_type;
  3185		return 0;
  3186	}
  3187	
  3188	static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
  3189		.release = bpf_tracing_multi_link_release,
  3190		.dealloc = bpf_tracing_multi_link_dealloc,
  3191		.show_fdinfo = bpf_tracing_multi_link_show_fdinfo,
  3192		.fill_link_info = bpf_tracing_multi_link_fill_link_info,
  3193	};
  3194	
  3195	static int check_multi_prog_type(struct bpf_prog *prog)
  3196	{
  3197		if (prog->expected_attach_type != BPF_TRACE_FENTRY_MULTI &&
  3198		    prog->expected_attach_type != BPF_TRACE_FEXIT_MULTI)
  3199			return -EINVAL;
  3200		return 0;
  3201	}
  3202	
  3203	static int btf_ids_cmp(const void *a, const void *b)
  3204	{
  3205		const u32 *x = a;
  3206		const u32 *y = b;
  3207	
  3208		if (*x == *y)
  3209			return 0;
  3210		return *x < *y ? -1 : 1;
  3211	}
  3212	
  3213	struct resolve_id {
  3214		const char *name;
  3215		void *addr;
  3216		u32 id;
  3217	};
  3218	
  3219	static int rid_name_cmp(const void *a, const void *b)
  3220	{
  3221		const struct resolve_id *x = a;
  3222		const struct resolve_id *y = b;
  3223	
  3224		return strcmp(x->name, y->name);
  3225	}
  3226	
  3227	static int rid_id_cmp(const void *a, const void *b)
  3228	{
  3229		const struct resolve_id *x = a;
  3230		const struct resolve_id *y = b;
  3231	
  3232		if (x->id == y->id)
  3233			return 0;
  3234		return x->id < y->id ? -1 : 1;
  3235	}
  3236	
  3237	struct kallsyms_data {
  3238		struct resolve_id *rid;
  3239		u32 cnt;
  3240		u32 found;
  3241	};
  3242	
  3243	static int kallsyms_callback(void *data, const char *name,
  3244				     struct module *mod, unsigned long addr)
  3245	{
  3246		struct kallsyms_data *args = data;
  3247		struct resolve_id *rid, id = {
  3248			.name = name,
  3249		};
  3250	
  3251		rid = bsearch(&id, args->rid, args->cnt, sizeof(*rid), rid_name_cmp);
  3252		if (rid && !rid->addr) {
  3253			rid->addr = (void *) addr;
  3254			args->found++;
  3255		}
  3256		return args->found == args->cnt ? 1 : 0;
  3257	}
  3258	
  3259	static int bpf_tramp_id_resolve(struct bpf_tramp_id *id, struct bpf_prog *prog)
  3260	{
  3261		struct kallsyms_data args;
  3262		const struct btf_type *t;
  3263		struct resolve_id *rid;
  3264		const char *name;
  3265		struct btf *btf;
  3266		int err = 0;
  3267		u32 i;
  3268	
  3269		btf = prog->aux->attach_btf;
  3270		if (!btf)
  3271			return -EINVAL;
  3272	
  3273		rid = kzalloc(id->cnt * sizeof(*rid), GFP_KERNEL);
  3274		if (!rid)
  3275			return -ENOMEM;
  3276	
  3277		err = -EINVAL;
  3278		for (i = 0; i < id->cnt; i++) {
  3279			t = btf_type_by_id(btf, id->id[i]);
  3280			if (!t)
  3281				goto out_free;
  3282	
  3283			name = btf_name_by_offset(btf, t->name_off);
  3284			if (!name)
  3285				goto out_free;
  3286	
  3287			rid[i].name = name;
  3288			rid[i].id = id->id[i];
  3289		}
  3290	
  3291		sort(rid, id->cnt, sizeof(*rid), rid_name_cmp, NULL);
  3292	
  3293		args.rid = rid;
  3294		args.cnt = id->cnt;
  3295		args.found = 0;
  3296		kallsyms_on_each_symbol(kallsyms_callback, &args);
  3297	
  3298		sort(rid, id->cnt, sizeof(*rid), rid_id_cmp, NULL);
  3299	
  3300		for (i = 0; i < id->cnt; i++) {
  3301			if (!rid[i].addr) {
  3302				err = -EINVAL;
  3303				goto out_free;
  3304			}
  3305			id->addr[i] = rid[i].addr;
  3306		}
  3307		err = 0;
  3308	out_free:
  3309		kfree(rid);
  3310		return err;
  3311	}
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
