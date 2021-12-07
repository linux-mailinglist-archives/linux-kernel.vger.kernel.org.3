Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2990246C217
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbhLGRvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:51:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:41157 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhLGRvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:51:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="217662933"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="217662933"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 09:32:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="515617230"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2021 09:32:10 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mueK1-000MoR-Rz; Tue, 07 Dec 2021 17:32:09 +0000
Date:   Wed, 8 Dec 2021 01:31:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?K=FChnel?= <thomas.kuehnel@avm.de>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     kbuild-all@lists.01.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?K=FChnel?= <thomas.kuehnel@avm.de>,
        Nicolas Schier <n.schier@avm.de>
Subject: Re: [PATCH 2/3] fs/ntfs3: add functions to modify LE bitmaps
Message-ID: <202112080045.huYZOn4p-lkp@intel.com>
References: <20211207102454.576906-3-thomas.kuehnel@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207102454.576906-3-thomas.kuehnel@avm.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Thomas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1]

url:    https://github.com/0day-ci/linux/commits/Thomas-K-hnel/fs-ntfs3-Fixes-for-big-endian-systems/20211207-184206
base:   0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
config: arm64-randconfig-s031-20211207 (https://download.01.org/0day-ci/archive/20211208/202112080045.huYZOn4p-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/2227622e39d3100d10077199481f05ccb9a17204
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Thomas-K-hnel/fs-ntfs3-Fixes-for-big-endian-systems/20211207-184206
        git checkout 2227622e39d3100d10077199481f05ccb9a17204
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash fs/ntfs3/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/ntfs3/bitmap.c:1498:37: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask_to_set @@     got restricted __le32 [usertype] @@
   fs/ntfs3/bitmap.c:1498:37: sparse:     expected unsigned long mask_to_set
   fs/ntfs3/bitmap.c:1498:37: sparse:     got restricted __le32 [usertype]
>> fs/ntfs3/bitmap.c:1508:29: sparse: sparse: invalid assignment: &=
>> fs/ntfs3/bitmap.c:1508:29: sparse:    left side has type unsigned long
>> fs/ntfs3/bitmap.c:1508:29: sparse:    right side has type restricted __le32
>> fs/ntfs3/bitmap.c:1518:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask_to_clear @@     got restricted __le32 [usertype] @@
   fs/ntfs3/bitmap.c:1518:39: sparse:     expected unsigned long mask_to_clear
   fs/ntfs3/bitmap.c:1518:39: sparse:     got restricted __le32 [usertype]
   fs/ntfs3/bitmap.c:1528:31: sparse: sparse: invalid assignment: &=
   fs/ntfs3/bitmap.c:1528:31: sparse:    left side has type unsigned long
   fs/ntfs3/bitmap.c:1528:31: sparse:    right side has type restricted __le32

vim +1498 fs/ntfs3/bitmap.c

  1492	
  1493	void ntfs_bitmap_set_le(unsigned long *map, unsigned int start, int len)
  1494	{
  1495		unsigned long *p = map + BIT_WORD(start);
  1496		const unsigned int size = start + len;
  1497		int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
> 1498		unsigned long mask_to_set = cpu_to_le32(BITMAP_FIRST_WORD_MASK(start));
  1499	
  1500		while (len - bits_to_set >= 0) {
  1501			*p |= mask_to_set;
  1502			len -= bits_to_set;
  1503			bits_to_set = BITS_PER_LONG;
  1504			mask_to_set = ~0UL;
  1505			p++;
  1506		}
  1507		if (len) {
> 1508			mask_to_set &= cpu_to_le32(BITMAP_LAST_WORD_MASK(size));
  1509			*p |= mask_to_set;
  1510		}
  1511	}
  1512	
  1513	void ntfs_bitmap_clear_le(unsigned long *map, unsigned int start, int len)
  1514	{
  1515		unsigned long *p = map + BIT_WORD(start);
  1516		const unsigned int size = start + len;
  1517		int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
> 1518		unsigned long mask_to_clear = cpu_to_le32(BITMAP_FIRST_WORD_MASK(start));

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
