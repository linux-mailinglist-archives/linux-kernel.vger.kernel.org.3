Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638DB4C549B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 09:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiBZIT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 03:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBZITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 03:19:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1264329C907
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 00:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645863529; x=1677399529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4aBlHQoKdJU04B0miPtpe0MVA5P57WayFJUqBHCI3Ew=;
  b=ZIoCekXE9evMy5QO/lgNQmnX1MD0IVBXPo9kt3pOwD5coYWKI1zpxEv/
   x/aM/qJ0cz/iE9sV1A6Gvtk4J0ti4pkNIGfEJ9bVFqlEJgeWh7tx/L/2V
   1qv8C7KelK2V307ZuJrgxAKHVqhJuXlD1kThyLdS7jr1BMFthQDDc6HP0
   B/KS8rnl6of/fwFBk6I+j1CKlsNtQ4zwNieKW/X94CS5q4isCDe+W0ZM6
   XoqiWDMMNRyg+aMdXzKiGdRJqrg1OWO4wSPFC6ZGuwq3+9pX92WiBffTh
   frdDHdGGxHpe/hHkM8/lBz5WSrrmRTWQMa0LDSJvTF6w4w0uB0GbiXUak
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="232613958"
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="232613958"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 00:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="574836557"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Feb 2022 00:18:45 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNsHs-0005In-Cu; Sat, 26 Feb 2022 08:18:44 +0000
Date:   Sat, 26 Feb 2022 16:17:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yusuf Khan <yusisamerican@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, gregkh@linuxfoundation.org,
        javier@javigon.com, arnd@arndb.de, will@kernel.org,
        axboe@kernel.dk, bjorn.andersson@linaro.org,
        Yusuf Khan <yusisamerican@gmail.com>
