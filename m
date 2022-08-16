Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415EA596591
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbiHPWjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbiHPWjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:39:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC5172B73
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660689545; x=1692225545;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b2H81zOo2CQKHQ/H0Vl5PE+rjPodbBMv+pUOYzqEYWQ=;
  b=JdU9CjgWihFAdspinkH3veFeBRpzTutQZexzJ8TO+3X0UxXZzDAND70u
   gaI809qjgFTgpwVd89f3OvptFE/RmHwNQ6v+WsHKpMie/PVMTAonQa5ys
   VTU2VDnnCpxdniD6UBcQgN0FsuAO0ycYqbyx9PENPIzqYuvyAwsPoL5G/
   eJO+vsJMGANGlBYPmty+4N0tJZvuGoIGTJQDgo9hpnGtPu0awMRqN1g4f
   Q7mE1wAyWzFTBrXMReWXJ+Tjgjd2OHNg5uQs6wQbJbx0sXPTLWbTT2lJA
   2L9bg8Y3OaxeFGVt4WvLFSAkBnVu2qvlXNZK/mOC/8TgNsBoh2OiJcfIX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="289915698"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="289915698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 15:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="935099855"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2022 15:39:03 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO5DC-0000I8-2C;
        Tue, 16 Aug 2022 22:39:02 +0000
Date:   Wed, 17 Aug 2022 06:38:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/13] arch/x86/kernel/cpu/mtrr/if.c:196:23: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202208170618.W2FnDExn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   8836fbd6cd3120383a0bc63cd54c7dd55639ed49
commit: 2600a472582e2968633831d430c2a1366ad3e8b1 [5/13] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s023-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170618.W2FnDExn-lkp@intel.com/config)
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
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/mtrr/ drivers/cdrom/ drivers/char/mwave/ drivers/firewire/ drivers/misc/vmw_vmci/ drivers/rapidio/ drivers/rtc/ drivers/scsi/ drivers/spi/ drivers/tty/ drivers/vhost/ fs/ocfs2/ fs/udf/ ipc/ kernel/ net/atm/ net/bluetooth/ net/can/ net/decnet/ net/ieee802154/ net/llc/ net/nfc/ net/vmw_vsock/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/mtrr/if.c:196:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:196:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:196:23: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:197:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:197:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:197:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:198:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:198:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:198:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:208:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:208:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:208:23: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:209:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:209:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:209:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:210:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:210:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:210:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:211:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:211:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:211:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:327:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:327:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:327:23: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:328:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:328:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:328:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:329:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:329:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:329:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:330:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:330:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:330:24: sparse:     got unsigned int *
--
>> kernel/profile.c:416:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   kernel/profile.c:416:21: sparse:     expected char [noderef] __user *__ptr_clean
   kernel/profile.c:416:21: sparse:     got char *
--
>> kernel/rseq.c:111:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:111:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:111:13: sparse:     got unsigned int *
   kernel/rseq.c:118:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:118:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:118:13: sparse:     got unsigned int *
>> kernel/rseq.c:132:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/rseq.c:132:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/rseq.c:132:13: sparse:     got unsigned long long *
   kernel/rseq.c:161:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:161:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:161:15: sparse:     got unsigned int *
   kernel/rseq.c:183:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:183:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:183:15: sparse:     got unsigned int *
   kernel/rseq.c:213:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/rseq.c:213:16: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/rseq.c:213:16: sparse:     got unsigned long long *
--
>> fs/ocfs2/ioctl.c:867:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ocfs2/ioctl.c:867:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ocfs2/ioctl.c:867:21: sparse:     got int *
>> fs/ocfs2/ioctl.c:47:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ocfs2/ioctl.c:47:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ocfs2/ioctl.c:47:15: sparse:     got unsigned int *
>> fs/ocfs2/ioctl.c:47:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ocfs2/ioctl.c:47:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ocfs2/ioctl.c:47:15: sparse:     got unsigned int *
--
>> fs/udf/file.c:208:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/udf/file.c:208:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/udf/file.c:208:21: sparse:     got long *
   fs/udf/file.c:213:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/udf/file.c:213:34: sparse:     expected long [noderef] __user *__ptr_clean
   fs/udf/file.c:213:34: sparse:     got long *
>> fs/udf/file.c:216:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/udf/file.c:216:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/udf/file.c:216:24: sparse:     got int *
--
>> ipc/mqueue.c:1273:36: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   ipc/mqueue.c:1273:36: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   ipc/mqueue.c:1273:36: sparse:     got unsigned int *
--
>> drivers/cdrom/cdrom.c:3284:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/cdrom/cdrom.c:3284:24: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/cdrom/cdrom.c:3284:24: sparse:     got signed int *
>> drivers/cdrom/cdrom.c:3286:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   drivers/cdrom/cdrom.c:3286:16: sparse:     expected long [noderef] __user *__ptr_clean
   drivers/cdrom/cdrom.c:3286:16: sparse:     got long *
--
>> drivers/char/mwave/3780i.c:499:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:499:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:499:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:541:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:541:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:541:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:580:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:580:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:580:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:629:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:629:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:629:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:631:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:631:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:631:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:674:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:674:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:674:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:676:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:676:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:676:20: sparse:     got unsigned short *
--
>> drivers/firewire/core-cdev.c:1108:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/firewire/core-cdev.c:1108:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/firewire/core-cdev.c:1108:21: sparse:     got unsigned int *
--
>> drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse:     got int *
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     got int *
>> drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     got int *
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     got int *
>> drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     got unsigned int *
--
>> net/atm/svc.c:509:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/svc.c:509:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/svc.c:509:13: sparse:     got int *
--
>> net/atm/ioctl.c:70:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:70:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:70:25: sparse:     got int *
   net/atm/ioctl.c:82:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:82:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:82:25: sparse:     got int *
