Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C927F48F6D5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiAOM36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:29:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:62895 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230484AbiAOM35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642249797; x=1673785797;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cM3iZHaAz0LuyfMtiXeatB+oz9vjER2/EHjYaAtQY2w=;
  b=Lr21K0I43SzLyXHOCIppw25ObYjnTw7FwRlHfL8xrPUP2vaMLPgunU5e
   wUEK2zhWOYrUAwkzXN3GDhIUwGlKZYlRFoMUMc1ifEdti/4qaNjzkfm7C
   adstGQ+kTSthoT2C/WcAblZeYzq2vqUjuWG4ohkXwacviqVZFTExyfJ3b
   mf/ntrE1xy06Gjm5DSxKzDbEJsi4i2A7vXi9rzP+sfpxV1yC0weyH2BBD
   MFo2xulPICJG1lAtucXqXOW5dTpSvgrKN4YuQ/nswyiW5Sfk9q053TiqU
   RK7tqMVqJNai+ZhwENLCUtcb6lQU43KKo2Fi/7GraCFwptBpMZTWOfaar
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="224390403"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="224390403"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 04:29:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="624669861"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Jan 2022 04:29:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8iBu-0009lX-G1; Sat, 15 Jan 2022 12:29:54 +0000
Date:   Sat, 15 Jan 2022 20:29:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1517/2384]
 arch/mips/mti-malta/malta-dtshim.c:92:15: error: implicit declaration of
 function 'min_t'
