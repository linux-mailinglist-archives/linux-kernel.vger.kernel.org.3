Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18D54D78B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 00:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiCMX0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 19:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiCMX0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 19:26:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3D61BB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 16:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647213941; x=1678749941;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ROzSnGZASrWm5HBqFlOpryjoFsrlVPD0LYb6sI107XE=;
  b=c9LT+d2Mtf3SIZzewSCkX/t0/6GgWJbPairuA66+vkcrYqgqDB4R1QcI
   kxqF3nop8TtNjGQPiQm3xMJvFQuFQtFrCJBGhhZjaPkmLQg6AmQ5/to2c
   iQqZXnoLsGGQA+Db3Q84IaTVIXDms8q8BzjW1wkrK8Clqr02FBMz8bIKD
   Ivt3tgclVAFBbMWATnuTD3pn/MxBJ2Immip5q+CDY0enEIP2TXZLVqi8g
   hHB3fU+ue0OV8efkJGCeSzPGMVtfzpyw7q7ECqn8Y8aYGLkL/EegSASgr
   7Ojymy9jV/KrEuA9gZiM6NcIs1r7zt76cnxpfwN2OTqm2sI78DsWQr8Rz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="319132190"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="319132190"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 16:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="713510511"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 16:25:39 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTXak-0009NT-Dh; Sun, 13 Mar 2022 23:25:38 +0000
Date:   Mon, 14 Mar 2022 07:25:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: arch/powerpc/net/bpf_jit_comp64.c:801:41: sparse: sparse: cast
 truncates bits from constant value (8000000000000000 becomes 0)
