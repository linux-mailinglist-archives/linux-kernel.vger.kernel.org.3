Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674C4585461
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbiG2RXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbiG2RXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:23:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2EA7FE60
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659115394; x=1690651394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T4U+87oXNpKGLwJTRRtJF3iwfxN3l89/0/Wv2F8eg98=;
  b=HAPeu68VdthvhQPKGrABiWsvttOaX9lvJqN2K3bhZ0XyIhFrmqDn/Hqr
   i9ZuofXOj1Tn8P2Sg9zjdET5xRuygdihHEPSMa43l0KZlQbM7O7RGNzAT
   Eu6MRxZJP9VrbsevkZPd1B4IkMo0dp4W4q9aDv0lN6TBznDnIyzUI5/qx
   E9yL39mY4iqL3tvLGkCpUm0ps9QFdbocDf1XtzThBx2d7dZAb5hZ2D636
   YazNUbMDcP+byPsBVN3NHiDIGVwUTwsiX/p2W24CF7R5Ddfplk4zWhx8F
   K07YfAv0eyTnAnMWk/E5UvXqDVJB/lvlkLMrfpZ6AQAV9ewAsHZwMW7Kh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="314616969"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="314616969"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 10:23:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="551803975"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Jul 2022 10:23:12 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHThg-000Bun-0W;
        Fri, 29 Jul 2022 17:23:12 +0000
Date:   Sat, 30 Jul 2022 01:22:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 12/35]
 arch/arm64/net/bpf_jit_comp.c:1724:27: error: invalid use of undefined type
 'struct bpf_tramp_links'
Message-ID: <202207300142.GpJOtWon-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_4
head:   a63fc296e166a76b3f7250a966df4651e3a846f1
commit: 7f6c8f779fa321cbbaf9cafeeb1cd0e2bdc4de36 [12/35] bpf: Replace bpf_tramp_link with bpf_tramp_prog
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220730/202207300142.GpJOtWon-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/net/bpf_jit_comp.c:1714:60: warning: 'struct bpf_tramp_links' declared inside parameter list will not be visible outside of this definition or declaration
    1714 | static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
         |                                                            ^~~~~~~~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c: In function 'invoke_bpf_mod_ret':
>> arch/arm64/net/bpf_jit_comp.c:1724:27: error: invalid use of undefined type 'struct bpf_tramp_links'
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
>> arch/arm64/net/bpf_jit_comp.c:1900:41: error: passing argument 2 of 'invoke_bpf_mod_ret' from incompatible pointer type [-Werror=incompatible-pointer-types]
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
>> arch/arm64/net/bpf_jit_comp.c:1968:5: error: conflicting types for 'arch_prepare_bpf_trampoline'; have 'int(struct bpf_tramp_image *, void *, void *, const struct btf_func_model *, u32,  struct bpf_tramp_links *, void *)' {aka 'int(struct bpf_tramp_image *, void *, void *, const struct btf_func_model *, unsigned int,  struct bpf_tramp_links *, void *)'}
    1968 | int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/net/bpf_jit_comp.c:11:
   include/linux/bpf.h:803:5: note: previous declaration of 'arch_prepare_bpf_trampoline' with type 'int(struct bpf_tramp_image *, void *, void *, const struct btf_func_model *, u32,  struct bpf_tramp_progs *, void *)' {aka 'int(struct bpf_tramp_image *, void *, void *, const struct btf_func_model *, unsigned int,  struct bpf_tramp_progs *, void *)'}
     803 | int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *image_end,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/net/bpf_jit_comp.c: In function 'arch_prepare_bpf_trampoline':
>> arch/arm64/net/bpf_jit_comp.c:1985:44: error: passing argument 3 of 'prepare_trampoline' from incompatible pointer type [-Werror=incompatible-pointer-types]
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


vim +1724 arch/arm64/net/bpf_jit_comp.c