>> net/atm/ioctl.c:125:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/atm/ioctl.c:125:25: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/atm/ioctl.c:125:25: sparse:     got unsigned short *
>> net/atm/ioctl.c:173:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:173:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:173:29: sparse:     got unsigned int *
>> net/atm/ioctl.c:180:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   net/atm/ioctl.c:180:29: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   net/atm/ioctl.c:180:29: sparse:     got void [noderef] __user **
   net/atm/ioctl.c:193:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:193:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:193:29: sparse:     got unsigned int *
   net/atm/ioctl.c:196:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:196:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:196:29: sparse:     got int *
   net/atm/ioctl.c:203:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   net/atm/ioctl.c:203:29: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   net/atm/ioctl.c:203:29: sparse:     got void [noderef] __user **
   net/atm/ioctl.c:205:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:205:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:205:29: sparse:     got int *
   net/atm/ioctl.c:280:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:280:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:280:13: sparse:     got unsigned int *
   net/atm/ioctl.c:293:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:293:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:293:13: sparse:     got unsigned int *
   net/atm/ioctl.c:293:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:293:45: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:293:45: sparse:     got int *
--
>> net/atm/common.c:795:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/common.c:795:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/common.c:795:13: sparse:     got int *
>> net/atm/common.c:808:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   net/atm/common.c:808:24: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   net/atm/common.c:808:24: sparse:     got unsigned long *
--
>> net/atm/resources.c:201:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:201:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:201:13: sparse:     got int *
   net/atm/resources.c:221:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:221:18: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:221:18: sparse:     got int *
   net/atm/resources.c:233:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:233:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:233:13: sparse:     got int *
   net/atm/resources.c:352:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:352:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:352:25: sparse:     got int *
   net/atm/resources.c:395:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:395:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:395:25: sparse:     got int *
--
>> net/bluetooth/af_bluetooth.c:512:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/af_bluetooth.c:512:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/af_bluetooth.c:512:23: sparse:     got int *
   net/bluetooth/af_bluetooth.c:523:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/af_bluetooth.c:523:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/af_bluetooth.c:523:23: sparse:     got int *
   net/bluetooth/af_bluetooth.c:178:25: sparse: sparse: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
--
>> net/bluetooth/hci_core.c:837:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/bluetooth/hci_core.c:837:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/bluetooth/hci_core.c:837:13: sparse:     got unsigned short *
--
>> net/bluetooth/hci_sock.c:1976:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/hci_sock.c:1976:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:1976:13: sparse:     got int *
>> net/bluetooth/hci_sock.c:1993:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/bluetooth/hci_sock.c:1993:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:1993:21: sparse:     got char *
   net/bluetooth/hci_sock.c:2003:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/bluetooth/hci_sock.c:2003:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:2003:21: sparse:     got char *
>> net/bluetooth/hci_sock.c:2053:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/bluetooth/hci_sock.c:2053:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:2053:21: sparse:     got unsigned short *
--
>> net/bluetooth/l2cap_sock.c:464:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/l2cap_sock.c:464:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:464:13: sparse:     got int *
>> net/bluetooth/l2cap_sock.c:539:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/l2cap_sock.c:539:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:539:21: sparse:     got unsigned int *
   net/bluetooth/l2cap_sock.c:589:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/l2cap_sock.c:589:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:589:13: sparse:     got int *
   net/bluetooth/l2cap_sock.c:625:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/l2cap_sock.c:625:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:625:21: sparse:     got unsigned int *
   net/bluetooth/l2cap_sock.c:632:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/l2cap_sock.c:632:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:632:21: sparse:     got unsigned int *
   net/bluetooth/l2cap_sock.c:654:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/l2cap_sock.c:654:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:654:21: sparse:     got unsigned int *
>> net/bluetooth/l2cap_sock.c:669:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/bluetooth/l2cap_sock.c:669:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:669:21: sparse:     got unsigned short *
   net/bluetooth/l2cap_sock.c:679:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/bluetooth/l2cap_sock.c:679:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:679:21: sparse:     got unsigned short *
   net/bluetooth/l2cap_sock.c:691:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/l2cap_sock.c:691:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:691:21: sparse:     got unsigned int *
>> net/bluetooth/l2cap_sock.c:712:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   net/bluetooth/l2cap_sock.c:712:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:712:21: sparse:     got unsigned char *
--
   net/bluetooth/sco.c: note: in included file:
   include/net/bluetooth/hci_core.h:148:35: sparse: sparse: array of flexible structures
>> net/bluetooth/sco.c:981:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/sco.c:981:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/sco.c:981:13: sparse:     got int *
   net/bluetooth/sco.c:1052:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/sco.c:1052:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/sco.c:1052:13: sparse:     got int *
>> net/bluetooth/sco.c:1065:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/sco.c:1065:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/sco.c:1065:21: sparse:     got unsigned int *
   net/bluetooth/sco.c:1088:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/sco.c:1088:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/sco.c:1088:21: sparse:     got unsigned int *
   net/bluetooth/sco.c:1095:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/sco.c:1095:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/sco.c:1095:21: sparse:     got int *
   net/bluetooth/sco.c:1106:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/sco.c:1106:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/sco.c:1106:21: sparse:     got unsigned int *
>> net/bluetooth/sco.c:1154:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   net/bluetooth/sco.c:1154:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   net/bluetooth/sco.c:1154:21: sparse:     got unsigned char *
   net/bluetooth/sco.c:1197:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/sco.c:1197:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/sco.c:1197:29: sparse:     got int *
