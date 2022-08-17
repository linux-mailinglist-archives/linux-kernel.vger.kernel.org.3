Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C07596761
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiHQCU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbiHQCUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:20:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4970A7FE69
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660702819; x=1692238819;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zGLvWtw8yrXWPCEV5nh8aDn9IdQAJ+B1YFs76G6HSzg=;
  b=VqOmqjFbanQEJF/31SYb7ZDsanAHlDBHmZrSyR7BelgsLiV774/YbMoa
   r05JNkbqwSTDI4ByZbhdyLz2l5VlmKCUSjraIOHUZ8qTNHs0ZfL7kIChg
   Eoa8P3hZ29UhWywrPVvnug1OyzyQh3hU9KnQQusya7+lsRhiscx0Gkwia
   qYayns8wpOp6FnA6rw1dofsETZnwE4epg2PnN9fvbDDw0ys4JXEm/BUeF
   Pep4bEb2Cw3FfnT6Mf9vuJrTytRVGUJpQTb05RS6XORMXzlhZDU4KKRQf
   IMjoRUsPfrXFRIhzZV/87xV9a57SWNw69PhSyPhpxmO/P86pJDky/AkTq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="279343545"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="279343545"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 19:20:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="852866871"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2022 19:20:08 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO8f9-0000Sz-2i;
        Wed, 17 Aug 2022 02:20:07 +0000
Date:   Wed, 17 Aug 2022 10:19:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/13] arch/x86/kernel/process.c:279:16: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202208171018.YSicD0Ib-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="935iG+o1P1Q4yHPC"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--935iG+o1P1Q4yHPC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   8836fbd6cd3120383a0bc63cd54c7dd55639ed49
commit: 2600a472582e2968633831d430c2a1366ad3e8b1 [5/13] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s021-20220815
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=2600a472582e2968633831d430c2a1366ad3e8b1
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 2600a472582e2968633831d430c2a1366ad3e8b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vsyscall/ arch/x86/kernel/ arch/x86/mm/ block/ drivers/acpi/ drivers/ata/ drivers/auxdisplay/ drivers/block/ drivers/char/ drivers/comedi/ drivers/gpu/drm/ drivers/hwmon/ drivers/input/ drivers/media/rc/ drivers/misc/ drivers/mtd/ drivers/nvme/host/ drivers/platform/x86/ drivers/pps/ drivers/scsi/ drivers/thermal/intel/int340x_thermal/ drivers/tty/ drivers/vfio/ drivers/video/fbdev/aty/ drivers/video/fbdev/matrox/ drivers/video/fbdev/sis/ drivers/video/fbdev/via/ drivers/xen/ fs/ kernel/ net/ sound/core/ sound/hda/ sound/pci/ sound/synth/emux/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/video/fbdev/aty/atyfb_base.c:479:9: sparse: sparse: switch with no cases
>> drivers/video/fbdev/aty/atyfb_base.c:1849:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/aty/atyfb_base.c:1849:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/aty/atyfb_base.c:1849:29: sparse:     got unsigned int *
--
>> drivers/video/fbdev/aty/aty128fb.c:2309:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/aty/aty128fb.c:2309:22: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/aty/aty128fb.c:2309:22: sparse:     got unsigned int *
   drivers/video/fbdev/aty/aty128fb.c:2323:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/aty/aty128fb.c:2323:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/aty/aty128fb.c:2323:24: sparse:     got unsigned int *
--
>> net/unix/af_unix.c:3091:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/unix/af_unix.c:3091:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/unix/af_unix.c:3091:23: sparse:     got int *
   net/unix/af_unix.c:3098:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/unix/af_unix.c:3098:31: sparse:     expected int [noderef] __user *__ptr_clean
   net/unix/af_unix.c:3098:31: sparse:     got int *
   net/unix/af_unix.c:3112:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/unix/af_unix.c:3112:31: sparse:     expected int [noderef] __user *__ptr_clean
   net/unix/af_unix.c:3112:31: sparse:     got int *
   net/unix/af_unix.c:159:13: sparse: sparse: context imbalance in 'unix_table_double_lock' - wrong count at exit
   net/unix/af_unix.c:178:28: sparse: sparse: context imbalance in 'unix_table_double_unlock' - unexpected unlock
   net/unix/af_unix.c:1290:13: sparse: sparse: context imbalance in 'unix_state_double_lock' - wrong count at exit
   net/unix/af_unix.c:1308:17: sparse: sparse: context imbalance in 'unix_state_double_unlock' - unexpected unlock
   net/unix/af_unix.c:1609:18: sparse: sparse: context imbalance in 'unix_stream_connect' - different lock contexts for basic block
   net/unix/af_unix.c:1972:25: sparse: sparse: context imbalance in 'unix_dgram_sendmsg' - unexpected unlock
   net/unix/af_unix.c:3255:20: sparse: sparse: context imbalance in 'unix_get_first' - wrong count at exit
   net/unix/af_unix.c:3286:34: sparse: sparse: context imbalance in 'unix_get_next' - unexpected unlock
   net/unix/af_unix.c:3316:42: sparse: sparse: context imbalance in 'unix_seq_stop' - unexpected unlock
   net/unix/af_unix.c:3419:34: sparse: sparse: context imbalance in 'bpf_iter_unix_hold_batch' - unexpected unlock
--
>> net/ipv6/ipv6_sockglue.c:1087:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1105:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1105:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1105:13: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1128:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     got int *
>> net/ipv6/ipv6_sockglue.c:1129:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     got unsigned int *
   net/ipv6/ipv6_sockglue.c:1130:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     got unsigned int *
   net/ipv6/ipv6_sockglue.c:1145:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1145:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1145:13: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1215:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1275:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1329:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1423:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1477:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     got int *
--
>> net/ipv6/raw.c:964:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:964:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:964:21: sparse:     got int *
   net/ipv6/raw.c:970:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:970:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:970:21: sparse:     got int *
   net/ipv6/raw.c:1062:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:1062:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:1062:13: sparse:     got int *
   net/ipv6/raw.c:1087:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:1087:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:1087:13: sparse:     got int *
   net/ipv6/raw.c:1123:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:1123:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:1123:24: sparse:     got int *
   net/ipv6/raw.c:1134:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:1134:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:1134:24: sparse:     got int *
--
>> net/ipv6/sit.c:359:54: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/sit.c:359:54: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/sit.c:359:54: sparse:     got unsigned int *
--
>> sound/pci/hda/hda_hwdep.c:26:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/hda/hda_hwdep.c:26:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/hda/hda_hwdep.c:26:13: sparse:     got unsigned int *
   sound/pci/hda/hda_hwdep.c:30:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/hda/hda_hwdep.c:30:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/hda/hda_hwdep.c:30:13: sparse:     got unsigned int *
   sound/pci/hda/hda_hwdep.c:40:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/hda/hda_hwdep.c:40:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/hda/hda_hwdep.c:40:13: sparse:     got unsigned int *
   sound/pci/hda/hda_hwdep.c:52:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/hda/hda_hwdep.c:52:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/hda/hda_hwdep.c:52:13: sparse:     got unsigned int *
>> sound/pci/hda/hda_hwdep.c:68:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/pci/hda/hda_hwdep.c:68:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/pci/hda/hda_hwdep.c:68:24: sparse:     got int *
--
>> drivers/video/fbdev/matrox/matroxfb_base.c:903:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:903:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:903:37: sparse:     got unsigned int *
   drivers/video/fbdev/matrox/matroxfb_base.c:1044:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:1044:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:1044:37: sparse:     got unsigned int *
   drivers/video/fbdev/matrox/matroxfb_base.c:1069:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:1069:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:1069:37: sparse:     got unsigned int *
   drivers/video/fbdev/matrox/matroxfb_base.c:1083:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:1083:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:1083:37: sparse:     got unsigned int *
--
>> drivers/xen/gntdev.c:870:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed short [noderef] __user *__ptr_clean @@     got signed short * @@
   drivers/xen/gntdev.c:870:13: sparse:     expected signed short [noderef] __user *__ptr_clean
   drivers/xen/gntdev.c:870:13: sparse:     got signed short *
--
>> drivers/xen/privcmd.c:375:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/xen/privcmd.c:375:31: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/xen/privcmd.c:375:31: sparse:     got unsigned long *
   drivers/xen/privcmd.c:559:35: sparse: sparse: cast removes address space '__user' of expression
   drivers/xen/privcmd.c:559:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] [usertype] __user *[addressable] [assigned] user_gfn @@     got unsigned long [usertype] * @@
   drivers/xen/privcmd.c:559:32: sparse:     expected unsigned long [noderef] [usertype] __user *[addressable] [assigned] user_gfn
   drivers/xen/privcmd.c:559:32: sparse:     got unsigned long [usertype] *
   drivers/xen/privcmd.c:686:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[usertype] h @@     got void [noderef] __user *uptr @@
   drivers/xen/privcmd.c:686:17: sparse:     expected void *[usertype] h
   drivers/xen/privcmd.c:686:17: sparse:     got void [noderef] __user *uptr
--
>> net/packet/af_packet.c:4034:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/packet/af_packet.c:4034:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/packet/af_packet.c:4034:13: sparse:     got int *
   net/packet/af_packet.c:4134:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/packet/af_packet.c:4134:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/packet/af_packet.c:4134:13: sparse:     got int *
   net/packet/af_packet.c:4202:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/packet/af_packet.c:4202:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/packet/af_packet.c:4202:24: sparse:     got int *
   net/packet/af_packet.c:4214:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/packet/af_packet.c:4214:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/packet/af_packet.c:4214:24: sparse:     got int *
   net/packet/af_packet.c:1050:13: sparse: sparse: context imbalance in '__packet_lookup_frame_in_block' - different lock contexts for basic block
   net/packet/af_packet.c:2490:17: sparse: sparse: context imbalance in 'tpacket_rcv' - unexpected unlock
--
>> net/sunrpc/cache.c:1019:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sunrpc/cache.c:1019:16: sparse:     expected int [noderef] __user *__ptr_clean
   net/sunrpc/cache.c:1019:16: sparse:     got int *
--
>> net/sunrpc/rpc_pipe.c:380:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sunrpc/rpc_pipe.c:380:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/sunrpc/rpc_pipe.c:380:24: sparse:     got int *
--
>> drivers/video/fbdev/sis/sis_main.c:1717:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1717:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1717:20: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse:     got unsigned int *
--
>> drivers/video/fbdev/via/viafbdev.c:409:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     got unsigned int *
--
>> arch/x86/kernel/process_64.c:810:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   arch/x86/kernel/process_64.c:810:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   arch/x86/kernel/process_64.c:810:23: sparse:     got unsigned long *
   arch/x86/kernel/process_64.c:816:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   arch/x86/kernel/process_64.c:816:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   arch/x86/kernel/process_64.c:816:23: sparse:     got unsigned long *
--
>> arch/x86/kernel/traps.c:621:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   arch/x86/kernel/traps.c:621:13: sparse:     expected char const [noderef] __user *__ptr_clean
   arch/x86/kernel/traps.c:621:13: sparse:     got char const *
--
>> arch/x86/kernel/ptrace.c:741:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   arch/x86/kernel/ptrace.c:741:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   arch/x86/kernel/ptrace.c:741:23: sparse:     got unsigned long *
--
>> arch/x86/kernel/process.c:279:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/process.c:279:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/process.c:279:16: sparse:     got unsigned int *
   arch/x86/kernel/process.c:758:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct cpuinfo_x86 * @@
   arch/x86/kernel/process.c:758:26: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/process.c:758:26: sparse:     got struct cpuinfo_x86 *
