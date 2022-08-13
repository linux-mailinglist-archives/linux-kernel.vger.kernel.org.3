Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92210591B37
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbiHMPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiHMPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:11:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB9B13CE6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660403483; x=1691939483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KPoPqxlKV5bv3IEaAd1mNXRvskXDUBnSwowfO+SwH0w=;
  b=fROTOi8i+U4FsDS15UY9tG5GclFnlm/j88ul/uxse0hgF/44dbEonaj4
   V4nDS4U0XIaodypE+jzYUFYazr3yKch8Z/Q0pO8vaLIcxqZaV1WlwfYbM
   hXDQU87grj3eSIsRQQQr4tsQt8D4zOHaui4quoI5Ofy3RE+KHHK/tq+ne
   6bkm2oWw9M/0Nis0voVnNtvAoVh8Rz0ZIY9KG69hRMPg1XxeyYOE167GO
   ZZGIZ5/0KB6dwmrYpilG0PYX4uE1bwyIUQ6aKelcJfQD+JQ9/AzkQxLdI
   3A389uWkwroFTTioPyD1FNYlpHuevRfrXq9XQrlbTeVdFSlt8eHP7LJLQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="272151742"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="272151742"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 08:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="851849151"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2022 08:11:21 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMsnJ-0001nh-03;
        Sat, 13 Aug 2022 15:11:21 +0000
Date:   Sat, 13 Aug 2022 23:10:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_new_2 3/21]
 arch/arm64/net/bpf_jit_comp.c:1724:20: error: incomplete definition of type
 'struct bpf_tramp_links'
