Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522CB58523F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiG2PUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiG2PUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:20:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A1C6413
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659108017; x=1690644017;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LuvWz7xGeiM0KAFgMd+Y7oCHX7Mdhlc4Vyl9xxmtLQc=;
  b=fxyTPNTYDezSeW+ImFhWx4JuOwQIuQhd8a+WofEEsvNauUDF3JT5lUy+
   kxeTJF7pz6iy3e2c2aJNYCsuvr+GDesrjzQQeEDemFUaHW3qE9xc5aQ7e
   oHrB+ZwhS/t8PD+xwQELbRgau2Hk16XhydYtuYecCPmeMF5ubyIchDtNF
   Sw6vQftU7BqZ7UEJ7Uob7qlZMhqPEnzuULWPQH6BhAPc91dE4mZBibeMe
   UYEGNSJ1NtKZt6IwYqjfBldY2+i097NFwxcxlJrQD0H2KeujHTULKSFc2
   G54ZF1WCR9oJlF0XGxePYTAQl1rGRtmmU3bvpu3cdqYrj3jqhHM8S28ud
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="375089548"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="375089548"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 08:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="928775870"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2022 08:20:06 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHRmY-000Bm9-0V;
        Fri, 29 Jul 2022 15:20:06 +0000
Date:   Fri, 29 Jul 2022 23:19:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 12/35]
 arch/arm64/net/bpf_jit_comp.c:1714:60: warning: 'struct bpf_tramp_links'
 declared inside parameter list will not be visible outside of this
 definition or declaration
