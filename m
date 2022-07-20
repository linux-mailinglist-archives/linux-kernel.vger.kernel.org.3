Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0826657BF97
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiGTVbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiGTVbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:31:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13CD5C94E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658352667; x=1689888667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2u2WkGpWm77J9Fj6iozXFUHRQK3Byeni38N/0FHTVvo=;
  b=FCM3ctARw7ViGu3P9f1gf/ODtzOmuYiR3ML7NicorNyN5oip7hPwlUUl
   unU5pADlpkZHMz7x2/+tkOYO3ue1bqdfS4bdQblTo+C9zSUuQb4Qdlmao
   KXix1t3jPxfGMI5683viPU404NdQfgfdvRr39RtvaK3LiO3HRpqOhMVFd
   FYxDnuxDKbZZjBgbEt5NjHaFn2RIRSaIEhNhuZ4V4l1yjwqHTVG1fnonN
   nj7Ww/+mM0SBMRpQdgnY4ZplGonxwqewodhgmappkLWPzG3wZjWvuXmBj
   FAcGs/W3gmEbNXuTjmOTEOGOPmrA24+PCdbZO3f3FI7enjOu7Of00+qU0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="287636426"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="287636426"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 14:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="573473981"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Jul 2022 14:31:06 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEHHd-0000xd-AH;
        Wed, 20 Jul 2022 21:31:05 +0000
Date:   Thu, 21 Jul 2022 05:30:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [linux-stable-rc:linux-5.4.y 2861/4659]
 include/linux/sunrpc/xdr.h:539:17: error: comparison is always false due to
 limited range of data type
Message-ID: <202207210530.WFoSELcf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
head:   0b5688944207ade9aea3eabc48e296ff5a72a529
commit: ce1aa09cc14ed625104acc2d487bd92b9a88efe2 [2861/4659] NFSD: prevent integer overflow on 32 bit systems
config: sparc64-allnoconfig (https://download.01.org/0day-ci/archive/20220721/202207210530.WFoSELcf-lkp@intel.com/config)
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
