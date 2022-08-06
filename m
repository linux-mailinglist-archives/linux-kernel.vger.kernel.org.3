Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D058B314
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 02:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiHFArm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 20:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHFArk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 20:47:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C15D0FC
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 17:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659746859; x=1691282859;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=glszrEwl1OKsvGBXpAoV4Py+FHvDx8VXlMQ5ubeaEiI=;
  b=Dh71o/Cw0kF1z8T2W6/FLpAwxohgXVkYOXvkAsbgJuBIJPySFor3SKh4
   vFqEXsi9hO/rNxmjC4XlPDrFIkVig/zlS4FKqQfhOM9LxNRFdLe/MCKn4
   H5prFepUmJZl5Cv3ES+13GnfOHxVgdO2jGZcUZxKC7aqiXTJ/QcLc9FEQ
   xEKxjDkEvsgEuH+zOIGW7PtQHrmR55pJ/6idNNj4vULI+V/TyNCBDFv9K
   dCHphDwgxnJMw02utxuPlczBvln1AbNIEfO1epys1M9PftwKqmjWIrY+i
   5y6LFocz1xDlvbnI+ycUOh3Dd3TRNVF1Ah8ZGoYSp3ULfrC8TyaFSsZCI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289080877"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289080877"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 17:47:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="931417763"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2022 17:47:37 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK7ya-000Jrt-3B;
        Sat, 06 Aug 2022 00:47:36 +0000
Date:   Sat, 6 Aug 2022 08:46:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: arch/arm64/net/bpf_jit_comp.c:1683:16: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202208060800.EiP6qXW9-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   74cae210a335d159f2eb822e261adee905b6951a
commit: efc9909fdce00a827a37609628223cd45bf95d0b bpf, arm64: Add bpf trampoline for arm64
date:   4 weeks ago
config: arm64-randconfig-s051-20220805 (https://download.01.org/0day-ci/archive/20220806/202208060800.EiP6qXW9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=efc9909fdce00a827a37609628223cd45bf95d0b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout efc9909fdce00a827a37609628223cd45bf95d0b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/arm64/net/bpf_jit_comp.c:1683:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] *branch @@     got restricted __le32 [usertype] * @@
   arch/arm64/net/bpf_jit_comp.c:1683:16: sparse:     expected unsigned int [usertype] *branch
   arch/arm64/net/bpf_jit_comp.c:1683:16: sparse:     got restricted __le32 [usertype] *
>> arch/arm64/net/bpf_jit_comp.c:1699:52: sparse: sparse: subtraction of different types can't work (different base types)
>> arch/arm64/net/bpf_jit_comp.c:1733:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] * @@     got restricted __le32 [usertype] * @@
   arch/arm64/net/bpf_jit_comp.c:1733:29: sparse:     expected unsigned int [usertype] *
   arch/arm64/net/bpf_jit_comp.c:1733:29: sparse:     got restricted __le32 [usertype] *
   arch/arm64/net/bpf_jit_comp.c:1917:52: sparse: sparse: subtraction of different types can't work (different base types)

vim +1683 arch/arm64/net/bpf_jit_comp.c

  1640	
  1641	static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
  1642				    int args_off, int retval_off, int run_ctx_off,
  1643				    bool save_ret)
  1644	{
  1645		u32 *branch;
  1646		u64 enter_prog;
  1647		u64 exit_prog;
  1648		struct bpf_prog *p = l->link.prog;
  1649		int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
  1650	
  1651		if (p->aux->sleepable) {
  1652			enter_prog = (u64)__bpf_prog_enter_sleepable;
  1653			exit_prog = (u64)__bpf_prog_exit_sleepable;
  1654		} else {
  1655			enter_prog = (u64)__bpf_prog_enter;
  1656			exit_prog = (u64)__bpf_prog_exit;
  1657		}
  1658	
  1659		if (l->cookie == 0) {
  1660			/* if cookie is zero, one instruction is enough to store it */
  1661			emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);
  1662		} else {
  1663			emit_a64_mov_i64(A64_R(10), l->cookie, ctx);
  1664			emit(A64_STR64I(A64_R(10), A64_SP, run_ctx_off + cookie_off),
  1665			     ctx);
  1666		}
  1667	
  1668		/* save p to callee saved register x19 to avoid loading p with mov_i64
  1669		 * each time.
  1670		 */
  1671		emit_addr_mov_i64(A64_R(19), (const u64)p, ctx);
  1672	
  1673		/* arg1: prog */
  1674		emit(A64_MOV(1, A64_R(0), A64_R(19)), ctx);
  1675		/* arg2: &run_ctx */
  1676		emit(A64_ADD_I(1, A64_R(1), A64_SP, run_ctx_off), ctx);
  1677	
  1678		emit_call(enter_prog, ctx);
  1679	
  1680		/* if (__bpf_prog_enter(prog) == 0)
  1681		 *         goto skip_exec_of_prog;
  1682		 */
> 1683		branch = ctx->image + ctx->idx;
  1684		emit(A64_NOP, ctx);
  1685	
  1686		/* save return value to callee saved register x20 */
  1687		emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
  1688	
  1689		emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
  1690		if (!p->jited)
  1691			emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);
  1692	
  1693		emit_call((const u64)p->bpf_func, ctx);
  1694	
  1695		if (save_ret)
  1696			emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
  1697	
  1698		if (ctx->image) {
> 1699			int offset = &ctx->image[ctx->idx] - branch;
  1700			*branch = A64_CBZ(1, A64_R(0), offset);
  1701		}
  1702	
  1703		/* arg1: prog */
  1704		emit(A64_MOV(1, A64_R(0), A64_R(19)), ctx);
  1705		/* arg2: start time */
  1706		emit(A64_MOV(1, A64_R(1), A64_R(20)), ctx);
  1707		/* arg3: &run_ctx */
  1708		emit(A64_ADD_I(1, A64_R(2), A64_SP, run_ctx_off), ctx);
  1709	
  1710		emit_call(exit_prog, ctx);
  1711	}
  1712	
  1713	static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
  1714				       int args_off, int retval_off, int run_ctx_off,
  1715				       u32 **branches)
  1716	{
  1717		int i;
  1718	
  1719		/* The first fmod_ret program will receive a garbage return value.
  1720		 * Set this to 0 to avoid confusing the program.
  1721		 */
  1722		emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
  1723		for (i = 0; i < tl->nr_links; i++) {
  1724			invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
  1725					run_ctx_off, true);
  1726			/* if (*(u64 *)(sp + retval_off) !=  0)
  1727			 *	goto do_fexit;
  1728			 */
  1729			emit(A64_LDR64I(A64_R(10), A64_SP, retval_off), ctx);
  1730			/* Save the location of branch, and generate a nop.
  1731			 * This nop will be replaced with a cbnz later.
  1732			 */
> 1733			branches[i] = ctx->image + ctx->idx;
  1734			emit(A64_NOP, ctx);
  1735		}
  1736	}
  1737	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
