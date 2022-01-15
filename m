Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F348F994
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 22:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiAOVls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 16:41:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:59005 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233773AbiAOVlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 16:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642282904; x=1673818904;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1Lu2BSYLQ36vgGLEjbs4qcV3IgTuLpm2f8xL40fZuKc=;
  b=X7CQNoMpel36jB19hpkeBgB3gBwptpr+zs+CK+jr7+zAl+Qj8hGYGx08
   xmlJ2sR8rxmJuJFOvdo3n9nVR40gX1hW3eZfsNDsWucJjXUv3ezSbqpia
   BXRzf8FgWokme8ip0xbCiQtG2B/+f62Oczmwj3uhUB/4UmGXIURigi32V
   6vFb5/NjVArCyzGrAogV4xqdOJTr/Dju+4F+Hw/9luxP8bv3jJdH//yBe
   JHf/+helHG0q5t6QuE+tHWZ5/Mv1+q2AN5ssEIY/kZng3LK5ylvWmSXFv
   KqzSfhAGjFbRaDv2cuMP3PKfQXODX/ZVCsu4Qj+ZZJZ0e5/Q/mx3IArLf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="243265671"
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="243265671"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 13:41:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="491934681"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Jan 2022 13:41:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8qnu-000AJ9-Nd; Sat, 15 Jan 2022 21:41:42 +0000
Date:   Sun, 16 Jan 2022 05:41:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ojeda-linux:doc 955/959] init/Kconfig:2084: syntax error
Message-ID: <202201160443.Rlzfej5l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ojeda/linux.git doc
head:   2fc4925b38062461996c9ae2bdf227d1383117ce
commit: cf009425efb0d9533b5bf09ebd304b938e4e5dc2 [955/959] rust: rework Rust toolchain detection
config: microblaze-buildonly-randconfig-r005-20220116
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ojeda/linux/commit/cf009425efb0d9533b5bf09ebd304b938e4e5dc2
        git remote add ojeda-linux https://github.com/ojeda/linux.git
        git fetch --no-tags ojeda-linux doc
        git checkout cf009425efb0d9533b5bf09ebd304b938e4e5dc2
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=microblaze  buildonly-randconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=microblaze 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   error: no override and no default toolchain set
>> init/Kconfig:2084: syntax error
   init/Kconfig:2083: invalid statement
>> sh: 1: bindgen: not found
   init/Kconfig:2089: syntax error
   init/Kconfig:2088: invalid statement
   make[2]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
   make[1]: *** [Makefile:666: oldconfig] Error 2
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
   error: no override and no default toolchain set
>> init/Kconfig:2084: syntax error
   init/Kconfig:2083: invalid statement
>> sh: 1: bindgen: not found
   init/Kconfig:2089: syntax error
   init/Kconfig:2088: invalid statement
   make[2]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1
   make[1]: *** [Makefile:666: olddefconfig] Error 2
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.


