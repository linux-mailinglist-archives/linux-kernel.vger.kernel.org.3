Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C88C4E20CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344673AbiCUG7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241003AbiCUG7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:59:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299CF40929
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647845901; x=1679381901;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2xY7hFHnTphpI7bW00HMuxLdCo+tEd4p8L6fLJfPBE4=;
  b=O833YmADrpuegWSoZPtUmupgkpRd+zoSTFZYrBaIVfuex2vP3KpIbbaI
   HbERfDP/GQTKDoPGUtUz5eg79sLNyUwx9oHAhBgsexuAAvQvpgidJLEct
   2UI1MkYXydbD7MABpzYrcUSS/ZE7AVc8d9J1UAdiQl2xt4zzhp06E5rqF
   Ge2NGWNcw/ap3mOoO2uuRmMB79Xm2HM5/6CYQJVX0V2oOfLt7qXuhLvoz
   Nr4XbPRPFmE6MqKyRDALCbOdG1/O4z9nU1qQu/CstOgGM4g0K5b1L2hjG
   whzheEuiZ60Ojr6r4buycXj+JlBGh0yVz5MczIjC6Y3h9LIQJkU1nlM3q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257430942"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="257430942"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 23:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="543096825"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2022 23:58:18 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWBze-000HZn-4s; Mon, 21 Mar 2022 06:58:18 +0000
Date:   Mon, 21 Mar 2022 14:57:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: [ammarfaizi2-block:bpf/bpf-next/master 244/254]
 kernel/bpf/verifier.c:13499:47: sparse: sparse: cast from restricted gfp_t
