Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2FA50C803
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 09:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiDWHdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 03:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiDWHdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 03:33:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017A0C2C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650699050; x=1682235050;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Lqfh2dy8yhcMsDgpHBa9eJKT10BfW8n3g7pvy4zAr5o=;
  b=DW2dMb6cmqB192kcuYWjz+O/KM4pUS5aPIOkfx6XzOi728zwAd5OD4ur
   lCb/aPv9B06/6w4mwQEGwm9lYrvG6SBDsHFAYQKa6aRrvsBbmkgsxchMV
   lb1t9LQYZxbyg9U3ETnBHOpsB3gOo14+SaTwIvK2yZAcPIaAGl5DY/Nr0
   UWnyXySdPMgwIRKq0vpho8jrdlYfbeHVGIPw8Xw+oe8WRabgue/H48NAT
   RjGBelEWKPMXaPXIdQC85x6Fpti/oPewN8PA9gqq9gK2fpeACmxHoJ2xE
   ldWhXD3bmRGDn4PutPdde4xyjy3hVa8WZYfmp3RKRUbOFewb/GiNSqUum
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264356405"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="264356405"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 00:30:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="703856539"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Apr 2022 00:30:47 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niAEB-00001N-8X;
        Sat, 23 Apr 2022 07:30:47 +0000
Date:   Sat, 23 Apr 2022 15:30:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [linux-stable-rc:linux-5.15.y 4665/5978]
 include/linux/sunrpc/xdr.h:734:10: warning: result of comparison of constant
 4611686018427387903 with expression of type '__u32' (aka 'unsigned int') is
 always false
Message-ID: <202204231526.ijyYsWuP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   81d8d30c35edf29c5c70186ccb14dac4a5ca38a8
commit: 303cd6173dce0a28d26526c77814eb90a41bd898 [4665/5978] NFSD: prevent integer overflow on 32 bit systems
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220423/202204231526.ijyYsWuP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=303cd6173dce0a28d26526c77814eb90a41bd898
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 303cd6173dce0a28d26526c77814eb90a41bd898
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/ipv4/ipconfig.c:59:
   In file included from include/linux/nfs_fs.h:31:
   In file included from include/linux/sunrpc/auth.h:13:
   In file included from include/linux/sunrpc/sched.h:19:
>> include/linux/sunrpc/xdr.h:734:10: warning: result of comparison of constant 4611686018427387903 with expression of type '__u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           if (len > SIZE_MAX / sizeof(*p))
               ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +734 include/linux/sunrpc/xdr.h

   712	
   713	/**
   714	 * xdr_stream_decode_uint32_array - Decode variable length array of integers
   715	 * @xdr: pointer to xdr_stream
   716	 * @array: location to store the integer array or NULL
   717	 * @array_size: number of elements to store
   718	 *
   719	 * Return values:
   720	 *   On success, returns number of elements stored in @array
   721	 *   %-EBADMSG on XDR buffer overflow
   722	 *   %-EMSGSIZE if the size of the array exceeds @array_size
   723	 */
   724	static inline ssize_t
   725	xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
   726			__u32 *array, size_t array_size)
   727	{
   728		__be32 *p;
   729		__u32 len;
   730		ssize_t retval;
   731	
   732		if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
   733			return -EBADMSG;
 > 734		if (len > SIZE_MAX / sizeof(*p))
   735			return -EBADMSG;
   736		p = xdr_inline_decode(xdr, len * sizeof(*p));
   737		if (unlikely(!p))
   738			return -EBADMSG;
   739		if (array == NULL)
   740			return len;
   741		if (len <= array_size) {
   742			if (len < array_size)
   743				memset(array+len, 0, (array_size-len)*sizeof(*array));
   744			array_size = len;
   745			retval = len;
   746		} else
   747			retval = -EMSGSIZE;
   748		for (; array_size > 0; p++, array++, array_size--)
   749			*array = be32_to_cpup(p);
   750		return retval;
   751	}
   752	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
