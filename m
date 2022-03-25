Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC74E7C5A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiCYRaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244521AbiCYR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:29:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32327FD6F1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648229280; x=1679765280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/GPGUJn4ZLfGpZmv/+3m8wflE0f7VIHwXcWQByrjsFQ=;
  b=MmCZXNPSwe+2hekXVtQgEBWlohRXcZL55c9+TYhljTEyWxLjiGwXWC7S
   81bWoaL0Sv3kjehBFbnjZDZ8wftvfVut5yDeee5eFagd0YV4QuEoTyjM2
   2R9Qs9UwsuoOsJckffVndujp8Br7P8kq0L9Uyqrp++i8PV+6ldWsllnzM
   +aVfmzyvdyYfUKNNMaH7kfLyA0kfBzR7CwHAtDBprNDu7Dn31aEyHpMDx
   NLD3/FxBcBTavHQc46JeV98wC2PI6niqq9u6lW6EqwID2Ac4OhETib0V9
   WYFGhWSQEQ0SeV5xCVZNC5e0MESHlkLB52YUoiWPktwZqZgTM1X48scYE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="246163783"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="246163783"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 10:27:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="584532516"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Mar 2022 10:27:57 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXnjA-000MPz-Hj; Fri, 25 Mar 2022 17:27:56 +0000
Date:   Sat, 26 Mar 2022 01:27:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: include/linux/sunrpc/xdr.h:734:10: warning: result of comparison of
 constant 4611686018427387903 with expression of type '__u32' (aka 'unsigned
 int') is always false
Message-ID: <202203260009.5SM2MiP9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34af78c4e616c359ed428d79fe4758a35d2c5473
commit: 23a9dbbe0faf124fc4c139615633b9d12a3a89ef NFSD: prevent integer overflow on 32 bit systems
date:   10 days ago
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220326/202203260009.5SM2MiP9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=23a9dbbe0faf124fc4c139615633b9d12a3a89ef
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 23a9dbbe0faf124fc4c139615633b9d12a3a89ef
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/sunrpc/auth_gss/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/sunrpc/auth_gss/gss_generic_token.c:37:
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