--
>> arch/x86/mm/fault.c:152:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   arch/x86/mm/fault.c:152:29: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   arch/x86/mm/fault.c:152:29: sparse:     got unsigned char *
--
>> arch/x86/entry/vsyscall/vsyscall_64.c:169:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   arch/x86/entry/vsyscall/vsyscall_64.c:169:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   arch/x86/entry/vsyscall/vsyscall_64.c:169:13: sparse:     got unsigned long *
--
   arch/x86/kernel/fpu/xstate.c:1526:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1526:9: sparse:     expected struct lockdep_map const *lock
   arch/x86/kernel/fpu/xstate.c:1526:9: sparse:     got struct lockdep_map [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1616:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1616:31: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1616:31: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1624:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1624:33: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1624:33: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1642:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1642:31: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1642:31: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1646:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1646:41: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1646:41: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1661:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1661:33: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1661:33: sparse:     got struct spinlock [noderef] __rcu *
>> arch/x86/kernel/fpu/xstate.c:1718:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   arch/x86/kernel/fpu/xstate.c:1718:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1718:24: sparse:     got unsigned long long *
   arch/x86/kernel/fpu/xstate.c:1727:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   arch/x86/kernel/fpu/xstate.c:1727:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1727:24: sparse:     got unsigned long long *
   arch/x86/kernel/fpu/xstate.c:1732:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   arch/x86/kernel/fpu/xstate.c:1732:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1732:24: sparse:     got unsigned long long *
--
>> kernel/groups.c:47:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/groups.c:47:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/groups.c:47:21: sparse:     got unsigned int *
   kernel/groups.c:64:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/groups.c:64:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/groups.c:64:21: sparse:     got unsigned int *
--
>> kernel/sys.c:744:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:744:18: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:744:18: sparse:     got unsigned int *
   kernel/sys.c:746:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:746:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:746:26: sparse:     got unsigned int *
   kernel/sys.c:748:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:748:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:748:32: sparse:     got unsigned int *
   kernel/sys.c:827:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:827:18: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:827:18: sparse:     got unsigned int *
   kernel/sys.c:829:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:829:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:829:26: sparse:     got unsigned int *
   kernel/sys.c:831:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:831:34: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:831:34: sparse:     got unsigned int *
   kernel/sys.c:1083:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/sys.c:1083:32: sparse:     expected struct task_struct *p1
   kernel/sys.c:1083:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/sys.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/sys.c:2369:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/sys.c:2369:25: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/sys.c:2369:25: sparse:     got int *
   kernel/sys.c:2505:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/sys.c:2505:25: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/sys.c:2505:25: sparse:     got int *
   kernel/sys.c:2640:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:2640:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:2640:24: sparse:     got unsigned int *
   kernel/sys.c:2642:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:2642:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:2642:24: sparse:     got unsigned int *
--
   kernel/fork.c:1307:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *__ret @@     got struct file *new_exe_file @@
   kernel/fork.c:1307:24: sparse:     expected struct file [noderef] __rcu *__ret
   kernel/fork.c:1307:24: sparse:     got struct file *new_exe_file
   kernel/fork.c:1307:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   kernel/fork.c:1307:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1307:22: sparse:     got struct file [noderef] __rcu *[assigned] __ret
>> kernel/fork.c:1472:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/fork.c:1472:25: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/fork.c:1472:25: sparse:     got int *
   kernel/fork.c:1638:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1638:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1638:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1647:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1647:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1647:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1648:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1648:9: sparse:     expected void const *from
   kernel/fork.c:1648:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1649:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1649:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1649:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2077:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2077:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2077:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2081:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2081:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2081:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2301:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/fork.c:2301:26: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/fork.c:2301:26: sparse:     got int *
   kernel/fork.c:2401:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
   kernel/fork.c:2401:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2401:32: sparse:     got struct task_struct *
   kernel/fork.c:2410:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2410:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2410:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2457:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2457:54: sparse:     expected struct list_head *head
   kernel/fork.c:2457:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2478:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2478:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2478:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2499:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2499:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2499:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2526:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2526:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2526:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2555:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2555:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2555:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2557:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2557:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2557:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2689:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/fork.c:2689:17: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/fork.c:2689:17: sparse:     got int *
   kernel/fork.c:2993:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2993:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2993:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3074:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3074:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3074:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:2122:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2455:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2456:59: sparse: sparse: dereference of noderef expression
--
   kernel/exit.c:281:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:281:37: sparse:     expected struct task_struct *tsk
   kernel/exit.c:281:37: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:284:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:284:32: sparse:     expected struct task_struct *task
   kernel/exit.c:284:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:285:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:285:35: sparse:     expected struct task_struct *task
   kernel/exit.c:285:35: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:330:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:330:24: sparse:     expected struct task_struct *parent
   kernel/exit.c:330:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:357:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:357:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:357:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:360:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:360:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:360:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:583:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:583:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:583:29: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:585:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:585:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:585:29: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:909:63: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *const sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/exit.c:909:63: sparse:     expected struct sighand_struct *const sighand
   kernel/exit.c:909:63: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/exit.c:1064:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1064:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1064:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1089:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1089:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1089:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1178:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1178:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1178:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1193:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1193:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1193:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1244:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1244:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1244:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1247:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1247:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1247:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1253:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1253:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1253:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1434:59: sparse: sparse: incompatible types in comparison expression (different base types):
   kernel/exit.c:1434:59: sparse:    void *
   kernel/exit.c:1434:59: sparse:    struct task_struct [noderef] __rcu *
   kernel/exit.c:1450:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu * @@
   kernel/exit.c:1450:25: sparse:     expected struct task_struct *parent
   kernel/exit.c:1450:25: sparse:     got struct task_struct [noderef] __rcu *
>> kernel/exit.c:1683:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/exit.c:1683:37: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/exit.c:1683:37: sparse:     got int *
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/exit.c: note: in included file (through include/linux/sched/signal.h, include/linux/rcuwait.h, include/linux/percpu-rwsem.h, ...):
   include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_zombie' - unexpected unlock
   include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_stopped' - unexpected unlock
   include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_continued' - unexpected unlock
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/exit.c:1542:9: sparse: sparse: context imbalance in 'do_wait' - wrong count at exit
--
>> kernel/capability.c:86:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/capability.c:86:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/capability.c:86:13: sparse:     got unsigned int *
   kernel/capability.c:101:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/capability.c:101:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/capability.c:101:21: sparse:     got unsigned int *
>> kernel/capability.c:159:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/capability.c:159:13: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/capability.c:159:13: sparse:     got int *
   kernel/capability.c:195:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct __user_cap_data_struct [noderef] __user * @@
   kernel/capability.c:195:43: sparse:     expected void const *from
   kernel/capability.c:195:43: sparse:     got struct __user_cap_data_struct [noderef] __user *
   kernel/capability.c:171:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:172:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:173:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:235:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/capability.c:235:13: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/capability.c:235:13: sparse:     got int *
   kernel/capability.c:246:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct __user_cap_data_struct [noderef] __user ( * )[2] @@
   kernel/capability.c:246:29: sparse:     expected void *to
   kernel/capability.c:246:29: sparse:     got struct __user_cap_data_struct [noderef] __user ( * )[2]
   kernel/capability.c:250:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:251:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:252:43: sparse: sparse: dereference of noderef expression
--
   kernel/ptrace.c:54:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:54:22: sparse:    struct task_struct *
   kernel/ptrace.c:54:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:73:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *parent @@     got struct task_struct *new_parent @@
   kernel/ptrace.c:73:23: sparse:     expected struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:73:23: sparse:     got struct task_struct *new_parent
   kernel/ptrace.c:74:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] __rcu *ptracer_cred @@     got struct cred const * @@
   kernel/ptrace.c:74:29: sparse:     expected struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:74:29: sparse:     got struct cred const *
   kernel/ptrace.c:128:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   kernel/ptrace.c:128:18: sparse:     expected struct cred const *old_cred
   kernel/ptrace.c:128:18: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:132:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:132:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:132:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:170:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:170:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:170:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:202:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:202:28: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:202:28: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:208:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:208:30: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:208:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:261:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:261:44: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:261:44: sparse:    struct task_struct *
   kernel/ptrace.c:452:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:452:24: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:452:24: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:477:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:477:26: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:477:26: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:513:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/ptrace.c:513:54: sparse:     expected struct task_struct *parent
   kernel/ptrace.c:513:54: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:521:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:521:53: sparse:     expected struct task_struct *new_parent
   kernel/ptrace.c:521:53: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:569:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:569:41: sparse:     expected struct task_struct *p1
   kernel/ptrace.c:569:41: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:571:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sigh @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/ptrace.c:571:50: sparse:     expected struct sighand_struct *sigh
   kernel/ptrace.c:571:50: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/ptrace.c:762:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:762:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:762:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:770:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:770:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:770:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:881:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:881:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:881:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:885:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:885:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:885:31: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/ptrace.c:1055:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/ptrace.c:1055:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/ptrace.c:1055:23: sparse:     got unsigned long *
   kernel/ptrace.c:1115:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1115:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1115:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1117:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1117:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1117:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1315:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/ptrace.c:1315:16: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/ptrace.c:1315:16: sparse:     got unsigned long *
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:519:38: sparse: sparse: dereference of noderef expression
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:709:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:725:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1266:9: sparse: sparse: context imbalance in 'ptrace_request' - different lock contexts for basic block
--
>> arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse:     expected int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse:     got int *
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse:     expected int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse:     got int *
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse:     expected int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse:     got int *
--
>> fs/exec.c:421:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *const [noderef] __user *__ptr_clean @@     got char const [noderef] __user *const * @@
   fs/exec.c:421:13: sparse:     expected char const [noderef] __user *const [noderef] __user *__ptr_clean
   fs/exec.c:421:13: sparse:     got char const [noderef] __user *const *
   fs/exec.c:422:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __user * @@     got void * @@
   fs/exec.c:422:31: sparse:     expected char const [noderef] __user *
   fs/exec.c:422:31: sparse:     got void *
   fs/exec.c:1051:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1051:48: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1051:48: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1158:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1158:56: sparse:     expected struct task_struct *parent
   fs/exec.c:1158:56: sparse:     got struct task_struct [noderef] __rcu *parent
   fs/exec.c:1193:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1193:47: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1193:47: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1307:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   fs/exec.c:1307:26: sparse:     expected struct spinlock [usertype] *lock
   fs/exec.c:1307:26: sparse:     got struct spinlock [noderef] __rcu *
   fs/exec.c:1309:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   fs/exec.c:1309:28: sparse:     expected struct spinlock [usertype] *lock
   fs/exec.c:1309:28: sparse:     got struct spinlock [noderef] __rcu *
   fs/exec.c:1766:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1766:70: sparse:     expected struct task_struct *tsk
   fs/exec.c:1766:70: sparse:     got struct task_struct [noderef] __rcu *parent
--
>> fs/pipe.c:626:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/pipe.c:626:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/pipe.c:626:24: sparse:     got int *
--
>> fs/ioctl.c:69:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:69:17: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:69:17: sparse:     got int *
   fs/ioctl.c:91:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:91:13: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:91:13: sparse:     got int *
   fs/ioctl.c:346:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:346:17: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:346:17: sparse:     got int *
   fs/ioctl.c:370:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:370:17: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:370:17: sparse:     got int *
>> fs/ioctl.c:424:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/ioctl.c:424:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/ioctl.c:424:13: sparse:     got unsigned short *
>> fs/ioctl.c:711:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ioctl.c:711:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ioctl.c:711:23: sparse:     got unsigned int *
   fs/ioctl.c:723:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ioctl.c:723:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ioctl.c:723:15: sparse:     got unsigned int *
   fs/ioctl.c:817:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:817:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:817:24: sparse:     got int *
   fs/ioctl.c:832:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:832:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:832:24: sparse:     got int *
--
>> fs/readdir.c:293:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/readdir.c:293:21: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/readdir.c:293:21: sparse:     got unsigned long *
>> fs/readdir.c:377:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/readdir.c:377:21: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/readdir.c:377:21: sparse:     got signed long long *
--
   fs/file.c:379:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **old_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:379:17: sparse:     expected struct file **old_fds
   fs/file.c:379:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:380:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **new_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:380:17: sparse:     expected struct file **new_fds
   fs/file.c:380:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:395:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/file.c:395:17: sparse:    struct file [noderef] __rcu *
   fs/file.c:395:17: sparse:    struct file *
   fs/file.c:430:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   fs/file.c:470:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fdtable [noderef] __rcu *fdt @@     got struct fdtable * @@
   fs/file.c:645:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:838:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:1100:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *tofree @@     got struct file [noderef] __rcu * @@
>> fs/file.c:1173:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
--
>> fs/namespace.c:3261:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   fs/namespace.c:3261:21: sparse:     expected char const [noderef] __user *__ptr_clean
   fs/namespace.c:3261:21: sparse:     got char const *
--
>> fs/read_write.c:1291:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/read_write.c:1291:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/read_write.c:1291:21: sparse:     got long *
   fs/read_write.c:1295:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/read_write.c:1295:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/read_write.c:1295:21: sparse:     got long *
>> fs/read_write.c:1312:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long long [noderef] __user *__ptr_clean @@     got long long * @@
   fs/read_write.c:1312:21: sparse:     expected long long [noderef] __user *__ptr_clean
   fs/read_write.c:1312:21: sparse:     got long long *
--
>> fs/utimes.c:273:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:273:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:273:21: sparse:     got signed int *
   fs/utimes.c:274:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:274:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:274:21: sparse:     got signed int *
   fs/utimes.c:275:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:275:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:275:21: sparse:     got signed int *
   fs/utimes.c:276:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:276:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:276:21: sparse:     got signed int *
>> fs/utimes.c:219:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/utimes.c:219:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/utimes.c:219:21: sparse:     got long *
   fs/utimes.c:220:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/utimes.c:220:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/utimes.c:220:21: sparse:     got long *
   fs/utimes.c:241:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:241:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:241:21: sparse:     got signed int *
   fs/utimes.c:242:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:242:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:242:21: sparse:     got signed int *
--
>> fs/nsfs.c:211:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/nsfs.c:211:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/nsfs.c:211:24: sparse:     got unsigned int *
--
>> fs/timerfd.c:316:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/timerfd.c:316:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/timerfd.c:316:23: sparse:     got unsigned long long *
--
   fs/aio.c:616:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got struct kioctx_cpu *cpu @@
   fs/aio.c:616:24: sparse:     expected void [noderef] __percpu *__pdata
   fs/aio.c:616:24: sparse:     got struct kioctx_cpu *cpu
   fs/aio.c:782:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct kioctx_cpu *cpu @@     got struct kioctx_cpu [noderef] __percpu * @@
   fs/aio.c:782:18: sparse:     expected struct kioctx_cpu *cpu
   fs/aio.c:782:18: sparse:     got struct kioctx_cpu [noderef] __percpu *
   fs/aio.c:829:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got struct kioctx_cpu *cpu @@
   fs/aio.c:829:24: sparse:     expected void [noderef] __percpu *__pdata
   fs/aio.c:829:24: sparse:     got struct kioctx_cpu *cpu
   fs/aio.c:934:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct kioctx_cpu * @@
   fs/aio.c:934:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   fs/aio.c:934:16: sparse:     got struct kioctx_cpu *
   fs/aio.c:952:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct kioctx_cpu * @@
   fs/aio.c:952:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   fs/aio.c:952:16: sparse:     got struct kioctx_cpu *
>> fs/aio.c:1081:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:1081:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:1081:13: sparse:     got unsigned int *
   fs/aio.c:1961:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:1961:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:1961:13: sparse:     got unsigned int *
>> fs/aio.c:1344:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/aio.c:1344:15: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/aio.c:1344:15: sparse:     got unsigned long *
   fs/aio.c:1358:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/aio.c:1358:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/aio.c:1358:23: sparse:     got unsigned long *
   fs/aio.c:1656:13: sparse: sparse: context imbalance in 'poll_iocb_lock_wq' - different lock contexts for basic block
   fs/aio.c:1687:13: sparse: sparse: context imbalance in 'poll_iocb_unlock_wq' - unexpected unlock
>> fs/aio.c:2076:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct iocb [noderef] __user *[noderef] __user *__ptr_clean @@     got struct iocb [noderef] __user ** @@
   fs/aio.c:2076:21: sparse:     expected struct iocb [noderef] __user *[noderef] __user *__ptr_clean
   fs/aio.c:2076:21: sparse:     got struct iocb [noderef] __user **
   fs/aio.c:2154:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:2154:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:2154:13: sparse:     got unsigned int *
--
>> fs/binfmt_elf.c:326:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/binfmt_elf.c:326:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:326:13: sparse:     got unsigned long long *
   fs/binfmt_elf.c:333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/binfmt_elf.c:333:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:333:21: sparse:     got unsigned long long *
   fs/binfmt_elf.c:340:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/binfmt_elf.c:340:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:340:13: sparse:     got unsigned long long *
   fs/binfmt_elf.c:348:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/binfmt_elf.c:348:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:348:21: sparse:     got unsigned long long *
   fs/binfmt_elf.c:355:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/binfmt_elf.c:355:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:355:13: sparse:     got unsigned long long *
--
>> fs/fhandle.c:72:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/fhandle.c:72:13: sparse:     expected int [noderef] __user *__ptr_clean
   fs/fhandle.c:72:13: sparse:     got int *
--
   kernel/sched/core.c:1027:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1027:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1027:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2191:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2191:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:2191:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2191:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2191:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2191:68: sparse:     got struct task_struct [noderef] __rcu *curr