--
>> net/can/raw.c:698:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/raw.c:698:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/raw.c:698:13: sparse:     got int *
   net/can/raw.c:713:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/raw.c:713:37: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/raw.c:713:37: sparse:     got int *
   net/can/raw.c:727:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/raw.c:727:31: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/raw.c:727:31: sparse:     got int *
   net/can/raw.c:764:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/raw.c:764:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/raw.c:764:13: sparse:     got int *
--
>> net/bluetooth/rfcomm/sock.c:743:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/rfcomm/sock.c:743:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/rfcomm/sock.c:743:13: sparse:     got int *
>> net/bluetooth/rfcomm/sock.c:773:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/rfcomm/sock.c:773:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/rfcomm/sock.c:773:21: sparse:     got unsigned int *
   net/bluetooth/rfcomm/sock.c:821:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/rfcomm/sock.c:821:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/rfcomm/sock.c:821:13: sparse:     got int *
   net/bluetooth/rfcomm/sock.c:848:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/rfcomm/sock.c:848:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/rfcomm/sock.c:848:21: sparse:     got unsigned int *
--
>> net/bluetooth/rfcomm/tty.c:513:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/bluetooth/rfcomm/tty.c:513:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/bluetooth/rfcomm/tty.c:513:13: sparse:     got unsigned short *
--
>> net/bluetooth/hidp/sock.c:158:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/hidp/sock.c:158:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/hidp/sock.c:158:21: sparse:     got unsigned int *
   net/bluetooth/hidp/sock.c:158:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/hidp/sock.c:158:45: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/hidp/sock.c:158:45: sparse:     got unsigned int *
   net/bluetooth/hidp/sock.c:168:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/hidp/sock.c:168:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/hidp/sock.c:168:29: sparse:     got unsigned int *
--
   drivers/rapidio/rio_cm.c: note: in included file:
   include/linux/rio.h:204:34: sparse: sparse: array of flexible structures
   drivers/rapidio/rio_cm.c:383:17: sparse: sparse: cast to restricted __be16
   drivers/rapidio/rio_cm.c:402:23: sparse: sparse: cast to restricted __be32
   drivers/rapidio/rio_cm.c:403:21: sparse: sparse: cast to restricted __be16
   drivers/rapidio/rio_cm.c:429:17: sparse: sparse: cast to restricted __be16
   drivers/rapidio/rio_cm.c:440:27: sparse: sparse: cast to restricted __be16
   drivers/rapidio/rio_cm.c:461:9: sparse: sparse: cast to restricted __be16
   drivers/rapidio/rio_cm.c:464:32: sparse: sparse: cast to restricted __be16
   drivers/rapidio/rio_cm.c:495:9: sparse: sparse: cast to restricted __be16
   drivers/rapidio/rio_cm.c:495:9: sparse: sparse: cast to restricted __be16
   drivers/rapidio/rio_cm.c:533:9: sparse: sparse: cast to restricted __be16
   drivers/rapidio/rio_cm.c:535:32: sparse: sparse: cast to restricted __be16
   drivers/rapidio/rio_cm.c:807:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_id @@     got restricted __be32 [usertype] @@
   drivers/rapidio/rio_cm.c:807:26: sparse:     expected unsigned int [usertype] src_id
   drivers/rapidio/rio_cm.c:807:26: sparse:     got restricted __be32 [usertype]
   drivers/rapidio/rio_cm.c:808:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dst_id @@     got restricted __be32 [usertype] @@
   drivers/rapidio/rio_cm.c:808:26: sparse:     expected unsigned int [usertype] dst_id
   drivers/rapidio/rio_cm.c:808:26: sparse:     got restricted __be32 [usertype]
   drivers/rapidio/rio_cm.c:813:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] dst_ch @@     got restricted __be16 [usertype] @@
   drivers/rapidio/rio_cm.c:813:21: sparse:     expected unsigned short [usertype] dst_ch
   drivers/rapidio/rio_cm.c:813:21: sparse:     got restricted __be16 [usertype]
   drivers/rapidio/rio_cm.c:814:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] src_ch @@     got restricted __be16 [usertype] @@
   drivers/rapidio/rio_cm.c:814:21: sparse:     expected unsigned short [usertype] src_ch
   drivers/rapidio/rio_cm.c:814:21: sparse:     got restricted __be16 [usertype]
   drivers/rapidio/rio_cm.c:815:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] msg_len @@     got restricted __be16 [usertype] @@
   drivers/rapidio/rio_cm.c:815:22: sparse:     expected unsigned short [usertype] msg_len
   drivers/rapidio/rio_cm.c:815:22: sparse:     got restricted __be16 [usertype]
   drivers/rapidio/rio_cm.c:975:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_id @@     got restricted __be32 [usertype] @@
   drivers/rapidio/rio_cm.c:975:26: sparse:     expected unsigned int [usertype] src_id
   drivers/rapidio/rio_cm.c:975:26: sparse:     got restricted __be32 [usertype]
   drivers/rapidio/rio_cm.c:976:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dst_id @@     got restricted __be32 [usertype] @@
   drivers/rapidio/rio_cm.c:976:26: sparse:     expected unsigned int [usertype] dst_id
   drivers/rapidio/rio_cm.c:976:26: sparse:     got restricted __be32 [usertype]
   drivers/rapidio/rio_cm.c:981:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] dst_ch @@     got restricted __be16 [usertype] @@
   drivers/rapidio/rio_cm.c:981:21: sparse:     expected unsigned short [usertype] dst_ch
   drivers/rapidio/rio_cm.c:981:21: sparse:     got restricted __be16 [usertype]
   drivers/rapidio/rio_cm.c:982:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] src_ch @@     got restricted __be16 [usertype] @@
   drivers/rapidio/rio_cm.c:982:21: sparse:     expected unsigned short [usertype] src_ch
   drivers/rapidio/rio_cm.c:982:21: sparse:     got restricted __be16 [usertype]
   drivers/rapidio/rio_cm.c:1030:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_id @@     got restricted __be32 [usertype] @@
   drivers/rapidio/rio_cm.c:1030:26: sparse:     expected unsigned int [usertype] src_id
   drivers/rapidio/rio_cm.c:1030:26: sparse:     got restricted __be32 [usertype]
   drivers/rapidio/rio_cm.c:1031:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dst_id @@     got restricted __be32 [usertype] @@
   drivers/rapidio/rio_cm.c:1031:26: sparse:     expected unsigned int [usertype] dst_id
   drivers/rapidio/rio_cm.c:1031:26: sparse:     got restricted __be32 [usertype]
   drivers/rapidio/rio_cm.c:1032:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] dst_ch @@     got restricted __be16 [usertype] @@
   drivers/rapidio/rio_cm.c:1032:21: sparse:     expected unsigned short [usertype] dst_ch
   drivers/rapidio/rio_cm.c:1032:21: sparse:     got restricted __be16 [usertype]
   drivers/rapidio/rio_cm.c:1033:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] src_ch @@     got restricted __be16 [usertype] @@
   drivers/rapidio/rio_cm.c:1033:21: sparse:     expected unsigned short [usertype] src_ch
   drivers/rapidio/rio_cm.c:1033:21: sparse:     got restricted __be16 [usertype]
   drivers/rapidio/rio_cm.c:1404:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_id @@     got restricted __be32 [usertype] @@
   drivers/rapidio/rio_cm.c:1404:26: sparse:     expected unsigned int [usertype] src_id
   drivers/rapidio/rio_cm.c:1404:26: sparse:     got restricted __be32 [usertype]
   drivers/rapidio/rio_cm.c:1405:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dst_id @@     got restricted __be32 [usertype] @@
   drivers/rapidio/rio_cm.c:1405:26: sparse:     expected unsigned int [usertype] dst_id
   drivers/rapidio/rio_cm.c:1405:26: sparse:     got restricted __be32 [usertype]
   drivers/rapidio/rio_cm.c:1410:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] dst_ch @@     got restricted __be16 [usertype] @@
   drivers/rapidio/rio_cm.c:1410:21: sparse:     expected unsigned short [usertype] dst_ch
   drivers/rapidio/rio_cm.c:1410:21: sparse:     got restricted __be16 [usertype]
   drivers/rapidio/rio_cm.c:1411:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] src_ch @@     got restricted __be16 [usertype] @@
   drivers/rapidio/rio_cm.c:1411:21: sparse:     expected unsigned short [usertype] src_ch
   drivers/rapidio/rio_cm.c:1411:21: sparse:     got restricted __be16 [usertype]