Message-ID: <202201152000.mOrb5rnf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 986644c38150163ceefbb1302500fba6787bf621 [1517/2384] headers/deps: Optimize <linux/kernel.h>
config: mips-maltaaprp_defconfig (https://download.01.org/0day-ci/archive/20220115/202201152000.mOrb5rnf-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 650fc40b6d8d9a5869b4fca525d5f237b0ee2803)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=986644c38150163ceefbb1302500fba6787bf621
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 986644c38150163ceefbb1302500fba6787bf621
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/mips/mti-malta/malta-dtshim.c:92:15: error: implicit declaration of function 'min_t' [-Werror,-Wimplicit-function-declaration]
           size_preio = min_t(unsigned long, size, SZ_256M);
                        ^
>> arch/mips/mti-malta/malta-dtshim.c:92:21: error: expected expression
           size_preio = min_t(unsigned long, size, SZ_256M);
                              ^
>> arch/mips/mti-malta/malta-dtshim.c:192:21: error: implicit declaration of function 'max_t' [-Werror,-Wimplicit-function-declaration]
           physical_memsize = max_t(unsigned long, physical_memsize, memsize);
                              ^
   arch/mips/mti-malta/malta-dtshim.c:192:27: error: expected expression
           physical_memsize = max_t(unsigned long, physical_memsize, memsize);
                                    ^
   4 errors generated.


vim +/min_t +92 arch/mips/mti-malta/malta-dtshim.c

0051fc2e7b8450 Paul Burton     2016-09-19   72  
0051fc2e7b8450 Paul Burton     2016-09-19   73  static unsigned __init gen_fdt_mem_array(__be32 *mem_array, unsigned long size,
0051fc2e7b8450 Paul Burton     2016-09-19   74  					 enum mem_map map)
e81a8c7dabac05 Paul Burton     2015-09-22   75  {
e81a8c7dabac05 Paul Burton     2015-09-22   76  	unsigned long size_preio;
e81a8c7dabac05 Paul Burton     2015-09-22   77  	unsigned entries;
e81a8c7dabac05 Paul Burton     2015-09-22   78  
e81a8c7dabac05 Paul Burton     2015-09-22   79  	entries = 1;
e81a8c7dabac05 Paul Burton     2015-09-22   80  	mem_array[0] = cpu_to_be32(PHYS_OFFSET);
97f2645f358b41 Masahiro Yamada 2016-08-03   81  	if (IS_ENABLED(CONFIG_EVA)) {
e81a8c7dabac05 Paul Burton     2015-09-22   82  		/*
e81a8c7dabac05 Paul Burton     2015-09-22   83  		 * The current Malta EVA configuration is "special" in that it
e81a8c7dabac05 Paul Burton     2015-09-22   84  		 * always makes use of addresses in the upper half of the 32 bit
e81a8c7dabac05 Paul Burton     2015-09-22   85  		 * physical address map, which gives it a contiguous region of
e81a8c7dabac05 Paul Burton     2015-09-22   86  		 * DDR but limits it to 2GB.
e81a8c7dabac05 Paul Burton     2015-09-22   87  		 */
e81a8c7dabac05 Paul Burton     2015-09-22   88  		mem_array[1] = cpu_to_be32(size);
0051fc2e7b8450 Paul Burton     2016-09-19   89  		goto done;
0051fc2e7b8450 Paul Burton     2016-09-19   90  	}
0051fc2e7b8450 Paul Burton     2016-09-19   91  
e81a8c7dabac05 Paul Burton     2015-09-22  @92  	size_preio = min_t(unsigned long, size, SZ_256M);
e81a8c7dabac05 Paul Burton     2015-09-22   93  	mem_array[1] = cpu_to_be32(size_preio);
0051fc2e7b8450 Paul Burton     2016-09-19   94  	size -= size_preio;
0051fc2e7b8450 Paul Burton     2016-09-19   95  	if (!size)
0051fc2e7b8450 Paul Burton     2016-09-19   96  		goto done;
0051fc2e7b8450 Paul Burton     2016-09-19   97  
0051fc2e7b8450 Paul Burton     2016-09-19   98  	if (map == MEM_MAP_V2) {
0051fc2e7b8450 Paul Burton     2016-09-19   99  		/*
0051fc2e7b8450 Paul Burton     2016-09-19  100  		 * We have a flat 32 bit physical memory map with DDR filling
0051fc2e7b8450 Paul Burton     2016-09-19  101  		 * all 4GB of the memory map, apart from the I/O region which
0051fc2e7b8450 Paul Burton     2016-09-19  102  		 * obscures 256MB from 0x10000000-0x1fffffff.
0051fc2e7b8450 Paul Burton     2016-09-19  103  		 *
0051fc2e7b8450 Paul Burton     2016-09-19  104  		 * Therefore we discard the 256MB behind the I/O region.
0051fc2e7b8450 Paul Burton     2016-09-19  105  		 */
0051fc2e7b8450 Paul Burton     2016-09-19  106  		if (size <= SZ_256M)
0051fc2e7b8450 Paul Burton     2016-09-19  107  			goto done;
0051fc2e7b8450 Paul Burton     2016-09-19  108  		size -= SZ_256M;
0051fc2e7b8450 Paul Burton     2016-09-19  109  
0051fc2e7b8450 Paul Burton     2016-09-19  110  		/* Make use of the memory following the I/O region */
0051fc2e7b8450 Paul Burton     2016-09-19  111  		entries++;
0051fc2e7b8450 Paul Burton     2016-09-19  112  		mem_array[2] = cpu_to_be32(PHYS_OFFSET + SZ_512M);
0051fc2e7b8450 Paul Burton     2016-09-19  113  		mem_array[3] = cpu_to_be32(size);
0051fc2e7b8450 Paul Burton     2016-09-19  114  	} else {
0051fc2e7b8450 Paul Burton     2016-09-19  115  		/*
0051fc2e7b8450 Paul Burton     2016-09-19  116  		 * We have a 32 bit physical memory map with a 2GB DDR region
0051fc2e7b8450 Paul Burton     2016-09-19  117  		 * aliased in the upper & lower halves of it. The I/O region
0051fc2e7b8450 Paul Burton     2016-09-19  118  		 * obscures 256MB from 0x10000000-0x1fffffff in the low alias
0051fc2e7b8450 Paul Burton     2016-09-19  119  		 * but the DDR it obscures is accessible via the high alias.
0051fc2e7b8450 Paul Burton     2016-09-19  120  		 *
0051fc2e7b8450 Paul Burton     2016-09-19  121  		 * Simply access everything beyond the lowest 256MB of DDR using
0051fc2e7b8450 Paul Burton     2016-09-19  122  		 * the high alias.
0051fc2e7b8450 Paul Burton     2016-09-19  123  		 */
0051fc2e7b8450 Paul Burton     2016-09-19  124  		entries++;
0051fc2e7b8450 Paul Burton     2016-09-19  125  		mem_array[2] = cpu_to_be32(PHYS_OFFSET + SZ_2G + SZ_256M);
0051fc2e7b8450 Paul Burton     2016-09-19  126  		mem_array[3] = cpu_to_be32(size);
e81a8c7dabac05 Paul Burton     2015-09-22  127  	}
e81a8c7dabac05 Paul Burton     2015-09-22  128  
0051fc2e7b8450 Paul Burton     2016-09-19  129  done:
e81a8c7dabac05 Paul Burton     2015-09-22  130  	BUG_ON(entries > MAX_MEM_ARRAY_ENTRIES);
e81a8c7dabac05 Paul Burton     2015-09-22  131  	return entries;
e81a8c7dabac05 Paul Burton     2015-09-22  132  }
e81a8c7dabac05 Paul Burton     2015-09-22  133  
e81a8c7dabac05 Paul Burton     2015-09-22  134  static void __init append_memory(void *fdt, int root_off)
e81a8c7dabac05 Paul Burton     2015-09-22  135  {
e81a8c7dabac05 Paul Burton     2015-09-22  136  	__be32 mem_array[2 * MAX_MEM_ARRAY_ENTRIES];
e81a8c7dabac05 Paul Burton     2015-09-22  137  	unsigned long memsize;
e81a8c7dabac05 Paul Burton     2015-09-22  138  	unsigned mem_entries;
e81a8c7dabac05 Paul Burton     2015-09-22  139  	int i, err, mem_off;
0051fc2e7b8450 Paul Burton     2016-09-19  140  	enum mem_map mem_map;
0051fc2e7b8450 Paul Burton     2016-09-19  141  	u32 config;
e81a8c7dabac05 Paul Burton     2015-09-22  142  	char *var, param_name[10], *var_names[] = {
e81a8c7dabac05 Paul Burton     2015-09-22  143  		"ememsize", "memsize",
e81a8c7dabac05 Paul Burton     2015-09-22  144  	};
e81a8c7dabac05 Paul Burton     2015-09-22  145  
e81a8c7dabac05 Paul Burton     2015-09-22  146  	/* if a memory node already exists, leave it alone */
e81a8c7dabac05 Paul Burton     2015-09-22  147  	mem_off = fdt_path_offset(fdt, "/memory");
e81a8c7dabac05 Paul Burton     2015-09-22  148  	if (mem_off >= 0)
e81a8c7dabac05 Paul Burton     2015-09-22  149  		return;
e81a8c7dabac05 Paul Burton     2015-09-22  150  
e81a8c7dabac05 Paul Burton     2015-09-22  151  	/* find memory size from the bootloader environment */
e81a8c7dabac05 Paul Burton     2015-09-22  152  	for (i = 0; i < ARRAY_SIZE(var_names); i++) {
e81a8c7dabac05 Paul Burton     2015-09-22  153  		var = fw_getenv(var_names[i]);
e81a8c7dabac05 Paul Burton     2015-09-22  154  		if (!var)
e81a8c7dabac05 Paul Burton     2015-09-22  155  			continue;
e81a8c7dabac05 Paul Burton     2015-09-22  156  
e81a8c7dabac05 Paul Burton     2015-09-22  157  		err = kstrtoul(var, 0, &physical_memsize);
e81a8c7dabac05 Paul Burton     2015-09-22  158  		if (!err)
e81a8c7dabac05 Paul Burton     2015-09-22  159  			break;
e81a8c7dabac05 Paul Burton     2015-09-22  160  
e81a8c7dabac05 Paul Burton     2015-09-22  161  		pr_warn("Failed to read the '%s' env variable '%s'\n",
e81a8c7dabac05 Paul Burton     2015-09-22  162  			var_names[i], var);
e81a8c7dabac05 Paul Burton     2015-09-22  163  	}
e81a8c7dabac05 Paul Burton     2015-09-22  164  
e81a8c7dabac05 Paul Burton     2015-09-22  165  	if (!physical_memsize) {
e81a8c7dabac05 Paul Burton     2015-09-22  166  		pr_warn("The bootloader didn't provide memsize: defaulting to 32MB\n");
e81a8c7dabac05 Paul Burton     2015-09-22  167  		physical_memsize = 32 << 20;
e81a8c7dabac05 Paul Burton     2015-09-22  168  	}
e81a8c7dabac05 Paul Burton     2015-09-22  169  
97f2645f358b41 Masahiro Yamada 2016-08-03  170  	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
e81a8c7dabac05 Paul Burton     2015-09-22  171  		/*
e81a8c7dabac05 Paul Burton     2015-09-22  172  		 * SOC-it swaps, or perhaps doesn't swap, when DMA'ing
e81a8c7dabac05 Paul Burton     2015-09-22  173  		 * the last word of physical memory.
e81a8c7dabac05 Paul Burton     2015-09-22  174  		 */
e81a8c7dabac05 Paul Burton     2015-09-22  175  		physical_memsize -= PAGE_SIZE;
e81a8c7dabac05 Paul Burton     2015-09-22  176  	}
e81a8c7dabac05 Paul Burton     2015-09-22  177  
e81a8c7dabac05 Paul Burton     2015-09-22  178  	/* default to using all available RAM */
e81a8c7dabac05 Paul Burton     2015-09-22  179  	memsize = physical_memsize;
e81a8c7dabac05 Paul Burton     2015-09-22  180  
e81a8c7dabac05 Paul Burton     2015-09-22  181  	/* allow the user to override the usable memory */
e81a8c7dabac05 Paul Burton     2015-09-22  182  	for (i = 0; i < ARRAY_SIZE(var_names); i++) {
e81a8c7dabac05 Paul Burton     2015-09-22  183  		snprintf(param_name, sizeof(param_name), "%s=", var_names[i]);
e81a8c7dabac05 Paul Burton     2015-09-22  184  		var = strstr(arcs_cmdline, param_name);
e81a8c7dabac05 Paul Burton     2015-09-22  185  		if (!var)
e81a8c7dabac05 Paul Burton     2015-09-22  186  			continue;
e81a8c7dabac05 Paul Burton     2015-09-22  187  
e81a8c7dabac05 Paul Burton     2015-09-22  188  		memsize = memparse(var + strlen(param_name), NULL);
e81a8c7dabac05 Paul Burton     2015-09-22  189  	}
e81a8c7dabac05 Paul Burton     2015-09-22  190  
e81a8c7dabac05 Paul Burton     2015-09-22  191  	/* if the user says there's more RAM than we thought, believe them */
e81a8c7dabac05 Paul Burton     2015-09-22 @192  	physical_memsize = max_t(unsigned long, physical_memsize, memsize);
e81a8c7dabac05 Paul Burton     2015-09-22  193  
0051fc2e7b8450 Paul Burton     2016-09-19  194  	/* detect the memory map in use */
0051fc2e7b8450 Paul Burton     2016-09-19  195  	if (malta_scon() == MIPS_REVISION_SCON_ROCIT) {
0051fc2e7b8450 Paul Burton     2016-09-19  196  		/* ROCit has a register indicating the memory map in use */
0051fc2e7b8450 Paul Burton     2016-09-19  197  		config = readl((void __iomem *)CKSEG1ADDR(ROCIT_CONFIG_GEN1));
0051fc2e7b8450 Paul Burton     2016-09-19  198  		mem_map = config & ROCIT_CONFIG_GEN1_MEMMAP_MASK;
0051fc2e7b8450 Paul Burton     2016-09-19  199  		mem_map >>= ROCIT_CONFIG_GEN1_MEMMAP_SHIFT;
0051fc2e7b8450 Paul Burton     2016-09-19  200  	} else {
0051fc2e7b8450 Paul Burton     2016-09-19  201  		/* if not using ROCit, presume the v1 memory map */
0051fc2e7b8450 Paul Burton     2016-09-19  202  		mem_map = MEM_MAP_V1;
0051fc2e7b8450 Paul Burton     2016-09-19  203  	}
0051fc2e7b8450 Paul Burton     2016-09-19  204  	if (mem_map > MEM_MAP_V2)
0051fc2e7b8450 Paul Burton     2016-09-19  205  		panic("Unsupported physical memory map v%u detected",
0051fc2e7b8450 Paul Burton     2016-09-19  206  		      (unsigned int)mem_map);
0051fc2e7b8450 Paul Burton     2016-09-19  207  
e81a8c7dabac05 Paul Burton     2015-09-22  208  	/* append memory to the DT */
e81a8c7dabac05 Paul Burton     2015-09-22  209  	mem_off = fdt_add_subnode(fdt, root_off, "memory");
e81a8c7dabac05 Paul Burton     2015-09-22  210  	if (mem_off < 0)
e81a8c7dabac05 Paul Burton     2015-09-22  211  		panic("Unable to add memory node to DT: %d", mem_off);
e81a8c7dabac05 Paul Burton     2015-09-22  212  
e81a8c7dabac05 Paul Burton     2015-09-22  213  	err = fdt_setprop_string(fdt, mem_off, "device_type", "memory");
e81a8c7dabac05 Paul Burton     2015-09-22  214  	if (err)
e81a8c7dabac05 Paul Burton     2015-09-22  215  		panic("Unable to set memory node device_type: %d", err);
e81a8c7dabac05 Paul Burton     2015-09-22  216  
0051fc2e7b8450 Paul Burton     2016-09-19  217  	mem_entries = gen_fdt_mem_array(mem_array, physical_memsize, mem_map);
e81a8c7dabac05 Paul Burton     2015-09-22  218  	err = fdt_setprop(fdt, mem_off, "reg", mem_array,
e81a8c7dabac05 Paul Burton     2015-09-22  219  			  mem_entries * 2 * sizeof(mem_array[0]));
e81a8c7dabac05 Paul Burton     2015-09-22  220  	if (err)
e81a8c7dabac05 Paul Burton     2015-09-22  221  		panic("Unable to set memory regs property: %d", err);
e81a8c7dabac05 Paul Burton     2015-09-22  222  
0051fc2e7b8450 Paul Burton     2016-09-19  223  	mem_entries = gen_fdt_mem_array(mem_array, memsize, mem_map);
e81a8c7dabac05 Paul Burton     2015-09-22  224  	err = fdt_setprop(fdt, mem_off, "linux,usable-memory", mem_array,
e81a8c7dabac05 Paul Burton     2015-09-22  225  			  mem_entries * 2 * sizeof(mem_array[0]));
e81a8c7dabac05 Paul Burton     2015-09-22  226  	if (err)
e81a8c7dabac05 Paul Burton     2015-09-22  227  		panic("Unable to set linux,usable-memory property: %d", err);
e81a8c7dabac05 Paul Burton     2015-09-22  228  }
e81a8c7dabac05 Paul Burton     2015-09-22  229  

:::::: The code at line 92 was first introduced by commit
:::::: e81a8c7dabac05d444eda315ff1a747b0fe38396 MIPS: Malta: Setup RAM regions via DT

:::::: TO: Paul Burton <paul.burton@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