>> kernel/sched/core.c:5122:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/sched/core.c:5122:17: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/sched/core.c:5122:17: sparse:     got int *
   kernel/sched/core.c:5440:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5440:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5440:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6386:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6386:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6386:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6912:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6912:17: sparse:    struct task_struct *
   kernel/sched/core.c:6912:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7128:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7128:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7128:22: sparse:    struct task_struct *
>> kernel/sched/core.c:7778:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sched/core.c:7778:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sched/core.c:7778:15: sparse:     got unsigned int *
   kernel/sched/core.c:7808:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sched/core.c:7808:9: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sched/core.c:7808:9: sparse:     got unsigned int *
   kernel/sched/core.c:11187:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11187:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11187:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:537:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/core.c:570:23: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:586:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c:624:36: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/core.c:665:36: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c:2182:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2183:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2184:18: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:1594:9: sparse: sparse: context imbalance in 'ttwu_runnable' - wrong count at exit
   kernel/sched/core.c:4265:9: sparse: sparse: context imbalance in 'task_call_func' - wrong count at exit
   kernel/sched/sched.h:1594:9: sparse: sparse: context imbalance in 'wake_up_new_task' - wrong count at exit
   kernel/sched/core.c:5099:9: sparse: sparse: context imbalance in 'finish_task_switch' - wrong count at exit
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
--
   kernel/locking/lockdep_proc.c:477:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/locking/lockdep_proc.c:477:17: sparse:    char const [noderef] __rcu *
   kernel/locking/lockdep_proc.c:477:17: sparse:    char const *
   kernel/locking/lockdep_proc.c:478:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/locking/lockdep_proc.c:478:17: sparse:    struct lockdep_subclass_key const [noderef] __rcu *
   kernel/locking/lockdep_proc.c:478:17: sparse:    struct lockdep_subclass_key const *
>> kernel/locking/lockdep_proc.c:683:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   kernel/locking/lockdep_proc.c:683:21: sparse:     expected char const [noderef] __user *__ptr_clean
   kernel/locking/lockdep_proc.c:683:21: sparse:     got char const *
--
>> fs/notify/inotify/inotify_user.c:337:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/notify/inotify/inotify_user.c:337:23: sparse:     expected int [noderef] __user *__ptr_clean
   fs/notify/inotify/inotify_user.c:337:23: sparse:     got int *
   fs/notify/inotify/inotify_user.c:577:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct fsnotify_mark_connector *conn @@     got struct fsnotify_mark_connector [noderef] __rcu *i_fsnotify_marks @@
   fs/notify/inotify/inotify_user.c:577:51: sparse:     expected struct fsnotify_mark_connector *conn
   fs/notify/inotify/inotify_user.c:577:51: sparse:     got struct fsnotify_mark_connector [noderef] __rcu *i_fsnotify_marks
--
>> fs/quota/quota.c:224:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/quota/quota.c:224:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/quota/quota.c:224:21: sparse:     got unsigned int *
   fs/quota/quota.c:298:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/quota/quota.c:298:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/quota/quota.c:298:21: sparse:     got unsigned int *
   fs/quota/quota.c:411:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/quota/quota.c:411:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/quota/quota.c:411:13: sparse:     got unsigned int *
>> fs/quota/quota.c:419:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed char [noderef] __user *__ptr_clean @@     got signed char * @@
   fs/quota/quota.c:419:13: sparse:     expected signed char [noderef] __user *__ptr_clean
   fs/quota/quota.c:419:13: sparse:     got signed char *
>> fs/quota/quota.c:420:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/quota/quota.c:420:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/quota/quota.c:420:13: sparse:     got unsigned short *
   fs/quota/quota.c:421:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed char [noderef] __user *__ptr_clean @@     got signed char * @@
   fs/quota/quota.c:421:13: sparse:     expected signed char [noderef] __user *__ptr_clean
   fs/quota/quota.c:421:13: sparse:     got signed char *
   fs/quota/quota.c:424:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/quota/quota.c:424:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/quota/quota.c:424:13: sparse:     got unsigned int *
>> fs/quota/quota.c:425:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/quota/quota.c:425:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/quota/quota.c:425:13: sparse:     got signed int *
   fs/quota/quota.c:426:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/quota/quota.c:426:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/quota/quota.c:426:13: sparse:     got signed int *
   fs/quota/quota.c:427:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/quota/quota.c:427:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/quota/quota.c:427:13: sparse:     got signed int *
   fs/quota/quota.c:428:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/quota/quota.c:428:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/quota/quota.c:428:13: sparse:     got unsigned short *
   fs/quota/quota.c:429:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/quota/quota.c:429:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/quota/quota.c:429:13: sparse:     got unsigned short *
--
>> fs/proc/page.c:75:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/proc/page.c:75:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/proc/page.c:75:21: sparse:     got unsigned long long *
   fs/proc/page.c:252:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/proc/page.c:252:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/proc/page.c:252:21: sparse:     got unsigned long long *
--
>> drivers/scsi/scsi_ioctl.c:49:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/scsi_ioctl.c:49:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:49:21: sparse:     got unsigned int *
>> drivers/scsi/scsi_ioctl.c:173:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:173:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:173:16: sparse:     got int *
   drivers/scsi/scsi_ioctl.c:178:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:178:28: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:178:28: sparse:     got int *
   drivers/scsi/scsi_ioctl.c:191:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:191:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:191:16: sparse:     got int *
   drivers/scsi/scsi_ioctl.c:196:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:196:25: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:196:25: sparse:     got int *
   drivers/scsi/scsi_ioctl.c:215:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:215:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:215:16: sparse:     got int *
   drivers/scsi/scsi_ioctl.c:532:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/scsi_ioctl.c:532:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:532:13: sparse:     got unsigned int *
   drivers/scsi/scsi_ioctl.c:534:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/scsi_ioctl.c:534:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:534:13: sparse:     got unsigned int *
>> drivers/scsi/scsi_ioctl.c:538:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/scsi_ioctl.c:538:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:538:13: sparse:     got unsigned char *
   drivers/scsi/scsi_ioctl.c:924:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:924:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:924:24: sparse:     got int *
--
>> drivers/scsi/scsi_error.c:2387:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_error.c:2387:17: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_error.c:2387:17: sparse:     got int *
--
>> drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:415:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:415:21: sparse:     got int *
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:419:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:419:32: sparse:     got int *
>> drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/scsi/sg.c:425:32: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:425:32: sparse:     got signed int *
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:431:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:431:32: sparse:     got int *
>> drivers/scsi/sg.c:638:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/scsi/sg.c:638:13: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:638:13: sparse:     got char const *
   drivers/scsi/sg.c:952:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:952:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:952:26: sparse:     got int *
   drivers/scsi/sg.c:975:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:975:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:975:24: sparse:     got int *
   drivers/scsi/sg.c:995:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:995:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:995:26: sparse:     got int *
   drivers/scsi/sg.c:1006:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1006:40: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1006:40: sparse:     got int *
   drivers/scsi/sg.c:1010:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1010:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1010:24: sparse:     got int *
   drivers/scsi/sg.c:1019:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1019:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1019:24: sparse:     got int *
   drivers/scsi/sg.c:1021:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1021:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1021:24: sparse:     got int *
   drivers/scsi/sg.c:1023:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1023:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1023:26: sparse:     got int *
   drivers/scsi/sg.c:1046:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1046:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1046:24: sparse:     got int *
   drivers/scsi/sg.c:1048:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1048:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1048:26: sparse:     got int *
   drivers/scsi/sg.c:1054:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1054:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1054:24: sparse:     got int *
   drivers/scsi/sg.c:1056:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1056:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1056:26: sparse:     got int *
   drivers/scsi/sg.c:1062:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1062:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1062:24: sparse:     got int *
   drivers/scsi/sg.c:1064:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1064:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1064:26: sparse:     got int *
   drivers/scsi/sg.c:1072:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1072:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1072:24: sparse:     got int *
   drivers/scsi/sg.c:1076:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1076:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1076:24: sparse:     got int *
   drivers/scsi/sg.c:1102:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1102:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1102:24: sparse:     got int *
   drivers/scsi/sg.c:1108:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1108:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1108:26: sparse:     got int *
   drivers/scsi/sg.c:1114:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1114:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1114:24: sparse:     got int *
--
>> drivers/scsi/megaraid.c:3003:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/megaraid.c:3003:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3003:21: sparse:     got unsigned int *
   drivers/scsi/megaraid.c:3009:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/megaraid.c:3009:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3009:21: sparse:     got unsigned int *
