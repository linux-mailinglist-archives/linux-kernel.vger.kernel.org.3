Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DC659795B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbiHQV4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238344AbiHQV4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:56:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0EBA9266
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660773398; x=1692309398;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FaAQy8O/LGzcxVMsdG5Su6izS8gYDFrUjl1H2eEXAT4=;
  b=a+fX2nhSYvmcZc3XN6bwnbEGVBEeDQjA9FJAFeD43OWZeM5/kBM3AS3k
   ZY4Q6S6PdPTm8t3qd6oAqjR/Sk7naTFN9ro5pmBM03G9H0sc8Zk56DIQH
   b9rrbDTjCGq83G56KmKA/W0tXFlmNK0ooYM3cyQ27s8HK0j7qiya41QZg
   +ns4SAu/l7D2atfAg+wecrFEW1/LummBeOgMLT3RdF3pnm4hm+nQQm9hR
   OLc3/UgNB8Lba8AfKAIC65DlL1yurKfHv+3f4KmbloCBrJQBg6GvfkWku
   Hxh9pH9uFaisG/qg8mDZlXM91QfZOJlkF6Q7dyyUGZRtWBdYd1RAe8H1K
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="290178487"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="290178487"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="935537470"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2022 14:56:37 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOR1g-0001Ng-1x;
        Wed, 17 Aug 2022 21:56:36 +0000
Date:   Thu, 18 Aug 2022 05:55:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [linux-stable-rc:linux-5.4.y 2861/4798]
 include/linux/sunrpc/xdr.h:539:17: error: comparison is always false due to
 limited range of data type
Message-ID: <202208180553.0V0SzNdp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
head:   de0cd3ea700d1e8ed76705d02e33b524cbb84cf3
commit: ce1aa09cc14ed625104acc2d487bd92b9a88efe2 [2861/4798] NFSD: prevent integer overflow on 32 bit systems
config: sparc64-randconfig-r022-20220818 (https://download.01.org/0day-ci/archive/20220818/202208180553.0V0SzNdp-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=ce1aa09cc14ed625104acc2d487bd92b9a88efe2
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.4.y
        git checkout ce1aa09cc14ed625104acc2d487bd92b9a88efe2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash arch/sparc/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/sunrpc/sched.h:19,
                    from include/linux/sunrpc/auth.h:15,
                    from include/linux/nfs_fs.h:31,
                    from arch/sparc/kernel/sys_sparc32.c:25:
   include/linux/sunrpc/xdr.h: In function 'xdr_stream_decode_uint32_array':
>> include/linux/sunrpc/xdr.h:539:17: error: comparison is always false due to limited range of data type [-Werror=type-limits]
     539 |         if (len > SIZE_MAX / sizeof(*p))
         |                 ^
   cc1: all warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FRAME_POINTER
   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
   Selected by [y]:
   - LOCKDEP [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86


vim +539 include/linux/sunrpc/xdr.h

   517	
   518	/**
   519	 * xdr_stream_decode_uint32_array - Decode variable length array of integers
   520	 * @xdr: pointer to xdr_stream
   521	 * @array: location to store the integer array or NULL
   522	 * @array_size: number of elements to store
   523	 *
   524	 * Return values:
   525	 *   On success, returns number of elements stored in @array
   526	 *   %-EBADMSG on XDR buffer overflow
   527	 *   %-EMSGSIZE if the size of the array exceeds @array_size
   528	 */
   529	static inline ssize_t
   530	xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
   531			__u32 *array, size_t array_size)
   532	{
   533		__be32 *p;
   534		__u32 len;
   535		ssize_t retval;
   536	
   537		if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
   538			return -EBADMSG;
 > 539		if (len > SIZE_MAX / sizeof(*p))
   540			return -EBADMSG;
   541		p = xdr_inline_decode(xdr, len * sizeof(*p));
   542		if (unlikely(!p))
   543			return -EBADMSG;
   544		if (array == NULL)
   545			return len;
   546		if (len <= array_size) {
   547			if (len < array_size)
   548				memset(array+len, 0, (array_size-len)*sizeof(*array));
   549			array_size = len;
   550			retval = len;
   551		} else
   552			retval = -EMSGSIZE;
   553		for (; array_size > 0; p++, array++, array_size--)
   554			*array = be32_to_cpup(p);
   555		return retval;
   556	}
   557	#endif /* __KERNEL__ */
   558	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