Message-ID: <202207292335.Pl6WcNW4-lkp@intel.com>
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
commit: 7f6c8f779fa321cbbaf9cafeeb1cd0e2bdc4de36 [12/35] bpf: Replace bpf_tramp_link with bpf_tramp_prog
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220729/202207292335.Pl6WcNW4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=7f6c8f779fa321cbbaf9cafeeb1cd0e2bdc4de36
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_4
        git checkout 7f6c8f779fa321cbbaf9cafeeb1cd0e2bdc4de36
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/net/bpf_jit_comp.c:1714:60: warning: 'struct bpf_tramp_links' declared inside parameter list will not be visible outside of this definition or declaration
    1714 | static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
         |                                                            ^~~~~~~~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c: In function 'invoke_bpf_mod_ret':
   arch/arm64/net/bpf_jit_comp.c:1724:27: error: invalid use of undefined type 'struct bpf_tramp_links'
    1724 |         for (i = 0; i < tl->nr_links; i++) {
         |                           ^~
   arch/arm64/net/bpf_jit_comp.c:1725:40: error: invalid use of undefined type 'struct bpf_tramp_links'
    1725 |                 invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
         |                                        ^~
   arch/arm64/net/bpf_jit_comp.c: At top level:
   arch/arm64/net/bpf_jit_comp.c:1771:38: warning: 'struct bpf_tramp_links' declared inside parameter list will not be visible outside of this definition or declaration
    1771 |                               struct bpf_tramp_links *tlinks, void *orig_call,
         |                                      ^~~~~~~~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c: In function 'prepare_trampoline':
   arch/arm64/net/bpf_jit_comp.c:1783:49: error: invalid use of undefined type 'struct bpf_tramp_links'
    1783 |         struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
         |                                                 ^
   arch/arm64/net/bpf_jit_comp.c:1784:48: error: invalid use of undefined type 'struct bpf_tramp_links'
    1784 |         struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
         |                                                ^
   arch/arm64/net/bpf_jit_comp.c:1785:51: error: invalid use of undefined type 'struct bpf_tramp_links'
    1785 |         struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
         |                                                   ^
   arch/arm64/net/bpf_jit_comp.c:1889:31: error: invalid use of undefined type 'struct bpf_tramp_links'
    1889 |         for (i = 0; i < fentry->nr_links; i++)
         |                               ^~
   arch/arm64/net/bpf_jit_comp.c:1890:44: error: invalid use of undefined type 'struct bpf_tramp_links'
    1890 |                 invoke_bpf_prog(ctx, fentry->links[i], args_off,
         |                                            ^~
   arch/arm64/net/bpf_jit_comp.c:1894:21: error: invalid use of undefined type 'struct bpf_tramp_links'
    1894 |         if (fmod_ret->nr_links) {
         |                     ^~
   arch/arm64/net/bpf_jit_comp.c:1895:44: error: invalid use of undefined type 'struct bpf_tramp_links'
    1895 |                 branches = kcalloc(fmod_ret->nr_links, sizeof(u32 *),
         |                                            ^~
   arch/arm64/net/bpf_jit_comp.c:1900:41: error: passing argument 2 of 'invoke_bpf_mod_ret' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1900 |                 invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,
         |                                         ^~~~~~~~
         |                                         |
         |                                         struct bpf_tramp_links *
   arch/arm64/net/bpf_jit_comp.c:1714:77: note: expected 'struct bpf_tramp_links *' but argument is of type 'struct bpf_tramp_links *'
    1714 | static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
         |                                                     ~~~~~~~~~~~~~~~~~~~~~~~~^~
   arch/arm64/net/bpf_jit_comp.c:1917:33: error: invalid use of undefined type 'struct bpf_tramp_links'
    1917 |         for (i = 0; i < fmod_ret->nr_links && ctx->image != NULL; i++) {
         |                                 ^~
   arch/arm64/net/bpf_jit_comp.c:1922:30: error: invalid use of undefined type 'struct bpf_tramp_links'
    1922 |         for (i = 0; i < fexit->nr_links; i++)
         |                              ^~
   arch/arm64/net/bpf_jit_comp.c:1923:43: error: invalid use of undefined type 'struct bpf_tramp_links'
    1923 |                 invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off,
         |                                           ^~
   arch/arm64/net/bpf_jit_comp.c: At top level:
   arch/arm64/net/bpf_jit_comp.c:1970:51: warning: 'struct bpf_tramp_links' declared inside parameter list will not be visible outside of this definition or declaration
    1970 |                                 u32 flags, struct bpf_tramp_links *tlinks,
         |                                                   ^~~~~~~~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c:1968:5: error: conflicting types for 'arch_prepare_bpf_trampoline'; have 'int(struct bpf_tramp_image *, void *, void *, const struct btf_func_model *, u32,  struct bpf_tramp_links *, void *)' {aka 'int(struct bpf_tramp_image *, void *, void *, const struct btf_func_model *, unsigned int,  struct bpf_tramp_links *, void *)'}
    1968 | int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/net/bpf_jit_comp.c:11:
   include/linux/bpf.h:803:5: note: previous declaration of 'arch_prepare_bpf_trampoline' with type 'int(struct bpf_tramp_image *, void *, void *, const struct btf_func_model *, u32,  struct bpf_tramp_progs *, void *)' {aka 'int(struct bpf_tramp_image *, void *, void *, const struct btf_func_model *, unsigned int,  struct bpf_tramp_progs *, void *)'}
     803 | int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *image_end,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c: In function 'arch_prepare_bpf_trampoline':
   arch/arm64/net/bpf_jit_comp.c:1985:44: error: passing argument 3 of 'prepare_trampoline' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1985 |         ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
         |                                            ^~~~~~
         |                                            |
         |                                            struct bpf_tramp_links *
   arch/arm64/net/bpf_jit_comp.c:1771:55: note: expected 'struct bpf_tramp_links *' but argument is of type 'struct bpf_tramp_links *'
    1771 |                               struct bpf_tramp_links *tlinks, void *orig_call,
         |                               ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   arch/arm64/net/bpf_jit_comp.c:1996:44: error: passing argument 3 of 'prepare_trampoline' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1996 |         ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
         |                                            ^~~~~~
         |                                            |
         |                                            struct bpf_tramp_links *
   arch/arm64/net/bpf_jit_comp.c:1771:55: note: expected 'struct bpf_tramp_links *' but argument is of type 'struct bpf_tramp_links *'
    1771 |                               struct bpf_tramp_links *tlinks, void *orig_call,
         |                               ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   cc1: some warnings being treated as errors


vim +1714 arch/arm64/net/bpf_jit_comp.c

efc9909fdce00a Xu Kuohai 2022-07-11  1713  
efc9909fdce00a Xu Kuohai 2022-07-11 @1714  static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
efc9909fdce00a Xu Kuohai 2022-07-11  1715  			       int args_off, int retval_off, int run_ctx_off,
efc9909fdce00a Xu Kuohai 2022-07-11  1716  			       u32 **branches)
efc9909fdce00a Xu Kuohai 2022-07-11  1717  {
efc9909fdce00a Xu Kuohai 2022-07-11  1718  	int i;
efc9909fdce00a Xu Kuohai 2022-07-11  1719  
efc9909fdce00a Xu Kuohai 2022-07-11  1720  	/* The first fmod_ret program will receive a garbage return value.
efc9909fdce00a Xu Kuohai 2022-07-11  1721  	 * Set this to 0 to avoid confusing the program.
efc9909fdce00a Xu Kuohai 2022-07-11  1722  	 */
efc9909fdce00a Xu Kuohai 2022-07-11  1723  	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
efc9909fdce00a Xu Kuohai 2022-07-11  1724  	for (i = 0; i < tl->nr_links; i++) {
efc9909fdce00a Xu Kuohai 2022-07-11  1725  		invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
efc9909fdce00a Xu Kuohai 2022-07-11  1726  				run_ctx_off, true);
efc9909fdce00a Xu Kuohai 2022-07-11  1727  		/* if (*(u64 *)(sp + retval_off) !=  0)
efc9909fdce00a Xu Kuohai 2022-07-11  1728  		 *	goto do_fexit;
efc9909fdce00a Xu Kuohai 2022-07-11  1729  		 */
efc9909fdce00a Xu Kuohai 2022-07-11  1730  		emit(A64_LDR64I(A64_R(10), A64_SP, retval_off), ctx);
efc9909fdce00a Xu Kuohai 2022-07-11  1731  		/* Save the location of branch, and generate a nop.
efc9909fdce00a Xu Kuohai 2022-07-11  1732  		 * This nop will be replaced with a cbnz later.
efc9909fdce00a Xu Kuohai 2022-07-11  1733  		 */
efc9909fdce00a Xu Kuohai 2022-07-11  1734  		branches[i] = ctx->image + ctx->idx;
efc9909fdce00a Xu Kuohai 2022-07-11  1735  		emit(A64_NOP, ctx);
efc9909fdce00a Xu Kuohai 2022-07-11  1736  	}
efc9909fdce00a Xu Kuohai 2022-07-11  1737  }
efc9909fdce00a Xu Kuohai 2022-07-11  1738  

:::::: The code at line 1714 was first introduced by commit
:::::: efc9909fdce00a827a37609628223cd45bf95d0b bpf, arm64: Add bpf trampoline for arm64

:::::: TO: Xu Kuohai <xukuohai@huawei.com>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
