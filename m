Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B30F591AA9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiHMNi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiHMNiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:38:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191ACB7D3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660397902; x=1691933902;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dLDJ2+wdMS45uBcpYHFbh9zRFkbB5XjfU7Igv7102ys=;
  b=CLg8skYAR8yTuTDlcSo8X46ykIzVoLXhUfimTPm86CsNg/ie5vgjjuKU
   pjdvTvILBiD5RyjFaghC39YF3DvVO2bPnPCzu7cIyKbDUXLr5wpAZlU5X
   UhniEjOhjHL0kM92MZRQasitWdaekIzcHR71ThBuGIVhJ9n7gEjTHKgP8
   qWz6CNh2oDCfQOFXPB+YVWQlZ5HTGjWglrqjzPecQk05l+CQnyW1hpi1Y
   aumeS2d/HoHrFShg6im5B/opRAdXbf5TgEB016C5kef7H3IE5wQlVbKw4
   ExNVk2bjAPT37RykydCwhRYGEXAl81gq3jSMOHFySGX5Uv397JQVB3Zyh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278708252"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="278708252"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 06:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="851836214"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2022 06:38:19 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMrLG-0001iP-2g;
        Sat, 13 Aug 2022 13:38:18 +0000
Date:   Sat, 13 Aug 2022 21:37:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_new_2 3/21]
 arch/arm64/net/bpf_jit_comp.c:1714:60: warning: declaration of 'struct
 bpf_tramp_links' will not be visible outside of this function
Message-ID: <202208132138.yY3lWP4e-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_new_2
head:   c0620f064b5146578de80c7bb00febc697cc4890
commit: d408632e1e04f856d9836e842ef6aa2b96710a31 [3/21] bpf: Replace bpf_tramp_link with bpf_tramp_prog
config: arm64-randconfig-r011-20220804 (https://download.01.org/0day-ci/archive/20220813/202208132138.yY3lWP4e-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/net/bpf_jit_comp.c:1714:60: warning: declaration of 'struct bpf_tramp_links' will not be visible outside of this function [-Wvisibility]
   static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
                                                              ^
   arch/arm64/net/bpf_jit_comp.c:1724:20: error: incomplete definition of type 'struct bpf_tramp_links'
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
   arch/arm64/net/bpf_jit_comp.c:1783:42: error: subscript of pointer to incomplete type 'struct bpf_tramp_links'
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
   arch/arm64/net/bpf_jit_comp.c:1900:27: error: incompatible pointer types passing 'struct bpf_tramp_links *' to parameter of type 'struct bpf_tramp_links *' [-Werror,-Wincompatible-pointer-types]
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
   arch/arm64/net/bpf_jit_comp.c:1968:5: error: conflicting types for 'arch_prepare_bpf_trampoline'
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


vim +1714 arch/arm64/net/bpf_jit_comp.c

efc9909fdce00a82 Xu Kuohai 2022-07-11  1713  
efc9909fdce00a82 Xu Kuohai 2022-07-11 @1714  static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1715  			       int args_off, int retval_off, int run_ctx_off,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1716  			       u32 **branches)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1717  {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1718  	int i;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1719  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1720  	/* The first fmod_ret program will receive a garbage return value.
efc9909fdce00a82 Xu Kuohai 2022-07-11  1721  	 * Set this to 0 to avoid confusing the program.
efc9909fdce00a82 Xu Kuohai 2022-07-11  1722  	 */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1723  	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1724  	for (i = 0; i < tl->nr_links; i++) {
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

:::::: The code at line 1714 was first introduced by commit
:::::: efc9909fdce00a827a37609628223cd45bf95d0b bpf, arm64: Add bpf trampoline for arm64

:::::: TO: Xu Kuohai <xukuohai@huawei.com>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