>> drivers/rapidio/rio_cm.c:1536:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rapidio/rio_cm.c:1536:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rapidio/rio_cm.c:1536:13: sparse:     got unsigned int *
>> drivers/rapidio/rio_cm.c:1662:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/rapidio/rio_cm.c:1662:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/rapidio/rio_cm.c:1662:13: sparse:     got unsigned short *
   drivers/rapidio/rio_cm.c:1674:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/rapidio/rio_cm.c:1674:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/rapidio/rio_cm.c:1674:16: sparse:     got unsigned short *
   drivers/rapidio/rio_cm.c:1688:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/rapidio/rio_cm.c:1688:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/rapidio/rio_cm.c:1688:13: sparse:     got unsigned short *
   drivers/rapidio/rio_cm.c:1735:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/rapidio/rio_cm.c:1735:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/rapidio/rio_cm.c:1735:13: sparse:     got unsigned short *
--
>> drivers/rtc/rtc-abx80x.c:527:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-pcf2127.c:231:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-pcf85063.c:304:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-pcf85063.c:304:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-pcf85063.c:304:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-pcf8563.c:288:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rv3028.c:597:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rx8010.c:350:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     got unsigned int *
--
>> net/decnet/af_decnet.c:1541:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/decnet/af_decnet.c:1541:12: sparse:     expected int [noderef] __user *__ptr_clean
   net/decnet/af_decnet.c:1541:12: sparse:     got int *
   net/decnet/af_decnet.c:1636:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/decnet/af_decnet.c:1636:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/decnet/af_decnet.c:1636:21: sparse:     got int *
   net/decnet/af_decnet.c:251:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int hash @@     got restricted __le16 [usertype] sdn_objnamel @@
   net/decnet/af_decnet.c:251:22: sparse:     expected unsigned int hash
   net/decnet/af_decnet.c:251:22: sparse:     got restricted __le16 [usertype] sdn_objnamel
   net/decnet/af_decnet.c:1243:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/decnet/af_decnet.c:1243:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/decnet/af_decnet.c:1243:23: sparse:     got int *
   net/decnet/af_decnet.c:1256:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/decnet/af_decnet.c:1256:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/decnet/af_decnet.c:1256:23: sparse:     got int *
   net/decnet/af_decnet.c: note: in included file:
   include/net/dn.h:192:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] sport @@     got restricted __le16 [usertype] addrloc @@
   include/net/dn.h:192:24: sparse:     expected restricted __be16 [usertype] sport
   include/net/dn.h:192:24: sparse:     got restricted __le16 [usertype] addrloc
   include/net/dn.h:193:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] dport @@     got restricted __le16 [usertype] addrrem @@
   include/net/dn.h:193:24: sparse:     expected restricted __be16 [usertype] dport
   include/net/dn.h:193:24: sparse:     got restricted __le16 [usertype] addrrem
   net/decnet/af_decnet.c:2168:9: sparse: sparse: context imbalance in 'dn_socket_get_idx' - wrong count at exit
   net/decnet/af_decnet.c:2188:9: sparse: sparse: context imbalance in 'dn_socket_seq_next' - unexpected unlock
   net/decnet/af_decnet.c:2197:17: sparse: sparse: context imbalance in 'dn_socket_seq_stop' - unexpected unlock
