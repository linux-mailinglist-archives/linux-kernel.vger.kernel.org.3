Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EB95855CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiG2T4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiG2T4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:56:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE6387C20
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659124581; x=1690660581;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=51tgDkbcmMQ+yGrKQ0Ym9GKQl+AxqXPWfAbwLuO6p64=;
  b=ivGTFHvWXtNYKpBjvMYjJDgTVDWCRoOqGTRz3wzRYFlWfGVWKWL3fuXo
   a0XJO6xl5ltKoysNWMgqfjQ6BAEjAy5zc2gE4syCf3FEzGCczdtFk2+mY
   CbkgjUfEPaAue9E8QLQohVzq3hzLuBz3LfFep15Lx4bAz49onX27jxsc4
   G/gwf29b8HN9xbr53c5YaTde4TbNEFjJLxo0TmJBMYoiGoMuNc5jxU1MZ
   mPBNC/oGjBtbDgEkIC1CPofJFkelyfOqkkbrWlPbhAC1btpTE32CYFkvM
   COoi+YuwsjqxXqSics/kBAvT3KTeDmnGyTQ+ignytK9p7sW6OmRjcbVJr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="288850492"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="288850492"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 12:56:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="928853971"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2022 12:56:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHW5r-000C2n-36;
        Fri, 29 Jul 2022 19:56:19 +0000
Date:   Sat, 30 Jul 2022 03:56:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 13/35]
 arch/arm64/net/bpf_jit_comp.c:1649:31: error: invalid use of undefined type
 'struct bpf_tramp_link'
Message-ID: <202207300324.4CWYdwgw-lkp@intel.com>
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
head:   a63fc296e166a76b3f7250a966df4651e3a846f1
commit: 26d4fcc23a14c838c4568a38b8d47bb7a92f0a8b [13/35] bpf: Store trampoline progs in arrays
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220730/202207300324.4CWYdwgw-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=26d4fcc23a14c838c4568a38b8d47bb7a92f0a8b
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_4
        git checkout 26d4fcc23a14c838c4568a38b8d47bb7a92f0a8b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/net/bpf_jit_comp.c:1642:57: warning: 'struct bpf_tramp_link' declared inside parameter list will not be visible outside of this definition or declaration
    1642 | static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
         |                                                         ^~~~~~~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c: In function 'invoke_bpf_prog':
>> arch/arm64/net/bpf_jit_comp.c:1649:31: error: invalid use of undefined type 'struct bpf_tramp_link'
    1649 |         struct bpf_prog *p = l->link.prog;
         |                               ^~
   arch/arm64/net/bpf_jit_comp.c:1660:14: error: invalid use of undefined type 'struct bpf_tramp_link'
    1660 |         if (l->cookie == 0) {
         |              ^~
   arch/arm64/net/bpf_jit_comp.c:1664:46: error: invalid use of undefined type 'struct bpf_tramp_link'
    1664 |                 emit_a64_mov_i64(A64_R(10), l->cookie, ctx);
         |                                              ^~
   arch/arm64/net/bpf_jit_comp.c: At top level:
   arch/arm64/net/bpf_jit_comp.c:1714:60: warning: 'struct bpf_tramp_links' declared inside parameter list will not be visible outside of this definition or declaration
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


vim +1649 arch/arm64/net/bpf_jit_comp.c

b2ad54e1533e914 Xu Kuohai 2022-07-11  1641  
efc9909fdce00a8 Xu Kuohai 2022-07-11 @1642  static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
efc9909fdce00a8 Xu Kuohai 2022-07-11  1643  			    int args_off, int retval_off, int run_ctx_off,
efc9909fdce00a8 Xu Kuohai 2022-07-11  1644  			    bool save_ret)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1645  {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1646  	u32 *branch;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1647  	u64 enter_prog;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1648  	u64 exit_prog;
efc9909fdce00a8 Xu Kuohai 2022-07-11 @1649  	struct bpf_prog *p = l->link.prog;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1650  	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1651  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1652  	if (p->aux->sleepable) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1653  		enter_prog = (u64)__bpf_prog_enter_sleepable;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1654  		exit_prog = (u64)__bpf_prog_exit_sleepable;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1655  	} else {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1656  		enter_prog = (u64)__bpf_prog_enter;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1657  		exit_prog = (u64)__bpf_prog_exit;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1658  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1659  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1660  	if (l->cookie == 0) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1661  		/* if cookie is zero, one instruction is enough to store it */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1662  		emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1663  	} else {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1664  		emit_a64_mov_i64(A64_R(10), l->cookie, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1665  		emit(A64_STR64I(A64_R(10), A64_SP, run_ctx_off + cookie_off),
efc9909fdce00a8 Xu Kuohai 2022-07-11  1666  		     ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1667  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1668  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1669  	/* save p to callee saved register x19 to avoid loading p with mov_i64
efc9909fdce00a8 Xu Kuohai 2022-07-11  1670  	 * each time.
efc9909fdce00a8 Xu Kuohai 2022-07-11  1671  	 */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1672  	emit_addr_mov_i64(A64_R(19), (const u64)p, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1673  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1674  	/* arg1: prog */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1675  	emit(A64_MOV(1, A64_R(0), A64_R(19)), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1676  	/* arg2: &run_ctx */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1677  	emit(A64_ADD_I(1, A64_R(1), A64_SP, run_ctx_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1678  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1679  	emit_call(enter_prog, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1680  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1681  	/* if (__bpf_prog_enter(prog) == 0)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1682  	 *         goto skip_exec_of_prog;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1683  	 */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1684  	branch = ctx->image + ctx->idx;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1685  	emit(A64_NOP, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1686  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1687  	/* save return value to callee saved register x20 */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1688  	emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1689  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1690  	emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1691  	if (!p->jited)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1692  		emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1693  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1694  	emit_call((const u64)p->bpf_func, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1695  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1696  	if (save_ret)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1697  		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1698  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1699  	if (ctx->image) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1700  		int offset = &ctx->image[ctx->idx] - branch;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1701  		*branch = A64_CBZ(1, A64_R(0), offset);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1702  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1703  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1704  	/* arg1: prog */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1705  	emit(A64_MOV(1, A64_R(0), A64_R(19)), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1706  	/* arg2: start time */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1707  	emit(A64_MOV(1, A64_R(1), A64_R(20)), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1708  	/* arg3: &run_ctx */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1709  	emit(A64_ADD_I(1, A64_R(2), A64_SP, run_ctx_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1710  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1711  	emit_call(exit_prog, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1712  }
efc9909fdce00a8 Xu Kuohai 2022-07-11  1713  

:::::: The code at line 1649 was first introduced by commit
:::::: efc9909fdce00a827a37609628223cd45bf95d0b bpf, arm64: Add bpf trampoline for arm64

:::::: TO: Xu Kuohai <xukuohai@huawei.com>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