Message-ID: <202208132308.NqD8D2G4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_new_2
head:   c0620f064b5146578de80c7bb00febc697cc4890
commit: d408632e1e04f856d9836e842ef6aa2b96710a31 [3/21] bpf: Replace bpf_tramp_link with bpf_tramp_prog
config: arm64-randconfig-r011-20220804 (https://download.01.org/0day-ci/archive/20220813/202208132308.NqD8D2G4-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=d408632e1e04f856d9836e842ef6aa2b96710a31
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_new_2
        git checkout d408632e1e04f856d9836e842ef6aa2b96710a31
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/net/bpf_jit_comp.c:1714:60: warning: declaration of 'struct bpf_tramp_links' will not be visible outside of this function [-Wvisibility]
   static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
                                                              ^
>> arch/arm64/net/bpf_jit_comp.c:1724:20: error: incomplete definition of type 'struct bpf_tramp_links'
           for (i = 0; i < tl->nr_links; i++) {
                           ~~^
   arch/arm64/net/bpf_jit_comp.c:1714:60: note: forward declaration of 'struct bpf_tramp_links'
   static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
                                                              ^
   arch/arm64/net/bpf_jit_comp.c:1725:26: error: incomplete definition of type 'struct bpf_tramp_links'
                   invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
                                        ~~^
   arch/arm64/net/bpf_jit_comp.c:1714:60: note: forward declaration of 'struct bpf_tramp_links'
   static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
                                                              ^
   arch/arm64/net/bpf_jit_comp.c:1771:17: warning: declaration of 'struct bpf_tramp_links' will not be visible outside of this function [-Wvisibility]
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                        ^
>> arch/arm64/net/bpf_jit_comp.c:1783:42: error: subscript of pointer to incomplete type 'struct bpf_tramp_links'
           struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
                                             ~~~~~~^
   arch/arm64/net/bpf_jit_comp.c:1771:17: note: forward declaration of 'struct bpf_tramp_links'
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                        ^
   arch/arm64/net/bpf_jit_comp.c:1784:41: error: subscript of pointer to incomplete type 'struct bpf_tramp_links'
           struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
                                            ~~~~~~^
   arch/arm64/net/bpf_jit_comp.c:1771:17: note: forward declaration of 'struct bpf_tramp_links'
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                        ^
   arch/arm64/net/bpf_jit_comp.c:1785:44: error: subscript of pointer to incomplete type 'struct bpf_tramp_links'
           struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
                                               ~~~~~~^
   arch/arm64/net/bpf_jit_comp.c:1771:17: note: forward declaration of 'struct bpf_tramp_links'
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                        ^
   arch/arm64/net/bpf_jit_comp.c:1889:24: error: incomplete definition of type 'struct bpf_tramp_links'
           for (i = 0; i < fentry->nr_links; i++)
                           ~~~~~~^
   arch/arm64/net/bpf_jit_comp.c:1771:17: note: forward declaration of 'struct bpf_tramp_links'
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                        ^
   arch/arm64/net/bpf_jit_comp.c:1890:30: error: incomplete definition of type 'struct bpf_tramp_links'
                   invoke_bpf_prog(ctx, fentry->links[i], args_off,
                                        ~~~~~~^
   arch/arm64/net/bpf_jit_comp.c:1771:17: note: forward declaration of 'struct bpf_tramp_links'
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                        ^
   arch/arm64/net/bpf_jit_comp.c:1894:14: error: incomplete definition of type 'struct bpf_tramp_links'
           if (fmod_ret->nr_links) {
               ~~~~~~~~^
   arch/arm64/net/bpf_jit_comp.c:1771:17: note: forward declaration of 'struct bpf_tramp_links'
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                        ^
   arch/arm64/net/bpf_jit_comp.c:1895:30: error: incomplete definition of type 'struct bpf_tramp_links'
                   branches = kcalloc(fmod_ret->nr_links, sizeof(u32 *),
                                      ~~~~~~~~^
   arch/arm64/net/bpf_jit_comp.c:1771:17: note: forward declaration of 'struct bpf_tramp_links'
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                        ^
>> arch/arm64/net/bpf_jit_comp.c:1900:27: error: incompatible pointer types passing 'struct bpf_tramp_links *' to parameter of type 'struct bpf_tramp_links *' [-Werror,-Wincompatible-pointer-types]
                   invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,
                                           ^~~~~~~~
   arch/arm64/net/bpf_jit_comp.c:1714:77: note: passing argument to parameter 'tl' here
   static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
                                                                               ^
   arch/arm64/net/bpf_jit_comp.c:1917:26: error: incomplete definition of type 'struct bpf_tramp_links'
           for (i = 0; i < fmod_ret->nr_links && ctx->image != NULL; i++) {
                           ~~~~~~~~^
   arch/arm64/net/bpf_jit_comp.c:1771:17: note: forward declaration of 'struct bpf_tramp_links'
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                        ^
   arch/arm64/net/bpf_jit_comp.c:1922:23: error: incomplete definition of type 'struct bpf_tramp_links'
           for (i = 0; i < fexit->nr_links; i++)
                           ~~~~~^
   arch/arm64/net/bpf_jit_comp.c:1771:17: note: forward declaration of 'struct bpf_tramp_links'
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                        ^
   arch/arm64/net/bpf_jit_comp.c:1923:29: error: incomplete definition of type 'struct bpf_tramp_links'
                   invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off,
                                        ~~~~~^
   arch/arm64/net/bpf_jit_comp.c:1771:17: note: forward declaration of 'struct bpf_tramp_links'
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                        ^
   arch/arm64/net/bpf_jit_comp.c:1970:23: warning: declaration of 'struct bpf_tramp_links' will not be visible outside of this function [-Wvisibility]
                                   u32 flags, struct bpf_tramp_links *tlinks,
                                                     ^
>> arch/arm64/net/bpf_jit_comp.c:1968:5: error: conflicting types for 'arch_prepare_bpf_trampoline'
   int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
       ^
   include/linux/bpf.h:803:5: note: previous declaration is here
   int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *image_end,
       ^
   arch/arm64/net/bpf_jit_comp.c:1985:37: error: incompatible pointer types passing 'struct bpf_tramp_links *' to parameter of type 'struct bpf_tramp_links *' [-Werror,-Wincompatible-pointer-types]
           ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
                                              ^~~~~~
   arch/arm64/net/bpf_jit_comp.c:1771:34: note: passing argument to parameter 'tlinks' here
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                                         ^
   arch/arm64/net/bpf_jit_comp.c:1996:37: error: incompatible pointer types passing 'struct bpf_tramp_links *' to parameter of type 'struct bpf_tramp_links *' [-Werror,-Wincompatible-pointer-types]
           ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
                                              ^~~~~~
   arch/arm64/net/bpf_jit_comp.c:1771:34: note: passing argument to parameter 'tlinks' here
                                 struct bpf_tramp_links *tlinks, void *orig_call,
                                                         ^
   3 warnings and 16 errors generated.


vim +1724 arch/arm64/net/bpf_jit_comp.c

efc9909fdce00a82 Xu Kuohai 2022-07-11  1713  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1714  static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1715  			       int args_off, int retval_off, int run_ctx_off,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1716  			       u32 **branches)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1717  {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1718  	int i;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1719  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1720  	/* The first fmod_ret program will receive a garbage return value.
efc9909fdce00a82 Xu Kuohai 2022-07-11  1721  	 * Set this to 0 to avoid confusing the program.
efc9909fdce00a82 Xu Kuohai 2022-07-11  1722  	 */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1723  	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11 @1724  	for (i = 0; i < tl->nr_links; i++) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1725  		invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1726  				run_ctx_off, true);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1727  		/* if (*(u64 *)(sp + retval_off) !=  0)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1728  		 *	goto do_fexit;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1729  		 */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1730  		emit(A64_LDR64I(A64_R(10), A64_SP, retval_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1731  		/* Save the location of branch, and generate a nop.
efc9909fdce00a82 Xu Kuohai 2022-07-11  1732  		 * This nop will be replaced with a cbnz later.
efc9909fdce00a82 Xu Kuohai 2022-07-11  1733  		 */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1734  		branches[i] = ctx->image + ctx->idx;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1735  		emit(A64_NOP, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1736  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1737  }
efc9909fdce00a82 Xu Kuohai 2022-07-11  1738  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1739  static void save_args(struct jit_ctx *ctx, int args_off, int nargs)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1740  {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1741  	int i;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1742  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1743  	for (i = 0; i < nargs; i++) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1744  		emit(A64_STR64I(i, A64_SP, args_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1745  		args_off += 8;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1746  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1747  }
efc9909fdce00a82 Xu Kuohai 2022-07-11  1748  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1749  static void restore_args(struct jit_ctx *ctx, int args_off, int nargs)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1750  {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1751  	int i;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1752  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1753  	for (i = 0; i < nargs; i++) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1754  		emit(A64_LDR64I(i, A64_SP, args_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1755  		args_off += 8;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1756  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1757  }
efc9909fdce00a82 Xu Kuohai 2022-07-11  1758  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1759  /* Based on the x86's implementation of arch_prepare_bpf_trampoline().
efc9909fdce00a82 Xu Kuohai 2022-07-11  1760   *
efc9909fdce00a82 Xu Kuohai 2022-07-11  1761   * bpf prog and function entry before bpf trampoline hooked:
efc9909fdce00a82 Xu Kuohai 2022-07-11  1762   *   mov x9, lr
efc9909fdce00a82 Xu Kuohai 2022-07-11  1763   *   nop
efc9909fdce00a82 Xu Kuohai 2022-07-11  1764   *
efc9909fdce00a82 Xu Kuohai 2022-07-11  1765   * bpf prog and function entry after bpf trampoline hooked:
efc9909fdce00a82 Xu Kuohai 2022-07-11  1766   *   mov x9, lr
efc9909fdce00a82 Xu Kuohai 2022-07-11  1767   *   bl  <bpf_trampoline or plt>
efc9909fdce00a82 Xu Kuohai 2022-07-11  1768   *
efc9909fdce00a82 Xu Kuohai 2022-07-11  1769   */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1770  static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1771  			      struct bpf_tramp_links *tlinks, void *orig_call,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1772  			      int nargs, u32 flags)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1773  {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1774  	int i;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1775  	int stack_size;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1776  	int retaddr_off;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1777  	int regs_off;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1778  	int retval_off;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1779  	int args_off;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1780  	int nargs_off;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1781  	int ip_off;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1782  	int run_ctx_off;
efc9909fdce00a82 Xu Kuohai 2022-07-11 @1783  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
efc9909fdce00a82 Xu Kuohai 2022-07-11  1784  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
efc9909fdce00a82 Xu Kuohai 2022-07-11  1785  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
efc9909fdce00a82 Xu Kuohai 2022-07-11  1786  	bool save_ret;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1787  	u32 **branches = NULL;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1788  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1789  	/* trampoline stack layout:
efc9909fdce00a82 Xu Kuohai 2022-07-11  1790  	 *                  [ parent ip         ]
efc9909fdce00a82 Xu Kuohai 2022-07-11  1791  	 *                  [ FP                ]
efc9909fdce00a82 Xu Kuohai 2022-07-11  1792  	 * SP + retaddr_off [ self ip           ]
efc9909fdce00a82 Xu Kuohai 2022-07-11  1793  	 *                  [ FP                ]
efc9909fdce00a82 Xu Kuohai 2022-07-11  1794  	 *
efc9909fdce00a82 Xu Kuohai 2022-07-11  1795  	 *                  [ padding           ] align SP to multiples of 16
efc9909fdce00a82 Xu Kuohai 2022-07-11  1796  	 *
efc9909fdce00a82 Xu Kuohai 2022-07-11  1797  	 *                  [ x20               ] callee saved reg x20
efc9909fdce00a82 Xu Kuohai 2022-07-11  1798  	 * SP + regs_off    [ x19               ] callee saved reg x19
efc9909fdce00a82 Xu Kuohai 2022-07-11  1799  	 *
efc9909fdce00a82 Xu Kuohai 2022-07-11  1800  	 * SP + retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
efc9909fdce00a82 Xu Kuohai 2022-07-11  1801  	 *                                        BPF_TRAMP_F_RET_FENTRY_RET
efc9909fdce00a82 Xu Kuohai 2022-07-11  1802  	 *
efc9909fdce00a82 Xu Kuohai 2022-07-11  1803  	 *                  [ argN              ]
efc9909fdce00a82 Xu Kuohai 2022-07-11  1804  	 *                  [ ...               ]
efc9909fdce00a82 Xu Kuohai 2022-07-11  1805  	 * SP + args_off    [ arg1              ]
efc9909fdce00a82 Xu Kuohai 2022-07-11  1806  	 *
efc9909fdce00a82 Xu Kuohai 2022-07-11  1807  	 * SP + nargs_off   [ args count        ]
efc9909fdce00a82 Xu Kuohai 2022-07-11  1808  	 *
efc9909fdce00a82 Xu Kuohai 2022-07-11  1809  	 * SP + ip_off      [ traced function   ] BPF_TRAMP_F_IP_ARG flag
efc9909fdce00a82 Xu Kuohai 2022-07-11  1810  	 *
efc9909fdce00a82 Xu Kuohai 2022-07-11  1811  	 * SP + run_ctx_off [ bpf_tramp_run_ctx ]
efc9909fdce00a82 Xu Kuohai 2022-07-11  1812  	 */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1813  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1814  	stack_size = 0;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1815  	run_ctx_off = stack_size;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1816  	/* room for bpf_tramp_run_ctx */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1817  	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1818  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1819  	ip_off = stack_size;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1820  	/* room for IP address argument */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1821  	if (flags & BPF_TRAMP_F_IP_ARG)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1822  		stack_size += 8;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1823  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1824  	nargs_off = stack_size;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1825  	/* room for args count */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1826  	stack_size += 8;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1827  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1828  	args_off = stack_size;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1829  	/* room for args */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1830  	stack_size += nargs * 8;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1831  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1832  	/* room for return value */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1833  	retval_off = stack_size;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1834  	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1835  	if (save_ret)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1836  		stack_size += 8;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1837  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1838  	/* room for callee saved registers, currently x19 and x20 are used */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1839  	regs_off = stack_size;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1840  	stack_size += 16;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1841  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1842  	/* round up to multiples of 16 to avoid SPAlignmentFault */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1843  	stack_size = round_up(stack_size, 16);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1844  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1845  	/* return address locates above FP */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1846  	retaddr_off = stack_size + 8;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1847  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1848  	/* bpf trampoline may be invoked by 3 instruction types:
efc9909fdce00a82 Xu Kuohai 2022-07-11  1849  	 * 1. bl, attached to bpf prog or kernel function via short jump
efc9909fdce00a82 Xu Kuohai 2022-07-11  1850  	 * 2. br, attached to bpf prog or kernel function via long jump
efc9909fdce00a82 Xu Kuohai 2022-07-11  1851  	 * 3. blr, working as a function pointer, used by struct_ops.
efc9909fdce00a82 Xu Kuohai 2022-07-11  1852  	 * So BTI_JC should used here to support both br and blr.
efc9909fdce00a82 Xu Kuohai 2022-07-11  1853  	 */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1854  	emit_bti(A64_BTI_JC, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1855  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1856  	/* frame for parent function */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1857  	emit(A64_PUSH(A64_FP, A64_R(9), A64_SP), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1858  	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1859  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1860  	/* frame for patched function */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1861  	emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1862  	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1863  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1864  	/* allocate stack space */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1865  	emit(A64_SUB_I(1, A64_SP, A64_SP, stack_size), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1866  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1867  	if (flags & BPF_TRAMP_F_IP_ARG) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1868  		/* save ip address of the traced function */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1869  		emit_addr_mov_i64(A64_R(10), (const u64)orig_call, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1870  		emit(A64_STR64I(A64_R(10), A64_SP, ip_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1871  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1872  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1873  	/* save args count*/
efc9909fdce00a82 Xu Kuohai 2022-07-11  1874  	emit(A64_MOVZ(1, A64_R(10), nargs, 0), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1875  	emit(A64_STR64I(A64_R(10), A64_SP, nargs_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1876  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1877  	/* save args */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1878  	save_args(ctx, args_off, nargs);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1879  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1880  	/* save callee saved registers */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1881  	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1882  	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1883  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1884  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1885  		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1886  		emit_call((const u64)__bpf_tramp_enter, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1887  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1888  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1889  	for (i = 0; i < fentry->nr_links; i++)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1890  		invoke_bpf_prog(ctx, fentry->links[i], args_off,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1891  				retval_off, run_ctx_off,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1892  				flags & BPF_TRAMP_F_RET_FENTRY_RET);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1893  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1894  	if (fmod_ret->nr_links) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1895  		branches = kcalloc(fmod_ret->nr_links, sizeof(u32 *),
efc9909fdce00a82 Xu Kuohai 2022-07-11  1896  				   GFP_KERNEL);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1897  		if (!branches)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1898  			return -ENOMEM;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1899  
efc9909fdce00a82 Xu Kuohai 2022-07-11 @1900  		invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1901  				   run_ctx_off, branches);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1902  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1903  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1904  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1905  		restore_args(ctx, args_off, nargs);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1906  		/* call original func */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1907  		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1908  		emit(A64_BLR(A64_R(10)), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1909  		/* store return value */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1910  		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1911  		/* reserve a nop for bpf_tramp_image_put */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1912  		im->ip_after_call = ctx->image + ctx->idx;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1913  		emit(A64_NOP, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1914  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1915  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1916  	/* update the branches saved in invoke_bpf_mod_ret with cbnz */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1917  	for (i = 0; i < fmod_ret->nr_links && ctx->image != NULL; i++) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1918  		int offset = &ctx->image[ctx->idx] - branches[i];
efc9909fdce00a82 Xu Kuohai 2022-07-11  1919  		*branches[i] = A64_CBNZ(1, A64_R(10), offset);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1920  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1921  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1922  	for (i = 0; i < fexit->nr_links; i++)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1923  		invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1924  				run_ctx_off, false);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1925  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1926  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1927  		im->ip_epilogue = ctx->image + ctx->idx;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1928  		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1929  		emit_call((const u64)__bpf_tramp_exit, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1930  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1931  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1932  	if (flags & BPF_TRAMP_F_RESTORE_REGS)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1933  		restore_args(ctx, args_off, nargs);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1934  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1935  	/* restore callee saved register x19 and x20 */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1936  	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1937  	emit(A64_LDR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1938  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1939  	if (save_ret)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1940  		emit(A64_LDR64I(A64_R(0), A64_SP, retval_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1941  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1942  	/* reset SP  */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1943  	emit(A64_MOV(1, A64_SP, A64_FP), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1944  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1945  	/* pop frames  */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1946  	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1947  	emit(A64_POP(A64_FP, A64_R(9), A64_SP), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1948  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1949  	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1950  		/* skip patched function, return to parent */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1951  		emit(A64_MOV(1, A64_LR, A64_R(9)), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1952  		emit(A64_RET(A64_R(9)), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1953  	} else {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1954  		/* return to patched function */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1955  		emit(A64_MOV(1, A64_R(10), A64_LR), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1956  		emit(A64_MOV(1, A64_LR, A64_R(9)), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1957  		emit(A64_RET(A64_R(10)), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1958  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1959  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1960  	if (ctx->image)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1961  		bpf_flush_icache(ctx->image, ctx->image + ctx->idx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1962  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1963  	kfree(branches);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1964  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1965  	return ctx->idx;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1966  }
efc9909fdce00a82 Xu Kuohai 2022-07-11  1967  

:::::: The code at line 1724 was first introduced by commit
:::::: efc9909fdce00a827a37609628223cd45bf95d0b bpf, arm64: Add bpf trampoline for arm64

:::::: TO: Xu Kuohai <xukuohai@huawei.com>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
