Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85947505BED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbiDRPwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345884AbiDRPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:51:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A2B11A0B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650295836; x=1681831836;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eTFjGgPl5lPR5wORi4J+sSH5sPmjB1hWZhztXCFYZ5g=;
  b=AaI4XYOFphNEJlLd2/Ytgqq4X/icHmL0hTST7H68ra1a4p7vzn7quENS
   LJwTiyoVVhkCQ6amesulhv0hH7/AFj3Jt7zvTAGh9ms37BUEnwRutHPYS
   56PJ2ppHCo/5y1P5gP2up3mAFOW9Wdw/25tvHSOBHZnnjbq5Efev6xnWr
   VQfbxPqRgN8NXLTIkCtBQyLBQCfu4FDYNZBVxpSEuK+RRR4yBgMJXh5Un
   M68CMIUXz/ZV8cgkE7hOBX1F5M2Rq7XmICVjsM6YK+i37Ts508lXusyWX
   dIgjONK9zkwRuyi8ZJWGsAujhzuiOk3Yy5ZDfZer4epKNZms+cJQJv9Mp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263717709"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="263717709"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 08:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="592428198"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2022 08:30:33 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngTKi-0004kQ-DH;
        Mon, 18 Apr 2022 15:30:32 +0000
Date:   Mon, 18 Apr 2022 23:30:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [kees:for-next/execve 1/1] fs/binfmt_flat.c:816:39: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202204182333.OIUOotK8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
head:   a767e6fd68d2ca84578649acc072f21b81edfb3a
commit: a767e6fd68d2ca84578649acc072f21b81edfb3a [1/1] binfmt_flat: do not stop relocating GOT entries prematurely on riscv
config: m68k-randconfig-s032-20220417 (https://download.01.org/0day-ci/archive/20220418/202204182333.OIUOotK8-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=a767e6fd68d2ca84578649acc072f21b81edfb3a
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/execve
        git checkout a767e6fd68d2ca84578649acc072f21b81edfb3a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/binfmt_flat.c:816:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int [noderef] [usertype] __user *rp @@     got unsigned int [usertype] *[noderef] __user @@
   fs/binfmt_flat.c:816:39: sparse:     expected unsigned int [noderef] [usertype] __user *rp
   fs/binfmt_flat.c:816:39: sparse:     got unsigned int [usertype] *[noderef] __user
   fs/binfmt_flat.c:856:29: sparse: sparse: restricted __be32 degrades to integer
   fs/binfmt_flat.c:899:29: sparse: sparse: restricted __be32 degrades to integer

vim +816 fs/binfmt_flat.c

   563	
   564		/*
   565		 * Check initial limits. This avoids letting people circumvent
   566		 * size limits imposed on them by creating programs with large
   567		 * arrays in the data or bss.
   568		 */
   569		rlim = rlimit(RLIMIT_DATA);
   570		if (rlim >= RLIM_INFINITY)
   571			rlim = ~0;
   572		if (data_len + bss_len > rlim) {
   573			ret = -ENOMEM;
   574			goto err;
   575		}
   576	
   577		/* Flush all traces of the currently running executable */
   578		if (id == 0) {
   579			ret = begin_new_exec(bprm);
   580			if (ret)
   581				goto err;
   582	
   583			/* OK, This is the point of no return */
   584			set_personality(PER_LINUX_32BIT);
   585			setup_new_exec(bprm);
   586		}
   587	
   588		/*
   589		 * calculate the extra space we need to map in
   590		 */
   591		extra = max_t(unsigned long, bss_len + stack_len,
   592				relocs * sizeof(unsigned long));
   593	
   594		/*
   595		 * there are a couple of cases here,  the separate code/data
   596		 * case,  and then the fully copied to RAM case which lumps
   597		 * it all together.
   598		 */
   599		if (!IS_ENABLED(CONFIG_MMU) && !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {
   600			/*
   601			 * this should give us a ROM ptr,  but if it doesn't we don't
   602			 * really care
   603			 */
   604			pr_debug("ROM mapping of file (we hope)\n");
   605	
   606			textpos = vm_mmap(bprm->file, 0, text_len, PROT_READ|PROT_EXEC,
   607					  MAP_PRIVATE, 0);
   608			if (!textpos || IS_ERR_VALUE(textpos)) {
   609				ret = textpos;
   610				if (!textpos)
   611					ret = -ENOMEM;
   612				pr_err("Unable to mmap process text, errno %d\n", ret);
   613				goto err;
   614			}
   615	
   616			len = data_len + extra +
   617				DATA_START_OFFSET_WORDS * sizeof(unsigned long);
   618			len = PAGE_ALIGN(len);
   619			realdatastart = vm_mmap(NULL, 0, len,
   620				PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);
   621	
   622			if (realdatastart == 0 || IS_ERR_VALUE(realdatastart)) {
   623				ret = realdatastart;
   624				if (!realdatastart)
   625					ret = -ENOMEM;
   626				pr_err("Unable to allocate RAM for process data, "
   627				       "errno %d\n", ret);
   628				vm_munmap(textpos, text_len);
   629				goto err;
   630			}
   631			datapos = ALIGN(realdatastart +
   632					DATA_START_OFFSET_WORDS * sizeof(unsigned long),
   633					FLAT_DATA_ALIGN);
   634	
   635			pr_debug("Allocated data+bss+stack (%u bytes): %lx\n",
   636				 data_len + bss_len + stack_len, datapos);
   637	
   638			fpos = ntohl(hdr->data_start);
   639	#ifdef CONFIG_BINFMT_ZFLAT
   640			if (flags & FLAT_FLAG_GZDATA) {
   641				result = decompress_exec(bprm, fpos, (char *)datapos,
   642							 full_data, 0);
   643			} else
   644	#endif
   645			{
   646				result = read_code(bprm->file, datapos, fpos,
   647						full_data);
   648			}
   649			if (IS_ERR_VALUE(result)) {
   650				ret = result;
   651				pr_err("Unable to read data+bss, errno %d\n", ret);
   652				vm_munmap(textpos, text_len);
   653				vm_munmap(realdatastart, len);
   654				goto err;
   655			}
   656	
   657			reloc = (__be32 __user *)
   658				(datapos + (ntohl(hdr->reloc_start) - text_len));
   659			memp = realdatastart;
   660			memp_size = len;
   661		} else {
   662	
   663			len = text_len + data_len + extra +
   664				DATA_START_OFFSET_WORDS * sizeof(u32);
   665			len = PAGE_ALIGN(len);
   666			textpos = vm_mmap(NULL, 0, len,
   667				PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);
   668	
   669			if (!textpos || IS_ERR_VALUE(textpos)) {
   670				ret = textpos;
   671				if (!textpos)
   672					ret = -ENOMEM;
   673				pr_err("Unable to allocate RAM for process text/data, "
   674				       "errno %d\n", ret);
   675				goto err;
   676			}
   677	
   678			realdatastart = textpos + ntohl(hdr->data_start);
   679			datapos = ALIGN(realdatastart +
   680					DATA_START_OFFSET_WORDS * sizeof(u32),
   681					FLAT_DATA_ALIGN);
   682	
   683			reloc = (__be32 __user *)
   684				(datapos + (ntohl(hdr->reloc_start) - text_len));
   685			memp = textpos;
   686			memp_size = len;
   687	#ifdef CONFIG_BINFMT_ZFLAT
   688			/*
   689			 * load it all in and treat it like a RAM load from now on
   690			 */
   691			if (flags & FLAT_FLAG_GZIP) {
   692	#ifndef CONFIG_MMU
   693				result = decompress_exec(bprm, sizeof(struct flat_hdr),
   694						 (((char *)textpos) + sizeof(struct flat_hdr)),
   695						 (text_len + full_data
   696							  - sizeof(struct flat_hdr)),
   697						 0);
   698				memmove((void *) datapos, (void *) realdatastart,
   699						full_data);
   700	#else
   701				/*
   702				 * This is used on MMU systems mainly for testing.
   703				 * Let's use a kernel buffer to simplify things.
   704				 */
   705				long unz_text_len = text_len - sizeof(struct flat_hdr);
   706				long unz_len = unz_text_len + full_data;
   707				char *unz_data = vmalloc(unz_len);
   708				if (!unz_data) {
   709					result = -ENOMEM;
   710				} else {
   711					result = decompress_exec(bprm, sizeof(struct flat_hdr),
   712								 unz_data, unz_len, 0);
   713					if (result == 0 &&
   714					    (copy_to_user((void __user *)textpos + sizeof(struct flat_hdr),
   715							  unz_data, unz_text_len) ||
   716					     copy_to_user((void __user *)datapos,
   717							  unz_data + unz_text_len, full_data)))
   718						result = -EFAULT;
   719					vfree(unz_data);
   720				}
   721	#endif
   722			} else if (flags & FLAT_FLAG_GZDATA) {
   723				result = read_code(bprm->file, textpos, 0, text_len);
   724				if (!IS_ERR_VALUE(result)) {
   725	#ifndef CONFIG_MMU
   726					result = decompress_exec(bprm, text_len, (char *) datapos,
   727							 full_data, 0);
   728	#else
   729					char *unz_data = vmalloc(full_data);
   730					if (!unz_data) {
   731						result = -ENOMEM;
   732					} else {
   733						result = decompress_exec(bprm, text_len,
   734							       unz_data, full_data, 0);
   735						if (result == 0 &&
   736						    copy_to_user((void __user *)datapos,
   737								 unz_data, full_data))
   738							result = -EFAULT;
   739						vfree(unz_data);
   740					}
   741	#endif
   742				}
   743			} else
   744	#endif /* CONFIG_BINFMT_ZFLAT */
   745			{
   746				result = read_code(bprm->file, textpos, 0, text_len);
   747				if (!IS_ERR_VALUE(result))
   748					result = read_code(bprm->file, datapos,
   749							   ntohl(hdr->data_start),
   750							   full_data);
   751			}
   752			if (IS_ERR_VALUE(result)) {
   753				ret = result;
   754				pr_err("Unable to read code+data+bss, errno %d\n", ret);
   755				vm_munmap(textpos, text_len + data_len + extra +
   756					  DATA_START_OFFSET_WORDS * sizeof(u32));
   757				goto err;
   758			}
   759		}
   760	
   761		start_code = textpos + sizeof(struct flat_hdr);
   762		end_code = textpos + text_len;
   763		text_len -= sizeof(struct flat_hdr); /* the real code len */
   764	
   765		/* The main program needs a little extra setup in the task structure */
   766		if (id == 0) {
   767			current->mm->start_code = start_code;
   768			current->mm->end_code = end_code;
   769			current->mm->start_data = datapos;
   770			current->mm->end_data = datapos + data_len;
   771			/*
   772			 * set up the brk stuff, uses any slack left in data/bss/stack
   773			 * allocation.  We put the brk after the bss (between the bss
   774			 * and stack) like other platforms.
   775			 * Userspace code relies on the stack pointer starting out at
   776			 * an address right at the end of a page.
   777			 */
   778			current->mm->start_brk = datapos + data_len + bss_len;
   779			current->mm->brk = (current->mm->start_brk + 3) & ~3;
   780	#ifndef CONFIG_MMU
   781			current->mm->context.end_brk = memp + memp_size - stack_len;
   782	#endif
   783		}
   784	
   785		if (flags & FLAT_FLAG_KTRACE) {
   786			pr_info("Mapping is %lx, Entry point is %x, data_start is %x\n",
   787				textpos, 0x00ffffff&ntohl(hdr->entry), ntohl(hdr->data_start));
   788			pr_info("%s %s: TEXT=%lx-%lx DATA=%lx-%lx BSS=%lx-%lx\n",
   789				id ? "Lib" : "Load", bprm->filename,
   790				start_code, end_code, datapos, datapos + data_len,
   791				datapos + data_len, (datapos + data_len + bss_len + 3) & ~3);
   792		}
   793	
   794		/* Store the current module values into the global library structure */
   795		libinfo->lib_list[id].start_code = start_code;
   796		libinfo->lib_list[id].start_data = datapos;
   797		libinfo->lib_list[id].start_brk = datapos + data_len + bss_len;
   798		libinfo->lib_list[id].text_len = text_len;
   799		libinfo->lib_list[id].loaded = 1;
   800		libinfo->lib_list[id].entry = (0x00ffffff & ntohl(hdr->entry)) + textpos;
   801		libinfo->lib_list[id].build_date = ntohl(hdr->build_date);
   802	
   803		/*
   804		 * We just load the allocations into some temporary memory to
   805		 * help simplify all this mumbo jumbo
   806		 *
   807		 * We've got two different sections of relocation entries.
   808		 * The first is the GOT which resides at the beginning of the data segment
   809		 * and is terminated with a -1.  This one can be relocated in place.
   810		 * The second is the extra relocation entries tacked after the image's
   811		 * data segment. These require a little more processing as the entry is
   812		 * really an offset into the image which contains an offset into the
   813		 * image.
   814		 */
   815		if (flags & FLAT_FLAG_GOTPIC) {
 > 816			rp = skip_got_header((u32 * __user) datapos);
   817			for (; ; rp++) {
   818				u32 addr, rp_val;
   819				if (get_user(rp_val, rp))
   820					return -EFAULT;
   821				if (rp_val == 0xffffffff)
   822					break;
   823				if (rp_val) {
   824					addr = calc_reloc(rp_val, libinfo, id, 0);
   825					if (addr == RELOC_FAILED) {
   826						ret = -ENOEXEC;
   827						goto err;
   828					}
   829					if (put_user(addr, rp))
   830						return -EFAULT;
   831				}
   832			}
   833		}
   834	
   835		/*
   836		 * Now run through the relocation entries.
   837		 * We've got to be careful here as C++ produces relocatable zero
   838		 * entries in the constructor and destructor tables which are then
   839		 * tested for being not zero (which will always occur unless we're
   840		 * based from address zero).  This causes an endless loop as __start
   841		 * is at zero.  The solution used is to not relocate zero addresses.
   842		 * This has the negative side effect of not allowing a global data
   843		 * reference to be statically initialised to _stext (I've moved
   844		 * __start to address 4 so that is okay).
   845		 */
   846		if (rev > OLD_FLAT_VERSION) {
   847			for (i = 0; i < relocs; i++) {
   848				u32 addr, relval;
   849				__be32 tmp;
   850	
   851				/*
   852				 * Get the address of the pointer to be
   853				 * relocated (of course, the address has to be
   854				 * relocated first).
   855				 */
   856				if (get_user(tmp, reloc + i))
   857					return -EFAULT;
   858				relval = ntohl(tmp);
   859				addr = flat_get_relocate_addr(relval);
   860				rp = (u32 __user *)calc_reloc(addr, libinfo, id, 1);
   861				if (rp == (u32 __user *)RELOC_FAILED) {
   862					ret = -ENOEXEC;
   863					goto err;
   864				}
   865	
   866				/* Get the pointer's value.  */
   867				ret = flat_get_addr_from_rp(rp, relval, flags, &addr);
   868				if (unlikely(ret))
   869					goto err;
   870	
   871				if (addr != 0) {
   872					/*
   873					 * Do the relocation.  PIC relocs in the data section are
   874					 * already in target order
   875					 */
   876					if ((flags & FLAT_FLAG_GOTPIC) == 0) {
   877						/*
   878						 * Meh, the same value can have a different
   879						 * byte order based on a flag..
   880						 */
   881						addr = ntohl((__force __be32)addr);
   882					}
   883					addr = calc_reloc(addr, libinfo, id, 0);
   884					if (addr == RELOC_FAILED) {
   885						ret = -ENOEXEC;
   886						goto err;
   887					}
   888	
   889					/* Write back the relocated pointer.  */
   890					ret = flat_put_addr_at_rp(rp, addr, relval);
   891					if (unlikely(ret))
   892						goto err;
   893				}
   894			}
   895	#ifdef CONFIG_BINFMT_FLAT_OLD
   896		} else {
   897			for (i = 0; i < relocs; i++) {
   898				__be32 relval;
   899				if (get_user(relval, reloc + i))
   900					return -EFAULT;
   901				old_reloc(ntohl(relval));
   902			}
   903	#endif /* CONFIG_BINFMT_FLAT_OLD */
   904		}
   905	
   906		flush_icache_user_range(start_code, end_code);
   907	
   908		/* zero the BSS,  BRK and stack areas */
   909		if (clear_user((void __user *)(datapos + data_len), bss_len +
   910			       (memp + memp_size - stack_len -		/* end brk */
   911			       libinfo->lib_list[id].start_brk) +	/* start brk */
   912			       stack_len))
   913			return -EFAULT;
   914	
   915		return 0;
   916	err:
   917		return ret;
   918	}
   919	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
