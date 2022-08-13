Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95E9591BBE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbiHMPw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbiHMPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:52:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6B46394
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660405944; x=1691941944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QWYh8FleGsJrLnm5D7v3X6m4k4HjaG9y2I0dn4fjDD0=;
  b=MxPnsMSQOuSBNfr9iC1wgYdrES5x9KMy29rrQp5Q82IrP9wSbQhc1VGP
   BwMB7Zt3gKxQyglscv1KS7iEbciHXyHXYt01nbpvRyl++/deicQLr4q93
   tbTM/vxVPy5vFU/LGuVvREDrnNVkj2S34mcvHtH4GDtj8pBd8t2VMaETz
   PTrQaYGNtMyEm9iIC5GeY5Xzte3GcmCHhc9CuauG8B4oxNJm0lkkXUB9v
   hmQyU+602rKlFw26ZuE5a5wzaOCZTlXW8m+mT42QyoVV2qQZAnIRXqzn5
   b+eGikvmHLv80oUrHi2p6XSRNupDSIbIbtO8gk42F6IwfmkU6PuiSZ4UQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355769405"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="355769405"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 08:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="851854507"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2022 08:52:22 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMtQz-0001po-2m;
        Sat, 13 Aug 2022 15:52:21 +0000
Date:   Sat, 13 Aug 2022 23:52:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_new_2 4/21]
 arch/arm64/net/bpf_jit_comp.c:1642:57: warning: declaration of 'struct
 bpf_tramp_link' will not be visible outside of this function
Message-ID: <202208132334.OnxznuN5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_new_2
head:   c0620f064b5146578de80c7bb00febc697cc4890
commit: 9b9520851a227843b7e43a337281093a5d13ca71 [4/21] bpf: Store trampoline progs in arrays
config: arm64-randconfig-r011-20220804 (https://download.01.org/0day-ci/archive/20220813/202208132334.OnxznuN5-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=9b9520851a227843b7e43a337281093a5d13ca71
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_new_2
        git checkout 9b9520851a227843b7e43a337281093a5d13ca71
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/net/bpf_jit_comp.c:1642:57: warning: declaration of 'struct bpf_tramp_link' will not be visible outside of this function [-Wvisibility]
   static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
                                                           ^
   arch/arm64/net/bpf_jit_comp.c:1649:24: error: incomplete definition of type 'struct bpf_tramp_link'
           struct bpf_prog *p = l->link.prog;
                                ~^
   arch/arm64/net/bpf_jit_comp.c:1642:57: note: forward declaration of 'struct bpf_tramp_link'
   static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
                                                           ^
   arch/arm64/net/bpf_jit_comp.c:1660:7: error: incomplete definition of type 'struct bpf_tramp_link'
           if (l->cookie == 0) {
               ~^
   arch/arm64/net/bpf_jit_comp.c:1642:57: note: forward declaration of 'struct bpf_tramp_link'
   static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
                                                           ^
   arch/arm64/net/bpf_jit_comp.c:1664:32: error: incomplete definition of type 'struct bpf_tramp_link'
                   emit_a64_mov_i64(A64_R(10), l->cookie, ctx);
                                               ~^
   arch/arm64/net/bpf_jit_comp.c:1642:57: note: forward declaration of 'struct bpf_tramp_link'
   static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
                                                           ^
   arch/arm64/net/bpf_jit_comp.c:1714:60: warning: declaration of 'struct bpf_tramp_links' will not be visible outside of this function [-Wvisibility]
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


vim +1642 arch/arm64/net/bpf_jit_comp.c

b2ad54e1533e9144 Xu Kuohai 2022-07-11  1641  
efc9909fdce00a82 Xu Kuohai 2022-07-11 @1642  static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1643  			    int args_off, int retval_off, int run_ctx_off,
efc9909fdce00a82 Xu Kuohai 2022-07-11  1644  			    bool save_ret)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1645  {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1646  	u32 *branch;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1647  	u64 enter_prog;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1648  	u64 exit_prog;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1649  	struct bpf_prog *p = l->link.prog;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1650  	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1651  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1652  	if (p->aux->sleepable) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1653  		enter_prog = (u64)__bpf_prog_enter_sleepable;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1654  		exit_prog = (u64)__bpf_prog_exit_sleepable;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1655  	} else {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1656  		enter_prog = (u64)__bpf_prog_enter;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1657  		exit_prog = (u64)__bpf_prog_exit;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1658  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1659  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1660  	if (l->cookie == 0) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1661  		/* if cookie is zero, one instruction is enough to store it */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1662  		emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1663  	} else {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1664  		emit_a64_mov_i64(A64_R(10), l->cookie, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1665  		emit(A64_STR64I(A64_R(10), A64_SP, run_ctx_off + cookie_off),
efc9909fdce00a82 Xu Kuohai 2022-07-11  1666  		     ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1667  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1668  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1669  	/* save p to callee saved register x19 to avoid loading p with mov_i64
efc9909fdce00a82 Xu Kuohai 2022-07-11  1670  	 * each time.
efc9909fdce00a82 Xu Kuohai 2022-07-11  1671  	 */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1672  	emit_addr_mov_i64(A64_R(19), (const u64)p, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1673  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1674  	/* arg1: prog */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1675  	emit(A64_MOV(1, A64_R(0), A64_R(19)), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1676  	/* arg2: &run_ctx */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1677  	emit(A64_ADD_I(1, A64_R(1), A64_SP, run_ctx_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1678  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1679  	emit_call(enter_prog, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1680  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1681  	/* if (__bpf_prog_enter(prog) == 0)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1682  	 *         goto skip_exec_of_prog;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1683  	 */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1684  	branch = ctx->image + ctx->idx;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1685  	emit(A64_NOP, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1686  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1687  	/* save return value to callee saved register x20 */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1688  	emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1689  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1690  	emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1691  	if (!p->jited)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1692  		emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1693  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1694  	emit_call((const u64)p->bpf_func, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1695  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1696  	if (save_ret)
efc9909fdce00a82 Xu Kuohai 2022-07-11  1697  		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1698  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1699  	if (ctx->image) {
efc9909fdce00a82 Xu Kuohai 2022-07-11  1700  		int offset = &ctx->image[ctx->idx] - branch;
efc9909fdce00a82 Xu Kuohai 2022-07-11  1701  		*branch = A64_CBZ(1, A64_R(0), offset);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1702  	}
efc9909fdce00a82 Xu Kuohai 2022-07-11  1703  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1704  	/* arg1: prog */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1705  	emit(A64_MOV(1, A64_R(0), A64_R(19)), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1706  	/* arg2: start time */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1707  	emit(A64_MOV(1, A64_R(1), A64_R(20)), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1708  	/* arg3: &run_ctx */
efc9909fdce00a82 Xu Kuohai 2022-07-11  1709  	emit(A64_ADD_I(1, A64_R(2), A64_SP, run_ctx_off), ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1710  
efc9909fdce00a82 Xu Kuohai 2022-07-11  1711  	emit_call(exit_prog, ctx);
efc9909fdce00a82 Xu Kuohai 2022-07-11  1712  }
efc9909fdce00a82 Xu Kuohai 2022-07-11  1713  

:::::: The code at line 1642 was first introduced by commit
:::::: efc9909fdce00a827a37609628223cd45bf95d0b bpf, arm64: Add bpf trampoline for arm64

:::::: TO: Xu Kuohai <xukuohai@huawei.com>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
