Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E80554B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiFVNcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiFVNcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:32:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F781AF15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655904769; x=1687440769;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4BA6ocIV6Od4eDtUPoo94u293A4vDabJdvHyeIqBEzY=;
  b=QkeYlqs1h/QgmIrs1Lecu9g545PbIeFRsU+7CLoE2KPmcgwhzRHodQSi
   X1UIKGO0/7E2f0RrG1aHxrUPiOEGuDyU3y/H7m0LBOkInUJKuw3ZWdaFl
   He6KsL+M8zJH43XEQwWvG4kFEMZJ+2sd2jJf0WcEXCTqlH57kC/77VdN4
   jayCR8MullBkljJqU1sYiADIIQlR43BVO8GSxAcqjt0sQK3LI26Mx5Jvo
   HrTqG6wOiSJLskjR2HC6rVF16+4yFffkE+DuGc9A4iuVO50FSIKh7OAH0
   kiLVZdWpjoiMBcof+hfetHj1/DkxO9PfQPXgRqE1KGDGtINK81TEMuwjz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260236242"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260236242"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 06:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="690502072"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2022 06:32:48 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o40TP-0001Jd-J3;
        Wed, 22 Jun 2022 13:32:47 +0000
Date:   Wed, 22 Jun 2022 21:31:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [stable:linux-5.4.y 2861/4158] include/linux/sunrpc/xdr.h:539:17:
 error: comparison is always false due to limited range of data type
Message-ID: <202206222129.ghnMZRcz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
head:   f0c280af0ec7c79cf043594974206d87c3c46524
commit: ce1aa09cc14ed625104acc2d487bd92b9a88efe2 [2861/4158] NFSD: prevent integer overflow on 32 bit systems
config: sparc-randconfig-r013-20220622 (https://download.01.org/0day-ci/archive/20220622/202206222129.ghnMZRcz-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=ce1aa09cc14ed625104acc2d487bd92b9a88efe2
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.4.y
        git checkout ce1aa09cc14ed625104acc2d487bd92b9a88efe2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash arch/sparc/kernel/

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
   Depends on DEBUG_KERNEL && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS || MCOUNT
   Selected by
   - LOCKDEP && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86


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
