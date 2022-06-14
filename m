Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED8454BE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiFNXnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFNXm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:42:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92A91A83D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655250177; x=1686786177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AzMjodAxqu1zxZ6O9GwBL8stvOI7YSuvOydidLljVtg=;
  b=nNalkV2ew/MhysmZMMhv3kJwzfTSVGWtVDBImHuv4r91I7z6FCxe20Hc
   4PnOkWHmt4WY/MfzL9LEshI2hzL1d6DFi8R6MVdd9o25wvPDc3il8zgvv
   gCkA46kcv1gSlguXidoHxY9MqZ9xeVQ9+4jMP+LmGh2o++n6QGofogZf6
   78RQ+u8a91rZ3jXzL/DbHrjdsrLnFiJ5QoamqlKXQqRIxn+tDXivrsd3+
   l4dMmVxaoQTRIZW3P2MOwU5Yx6M7Syd9zPpggINuV/uI1Bg27f9Nlx5aw
   M/DSmns9qFF60LhaYHNtVVPV0r6Uysi05EH5DEnlWvdXrIswXJoOehnfS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="340437820"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="340437820"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 16:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="558632225"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2022 16:42:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1GBS-000MOx-8k;
        Tue, 14 Jun 2022 23:42:54 +0000
Date:   Wed, 15 Jun 2022 07:42:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shyam Prasad N <sprasad@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [samba-ksmbd:for-next 5/5] include/linux/kern_levels.h:5:25:
 warning: format '%x' expects argument of type 'unsigned int', but argument 3
 has type '__u64' {aka 'long long unsigned int'}
Message-ID: <202206150736.n4DaXscy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.samba.org/ksmbd.git for-next
head:   43c233283f928be86531f030c8a3faa497a30e15
commit: 43c233283f928be86531f030c8a3faa497a30e15 [5/5] cifs: when a channel is not found for server, log its connection id
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220615/202206150736.n4DaXscy-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add samba-ksmbd git://git.samba.org/ksmbd.git
        git fetch --no-tags samba-ksmbd for-next
        git checkout 43c233283f928be86531f030c8a3faa497a30e15
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/percpu.h:5,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/net/sock.h:38,
                    from fs/cifs/cifspdu.h:12,
                    from fs/cifs/sess.c:11:
   fs/cifs/sess.c: In function 'cifs_ses_get_chan_index':
>> include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type '__u64' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:447:25: note: in definition of macro 'printk_index_wrap'
     447 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:131:17: note: in expansion of macro 'printk'
     131 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:654:9: note: in expansion of macro 'no_printk'
     654 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:654:19: note: in expansion of macro 'KERN_DEBUG'
     654 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   fs/cifs/cifs_debug.h:65:17: note: in expansion of macro 'pr_debug_once'
      65 |                 pr_debug_ ## ratefunc("%s: " fmt,                       \
         |                 ^~~~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/sess.c:85:17: note: in expansion of macro 'cifs_dbg'
      85 |                 cifs_dbg(VFS, "unable to get chan index for server: 0x%x",
         |                 ^~~~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type '__u64' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:447:25: note: in definition of macro 'printk_index_wrap'
     447 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/once_lite.h:19:25: note: in expansion of macro 'printk'
      19 |                         func(__VA_ARGS__);                              \
         |                         ^~~~
   include/linux/once_lite.h:11:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
      11 |         DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/printk.h:614:9: note: in expansion of macro 'DO_ONCE_LITE'
     614 |         DO_ONCE_LITE(printk, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   include/linux/printk.h:631:9: note: in expansion of macro 'printk_once'
     631 |         printk_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:631:21: note: in expansion of macro 'KERN_ERR'
     631 |         printk_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                     ^~~~~~~~
   fs/cifs/cifs_debug.h:68:17: note: in expansion of macro 'pr_err_once'
      68 |                 pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);        \
         |                 ^~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/sess.c:85:17: note: in expansion of macro 'cifs_dbg'
      85 |                 cifs_dbg(VFS, "unable to get chan index for server: 0x%x",
         |                 ^~~~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type '__u64' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:447:25: note: in definition of macro 'printk_index_wrap'
     447 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:131:17: note: in expansion of macro 'printk'
     131 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:654:9: note: in expansion of macro 'no_printk'
     654 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:654:19: note: in expansion of macro 'KERN_DEBUG'
     654 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   fs/cifs/cifs_debug.h:70:17: note: in expansion of macro 'pr_debug_once'
      70 |                 pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);              \
         |                 ^~~~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/sess.c:85:17: note: in expansion of macro 'cifs_dbg'
      85 |                 cifs_dbg(VFS, "unable to get chan index for server: 0x%x",
         |                 ^~~~~~~~
>> include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type '__u64' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:447:25: note: in definition of macro 'printk_index_wrap'
     447 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:131:17: note: in expansion of macro 'printk'
     131 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:719:9: note: in expansion of macro 'no_printk'
     719 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:719:19: note: in expansion of macro 'KERN_DEBUG'
     719 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   fs/cifs/cifs_debug.h:65:17: note: in expansion of macro 'pr_debug_ratelimited'
      65 |                 pr_debug_ ## ratefunc("%s: " fmt,                       \
         |                 ^~~~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/sess.c:85:17: note: in expansion of macro 'cifs_dbg'
      85 |                 cifs_dbg(VFS, "unable to get chan index for server: 0x%x",
         |                 ^~~~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type '__u64' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:447:25: note: in definition of macro 'printk_index_wrap'
     447 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:669:17: note: in expansion of macro 'printk'
     669 |                 printk(fmt, ##__VA_ARGS__);                             \
         |                 ^~~~~~
   include/linux/printk.h:683:9: note: in expansion of macro 'printk_ratelimited'
     683 |         printk_ratelimited(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:683:28: note: in expansion of macro 'KERN_ERR'
     683 |         printk_ratelimited(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                            ^~~~~~~~
   fs/cifs/cifs_debug.h:68:17: note: in expansion of macro 'pr_err_ratelimited'
      68 |                 pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);        \
         |                 ^~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/sess.c:85:17: note: in expansion of macro 'cifs_dbg'
      85 |                 cifs_dbg(VFS, "unable to get chan index for server: 0x%x",
         |                 ^~~~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type '__u64' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:447:25: note: in definition of macro 'printk_index_wrap'
     447 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:131:17: note: in expansion of macro 'printk'
     131 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:719:9: note: in expansion of macro 'no_printk'
     719 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:719:19: note: in expansion of macro 'KERN_DEBUG'
     719 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   fs/cifs/cifs_debug.h:70:17: note: in expansion of macro 'pr_debug_ratelimited'
      70 |                 pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);              \
         |                 ^~~~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/sess.c:85:17: note: in expansion of macro 'cifs_dbg'
      85 |                 cifs_dbg(VFS, "unable to get chan index for server: 0x%x",
         |                 ^~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a7 Joe Perches 2012-07-30  4  
04d2c8c83d0e3ac Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3ac Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3ac Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
