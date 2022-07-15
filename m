Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD75758B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiGOAoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiGOAoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:44:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773D02C135
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657845840; x=1689381840;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fDqCQ8Z2BTofekbAEPEL4MFRZeM3+4NaynF7tPkBoCo=;
  b=aZfZ7ZMkO6I/SBKK8bbJOGIo2sqpX/Vq1JpfuJuDPL9cYhY54xDRs/Ir
   U0Y/0enbMrd4Dp0uR8hi2ezz7lVpOp/LZkRrgXYxBVhsJztt4dMJv+83H
   7Y4OPLXAx26xFMbDxSuUSCkPEd6ZzFlr1fsi7/mONLtmEonPTaTc6aKpu
   ySb6LwPJ1UON620tzA3ameF9GFDOa6X1TUBmrJJtk0OIF2xO0YyHDI0to
   EqjEt5UXIfyxLKk99oGMfc4IMgCyn6Bc9YOLhr8LdT9itPYVyrwhKfiJs
   3y/cf52UUL1ANZZ8AO8jXUXyaXCN44aRIBbH7TxTFv77eo6vzlNQG9VyI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371984773"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="371984773"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="623644450"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2022 17:43:57 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC9Qu-0001Jj-90;
        Fri, 15 Jul 2022 00:43:52 +0000
Date:   Fri, 15 Jul 2022 08:43:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akira Kawata <akirakawata1@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 4906/7121]
 arch/mips/kernel/../../../fs/binfmt_elf.c:823:16: warning: variable
 'load_addr' set but not used
Message-ID: <202207150852.wnhOVq20-lkp@intel.com>
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