--
>> net/ieee802154/socket.c:533:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:533:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:533:24: sparse:     got int *
   net/ieee802154/socket.c:552:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:552:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:552:24: sparse:     got int *
   net/ieee802154/socket.c:836:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:836:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:836:13: sparse:     got int *
   net/ieee802154/socket.c:866:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:866:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:866:13: sparse:     got int *
--
>> net/llc/af_llc.c:1171:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/llc/af_llc.c:1171:14: sparse:     expected int [noderef] __user *__ptr_clean
   net/llc/af_llc.c:1171:14: sparse:     got int *
   net/llc/af_llc.c:1202:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/llc/af_llc.c:1202:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/llc/af_llc.c:1202:13: sparse:     got int *
--
>> net/nfc/llcp_sock.c:319:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/nfc/llcp_sock.c:319:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:319:13: sparse:     got int *
>> net/nfc/llcp_sock.c:333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:333:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:333:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:342:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:342:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:342:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:351:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:351:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:351:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:357:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:357:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:357:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:363:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:363:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:363:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:375:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/nfc/llcp_sock.c:375:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:375:13: sparse:     got int *
--
>> drivers/scsi/hpsa.c:6286:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/hpsa.c:6286:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/hpsa.c:6286:13: sparse:     got unsigned int *
   drivers/scsi/hpsa.c:6317:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/hpsa.c:6317:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/hpsa.c:6317:13: sparse:     got unsigned int *
--
   drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:415:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:415:21: sparse:     got int *
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:419:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:419:32: sparse:     got int *
   drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/scsi/sg.c:425:32: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:425:32: sparse:     got signed int *
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:431:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:431:32: sparse:     got int *
   drivers/scsi/sg.c:638:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/scsi/sg.c:638:13: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:638:13: sparse:     got char const *
>> drivers/scsi/sg.c:907:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/sg.c:907:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:907:21: sparse:     got unsigned int *
   drivers/scsi/sg.c:908:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/sg.c:908:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:908:21: sparse:     got unsigned int *
   drivers/scsi/sg.c:909:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:909:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:909:21: sparse:     got int *
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
>> net/vmw_vsock/af_vsock.c:1689:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/vmw_vsock/af_vsock.c:1689:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/vmw_vsock/af_vsock.c:1689:13: sparse:     got int *
   net/vmw_vsock/af_vsock.c:1724:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/vmw_vsock/af_vsock.c:1724:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/vmw_vsock/af_vsock.c:1724:13: sparse:     got int *
>> net/vmw_vsock/af_vsock.c:2253:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/vmw_vsock/af_vsock.c:2253:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/vmw_vsock/af_vsock.c:2253:21: sparse:     got unsigned int *
--
>> drivers/spi/spidev.c:380:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/spi/spidev.c:380:26: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/spi/spidev.c:380:26: sparse:     got unsigned char *
>> drivers/spi/spidev.c:384:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/spi/spidev.c:384:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/spi/spidev.c:384:26: sparse:     got unsigned int *
   drivers/spi/spidev.c:388:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/spi/spidev.c:388:26: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/spi/spidev.c:388:26: sparse:     got unsigned char *
   drivers/spi/spidev.c:392:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/spi/spidev.c:392:26: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/spi/spidev.c:392:26: sparse:     got unsigned char *
   drivers/spi/spidev.c:395:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/spi/spidev.c:395:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/spi/spidev.c:395:26: sparse:     got unsigned int *
   drivers/spi/spidev.c:402:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/spi/spidev.c:402:34: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/spi/spidev.c:402:34: sparse:     got unsigned char *
   drivers/spi/spidev.c:404:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/spi/spidev.c:404:34: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/spi/spidev.c:404:34: sparse:     got unsigned int *
   drivers/spi/spidev.c:428:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/spi/spidev.c:428:26: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/spi/spidev.c:428:26: sparse:     got unsigned char *
   drivers/spi/spidev.c:445:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/spi/spidev.c:445:26: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/spi/spidev.c:445:26: sparse:     got unsigned char *
   drivers/spi/spidev.c:460:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/spi/spidev.c:460:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/spi/spidev.c:460:26: sparse:     got unsigned int *
--
>> drivers/tty/n_gsm.c:3087:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/n_gsm.c:3087:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/n_gsm.c:3087:24: sparse:     got unsigned int *
   drivers/tty/n_gsm.c:3252:29: sparse: sparse: restricted __be16 degrades to integer
--
>> drivers/tty/vt/vt_ioctl.c:328:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt_ioctl.c:328:24: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:328:24: sparse:     got char *
>> drivers/tty/vt/vt_ioctl.c:386:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:386:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:386:24: sparse:     got int *
   drivers/tty/vt/vt_ioctl.c:406:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:406:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:406:24: sparse:     got int *
   drivers/tty/vt/vt_ioctl.c:415:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:415:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:415:24: sparse:     got int *
>> drivers/tty/vt/vt_ioctl.c:811:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:811:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:811:21: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:821:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:821:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:821:24: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:834:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:834:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:834:24: sparse:     got int *
   drivers/tty/vt/vt_ioctl.c:917:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:917:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:917:21: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:918:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:918:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:918:21: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:952:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:952:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:952:24: sparse:     got unsigned short *