Message-ID: <202203140752.mHxqmO6Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09688c0166e76ce2fb85e86b9d99be8b0084cdf9
commit: 9c70c7147ffec31de67d33243570a533b29f9759 bpf ppc64: Access only if addr is kernel address
date:   4 months ago
config: powerpc64-randconfig-s032-20220313 (https://download.01.org/0day-ci/archive/20220314/202203140752.mHxqmO6Z-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9c70c7147ffec31de67d33243570a533b29f9759
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9c70c7147ffec31de67d33243570a533b29f9759
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/net/bpf_jit_comp64.c:801:41: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
>> arch/powerpc/net/bpf_jit_comp64.c:801:41: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
>> arch/powerpc/net/bpf_jit_comp64.c:803:41: sparse: sparse: cast truncates bits from constant value (c000000000000000 becomes 0)
>> arch/powerpc/net/bpf_jit_comp64.c:803:41: sparse: sparse: cast truncates bits from constant value (c000000000000000 becomes 0)

vim +801 arch/powerpc/net/bpf_jit_comp64.c

   297	
   298	/* Assemble the body code between the prologue & epilogue */
   299	int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *ctx,
   300			       u32 *addrs, int pass)
   301	{
   302		enum stf_barrier_type stf_barrier = stf_barrier_type_get();
   303		const struct bpf_insn *insn = fp->insnsi;
   304		int flen = fp->len;
   305		int i, ret;
   306	
   307		/* Start of epilogue code - will only be valid 2nd pass onwards */
   308		u32 exit_addr = addrs[flen];
   309	
   310		for (i = 0; i < flen; i++) {
   311			u32 code = insn[i].code;
   312			u32 dst_reg = b2p[insn[i].dst_reg];
   313			u32 src_reg = b2p[insn[i].src_reg];
   314			u32 size = BPF_SIZE(code);
   315			s16 off = insn[i].off;
   316			s32 imm = insn[i].imm;
   317			bool func_addr_fixed;
   318			u64 func_addr;
   319			u64 imm64;
   320			u32 true_cond;
   321			u32 tmp_idx;
   322	
   323			/*
   324			 * addrs[] maps a BPF bytecode address into a real offset from
   325			 * the start of the body code.
   326			 */
   327			addrs[i] = ctx->idx * 4;
   328	
   329			/*
   330			 * As an optimization, we note down which non-volatile registers
   331			 * are used so that we can only save/restore those in our
   332			 * prologue and epilogue. We do this here regardless of whether
   333			 * the actual BPF instruction uses src/dst registers or not
   334			 * (for instance, BPF_CALL does not use them). The expectation
   335			 * is that those instructions will have src_reg/dst_reg set to
   336			 * 0. Even otherwise, we just lose some prologue/epilogue
   337			 * optimization but everything else should work without
   338			 * any issues.
   339			 */
   340			if (dst_reg >= BPF_PPC_NVR_MIN && dst_reg < 32)
   341				bpf_set_seen_register(ctx, dst_reg);
   342			if (src_reg >= BPF_PPC_NVR_MIN && src_reg < 32)
   343				bpf_set_seen_register(ctx, src_reg);
   344	
   345			switch (code) {
   346			/*
   347			 * Arithmetic operations: ADD/SUB/MUL/DIV/MOD/NEG
   348			 */
   349			case BPF_ALU | BPF_ADD | BPF_X: /* (u32) dst += (u32) src */
   350			case BPF_ALU64 | BPF_ADD | BPF_X: /* dst += src */
   351				EMIT(PPC_RAW_ADD(dst_reg, dst_reg, src_reg));
   352				goto bpf_alu32_trunc;
   353			case BPF_ALU | BPF_SUB | BPF_X: /* (u32) dst -= (u32) src */
   354			case BPF_ALU64 | BPF_SUB | BPF_X: /* dst -= src */
   355				EMIT(PPC_RAW_SUB(dst_reg, dst_reg, src_reg));
   356				goto bpf_alu32_trunc;
   357			case BPF_ALU | BPF_ADD | BPF_K: /* (u32) dst += (u32) imm */
   358			case BPF_ALU64 | BPF_ADD | BPF_K: /* dst += imm */
   359				if (!imm) {
   360					goto bpf_alu32_trunc;
   361				} else if (imm >= -32768 && imm < 32768) {
   362					EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(imm)));
   363				} else {
   364					PPC_LI32(b2p[TMP_REG_1], imm);
   365					EMIT(PPC_RAW_ADD(dst_reg, dst_reg, b2p[TMP_REG_1]));
   366				}
   367				goto bpf_alu32_trunc;
   368			case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
   369			case BPF_ALU64 | BPF_SUB | BPF_K: /* dst -= imm */
   370				if (!imm) {
   371					goto bpf_alu32_trunc;
   372				} else if (imm > -32768 && imm <= 32768) {
   373					EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(-imm)));
   374				} else {
   375					PPC_LI32(b2p[TMP_REG_1], imm);
   376					EMIT(PPC_RAW_SUB(dst_reg, dst_reg, b2p[TMP_REG_1]));
   377				}
   378				goto bpf_alu32_trunc;
   379			case BPF_ALU | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
   380			case BPF_ALU64 | BPF_MUL | BPF_X: /* dst *= src */
   381				if (BPF_CLASS(code) == BPF_ALU)
   382					EMIT(PPC_RAW_MULW(dst_reg, dst_reg, src_reg));
   383				else
   384					EMIT(PPC_RAW_MULD(dst_reg, dst_reg, src_reg));
   385				goto bpf_alu32_trunc;
   386			case BPF_ALU | BPF_MUL | BPF_K: /* (u32) dst *= (u32) imm */
   387			case BPF_ALU64 | BPF_MUL | BPF_K: /* dst *= imm */
   388				if (imm >= -32768 && imm < 32768)
   389					EMIT(PPC_RAW_MULI(dst_reg, dst_reg, IMM_L(imm)));
   390				else {
   391					PPC_LI32(b2p[TMP_REG_1], imm);
   392					if (BPF_CLASS(code) == BPF_ALU)
   393						EMIT(PPC_RAW_MULW(dst_reg, dst_reg,
   394								b2p[TMP_REG_1]));
   395					else
   396						EMIT(PPC_RAW_MULD(dst_reg, dst_reg,
   397								b2p[TMP_REG_1]));
   398				}
   399				goto bpf_alu32_trunc;
   400			case BPF_ALU | BPF_DIV | BPF_X: /* (u32) dst /= (u32) src */
   401			case BPF_ALU | BPF_MOD | BPF_X: /* (u32) dst %= (u32) src */
   402				if (BPF_OP(code) == BPF_MOD) {
   403					EMIT(PPC_RAW_DIVWU(b2p[TMP_REG_1], dst_reg, src_reg));
   404					EMIT(PPC_RAW_MULW(b2p[TMP_REG_1], src_reg,
   405							b2p[TMP_REG_1]));
   406					EMIT(PPC_RAW_SUB(dst_reg, dst_reg, b2p[TMP_REG_1]));
   407				} else
   408					EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, src_reg));
   409				goto bpf_alu32_trunc;
   410			case BPF_ALU64 | BPF_DIV | BPF_X: /* dst /= src */
   411			case BPF_ALU64 | BPF_MOD | BPF_X: /* dst %= src */
   412				if (BPF_OP(code) == BPF_MOD) {
   413					EMIT(PPC_RAW_DIVDU(b2p[TMP_REG_1], dst_reg, src_reg));
   414					EMIT(PPC_RAW_MULD(b2p[TMP_REG_1], src_reg,
   415							b2p[TMP_REG_1]));
   416					EMIT(PPC_RAW_SUB(dst_reg, dst_reg, b2p[TMP_REG_1]));
   417				} else
   418					EMIT(PPC_RAW_DIVDU(dst_reg, dst_reg, src_reg));
   419				break;
   420			case BPF_ALU | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
   421			case BPF_ALU | BPF_DIV | BPF_K: /* (u32) dst /= (u32) imm */
   422			case BPF_ALU64 | BPF_MOD | BPF_K: /* dst %= imm */
   423			case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
   424				if (imm == 0)
   425					return -EINVAL;
   426				if (imm == 1) {
   427					if (BPF_OP(code) == BPF_DIV) {
   428						goto bpf_alu32_trunc;
   429					} else {
   430						EMIT(PPC_RAW_LI(dst_reg, 0));
   431						break;
   432					}
   433				}
   434	
   435				PPC_LI32(b2p[TMP_REG_1], imm);
   436				switch (BPF_CLASS(code)) {
   437				case BPF_ALU:
   438					if (BPF_OP(code) == BPF_MOD) {
   439						EMIT(PPC_RAW_DIVWU(b2p[TMP_REG_2],
   440								dst_reg,
   441								b2p[TMP_REG_1]));
   442						EMIT(PPC_RAW_MULW(b2p[TMP_REG_1],
   443								b2p[TMP_REG_1],
   444								b2p[TMP_REG_2]));
   445						EMIT(PPC_RAW_SUB(dst_reg, dst_reg,
   446								b2p[TMP_REG_1]));
   447					} else
   448						EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg,
   449								b2p[TMP_REG_1]));
   450					break;
   451				case BPF_ALU64:
   452					if (BPF_OP(code) == BPF_MOD) {
   453						EMIT(PPC_RAW_DIVDU(b2p[TMP_REG_2],
   454								dst_reg,
   455								b2p[TMP_REG_1]));
   456						EMIT(PPC_RAW_MULD(b2p[TMP_REG_1],
   457								b2p[TMP_REG_1],
   458								b2p[TMP_REG_2]));
   459						EMIT(PPC_RAW_SUB(dst_reg, dst_reg,
   460								b2p[TMP_REG_1]));
   461					} else
   462						EMIT(PPC_RAW_DIVDU(dst_reg, dst_reg,
   463								b2p[TMP_REG_1]));
   464					break;
   465				}
   466				goto bpf_alu32_trunc;
   467			case BPF_ALU | BPF_NEG: /* (u32) dst = -dst */
   468			case BPF_ALU64 | BPF_NEG: /* dst = -dst */
   469				EMIT(PPC_RAW_NEG(dst_reg, dst_reg));
   470				goto bpf_alu32_trunc;
   471	
   472			/*
   473			 * Logical operations: AND/OR/XOR/[A]LSH/[A]RSH
   474			 */
   475			case BPF_ALU | BPF_AND | BPF_X: /* (u32) dst = dst & src */
   476			case BPF_ALU64 | BPF_AND | BPF_X: /* dst = dst & src */
   477				EMIT(PPC_RAW_AND(dst_reg, dst_reg, src_reg));
   478				goto bpf_alu32_trunc;
   479			case BPF_ALU | BPF_AND | BPF_K: /* (u32) dst = dst & imm */
   480			case BPF_ALU64 | BPF_AND | BPF_K: /* dst = dst & imm */
   481				if (!IMM_H(imm))
   482					EMIT(PPC_RAW_ANDI(dst_reg, dst_reg, IMM_L(imm)));
   483				else {
   484					/* Sign-extended */
   485					PPC_LI32(b2p[TMP_REG_1], imm);
   486					EMIT(PPC_RAW_AND(dst_reg, dst_reg, b2p[TMP_REG_1]));
   487				}
   488				goto bpf_alu32_trunc;
   489			case BPF_ALU | BPF_OR | BPF_X: /* dst = (u32) dst | (u32) src */
   490			case BPF_ALU64 | BPF_OR | BPF_X: /* dst = dst | src */
   491				EMIT(PPC_RAW_OR(dst_reg, dst_reg, src_reg));
   492				goto bpf_alu32_trunc;
   493			case BPF_ALU | BPF_OR | BPF_K:/* dst = (u32) dst | (u32) imm */
   494			case BPF_ALU64 | BPF_OR | BPF_K:/* dst = dst | imm */
   495				if (imm < 0 && BPF_CLASS(code) == BPF_ALU64) {
   496					/* Sign-extended */
   497					PPC_LI32(b2p[TMP_REG_1], imm);
   498					EMIT(PPC_RAW_OR(dst_reg, dst_reg, b2p[TMP_REG_1]));
   499				} else {
   500					if (IMM_L(imm))
   501						EMIT(PPC_RAW_ORI(dst_reg, dst_reg, IMM_L(imm)));
   502					if (IMM_H(imm))
   503						EMIT(PPC_RAW_ORIS(dst_reg, dst_reg, IMM_H(imm)));
   504				}
   505				goto bpf_alu32_trunc;
   506			case BPF_ALU | BPF_XOR | BPF_X: /* (u32) dst ^= src */
   507			case BPF_ALU64 | BPF_XOR | BPF_X: /* dst ^= src */
   508				EMIT(PPC_RAW_XOR(dst_reg, dst_reg, src_reg));
   509				goto bpf_alu32_trunc;
   510			case BPF_ALU | BPF_XOR | BPF_K: /* (u32) dst ^= (u32) imm */
   511			case BPF_ALU64 | BPF_XOR | BPF_K: /* dst ^= imm */
   512				if (imm < 0 && BPF_CLASS(code) == BPF_ALU64) {
   513					/* Sign-extended */
   514					PPC_LI32(b2p[TMP_REG_1], imm);
   515					EMIT(PPC_RAW_XOR(dst_reg, dst_reg, b2p[TMP_REG_1]));
   516				} else {
   517					if (IMM_L(imm))
   518						EMIT(PPC_RAW_XORI(dst_reg, dst_reg, IMM_L(imm)));
   519					if (IMM_H(imm))
   520						EMIT(PPC_RAW_XORIS(dst_reg, dst_reg, IMM_H(imm)));
   521				}
   522				goto bpf_alu32_trunc;
   523			case BPF_ALU | BPF_LSH | BPF_X: /* (u32) dst <<= (u32) src */
   524				/* slw clears top 32 bits */
   525				EMIT(PPC_RAW_SLW(dst_reg, dst_reg, src_reg));
   526				/* skip zero extension move, but set address map. */
   527				if (insn_is_zext(&insn[i + 1]))
   528					addrs[++i] = ctx->idx * 4;
   529				break;
   530			case BPF_ALU64 | BPF_LSH | BPF_X: /* dst <<= src; */
   531				EMIT(PPC_RAW_SLD(dst_reg, dst_reg, src_reg));
   532				break;
   533			case BPF_ALU | BPF_LSH | BPF_K: /* (u32) dst <<== (u32) imm */
   534				/* with imm 0, we still need to clear top 32 bits */
   535				EMIT(PPC_RAW_SLWI(dst_reg, dst_reg, imm));
   536				if (insn_is_zext(&insn[i + 1]))
   537					addrs[++i] = ctx->idx * 4;
   538				break;
   539			case BPF_ALU64 | BPF_LSH | BPF_K: /* dst <<== imm */
   540				if (imm != 0)
   541					EMIT(PPC_RAW_SLDI(dst_reg, dst_reg, imm));
   542				break;
   543			case BPF_ALU | BPF_RSH | BPF_X: /* (u32) dst >>= (u32) src */
   544				EMIT(PPC_RAW_SRW(dst_reg, dst_reg, src_reg));
   545				if (insn_is_zext(&insn[i + 1]))
   546					addrs[++i] = ctx->idx * 4;
   547				break;
   548			case BPF_ALU64 | BPF_RSH | BPF_X: /* dst >>= src */
   549				EMIT(PPC_RAW_SRD(dst_reg, dst_reg, src_reg));
   550				break;
   551			case BPF_ALU | BPF_RSH | BPF_K: /* (u32) dst >>= (u32) imm */
   552				EMIT(PPC_RAW_SRWI(dst_reg, dst_reg, imm));
   553				if (insn_is_zext(&insn[i + 1]))
   554					addrs[++i] = ctx->idx * 4;
   555				break;
   556			case BPF_ALU64 | BPF_RSH | BPF_K: /* dst >>= imm */
   557				if (imm != 0)
   558					EMIT(PPC_RAW_SRDI(dst_reg, dst_reg, imm));
   559				break;
   560			case BPF_ALU | BPF_ARSH | BPF_X: /* (s32) dst >>= src */
   561				EMIT(PPC_RAW_SRAW(dst_reg, dst_reg, src_reg));
   562				goto bpf_alu32_trunc;
   563			case BPF_ALU64 | BPF_ARSH | BPF_X: /* (s64) dst >>= src */
   564				EMIT(PPC_RAW_SRAD(dst_reg, dst_reg, src_reg));
   565				break;
   566			case BPF_ALU | BPF_ARSH | BPF_K: /* (s32) dst >>= imm */
   567				EMIT(PPC_RAW_SRAWI(dst_reg, dst_reg, imm));
   568				goto bpf_alu32_trunc;
   569			case BPF_ALU64 | BPF_ARSH | BPF_K: /* (s64) dst >>= imm */
   570				if (imm != 0)
   571					EMIT(PPC_RAW_SRADI(dst_reg, dst_reg, imm));
   572				break;
   573	
   574			/*
   575			 * MOV
   576			 */
   577			case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
   578			case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
   579				if (imm == 1) {
   580					/* special mov32 for zext */
   581					EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
   582					break;
   583				}
   584				EMIT(PPC_RAW_MR(dst_reg, src_reg));
   585				goto bpf_alu32_trunc;
   586			case BPF_ALU | BPF_MOV | BPF_K: /* (u32) dst = imm */
   587			case BPF_ALU64 | BPF_MOV | BPF_K: /* dst = (s64) imm */
   588				PPC_LI32(dst_reg, imm);
   589				if (imm < 0)
   590					goto bpf_alu32_trunc;
   591				else if (insn_is_zext(&insn[i + 1]))
   592					addrs[++i] = ctx->idx * 4;
   593				break;
   594	
   595	bpf_alu32_trunc:
   596			/* Truncate to 32-bits */
   597			if (BPF_CLASS(code) == BPF_ALU && !fp->aux->verifier_zext)
   598				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
   599			break;
   600	
   601			/*
   602			 * BPF_FROM_BE/LE
   603			 */
   604			case BPF_ALU | BPF_END | BPF_FROM_LE:
   605			case BPF_ALU | BPF_END | BPF_FROM_BE:
   606	#ifdef __BIG_ENDIAN__
   607				if (BPF_SRC(code) == BPF_FROM_BE)
   608					goto emit_clear;
   609	#else /* !__BIG_ENDIAN__ */
   610				if (BPF_SRC(code) == BPF_FROM_LE)
   611					goto emit_clear;
   612	#endif
   613				switch (imm) {
   614				case 16:
   615					/* Rotate 8 bits left & mask with 0x0000ff00 */
   616					EMIT(PPC_RAW_RLWINM(b2p[TMP_REG_1], dst_reg, 8, 16, 23));
   617					/* Rotate 8 bits right & insert LSB to reg */
   618					EMIT(PPC_RAW_RLWIMI(b2p[TMP_REG_1], dst_reg, 24, 24, 31));
   619					/* Move result back to dst_reg */
   620					EMIT(PPC_RAW_MR(dst_reg, b2p[TMP_REG_1]));
   621					break;
   622				case 32:
   623					/*
   624					 * Rotate word left by 8 bits:
   625					 * 2 bytes are already in their final position
   626					 * -- byte 2 and 4 (of bytes 1, 2, 3 and 4)
   627					 */
   628					EMIT(PPC_RAW_RLWINM(b2p[TMP_REG_1], dst_reg, 8, 0, 31));
   629					/* Rotate 24 bits and insert byte 1 */
   630					EMIT(PPC_RAW_RLWIMI(b2p[TMP_REG_1], dst_reg, 24, 0, 7));
   631					/* Rotate 24 bits and insert byte 3 */
   632					EMIT(PPC_RAW_RLWIMI(b2p[TMP_REG_1], dst_reg, 24, 16, 23));
   633					EMIT(PPC_RAW_MR(dst_reg, b2p[TMP_REG_1]));
   634					break;
   635				case 64:
   636					/*
   637					 * Way easier and faster(?) to store the value
   638					 * into stack and then use ldbrx
   639					 *
   640					 * ctx->seen will be reliable in pass2, but
   641					 * the instructions generated will remain the
   642					 * same across all passes
   643					 */
   644					PPC_BPF_STL(dst_reg, 1, bpf_jit_stack_local(ctx));
   645					EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], 1, bpf_jit_stack_local(ctx)));
   646					EMIT(PPC_RAW_LDBRX(dst_reg, 0, b2p[TMP_REG_1]));
   647					break;
   648				}
   649				break;
   650	
   651	emit_clear:
   652				switch (imm) {
   653				case 16:
   654					/* zero-extend 16 bits into 64 bits */
   655					EMIT(PPC_RAW_RLDICL(dst_reg, dst_reg, 0, 48));
   656					if (insn_is_zext(&insn[i + 1]))
   657						addrs[++i] = ctx->idx * 4;
   658					break;
   659				case 32:
   660					if (!fp->aux->verifier_zext)
   661						/* zero-extend 32 bits into 64 bits */
   662						EMIT(PPC_RAW_RLDICL(dst_reg, dst_reg, 0, 32));
   663					break;
   664				case 64:
   665					/* nop */
   666					break;
   667				}
   668				break;
   669	
   670			/*
   671			 * BPF_ST NOSPEC (speculation barrier)
   672			 */
   673			case BPF_ST | BPF_NOSPEC:
   674				if (!security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) ||
   675						!security_ftr_enabled(SEC_FTR_STF_BARRIER))
   676					break;
   677	
   678				switch (stf_barrier) {
   679				case STF_BARRIER_EIEIO:
   680					EMIT(PPC_RAW_EIEIO() | 0x02000000);
   681					break;
   682				case STF_BARRIER_SYNC_ORI:
   683					EMIT(PPC_RAW_SYNC());
   684					EMIT(PPC_RAW_LD(b2p[TMP_REG_1], _R13, 0));
   685					EMIT(PPC_RAW_ORI(_R31, _R31, 0));
   686					break;
   687				case STF_BARRIER_FALLBACK:
   688					EMIT(PPC_RAW_MFLR(b2p[TMP_REG_1]));
   689					PPC_LI64(12, dereference_kernel_function_descriptor(bpf_stf_barrier));
   690					EMIT(PPC_RAW_MTCTR(12));
   691					EMIT(PPC_RAW_BCTRL());
   692					EMIT(PPC_RAW_MTLR(b2p[TMP_REG_1]));
   693					break;
   694				case STF_BARRIER_NONE:
   695					break;
   696				}
   697				break;
   698	
   699			/*
   700			 * BPF_ST(X)
   701			 */
   702			case BPF_STX | BPF_MEM | BPF_B: /* *(u8 *)(dst + off) = src */
   703			case BPF_ST | BPF_MEM | BPF_B: /* *(u8 *)(dst + off) = imm */
   704				if (BPF_CLASS(code) == BPF_ST) {
   705					EMIT(PPC_RAW_LI(b2p[TMP_REG_1], imm));
   706					src_reg = b2p[TMP_REG_1];
   707				}
   708				EMIT(PPC_RAW_STB(src_reg, dst_reg, off));
   709				break;
   710			case BPF_STX | BPF_MEM | BPF_H: /* (u16 *)(dst + off) = src */
   711			case BPF_ST | BPF_MEM | BPF_H: /* (u16 *)(dst + off) = imm */
   712				if (BPF_CLASS(code) == BPF_ST) {
   713					EMIT(PPC_RAW_LI(b2p[TMP_REG_1], imm));
   714					src_reg = b2p[TMP_REG_1];
   715				}
   716				EMIT(PPC_RAW_STH(src_reg, dst_reg, off));
   717				break;
   718			case BPF_STX | BPF_MEM | BPF_W: /* *(u32 *)(dst + off) = src */
   719			case BPF_ST | BPF_MEM | BPF_W: /* *(u32 *)(dst + off) = imm */
   720				if (BPF_CLASS(code) == BPF_ST) {
   721					PPC_LI32(b2p[TMP_REG_1], imm);
   722					src_reg = b2p[TMP_REG_1];
   723				}
   724				EMIT(PPC_RAW_STW(src_reg, dst_reg, off));
   725				break;
   726			case BPF_STX | BPF_MEM | BPF_DW: /* (u64 *)(dst + off) = src */
   727			case BPF_ST | BPF_MEM | BPF_DW: /* *(u64 *)(dst + off) = imm */
   728				if (BPF_CLASS(code) == BPF_ST) {
   729					PPC_LI32(b2p[TMP_REG_1], imm);
   730					src_reg = b2p[TMP_REG_1];
   731				}
   732				PPC_BPF_STL(src_reg, dst_reg, off);
   733				break;
   734	
   735			/*
   736			 * BPF_STX ATOMIC (atomic ops)
   737			 */
   738			case BPF_STX | BPF_ATOMIC | BPF_W:
   739				if (imm != BPF_ADD) {
   740					pr_err_ratelimited(
   741						"eBPF filter atomic op code %02x (@%d) unsupported\n",
   742						code, i);
   743					return -ENOTSUPP;
   744				}
   745	
   746				/* *(u32 *)(dst + off) += src */
   747	
   748				/* Get EA into TMP_REG_1 */
   749				EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], dst_reg, off));
   750				tmp_idx = ctx->idx * 4;
   751				/* load value from memory into TMP_REG_2 */
   752				EMIT(PPC_RAW_LWARX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1], 0));
   753				/* add value from src_reg into this */
   754				EMIT(PPC_RAW_ADD(b2p[TMP_REG_2], b2p[TMP_REG_2], src_reg));
   755				/* store result back */
   756				EMIT(PPC_RAW_STWCX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1]));
   757				/* we're done if this succeeded */
   758				PPC_BCC_SHORT(COND_NE, tmp_idx);
   759				break;
   760			case BPF_STX | BPF_ATOMIC | BPF_DW:
   761				if (imm != BPF_ADD) {
   762					pr_err_ratelimited(
   763						"eBPF filter atomic op code %02x (@%d) unsupported\n",
   764						code, i);
   765					return -ENOTSUPP;
   766				}
   767				/* *(u64 *)(dst + off) += src */
   768	
   769				EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], dst_reg, off));
   770				tmp_idx = ctx->idx * 4;
   771				EMIT(PPC_RAW_LDARX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1], 0));
   772				EMIT(PPC_RAW_ADD(b2p[TMP_REG_2], b2p[TMP_REG_2], src_reg));
   773				EMIT(PPC_RAW_STDCX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1]));
   774				PPC_BCC_SHORT(COND_NE, tmp_idx);
   775				break;
   776	
   777			/*
   778			 * BPF_LDX
   779			 */
   780			/* dst = *(u8 *)(ul) (src + off) */
   781			case BPF_LDX | BPF_MEM | BPF_B:
   782			case BPF_LDX | BPF_PROBE_MEM | BPF_B:
   783			/* dst = *(u16 *)(ul) (src + off) */
   784			case BPF_LDX | BPF_MEM | BPF_H:
   785			case BPF_LDX | BPF_PROBE_MEM | BPF_H:
   786			/* dst = *(u32 *)(ul) (src + off) */
   787			case BPF_LDX | BPF_MEM | BPF_W:
   788			case BPF_LDX | BPF_PROBE_MEM | BPF_W:
   789			/* dst = *(u64 *)(ul) (src + off) */
   790			case BPF_LDX | BPF_MEM | BPF_DW:
   791			case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
   792				/*
   793				 * As PTR_TO_BTF_ID that uses BPF_PROBE_MEM mode could either be a valid
   794				 * kernel pointer or NULL but not a userspace address, execute BPF_PROBE_MEM
   795				 * load only if addr is kernel address (see is_kernel_addr()), otherwise
   796				 * set dst_reg=0 and move on.
   797				 */
   798				if (BPF_MODE(code) == BPF_PROBE_MEM) {
   799					EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], src_reg, off));
   800					if (IS_ENABLED(CONFIG_PPC_BOOK3E_64))
 > 801						PPC_LI64(b2p[TMP_REG_2], 0x8000000000000000ul);
   802					else /* BOOK3S_64 */
 > 803						PPC_LI64(b2p[TMP_REG_2], PAGE_OFFSET);

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