Hi Akira,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   6729599d99f8543a9c2525f3fbaccabccc04ad09
commit: dd85ed4af8f5cb42990fb5f42c22d268028693a3 [4906/7121] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
config: mips-randconfig-r023-20220714 (https://download.01.org/0day-ci/archive/20220715/202207150852.wnhOVq20-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips64-linux-gnuabi64
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=dd85ed4af8f5cb42990fb5f42c22d268028693a3
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout dd85ed4af8f5cb42990fb5f42c22d268028693a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/mips/kernel/binfmt_elfn32.c:113:
>> arch/mips/kernel/../../../fs/binfmt_elf.c:823:16: warning: variable 'load_addr' set but not used [-Wunused-but-set-variable]
           unsigned long load_addr, load_bias = 0, phdr_addr = 0;
                         ^
   arch/mips/kernel/binfmt_elfn32.c:86:1: warning: unused function 'jiffies_to_old_timeval32' [-Wunused-function]
   jiffies_to_old_timeval32(unsigned long jiffies, struct old_timeval32 *value)
   ^
   2 warnings generated.
   Assembler messages:
   Warning: a different -march was already specified, is now octeon


vim +/load_addr +823 arch/mips/kernel/../../../fs/binfmt_elf.c

   819	
   820	static int load_elf_binary(struct linux_binprm *bprm)
   821	{
   822		struct file *interpreter = NULL; /* to shut gcc up */
 > 823		unsigned long load_addr, load_bias = 0, phdr_addr = 0;
   824		int load_addr_set = 0;
   825		unsigned long error;
   826		struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
   827		struct elf_phdr *elf_property_phdata = NULL;
   828		unsigned long elf_bss, elf_brk;
   829		int bss_prot = 0;
   830		int retval, i;
   831		unsigned long elf_entry;
   832		unsigned long e_entry;
   833		unsigned long interp_load_addr = 0;
   834		unsigned long start_code, end_code, start_data, end_data;
   835		unsigned long reloc_func_desc __maybe_unused = 0;
   836		int executable_stack = EXSTACK_DEFAULT;
   837		struct elfhdr *elf_ex = (struct elfhdr *)bprm->buf;
   838		struct elfhdr *interp_elf_ex = NULL;
   839		struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
   840		struct mm_struct *mm;
   841		struct pt_regs *regs;
   842	
   843		retval = -ENOEXEC;
   844		/* First of all, some simple consistency checks */
   845		if (memcmp(elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
   846			goto out;
   847	
   848		if (elf_ex->e_type != ET_EXEC && elf_ex->e_type != ET_DYN)
   849			goto out;
   850		if (!elf_check_arch(elf_ex))
   851			goto out;
   852		if (elf_check_fdpic(elf_ex))
   853			goto out;
   854		if (!bprm->file->f_op->mmap)
   855			goto out;
   856	
   857		elf_phdata = load_elf_phdrs(elf_ex, bprm->file);
   858		if (!elf_phdata)
   859			goto out;
   860	
   861		elf_ppnt = elf_phdata;
   862		for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
   863			char *elf_interpreter;
   864	
   865			if (elf_ppnt->p_type == PT_GNU_PROPERTY) {
   866				elf_property_phdata = elf_ppnt;
   867				continue;
   868			}
   869	
   870			if (elf_ppnt->p_type != PT_INTERP)
   871				continue;
   872	
   873			/*
   874			 * This is the program interpreter used for shared libraries -
   875			 * for now assume that this is an a.out format binary.
   876			 */
   877			retval = -ENOEXEC;
   878			if (elf_ppnt->p_filesz > PATH_MAX || elf_ppnt->p_filesz < 2)
   879				goto out_free_ph;
   880	
   881			retval = -ENOMEM;
   882			elf_interpreter = kmalloc(elf_ppnt->p_filesz, GFP_KERNEL);
   883			if (!elf_interpreter)
   884				goto out_free_ph;
   885	
   886			retval = elf_read(bprm->file, elf_interpreter, elf_ppnt->p_filesz,
   887					  elf_ppnt->p_offset);
   888			if (retval < 0)
   889				goto out_free_interp;
   890			/* make sure path is NULL terminated */
   891			retval = -ENOEXEC;
   892			if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
   893				goto out_free_interp;
   894	
   895			interpreter = open_exec(elf_interpreter);
   896			kfree(elf_interpreter);
   897			retval = PTR_ERR(interpreter);
   898			if (IS_ERR(interpreter))
   899				goto out_free_ph;
   900	
   901			/*
   902			 * If the binary is not readable then enforce mm->dumpable = 0
   903			 * regardless of the interpreter's permissions.
   904			 */
   905			would_dump(bprm, interpreter);
   906	
   907			interp_elf_ex = kmalloc(sizeof(*interp_elf_ex), GFP_KERNEL);
   908			if (!interp_elf_ex) {
   909				retval = -ENOMEM;
   910				goto out_free_ph;
   911			}
   912	
   913			/* Get the exec headers */
   914			retval = elf_read(interpreter, interp_elf_ex,
   915					  sizeof(*interp_elf_ex), 0);
   916			if (retval < 0)
   917				goto out_free_dentry;
   918	
   919			break;
   920	
   921	out_free_interp:
   922			kfree(elf_interpreter);
   923			goto out_free_ph;
   924		}
   925	
   926		elf_ppnt = elf_phdata;
   927		for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
   928			switch (elf_ppnt->p_type) {
   929			case PT_GNU_STACK:
   930				if (elf_ppnt->p_flags & PF_X)
   931					executable_stack = EXSTACK_ENABLE_X;
   932				else
   933					executable_stack = EXSTACK_DISABLE_X;
   934				break;
   935	
   936			case PT_LOPROC ... PT_HIPROC:
   937				retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
   938							  bprm->file, false,
   939							  &arch_state);
   940				if (retval)
   941					goto out_free_dentry;
   942				break;
   943			}
   944	
   945		/* Some simple consistency checks for the interpreter */
   946		if (interpreter) {
   947			retval = -ELIBBAD;
   948			/* Not an ELF interpreter */
   949			if (memcmp(interp_elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
   950				goto out_free_dentry;
   951			/* Verify the interpreter has a valid arch */
   952			if (!elf_check_arch(interp_elf_ex) ||
   953			    elf_check_fdpic(interp_elf_ex))
   954				goto out_free_dentry;
   955	
   956			/* Load the interpreter program headers */
   957			interp_elf_phdata = load_elf_phdrs(interp_elf_ex,
   958							   interpreter);
   959			if (!interp_elf_phdata)
   960				goto out_free_dentry;
   961	
   962			/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
   963			elf_property_phdata = NULL;
   964			elf_ppnt = interp_elf_phdata;
   965			for (i = 0; i < interp_elf_ex->e_phnum; i++, elf_ppnt++)
   966				switch (elf_ppnt->p_type) {
   967				case PT_GNU_PROPERTY:
   968					elf_property_phdata = elf_ppnt;
   969					break;
   970	
   971				case PT_LOPROC ... PT_HIPROC:
   972					retval = arch_elf_pt_proc(interp_elf_ex,
   973								  elf_ppnt, interpreter,
   974								  true, &arch_state);
   975					if (retval)
   976						goto out_free_dentry;
   977					break;
   978				}
   979		}
   980	
   981		retval = parse_elf_properties(interpreter ?: bprm->file,
   982					      elf_property_phdata, &arch_state);
   983		if (retval)
   984			goto out_free_dentry;
   985	
   986		/*
   987		 * Allow arch code to reject the ELF at this point, whilst it's
   988		 * still possible to return an error to the code that invoked
   989		 * the exec syscall.
   990		 */
   991		retval = arch_check_elf(elf_ex,
   992					!!interpreter, interp_elf_ex,
   993					&arch_state);
   994		if (retval)
   995			goto out_free_dentry;
   996	
   997		/* Flush all traces of the currently running executable */
   998		retval = begin_new_exec(bprm);
   999		if (retval)
  1000			goto out_free_dentry;
  1001	
  1002		/* Do this immediately, since STACK_TOP as used in setup_arg_pages
  1003		   may depend on the personality.  */
  1004		SET_PERSONALITY2(*elf_ex, &arch_state);
  1005		if (elf_read_implies_exec(*elf_ex, executable_stack))
  1006			current->personality |= READ_IMPLIES_EXEC;
  1007	
  1008		if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
  1009			current->flags |= PF_RANDOMIZE;
  1010	
  1011		setup_new_exec(bprm);
  1012	
  1013		/* Do this so that we can load the interpreter, if need be.  We will
  1014		   change some of these later */
  1015		retval = setup_arg_pages(bprm, randomize_stack_top(STACK_TOP),
  1016					 executable_stack);
  1017		if (retval < 0)
  1018			goto out_free_dentry;
  1019		
  1020		elf_bss = 0;
  1021		elf_brk = 0;
  1022	
  1023		start_code = ~0UL;
  1024		end_code = 0;
  1025		start_data = 0;
  1026		end_data = 0;
  1027	
  1028		/* Now we do a little grungy work by mmapping the ELF image into
  1029		   the correct location in memory. */
  1030		for(i = 0, elf_ppnt = elf_phdata;
  1031		    i < elf_ex->e_phnum; i++, elf_ppnt++) {
  1032			int elf_prot, elf_flags;
  1033			unsigned long k, vaddr;
  1034			unsigned long total_size = 0;
  1035			unsigned long alignment;
  1036	
  1037			if (elf_ppnt->p_type != PT_LOAD)
  1038				continue;
  1039	
  1040			if (unlikely (elf_brk > elf_bss)) {
  1041				unsigned long nbyte;
  1042		            
  1043				/* There was a PT_LOAD segment with p_memsz > p_filesz
  1044				   before this one. Map anonymous pages, if needed,
  1045				   and clear the area.  */
  1046				retval = set_brk(elf_bss + load_bias,
  1047						 elf_brk + load_bias,
  1048						 bss_prot);
  1049				if (retval)
  1050					goto out_free_dentry;
  1051				nbyte = ELF_PAGEOFFSET(elf_bss);
  1052				if (nbyte) {
  1053					nbyte = ELF_MIN_ALIGN - nbyte;
  1054					if (nbyte > elf_brk - elf_bss)
  1055						nbyte = elf_brk - elf_bss;
  1056					if (clear_user((void __user *)elf_bss +
  1057								load_bias, nbyte)) {
  1058						/*
  1059						 * This bss-zeroing can fail if the ELF
  1060						 * file specifies odd protections. So
  1061						 * we don't check the return value
  1062						 */
  1063					}
  1064				}
  1065			}
  1066	
  1067			elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
  1068					     !!interpreter, false);
  1069	
  1070			elf_flags = MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE;
  1071	
  1072			vaddr = elf_ppnt->p_vaddr;
  1073			/*
  1074			 * If we are loading ET_EXEC or we have already performed
  1075			 * the ET_DYN load_addr calculations, proceed normally.
  1076			 */
  1077			if (elf_ex->e_type == ET_EXEC || load_addr_set) {
  1078				elf_flags |= MAP_FIXED;
  1079			} else if (elf_ex->e_type == ET_DYN) {
  1080				/*
  1081				 * This logic is run once for the first LOAD Program
  1082				 * Header for ET_DYN binaries to calculate the
  1083				 * randomization (load_bias) for all the LOAD
  1084				 * Program Headers, and to calculate the entire
  1085				 * size of the ELF mapping (total_size). (Note that
  1086				 * load_addr_set is set to true later once the
  1087				 * initial mapping is performed.)
  1088				 *
  1089				 * There are effectively two types of ET_DYN
  1090				 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
  1091				 * and loaders (ET_DYN without INTERP, since they
  1092				 * _are_ the ELF interpreter). The loaders must
  1093				 * be loaded away from programs since the program
  1094				 * may otherwise collide with the loader (especially
  1095				 * for ET_EXEC which does not have a randomized
  1096				 * position). For example to handle invocations of
  1097				 * "./ld.so someprog" to test out a new version of
  1098				 * the loader, the subsequent program that the
  1099				 * loader loads must avoid the loader itself, so
  1100				 * they cannot share the same load range. Sufficient
  1101				 * room for the brk must be allocated with the
  1102				 * loader as well, since brk must be available with
  1103				 * the loader.
  1104				 *
  1105				 * Therefore, programs are loaded offset from
  1106				 * ELF_ET_DYN_BASE and loaders are loaded into the
  1107				 * independently randomized mmap region (0 load_bias
  1108				 * without MAP_FIXED).
  1109				 */
  1110				if (interpreter) {
  1111					load_bias = ELF_ET_DYN_BASE;
  1112					if (current->flags & PF_RANDOMIZE)
  1113						load_bias += arch_mmap_rnd();
  1114					alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
  1115					if (alignment)
  1116						load_bias &= ~(alignment - 1);
  1117					elf_flags |= MAP_FIXED;
  1118				} else
  1119					load_bias = 0;
  1120	
  1121				/*
  1122				 * Since load_bias is used for all subsequent loading
  1123				 * calculations, we must lower it by the first vaddr
  1124				 * so that the remaining calculations based on the
  1125				 * ELF vaddrs will be correctly offset. The result
  1126				 * is then page aligned.
  1127				 */
  1128				load_bias = ELF_PAGESTART(load_bias - vaddr);
  1129	
  1130				total_size = total_mapping_size(elf_phdata,
  1131								elf_ex->e_phnum);
  1132				if (!total_size) {
  1133					retval = -EINVAL;
  1134					goto out_free_dentry;
  1135				}
  1136			}
  1137	
  1138			error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
  1139					elf_prot, elf_flags, total_size);
  1140			if (BAD_ADDR(error)) {
  1141				retval = IS_ERR((void *)error) ?
  1142					PTR_ERR((void*)error) : -EINVAL;
  1143				goto out_free_dentry;
  1144			}
  1145	
  1146			if (!load_addr_set) {
  1147				load_addr_set = 1;
  1148				load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
  1149				if (elf_ex->e_type == ET_DYN) {
  1150					load_bias += error -
  1151					             ELF_PAGESTART(load_bias + vaddr);
  1152					load_addr += load_bias;
  1153					reloc_func_desc = load_bias;
  1154				}
  1155			}
  1156	
  1157			/*
  1158			 * Figure out which segment in the file contains the Program
  1159			 * Header table, and map to the associated memory address.
  1160			 */
  1161			if (elf_ppnt->p_offset <= elf_ex->e_phoff &&
  1162			    elf_ex->e_phoff < elf_ppnt->p_offset + elf_ppnt->p_filesz) {
  1163				phdr_addr = elf_ex->e_phoff - elf_ppnt->p_offset +
  1164					    elf_ppnt->p_vaddr;
  1165			}
  1166	
  1167			k = elf_ppnt->p_vaddr;
  1168			if ((elf_ppnt->p_flags & PF_X) && k < start_code)
  1169				start_code = k;
  1170			if (start_data < k)
  1171				start_data = k;
  1172	
  1173			/*
  1174			 * Check to see if the section's size will overflow the
  1175			 * allowed task size. Note that p_filesz must always be
  1176			 * <= p_memsz so it is only necessary to check p_memsz.
  1177			 */
  1178			if (BAD_ADDR(k) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
  1179			    elf_ppnt->p_memsz > TASK_SIZE ||
  1180			    TASK_SIZE - elf_ppnt->p_memsz < k) {
  1181				/* set_brk can never work. Avoid overflows. */
  1182				retval = -EINVAL;
  1183				goto out_free_dentry;
  1184			}
  1185	
  1186			k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
  1187	
  1188			if (k > elf_bss)
  1189				elf_bss = k;
  1190			if ((elf_ppnt->p_flags & PF_X) && end_code < k)
  1191				end_code = k;
  1192			if (end_data < k)
  1193				end_data = k;
  1194			k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
  1195			if (k > elf_brk) {
  1196				bss_prot = elf_prot;
  1197				elf_brk = k;
  1198			}
  1199		}
  1200	
  1201		e_entry = elf_ex->e_entry + load_bias;
  1202		phdr_addr += load_bias;
  1203		elf_bss += load_bias;
  1204		elf_brk += load_bias;
  1205		start_code += load_bias;
  1206		end_code += load_bias;
  1207		start_data += load_bias;
  1208		end_data += load_bias;
  1209	
  1210		/* Calling set_brk effectively mmaps the pages that we need
  1211		 * for the bss and break sections.  We must do this before
  1212		 * mapping in the interpreter, to make sure it doesn't wind
  1213		 * up getting placed where the bss needs to go.
  1214		 */
  1215		retval = set_brk(elf_bss, elf_brk, bss_prot);
  1216		if (retval)
  1217			goto out_free_dentry;
  1218		if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bss))) {
  1219			retval = -EFAULT; /* Nobody gets to see this, but.. */
  1220			goto out_free_dentry;
  1221		}
  1222	
  1223		if (interpreter) {
  1224			elf_entry = load_elf_interp(interp_elf_ex,
  1225						    interpreter,
  1226						    load_bias, interp_elf_phdata,
  1227						    &arch_state);
  1228			if (!IS_ERR((void *)elf_entry)) {
  1229				/*
  1230				 * load_elf_interp() returns relocation
  1231				 * adjustment
  1232				 */
  1233				interp_load_addr = elf_entry;
  1234				elf_entry += interp_elf_ex->e_entry;
  1235			}
  1236			if (BAD_ADDR(elf_entry)) {
  1237				retval = IS_ERR((void *)elf_entry) ?
  1238						(int)elf_entry : -EINVAL;
  1239				goto out_free_dentry;
  1240			}
  1241			reloc_func_desc = interp_load_addr;
  1242	
  1243			allow_write_access(interpreter);
  1244			fput(interpreter);
  1245	
  1246			kfree(interp_elf_ex);
  1247			kfree(interp_elf_phdata);
  1248		} else {
  1249			elf_entry = e_entry;
  1250			if (BAD_ADDR(elf_entry)) {
  1251				retval = -EINVAL;
  1252				goto out_free_dentry;
  1253			}
  1254		}
  1255	
  1256		kfree(elf_phdata);
  1257	
  1258		set_binfmt(&elf_format);
  1259	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