>> drivers/scsi/megaraid.c:3519:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/megaraid.c:3519:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3519:21: sparse:     got unsigned char *
>> drivers/scsi/megaraid.c:3526:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct mega_passthru [noderef] [usertype] __user *[noderef] __user *__ptr_clean @@     got struct mega_passthru [noderef] [usertype] __user ** @@
   drivers/scsi/megaraid.c:3526:29: sparse:     expected struct mega_passthru [noderef] [usertype] __user *[noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3526:29: sparse:     got struct mega_passthru [noderef] [usertype] __user **
   drivers/scsi/megaraid.c:3529:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/megaraid.c:3529:29: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3529:29: sparse:     got unsigned char *
   drivers/scsi/megaraid.c:3536:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/megaraid.c:3536:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3536:21: sparse:     got unsigned char *
   drivers/scsi/megaraid.c:3543:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct mega_passthru [noderef] [usertype] __user *[noderef] __user *__ptr_clean @@     got struct mega_passthru [noderef] [usertype] __user ** @@
   drivers/scsi/megaraid.c:3543:29: sparse:     expected struct mega_passthru [noderef] [usertype] __user *[noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3543:29: sparse:     got struct mega_passthru [noderef] [usertype] __user **
   drivers/scsi/megaraid.c:3546:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/megaraid.c:3546:29: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3546:29: sparse:     got unsigned char *
   drivers/scsi/megaraid.c:4470:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:4470:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4470:26: sparse:     got void *
   drivers/scsi/megaraid.c:4529:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:4529:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4529:26: sparse:     got void *
--
>> block/ioctl.c:58:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:58:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:58:13: sparse:     got int *
>> block/ioctl.c:58:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   block/ioctl.c:58:39: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   block/ioctl.c:58:39: sparse:     got void [noderef] __user **
>> block/ioctl.c:197:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   block/ioctl.c:197:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   block/ioctl.c:197:16: sparse:     got unsigned short *
   block/ioctl.c:202:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:202:16: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:202:16: sparse:     got int *
>> block/ioctl.c:207:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:207:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:207:16: sparse:     got unsigned int *
>> block/ioctl.c:212:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   block/ioctl.c:212:16: sparse:     expected long [noderef] __user *__ptr_clean
   block/ioctl.c:212:16: sparse:     got long *
>> block/ioctl.c:217:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   block/ioctl.c:217:16: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   block/ioctl.c:217:16: sparse:     got unsigned long *
>> block/ioctl.c:222:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   block/ioctl.c:222:16: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   block/ioctl.c:222:16: sparse:     got unsigned long long *
   block/ioctl.c:365:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:365:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:365:13: sparse:     got int *
   block/ioctl.c:451:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:451:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:451:13: sparse:     got int *
--
>> block/bsg.c:87:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:87:16: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:87:16: sparse:     got int *
   block/bsg.c:94:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:94:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:94:13: sparse:     got int *
   block/bsg.c:123:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:123:24: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:123:24: sparse:     got int *
   block/bsg.c:125:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:125:24: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:125:24: sparse:     got int *
   block/bsg.c:127:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:127:24: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:127:24: sparse:     got int *
   block/bsg.c:129:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:129:21: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:129:21: sparse:     got int *
   block/bsg.c:136:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:136:24: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:136:24: sparse:     got int *
   block/bsg.c:139:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:139:21: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:139:21: sparse:     got int *
   block/bsg.c:147:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:147:24: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:147:24: sparse:     got int *
--
>> drivers/acpi/ec_sys.c:53:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/acpi/ec_sys.c:53:21: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/acpi/ec_sys.c:53:21: sparse:     got char *
>> drivers/acpi/ec_sys.c:87:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/acpi/ec_sys.c:87:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/acpi/ec_sys.c:87:21: sparse:     got char const *
--
>> drivers/ata/libata-scsi.c:571:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/ata/libata-scsi.c:571:24: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/ata/libata-scsi.c:571:24: sparse:     got unsigned long *
--
>> drivers/auxdisplay/charlcd.c:482:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/auxdisplay/charlcd.c:482:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/auxdisplay/charlcd.c:482:21: sparse:     got char const *
--
>> drivers/auxdisplay/panel.c:1041:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/auxdisplay/panel.c:1041:17: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/auxdisplay/panel.c:1041:17: sparse:     got char *
--
>> sound/pci/emu10k1/emufx.c:518:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:518:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:518:26: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:534:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:534:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:534:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:554:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:554:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:554:29: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:555:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:555:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:555:29: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:585:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:585:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:585:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:586:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:586:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:586:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:605:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:605:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:605:29: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:606:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:606:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:606:29: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:623:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:623:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:623:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:626:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:626:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:626:21: sparse:     got unsigned int *
>> sound/pci/emu10k1/emufx.c:2560:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/pci/emu10k1/emufx.c:2560:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:2560:24: sparse:     got int *
   sound/pci/emu10k1/emufx.c:2614:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:2614:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:2614:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:2652:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:2652:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:2652:21: sparse:     got unsigned int *
   sound/pci/emu10k1/emufx.c:2671:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/emu10k1/emufx.c:2671:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/emu10k1/emufx.c:2671:21: sparse:     got unsigned int *
--
>> fs/autofs/root.c:812:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:812:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:812:16: sparse:     got int *
   fs/autofs/root.c:819:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:819:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:819:16: sparse:     got int *
>> fs/autofs/root.c:790:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/autofs/root.c:790:14: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/autofs/root.c:790:14: sparse:     got unsigned long *
   fs/autofs/root.c:794:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/autofs/root.c:794:14: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/autofs/root.c:794:14: sparse:     got unsigned long *
   fs/autofs/root.c:834:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:834:18: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:834:18: sparse:     got int *
--
>> fs/autofs/expire.c:616:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/expire.c:616:20: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/expire.c:616:20: sparse:     got int *
--
>> drivers/block/xen-blkfront.c:518:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/block/xen-blkfront.c:518:29: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/block/xen-blkfront.c:518:29: sparse:     got char *
--
>> drivers/char/random.c:1364:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/char/random.c:1364:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/char/random.c:1364:21: sparse:     got int *
   drivers/char/random.c:1370:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/char/random.c:1370:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/char/random.c:1370:21: sparse:     got int *
   drivers/char/random.c:1384:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/char/random.c:1384:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/char/random.c:1384:21: sparse:     got int *
   drivers/char/random.c:1388:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/char/random.c:1388:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/char/random.c:1388:21: sparse:     got int *
--
>> drivers/char/hpet.c:317:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/char/hpet.c:317:18: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/char/hpet.c:317:18: sparse:     got unsigned long *
--
>> fs/xfs/xfs_ioctl.c:1431:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl.c:1432:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl.c:1432:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1432:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl.c:1433:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl.c:1433:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1433:13: sparse:     got signed long long *
>> fs/xfs/xfs_ioctl.c:1434:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1434:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1434:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl.c:1435:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1435:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1435:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl.c:1439:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1439:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1439:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl.c:1440:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1440:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1440:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl.c:1441:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1441:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1441:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl.c:1442:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1442:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1442:13: sparse:     got signed int *
>> fs/xfs/xfs_ioctl.c:1945:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/xfs/xfs_ioctl.c:1945:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1945:24: sparse:     got int *
>> fs/xfs/xfs_ioctl.c:2107:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl.c:2107:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:2107:21: sparse:     got unsigned int *
--
>> drivers/comedi/comedi_fops.c:1083:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/comedi/comedi_fops.c:1083:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/comedi/comedi_fops.c:1083:29: sparse:     got unsigned int *
--
>> sound/core/rawmidi.c:705:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi.c:705:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:705:13: sparse:     got unsigned int *
>> sound/core/rawmidi.c:707:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:707:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:707:13: sparse:     got int *
   sound/core/rawmidi.c:709:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi.c:709:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:709:13: sparse:     got unsigned int *
   sound/core/rawmidi.c:912:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:912:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:912:24: sparse:     got int *
   sound/core/rawmidi.c:918:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:918:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:918:21: sparse:     got int *
   sound/core/rawmidi.c:930:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi.c:930:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:930:21: sparse:     got unsigned int *
   sound/core/rawmidi.c:965:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:965:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:965:21: sparse:     got int *
   sound/core/rawmidi.c:980:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:980:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:980:21: sparse:     got int *
   sound/core/rawmidi.c:1014:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:1014:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:1014:21: sparse:     got int *
   sound/core/rawmidi.c:1028:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:1028:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:1028:21: sparse:     got int *
   sound/core/rawmidi.c:1036:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:1036:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:1036:21: sparse:     got int *
--
   sound/core/control.c:391:11: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long h @@     got restricted snd_ctl_elem_iface_t const [usertype] iface @@
   sound/core/control.c:391:11: sparse:     expected unsigned long h
   sound/core/control.c:391:11: sparse:     got restricted snd_ctl_elem_iface_t const [usertype] iface
   sound/core/control.c:927:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:927:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:928:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:928:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:947:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:975:41: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1086:34: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1654:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
>> sound/core/control.c:1763:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1763:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1763:13: sparse:     got int *
   sound/core/control.c:1767:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1767:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1767:21: sparse:     got int *
   sound/core/control.c:1904:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1904:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1904:24: sparse:     got int *
   sound/core/control.c:1945:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1945:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1945:24: sparse:     got int *
--
>> sound/core/hwdep.c:243:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/hwdep.c:243:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:243:24: sparse:     got int *
   sound/core/hwdep.c:273:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/hwdep.c:273:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:273:29: sparse:     got int *
   sound/core/hwdep.c:292:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/hwdep.c:292:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:292:29: sparse:     got int *
>> sound/core/hwdep.c:302:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/hwdep.c:302:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:302:29: sparse:     got unsigned int *
--
>> sound/core/timer.c:2045:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/timer.c:2045:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/timer.c:2045:13: sparse:     got int *
   sound/core/timer.c:2084:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/timer.c:2084:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/timer.c:2084:24: sparse:     got int *
   sound/core/timer.c:790:25: sparse: sparse: context imbalance in 'snd_timer_process_callbacks' - unexpected unlock
--
>> sound/core/pcm.c:92:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:92:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:92:29: sparse:     got int *
   sound/core/pcm.c:97:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:97:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:97:29: sparse:     got int *
>> sound/core/pcm.c:112:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm.c:112:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm.c:112:29: sparse:     got unsigned int *
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:114:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:114:29: sparse:     got int *
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm.c:119:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm.c:119:29: sparse:     got unsigned int *
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:155:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:155:29: sparse:     got int *
--
>> sound/core/pcm_native.c:1082:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:1082:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:1082:20: sparse:     got unsigned int *
   sound/core/pcm_native.c:1108:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:1108:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:1108:20: sparse:     got unsigned int *
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3039:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3134:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3134:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3134:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3135:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3135:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3135:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3136:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3136:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3136:13: sparse:     got unsigned int *
>> sound/core/pcm_native.c:3171:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean @@     got restricted snd_pcm_state_t * @@
   sound/core/pcm_native.c:3171:13: sparse:     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3171:13: sparse:     got restricted snd_pcm_state_t *
   sound/core/pcm_native.c:3172:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3172:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3172:13: sparse:     got unsigned int *
>> sound/core/pcm_native.c:3173:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3173:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3173:13: sparse:     got signed int *
   sound/core/pcm_native.c:3174:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3174:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3174:13: sparse:     got signed int *
   sound/core/pcm_native.c:3175:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean @@     got restricted snd_pcm_state_t * @@
   sound/core/pcm_native.c:3175:13: sparse:     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3175:13: sparse:     got restricted snd_pcm_state_t *
   sound/core/pcm_native.c:3176:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3176:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3176:13: sparse:     got signed int *
   sound/core/pcm_native.c:3177:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3177:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3177:13: sparse:     got signed int *
   sound/core/pcm_native.c:3178:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3178:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3178:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3179:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3179:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3179:13: sparse:     got unsigned int *
>> sound/core/pcm_native.c:3191:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm_native.c:3191:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3191:13: sparse:     got int *
>> sound/core/pcm_native.c:3208:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3208:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3208:13: sparse:     got signed long *
   sound/core/pcm_native.c:3216:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3216:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3216:13: sparse:     got signed long *
   sound/core/pcm_native.c:3233:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3233:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3233:13: sparse:     got signed long *
   sound/core/pcm_native.c:3246:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3246:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3246:13: sparse:     got signed long *
>> sound/core/pcm_native.c:3257:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3257:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3257:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3259:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3259:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3259:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3262:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3262:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3262:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3273:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3273:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3273:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3275:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3275:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3275:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3278:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3278:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3278:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3302:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm_native.c:3302:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3302:24: sparse:     got int *
   sound/core/pcm_native.c:3310:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3310:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3310:21: sparse:     got unsigned int *
   sound/core/pcm_native.c:3357:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3357:21: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3357:21: sparse:     got signed long *
   sound/core/pcm_native.c:95:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock' - different lock contexts for basic block
   sound/core/pcm_native.c:96:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock' - unexpected unlock
   sound/core/pcm_native.c:97:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock_irq' - different lock contexts for basic block
   sound/core/pcm_native.c:98:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
   sound/core/pcm_native.c:145:9: sparse: sparse: context imbalance in 'snd_pcm_stream_lock_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:171:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave' - different lock contexts for basic block
   sound/core/pcm_native.c:184:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:201:39: sparse: sparse: context imbalance in 'snd_pcm_stream_unlock_irqrestore' - unexpected unlock
   sound/core/pcm_native.c:1261:44: sparse: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
   sound/core/pcm_native.c:1331:37: sparse: sparse: context imbalance in 'snd_pcm_stream_group_ref' - different lock contexts for basic block
--
>> sound/core/pcm_lib.c:2436:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2436:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2436:13: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2446:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2446:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2446:21: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2447:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2447:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2447:21: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2457:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2457:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2457:29: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2462:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2462:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2462:13: sparse:     got unsigned int *
--
   sound/core/oss/pcm_oss.c:919:53: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected int format @@     got restricted snd_pcm_format_t [assigned] [usertype] format @@
   sound/core/oss/pcm_oss.c:919:53: sparse:     expected int format
   sound/core/oss/pcm_oss.c:919:53: sparse:     got restricted snd_pcm_format_t [assigned] [usertype] format
   sound/core/oss/pcm_oss.c:919:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted snd_pcm_format_t [assigned] [usertype] sformat @@     got int @@
   sound/core/oss/pcm_oss.c:919:25: sparse:     expected restricted snd_pcm_format_t [assigned] [usertype] sformat
   sound/core/oss/pcm_oss.c:919:25: sparse:     got int
>> sound/core/oss/pcm_oss.c:2608:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2608:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2608:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2610:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2610:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2610:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2636:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2636:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2636:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2641:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2641:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2641:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2646:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2646:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2646:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2648:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2648:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2648:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2654:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2654:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2654:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2659:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2659:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2659:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2661:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2661:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2661:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2666:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2666:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2666:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2671:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2671:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2671:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2673:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2673:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2673:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2678:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2678:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2678:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2683:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2683:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2683:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2690:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2690:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2690:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2695:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2695:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2695:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2697:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2697:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2697:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2704:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2704:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2704:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2717:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2717:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2717:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2722:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2722:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2722:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2724:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2724:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2724:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2750:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2750:25: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2750:25: sparse:     got int *
   sound/core/oss/pcm_oss.c:2753:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2753:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2753:24: sparse:     got int *
--
>> sound/hda/hdmi_chmap.c:678:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:678:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:678:13: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:710:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:710:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:710:29: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:711:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:711:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:711:29: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:732:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:732:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:732:13: sparse:     got unsigned int *
--
>> fs/nilfs2/ioctl.c:165:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/nilfs2/ioctl.c:165:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/nilfs2/ioctl.c:165:16: sparse:     got int *
--
>> drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:308:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:308:32: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:308:32: sparse:     got unsigned long *
   drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:316:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:316:32: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:316:32: sparse:     got unsigned long *
   drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:325:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:325:32: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:325:32: sparse:     got unsigned long *
   drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:333:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:333:32: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c:333:32: sparse:     got unsigned long *
--
>> net/socket.c:1227:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/socket.c:1227:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/socket.c:1227:29: sparse:     got int *
   net/socket.c:1233:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/socket.c:1233:31: sparse:     expected int [noderef] __user *__ptr_clean
   net/socket.c:1233:31: sparse:     got int *
   net/socket.c:278:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/socket.c:278:15: sparse:     expected int [noderef] __user *__ptr_clean
   net/socket.c:278:15: sparse:     got int *
   net/socket.c:1685:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/socket.c:1685:15: sparse:     expected int [noderef] __user *__ptr_clean
   net/socket.c:1685:15: sparse:     got int *
   net/socket.c:1689:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/socket.c:1689:15: sparse:     expected int [noderef] __user *__ptr_clean
   net/socket.c:1689:15: sparse:     got int *
>> net/socket.c:2627:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/socket.c:2627:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/socket.c:2627:31: sparse:     got unsigned int *
   net/socket.c:2843:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/socket.c:2843:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/socket.c:2843:31: sparse:     got unsigned int *
--
>> net/core/dev_ioctl.c:81:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/dev_ioctl.c:81:16: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/dev_ioctl.c:81:16: sparse:     got int *
--
>> net/core/sock.c:743:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/sock.c:743:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/sock.c:743:13: sparse:     got int *
>> net/core/sock.c:1534:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/core/sock.c:1534:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/core/sock.c:1534:21: sparse:     got unsigned int *
   net/core/sock.c:1560:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/sock.c:1560:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/sock.c:1560:13: sparse:     got int *
   net/core/sock.c:1713:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/sock.c:1713:32: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/sock.c:1713:32: sparse:     got int *
   net/core/sock.c:1902:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/sock.c:1902:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/sock.c:1902:13: sparse:     got int *
   net/core/sock.c:2286:9: sparse: sparse: context imbalance in 'sk_clone_lock' - wrong count at exit
   net/core/sock.c:2290:6: sparse: sparse: context imbalance in 'sk_free_unlock_clone' - unexpected unlock
   net/core/sock.c:3892:13: sparse: sparse: context imbalance in 'proto_seq_start' - wrong count at exit
   net/core/sock.c:3904:13: sparse: sparse: context imbalance in 'proto_seq_stop' - wrong count at exit
--
>> net/core/scm.c:324:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/scm.c:324:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/scm.c:324:23: sparse:     got int *
   net/core/scm.c:326:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/scm.c:326:31: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/scm.c:326:31: sparse:     got int *
>> net/core/scm.c:328:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   net/core/scm.c:328:31: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   net/core/scm.c:328:31: sparse:     got unsigned long *
--
>> drivers/gpu/drm/drm_crtc.c:787:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_crtc.c:787:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_crtc.c:787:29: sparse:     got unsigned int *
--
>> drivers/gpu/drm/drm_property.c:484:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/drm_property.c:484:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_property.c:484:21: sparse:     got unsigned long long *
--
>> drivers/gpu/drm/drm_connector.c:2606:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_connector.c:2606:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_connector.c:2606:29: sparse:     got unsigned int *
--
>> drivers/gpu/drm/drm_mode_object.c:404:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     got unsigned int *
>> drivers/gpu/drm/drm_mode_object.c:407:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     got unsigned long long *
--
>> drivers/gpu/drm/drm_mode_config.c:114:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_mode_config.c:114:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:114:21: sparse:     got unsigned int *
   drivers/gpu/drm/drm_mode_config.c:133:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_mode_config.c:133:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:133:29: sparse:     got unsigned int *
   drivers/gpu/drm/drm_mode_config.c:144:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_mode_config.c:144:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:144:21: sparse:     got unsigned int *
   drivers/gpu/drm/drm_mode_config.c:161:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_mode_config.c:161:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:161:29: sparse:     got unsigned int *
--
>> drivers/gpu/drm/drm_plane.c:672:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     got unsigned int *
--
>> drivers/gpu/drm/drm_lease.c:614:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     got unsigned int *
   drivers/gpu/drm/drm_lease.c:669:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     got unsigned int *
--
>> drivers/gpu/drm/drm_atomic_uapi.c:345:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:345:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:345:13: sparse:     got signed int *
   drivers/gpu/drm/drm_atomic_uapi.c:447:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:447:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:447:21: sparse:     got signed int *
   drivers/gpu/drm/drm_atomic_uapi.c:1098:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1098:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1098:13: sparse:     got signed int *
   drivers/gpu/drm/drm_atomic_uapi.c:1274:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1274:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1274:21: sparse:     got signed int *
>> drivers/gpu/drm/drm_atomic_uapi.c:1352:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1352:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1352:21: sparse:     got unsigned int *
   drivers/gpu/drm/drm_atomic_uapi.c:1369:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1369:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1369:21: sparse:     got unsigned int *
   drivers/gpu/drm/drm_atomic_uapi.c:1382:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1382:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1382:29: sparse:     got unsigned int *
--
>> fs/btrfs/ioctl.c:464:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/btrfs/ioctl.c:464:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/btrfs/ioctl.c:464:16: sparse:     got int *
   fs/btrfs/ioctl.c:413:6: sparse: sparse: context imbalance in 'btrfs_exclop_start_try_lock' - wrong count at exit
   fs/btrfs/ioctl.c:426:6: sparse: sparse: context imbalance in 'btrfs_exclop_start_unlock' - unexpected unlock
--
>> drivers/hwmon/w83793.c:1370:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/hwmon/w83793.c:1370:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1370:37: sparse:     got char const *
>> drivers/hwmon/w83793.c:1406:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1406:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1406:23: sparse:     got int *
   drivers/hwmon/w83793.c:1410:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1410:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1410:23: sparse:     got int *
   drivers/hwmon/w83793.c:1419:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1419:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1419:23: sparse:     got int *
   drivers/hwmon/w83793.c:1423:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1423:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1423:21: sparse:     got int *
   drivers/hwmon/w83793.c:1429:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1429:31: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1429:31: sparse:     got int *
   drivers/hwmon/w83793.c:1433:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1433:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1433:21: sparse:     got int *
--
>> kernel/time/time.c:67:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:67:21: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:67:21: sparse:     got long *
   kernel/time/time.c:86:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:86:13: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:86:13: sparse:     got long *
>> kernel/time/time.c:112:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   kernel/time/time.c:112:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   kernel/time/time.c:112:21: sparse:     got signed int *
   kernel/time/time.c:124:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   kernel/time/time.c:124:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   kernel/time/time.c:124:13: sparse:     got signed int *
   kernel/time/time.c:147:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:147:21: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:147:21: sparse:     got long *
   kernel/time/time.c:148:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:148:21: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:148:21: sparse:     got long *
   kernel/time/time.c:206:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:206:21: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:206:21: sparse:     got long *
   kernel/time/time.c:207:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:207:21: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:207:21: sparse:     got long *
--
>> sound/pci/es1938.c:840:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   sound/pci/es1938.c:840:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   sound/pci/es1938.c:840:21: sparse:     got unsigned char *
--
>> sound/synth/emux/emux_hwdep.c:86:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/synth/emux/emux_hwdep.c:86:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/synth/emux/emux_hwdep.c:86:24: sparse:     got unsigned int *
   sound/synth/emux/emux_hwdep.c:98:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/synth/emux/emux_hwdep.c:98:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/synth/emux/emux_hwdep.c:98:32: sparse:     got unsigned int *
--
>> kernel/futex/syscalls.c:75:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/syscalls.c:75:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:75:13: sparse:     got unsigned long *
>> kernel/futex/syscalls.c:77:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct robust_list_head [noderef] __user *[noderef] __user *__ptr_clean @@     got struct robust_list_head [noderef] __user ** @@
   kernel/futex/syscalls.c:77:16: sparse:     expected struct robust_list_head [noderef] __user *[noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:77:16: sparse:     got struct robust_list_head [noderef] __user **
--
>> kernel/futex/requeue.c:458:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/requeue.c:458:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/requeue.c:458:31: sparse:     got unsigned int *
   kernel/futex/requeue.c:455:41: sparse: sparse: context imbalance in 'futex_requeue' - different lock contexts for basic block
--
>> kernel/futex/pi.c:1112:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/pi.c:1112:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/pi.c:1112:13: sparse:     got unsigned int *
   kernel/futex/pi.c:675:9: sparse: sparse: context imbalance in 'wake_futex_pi' - unexpected unlock
   kernel/futex/pi.c:803:9: sparse: sparse: context imbalance in '__fixup_pi_state_owner' - unexpected unlock
   kernel/futex/pi.c:1068:9: sparse: sparse: context imbalance in 'futex_lock_pi' - unexpected unlock
   kernel/futex/pi.c:1100:5: sparse: sparse: context imbalance in 'futex_unlock_pi' - different lock contexts for basic block
--
>> kernel/futex/core.c:648:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:648:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:648:13: sparse:     got unsigned int *
>> kernel/futex/core.c:783:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/futex/core.c:783:13: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/futex/core.c:783:13: sparse:     got long *
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
--
>> kernel/futex/waitwake.c:473:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/waitwake.c:473:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/waitwake.c:473:29: sparse:     got unsigned int *
   kernel/futex/waitwake.c:614:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/waitwake.c:614:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/waitwake.c:614:23: sparse:     got unsigned int *
   kernel/futex/waitwake.c:262:33: sparse: sparse: context imbalance in 'futex_wake_op' - different lock contexts for basic block
   kernel/futex/waitwake.c:328:6: sparse: sparse: context imbalance in 'futex_wait_queue' - unexpected unlock
   kernel/futex/waitwake.c:449:36: sparse: sparse: context imbalance in 'futex_wait_multiple_setup' - unexpected unlock
--
>> drivers/input/mousedev.c:683:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/input/mousedev.c:683:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/input/mousedev.c:683:21: sparse:     got char const *
--
>> drivers/input/joydev.c:530:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/input/joydev.c:530:24: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/input/joydev.c:530:24: sparse:     got signed int *
   drivers/input/joydev.c:533:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/input/joydev.c:533:24: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/input/joydev.c:533:24: sparse:     got signed int *
>> drivers/input/joydev.c:536:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/input/joydev.c:536:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/input/joydev.c:536:24: sparse:     got unsigned int *
>> drivers/input/joydev.c:539:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/input/joydev.c:539:24: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/input/joydev.c:539:24: sparse:     got unsigned char *
   drivers/input/joydev.c:542:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/input/joydev.c:542:24: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/input/joydev.c:542:24: sparse:     got unsigned char *
>> drivers/input/joydev.c:682:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   drivers/input/joydev.c:682:26: sparse:     expected long [noderef] __user *__ptr_clean
   drivers/input/joydev.c:682:26: sparse:     got long *
   drivers/input/joydev.c:687:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   drivers/input/joydev.c:687:26: sparse:     expected long [noderef] __user *__ptr_clean
   drivers/input/joydev.c:687:26: sparse:     got long *
--
>> drivers/input/evdev.c:819:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:819:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:819:13: sparse:     got int *
   drivers/input/evdev.c:854:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:854:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:854:13: sparse:     got int *
   drivers/input/evdev.c:928:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:928:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:928:13: sparse:     got int *
   drivers/input/evdev.c:936:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:936:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:936:21: sparse:     got int *
>> drivers/input/evdev.c:1017:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/input/evdev.c:1017:37: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1017:37: sparse:     got unsigned char *
   drivers/input/evdev.c:1047:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1047:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1047:24: sparse:     got int *
   drivers/input/evdev.c:1057:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1057:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1057:21: sparse:     got int *
   drivers/input/evdev.c:1059:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1059:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1059:21: sparse:     got int *
   drivers/input/evdev.c:1066:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1066:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1066:21: sparse:     got int *
   drivers/input/evdev.c:1068:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1068:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1068:21: sparse:     got int *
   drivers/input/evdev.c:1082:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1082:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1082:21: sparse:     got int *
>> drivers/input/evdev.c:1187:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed short [noderef] __user *__ptr_clean @@     got signed short * @@
   drivers/input/evdev.c:1187:21: sparse:     expected signed short [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1187:21: sparse:     got signed short *
--
   kernel/trace/trace.c:406:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:406:28: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:406:28: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:420:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:420:33: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:420:33: sparse:     got struct trace_export [noderef] __rcu **
>> kernel/trace/trace.c:1604:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   kernel/trace/trace.c:1604:15: sparse:     expected char const [noderef] __user *__ptr_clean
   kernel/trace/trace.c:1604:15: sparse:     got char const *
   kernel/trace/trace.c:1618:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   kernel/trace/trace.c:1618:31: sparse:     expected char const [noderef] __user *__ptr_clean
   kernel/trace/trace.c:1618:31: sparse:     got char const *
   kernel/trace/trace.c:1643:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   kernel/trace/trace.c:1643:23: sparse:     expected char const [noderef] __user *__ptr_clean
   kernel/trace/trace.c:1643:23: sparse:     got char const *
   kernel/trace/trace.c:2864:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace.c:2864:38: sparse:     expected struct event_filter *filter
   kernel/trace/trace.c:2864:38: sparse:     got struct event_filter [noderef] __rcu *filter
   kernel/trace/trace.c:360:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:360:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:360:9: sparse:    struct trace_export *
   kernel/trace/trace.c:375:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:375:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:375:9: sparse:    struct trace_export *
--
>> fs/reiserfs/ioctl.c:96:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/reiserfs/ioctl.c:96:23: sparse:     expected int [noderef] __user *__ptr_clean
   fs/reiserfs/ioctl.c:96:23: sparse:     got int *
   fs/reiserfs/ioctl.c:106:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/reiserfs/ioctl.c:106:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/reiserfs/ioctl.c:106:21: sparse:     got int *
--
>> kernel/bpf/btf.c:6804:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   kernel/bpf/btf.c:6804:29: sparse:     expected char [noderef] __user *__ptr_clean
   kernel/bpf/btf.c:6804:29: sparse:     got char *
>> kernel/bpf/btf.c:6812:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/btf.c:6812:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/btf.c:6812:13: sparse:     got unsigned int *
--
>> kernel/bpf/hashtab.c:1650:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/hashtab.c:1650:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/hashtab.c:1650:13: sparse:     got unsigned int *
   kernel/bpf/hashtab.c:1828:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/hashtab.c:1828:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/hashtab.c:1828:13: sparse:     got unsigned int *
   kernel/bpf/hashtab.c:783:27: sparse: sparse: context imbalance in 'htab_lru_map_delete_node' - unexpected unlock
   kernel/bpf/hashtab.c:1130:27: sparse: sparse: context imbalance in 'htab_map_update_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1197:27: sparse: sparse: context imbalance in 'htab_lru_map_update_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1258:27: sparse: sparse: context imbalance in '__htab_percpu_map_update_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1323:27: sparse: sparse: context imbalance in '__htab_lru_percpu_map_update_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1375:27: sparse: sparse: context imbalance in 'htab_map_delete_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1409:27: sparse: sparse: context imbalance in 'htab_lru_map_delete_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1575:27: sparse: sparse: context imbalance in '__htab_map_lookup_and_delete_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1708:17: sparse: sparse: context imbalance in '__htab_map_lookup_and_delete_batch' - unexpected unlock
   kernel/bpf/hashtab.c:1941:17: sparse: sparse: context imbalance in 'bpf_hash_map_seq_find_next' - unexpected unlock
   kernel/bpf/hashtab.c: note: in included file (through include/linux/workqueue.h, include/linux/bpf.h):
   include/linux/rcupdate.h:737:9: sparse: sparse: context imbalance in 'bpf_hash_map_seq_stop' - unexpected unlock
--
   kernel/bpf/syscall.c:601:25: sparse: sparse: Using plain integer as NULL pointer
>> kernel/bpf/syscall.c:1701:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/syscall.c:1701:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:1701:13: sparse:     got unsigned int *
>> kernel/bpf/syscall.c:3179:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   kernel/bpf/syscall.c:3179:21: sparse:     expected char [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:3179:21: sparse:     got char *
   kernel/bpf/syscall.c:3649:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/syscall.c:3649:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:3649:23: sparse:     got unsigned int *
   kernel/bpf/syscall.c:3925:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/syscall.c:3925:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:3925:29: sparse:     got unsigned int *
>> kernel/bpf/syscall.c:4048:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/bpf/syscall.c:4048:45: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4048:45: sparse:     got unsigned long long *
   kernel/bpf/syscall.c:4054:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/bpf/syscall.c:4054:37: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4054:37: sparse:     got unsigned long long *
   kernel/bpf/syscall.c:4076:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/syscall.c:4076:45: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4076:45: sparse:     got unsigned int *
   kernel/bpf/syscall.c:4081:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/syscall.c:4081:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4081:37: sparse:     got unsigned int *
   kernel/bpf/syscall.c:4134:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/bpf/syscall.c:4134:37: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4134:37: sparse:     got unsigned long long *
   kernel/bpf/syscall.c:4166:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/syscall.c:4166:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4166:13: sparse:     got unsigned int *
   kernel/bpf/syscall.c:4211:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/syscall.c:4211:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4211:13: sparse:     got unsigned int *
   kernel/bpf/syscall.c:4263:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/syscall.c:4263:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4263:13: sparse:     got unsigned int *
   kernel/bpf/syscall.c:4340:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/syscall.c:4340:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4340:13: sparse:     got unsigned int *
   kernel/bpf/syscall.c:4348:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   kernel/bpf/syscall.c:4348:29: sparse:     expected char [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4348:29: sparse:     got char *
   kernel/bpf/syscall.c:4363:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   kernel/bpf/syscall.c:4363:29: sparse:     expected char [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4363:29: sparse:     got char *
   kernel/bpf/syscall.c:4368:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/syscall.c:4368:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4368:13: sparse:     got unsigned int *
   kernel/bpf/syscall.c:4369:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/bpf/syscall.c:4369:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4369:13: sparse:     got unsigned int *
   kernel/bpf/syscall.c:4370:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/bpf/syscall.c:4370:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4370:13: sparse:     got unsigned long long *
   kernel/bpf/syscall.c:4371:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/bpf/syscall.c:4371:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/bpf/syscall.c:4371:13: sparse:     got unsigned long long *
--
>> kernel/bpf/verifier.c:326:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   kernel/bpf/verifier.c:326:13: sparse:     expected char [noderef] __user *__ptr_clean
   kernel/bpf/verifier.c:326:13: sparse:     got char *
   kernel/bpf/verifier.c:14357:38: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
--
>> kernel/bpf/bpf_iter.c:476:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   kernel/bpf/bpf_iter.c:476:29: sparse:     expected char [noderef] __user *__ptr_clean
   kernel/bpf/bpf_iter.c:476:29: sparse:     got char *
--
   kernel/events/core.c:1402:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1402:15: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1402:15: sparse:    struct perf_event_context *
   kernel/events/core.c:1415:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1415:28: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1415:28: sparse:    struct perf_event_context *
   kernel/events/core.c:3402:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3402:18: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3402:18: sparse:    struct perf_event_context *
   kernel/events/core.c:3403:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3403:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3403:23: sparse:    struct perf_event_context *
   kernel/events/core.c:3451:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3451:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3451:25: sparse:    struct perf_event_context *
   kernel/events/core.c:3452:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3452:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3452:25: sparse:    struct perf_event_context *
   kernel/events/core.c:4685:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:4685:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:4685:25: sparse:    struct perf_event_context *
   kernel/events/core.c:5956:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5956:9: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5956:9: sparse:    struct perf_buffer *
   kernel/events/core.c:5428:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] events @@     got int @@
>> kernel/events/core.c:11730:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/events/core.c:11842:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/events/core.c:5672:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5672:22: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5672:22: sparse:    struct perf_buffer *
   kernel/events/core.c:5796:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5796:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5796:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5829:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5829:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5829:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5886:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5886:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5886:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5977:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5977:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5977:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5993:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5993:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5993:14: sparse:    struct perf_buffer *
   kernel/events/core.c:7642:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7642:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:7642:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7694:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7694:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:7694:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7733:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7733:13: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:7733:13: sparse:    struct perf_buffer *
   kernel/events/core.c:7838:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7838:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7838:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:7840:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7840:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7840:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:8541:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8541:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:8541:23: sparse:    struct perf_event_context *
   kernel/events/core.c:9535:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9535:9: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9535:9: sparse:    struct swevent_hlist *
   kernel/events/core.c:9574:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9574:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9574:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9755:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9755:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:9755:23: sparse:    struct perf_event_context *
   kernel/events/core.c:10938:1: sparse: sparse: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
   kernel/events/core.c:12773:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12773:9: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12773:9: sparse:    struct perf_event_context *
   kernel/events/core.c:12883:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12883:17: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12883:17: sparse:    struct perf_event_context *
   kernel/events/core.c:13313:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:13313:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:13313:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:167:9: sparse: sparse: context imbalance in 'perf_ctx_lock' - wrong count at exit
   kernel/events/core.c:175:17: sparse: sparse: context imbalance in 'perf_ctx_unlock' - unexpected unlock
   kernel/events/core.c: note: in included file (through include/linux/rcupdate.h, include/linux/rculist.h, include/linux/dcache.h, ...):
   include/linux/rcutiny.h:114:44: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
   kernel/events/core.c:1449:17: sparse: sparse: context imbalance in 'perf_pin_task_context' - unexpected unlock
   kernel/events/core.c:2775:9: sparse: sparse: context imbalance in '__perf_install_in_context' - wrong count at exit
   kernel/events/core.c:4657:17: sparse: sparse: context imbalance in 'find_get_context' - unexpected unlock
   kernel/events/core.c: note: in included file:
   kernel/events/internal.h:209:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *buf @@
   kernel/events/core.c:9384:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9384:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9384:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9404:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9404:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9404:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9524:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9524:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9524:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist *
--
>> net/ethtool/ioctl.c:107:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ethtool/ioctl.c:107:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ethtool/ioctl.c:107:13: sparse:     got unsigned int *
--
>> sound/pci/asihpi/hpioctl.c:118:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   sound/pci/asihpi/hpioctl.c:118:13: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   sound/pci/asihpi/hpioctl.c:118:13: sparse:     got void [noderef] __user **
   sound/pci/asihpi/hpioctl.c:119:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   sound/pci/asihpi/hpioctl.c:119:20: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   sound/pci/asihpi/hpioctl.c:119:20: sparse:     got void [noderef] __user **
>> sound/pci/asihpi/hpioctl.c:125:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   sound/pci/asihpi/hpioctl.c:125:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   sound/pci/asihpi/hpioctl.c:125:13: sparse:     got unsigned short *
   sound/pci/asihpi/hpioctl.c:144:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   sound/pci/asihpi/hpioctl.c:144:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   sound/pci/asihpi/hpioctl.c:144:13: sparse:     got unsigned short *
--
>> fs/ext4/ioctl.c:803:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:803:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:803:13: sparse:     got unsigned int *
>> fs/ext4/ioctl.c:1226:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext4/ioctl.c:1226:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1226:24: sparse:     got int *
   fs/ext4/ioctl.c:1246:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext4/ioctl.c:1246:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1246:21: sparse:     got int *
   fs/ext4/ioctl.c:1279:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:1279:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1279:21: sparse:     got unsigned int *
   fs/ext4/ioctl.c:1560:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:1560:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1560:24: sparse:     got unsigned int *
--
>> fs/ext2/ioctl.c:65:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext2/ioctl.c:65:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext2/ioctl.c:65:24: sparse:     got int *
   fs/ext2/ioctl.c:74:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext2/ioctl.c:74:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext2/ioctl.c:74:21: sparse:     got int *
   fs/ext2/ioctl.c:94:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext2/ioctl.c:94:32: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext2/ioctl.c:94:32: sparse:     got int *
   fs/ext2/ioctl.c:105:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext2/ioctl.c:105:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext2/ioctl.c:105:21: sparse:     got int *
--
>> drivers/media/rc/lirc_dev.c:365:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/rc/lirc_dev.c:365:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/rc/lirc_dev.c:365:23: sparse:     got unsigned int *
   drivers/media/rc/lirc_dev.c:569:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/rc/lirc_dev.c:569:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/rc/lirc_dev.c:569:23: sparse:     got unsigned int *
--
>> drivers/misc/xilinx_sdfec.c:735:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int enum xsdfec_order [noderef] __user *__ptr_clean @@     got unsigned int enum xsdfec_order * @@
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     expected unsigned int enum xsdfec_order [noderef] __user *__ptr_clean
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     got unsigned int enum xsdfec_order *
>> drivers/misc/xilinx_sdfec.c:760:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected bool [noderef] __user *__ptr_clean @@     got bool * @@
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     expected bool [noderef] __user *__ptr_clean
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     got bool *
   drivers/misc/xilinx_sdfec.c:787:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected bool [noderef] __user *__ptr_clean @@     got bool * @@
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     expected bool [noderef] __user *__ptr_clean
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     got bool *
--
>> drivers/mtd/mtdchar.c:409:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:409:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:409:13: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:757:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:757:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:757:21: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:765:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:765:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:765:21: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:766:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:766:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:766:24: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:767:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:767:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:767:24: sparse:     got unsigned int *
--
>> net/netlink/af_netlink.c:1730:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1730:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1730:13: sparse:     got int *
   net/netlink/af_netlink.c:1741:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1741:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1741:21: sparse:     got int *
>> net/netlink/af_netlink.c:1742:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1742:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1742:21: sparse:     got char *
   net/netlink/af_netlink.c:1751:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1751:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1751:21: sparse:     got int *
   net/netlink/af_netlink.c:1752:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1752:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1752:21: sparse:     got char *
   net/netlink/af_netlink.c:1761:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1761:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1761:21: sparse:     got int *
   net/netlink/af_netlink.c:1762:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1762:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1762:21: sparse:     got char *
>> net/netlink/af_netlink.c:1777:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/netlink/af_netlink.c:1777:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1777:29: sparse:     got unsigned int *
   net/netlink/af_netlink.c:1783:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1783:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1783:21: sparse:     got int *
   net/netlink/af_netlink.c:1793:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1793:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1793:21: sparse:     got int *
   net/netlink/af_netlink.c:1794:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1794:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1794:21: sparse:     got char *
   net/netlink/af_netlink.c:1803:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1803:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1803:21: sparse:     got int *
   net/netlink/af_netlink.c:1803:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1803:46: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1803:46: sparse:     got char *
   net/netlink/af_netlink.c:1812:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1812:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1812:21: sparse:     got int *
   net/netlink/af_netlink.c:1812:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1812:46: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1812:46: sparse:     got char *
   net/netlink/af_netlink.c:2568:13: sparse: sparse: context imbalance in 'netlink_walk_start' - wrong count at exit
   net/netlink/af_netlink.c:2574:13: sparse: sparse: context imbalance in 'netlink_walk_stop' - unexpected unlock
   net/netlink/af_netlink.c:2624:9: sparse: sparse: context imbalance in 'netlink_seq_start' - wrong count at exit
--
>> drivers/nvme/host/ioctl.c:282:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/nvme/host/ioctl.c:282:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/nvme/host/ioctl.c:282:21: sparse:     got unsigned int *
>> drivers/nvme/host/ioctl.c:328:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/nvme/host/ioctl.c:328:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/nvme/host/ioctl.c:328:21: sparse:     got unsigned long long *
--
>> net/ipv4/ip_sockglue.c:1485:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1485:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1485:13: sparse:     got int *
   net/ipv4/ip_sockglue.c:1517:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1517:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1517:13: sparse:     got int *
>> net/ipv4/ip_sockglue.c:1518:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/ip_sockglue.c:1518:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1518:13: sparse:     got unsigned int *
   net/ipv4/ip_sockglue.c:1519:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/ip_sockglue.c:1519:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1519:13: sparse:     got unsigned int *
   net/ipv4/ip_sockglue.c:1538:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1538:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1538:13: sparse:     got int *
   net/ipv4/ip_sockglue.c:1564:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1564:32: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1564:32: sparse:     got int *
   net/ipv4/ip_sockglue.c:1569:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1569:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1569:21: sparse:     got int *
   net/ipv4/ip_sockglue.c:1662:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1662:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1662:21: sparse:     got int *
   net/ipv4/ip_sockglue.c:1725:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1725:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1725:24: sparse:     got int *
   net/ipv4/ip_sockglue.c:1745:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1745:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1745:21: sparse:     got int *
   net/ipv4/ip_sockglue.c:1751:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1751:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1751:21: sparse:     got int *
--
>> net/ipv4/tcp.c:639:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:639:16: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:639:16: sparse:     got int *
   net/ipv4/tcp.c:4054:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4054:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4054:13: sparse:     got int *
   net/ipv4/tcp.c:4104:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4104:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4104:21: sparse:     got int *
   net/ipv4/tcp.c:4110:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4110:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4110:21: sparse:     got int *
   net/ipv4/tcp.c:4122:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4122:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4122:21: sparse:     got int *
   net/ipv4/tcp.c:4130:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4130:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4130:21: sparse:     got int *
   net/ipv4/tcp.c:4141:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4141:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4141:21: sparse:     got int *
   net/ipv4/tcp.c:4144:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4144:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4144:21: sparse:     got int *
   net/ipv4/tcp.c:4151:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4151:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4151:21: sparse:     got int *
   net/ipv4/tcp.c:4155:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4155:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4155:29: sparse:     got int *
   net/ipv4/tcp.c:4159:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4159:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4159:21: sparse:     got int *
   net/ipv4/tcp.c:4169:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4169:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4169:21: sparse:     got int *
   net/ipv4/tcp.c:4175:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4175:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4175:21: sparse:     got int *
   net/ipv4/tcp.c:4203:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4203:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4203:21: sparse:     got int *
   net/ipv4/tcp.c:4264:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4264:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4264:21: sparse:     got int *
   net/ipv4/tcp.c:4270:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4270:37: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4270:37: sparse:     got int *
   net/ipv4/tcp.c:4279:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4279:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4279:29: sparse:     got int *
   net/ipv4/tcp.c:4292:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4292:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4292:29: sparse:     got int *
   net/ipv4/tcp.c:4303:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4303:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4303:21: sparse:     got int *
   net/ipv4/tcp.c:4314:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4314:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4314:29: sparse:     got int *
   net/ipv4/tcp.c:4366:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4366:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4366:13: sparse:     got int *
--
>> net/ipv4/raw.c:802:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/raw.c:802:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/raw.c:802:13: sparse:     got int *
   net/ipv4/raw.c:810:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/raw.c:810:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/raw.c:810:13: sparse:     got int *
   net/ipv4/raw.c:863:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/raw.c:863:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/raw.c:863:24: sparse:     got int *
   net/ipv4/raw.c:874:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/raw.c:874:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/raw.c:874:24: sparse:     got int *
--
>> net/ipv4/udp.c:1712:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/udp.c:1712:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/udp.c:1712:24: sparse:     got int *
   net/ipv4/udp.c:1719:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/udp.c:1719:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/udp.c:1719:24: sparse:     got int *
   net/ipv4/udp.c:2807:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/udp.c:2807:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/udp.c:2807:13: sparse:     got int *
   net/ipv4/udp.c:2854:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/udp.c:2854:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/udp.c:2854:13: sparse:     got int *
   net/ipv4/udp.c:1478:28: sparse: sparse: context imbalance in 'udp_rmem_release' - unexpected unlock
   net/ipv4/udp.c:1510:19: sparse: sparse: context imbalance in 'busylock_acquire' - wrong count at exit
   net/ipv4/udp.c:1522:28: sparse: sparse: context imbalance in 'busylock_release' - unexpected unlock
   net/ipv4/udp.c:2995:9: sparse: sparse: context imbalance in 'udp_get_first' - wrong count at exit
   net/ipv4/udp.c:3017:39: sparse: sparse: context imbalance in 'udp_get_next' - unexpected unlock
   net/ipv4/udp.c:3067:31: sparse: sparse: context imbalance in 'udp_seq_stop' - unexpected unlock
--
   net/ipv4/igmp.c: note: in included file (through include/linux/igmp.h):
   include/uapi/linux/igmp.h:60:32: sparse: sparse: array of flexible structures
>> net/ipv4/igmp.c:2578:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/igmp.c:2578:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/igmp.c:2578:13: sparse:     got int *
   net/ipv4/igmp.c:2929:31: sparse: sparse: context imbalance in 'igmp_mcf_get_next' - unexpected unlock
   net/ipv4/igmp.c:2957:9: sparse: sparse: context imbalance in 'igmp_mcf_get_idx' - wrong count at exit
   net/ipv4/igmp.c:2974:9: sparse: sparse: context imbalance in 'igmp_mcf_seq_next' - wrong count at exit
   net/ipv4/igmp.c:2986:9: sparse: sparse: context imbalance in 'igmp_mcf_seq_stop' - unexpected unlock
--
>> drivers/tty/tty_ioctl.c:803:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_ioctl.c:803:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_ioctl.c:803:23: sparse:     got int *
>> drivers/tty/tty_ioctl.c:807:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/tty_ioctl.c:807:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/tty_ioctl.c:807:21: sparse:     got unsigned int *
   drivers/tty/tty_ioctl.c: note: in included file (through arch/x86/include/generated/uapi/asm/termios.h, include/uapi/linux/termios.h):
>> include/asm-generic/termios.h:25:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short const [noderef] __user *__ptr_clean @@     got unsigned short const * @@
   include/asm-generic/termios.h:25:13: sparse:     expected unsigned short const [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:25:13: sparse:     got unsigned short const *
   include/asm-generic/termios.h:29:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short const [noderef] __user *__ptr_clean @@     got unsigned short const * @@
   include/asm-generic/termios.h:29:13: sparse:     expected unsigned short const [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:29:13: sparse:     got unsigned short const *
   include/asm-generic/termios.h:33:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short const [noderef] __user *__ptr_clean @@     got unsigned short const * @@
   include/asm-generic/termios.h:33:13: sparse:     expected unsigned short const [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:33:13: sparse:     got unsigned short const *
   include/asm-generic/termios.h:37:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short const [noderef] __user *__ptr_clean @@     got unsigned short const * @@
   include/asm-generic/termios.h:37:13: sparse:     expected unsigned short const [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:37:13: sparse:     got unsigned short const *
>> include/asm-generic/termios.h:41:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char const [noderef] __user *__ptr_clean @@     got unsigned char const * @@
   include/asm-generic/termios.h:41:13: sparse:     expected unsigned char const [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:41:13: sparse:     got unsigned char const *
>> include/asm-generic/termios.h:59:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   include/asm-generic/termios.h:59:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:59:13: sparse:     got unsigned short *
   include/asm-generic/termios.h:60:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   include/asm-generic/termios.h:60:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:60:13: sparse:     got unsigned short *
   include/asm-generic/termios.h:61:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   include/asm-generic/termios.h:61:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:61:13: sparse:     got unsigned short *
   include/asm-generic/termios.h:62:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   include/asm-generic/termios.h:62:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:62:13: sparse:     got unsigned short *
>> include/asm-generic/termios.h:63:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   include/asm-generic/termios.h:63:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:63:13: sparse:     got unsigned char *
--
>> drivers/tty/n_tty.c:2473:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/n_tty.c:2473:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/n_tty.c:2473:24: sparse:     got int *
>> drivers/tty/n_tty.c:2481:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/n_tty.c:2481:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/n_tty.c:2481:24: sparse:     got unsigned int *
--
>> drivers/tty/tty_io.c:2285:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/tty_io.c:2285:13: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2285:13: sparse:     got char *
>> drivers/tty/tty_io.c:2430:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_io.c:2430:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2430:13: sparse:     got int *
   drivers/tty/tty_io.c:2456:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_io.c:2456:15: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2456:15: sparse:     got int *
   drivers/tty/tty_io.c:2517:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_io.c:2517:34: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2517:34: sparse:     got int *
>> drivers/tty/tty_io.c:2542:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/tty_io.c:2542:18: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2542:18: sparse:     got unsigned int *
   drivers/tty/tty_io.c:2709:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_io.c:2709:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2709:24: sparse:     got int *
   drivers/tty/tty_io.c:2724:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/tty_io.c:2724:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2724:24: sparse:     got unsigned int *
--
   drivers/tty/tty_jobctrl.c:80:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:80:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:80:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:83:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:83:34: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:83:34: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:124:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:124:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:124:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:126:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:126:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:126:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:135:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:135:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:135:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:156:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:156:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:156:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:165:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:165:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:167:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:167:40: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:167:40: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:205:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:205:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:205:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:215:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:215:51: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:215:51: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:227:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:227:43: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:227:43: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:291:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:291:39: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:291:39: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:294:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:294:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:294:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:303:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:303:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:303:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:307:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:307:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:307:33: sparse:     got struct spinlock [noderef] __rcu *
>> drivers/tty/tty_jobctrl.c:472:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_jobctrl.c:472:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_jobctrl.c:472:16: sparse:     got int *
   drivers/tty/tty_jobctrl.c:499:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_jobctrl.c:499:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_jobctrl.c:499:13: sparse:     got int *
   drivers/tty/tty_jobctrl.c:556:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_jobctrl.c:556:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_jobctrl.c:556:16: sparse:     got int *
   drivers/tty/tty_jobctrl.c:19:41: sparse: sparse: dereference of noderef expression
--
>> drivers/tty/pty.c:141:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/pty.c:141:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/pty.c:141:13: sparse:     got int *
   drivers/tty/pty.c:154:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/pty.c:154:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/pty.c:154:16: sparse:     got int *
   drivers/tty/pty.c:162:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/pty.c:162:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/pty.c:162:13: sparse:     got int *
   drivers/tty/pty.c:184:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/pty.c:184:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/pty.c:184:16: sparse:     got int *
>> drivers/tty/pty.c:655:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/pty.c:655:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/pty.c:655:24: sparse:     got unsigned int *
--
>> drivers/tty/sysrq.c:1161:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/tty/sysrq.c:1161:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/tty/sysrq.c:1161:21: sparse:     got char const *
   drivers/tty/sysrq.c:150:13: sparse: sparse: context imbalance in 'sysrq_handle_crash' - unexpected unlock
--
>> drivers/tty/serial/serial_core.c:1061:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/serial/serial_core.c:1061:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/serial/serial_core.c:1061:16: sparse:     got unsigned int *
   drivers/tty/serial/serial_core.c:152:9: sparse: sparse: context imbalance in 'uart_start' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:224:17: sparse: sparse: context imbalance in 'uart_port_startup' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:333:9: sparse: sparse: context imbalance in 'uart_shutdown' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:560:9: sparse: sparse: context imbalance in 'uart_put_char' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:608:9: sparse: sparse: context imbalance in 'uart_write' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:621:9: sparse: sparse: context imbalance in 'uart_write_room' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:634:9: sparse: sparse: context imbalance in 'uart_chars_in_buffer' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:661:9: sparse: sparse: context imbalance in 'uart_flush_buffer' - different lock contexts for basic block
--
>> fs/cifs/ioctl.c:163:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/cifs/ioctl.c:163:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/cifs/ioctl.c:163:13: sparse:     got unsigned int *
>> fs/cifs/ioctl.c:355:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/cifs/ioctl.c:355:38: sparse:     expected int [noderef] __user *__ptr_clean
   fs/cifs/ioctl.c:355:38: sparse:     got int *
   fs/cifs/ioctl.c:365:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/cifs/ioctl.c:365:29: sparse:     expected int [noderef] __user *__ptr_clean
   fs/cifs/ioctl.c:365:29: sparse:     got int *
--
>> fs/cifs/smb2ops.c:1961:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/cifs/smb2ops.c:1961:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/cifs/smb2ops.c:1961:13: sparse:     got unsigned int *
--
>> fs/cifs/cifs_debug.c:779:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   fs/cifs/cifs_debug.c:779:14: sparse:     expected char const [noderef] __user *__ptr_clean
   fs/cifs/cifs_debug.c:779:14: sparse:     got char const *
--
>> sound/pci/lola/lola_mixer.c:561:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/lola/lola_mixer.c:561:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/lola/lola_mixer.c:561:13: sparse:     got unsigned int *
   sound/pci/lola/lola_mixer.c:563:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/lola/lola_mixer.c:563:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/lola/lola_mixer.c:563:13: sparse:     got unsigned int *
   sound/pci/lola/lola_mixer.c:565:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/lola/lola_mixer.c:565:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/lola/lola_mixer.c:565:13: sparse:     got unsigned int *
   sound/pci/lola/lola_mixer.c:567:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/pci/lola/lola_mixer.c:567:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/pci/lola/lola_mixer.c:567:13: sparse:     got unsigned int *
--
>> drivers/misc/genwqe/card_dev.c:1073:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int enum genwqe_card_state [noderef] __user *__ptr_clean @@     got unsigned int enum genwqe_card_state * @@
   drivers/misc/genwqe/card_dev.c:1073:17: sparse:     expected unsigned int enum genwqe_card_state [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1073:17: sparse:     got unsigned int enum genwqe_card_state *
>> drivers/misc/genwqe/card_dev.c:1080:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1080:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1080:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1087:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1087:17: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1087:17: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1100:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1100:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1100:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1106:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1106:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1106:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1116:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1116:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1116:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1123:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1123:17: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1123:17: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1136:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1136:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1136:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1142:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1142:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1142:21: sparse:     got unsigned long long *
--
>> drivers/platform/x86/wmi.c:903:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/platform/x86/wmi.c:903:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/platform/x86/wmi.c:903:13: sparse:     got unsigned long long *
--
>> drivers/vfio/vfio_main.c:1254:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/vfio/vfio_main.c:1254:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/vfio/vfio_main.c:1254:21: sparse:     got int *
--
>> drivers/pps/pps.c:170:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/pps/pps.c:170:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/pps/pps.c:170:23: sparse:     got int *

vim +279 arch/x86/kernel/process.c

389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  269  
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  270  int get_tsc_mode(unsigned long adr)
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  271  {
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  272  	unsigned int val;
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  273  
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  274  	if (test_thread_flag(TIF_NOTSC))
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  275  		val = PR_TSC_SIGSEGV;
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  276  	else
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  277  		val = PR_TSC_ENABLE;
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  278  
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27 @279  	return put_user(val, (unsigned int __user *)adr);
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  280  }
389d1fb11e5f2a Jeremy Fitzhardinge 2009-02-27  281  

:::::: The code at line 279 was first introduced by commit
:::::: 389d1fb11e5f2a16b5e34c547756f0c4dec641f7 x86: unify chunks of kernel/process*.c

:::::: TO: Jeremy Fitzhardinge <jeremy@goop.org>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--935iG+o1P1Q4yHPC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.0.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-5) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23890
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23890
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_UAPI_HEADER_TEST=y
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
# CONFIG_GART_IOMMU is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

# CONFIG_X86_16BIT is not set
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
# CONFIG_MTRR is not set
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=m
# CONFIG_ACPI_TINY_POWER_BUTTON is not set
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_TAD=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
# CONFIG_ACPI_HED is not set
CONFIG_ACPI_CUSTOM_METHOD=m
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_CONFIGFS=y
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
CONFIG_CPU_IDLE_GOV_TEO=y
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=m
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_XEN=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32_ABI is not set
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
CONFIG_BFQ_CGROUP_DEBUG=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
# CONFIG_FAILOVER is not set
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
# CONFIG_PCIEAER is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=y
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_EP=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCIE_DW_PLAT_EP=y
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
# CONFIG_PCI_EPF_TEST is not set
# CONFIG_PCI_EPF_NTB is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=y
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
# CONFIG_GOOGLE_MEMCONSOLE_COREBOOT is not set
# CONFIG_GOOGLE_VPD is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=m
# CONFIG_GNSS_MTK_SERIAL is not set
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=m
# CONFIG_NFTL is not set
CONFIG_INFTL=m
CONFIG_RFD_FTL=m
CONFIG_SSFDC=m
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=m
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
CONFIG_MTD_SBC_GXX=m
CONFIG_MTD_PCI=m
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
CONFIG_MTD_PMC551_BUGFIX=y
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=m
CONFIG_MTD_ONENAND=m
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
# CONFIG_MTD_ONENAND_GENERIC is not set
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_RAW_NAND=m

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_MXIC=m
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m
# CONFIG_MTD_NAND_ARASAN is not set

#
# Misc
#
CONFIG_MTD_SM_COMMON=m
CONFIG_MTD_NAND_NANDSIM=m
CONFIG_MTD_NAND_RICOH=m
CONFIG_MTD_NAND_DISKONCHIP=m
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_NAND_ECC_SW_BCH=y
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_UBI is not set
CONFIG_MTD_HYPERBUS=m
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_FD_RAWCMD=y
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_XEN_BLKDEV_BACKEND=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_FCLOOP is not set
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=m
CONFIG_IBM_ASM=m
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=m
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=m
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m

#
# Altera FPGA firmware download module (requires I2C)
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=y
# CONFIG_VMWARE_VMCI is not set
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=m
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HABANA_AI=y
# CONFIG_UACCE is not set
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=y
CONFIG_SCSI_3W_SAS=y
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=m
CONFIG_AIC94XX_DEBUG=y
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
CONFIG_SCSI_ADVANSYS=y
# CONFIG_SCSI_ARCMSR is not set
CONFIG_SCSI_ESAS2R=y
# CONFIG_MEGARAID_NEWGEN is not set
CONFIG_MEGARAID_LEGACY=m
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
CONFIG_SCSI_BUSLOGIC=y
# CONFIG_SCSI_FLASHPOINT is not set
# CONFIG_SCSI_MYRB is not set
CONFIG_SCSI_MYRS=m
CONFIG_VMWARE_PVSCSI=y
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_SCSI_SNIC is not set
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
CONFIG_SCSI_ISCI=m
CONFIG_SCSI_IPS=y
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
CONFIG_SCSI_IMM=m
CONFIG_SCSI_IZIP_EPP16=y
CONFIG_SCSI_IZIP_SLOW_CTR=y
# CONFIG_SCSI_STEX is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_MMIO is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
CONFIG_SCSI_QLOGIC_1280=m
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_AM53C974=y
CONFIG_SCSI_WD719X=m
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=y
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=m
# CONFIG_SCSI_DH_ALUA is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
# CONFIG_ATA_ACPI is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=m
# CONFIG_ATA_SFF is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=m
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_BCACHE=m
CONFIG_BCACHE_DEBUG=y
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
# CONFIG_BLK_DEV_DM is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_XEN_NETDEV_BACKEND is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
# CONFIG_INPUT_FF_MEMLESS is not set
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=m
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=m
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_JOYSTICK_AS5011=m
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_QWIIC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
# CONFIG_JOYSTICK_SENSEHAT is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SMB=m
# CONFIG_RMI4_F03 is not set
# CONFIG_RMI4_F11 is not set
# CONFIG_RMI4_F12 is not set
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
CONFIG_SERIAL_SCCNXP=m
CONFIG_SERIAL_SC16IS7XX=m
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_GOLDFISH_TTY=m
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
CONFIG_NULL_TTY=y
# CONFIG_HVC_XEN is not set
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_APPLICOM=y
# CONFIG_MWAVE is not set
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=m
CONFIG_XILLYBUS_CLASS=m
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_PCIE=m
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=m
CONFIG_I2C_ALI1535=m
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=m
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_NVIDIA_GPU=m
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_DESIGNWARE_PCI=m
CONFIG_I2C_EMEV2=m
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
CONFIG_CDNS_I3C_MASTER=m
CONFIG_DW_I3C_MASTER=m
# CONFIG_SVC_I3C_MASTER is not set
# CONFIG_MIPI_I3C_HCI is not set
# CONFIG_SPI is not set
CONFIG_SPMI=m
# CONFIG_SPMI_HISI3670 is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=m
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=y
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=y
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
CONFIG_PINCTRL_SUNRISEPOINT=y
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=y
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_SIOX=m
CONFIG_GPIO_VX855=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=y
CONFIG_GPIO_104_DIO_48E=m
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=m
CONFIG_GPIO_SCH=m
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
CONFIG_GPIO_MAX7300=m
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP873X=m
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TQMX86=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=m
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=m
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=m
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=m
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7414=m
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=m
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_I8K is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=m
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=m
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NCT6683=m
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
CONFIG_SENSORS_INSPUR_IPSPS=m
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
CONFIG_SENSORS_IR38064=m
# CONFIG_SENSORS_IR38064_REGULATOR is not set
CONFIG_SENSORS_IRPS5401=m
CONFIG_SENSORS_ISL68137=m
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=m
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=m
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_XGENE=m

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_PCI is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
CONFIG_MFD_CS47L90=y
CONFIG_MFD_CS47L92=y
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
CONFIG_HTC_PASIC3=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=m
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=m
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MT6360 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_SI476X_CORE=m
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=m
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_TI_LMU is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TQMX86=m
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_RAVE_SP_CORE=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA9210=m
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP8755=m
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77693=m
# CONFIG_REGULATOR_MAX77826 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6315 is not set
CONFIG_REGULATOR_MT6323=m
# CONFIG_REGULATOR_MT6358 is not set
# CONFIG_REGULATOR_MT6359 is not set
CONFIG_REGULATOR_MT6397=m
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=m
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
# CONFIG_REGULATOR_RT4801 is not set
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_SLG51000=m
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
# CONFIG_RC_MAP is not set
CONFIG_RC_DECODERS=y
# CONFIG_IR_IMON_DECODER is not set
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=m

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=m
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
# CONFIG_RADIO_SI470X is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
# CONFIG_V4L_MEM2MEM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
# CONFIG_VIDEO_CADENCE_CSI2TX is not set

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Camera sensor devices
#
# CONFIG_VIDEO_AR0521 is not set
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
CONFIG_VIDEO_MT9M111=m
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
CONFIG_VIDEO_OV9640=m
CONFIG_VIDEO_OV9650=m
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
CONFIG_VIDEO_S5K5BAF=m
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_CCS is not set
CONFIG_VIDEO_ET8EK8=m
# CONFIG_VIDEO_M5MOLS is not set
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=m
CONFIG_VIDEO_AK7375=m
CONFIG_VIDEO_DW9714=m
# CONFIG_VIDEO_DW9768 is not set
CONFIG_VIDEO_DW9807_VCM=m
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_MSP3400 is not set
CONFIG_VIDEO_SONY_BTF_MPX=m
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=m
# CONFIG_VIDEO_TEA6415C is not set
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_WM8775=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=m
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_ADV7604=m
CONFIG_VIDEO_ADV7604_CEC=y
CONFIG_VIDEO_ADV7842=m
# CONFIG_VIDEO_ADV7842_CEC is not set
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_SAA7110=m
# CONFIG_VIDEO_SAA711X is not set
CONFIG_VIDEO_TC358743=m
# CONFIG_VIDEO_TC358743_CEC is not set
CONFIG_VIDEO_TVP514X=m
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_AD9389B=m
# CONFIG_VIDEO_ADV7170 is not set
CONFIG_VIDEO_ADV7175=m
# CONFIG_VIDEO_ADV7343 is not set
CONFIG_VIDEO_ADV7393=m
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_THS8200=m
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=m
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_ST_MIPID02 is not set
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_FC2580=m
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_M88RS6000T=m
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT20XX=m
# CONFIG_MEDIA_TUNER_MT2131 is not set
CONFIG_MEDIA_TUNER_MT2266=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_XC5000=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=m
# CONFIG_DVB_MXL5XX is not set
# CONFIG_DVB_STB0899 is not set
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
# CONFIG_DVB_STV6110x is not set
CONFIG_DVB_STV6111=m

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
# CONFIG_DVB_MN88472 is not set
# CONFIG_DVB_MN88473 is not set
CONFIG_DVB_SI2165=m
CONFIG_DVB_TDA18271C2DD=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
# CONFIG_DVB_CX24123 is not set
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_MT312=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_STB6000=m
# CONFIG_DVB_STV0288 is not set
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_TDA10071=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TS2020=m
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TUNER_ITD1000=m
# CONFIG_DVB_VES1X93 is not set
CONFIG_DVB_ZL10036=m
# CONFIG_DVB_ZL10039 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=m
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=m
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=m
# CONFIG_DVB_DIB3000MB is not set
# CONFIG_DVB_DIB3000MC is not set
CONFIG_DVB_DIB7000M=m
# CONFIG_DVB_DIB7000P is not set
CONFIG_DVB_DIB9000=m
CONFIG_DVB_DRXD=m
# CONFIG_DVB_EC100 is not set
CONFIG_DVB_L64781=m
CONFIG_DVB_MT352=m
# CONFIG_DVB_NXT6000 is not set
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=m
CONFIG_DVB_S5H1432=m
# CONFIG_DVB_SI2168 is not set
# CONFIG_DVB_SP887X is not set
CONFIG_DVB_STV0367=m
CONFIG_DVB_TDA10048=m
# CONFIG_DVB_TDA1004X is not set
# CONFIG_DVB_ZD1301_DEMOD is not set
# CONFIG_DVB_ZL10353 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=m
CONFIG_DVB_TDA10021=m
# CONFIG_DVB_TDA10023 is not set
# CONFIG_DVB_VES1820 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_BCM3510=m
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_LGDT3305=m
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LGDT330X=m
# CONFIG_DVB_MXL692 is not set
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51132=m
# CONFIG_DVB_OR51211 is not set
CONFIG_DVB_S5H1409=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m
CONFIG_DVB_S921=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_MN88443X is not set
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_ASCOT2E=m
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_HELENE=m
CONFIG_DVB_HORUS3A=m
# CONFIG_DVB_ISL6405 is not set
CONFIG_DVB_ISL6421=m
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_IX2505V=m
CONFIG_DVB_LGS8GL5=m
# CONFIG_DVB_LGS8GXX is not set
# CONFIG_DVB_LNBH25 is not set
CONFIG_DVB_LNBH29=m
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=m
CONFIG_DVB_M88RS2000=m
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_DRX39XYJ=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=m
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_SIS=m
CONFIG_AGP_VIA=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
# CONFIG_DRM_VMWGFX_MKSSTATS is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_QXL is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=m
# CONFIG_DRM_ETNAVIV_THERMAL is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_SIMPLEDRM is not set
CONFIG_DRM_XEN=y
CONFIG_DRM_XEN_FRONTEND=m
CONFIG_DRM_VBOXVIDEO=m
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
CONFIG_DRM_SAVAGE=m
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_RIVA_BACKLIGHT=y
# CONFIG_FB_I740 is not set
CONFIG_FB_LE80578=m
CONFIG_FB_CARILLO_RANCH=m
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
# CONFIG_FB_MATROX_I2C is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
CONFIG_FB_ATY_BACKLIGHT=y
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=m
# CONFIG_FB_SAVAGE_I2C is not set
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=m
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=m
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=m
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=m
CONFIG_FB_VIRTUAL=m
CONFIG_XEN_FBDEV_FRONTEND=m
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
CONFIG_FB_SM712=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=m
# CONFIG_BACKLIGHT_KTD253 is not set
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_RAVE_SP=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
CONFIG_SND_PCM_OSS=m
# CONFIG_SND_PCM_OSS_PLUGINS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=m
# CONFIG_SND_ALOOP is not set
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_MTS64=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_PORTMAN2X4=m
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_SB_COMMON=m
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
CONFIG_SND_ALS300=m
CONFIG_SND_ALS4000=m
# CONFIG_SND_ALI5451 is not set
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
# CONFIG_SND_AU8820 is not set
CONFIG_SND_AU8830=m
CONFIG_SND_AW2=m
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
CONFIG_SND_CS4281=m
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
# CONFIG_SND_MIA is not set
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
# CONFIG_SND_INDIGODJX is not set
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
# CONFIG_SND_HDSPM is not set
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
CONFIG_SND_NM256=m
# CONFIG_SND_PCXHR is not set
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_SONICVIBES=m
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
# CONFIG_SND_HDA_CODEC_CS8409 is not set
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=m
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
# CONFIG_SND_SOC is not set
# CONFIG_SND_X86 is not set
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
# CONFIG_HID is not set

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=m
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
CONFIG_MMC_VIA_SDMMC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_SCSI_UFSHCD=y
CONFIG_SCSI_UFS_BSG=y
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
# CONFIG_SCSI_UFS_HWMON is not set
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=y
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=y
CONFIG_EDAC_I3000=m
# CONFIG_EDAC_I3200 is not set
CONFIG_EDAC_IE31200=y
CONFIG_EDAC_X38=y
# CONFIG_EDAC_I5400 is not set
CONFIG_EDAC_I5000=m
# CONFIG_EDAC_I5100 is not set
CONFIG_EDAC_I7300=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_INTEL_IDMA64=y
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=y
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
CONFIG_DW_EDMA=y
CONFIG_DW_EDMA_PCIE=y
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=m
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
# CONFIG_CFAG12864B is not set
CONFIG_IMG_ASCII_LCD=m
# CONFIG_HT16K33 is not set
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=m
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_IGD=y
CONFIG_VFIO_MDEV=y
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
# CONFIG_XENFS is not set
# CONFIG_XEN_SYS_HYPERVISOR is not set
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=m
CONFIG_XEN_GRANT_DEV_ALLOC=y
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_XEN_PCI_STUB=y
CONFIG_XEN_PCIDEV_BACKEND=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=m
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=m
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=m
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=m
CONFIG_COMEDI_PCL724=m
# CONFIG_COMEDI_PCL726 is not set
CONFIG_COMEDI_PCL730=m
# CONFIG_COMEDI_PCL812 is not set
CONFIG_COMEDI_PCL816=m
CONFIG_COMEDI_PCL818=m
CONFIG_COMEDI_PCM3724=m
CONFIG_COMEDI_AMPLC_DIO200_ISA=m
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
CONFIG_COMEDI_AMPLC_PC263_ISA=m
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=m
# CONFIG_COMEDI_DAC02 is not set
# CONFIG_COMEDI_DAS16M1 is not set
CONFIG_COMEDI_DAS08_ISA=m
# CONFIG_COMEDI_DAS16 is not set
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=m
CONFIG_COMEDI_DT2801=m
CONFIG_COMEDI_DT2811=m
CONFIG_COMEDI_DT2814=m
# CONFIG_COMEDI_DT2815 is not set
# CONFIG_COMEDI_DT2817 is not set
CONFIG_COMEDI_DT282X=m
CONFIG_COMEDI_DMM32AT=m
CONFIG_COMEDI_FL512=m
CONFIG_COMEDI_AIO_AIO12_8=m
CONFIG_COMEDI_AIO_IIRO_16=m
# CONFIG_COMEDI_II_PCI20KC is not set
CONFIG_COMEDI_C6XDIGIO=m
CONFIG_COMEDI_MPC624=m
# CONFIG_COMEDI_ADQ12B is not set
CONFIG_COMEDI_NI_AT_A2150=m
CONFIG_COMEDI_NI_AT_AO=m
CONFIG_COMEDI_NI_ATMIO=m
# CONFIG_COMEDI_NI_ATMIO16D is not set
# CONFIG_COMEDI_NI_LABPC_ISA is not set
CONFIG_COMEDI_PCMAD=m
# CONFIG_COMEDI_PCMDA12 is not set
CONFIG_COMEDI_PCMMIO=m
CONFIG_COMEDI_PCMUIO=m
# CONFIG_COMEDI_MULTIQ3 is not set
CONFIG_COMEDI_S526=m
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
# CONFIG_RTLLIB is not set
CONFIG_RTS5208=y
CONFIG_FB_SM750=m
# CONFIG_STAGING_MEDIA is not set
# CONFIG_MOST_COMPONENTS is not set
# CONFIG_KS7010 is not set
CONFIG_FIELDBUS_DEV=y
# CONFIG_QLGE is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
# CONFIG_VME_TSI148 is not set
# CONFIG_VME_FAKE is not set

#
# VME Device Drivers
#
CONFIG_VME_USER=m
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_EC is not set
CONFIG_CROS_KBD_LED_BACKLIGHT=y
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
# CONFIG_WMI_BMOF is not set
# CONFIG_HUAWEI_WMI is not set
CONFIG_MXM_WMI=m
CONFIG_PEAQ_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
CONFIG_XIAOMI_WMI=m
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=y
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_GPD_POCKET_FAN=m
# CONFIG_HP_ACCEL is not set
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
CONFIG_IBM_RTL=y
# CONFIG_SENSORS_HDAPS is not set
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_ALSA_SUPPORT is not set
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
CONFIG_THINKPAD_ACPI_DEBUG=y
CONFIG_THINKPAD_ACPI_UNSAFE_LEDS=y
# CONFIG_THINKPAD_ACPI_VIDEO is not set
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
# CONFIG_INTEL_ATOMISP2_LED is not set
CONFIG_INTEL_ATOMISP2_PM=y
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=y
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_INT0002_VGPIO=y
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_RST=m
CONFIG_INTEL_SMARTCONNECT=m
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_SAMSUNG_Q10 is not set
CONFIG_TOSHIBA_BT_RFKILL=y
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_LG_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IPS=y
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_MAX9485=m
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CS2000_CP=m
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_XILINX_VCU=m
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
# CONFIG_INTEL_IOMMU is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_CTRL is not set
# CONFIG_RPMSG_NS is not set
CONFIG_RPMSG_QCOM_GLINK=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=m
CONFIG_PWM_PCA9685=m

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=m
# end of IRQ chip support

CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_SIMPLE is not set
CONFIG_RESET_TI_SYSCON=m
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
# CONFIG_INTEL_RAPL is not set
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
# CONFIG_BLK_DEV_PMEM is not set
CONFIG_ND_CLAIM=y
CONFIG_BTT=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_SPMI_SDAM is not set
CONFIG_RAVE_SP_EEPROM=m
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=m
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_ACPI=y
CONFIG_INTEL_TH_GTH=m
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=m
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=m
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=m
# CONFIG_FPGA_DFL is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=m
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
CONFIG_MOST=y
# CONFIG_MOST_CDEV is not set
# CONFIG_MOST_SND is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=m
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_DEBUG=y
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=m
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=m
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=m
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=m
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_ADIANTUM=m
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# CONFIG_CRYPTO_CRC64_ROCKSOFT is not set
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256_SSSE3=m
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
# CONFIG_CRYPTO_DEV_PADLOCK_SHA is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
# CONFIG_CRYPTO_DEV_SP_CCP is not set
CONFIG_CRYPTO_DEV_SP_PSP=y
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=y
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC64_ROCKSOFT is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
CONFIG_NOINSTR_VALIDATION=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--935iG+o1P1Q4yHPC--
