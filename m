Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8727158B4A1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiHFIzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiHFIzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:55:36 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DB811C22
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 01:55:34 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oKFaa-0006R7-2N; Sat, 06 Aug 2022 10:55:20 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oKFaZ-000OIU-TO; Sat, 06 Aug 2022 10:55:19 +0200
Subject: Re: arch/arm64/net/bpf_jit_comp.c:1683:16: sparse: sparse: incorrect
 type in assignment (different base types)
To:     kernel test robot <lkp@intel.com>, Xu Kuohai <xukuohai@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <202208060800.EiP6qXW9-lkp@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0f1d610a-e249-7cd7-4408-3f7457ec60b3@iogearbox.net>
Date:   Sat, 6 Aug 2022 10:55:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <202208060800.EiP6qXW9-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26619/Sat Aug  6 09:53:47 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/22 2:46 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   74cae210a335d159f2eb822e261adee905b6951a
> commit: efc9909fdce00a827a37609628223cd45bf95d0b bpf, arm64: Add bpf trampoline for arm64
> date:   4 weeks ago
> config: arm64-randconfig-s051-20220805 (https://download.01.org/0day-ci/archive/20220806/202208060800.EiP6qXW9-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.4-39-gce1a6720-dirty
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=efc9909fdce00a827a37609628223cd45bf95d0b
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout efc9909fdce00a827a37609628223cd45bf95d0b
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/net/

Xu, please take a look and send a fix, thanks!

> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> sparse warnings: (new ones prefixed by >>)
>>> arch/arm64/net/bpf_jit_comp.c:1683:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] *branch @@     got restricted __le32 [usertype] * @@
>     arch/arm64/net/bpf_jit_comp.c:1683:16: sparse:     expected unsigned int [usertype] *branch
>     arch/arm64/net/bpf_jit_comp.c:1683:16: sparse:     got restricted __le32 [usertype] *
>>> arch/arm64/net/bpf_jit_comp.c:1699:52: sparse: sparse: subtraction of different types can't work (different base types)
>>> arch/arm64/net/bpf_jit_comp.c:1733:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] * @@     got restricted __le32 [usertype] * @@
>     arch/arm64/net/bpf_jit_comp.c:1733:29: sparse:     expected unsigned int [usertype] *
>     arch/arm64/net/bpf_jit_comp.c:1733:29: sparse:     got restricted __le32 [usertype] *
>     arch/arm64/net/bpf_jit_comp.c:1917:52: sparse: sparse: subtraction of different types can't work (different base types)
> 
> vim +1683 arch/arm64/net/bpf_jit_comp.c
> 
>    1640	
>    1641	static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
>    1642				    int args_off, int retval_off, int run_ctx_off,
>    1643				    bool save_ret)
>    1644	{
>    1645		u32 *branch;
>    1646		u64 enter_prog;
>    1647		u64 exit_prog;
>    1648		struct bpf_prog *p = l->link.prog;
>    1649		int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
>    1650	
>    1651		if (p->aux->sleepable) {
>    1652			enter_prog = (u64)__bpf_prog_enter_sleepable;
>    1653			exit_prog = (u64)__bpf_prog_exit_sleepable;
>    1654		} else {
>    1655			enter_prog = (u64)__bpf_prog_enter;
>    1656			exit_prog = (u64)__bpf_prog_exit;
>    1657		}
>    1658	
>    1659		if (l->cookie == 0) {
>    1660			/* if cookie is zero, one instruction is enough to store it */
>    1661			emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);
>    1662		} else {
>    1663			emit_a64_mov_i64(A64_R(10), l->cookie, ctx);
>    1664			emit(A64_STR64I(A64_R(10), A64_SP, run_ctx_off + cookie_off),
>    1665			     ctx);
>    1666		}
>    1667	
>    1668		/* save p to callee saved register x19 to avoid loading p with mov_i64
>    1669		 * each time.
>    1670		 */
>    1671		emit_addr_mov_i64(A64_R(19), (const u64)p, ctx);
>    1672	
>    1673		/* arg1: prog */
>    1674		emit(A64_MOV(1, A64_R(0), A64_R(19)), ctx);
>    1675		/* arg2: &run_ctx */
>    1676		emit(A64_ADD_I(1, A64_R(1), A64_SP, run_ctx_off), ctx);
>    1677	
>    1678		emit_call(enter_prog, ctx);
>    1679	
>    1680		/* if (__bpf_prog_enter(prog) == 0)
>    1681		 *         goto skip_exec_of_prog;
>    1682		 */
>> 1683		branch = ctx->image + ctx->idx;
>    1684		emit(A64_NOP, ctx);
>    1685	
>    1686		/* save return value to callee saved register x20 */
>    1687		emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
>    1688	
>    1689		emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
>    1690		if (!p->jited)
>    1691			emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);
>    1692	
>    1693		emit_call((const u64)p->bpf_func, ctx);
>    1694	
>    1695		if (save_ret)
>    1696			emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
>    1697	
>    1698		if (ctx->image) {
>> 1699			int offset = &ctx->image[ctx->idx] - branch;
>    1700			*branch = A64_CBZ(1, A64_R(0), offset);
>    1701		}
>    1702	
>    1703		/* arg1: prog */
>    1704		emit(A64_MOV(1, A64_R(0), A64_R(19)), ctx);
>    1705		/* arg2: start time */
>    1706		emit(A64_MOV(1, A64_R(1), A64_R(20)), ctx);
>    1707		/* arg3: &run_ctx */
>    1708		emit(A64_ADD_I(1, A64_R(2), A64_SP, run_ctx_off), ctx);
>    1709	
>    1710		emit_call(exit_prog, ctx);
>    1711	}
>    1712	
>    1713	static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
>    1714				       int args_off, int retval_off, int run_ctx_off,
>    1715				       u32 **branches)
>    1716	{
>    1717		int i;
>    1718	
>    1719		/* The first fmod_ret program will receive a garbage return value.
>    1720		 * Set this to 0 to avoid confusing the program.
>    1721		 */
>    1722		emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
>    1723		for (i = 0; i < tl->nr_links; i++) {
>    1724			invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
>    1725					run_ctx_off, true);
>    1726			/* if (*(u64 *)(sp + retval_off) !=  0)
>    1727			 *	goto do_fexit;
>    1728			 */
>    1729			emit(A64_LDR64I(A64_R(10), A64_SP, retval_off), ctx);
>    1730			/* Save the location of branch, and generate a nop.
>    1731			 * This nop will be replaced with a cbnz later.
>    1732			 */
>> 1733			branches[i] = ctx->image + ctx->idx;
>    1734			emit(A64_NOP, ctx);
>    1735		}
>    1736	}
>    1737	
> 