Subject: Re: [PATCH v2] drivers: ddcci: upstream DDCCI driver
Message-ID: <202202261633.79OaZm4i-lkp@intel.com>
References: <20220226040429.1035368-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226040429.1035368-1-yusisamerican@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yusuf,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on staging/staging-testing linus/master v5.17-rc5]
[cannot apply to next-20220225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yusuf-Khan/drivers-ddcci-upstream-DDCCI-driver/20220226-120531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220226/202202261633.79OaZm4i-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7eb8029b70584acc0e9ce82dfdcff13c5496f544
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yusuf-Khan/drivers-ddcci-upstream-DDCCI-driver/20220226-120531
        git checkout 7eb8029b70584acc0e9ce82dfdcff13c5496f544
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/ddcci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:5: warning: "O_CREAT" redefined
       5 | #define O_CREAT          01000  /* not fcntl */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:24: note: this is the location of the previous definition
      24 | #define O_CREAT         00000100        /* not fcntl */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:6: warning: "O_TRUNC" redefined
       6 | #define O_TRUNC          02000  /* not fcntl */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:33: note: this is the location of the previous definition
      33 | #define O_TRUNC         00001000        /* not fcntl */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:7: warning: "O_EXCL" redefined
       7 | #define O_EXCL           04000  /* not fcntl */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:27: note: this is the location of the previous definition
      27 | #define O_EXCL          00000200        /* not fcntl */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:8: warning: "O_NOCTTY" redefined
       8 | #define O_NOCTTY        010000  /* not fcntl */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:30: note: this is the location of the previous definition
      30 | #define O_NOCTTY        00000400        /* not fcntl */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:10: warning: "O_NONBLOCK" redefined
      10 | #define O_NONBLOCK       00004
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:39: note: this is the location of the previous definition
      39 | #define O_NONBLOCK      00004000
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:11: warning: "O_APPEND" redefined
      11 | #define O_APPEND         00010
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:36: note: this is the location of the previous definition
      36 | #define O_APPEND        00002000
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:12: warning: "O_DSYNC" redefined
      12 | #define O_DSYNC         040000  /* used to be O_SYNC, see below */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:42: note: this is the location of the previous definition
      42 | #define O_DSYNC         00010000        /* used to be O_SYNC, see below */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:13: warning: "O_DIRECTORY" redefined
      13 | #define O_DIRECTORY     0100000 /* must be a directory */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:54: note: this is the location of the previous definition
      54 | #define O_DIRECTORY     00200000        /* must be a directory */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:14: warning: "O_NOFOLLOW" redefined
      14 | #define O_NOFOLLOW      0200000 /* don't follow links */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:57: note: this is the location of the previous definition
      57 | #define O_NOFOLLOW      00400000        /* don't follow links */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:15: warning: "O_LARGEFILE" redefined
      15 | #define O_LARGEFILE     0400000 /* will be set by the kernel on every open */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:51: note: this is the location of the previous definition
      51 | #define O_LARGEFILE     00100000
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:16: warning: "O_DIRECT" redefined
      16 | #define O_DIRECT        02000000 /* direct disk access - should check with OSF/1 */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:48: note: this is the location of the previous definition
      48 | #define O_DIRECT        00040000        /* direct disk access hint */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:17: warning: "O_NOATIME" redefined
      17 | #define O_NOATIME       04000000
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:60: note: this is the location of the previous definition
      60 | #define O_NOATIME       01000000
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:18: warning: "O_CLOEXEC" redefined
      18 | #define O_CLOEXEC       010000000 /* set close_on_exec */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:63: note: this is the location of the previous definition
      63 | #define O_CLOEXEC       02000000        /* set close_on_exec */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:32: warning: "__O_SYNC" redefined
      32 | #define __O_SYNC        020000000
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:80: note: this is the location of the previous definition
      80 | #define __O_SYNC        04000000
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:35: warning: "O_PATH" redefined
      35 | #define O_PATH          040000000
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:85: note: this is the location of the previous definition
      85 | #define O_PATH          010000000
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:36: warning: "__O_TMPFILE" redefined
      36 | #define __O_TMPFILE     0100000000
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:89: note: this is the location of the previous definition
      89 | #define __O_TMPFILE     020000000
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:38: warning: "F_GETLK" redefined
      38 | #define F_GETLK         7
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:106: note: this is the location of the previous definition
     106 | #define F_GETLK         5
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:39: warning: "F_SETLK" redefined
      39 | #define F_SETLK         8
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:107: note: this is the location of the previous definition
     107 | #define F_SETLK         6
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:40: warning: "F_SETLKW" redefined
      40 | #define F_SETLKW        9
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:108: note: this is the location of the previous definition
     108 | #define F_SETLKW        7
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
>> arch/alpha/include/uapi/asm/fcntl.h:42: warning: "F_SETOWN" redefined
      42 | #define F_SETOWN        5       /*  for sockets. */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:111: note: this is the location of the previous definition
     111 | #define F_SETOWN        8       /* for sockets. */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
   arch/alpha/include/uapi/asm/fcntl.h:43: warning: "F_GETOWN" redefined
      43 | #define F_GETOWN        6       /*  for sockets. */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:112: note: this is the location of the previous definition
     112 | #define F_GETOWN        9       /* for sockets. */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
   arch/alpha/include/uapi/asm/fcntl.h:48: warning: "F_RDLCK" redefined
      48 | #define F_RDLCK         1
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:166: note: this is the location of the previous definition
     166 | #define F_RDLCK         0
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
   arch/alpha/include/uapi/asm/fcntl.h:49: warning: "F_WRLCK" redefined
      49 | #define F_WRLCK         2
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:167: note: this is the location of the previous definition
     167 | #define F_WRLCK         1
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
   arch/alpha/include/uapi/asm/fcntl.h:50: warning: "F_UNLCK" redefined
      50 | #define F_UNLCK         8
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:168: note: this is the location of the previous definition
     168 | #define F_UNLCK         2
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
   arch/alpha/include/uapi/asm/fcntl.h:53: warning: "F_EXLCK" redefined
      53 | #define F_EXLCK         16      /* or 3 */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:173: note: this is the location of the previous definition
     173 | #define F_EXLCK         4       /* or 3 */
         | 
   In file included from include/uapi/linux/fcntl.h:5,
                    from include/linux/fcntl.h:6,
                    from include/linux/fs.h:26,
                    from drivers/ddcci/ddcci.c:20:
   arch/alpha/include/uapi/asm/fcntl.h:54: warning: "F_SHLCK" redefined
      54 | #define F_SHLCK         32      /* or 4 */
         | 
   In file included from drivers/ddcci/ddcci.c:16:
   include/uapi/asm-generic/fcntl.h:174: note: this is the location of the previous definition
     174 | #define F_SHLCK         8       /* or 4 */
         | 
   drivers/ddcci/ddcci.c: In function 'ddcci_modalias_clean':
   drivers/ddcci/ddcci.c:76:17: error: expected '}' before 'else'
      76 |                 else if (c < '0' || (c > '9' && c < 'A') || (c > 'Z' && c < 'a') || c > 'z')
         |                 ^~~~


vim +/O_CREAT +5 arch/alpha/include/uapi/asm/fcntl.h

^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16   4  
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  @5  #define O_CREAT		 01000	/* not fcntl */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  @6  #define O_TRUNC		 02000	/* not fcntl */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  @7  #define O_EXCL		 04000	/* not fcntl */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  @8  #define O_NOCTTY	010000	/* not fcntl */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16   9  
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @10  #define O_NONBLOCK	 00004
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @11  #define O_APPEND	 00010
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27 @12  #define O_DSYNC		040000	/* used to be O_SYNC, see below */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @13  #define O_DIRECTORY	0100000	/* must be a directory */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @14  #define O_NOFOLLOW	0200000 /* don't follow links */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @15  #define O_LARGEFILE	0400000 /* will be set by the kernel on every open */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @16  #define O_DIRECT	02000000 /* direct disk access - should check with OSF/1 */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @17  #define O_NOATIME	04000000
620b5e68ee89ba include/asm-alpha/fcntl.h           Richard Henderson 2007-08-08 @18  #define O_CLOEXEC	010000000 /* set close_on_exec */
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  19  /*
76b7e0058d09f8 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-12-17  20   * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  21   * the O_SYNC flag.  We continue to use the existing numerical value
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  22   * for O_DSYNC semantics now, but using the correct symbolic name for it.
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  23   * This new value is used to request true Posix O_SYNC semantics.  It is
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  24   * defined in this strange way to make sure applications compiled against
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  25   * new headers get at least O_DSYNC semantics on older kernels.
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  26   *
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  27   * This has the nice side-effect that we can simply test for O_DSYNC
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  28   * wherever we do not care if O_DSYNC or O_SYNC is used.
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  29   *
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  30   * Note: __O_SYNC must never be used directly.
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  31   */
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27 @32  #define __O_SYNC	020000000
6b2f3d1f769be5 arch/alpha/include/asm/fcntl.h      Christoph Hellwig 2009-10-27  33  #define O_SYNC		(__O_SYNC|O_DSYNC)
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  34  
5229645bdc35f1 arch/alpha/include/asm/fcntl.h      Stephen Rothwell  2011-03-16 @35  #define O_PATH		040000000
bb458c644a59db arch/alpha/include/uapi/asm/fcntl.h Al Viro           2013-07-13 @36  #define __O_TMPFILE	0100000000
5229645bdc35f1 arch/alpha/include/asm/fcntl.h      Stephen Rothwell  2011-03-16  37  
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @38  #define F_GETLK		7
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @39  #define F_SETLK		8
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @40  #define F_SETLKW	9
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  41  
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @42  #define F_SETOWN	5	/*  for sockets. */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @43  #define F_GETOWN	6	/*  for sockets. */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  44  #define F_SETSIG	10	/*  for sockets. */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  45  #define F_GETSIG	11	/*  for sockets. */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  46  
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  47  /* for posix fcntl() and lockf() */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @48  #define F_RDLCK		1
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @49  #define F_WRLCK		2
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @50  #define F_UNLCK		8
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  51  
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  52  /* for old implementation of bsd flock () */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @53  #define F_EXLCK		16	/* or 3 */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16 @54  #define F_SHLCK		32	/* or 4 */
^1da177e4c3f41 include/asm-alpha/fcntl.h           Linus Torvalds    2005-04-16  55  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
