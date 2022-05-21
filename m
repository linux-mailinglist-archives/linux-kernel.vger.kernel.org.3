Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB3652FF84
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346248AbiEUUy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243137AbiEUUyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:54:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7193D488
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653166494; x=1684702494;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=81czwwX27X38vy6rDJbgD6S1jb9H/492BscylawrZys=;
  b=GKR8TO/q7j9ua8MW8Aw2/HiaY+dLTQWEheBgn5O+SX6RaAYhLzkIqsAL
   LjCrWYMO5Ep7mpqOkPuuemDhA8IZo0E3aTPQbi/pXqnUQihhQwSgh8asN
   NFbdalu0Cw2WrEZAeF6j24MFNkghumwmFuzKh+JzXuttWEWwm8xKSzVuB
   6dszdtX+O7Y22jKHU9LsjF2SCu1Laj2yxeAatP21imPBB/Iw+WWag8ZGl
   0Fh79SZ9dh7zYbyQJ5sZxfJjkz2RbrFeNZSXBasGhvoqN/V6xc4uu1mTw
   rVWYsx5enUtRd9nTRZyqA3L+jiLErwkx0rEXOnb7zij6G4mzFCsEsuK5I
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="252785141"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="252785141"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="576739428"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 May 2022 13:54:52 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsW7f-0006bw-Re;
        Sat, 21 May 2022 20:54:51 +0000
Date:   Sun, 22 May 2022 04:54:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhengyu <lizhengyu3@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [palmer:riscv-kexec 6/6] arch/riscv/kernel/elf_kexec.c:352:9: error:
 unknown type name 'Elf_Rela'; did you mean 'Elf64_Rela'?