--
>> drivers/tty/vt/consolemap.c:359:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/tty/vt/consolemap.c:359:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/tty/vt/consolemap.c:359:21: sparse:     got unsigned char *
>> drivers/tty/vt/consolemap.c:830:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/consolemap.c:830:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/consolemap.c:830:13: sparse:     got unsigned short *
--
>> drivers/tty/vt/keyboard.c:1724:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1724:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1724:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1751:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1751:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1751:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1769:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1769:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1769:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1807:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1807:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1807:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1913:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1913:30: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1913:30: sparse:     got unsigned int *
>> drivers/tty/vt/keyboard.c:2033:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/keyboard.c:2033:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2033:24: sparse:     got unsigned short *
>> drivers/tty/vt/keyboard.c:2067:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/tty/vt/keyboard.c:2067:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2067:13: sparse:     got unsigned char *
>> drivers/tty/vt/keyboard.c:2125:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/keyboard.c:2125:24: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2125:24: sparse:     got char *
   drivers/tty/vt/keyboard.c:2143:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/keyboard.c:2143:24: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2143:24: sparse:     got char *
--
>> drivers/tty/vt/vt.c:4338:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:4338:13: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:4338:13: sparse:     got char *
   drivers/tty/vt/vt.c:3193:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3193:13: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3193:13: sparse:     got char *
   drivers/tty/vt/vt.c:3225:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3225:31: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3225:31: sparse:     got char *
   drivers/tty/vt/vt.c:3231:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3231:31: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3231:31: sparse:     got char *
   drivers/tty/vt/vt.c:3240:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3240:31: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3240:31: sparse:     got char *
   drivers/tty/vt/vt.c:3246:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3246:37: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3246:37: sparse:     got char *
>> drivers/tty/vt/vt.c:3259:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/tty/vt/vt.c:3259:29: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3259:29: sparse:     got signed int *
--
>> drivers/vhost/scsi.c:1905:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/vhost/scsi.c:1905:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/vhost/scsi.c:1905:21: sparse:     got unsigned int *
   drivers/vhost/scsi.c:1915:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/vhost/scsi.c:1915:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/vhost/scsi.c:1915:21: sparse:     got unsigned int *
--
>> drivers/vhost/vhost.c:1607:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/vhost/vhost.c:1607:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/vhost/vhost.c:1607:13: sparse:     got unsigned int *
>> drivers/vhost/vhost.c:1805:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/vhost/vhost.c:1805:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/vhost/vhost.c:1805:21: sparse:     got int *
--
   drivers/scsi/megaraid/megaraid_sas_base.c:4657:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4657:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4657:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:4908:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4908:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4908:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6753:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6753:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6753:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:4564:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4564:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4564:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:205:26: sparse: sparse: symbol 'megasas_mgmt_info' was not declared. Should it be static?
   drivers/scsi/megaraid/megaraid_sas_base.c:294:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:300:31: sparse: sparse: cast from restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:426:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1236:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] opcode @@     got restricted __le32 [usertype] opcode @@
   drivers/scsi/megaraid/megaraid_sas_base.c:1236:32: sparse:     expected unsigned int [usertype] opcode
   drivers/scsi/megaraid/megaraid_sas_base.c:1236:32: sparse:     got restricted __le32 [usertype] opcode
   drivers/scsi/megaraid/megaraid_sas_base.c:2019:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2060:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:4788:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4788:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4788:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:5028:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:5028:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:5028:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:5213:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:5213:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:5213:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:5295:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:5295:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:5295:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6306:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid/megaraid_sas_base.c:6305:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem * @@     got unsigned int [usertype] * @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6305:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *
   drivers/scsi/megaraid/megaraid_sas_base.c:6305:57: sparse:     got unsigned int [usertype] *
   drivers/scsi/megaraid/megaraid_sas_base.c:6310:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid/megaraid_sas_base.c:6309:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem * @@     got unsigned int [usertype] * @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6309:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *
   drivers/scsi/megaraid/megaraid_sas_base.c:6309:57: sparse:     got unsigned int [usertype] *
   drivers/scsi/megaraid/megaraid_sas_base.c:6617:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6617:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6617:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6831:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6831:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6831:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:7593:44: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:8210:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected int crash_support @@     got restricted __le32 @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8210:23: sparse:     expected int crash_support
   drivers/scsi/megaraid/megaraid_sas_base.c:8210:23: sparse:     got restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:8294:31: sparse: sparse: invalid assignment: &=
   drivers/scsi/megaraid/megaraid_sas_base.c:8294:31: sparse:    left side has type restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:8294:31: sparse:    right side has type int
>> drivers/scsi/megaraid/megaraid_sas_base.c:8512:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8512:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/megaraid/megaraid_sas_base.c:8512:21: sparse:     got unsigned int *
   drivers/scsi/megaraid/megaraid_sas_base.c:8513:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8513:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/megaraid/megaraid_sas_base.c:8513:21: sparse:     got unsigned int *
   drivers/scsi/megaraid/megaraid_sas_base.c:8826:46: sparse: sparse: restricted __le32 degrades to integer

vim +196 arch/x86/kernel/cpu/mtrr/if.c

