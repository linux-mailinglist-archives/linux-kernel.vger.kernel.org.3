Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9BB570B26
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiGKUKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGKUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:10:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121DBDE80
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657570243; x=1689106243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=11JzeC5bV8G9x9/tbK6G+Unrxq9Y53txcJlahYMwkAw=;
  b=QqTlwf75JOVjs2suCXPastHoiZ/EwYhd/mQxnjod/yVS/Yy21fHE/Lmk
   EN8XRbca+eLcwqJHf7SkSCOnoPU2poBuLmOGPi7PtOb7uILO/GbmLhV8M
   yfUxb/UNIsf+AhU4dPNx+ravHv5PrwfjvA4JuWQMOpwmaeMSdCg3WJ2ST
   XX/Sj1wR2guKemxOxgbzaFF3LHY8/jWRYJxdhAIKnx1tuxUPkVgN8KRwh
   O167wZGwyoowxLclRJQojxoPACHGxYe8qENSIaOSCbMGS8DUzdxhIyfbR
   ahp574is6RmaaXK+IHT22zMsKjB0dKLdi4zBwGuVUA7yHxGahs89Qx8uy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285887860"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="285887860"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 13:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="737221720"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2022 13:10:40 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAzjs-0001Bz-9e;
        Mon, 11 Jul 2022 20:10:40 +0000
Date:   Tue, 12 Jul 2022 04:09:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [linux-stable-rc:linux-4.19.y 2019/3297]
 include/linux/sunrpc/xdr.h:512:17: error: comparison is always false due to
 limited range of data type
Message-ID: <202207120459.h567EtWi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
head:   72d6154340a122052ef914485fa4176f1c50464d
commit: 3a2789e8ccb4a3e2a631f6817a2d3bb98b8c4fd8 [2019/3297] NFSD: prevent integer overflow on 32 bit systems
config: sparc64-randconfig-r026-20220710 (https://download.01.org/0day-ci/archive/20220712/202207120459.h567EtWi-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=3a2789e8ccb4a3e2a631f6817a2d3bb98b8c4fd8
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.19.y
        git checkout 3a2789e8ccb4a3e2a631f6817a2d3bb98b8c4fd8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash arch/sparc/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/sunrpc/sched.h:19,
                    from include/linux/sunrpc/auth.h:15,
                    from include/linux/nfs_fs.h:31,
                    from arch/sparc/kernel/sys_sparc32.c:25:
   include/linux/sunrpc/xdr.h: In function 'xdr_stream_decode_uint32_array':
>> include/linux/sunrpc/xdr.h:512:17: error: comparison is always false due to limited range of data type [-Werror=type-limits]
     512 |         if (len > SIZE_MAX / sizeof(*p))
         |                 ^
   In file included from include/linux/ethtool.h:17,
                    from include/linux/netdevice.h:41,
                    from include/net/sock.h:51,
                    from include/linux/tcp.h:23,
                    from include/linux/ipv6.h:87,
                    from include/net/ipv6.h:16,
                    from include/linux/sunrpc/clnt.h:28,
                    from include/linux/nfs_fs.h:32,
                    from arch/sparc/kernel/sys_sparc32.c:25:
   include/linux/compat.h: In function 'put_compat_sigset':
   include/linux/compat.h:495:58: error: this statement may fall through [-Werror=implicit-fallthrough=]
     495 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                                                 ~~~~~~~~~^~~~~~~~~~~~~
   include/linux/compat.h:496:9: note: here
     496 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |         ^~~~
   include/linux/compat.h:496:58: error: this statement may fall through [-Werror=implicit-fallthrough=]
     496 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                                                 ~~~~~~~~~^~~~~~~~~~~~~
   include/linux/compat.h:497:9: note: here
     497 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |         ^~~~
   include/linux/compat.h:497:58: error: this statement may fall through [-Werror=implicit-fallthrough=]
     497 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                 ~~~~~~~~~^~~~~~~~~~~~~
   include/linux/compat.h:498:9: note: here
     498 |         case 1: v.sig[1] = (set->sig[0] >> 32); v.sig[0] = set->sig[0];
         |         ^~~~
   cc1: all warnings being treated as errors


vim +512 include/linux/sunrpc/xdr.h

   490	
   491	/**
   492	 * xdr_stream_decode_uint32_array - Decode variable length array of integers
   493	 * @xdr: pointer to xdr_stream
   494	 * @array: location to store the integer array or NULL
   495	 * @array_size: number of elements to store
   496	 *
   497	 * Return values:
   498	 *   On success, returns number of elements stored in @array
   499	 *   %-EBADMSG on XDR buffer overflow
   500	 *   %-EMSGSIZE if the size of the array exceeds @array_size
   501	 */
   502	static inline ssize_t
   503	xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
   504			__u32 *array, size_t array_size)
   505	{
   506		__be32 *p;
   507		__u32 len;
   508		ssize_t retval;
   509	
   510		if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
   511			return -EBADMSG;
 > 512		if (len > SIZE_MAX / sizeof(*p))
   513			return -EBADMSG;
   514		p = xdr_inline_decode(xdr, len * sizeof(*p));
   515		if (unlikely(!p))
   516			return -EBADMSG;
   517		if (array == NULL)
   518			return len;
   519		if (len <= array_size) {
   520			if (len < array_size)
   521				memset(array+len, 0, (array_size-len)*sizeof(*array));
   522			array_size = len;
   523			retval = len;
   524		} else
   525			retval = -EMSGSIZE;
   526		for (; array_size > 0; p++, array++, array_size--)
   527			*array = be32_to_cpup(p);
   528		return retval;
   529	}
   530	#endif /* __KERNEL__ */
   531	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