Message-ID: <202205220440.PBeyOqv0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git riscv-kexec
head:   daae2fd41212953aeccd56f0a84546394cd00dfb
commit: daae2fd41212953aeccd56f0a84546394cd00dfb [6/6] RISC-V: Load purgatory in kexec_file
config: riscv-randconfig-c003-20220522 (https://download.01.org/0day-ci/archive/20220522/202205220440.PBeyOqv0-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?id=daae2fd41212953aeccd56f0a84546394cd00dfb
        git remote add palmer https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git
        git fetch --no-tags palmer riscv-kexec
        git checkout daae2fd41212953aeccd56f0a84546394cd00dfb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/elf_kexec.c: In function 'arch_kexec_apply_relocations_add':
>> arch/riscv/kernel/elf_kexec.c:352:9: error: unknown type name 'Elf_Rela'; did you mean 'Elf64_Rela'?
     352 |         Elf_Rela *relas;
         |         ^~~~~~~~
         |         Elf64_Rela
   In file included from include/linux/elf.h:7,
                    from arch/riscv/kernel/elf_kexec.c:15:
>> arch/riscv/kernel/elf_kexec.c:370:44: error: request for member 'r_info' in something not a structure or union
     370 |                 sym += ELF64_R_SYM(relas[i].r_info);
         |                                            ^
   include/uapi/linux/elf.h:163:43: note: in definition of macro 'ELF64_R_SYM'
     163 | #define ELF64_R_SYM(i)                  ((i) >> 32)
         |                                           ^
>> arch/riscv/kernel/elf_kexec.c:379:32: error: request for member 'r_offset' in something not a structure or union
     379 |                 loc += relas[i].r_offset;
         |                                ^
>> arch/riscv/kernel/elf_kexec.c:392:32: error: request for member 'r_addend' in something not a structure or union
     392 |                 val += relas[i].r_addend;
         |                                ^
   arch/riscv/kernel/elf_kexec.c:394:51: error: request for member 'r_offset' in something not a structure or union
     394 |                 addr = section->sh_addr + relas[i].r_offset;
         |                                                   ^
   In file included from include/linux/elf.h:7,
                    from arch/riscv/kernel/elf_kexec.c:15:
   arch/riscv/kernel/elf_kexec.c:396:47: error: request for member 'r_info' in something not a structure or union
     396 |                 r_type = ELF64_R_TYPE(relas[i].r_info);
         |                                               ^
   include/uapi/linux/elf.h:164:43: note: in definition of macro 'ELF64_R_TYPE'
     164 | #define ELF64_R_TYPE(i)                 ((i) & 0xffffffff)
         |                                           ^


vim +352 arch/riscv/kernel/elf_kexec.c

   318	
   319	#define ENCODE_ITYPE_IMM(x) \
   320		(RV_X(x, 0, 12) << 20)
   321	#define ENCODE_BTYPE_IMM(x) \
   322		((RV_X(x, 1, 4) << 8) | (RV_X(x, 5, 6) << 25) | \
   323		(RV_X(x, 11, 1) << 7) | (RV_X(x, 12, 1) << 31))
   324	#define ENCODE_UTYPE_IMM(x) \
   325		(RV_X(x, 12, 20) << 12)
   326	#define ENCODE_JTYPE_IMM(x) \
   327		((RV_X(x, 1, 10) << 21) | (RV_X(x, 11, 1) << 20) | \
   328		(RV_X(x, 12, 8) << 12) | (RV_X(x, 20, 1) << 31))
   329	#define ENCODE_CBTYPE_IMM(x) \
   330		((RV_X(x, 1, 2) << 3) | (RV_X(x, 3, 2) << 10) | (RV_X(x, 5, 1) << 2) | \
   331		(RV_X(x, 6, 2) << 5) | (RV_X(x, 8, 1) << 12))
   332	#define ENCODE_CJTYPE_IMM(x) \
   333		((RV_X(x, 1, 3) << 3) | (RV_X(x, 4, 1) << 11) | (RV_X(x, 5, 1) << 2) | \
   334		(RV_X(x, 6, 1) << 7) | (RV_X(x, 7, 1) << 6) | (RV_X(x, 8, 2) << 9) | \
   335		(RV_X(x, 10, 1) << 8) | (RV_X(x, 11, 1) << 12))
   336	#define ENCODE_UJTYPE_IMM(x) \
   337		(ENCODE_UTYPE_IMM(RISCV_CONST_HIGH_PART(x)) | \
   338		(ENCODE_ITYPE_IMM(RISCV_CONST_LOW_PART(x)) << 32))
   339	#define ENCODE_UITYPE_IMM(x) \
   340		(ENCODE_UTYPE_IMM(x) | (ENCODE_ITYPE_IMM(x) << 32))
   341	
   342	#define CLEAN_IMM(type, x) \
   343		((~ENCODE_##type##_IMM((uint64_t)(-1))) & (x))
   344	
   345	int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
   346					     Elf_Shdr *section,
   347					     const Elf_Shdr *relsec,
   348					     const Elf_Shdr *symtab)
   349	{
   350		const char *strtab, *name, *shstrtab;
   351		const Elf_Shdr *sechdrs;
 > 352		Elf_Rela *relas;
   353		int i, r_type;
   354	
   355		/* String & section header string table */
   356		sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
   357		strtab = (char *)pi->ehdr + sechdrs[symtab->sh_link].sh_offset;
   358		shstrtab = (char *)pi->ehdr + sechdrs[pi->ehdr->e_shstrndx].sh_offset;
   359	
   360		relas = (void *)pi->ehdr + relsec->sh_offset;
   361	
   362		for (i = 0; i < relsec->sh_size / sizeof(*relas); i++) {
   363			const Elf_Sym *sym;	/* symbol to relocate */
   364			unsigned long addr;	/* final location after relocation */
   365			unsigned long val;	/* relocated symbol value */
   366			unsigned long sec_base;	/* relocated symbol value */
   367			void *loc;		/* tmp location to modify */
   368	
   369			sym = (void *)pi->ehdr + symtab->sh_offset;
 > 370			sym += ELF64_R_SYM(relas[i].r_info);
   371	
   372			if (sym->st_name)
   373				name = strtab + sym->st_name;
   374			else
   375				name = shstrtab + sechdrs[sym->st_shndx].sh_name;
   376	
   377			loc = pi->purgatory_buf;
   378			loc += section->sh_offset;
 > 379			loc += relas[i].r_offset;
   380	
   381			if (sym->st_shndx == SHN_ABS)
   382				sec_base = 0;
   383			else if (sym->st_shndx >= pi->ehdr->e_shnum) {
   384				pr_err("Invalid section %d for symbol %s\n",
   385				       sym->st_shndx, name);
   386				return -ENOEXEC;
   387			} else
   388				sec_base = pi->sechdrs[sym->st_shndx].sh_addr;
   389	
   390			val = sym->st_value;
   391			val += sec_base;
 > 392			val += relas[i].r_addend;
   393	
   394			addr = section->sh_addr + relas[i].r_offset;
   395	
   396			r_type = ELF64_R_TYPE(relas[i].r_info);
   397	
   398			switch (r_type) {
   399			case R_RISCV_BRANCH:
   400				*(u32 *)loc = CLEAN_IMM(BTYPE, *(u32 *)loc) |
   401					 ENCODE_BTYPE_IMM(val - addr);
   402				break;
   403			case R_RISCV_JAL:
   404				*(u32 *)loc = CLEAN_IMM(JTYPE, *(u32 *)loc) |
   405					 ENCODE_JTYPE_IMM(val - addr);
   406				break;
   407			/*
   408			 * With no R_RISCV_PCREL_LO12_S, R_RISCV_PCREL_LO12_I
   409			 * sym is expected to be next to R_RISCV_PCREL_HI20
   410			 * in purgatory relsec. Handle it like R_RISCV_CALL
   411			 * sym, instead of searching the whole relsec.
   412			 */
   413			case R_RISCV_PCREL_HI20:
   414			case R_RISCV_CALL:
   415				*(u64 *)loc = CLEAN_IMM(UITYPE, *(u64 *)loc) |
   416					 ENCODE_UJTYPE_IMM(val - addr);
   417				break;
   418			case R_RISCV_RVC_BRANCH:
   419				*(u32 *)loc = CLEAN_IMM(CBTYPE, *(u32 *)loc) |
   420					 ENCODE_CBTYPE_IMM(val - addr);
   421				break;
   422			case R_RISCV_RVC_JUMP:
   423				*(u32 *)loc = CLEAN_IMM(CJTYPE, *(u32 *)loc) |
   424					 ENCODE_CJTYPE_IMM(val - addr);
   425				break;
   426			case R_RISCV_ADD32:
   427				*(u32 *)loc += val;
   428				break;
   429			case R_RISCV_SUB32:
   430				*(u32 *)loc -= val;
   431				break;
   432			/* It has been applied by R_RISCV_PCREL_HI20 sym */
   433			case R_RISCV_PCREL_LO12_I:
   434			case R_RISCV_ALIGN:
   435			case R_RISCV_RELAX:
   436				break;
   437			default:
   438				pr_err("Unknown rela relocation: %d\n", r_type);
   439				return -ENOEXEC;
   440			}
   441		}
   442		return 0;
   443	}
   444	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