vim +2084 init/Kconfig

  1944	
  1945	config SLAB_MERGE_DEFAULT
  1946		bool "Allow slab caches to be merged"
  1947		default y
  1948		help
  1949		  For reduced kernel memory fragmentation, slab caches can be
  1950		  merged when they share the same size and other characteristics.
  1951		  This carries a risk of kernel heap overflows being able to
  1952		  overwrite objects from merged caches (and more easily control
  1953		  cache layout), which makes such heap attacks easier to exploit
  1954		  by attackers. By keeping caches unmerged, these kinds of exploits
  1955		  can usually only damage objects in the same cache. To disable
  1956		  merging at runtime, "slab_nomerge" can be passed on the kernel
  1957		  command line.
  1958	
  1959	config SLAB_FREELIST_RANDOM
  1960		bool "Randomize slab freelist"
  1961		depends on SLAB || SLUB
  1962		help
  1963		  Randomizes the freelist order used on creating new pages. This
  1964		  security feature reduces the predictability of the kernel slab
  1965		  allocator against heap overflows.
  1966	
  1967	config SLAB_FREELIST_HARDENED
  1968		bool "Harden slab freelist metadata"
  1969		depends on SLAB || SLUB
  1970		help
  1971		  Many kernel heap attacks try to target slab cache metadata and
  1972		  other infrastructure. This options makes minor performance
  1973		  sacrifices to harden the kernel slab allocator against common
  1974		  freelist exploit methods. Some slab implementations have more
  1975		  sanity-checking than others. This option is most effective with
  1976		  CONFIG_SLUB.
  1977	
  1978	config SHUFFLE_PAGE_ALLOCATOR
  1979		bool "Page allocator randomization"
  1980		default SLAB_FREELIST_RANDOM && ACPI_NUMA
  1981		help
  1982		  Randomization of the page allocator improves the average
  1983		  utilization of a direct-mapped memory-side-cache. See section
  1984		  5.2.27 Heterogeneous Memory Attribute Table (HMAT) in the ACPI
  1985		  6.2a specification for an example of how a platform advertises
  1986		  the presence of a memory-side-cache. There are also incidental
  1987		  security benefits as it reduces the predictability of page
  1988		  allocations to compliment SLAB_FREELIST_RANDOM, but the
  1989		  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
  1990		  10th order of pages is selected based on cache utilization
  1991		  benefits on x86.
  1992	
  1993		  While the randomization improves cache utilization it may
  1994		  negatively impact workloads on platforms without a cache. For
  1995		  this reason, by default, the randomization is enabled only
  1996		  after runtime detection of a direct-mapped memory-side-cache.
  1997		  Otherwise, the randomization may be force enabled with the
  1998		  'page_alloc.shuffle' kernel command line parameter.
  1999	
  2000		  Say Y if unsure.
  2001	
  2002	config SLUB_CPU_PARTIAL
  2003		default y
  2004		depends on SLUB && SMP
  2005		bool "SLUB per cpu partial cache"
  2006		help
  2007		  Per cpu partial caches accelerate objects allocation and freeing
  2008		  that is local to a processor at the price of more indeterminism
  2009		  in the latency of the free. On overflow these caches will be cleared
  2010		  which requires the taking of locks that may cause latency spikes.
  2011		  Typically one would choose no for a realtime system.
  2012	
  2013	config MMAP_ALLOW_UNINITIALIZED
  2014		bool "Allow mmapped anonymous memory to be uninitialized"
  2015		depends on EXPERT && !MMU
  2016		default n
  2017		help
  2018		  Normally, and according to the Linux spec, anonymous memory obtained
  2019		  from mmap() has its contents cleared before it is passed to
  2020		  userspace.  Enabling this config option allows you to request that
  2021		  mmap() skip that if it is given an MAP_UNINITIALIZED flag, thus
  2022		  providing a huge performance boost.  If this option is not enabled,
  2023		  then the flag will be ignored.
  2024	
  2025		  This is taken advantage of by uClibc's malloc(), and also by
  2026		  ELF-FDPIC binfmt's brk and stack allocator.
  2027	
  2028		  Because of the obvious security issues, this option should only be
  2029		  enabled on embedded devices where you control what is run in
  2030		  userspace.  Since that isn't generally a problem on no-MMU systems,
  2031		  it is normally safe to say Y here.
  2032	
  2033		  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
  2034	
  2035	config SYSTEM_DATA_VERIFICATION
  2036		def_bool n
  2037		select SYSTEM_TRUSTED_KEYRING
  2038		select KEYS
  2039		select CRYPTO
  2040		select CRYPTO_RSA
  2041		select ASYMMETRIC_KEY_TYPE
  2042		select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
  2043		select ASN1
  2044		select OID_REGISTRY
  2045		select X509_CERTIFICATE_PARSER
  2046		select PKCS7_MESSAGE_PARSER
  2047		help
  2048		  Provide PKCS#7 message verification using the contents of the system
  2049		  trusted keyring to provide public keys.  This then can be used for
  2050		  module verification, kexec image verification and firmware blob
  2051		  verification.
  2052	
  2053	config PROFILING
  2054		bool "Profiling support"
  2055		help
  2056		  Say Y here to enable the extended profiling support mechanisms used
  2057		  by profilers.
  2058	
  2059	config RUST
  2060		bool "Rust support"
  2061		depends on RUST_IS_AVAILABLE
  2062		depends on ARM64 || CPU_32v6 || CPU_32v6K || (PPC64 && CPU_LITTLE_ENDIAN) || X86_64 || RISCV
  2063		depends on !COMPILE_TEST
  2064		depends on !MODVERSIONS
  2065		depends on !GCC_PLUGIN_RANDSTRUCT
  2066		default n
  2067		help
  2068		  Enables Rust support in the kernel.
  2069	
  2070		  This allows other Rust-related options, like drivers written in Rust,
  2071		  to be selected.
  2072	
  2073		  It is also required to be able to load external kernel modules
  2074		  written in Rust.
  2075	
  2076		  See Documentation/rust/ for more information.
  2077	
  2078		  If unsure, say N.
  2079	
  2080	config RUSTC_VERSION_TEXT
  2081		depends on RUST
  2082		string
  2083		default $(shell,$(RUSTC) --version)
> 2084	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
