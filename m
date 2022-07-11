Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F402D570D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGKWCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiGKWCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:02:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C6509F1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657576966; x=1689112966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aHLBoGYYNG/10WCdfv0hEp1KbJZu9gbc4BUlFC2PDuw=;
  b=nyPDrchdJehGkK3zq1gwghD12WPBB+9A1QYNBguj60uR17iBaBsjCjJO
   8/PDZoz7SliiF+ycdDTkvFn8rH04feTUItXAES6YrV3v2rbijoNXKqkDS
   AxCRTzzkf1zlce92a/Osqx1esbMGItzEwakxMyAWGd64/1UwTi7jMwAmm
   9k1xhj+Z5ZNr7yY+hV2ayL6Wro9GrXhRV7zfD0i1Tg6i/S3RSnGZWocwN
   VL/2EWowfyo08wZ4o9z8x4lJXPDqrHZBvE9C7DOD21fbr8lKjEOT//sC6
   EIYPFn5YTZSNAlx0X4vM42zVIXEIwBNRT9oIg8RAqpMe/dEX0ydfr5DO4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285521645"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="285521645"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 15:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="737251166"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2022 15:02:44 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB1UJ-0001IF-Kn;
        Mon, 11 Jul 2022 22:02:43 +0000
Date:   Tue, 12 Jul 2022 06:02:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_29 26/32] kernel/bpf/syscall.c:3137:15: error:
 call to undeclared function 'bpf_trampoline_multi_detach'; ISO C99 and later
 do not support implicit function declarations
Message-ID: <202207120523.yVSHsCLv-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_29
head:   ec522c20e55e48f561146afbb81513e20870ee12
commit: 75c50c5a148820bf4b1fafa3fb834bbfaeccc6c2 [26/32] bpf: Add support for tracing multi link
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220712/202207120523.yVSHsCLv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project badda4ac3c489a8c8cccdad1f74b9308c350a9e0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=75c50c5a148820bf4b1fafa3fb834bbfaeccc6c2
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_29
        git checkout 75c50c5a148820bf4b1fafa3fb834bbfaeccc6c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c:2503:15: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           multi_func = is_tracing_multi(attr->expected_attach_type);
                        ^
>> kernel/bpf/syscall.c:3137:15: error: call to undeclared function 'bpf_trampoline_multi_detach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
                        ^
   kernel/bpf/syscall.c:3145:2: error: call to undeclared function 'bpf_tramp_id_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           bpf_tramp_id_put(tr_link->id);
           ^
   kernel/bpf/syscall.c:3145:2: note: did you mean 'bpf_trampoline_put'?
   include/linux/bpf.h:1013:20: note: 'bpf_trampoline_put' declared here
   static inline void bpf_trampoline_put(struct bpf_trampoline *tr) {}
                      ^
