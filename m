Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C033858381E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 07:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiG1FUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 01:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiG1FUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 01:20:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335545142B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658985647; x=1690521647;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HD4+CaAjihKbuf3BU930eUtTTwQm9V6MlayuL3aVnsE=;
  b=An/pz9Ij12MrxU94IAGN/VRL+ZrWvFDxLZm+PwmnG9kJMqHHC/IRGlZz
   4qfLe4ROUBDVTur+GdzeP4EFNutUtKLBZS3jAAhoQGOucE9AyRH0hENh2
   c5nr04EpsVJaWqgFymM8qhl/Ver+oplxmcoP/dmckz9IDXTuXan2cRzFe
   5vVwSrFFVRd4qwIPr+Xvxf3E7qWqHGHP33M85l1CXP5zMt0r1Fefw165B
   4cqjYscZqKPp30Dzpd9f0zYkwAtCGlk7mQpAO+cB14+QuPgfiPoKZWZFb
   hx/fk66RwBHH8yjQdkSIola2snypFJqvPliJ20V5yPrvhgJYnExE8zDw8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="288435847"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="288435847"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 22:20:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="928112590"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2022 22:20:45 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGvwy-0009iQ-26;
        Thu, 28 Jul 2022 05:20:44 +0000
Date:   Thu, 28 Jul 2022 13:19:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 24/34] kernel/bpf/syscall.c:3157:15:
 error: call to undeclared function 'bpf_trampoline_multi_detach'; ISO C99
 and later do not support implicit function declarations
Message-ID: <202207281330.rTwELUls-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_4
head:   1637b6b5bec11596e52cdc0a6eadfa45a15276c3
commit: ddb4a6defabce7658e7c6be7397bd5e714279b48 [24/34] bpf: Add support for tracing multi link
config: hexagon-randconfig-r041-20220728 (https://download.01.org/0day-ci/archive/20220728/202207281330.rTwELUls-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=ddb4a6defabce7658e7c6be7397bd5e714279b48
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_4
        git checkout ddb4a6defabce7658e7c6be7397bd5e714279b48
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c:2523:15: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           multi_func = is_tracing_multi(attr->expected_attach_type);
                        ^
>> kernel/bpf/syscall.c:3157:15: error: call to undeclared function 'bpf_trampoline_multi_detach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
                        ^
>> kernel/bpf/syscall.c:3165:2: error: call to undeclared function 'bpf_tramp_id_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           bpf_tramp_id_put(tr_link->id);
           ^
   kernel/bpf/syscall.c:3165:2: note: did you mean 'bpf_trampoline_put'?
   include/linux/bpf.h:1021:20: note: 'bpf_trampoline_put' declared here
   static inline void bpf_trampoline_put(struct bpf_trampoline *tr) {}
                      ^
>> kernel/bpf/syscall.c:3328:7: error: call to undeclared function 'bpf_tramp_id_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           id = bpf_tramp_id_alloc(cnt);
                ^
>> kernel/bpf/syscall.c:3328:5: error: incompatible integer to pointer conversion assigning to 'struct bpf_tramp_id *' from 'int' [-Wint-conversion]
           id = bpf_tramp_id_alloc(cnt);
              ^ ~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/syscall.c:3369:8: error: call to undeclared function 'bpf_trampoline_multi_attach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           err = bpf_trampoline_multi_attach(&link->tp, id);
                 ^
   kernel/bpf/syscall.c:3369:8: note: did you mean 'bpf_tracing_multi_attach'?
   kernel/bpf/syscall.c:3313:12: note: 'bpf_tracing_multi_attach' declared here
   static int bpf_tracing_multi_attach(struct bpf_prog *prog,
              ^
   kernel/bpf/syscall.c:4841:12: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   else if (is_tracing_multi(prog->expected_attach_type))
                            ^
   7 errors generated.


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
