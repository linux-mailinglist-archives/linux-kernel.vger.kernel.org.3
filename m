Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88355859AA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiG3JhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiG3JhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:37:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A9815FDA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659173821; x=1690709821;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nnO2LEN/TsivdC6GGv8T0MR4Hvri7DBHRSIWe0glSTQ=;
  b=M1T0VBlWIL5iQgH+VCsBiS90RzM8ST9pyv0/pAqXwgAXyCVnAa1fX5cI
   hrMOnWmEIFQxUfUX9FUZyzfH1mGV1EEneEQ2lNoLMhrdqEL8zxSvwlAnz
   ltuivEtw8GB9xeHmPaaKO8LBkxH/kK1x7Hpf3X01XkIhlwk5dWbYQNQ+n
   PBPlmT6lwT67HE+VAshPVr3AAatZIsUK9xyxIJmrthsdDNgauQzwYNytK
   Kwie9dCJ2ef2KYvTcOqRQfYta+VZTor4r3921ucKxtPdSqRj3zQXDlu52
   HuvRy4iT0NMSJrZjhC9/8Rp+m2uG5D4/GoDtoviwsjXY6NU1wwKu8ttQL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="352908989"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="352908989"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 02:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="551990976"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Jul 2022 02:37:00 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHiu3-000Cgu-13;
        Sat, 30 Jul 2022 09:36:59 +0000
Date:   Sat, 30 Jul 2022 17:36:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [stable:linux-4.19.y 2019/3409] include/linux/sunrpc/xdr.h:512:17:
 error: comparison is always false due to limited range of data type
Message-ID: <202207301724.i0Djw2HL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
head:   b275bfc9c2d385c7f7a66f9dcd0364e71cd8b864
commit: 3a2789e8ccb4a3e2a631f6817a2d3bb98b8c4fd8 [2019/3409] NFSD: prevent integer overflow on 32 bit systems
config: sparc64-randconfig-r015-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301724.i0Djw2HL-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=3a2789e8ccb4a3e2a631f6817a2d3bb98b8c4fd8
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-4.19.y
        git checkout 3a2789e8ccb4a3e2a631f6817a2d3bb98b8c4fd8
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
                    from include/linux/nfs_fs.h:32:
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

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FRAME_POINTER
   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
   Selected by [y]:
   - LOCKDEP [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86


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
