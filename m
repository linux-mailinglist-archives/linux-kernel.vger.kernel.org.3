Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EBB496A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 06:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiAVFIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 00:08:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:37322 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbiAVFIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 00:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642828100; x=1674364100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EUpygQ/F8ZOi3Xpsg2yPj/2oIACnLY59yGgn/ZDJKQY=;
  b=iE7z4fa06fuAI7qX8CYiT64BXxdp0suz7yluIcJ2l3IFBy/pPYhSkyc3
   oL4LnqXq7IUBuRIY03cUkZ1dpwZyf6nzl4aDJNLW74rDtgNMDX15wDflE
   MXAmSnZgJLE7vSe71E0ynYMqdwZzqQkpNRvoTy9bmba7TZR1p9w5N+Lb0
   d8riHClGMi1iQvY1E8FNp9VW1PFPI4GUMno+unHIqtguhGHKSW8ftvb0s
   y4m5/sbg8LUiA8NuktL7Z+MbtfwILY4WLTSfTDKZXfdIgqhEkkyzC6ZsV
   FqKGAb0hxwI4J2iB7ugJCJy/akkRokzixPdXhwY2mKkduJHRNMRRSbGoW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="244614823"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="244614823"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 21:08:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="519321517"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2022 21:08:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB8dO-000G4I-CK; Sat, 22 Jan 2022 05:08:18 +0000
Date:   Sat, 22 Jan 2022 13:08:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander K <ak@tempesta-tech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:topic-rpc-with-tls 9991/9999] net/tls/ecdh.c:144:1: warning: no
 previous prototype for 'ttls_ecdh_read_params'
Message-ID: <202201221357.AwLCo8LM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls
head:   a72d5318846d67a7f3f5f2bcb4c0c09c4f8907d1
commit: a0a99a10f4f0e3e1e35e566687137669da78abcd [9991/9999] Port of Tempesta TLS handshakes to the Linux 5.10.68
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220122/202201221357.AwLCo8LM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=a0a99a10f4f0e3e1e35e566687137669da78abcd
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls
        git checkout a0a99a10f4f0e3e1e35e566687137669da78abcd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/tls/ecdh.c:144:1: warning: no previous prototype for 'ttls_ecdh_read_params' [-Wmissing-prototypes]
     144 | ttls_ecdh_read_params(TlsECDHCtx *ctx, const unsigned char **buf,
         | ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/random.h:10,
                    from net/tls/bignum.h:28,
                    from net/tls/error.c:25:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:50: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                  ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:143:9: note: in expansion of macro 'BUG_ON'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:143:17: note: in expansion of macro 'virt_addr_valid'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   net/tls/error.c: At top level:
>> net/tls/error.c:40:6: warning: no previous prototype for 'ttls_strerror' [-Wmissing-prototypes]
      40 | void ttls_strerror(int ret, char *buf, size_t buflen)
         |      ^~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CRYPTO_SHA1_SSSE3
   Depends on CRYPTO && X86 && 64BIT
   Selected by
   - TLS_HANDSHAKE && NET && TLS
   WARNING: unmet direct dependencies detected for NEED_MULTIPLE_NODES
   Depends on DISCONTIGMEM || NUMA
   Selected by
   - SINGLE_MEMORY_CHUNK && MMU


vim +/ttls_ecdh_read_params +144 net/tls/ecdh.c

   135	
   136	/**
   137	 * Read the ServerKeyExhange parameters (RFC 8422 5.4)
   138	 *	struct {
   139	 *		ECParameters	curve_params;
   140	 *		ECPoint		public;
   141	 *	} ServerECDHParams;
   142	 */
   143	int
 > 144	ttls_ecdh_read_params(TlsECDHCtx *ctx, const unsigned char **buf,
   145			      const unsigned char *end)
   146	{
   147		int r;
   148	
   149		if (!(ctx->grp = ttls_ecp_tls_read_group(buf, end - *buf)))
   150			return -EINVAL;
   151	
   152		/*
   153		 * Import a point from a TLS ECPoint record (RFC 8443 5.4)
   154		 *	struct {
   155		 *		opaque point <1..2^8-1>;
   156		 *	} ECPoint;
   157		 */
   158		if (!(r = ttls_ecdh_read_public(ctx, *buf, end - *buf)))
   159			*buf += end - *buf;
   160	
   161		return r;
   162	}
   163	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