>> kernel/bpf/syscall.c:3308:7: error: call to undeclared function 'bpf_tramp_id_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           id = bpf_tramp_id_alloc(cnt);
                ^
   kernel/bpf/syscall.c:3308:5: warning: incompatible integer to pointer conversion assigning to 'struct bpf_tramp_id *' from 'int' [-Wint-conversion]
           id = bpf_tramp_id_alloc(cnt);
              ^ ~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/syscall.c:3349:8: error: call to undeclared function 'bpf_trampoline_multi_attach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           err = bpf_trampoline_multi_attach(&link->tp, id);
                 ^
   kernel/bpf/syscall.c:3349:8: note: did you mean 'bpf_tracing_multi_attach'?
   kernel/bpf/syscall.c:3293:12: note: 'bpf_tracing_multi_attach' declared here
   static int bpf_tracing_multi_attach(struct bpf_prog *prog,
              ^
   kernel/bpf/syscall.c:4821:12: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   else if (is_tracing_multi(prog->expected_attach_type))
                            ^
   1 warning and 6 errors generated.


vim +/bpf_trampoline_multi_detach +3137 kernel/bpf/syscall.c

  3131	
  3132	static void bpf_tracing_multi_link_release(struct bpf_link *link)
  3133	{
  3134		struct bpf_tracing_multi_link *tr_link =
  3135			container_of(link, struct bpf_tracing_multi_link, link);
  3136	
> 3137		WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
  3138	}
  3139	
  3140	static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
  3141	{
  3142		struct bpf_tracing_multi_link *tr_link =
  3143			container_of(link, struct bpf_tracing_multi_link, link);
  3144	
  3145		bpf_tramp_id_put(tr_link->id);
  3146		kfree(tr_link);
  3147	}
  3148	
  3149	static void bpf_tracing_multi_link_show_fdinfo(const struct bpf_link *link,
  3150						       struct seq_file *seq)
  3151	{
  3152		struct bpf_tracing_multi_link *tr_link =
  3153			container_of(link, struct bpf_tracing_multi_link, link);
  3154	
  3155		seq_printf(seq, "attach_type:\t%d\n", tr_link->attach_type);
  3156	}
  3157	
  3158	static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
  3159							 struct bpf_link_info *info)
  3160	{
  3161		struct bpf_tracing_multi_link *tr_link =
  3162			container_of(link, struct bpf_tracing_multi_link, link);
  3163	
  3164		info->tracing.attach_type = tr_link->attach_type;
  3165		return 0;
  3166	}
  3167	
  3168	static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
  3169		.release = bpf_tracing_multi_link_release,
  3170		.dealloc = bpf_tracing_multi_link_dealloc,
  3171		.show_fdinfo = bpf_tracing_multi_link_show_fdinfo,
  3172		.fill_link_info = bpf_tracing_multi_link_fill_link_info,
  3173	};
  3174	
  3175	static int check_multi_prog_type(struct bpf_prog *prog)
  3176	{
  3177		if (prog->expected_attach_type != BPF_TRACE_FENTRY_MULTI &&
  3178		    prog->expected_attach_type != BPF_TRACE_FEXIT_MULTI)
  3179			return -EINVAL;
  3180		return 0;
  3181	}
  3182	
  3183	static int btf_ids_cmp(const void *a, const void *b)
  3184	{
  3185		const u32 *x = a;
  3186		const u32 *y = b;
  3187	
  3188		if (*x == *y)
  3189			return 0;
  3190		return *x < *y ? -1 : 1;
  3191	}
  3192	
  3193	struct resolve_id {
  3194		const char *name;
  3195		void *addr;
  3196		u32 id;
  3197	};
  3198	
  3199	static int rid_name_cmp(const void *a, const void *b)
  3200	{
  3201		const struct resolve_id *x = a;
  3202		const struct resolve_id *y = b;
  3203	
  3204		return strcmp(x->name, y->name);
  3205	}
  3206	
  3207	static int rid_id_cmp(const void *a, const void *b)
  3208	{
  3209		const struct resolve_id *x = a;
  3210		const struct resolve_id *y = b;
  3211	
  3212		if (x->id == y->id)
  3213			return 0;
  3214		return x->id < y->id ? -1 : 1;
  3215	}
  3216	
  3217	struct kallsyms_data {
  3218		struct resolve_id *rid;
  3219		u32 cnt;
  3220		u32 found;
  3221	};
  3222	
  3223	static int kallsyms_callback(void *data, const char *name,
  3224				     struct module *mod, unsigned long addr)
  3225	{
  3226		struct kallsyms_data *args = data;
  3227		struct resolve_id *rid, id = {
  3228			.name = name,
  3229		};
  3230	
  3231		rid = bsearch(&id, args->rid, args->cnt, sizeof(*rid), rid_name_cmp);
  3232		if (rid && !rid->addr) {
  3233			rid->addr = (void *) addr;
  3234			args->found++;
  3235		}
  3236		return args->found == args->cnt ? 1 : 0;
  3237	}
  3238	
  3239	static int bpf_tramp_id_resolve(struct bpf_tramp_id *id, struct bpf_prog *prog)
  3240	{
  3241		struct kallsyms_data args;
  3242		const struct btf_type *t;
  3243		struct resolve_id *rid;
  3244		const char *name;
  3245		struct btf *btf;
  3246		int err = 0;
  3247		u32 i;
  3248	
  3249		btf = prog->aux->attach_btf;
  3250		if (!btf)
  3251			return -EINVAL;
  3252	
  3253		rid = kzalloc(id->cnt * sizeof(*rid), GFP_KERNEL);
  3254		if (!rid)
  3255			return -ENOMEM;
  3256	
  3257		err = -EINVAL;
  3258		for (i = 0; i < id->cnt; i++) {
  3259			t = btf_type_by_id(btf, id->id[i]);
  3260			if (!t)
  3261				goto out_free;
  3262	
  3263			name = btf_name_by_offset(btf, t->name_off);
  3264			if (!name)
  3265				goto out_free;
  3266	
  3267			rid[i].name = name;
  3268			rid[i].id = id->id[i];
  3269		}
  3270	
  3271		sort(rid, id->cnt, sizeof(*rid), rid_name_cmp, NULL);
  3272	
  3273		args.rid = rid;
  3274		args.cnt = id->cnt;
  3275		args.found = 0;
  3276		kallsyms_on_each_symbol(kallsyms_callback, &args);
  3277	
  3278		sort(rid, id->cnt, sizeof(*rid), rid_id_cmp, NULL);
  3279	
  3280		for (i = 0; i < id->cnt; i++) {
  3281			if (!rid[i].addr) {
  3282				err = -EINVAL;
  3283				goto out_free;
  3284			}
  3285			id->addr[i] = rid[i].addr;
  3286		}
  3287		err = 0;
  3288	out_free:
  3289		kfree(rid);
  3290		return err;
  3291	}
  3292	
  3293	static int bpf_tracing_multi_attach(struct bpf_prog *prog,
  3294					    const union bpf_attr *attr)
  3295	{
  3296		void __user *uids = u64_to_user_ptr(attr->link_create.tracing_multi.btf_ids);
  3297		u32 cnt_size, cnt = attr->link_create.tracing_multi.btf_ids_cnt;
  3298		struct bpf_tracing_multi_link *link = NULL;
  3299		struct bpf_link_primer link_primer;
  3300		struct bpf_tramp_id *id = NULL;
  3301		int err = -EINVAL;
  3302	
  3303		if (check_multi_prog_type(prog))
  3304			return -EINVAL;
  3305		if (!cnt || !uids)
  3306			return -EINVAL;
  3307	
> 3308		id = bpf_tramp_id_alloc(cnt);
  3309		if (!id)
  3310			return -ENOMEM;
  3311	
  3312		err = -EFAULT;
  3313		cnt_size = cnt * sizeof(id->id[0]);
  3314		if (copy_from_user(id->id, uids, cnt_size))
  3315			goto out_free_id;
  3316	
  3317		id->cnt = cnt;
  3318		id->obj_id = btf_obj_id(prog->aux->attach_btf);
  3319	
  3320		/* Sort user provided BTF ids, so we can use memcmp
  3321		 * and bsearch on top of it later.
  3322		 */
  3323		sort(id->id, cnt, sizeof(u32), btf_ids_cmp, NULL);
  3324	
  3325		err = bpf_tramp_id_resolve(id, prog);
  3326		if (err)
  3327			goto out_free_id;
  3328	
  3329		link = kzalloc(sizeof(*link), GFP_KERNEL);
  3330		if (!link) {
  3331			err = -ENOMEM;
  3332			goto out_free_id;
  3333		}
  3334	
  3335		bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING_MULTI,
  3336			      &bpf_tracing_multi_link_lops, prog);
  3337		link->attach_type = prog->expected_attach_type;
  3338	
  3339		err = bpf_link_prime(&link->link, &link_primer);
  3340		if (err) {
  3341			kfree(link);
  3342			goto out_free_id;
  3343		}
  3344	
  3345		link->id = id;
  3346		link->tp.cookie = 0;
  3347		link->tp.prog = prog;
  3348	
  3349		err = bpf_trampoline_multi_attach(&link->tp, id);
  3350		if (err) {
  3351			bpf_link_cleanup(&link_primer);
  3352			goto out_free_id;
  3353		}
  3354		return bpf_link_settle(&link_primer);
  3355	out_free_id:
  3356		kfree(id);
  3357		return err;
  3358	}
  3359	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
