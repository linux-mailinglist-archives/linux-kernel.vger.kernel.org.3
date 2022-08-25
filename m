Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002C15A10DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241975AbiHYMpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241465AbiHYMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:45:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7380E13FAF
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661431498; x=1692967498;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=saLt7LoBJ+72ahHTpOKFGxOfPZ9teye4fthlLMq6KF0=;
  b=HqRr/3YoEg87fsk8xQ7bJJo7drRENrsloxQkgwzRh53GvCaZ1yYRJ7NS
   65a/K3G/g1jhl2Suiz+YyabPIVjUrJ46I9zg5axuiYldINMOJhC3395MY
   P5sZpNuQB4E4i03bD6kcqdtXRZRyjKEPq+RzZa60Y35W1w8zwtGImZ6fb
   jPiixBtC24A1w8TBnIOwke5xElYxEw0FM/bijAqPX1c1xID/G8GXsQqmb
   zHJPXfJPhPT+xX2gfN4byVWagdNkO/J6ExxVy+1Sndx7p7pRY/6Rr/rRb
   sJzeYJ7wjd8VvK6aB4+JjJer2X3t5rcZ0T+GjVLlWWABLlWMjhI5Vm8ZG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295506670"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="295506670"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 05:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="586855712"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2022 05:44:56 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRCEB-0002Ff-2d;
        Thu, 25 Aug 2022 12:44:55 +0000
Date:   Thu, 25 Aug 2022 20:44:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [stable:linux-5.4.y 2861/5186] include/linux/sunrpc/xdr.h:539:17:
 error: comparison is always false due to limited range of data type
Message-ID: <202208252033.POQoHYcN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
head:   684cc17be897de3b0fd2e5a021a702f68046d9fe
commit: ce1aa09cc14ed625104acc2d487bd92b9a88efe2 [2861/5186] NFSD: prevent integer overflow on 32 bit systems
config: sparc64-randconfig-r003-20220823 (https://download.01.org/0day-ci/archive/20220825/202208252033.POQoHYcN-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=ce1aa09cc14ed625104acc2d487bd92b9a88efe2
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.4.y
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