efc9909fdce00a8 Xu Kuohai 2022-07-11  1713  
efc9909fdce00a8 Xu Kuohai 2022-07-11 @1714  static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
efc9909fdce00a8 Xu Kuohai 2022-07-11  1715  			       int args_off, int retval_off, int run_ctx_off,
efc9909fdce00a8 Xu Kuohai 2022-07-11  1716  			       u32 **branches)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1717  {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1718  	int i;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1719  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1720  	/* The first fmod_ret program will receive a garbage return value.
efc9909fdce00a8 Xu Kuohai 2022-07-11  1721  	 * Set this to 0 to avoid confusing the program.
efc9909fdce00a8 Xu Kuohai 2022-07-11  1722  	 */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1723  	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11 @1724  	for (i = 0; i < tl->nr_links; i++) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1725  		invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
efc9909fdce00a8 Xu Kuohai 2022-07-11  1726  				run_ctx_off, true);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1727  		/* if (*(u64 *)(sp + retval_off) !=  0)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1728  		 *	goto do_fexit;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1729  		 */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1730  		emit(A64_LDR64I(A64_R(10), A64_SP, retval_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1731  		/* Save the location of branch, and generate a nop.
efc9909fdce00a8 Xu Kuohai 2022-07-11  1732  		 * This nop will be replaced with a cbnz later.
efc9909fdce00a8 Xu Kuohai 2022-07-11  1733  		 */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1734  		branches[i] = ctx->image + ctx->idx;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1735  		emit(A64_NOP, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1736  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1737  }
efc9909fdce00a8 Xu Kuohai 2022-07-11  1738  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1739  static void save_args(struct jit_ctx *ctx, int args_off, int nargs)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1740  {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1741  	int i;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1742  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1743  	for (i = 0; i < nargs; i++) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1744  		emit(A64_STR64I(i, A64_SP, args_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1745  		args_off += 8;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1746  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1747  }
efc9909fdce00a8 Xu Kuohai 2022-07-11  1748  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1749  static void restore_args(struct jit_ctx *ctx, int args_off, int nargs)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1750  {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1751  	int i;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1752  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1753  	for (i = 0; i < nargs; i++) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1754  		emit(A64_LDR64I(i, A64_SP, args_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1755  		args_off += 8;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1756  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1757  }
efc9909fdce00a8 Xu Kuohai 2022-07-11  1758  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1759  /* Based on the x86's implementation of arch_prepare_bpf_trampoline().
efc9909fdce00a8 Xu Kuohai 2022-07-11  1760   *
efc9909fdce00a8 Xu Kuohai 2022-07-11  1761   * bpf prog and function entry before bpf trampoline hooked:
efc9909fdce00a8 Xu Kuohai 2022-07-11  1762   *   mov x9, lr
efc9909fdce00a8 Xu Kuohai 2022-07-11  1763   *   nop
efc9909fdce00a8 Xu Kuohai 2022-07-11  1764   *
efc9909fdce00a8 Xu Kuohai 2022-07-11  1765   * bpf prog and function entry after bpf trampoline hooked:
efc9909fdce00a8 Xu Kuohai 2022-07-11  1766   *   mov x9, lr
efc9909fdce00a8 Xu Kuohai 2022-07-11  1767   *   bl  <bpf_trampoline or plt>
efc9909fdce00a8 Xu Kuohai 2022-07-11  1768   *
efc9909fdce00a8 Xu Kuohai 2022-07-11  1769   */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1770  static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
efc9909fdce00a8 Xu Kuohai 2022-07-11  1771  			      struct bpf_tramp_links *tlinks, void *orig_call,
efc9909fdce00a8 Xu Kuohai 2022-07-11  1772  			      int nargs, u32 flags)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1773  {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1774  	int i;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1775  	int stack_size;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1776  	int retaddr_off;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1777  	int regs_off;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1778  	int retval_off;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1779  	int args_off;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1780  	int nargs_off;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1781  	int ip_off;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1782  	int run_ctx_off;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1783  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
efc9909fdce00a8 Xu Kuohai 2022-07-11  1784  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
efc9909fdce00a8 Xu Kuohai 2022-07-11  1785  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
efc9909fdce00a8 Xu Kuohai 2022-07-11  1786  	bool save_ret;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1787  	u32 **branches = NULL;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1788  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1789  	/* trampoline stack layout:
efc9909fdce00a8 Xu Kuohai 2022-07-11  1790  	 *                  [ parent ip         ]
efc9909fdce00a8 Xu Kuohai 2022-07-11  1791  	 *                  [ FP                ]
efc9909fdce00a8 Xu Kuohai 2022-07-11  1792  	 * SP + retaddr_off [ self ip           ]
efc9909fdce00a8 Xu Kuohai 2022-07-11  1793  	 *                  [ FP                ]
efc9909fdce00a8 Xu Kuohai 2022-07-11  1794  	 *
efc9909fdce00a8 Xu Kuohai 2022-07-11  1795  	 *                  [ padding           ] align SP to multiples of 16
efc9909fdce00a8 Xu Kuohai 2022-07-11  1796  	 *
efc9909fdce00a8 Xu Kuohai 2022-07-11  1797  	 *                  [ x20               ] callee saved reg x20
efc9909fdce00a8 Xu Kuohai 2022-07-11  1798  	 * SP + regs_off    [ x19               ] callee saved reg x19
efc9909fdce00a8 Xu Kuohai 2022-07-11  1799  	 *
efc9909fdce00a8 Xu Kuohai 2022-07-11  1800  	 * SP + retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
efc9909fdce00a8 Xu Kuohai 2022-07-11  1801  	 *                                        BPF_TRAMP_F_RET_FENTRY_RET
efc9909fdce00a8 Xu Kuohai 2022-07-11  1802  	 *
efc9909fdce00a8 Xu Kuohai 2022-07-11  1803  	 *                  [ argN              ]
efc9909fdce00a8 Xu Kuohai 2022-07-11  1804  	 *                  [ ...               ]
efc9909fdce00a8 Xu Kuohai 2022-07-11  1805  	 * SP + args_off    [ arg1              ]
efc9909fdce00a8 Xu Kuohai 2022-07-11  1806  	 *
efc9909fdce00a8 Xu Kuohai 2022-07-11  1807  	 * SP + nargs_off   [ args count        ]
efc9909fdce00a8 Xu Kuohai 2022-07-11  1808  	 *
efc9909fdce00a8 Xu Kuohai 2022-07-11  1809  	 * SP + ip_off      [ traced function   ] BPF_TRAMP_F_IP_ARG flag
efc9909fdce00a8 Xu Kuohai 2022-07-11  1810  	 *
efc9909fdce00a8 Xu Kuohai 2022-07-11  1811  	 * SP + run_ctx_off [ bpf_tramp_run_ctx ]
efc9909fdce00a8 Xu Kuohai 2022-07-11  1812  	 */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1813  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1814  	stack_size = 0;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1815  	run_ctx_off = stack_size;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1816  	/* room for bpf_tramp_run_ctx */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1817  	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1818  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1819  	ip_off = stack_size;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1820  	/* room for IP address argument */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1821  	if (flags & BPF_TRAMP_F_IP_ARG)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1822  		stack_size += 8;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1823  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1824  	nargs_off = stack_size;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1825  	/* room for args count */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1826  	stack_size += 8;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1827  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1828  	args_off = stack_size;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1829  	/* room for args */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1830  	stack_size += nargs * 8;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1831  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1832  	/* room for return value */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1833  	retval_off = stack_size;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1834  	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1835  	if (save_ret)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1836  		stack_size += 8;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1837  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1838  	/* room for callee saved registers, currently x19 and x20 are used */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1839  	regs_off = stack_size;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1840  	stack_size += 16;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1841  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1842  	/* round up to multiples of 16 to avoid SPAlignmentFault */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1843  	stack_size = round_up(stack_size, 16);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1844  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1845  	/* return address locates above FP */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1846  	retaddr_off = stack_size + 8;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1847  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1848  	/* bpf trampoline may be invoked by 3 instruction types:
efc9909fdce00a8 Xu Kuohai 2022-07-11  1849  	 * 1. bl, attached to bpf prog or kernel function via short jump
efc9909fdce00a8 Xu Kuohai 2022-07-11  1850  	 * 2. br, attached to bpf prog or kernel function via long jump
efc9909fdce00a8 Xu Kuohai 2022-07-11  1851  	 * 3. blr, working as a function pointer, used by struct_ops.
efc9909fdce00a8 Xu Kuohai 2022-07-11  1852  	 * So BTI_JC should used here to support both br and blr.
efc9909fdce00a8 Xu Kuohai 2022-07-11  1853  	 */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1854  	emit_bti(A64_BTI_JC, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1855  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1856  	/* frame for parent function */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1857  	emit(A64_PUSH(A64_FP, A64_R(9), A64_SP), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1858  	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1859  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1860  	/* frame for patched function */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1861  	emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1862  	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1863  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1864  	/* allocate stack space */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1865  	emit(A64_SUB_I(1, A64_SP, A64_SP, stack_size), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1866  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1867  	if (flags & BPF_TRAMP_F_IP_ARG) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1868  		/* save ip address of the traced function */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1869  		emit_addr_mov_i64(A64_R(10), (const u64)orig_call, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1870  		emit(A64_STR64I(A64_R(10), A64_SP, ip_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1871  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1872  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1873  	/* save args count*/
efc9909fdce00a8 Xu Kuohai 2022-07-11  1874  	emit(A64_MOVZ(1, A64_R(10), nargs, 0), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1875  	emit(A64_STR64I(A64_R(10), A64_SP, nargs_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1876  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1877  	/* save args */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1878  	save_args(ctx, args_off, nargs);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1879  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1880  	/* save callee saved registers */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1881  	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1882  	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1883  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1884  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1885  		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1886  		emit_call((const u64)__bpf_tramp_enter, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1887  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1888  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1889  	for (i = 0; i < fentry->nr_links; i++)
efc9909fdce00a8 Xu Kuohai 2022-07-11 @1890  		invoke_bpf_prog(ctx, fentry->links[i], args_off,
efc9909fdce00a8 Xu Kuohai 2022-07-11  1891  				retval_off, run_ctx_off,
efc9909fdce00a8 Xu Kuohai 2022-07-11  1892  				flags & BPF_TRAMP_F_RET_FENTRY_RET);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1893  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1894  	if (fmod_ret->nr_links) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1895  		branches = kcalloc(fmod_ret->nr_links, sizeof(u32 *),
efc9909fdce00a8 Xu Kuohai 2022-07-11  1896  				   GFP_KERNEL);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1897  		if (!branches)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1898  			return -ENOMEM;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1899  
efc9909fdce00a8 Xu Kuohai 2022-07-11 @1900  		invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,
efc9909fdce00a8 Xu Kuohai 2022-07-11  1901  				   run_ctx_off, branches);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1902  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1903  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1904  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1905  		restore_args(ctx, args_off, nargs);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1906  		/* call original func */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1907  		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1908  		emit(A64_BLR(A64_R(10)), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1909  		/* store return value */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1910  		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1911  		/* reserve a nop for bpf_tramp_image_put */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1912  		im->ip_after_call = ctx->image + ctx->idx;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1913  		emit(A64_NOP, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1914  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1915  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1916  	/* update the branches saved in invoke_bpf_mod_ret with cbnz */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1917  	for (i = 0; i < fmod_ret->nr_links && ctx->image != NULL; i++) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1918  		int offset = &ctx->image[ctx->idx] - branches[i];
efc9909fdce00a8 Xu Kuohai 2022-07-11  1919  		*branches[i] = A64_CBNZ(1, A64_R(10), offset);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1920  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1921  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1922  	for (i = 0; i < fexit->nr_links; i++)
efc9909fdce00a8 Xu Kuohai 2022-07-11 @1923  		invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off,
efc9909fdce00a8 Xu Kuohai 2022-07-11  1924  				run_ctx_off, false);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1925  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1926  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1927  		im->ip_epilogue = ctx->image + ctx->idx;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1928  		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1929  		emit_call((const u64)__bpf_tramp_exit, ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1930  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1931  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1932  	if (flags & BPF_TRAMP_F_RESTORE_REGS)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1933  		restore_args(ctx, args_off, nargs);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1934  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1935  	/* restore callee saved register x19 and x20 */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1936  	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1937  	emit(A64_LDR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1938  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1939  	if (save_ret)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1940  		emit(A64_LDR64I(A64_R(0), A64_SP, retval_off), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1941  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1942  	/* reset SP  */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1943  	emit(A64_MOV(1, A64_SP, A64_FP), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1944  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1945  	/* pop frames  */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1946  	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1947  	emit(A64_POP(A64_FP, A64_R(9), A64_SP), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1948  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1949  	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1950  		/* skip patched function, return to parent */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1951  		emit(A64_MOV(1, A64_LR, A64_R(9)), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1952  		emit(A64_RET(A64_R(9)), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1953  	} else {
efc9909fdce00a8 Xu Kuohai 2022-07-11  1954  		/* return to patched function */
efc9909fdce00a8 Xu Kuohai 2022-07-11  1955  		emit(A64_MOV(1, A64_R(10), A64_LR), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1956  		emit(A64_MOV(1, A64_LR, A64_R(9)), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1957  		emit(A64_RET(A64_R(10)), ctx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1958  	}
efc9909fdce00a8 Xu Kuohai 2022-07-11  1959  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1960  	if (ctx->image)
efc9909fdce00a8 Xu Kuohai 2022-07-11  1961  		bpf_flush_icache(ctx->image, ctx->image + ctx->idx);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1962  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1963  	kfree(branches);
efc9909fdce00a8 Xu Kuohai 2022-07-11  1964  
efc9909fdce00a8 Xu Kuohai 2022-07-11  1965  	return ctx->idx;
efc9909fdce00a8 Xu Kuohai 2022-07-11  1966  }
efc9909fdce00a8 Xu Kuohai 2022-07-11  1967  

:::::: The code at line 1724 was first introduced by commit
:::::: efc9909fdce00a827a37609628223cd45bf95d0b bpf, arm64: Add bpf trampoline for arm64

:::::: TO: Xu Kuohai <xukuohai@huawei.com>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