Message-ID: <202203211432.Fx74gYS9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block bpf/bpf-next/master
head:   7ada3787e91c89b0aa7abf47682e8e587b855c13
commit: b00fa38a9c1cba044a32a601b49a55a18ed719d1 [244/254] bpf: Enable non-atomic allocations in local storage
config: csky-randconfig-s032-20220320 (https://download.01.org/0day-ci/archive/20220321/202203211432.Fx74gYS9-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/b00fa38a9c1cba044a32a601b49a55a18ed719d1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block bpf/bpf-next/master
        git checkout b00fa38a9c1cba044a32a601b49a55a18ed719d1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/verifier.c:13499:47: sparse: sparse: cast from restricted gfp_t
   kernel/bpf/verifier.c:13501:47: sparse: sparse: cast from restricted gfp_t
   kernel/bpf/verifier.c:13746:38: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/csky/include/asm/uaccess.h:121:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/include/asm/uaccess.h:121:17: sparse: sparse: asm output is not an lvalue
   arch/csky/include/asm/uaccess.h:121:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/include/asm/uaccess.h:121:17: sparse: sparse: generating address of non-lvalue (11)
   kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar

vim +13499 kernel/bpf/verifier.c

 13236	
 13237	/* Do various post-verification rewrites in a single program pass.
 13238	 * These rewrites simplify JIT and interpreter implementations.
 13239	 */
 13240	static int do_misc_fixups(struct bpf_verifier_env *env)
 13241	{
 13242		struct bpf_prog *prog = env->prog;
 13243		enum bpf_attach_type eatype = prog->expected_attach_type;
 13244		enum bpf_prog_type prog_type = resolve_prog_type(prog);
 13245		struct bpf_insn *insn = prog->insnsi;
 13246		const struct bpf_func_proto *fn;
 13247		const int insn_cnt = prog->len;
 13248		const struct bpf_map_ops *ops;
 13249		struct bpf_insn_aux_data *aux;
 13250		struct bpf_insn insn_buf[16];
 13251		struct bpf_prog *new_prog;
 13252		struct bpf_map *map_ptr;
 13253		int i, ret, cnt, delta = 0;
 13254	
 13255		for (i = 0; i < insn_cnt; i++, insn++) {
 13256			/* Make divide-by-zero exceptions impossible. */
 13257			if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 13258			    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
 13259			    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
 13260			    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
 13261				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
 13262				bool isdiv = BPF_OP(insn->code) == BPF_DIV;
 13263				struct bpf_insn *patchlet;
 13264				struct bpf_insn chk_and_div[] = {
 13265					/* [R,W]x div 0 -> 0 */
 13266					BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
 13267						     BPF_JNE | BPF_K, insn->src_reg,
 13268						     0, 2, 0),
 13269					BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
 13270					BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 13271					*insn,
 13272				};
 13273				struct bpf_insn chk_and_mod[] = {
 13274					/* [R,W]x mod 0 -> [R,W]x */
 13275					BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
 13276						     BPF_JEQ | BPF_K, insn->src_reg,
 13277						     0, 1 + (is64 ? 0 : 1), 0),
 13278					*insn,
 13279					BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 13280					BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
 13281				};
 13282	
 13283				patchlet = isdiv ? chk_and_div : chk_and_mod;
 13284				cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
 13285					      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
 13286	
 13287				new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
 13288				if (!new_prog)
 13289					return -ENOMEM;
 13290	
 13291				delta    += cnt - 1;
 13292				env->prog = prog = new_prog;
 13293				insn      = new_prog->insnsi + i + delta;
 13294				continue;
 13295			}
 13296	
 13297			/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
 13298			if (BPF_CLASS(insn->code) == BPF_LD &&
 13299			    (BPF_MODE(insn->code) == BPF_ABS ||
 13300			     BPF_MODE(insn->code) == BPF_IND)) {
 13301				cnt = env->ops->gen_ld_abs(insn, insn_buf);
 13302				if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf)) {
 13303					verbose(env, "bpf verifier is misconfigured\n");
 13304					return -EINVAL;
 13305				}
 13306	
 13307				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13308				if (!new_prog)
 13309					return -ENOMEM;
 13310	
 13311				delta    += cnt - 1;
 13312				env->prog = prog = new_prog;
 13313				insn      = new_prog->insnsi + i + delta;
 13314				continue;
 13315			}
 13316	
 13317			/* Rewrite pointer arithmetic to mitigate speculation attacks. */
 13318			if (insn->code == (BPF_ALU64 | BPF_ADD | BPF_X) ||
 13319			    insn->code == (BPF_ALU64 | BPF_SUB | BPF_X)) {
 13320				const u8 code_add = BPF_ALU64 | BPF_ADD | BPF_X;
 13321				const u8 code_sub = BPF_ALU64 | BPF_SUB | BPF_X;
 13322				struct bpf_insn *patch = &insn_buf[0];
 13323				bool issrc, isneg, isimm;
 13324				u32 off_reg;
 13325	
 13326				aux = &env->insn_aux_data[i + delta];
 13327				if (!aux->alu_state ||
 13328				    aux->alu_state == BPF_ALU_NON_POINTER)
 13329					continue;
 13330	
 13331				isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
 13332				issrc = (aux->alu_state & BPF_ALU_SANITIZE) ==
 13333					BPF_ALU_SANITIZE_SRC;
 13334				isimm = aux->alu_state & BPF_ALU_IMMEDIATE;
 13335	
 13336				off_reg = issrc ? insn->src_reg : insn->dst_reg;
 13337				if (isimm) {
 13338					*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
 13339				} else {
 13340					if (isneg)
 13341						*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 13342					*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
 13343					*patch++ = BPF_ALU64_REG(BPF_SUB, BPF_REG_AX, off_reg);
 13344					*patch++ = BPF_ALU64_REG(BPF_OR, BPF_REG_AX, off_reg);
 13345					*patch++ = BPF_ALU64_IMM(BPF_NEG, BPF_REG_AX, 0);
 13346					*patch++ = BPF_ALU64_IMM(BPF_ARSH, BPF_REG_AX, 63);
 13347					*patch++ = BPF_ALU64_REG(BPF_AND, BPF_REG_AX, off_reg);
 13348				}
 13349				if (!issrc)
 13350					*patch++ = BPF_MOV64_REG(insn->dst_reg, insn->src_reg);
 13351				insn->src_reg = BPF_REG_AX;
 13352				if (isneg)
 13353					insn->code = insn->code == code_add ?
 13354						     code_sub : code_add;
 13355				*patch++ = *insn;
 13356				if (issrc && isneg && !isimm)
 13357					*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 13358				cnt = patch - insn_buf;
 13359	
 13360				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13361				if (!new_prog)
 13362					return -ENOMEM;
 13363	
 13364				delta    += cnt - 1;
 13365				env->prog = prog = new_prog;
 13366				insn      = new_prog->insnsi + i + delta;
 13367				continue;
 13368			}
 13369	
 13370			if (insn->code != (BPF_JMP | BPF_CALL))
 13371				continue;
 13372			if (insn->src_reg == BPF_PSEUDO_CALL)
 13373				continue;
 13374			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 13375				ret = fixup_kfunc_call(env, insn);
 13376				if (ret)
 13377					return ret;
 13378				continue;
 13379			}
 13380	
 13381			if (insn->imm == BPF_FUNC_get_route_realm)
 13382				prog->dst_needed = 1;
 13383			if (insn->imm == BPF_FUNC_get_prandom_u32)
 13384				bpf_user_rnd_init_once();
 13385			if (insn->imm == BPF_FUNC_override_return)
 13386				prog->kprobe_override = 1;
 13387			if (insn->imm == BPF_FUNC_tail_call) {
 13388				/* If we tail call into other programs, we
 13389				 * cannot make any assumptions since they can
 13390				 * be replaced dynamically during runtime in
 13391				 * the program array.
 13392				 */
 13393				prog->cb_access = 1;
 13394				if (!allow_tail_call_in_subprogs(env))
 13395					prog->aux->stack_depth = MAX_BPF_STACK;
 13396				prog->aux->max_pkt_offset = MAX_PACKET_OFF;
 13397	
 13398				/* mark bpf_tail_call as different opcode to avoid
 13399				 * conditional branch in the interpreter for every normal
 13400				 * call and to prevent accidental JITing by JIT compiler
 13401				 * that doesn't support bpf_tail_call yet
 13402				 */
 13403				insn->imm = 0;
 13404				insn->code = BPF_JMP | BPF_TAIL_CALL;
 13405	
 13406				aux = &env->insn_aux_data[i + delta];
 13407				if (env->bpf_capable && !prog->blinding_requested &&
 13408				    prog->jit_requested &&
 13409				    !bpf_map_key_poisoned(aux) &&
 13410				    !bpf_map_ptr_poisoned(aux) &&
 13411				    !bpf_map_ptr_unpriv(aux)) {
 13412					struct bpf_jit_poke_descriptor desc = {
 13413						.reason = BPF_POKE_REASON_TAIL_CALL,
 13414						.tail_call.map = BPF_MAP_PTR(aux->map_ptr_state),
 13415						.tail_call.key = bpf_map_key_immediate(aux),
 13416						.insn_idx = i + delta,
 13417					};
 13418	
 13419					ret = bpf_jit_add_poke_descriptor(prog, &desc);
 13420					if (ret < 0) {
 13421						verbose(env, "adding tail call poke descriptor failed\n");
 13422						return ret;
 13423					}
 13424	
 13425					insn->imm = ret + 1;
 13426					continue;
 13427				}
 13428	
 13429				if (!bpf_map_ptr_unpriv(aux))
 13430					continue;
 13431	
 13432				/* instead of changing every JIT dealing with tail_call
 13433				 * emit two extra insns:
 13434				 * if (index >= max_entries) goto out;
 13435				 * index &= array->index_mask;
 13436				 * to avoid out-of-bounds cpu speculation
 13437				 */
 13438				if (bpf_map_ptr_poisoned(aux)) {
 13439					verbose(env, "tail_call abusing map_ptr\n");
 13440					return -EINVAL;
 13441				}
 13442	
 13443				map_ptr = BPF_MAP_PTR(aux->map_ptr_state);
 13444				insn_buf[0] = BPF_JMP_IMM(BPF_JGE, BPF_REG_3,
 13445							  map_ptr->max_entries, 2);
 13446				insn_buf[1] = BPF_ALU32_IMM(BPF_AND, BPF_REG_3,
 13447							    container_of(map_ptr,
 13448									 struct bpf_array,
 13449									 map)->index_mask);
 13450				insn_buf[2] = *insn;
 13451				cnt = 3;
 13452				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13453				if (!new_prog)
 13454					return -ENOMEM;
 13455	
 13456				delta    += cnt - 1;
 13457				env->prog = prog = new_prog;
 13458				insn      = new_prog->insnsi + i + delta;
 13459				continue;
 13460			}
 13461	
 13462			if (insn->imm == BPF_FUNC_timer_set_callback) {
 13463				/* The verifier will process callback_fn as many times as necessary
 13464				 * with different maps and the register states prepared by
 13465				 * set_timer_callback_state will be accurate.
 13466				 *
 13467				 * The following use case is valid:
 13468				 *   map1 is shared by prog1, prog2, prog3.
 13469				 *   prog1 calls bpf_timer_init for some map1 elements
 13470				 *   prog2 calls bpf_timer_set_callback for some map1 elements.
 13471				 *     Those that were not bpf_timer_init-ed will return -EINVAL.
 13472				 *   prog3 calls bpf_timer_start for some map1 elements.
 13473				 *     Those that were not both bpf_timer_init-ed and
 13474				 *     bpf_timer_set_callback-ed will return -EINVAL.
 13475				 */
 13476				struct bpf_insn ld_addrs[2] = {
 13477					BPF_LD_IMM64(BPF_REG_3, (long)prog->aux),
 13478				};
 13479	
 13480				insn_buf[0] = ld_addrs[0];
 13481				insn_buf[1] = ld_addrs[1];
 13482				insn_buf[2] = *insn;
 13483				cnt = 3;
 13484	
 13485				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13486				if (!new_prog)
 13487					return -ENOMEM;
 13488	
 13489				delta    += cnt - 1;
 13490				env->prog = prog = new_prog;
 13491				insn      = new_prog->insnsi + i + delta;
 13492				goto patch_call_imm;
 13493			}
 13494	
 13495			if (insn->imm == BPF_FUNC_task_storage_get ||
 13496			    insn->imm == BPF_FUNC_sk_storage_get ||
 13497			    insn->imm == BPF_FUNC_inode_storage_get) {
 13498				if (env->prog->aux->sleepable)
 13499					insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__s32)GFP_KERNEL);
 13500				else
 13501					insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__s32)GFP_ATOMIC);
 13502				insn_buf[1] = *insn;
 13503				cnt = 2;
 13504	
 13505				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13506				if (!new_prog)
 13507					return -ENOMEM;
 13508	
 13509				delta += cnt - 1;
 13510				env->prog = prog = new_prog;
 13511				insn = new_prog->insnsi + i + delta;
 13512				goto patch_call_imm;
 13513			}
 13514	
 13515			/* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
 13516			 * and other inlining handlers are currently limited to 64 bit
 13517			 * only.
 13518			 */
 13519			if (prog->jit_requested && BITS_PER_LONG == 64 &&
 13520			    (insn->imm == BPF_FUNC_map_lookup_elem ||
 13521			     insn->imm == BPF_FUNC_map_update_elem ||
 13522			     insn->imm == BPF_FUNC_map_delete_elem ||
 13523			     insn->imm == BPF_FUNC_map_push_elem   ||
 13524			     insn->imm == BPF_FUNC_map_pop_elem    ||
 13525			     insn->imm == BPF_FUNC_map_peek_elem   ||
 13526			     insn->imm == BPF_FUNC_redirect_map    ||
 13527			     insn->imm == BPF_FUNC_for_each_map_elem)) {
 13528				aux = &env->insn_aux_data[i + delta];
 13529				if (bpf_map_ptr_poisoned(aux))
 13530					goto patch_call_imm;
 13531	
 13532				map_ptr = BPF_MAP_PTR(aux->map_ptr_state);
 13533				ops = map_ptr->ops;
 13534				if (insn->imm == BPF_FUNC_map_lookup_elem &&
 13535				    ops->map_gen_lookup) {
 13536					cnt = ops->map_gen_lookup(map_ptr, insn_buf);
 13537					if (cnt == -EOPNOTSUPP)
 13538						goto patch_map_ops_generic;
 13539					if (cnt <= 0 || cnt >= ARRAY_SIZE(insn_buf)) {
 13540						verbose(env, "bpf verifier is misconfigured\n");
 13541						return -EINVAL;
 13542					}
 13543	
 13544					new_prog = bpf_patch_insn_data(env, i + delta,
 13545								       insn_buf, cnt);
 13546					if (!new_prog)
 13547						return -ENOMEM;
 13548	
 13549					delta    += cnt - 1;
 13550					env->prog = prog = new_prog;
 13551					insn      = new_prog->insnsi + i + delta;
 13552					continue;
 13553				}
 13554	
 13555				BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
 13556					     (void *(*)(struct bpf_map *map, void *key))NULL));
 13557				BUILD_BUG_ON(!__same_type(ops->map_delete_elem,
 13558					     (int (*)(struct bpf_map *map, void *key))NULL));
 13559				BUILD_BUG_ON(!__same_type(ops->map_update_elem,
 13560					     (int (*)(struct bpf_map *map, void *key, void *value,
 13561						      u64 flags))NULL));
 13562				BUILD_BUG_ON(!__same_type(ops->map_push_elem,
 13563					     (int (*)(struct bpf_map *map, void *value,
 13564						      u64 flags))NULL));
 13565				BUILD_BUG_ON(!__same_type(ops->map_pop_elem,
 13566					     (int (*)(struct bpf_map *map, void *value))NULL));
 13567				BUILD_BUG_ON(!__same_type(ops->map_peek_elem,
 13568					     (int (*)(struct bpf_map *map, void *value))NULL));
 13569				BUILD_BUG_ON(!__same_type(ops->map_redirect,
 13570					     (int (*)(struct bpf_map *map, u32 ifindex, u64 flags))NULL));
 13571				BUILD_BUG_ON(!__same_type(ops->map_for_each_callback,
 13572					     (int (*)(struct bpf_map *map,
 13573						      bpf_callback_t callback_fn,
 13574						      void *callback_ctx,
 13575						      u64 flags))NULL));
 13576	
 13577	patch_map_ops_generic:
 13578				switch (insn->imm) {
 13579				case BPF_FUNC_map_lookup_elem:
 13580					insn->imm = BPF_CALL_IMM(ops->map_lookup_elem);
 13581					continue;
 13582				case BPF_FUNC_map_update_elem:
 13583					insn->imm = BPF_CALL_IMM(ops->map_update_elem);
 13584					continue;
 13585				case BPF_FUNC_map_delete_elem:
 13586					insn->imm = BPF_CALL_IMM(ops->map_delete_elem);
 13587					continue;
 13588				case BPF_FUNC_map_push_elem:
 13589					insn->imm = BPF_CALL_IMM(ops->map_push_elem);
 13590					continue;
 13591				case BPF_FUNC_map_pop_elem:
 13592					insn->imm = BPF_CALL_IMM(ops->map_pop_elem);
 13593					continue;
 13594				case BPF_FUNC_map_peek_elem:
 13595					insn->imm = BPF_CALL_IMM(ops->map_peek_elem);
 13596					continue;
 13597				case BPF_FUNC_redirect_map:
 13598					insn->imm = BPF_CALL_IMM(ops->map_redirect);
 13599					continue;
 13600				case BPF_FUNC_for_each_map_elem:
 13601					insn->imm = BPF_CALL_IMM(ops->map_for_each_callback);
 13602					continue;
 13603				}
 13604	
 13605				goto patch_call_imm;
 13606			}
 13607	
 13608			/* Implement bpf_jiffies64 inline. */
 13609			if (prog->jit_requested && BITS_PER_LONG == 64 &&
 13610			    insn->imm == BPF_FUNC_jiffies64) {
 13611				struct bpf_insn ld_jiffies_addr[2] = {
 13612					BPF_LD_IMM64(BPF_REG_0,
 13613						     (unsigned long)&jiffies),
 13614				};
 13615	
 13616				insn_buf[0] = ld_jiffies_addr[0];
 13617				insn_buf[1] = ld_jiffies_addr[1];
 13618				insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0,
 13619							  BPF_REG_0, 0);
 13620				cnt = 3;
 13621	
 13622				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
 13623							       cnt);
 13624				if (!new_prog)
 13625					return -ENOMEM;
 13626	
 13627				delta    += cnt - 1;
 13628				env->prog = prog = new_prog;
 13629				insn      = new_prog->insnsi + i + delta;
 13630				continue;
 13631			}
 13632	
 13633			/* Implement bpf_get_func_arg inline. */
 13634			if (prog_type == BPF_PROG_TYPE_TRACING &&
 13635			    insn->imm == BPF_FUNC_get_func_arg) {
 13636				/* Load nr_args from ctx - 8 */
 13637				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
 13638				insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
 13639				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
 13640				insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
 13641				insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
 13642				insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
 13643				insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
 13644				insn_buf[7] = BPF_JMP_A(1);
 13645				insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
 13646				cnt = 9;
 13647	
 13648				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13649				if (!new_prog)
 13650					return -ENOMEM;
 13651	
 13652				delta    += cnt - 1;
 13653				env->prog = prog = new_prog;
 13654				insn      = new_prog->insnsi + i + delta;
 13655				continue;
 13656			}
 13657	
 13658			/* Implement bpf_get_func_ret inline. */
 13659			if (prog_type == BPF_PROG_TYPE_TRACING &&
 13660			    insn->imm == BPF_FUNC_get_func_ret) {
 13661				if (eatype == BPF_TRACE_FEXIT ||
 13662				    eatype == BPF_MODIFY_RETURN) {
 13663					/* Load nr_args from ctx - 8 */
 13664					insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
 13665					insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
 13666					insn_buf[2] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
 13667					insn_buf[3] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
 13668					insn_buf[4] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
 13669					insn_buf[5] = BPF_MOV64_IMM(BPF_REG_0, 0);
 13670					cnt = 6;
 13671				} else {
 13672					insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
 13673					cnt = 1;
 13674				}
 13675	
 13676				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13677				if (!new_prog)
 13678					return -ENOMEM;
 13679	
 13680				delta    += cnt - 1;
 13681				env->prog = prog = new_prog;
 13682				insn      = new_prog->insnsi + i + delta;
 13683				continue;
 13684			}
 13685	
 13686			/* Implement get_func_arg_cnt inline. */
 13687			if (prog_type == BPF_PROG_TYPE_TRACING &&
 13688			    insn->imm == BPF_FUNC_get_func_arg_cnt) {
 13689				/* Load nr_args from ctx - 8 */
 13690				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
 13691	
 13692				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 13693				if (!new_prog)
 13694					return -ENOMEM;
 13695	
 13696				env->prog = prog = new_prog;
 13697				insn      = new_prog->insnsi + i + delta;
 13698				continue;
 13699			}
 13700	
 13701			/* Implement tracing bpf_get_func_ip inline. */
 13702			if (prog_type == BPF_PROG_TYPE_TRACING &&
 13703			    insn->imm == BPF_FUNC_get_func_ip) {
 13704				/* Load IP address from ctx - 16 */
 13705				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -16);
 13706	
 13707				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 13708				if (!new_prog)
 13709					return -ENOMEM;
 13710	
 13711				env->prog = prog = new_prog;
 13712				insn      = new_prog->insnsi + i + delta;
 13713				continue;
 13714			}
 13715	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
