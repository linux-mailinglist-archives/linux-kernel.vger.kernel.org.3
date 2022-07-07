Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D20F569E49
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiGGJIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiGGJIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:08:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB0F1C90D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657184916; x=1688720916;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K92sXVRr3OVAanF+nk1nqQI3Z2WShQWgeM5zAx+dTos=;
  b=BU1yoVMAUH0tBBqMa3Rh6ZqvXQ2XjLX/OqACLwg+BLVVtWBbnWyuaUUL
   GQcvC6TOdvKNzVHtKjuKC3q6gMj22JmBwIs4L3HW5aukky5fvEJchO+p+
   RSUclDdY8fvTma9S2zXkfmqzd7geRieKkyQsW3L1xQzo/4UE5gy+hRL2L
   gi5F+/ih/L+DmvN3hGDxKsetlVsIr/mUdmVKeqoHj+ssUaBemJinZW4ZW
   TilsNB/dHhTXn31Vj/DeUr//28CBq8XJ8w1tPByxg/T4YHplCX6ByjfZR
   OsmBUBfwFz55cebrVi7//MLdVlIdQvuCYWpvfP++gFEoWa3FWqzVynuvl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="347958604"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="347958604"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 02:08:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="626246852"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2022 02:08:35 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9NUw-000Lnu-IA;
        Thu, 07 Jul 2022 09:08:34 +0000
Date:   Thu, 7 Jul 2022 17:08:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhengyu <lizhengyu3@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/elf_kexec.c:352:9: error: unknown type name
 'Elf_Rela'; did you mean 'Elf64_Rela'?
Message-ID: <202207071735.mAMg0MAa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f09069cde34dcd86f5ecf3a3139fd752020812f
commit: 838b3e28488f702e2b5477b393f009b2639d2b1a RISC-V: Load purgatory in kexec_file
date:   7 weeks ago
config: riscv-buildonly-randconfig-r001-20220707 (https://download.01.org/0day-ci/archive/20220707/202207071735.mAMg0MAa-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=838b3e28488f702e2b5477b393f009b2639d2b1a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 838b3e28488f702e2b5477b393f009b2639d2b1a
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
