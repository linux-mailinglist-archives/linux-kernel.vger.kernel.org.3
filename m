Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29970492476
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbiARLP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:15:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:8844 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239448AbiARLOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642504487; x=1674040487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xsyC27XkD+QKX/ADefo2g/TIgEPRUlUOJBv3K++OuSI=;
  b=gpDFRpL06IAfbpYfgeHep2MgOJeE24JEC06XNF6vaJznHFyxP5mm2pn1
   /6ZIUzJv00TNODGDELrSGR/iEuJBRK05HWJKqyeYrMXOZ3nxVgZoJbx9N
   l4iXZYlMUWGkFP562exTx39TudN5BmGi3EiLopkWZRCIs/+ekR1edLqAC
   rjAvJymb8TFMLmgL6wUqBrcS28NHiNk1rE2WgUfdWlS0ZwxP1pHNxE3Rk
   QAfzfyd6TGlJPyE9DaqygB7IUko+t/c2tib07j96qtnq65QFc3G/9oaQL
   F6k9ojwlJntMo5mB6HqegvuQioCXzgIj28SvRGhaFeSEu3d60yFYsgV2B
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="331143426"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="331143426"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 03:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="622107672"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2022 03:14:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9mRZ-000CV3-U8; Tue, 18 Jan 2022 11:14:29 +0000
Date:   Tue, 18 Jan 2022 19:13:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is
 used uninitialized whenever 'if' condition is true
Message-ID: <202201181730.mj1jL8Vy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e3a8b6a1e70c37702054ae3c7c07ed828435d8ee
commit: 72b3942a173c387b27860ba1069636726e208777 scripts: ftrace - move the sort-processing in ftrace_init
date:   5 days ago
config: s390-randconfig-r044-20220116 (https://download.01.org/0day-ci/archive/20220118/202201181730.mj1jL8Vy-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c10cbb243cafc0cf42c3e922cb29183279444432)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=72b3942a173c387b27860ba1069636726e208777
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 72b3942a173c387b27860ba1069636726e208777
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from scripts/sorttable.c:195:
>> scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:479:6: note: uninitialized use occurs here
           if (mcount_sort_thread) {
               ^~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:380:2: note: remove the 'if' if its condition is always false
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:479:6: note: uninitialized use occurs here
           if (mcount_sort_thread) {
               ^~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:380:6: note: remove the '||' if its condition is always false
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
               ^~~~~~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:479:6: note: uninitialized use occurs here
           if (mcount_sort_thread) {
               ^~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:380:6: note: remove the '||' if its condition is always false
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:288:30: note: initialize the variable 'mcount_sort_thread' to silence this warning
           pthread_t mcount_sort_thread;
                                       ^
                                        = 0
   In file included from scripts/sorttable.c:197:
>> scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:479:6: note: uninitialized use occurs here
           if (mcount_sort_thread) {
               ^~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:380:2: note: remove the 'if' if its condition is always false
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:479:6: note: uninitialized use occurs here
           if (mcount_sort_thread) {
               ^~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:380:6: note: remove the '||' if its condition is always false
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
               ^~~~~~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:479:6: note: uninitialized use occurs here
           if (mcount_sort_thread) {
               ^~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:380:6: note: remove the '||' if its condition is always false
           if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~
   scripts/sorttable.h:288:30: note: initialize the variable 'mcount_sort_thread' to silence this warning
           pthread_t mcount_sort_thread;
                                       ^
                                        = 0
   6 warnings generated.
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:35:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:36:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:35:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:35:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   12 warnings generated.


vim +380 scripts/sorttable.h

   378	
   379	#ifdef MCOUNT_SORT_ENABLED
 > 380		if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
   381			fprintf(stderr,
   382				"incomplete mcount's sort in file: %s\n",
   383				fname);
   384			goto out;
   385		}
   386	
   387		/* create thread to sort mcount_loc concurrently */
   388		if (pthread_create(&mcount_sort_thread, NULL, &sort_mcount_loc, &mstruct)) {
   389			fprintf(stderr,
   390				"pthread_create mcount_sort_thread failed '%s': %s\n",
   391				strerror(errno), fname);
   392			goto out;
   393		}
   394	#endif
   395		if (!extab_sec) {
   396			fprintf(stderr,	"no __ex_table in file: %s\n", fname);
   397			goto out;
   398		}
   399	
   400		if (!symtab_sec) {
   401			fprintf(stderr,	"no .symtab in file: %s\n", fname);
   402			goto out;
   403		}
   404	
   405		if (!strtab_sec) {
   406			fprintf(stderr,	"no .strtab in file: %s\n", fname);
   407			goto out;
   408		}
   409	
   410		extab_image = (void *)ehdr + _r(&extab_sec->sh_offset);
   411		strtab = (const char *)ehdr + _r(&strtab_sec->sh_offset);
   412		symtab = (const Elf_Sym *)((const char *)ehdr +
   413							  _r(&symtab_sec->sh_offset));
   414	
   415		if (custom_sort) {
   416			custom_sort(extab_image, _r(&extab_sec->sh_size));
   417		} else {
   418			int num_entries = _r(&extab_sec->sh_size) / extable_ent_size;
   419			qsort(extab_image, num_entries,
   420			      extable_ent_size, compare_extable);
   421		}
   422	
   423		/* If there were relocations, we no longer need them. */
   424		if (relocs)
   425			memset(relocs, 0, relocs_size);
   426	
   427		/* find the flag main_extable_sort_needed */
   428		for (sym = (void *)ehdr + _r(&symtab_sec->sh_offset);
   429		     sym < sym + _r(&symtab_sec->sh_size) / sizeof(Elf_Sym);
   430		     sym++) {
   431			if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
   432				continue;
   433			if (!strcmp(strtab + r(&sym->st_name),
   434				    "main_extable_sort_needed")) {
   435				sort_needed_sym = sym;
   436				break;
   437			}
   438		}
   439	
   440		if (!sort_needed_sym) {
   441			fprintf(stderr,
   442				"no main_extable_sort_needed symbol in file: %s\n",
   443				fname);
   444			goto out;
   445		}
   446	
   447		sort_needed_sec = &shdr[get_secindex(r2(&sym->st_shndx),
   448						     sort_needed_sym - symtab,
   449						     symtab_shndx)];
   450		sort_needed_loc = (void *)ehdr +
   451			_r(&sort_needed_sec->sh_offset) +
   452			_r(&sort_needed_sym->st_value) -
   453			_r(&sort_needed_sec->sh_addr);
   454	
   455		/* extable has been sorted, clear the flag */
   456		w(0, sort_needed_loc);
   457		rc = 0;
   458	
   459	out:
   460	#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
   461		if (orc_sort_thread) {
   462			void *retval = NULL;
   463			/* wait for ORC tables sort done */
   464			rc = pthread_join(orc_sort_thread, &retval);
   465			if (rc) {
   466				fprintf(stderr,
   467					"pthread_join failed '%s': %s\n",
   468					strerror(errno), fname);
   469			} else if (retval) {
   470				rc = -1;
   471				fprintf(stderr,
   472					"failed to sort ORC tables '%s': %s\n",
   473					(char *)retval, fname);
   474			}
   475		}
   476	#endif
   477	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