^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  153  
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  154  static long
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  155  mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  156  {
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  157  	int err = 0;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  158  	mtrr_type type;
b263b31e8ad65cd arch/x86/kernel/cpu/mtrr/if.c  H. Peter Anvin         2012-02-27  159  	unsigned long base;
365bff806e9faba arch/i386/kernel/cpu/mtrr/if.c Jan Beulich            2006-12-07  160  	unsigned long size;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  161  	struct mtrr_sentry sentry;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  162  	struct mtrr_gentry gentry;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  163  	void __user *arg = (void __user *) __arg;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  164  
32043fa065b51e0 arch/x86/kernel/cpu/mtrr/if.c  Colin Ian King         2018-12-18  165  	memset(&gentry, 0, sizeof(gentry));
32043fa065b51e0 arch/x86/kernel/cpu/mtrr/if.c  Colin Ian King         2018-12-18  166  
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  167  	switch (cmd) {
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  168  	case MTRRIOC_ADD_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  169  	case MTRRIOC_SET_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  170  	case MTRRIOC_DEL_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  171  	case MTRRIOC_KILL_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  172  	case MTRRIOC_ADD_PAGE_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  173  	case MTRRIOC_SET_PAGE_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  174  	case MTRRIOC_DEL_PAGE_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  175  	case MTRRIOC_KILL_PAGE_ENTRY:
0e96f31ea4249b1 arch/x86/kernel/cpu/mtrr/if.c  Jordan Borgner         2018-10-28  176  		if (copy_from_user(&sentry, arg, sizeof(sentry)))
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  177  			return -EFAULT;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  178  		break;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  179  	case MTRRIOC_GET_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  180  	case MTRRIOC_GET_PAGE_ENTRY:
0e96f31ea4249b1 arch/x86/kernel/cpu/mtrr/if.c  Jordan Borgner         2018-10-28  181  		if (copy_from_user(&gentry, arg, sizeof(gentry)))
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  182  			return -EFAULT;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  183  		break;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  184  #ifdef CONFIG_COMPAT
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  185  	case MTRRIOC32_ADD_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  186  	case MTRRIOC32_SET_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  187  	case MTRRIOC32_DEL_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  188  	case MTRRIOC32_KILL_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  189  	case MTRRIOC32_ADD_PAGE_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  190  	case MTRRIOC32_SET_PAGE_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  191  	case MTRRIOC32_DEL_PAGE_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  192  	case MTRRIOC32_KILL_PAGE_ENTRY: {
26dc67eda19beaf arch/x86/kernel/cpu/mtrr/if.c  Jaswinder Singh Rajput 2009-07-04  193  		struct mtrr_sentry32 __user *s32;
26dc67eda19beaf arch/x86/kernel/cpu/mtrr/if.c  Jaswinder Singh Rajput 2009-07-04  194  
26dc67eda19beaf arch/x86/kernel/cpu/mtrr/if.c  Jaswinder Singh Rajput 2009-07-04  195  		s32 = (struct mtrr_sentry32 __user *)__arg;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30 @196  		err = get_user(sentry.base, &s32->base);
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  197  		err |= get_user(sentry.size, &s32->size);
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  198  		err |= get_user(sentry.type, &s32->type);
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  199  		if (err)
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  200  			return err;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  201  		break;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  202  	}
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  203  	case MTRRIOC32_GET_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  204  	case MTRRIOC32_GET_PAGE_ENTRY: {
26dc67eda19beaf arch/x86/kernel/cpu/mtrr/if.c  Jaswinder Singh Rajput 2009-07-04  205  		struct mtrr_gentry32 __user *g32;
26dc67eda19beaf arch/x86/kernel/cpu/mtrr/if.c  Jaswinder Singh Rajput 2009-07-04  206  
26dc67eda19beaf arch/x86/kernel/cpu/mtrr/if.c  Jaswinder Singh Rajput 2009-07-04  207  		g32 = (struct mtrr_gentry32 __user *)__arg;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  208  		err = get_user(gentry.regnum, &g32->regnum);
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  209  		err |= get_user(gentry.base, &g32->base);
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  210  		err |= get_user(gentry.size, &g32->size);
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  211  		err |= get_user(gentry.type, &g32->type);
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  212  		if (err)
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  213  			return err;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  214  		break;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  215  	}
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  216  #endif
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  217  	}
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  218  
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  219  	switch (cmd) {
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  220  	default:
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  221  		return -ENOTTY;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  222  	case MTRRIOC_ADD_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  223  #ifdef CONFIG_COMPAT
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  224  	case MTRRIOC32_ADD_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  225  #endif
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  226  		err =
2d2ee8de5f6d26e arch/x86/kernel/cpu/mtrr/if.c  Paul Jimenez           2008-01-30  227  		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  228  				  file, 0);
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  229  		break;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  230  	case MTRRIOC_SET_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  231  #ifdef CONFIG_COMPAT
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  232  	case MTRRIOC32_SET_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  233  #endif
2d2ee8de5f6d26e arch/x86/kernel/cpu/mtrr/if.c  Paul Jimenez           2008-01-30  234  		err = mtrr_add(sentry.base, sentry.size, sentry.type, false);
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  235  		break;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  236  	case MTRRIOC_DEL_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  237  #ifdef CONFIG_COMPAT
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  238  	case MTRRIOC32_DEL_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  239  #endif
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  240  		err = mtrr_file_del(sentry.base, sentry.size, file, 0);
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  241  		break;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  242  	case MTRRIOC_KILL_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  243  #ifdef CONFIG_COMPAT
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  244  	case MTRRIOC32_KILL_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  245  #endif
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  246  		err = mtrr_del(-1, sentry.base, sentry.size);
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  247  		break;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  248  	case MTRRIOC_GET_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  249  #ifdef CONFIG_COMPAT
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  250  	case MTRRIOC32_GET_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  251  #endif
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  252  		if (gentry.regnum >= num_var_ranges)
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  253  			return -EINVAL;
b263b31e8ad65cd arch/x86/kernel/cpu/mtrr/if.c  H. Peter Anvin         2012-02-27  254  		mtrr_if->get(gentry.regnum, &base, &size, &type);
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  255  
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  256  		/* Hide entries that go above 4GB */
b263b31e8ad65cd arch/x86/kernel/cpu/mtrr/if.c  H. Peter Anvin         2012-02-27  257  		if (base + size - 1 >= (1UL << (8 * sizeof(gentry.size) - PAGE_SHIFT))
365bff806e9faba arch/i386/kernel/cpu/mtrr/if.c Jan Beulich            2006-12-07  258  		    || size >= (1UL << (8 * sizeof(gentry.size) - PAGE_SHIFT)))
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  259  			gentry.base = gentry.size = gentry.type = 0;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  260  		else {
b263b31e8ad65cd arch/x86/kernel/cpu/mtrr/if.c  H. Peter Anvin         2012-02-27  261  			gentry.base = base << PAGE_SHIFT;
365bff806e9faba arch/i386/kernel/cpu/mtrr/if.c Jan Beulich            2006-12-07  262  			gentry.size = size << PAGE_SHIFT;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  263  			gentry.type = type;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  264  		}
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  265  
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  266  		break;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  267  	case MTRRIOC_ADD_PAGE_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  268  #ifdef CONFIG_COMPAT
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  269  	case MTRRIOC32_ADD_PAGE_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  270  #endif
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  271  		err =
2d2ee8de5f6d26e arch/x86/kernel/cpu/mtrr/if.c  Paul Jimenez           2008-01-30  272  		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  273  				  file, 1);
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  274  		break;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  275  	case MTRRIOC_SET_PAGE_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  276  #ifdef CONFIG_COMPAT
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  277  	case MTRRIOC32_SET_PAGE_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  278  #endif
2d2ee8de5f6d26e arch/x86/kernel/cpu/mtrr/if.c  Paul Jimenez           2008-01-30  279  		err =
2d2ee8de5f6d26e arch/x86/kernel/cpu/mtrr/if.c  Paul Jimenez           2008-01-30  280  		    mtrr_add_page(sentry.base, sentry.size, sentry.type, false);
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  281  		break;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  282  	case MTRRIOC_DEL_PAGE_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  283  #ifdef CONFIG_COMPAT
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  284  	case MTRRIOC32_DEL_PAGE_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  285  #endif
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  286  		err = mtrr_file_del(sentry.base, sentry.size, file, 1);
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  287  		break;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  288  	case MTRRIOC_KILL_PAGE_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  289  #ifdef CONFIG_COMPAT
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  290  	case MTRRIOC32_KILL_PAGE_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  291  #endif
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  292  		err = mtrr_del_page(-1, sentry.base, sentry.size);
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  293  		break;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  294  	case MTRRIOC_GET_PAGE_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  295  #ifdef CONFIG_COMPAT
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  296  	case MTRRIOC32_GET_PAGE_ENTRY:
98838ec984b78c6 arch/i386/kernel/cpu/mtrr/if.c Giuliano Procida       2007-02-13  297  #endif
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  298  		if (gentry.regnum >= num_var_ranges)
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  299  			return -EINVAL;
b263b31e8ad65cd arch/x86/kernel/cpu/mtrr/if.c  H. Peter Anvin         2012-02-27  300  		mtrr_if->get(gentry.regnum, &base, &size, &type);
365bff806e9faba arch/i386/kernel/cpu/mtrr/if.c Jan Beulich            2006-12-07  301  		/* Hide entries that would overflow */
365bff806e9faba arch/i386/kernel/cpu/mtrr/if.c Jan Beulich            2006-12-07  302  		if (size != (__typeof__(gentry.size))size)
365bff806e9faba arch/i386/kernel/cpu/mtrr/if.c Jan Beulich            2006-12-07  303  			gentry.base = gentry.size = gentry.type = 0;
365bff806e9faba arch/i386/kernel/cpu/mtrr/if.c Jan Beulich            2006-12-07  304  		else {
b263b31e8ad65cd arch/x86/kernel/cpu/mtrr/if.c  H. Peter Anvin         2012-02-27  305  			gentry.base = base;
365bff806e9faba arch/i386/kernel/cpu/mtrr/if.c Jan Beulich            2006-12-07  306  			gentry.size = size;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  307  			gentry.type = type;
365bff806e9faba arch/i386/kernel/cpu/mtrr/if.c Jan Beulich            2006-12-07  308  		}
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  309  		break;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  310  	}
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  311  
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  312  	if (err)
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  313  		return err;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  314  
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  315  	switch (cmd) {
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  316  	case MTRRIOC_GET_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  317  	case MTRRIOC_GET_PAGE_ENTRY:
0e96f31ea4249b1 arch/x86/kernel/cpu/mtrr/if.c  Jordan Borgner         2018-10-28  318  		if (copy_to_user(arg, &gentry, sizeof(gentry)))
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  319  			err = -EFAULT;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  320  		break;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  321  #ifdef CONFIG_COMPAT
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  322  	case MTRRIOC32_GET_ENTRY:
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  323  	case MTRRIOC32_GET_PAGE_ENTRY: {
26dc67eda19beaf arch/x86/kernel/cpu/mtrr/if.c  Jaswinder Singh Rajput 2009-07-04  324  		struct mtrr_gentry32 __user *g32;
26dc67eda19beaf arch/x86/kernel/cpu/mtrr/if.c  Jaswinder Singh Rajput 2009-07-04  325  
26dc67eda19beaf arch/x86/kernel/cpu/mtrr/if.c  Jaswinder Singh Rajput 2009-07-04  326  		g32 = (struct mtrr_gentry32 __user *)__arg;
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  327  		err = put_user(gentry.base, &g32->base);
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  328  		err |= put_user(gentry.size, &g32->size);
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  329  		err |= put_user(gentry.regnum, &g32->regnum);
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  330  		err |= put_user(gentry.type, &g32->type);
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  331  		break;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  332  	}
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  333  #endif
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  334  	}
c53117815771e1e arch/i386/kernel/cpu/mtrr/if.c Brian Gerst            2005-10-30  335  	return err;
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  336  }
^1da177e4c3f415 arch/i386/kernel/cpu/mtrr/if.c Linus Torvalds         2005-04-16  337  

:::::: The code at line 196 was first introduced by commit
:::::: c53117815771e1e84e6ba80a42fa1f8e330adb4d [PATCH] Clean up mtrr compat ioctl code

:::::: TO: Brian Gerst <bgerst@didntduck.org>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
