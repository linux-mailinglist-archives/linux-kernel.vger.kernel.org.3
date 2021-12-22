Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7449647D70D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbhLVSmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:42:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:54895 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233997AbhLVSmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640198521; x=1671734521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y1lXxmyRRXiX9y2S1oTr0G0C+5LVXOfjWd2EIylKh2U=;
  b=bGd2ngPe4Ds6VU8xF50JQyi99QNaMN9OpIeOMtM7xJJDBxMV61rXp3Mr
   ZeL0y2XixYFmQzUlLc56Vx2qU6heyJG9F0TOR9ffBqQ7zfydMTz4GvlBP
   eYbEx7EH0TaljnAJsWpDXqkiVsKdXbDuILMWCkvNMpBkKWNEaY7RXPTvp
   Egq4hy7onU+hKM5fuRmA3DKCR5NVl1xtjiXra3DnfIU8izsRpSN0iqWtO
   CFinljO1qy1VptNc/G84hMs8pfRekCTkzhFb6/ZzTgKgIIAGz51hJR5aV
   B0enPXxAVrZnfBrcIXu/imV2DYOLnUmXq352EQzXhd2GGQl1Syx5ZmM0e
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="264890704"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="264890704"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 10:42:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="466761842"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2021 10:41:59 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n06Yo-0000qw-Of; Wed, 22 Dec 2021 18:41:58 +0000
Date:   Thu, 23 Dec 2021 02:41:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:nvme/dev 18/18] apple.c:undefined reference to
 `devm_apple_rtkit_init'
Message-ID: <202112230249.4pCuDsHz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme/dev
head:   95d74d28463059dbd4d9cf8e62a2ea0a71d15d06
commit: 95d74d28463059dbd4d9cf8e62a2ea0a71d15d06 [18/18] WIP: nvme-apple: add initial Apple SoC NVMe driver
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20211223/202112230249.4pCuDsHz-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/95d74d28463059dbd4d9cf8e62a2ea0a71d15d06
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme/dev
        git checkout 95d74d28463059dbd4d9cf8e62a2ea0a71d15d06
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   `.exit.text' referenced in section `__jump_table' of fs/cifs/cifsfs.o: defined in discarded section `.exit.text' of fs/cifs/cifsfs.o
   `.exit.text' referenced in section `__jump_table' of fs/cifs/cifsfs.o: defined in discarded section `.exit.text' of fs/cifs/cifsfs.o
   `.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o: defined in discarded section `.exit.text' of fs/fuse/inode.o
   `.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o: defined in discarded section `.exit.text' of fs/fuse/inode.o
   `.exit.text' referenced in section `__jump_table' of fs/ceph/super.o: defined in discarded section `.exit.text' of fs/ceph/super.o
   `.exit.text' referenced in section `__jump_table' of fs/ceph/super.o: defined in discarded section `.exit.text' of fs/ceph/super.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/rio_cm.o: defined in discarded section `.exit.text' of drivers/rapidio/rio_cm.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/rio_cm.o: defined in discarded section `.exit.text' of drivers/rapidio/rio_cm.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen2.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen2.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen2.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen2.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen2.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen2.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen2.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen2.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen3.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen3.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen3.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen3.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen3.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen3.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen3.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen3.o
   `.exit.text' referenced in section `__jump_table' of drivers/video/fbdev/vt8623fb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/vt8623fb.o
   `.exit.text' referenced in section `__jump_table' of drivers/video/fbdev/vt8623fb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/vt8623fb.o
   `.exit.text' referenced in section `__jump_table' of drivers/video/fbdev/s3fb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/s3fb.o
   `.exit.text' referenced in section `__jump_table' of drivers/video/fbdev/s3fb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/s3fb.o
   `.exit.text' referenced in section `__jump_table' of drivers/video/fbdev/arkfb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/arkfb.o
   `.exit.text' referenced in section `__jump_table' of drivers/video/fbdev/arkfb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/arkfb.o
   `.exit.text' referenced in section `__jump_table' of drivers/misc/phantom.o: defined in discarded section `.exit.text' of drivers/misc/phantom.o
   `.exit.text' referenced in section `__jump_table' of drivers/misc/phantom.o: defined in discarded section `.exit.text' of drivers/misc/phantom.o
   `.exit.text' referenced in section `__jump_table' of drivers/misc/habanalabs/common/habanalabs_drv.o: defined in discarded section `.exit.text' of drivers/misc/habanalabs/common/habanalabs_drv.o
   `.exit.text' referenced in section `__jump_table' of drivers/misc/habanalabs/common/habanalabs_drv.o: defined in discarded section `.exit.text' of drivers/misc/habanalabs/common/habanalabs_drv.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/fcoe/fcoe.o: defined in discarded section `.exit.text' of drivers/scsi/fcoe/fcoe.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/fcoe/fcoe.o: defined in discarded section `.exit.text' of drivers/scsi/fcoe/fcoe.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/cxgbi/libcxgbi.o: defined in discarded section `.exit.text' of drivers/scsi/cxgbi/libcxgbi.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/cxgbi/libcxgbi.o: defined in discarded section `.exit.text' of drivers/scsi/cxgbi/libcxgbi.o
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_get_address':
   apple.c:(.text+0x7c8): undefined reference to `apple_sart_remove_allowed_region'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_free':
   apple.c:(.text+0x7ef): undefined reference to `apple_sart_remove_allowed_region'
   xtensa-linux-ld: apple.c:(.text+0x854): undefined reference to `apple_sart_add_allowed_region'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_alloc':
   apple.c:(.text+0x8ae): undefined reference to `apple_sart_add_allowed_region'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reg_read64':
   apple.c:(.text+0x1c44): undefined reference to `apple_sart_get'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
   apple.c:(.text+0x1eae): undefined reference to `apple_sart_get'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reg_read64':
>> apple.c:(.text+0x1cdc): undefined reference to `devm_apple_rtkit_init'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
   apple.c:(.text+0x212c): undefined reference to `devm_apple_rtkit_init'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_irq':
   apple.c:(.text+0x2bd0): undefined reference to `apple_rtkit_is_crashed'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
   apple.c:(.text+0x2cdf): undefined reference to `apple_rtkit_is_crashed'
   xtensa-linux-ld: apple.c:(.text+0x2f8c): undefined reference to `apple_rtkit_is_running'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
   apple.c:(.text+0x2fca): undefined reference to `apple_rtkit_is_running'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
>> apple.c:(.text+0x2f94): undefined reference to `apple_rtkit_shutdown'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
   apple.c:(.text+0x2fdc): undefined reference to `apple_rtkit_shutdown'
   xtensa-linux-ld: apple.c:(.text+0x3020): undefined reference to `apple_rtkit_is_running'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   apple.c:(.text+0x308e): undefined reference to `apple_rtkit_is_running'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
   apple.c:(.text+0x3028): undefined reference to `apple_rtkit_shutdown'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   apple.c:(.text+0x30a0): undefined reference to `apple_rtkit_shutdown'
   xtensa-linux-ld: apple.c:(.text+0x31d4): undefined reference to `apple_rtkit_is_crashed'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   apple.c:(.text+0x348c): undefined reference to `apple_rtkit_is_crashed'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   apple.c:(.text+0x31e8): undefined reference to `apple_rtkit_is_running'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   apple.c:(.text+0x34e3): undefined reference to `apple_rtkit_is_running'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   apple.c:(.text+0x320c): undefined reference to `apple_rtkit_shutdown'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   apple.c:(.text+0x3577): undefined reference to `apple_rtkit_shutdown'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   apple.c:(.text+0x3214): undefined reference to `apple_rtkit_reinit'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   apple.c:(.text+0x3595): undefined reference to `apple_rtkit_reinit'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
>> apple.c:(.text+0x3230): undefined reference to `apple_rtkit_boot'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   apple.c:(.text+0x35f4): undefined reference to `apple_rtkit_boot'
   xtensa-linux-ld: apple.c:(.text+0x3e74): undefined reference to `apple_rtkit_is_crashed'
   xtensa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_timeout':
   apple.c:(.text+0x3fcc): undefined reference to `apple_rtkit_is_crashed'
   `.exit.text' referenced in section `__jump_table' of drivers/target/target_core_configfs.o: defined in discarded section `.exit.text' of drivers/target/target_core_configfs.o
   `.exit.text' referenced in section `__jump_table' of drivers/target/target_core_configfs.o: defined in discarded section `.exit.text' of drivers/target/target_core_configfs.o
   `.exit.text' referenced in section `__jump_table' of drivers/mtd/maps/pcmciamtd.o: defined in discarded section `.exit.text' of drivers/mtd/maps/pcmciamtd.o
   `.exit.text' referenced in section `__jump_table' of drivers/mtd/maps/pcmciamtd.o: defined in discarded section `.exit.text' of drivers/mtd/maps/pcmciamtd.o
   `.exit.text' referenced in section `__jump_table' of drivers/net/wireless/zydas/zd1211rw/zd_usb.o: defined in discarded section `.exit.text' of drivers/net/wireless/zydas/zd1211rw/zd_usb.o
   `.exit.text' referenced in section `__jump_table' of drivers/net/wireless/zydas/zd1211rw/zd_usb.o: defined in discarded section `.exit.text' of drivers/net/wireless/zydas/zd1211rw/zd_usb.o
   `.exit.text' referenced in section `__jump_table' of drivers/net/wireless/ray_cs.o: defined in discarded section `.exit.text' of drivers/net/wireless/ray_cs.o
   `.exit.text' referenced in section `__jump_table' of drivers/net/wireless/ray_cs.o: defined in discarded section `.exit.text' of drivers/net/wireless/ray_cs.o
   `.exit.text' referenced in section `__jump_table' of drivers/net/wireless/mac80211_hwsim.o: defined in discarded section `.exit.text' of drivers/net/wireless/mac80211_hwsim.o
   `.exit.text' referenced in section `__jump_table' of drivers/net/wireless/mac80211_hwsim.o: defined in discarded section `.exit.text' of drivers/net/wireless/mac80211_hwsim.o
   `.exit.text' referenced in section `__jump_table' of drivers/usb/gadget/legacy/inode.o: defined in discarded section `.exit.text' of drivers/usb/gadget/legacy/inode.o
   `.exit.text' referenced in section `__jump_table' of drivers/usb/gadget/legacy/inode.o: defined in discarded section `.exit.text' of drivers/usb/gadget/legacy/inode.o
   `.exit.text' referenced in section `__jump_table' of drivers/usb/gadget/legacy/g_ffs.o: defined in discarded section `.exit.text' of drivers/usb/gadget/legacy/g_ffs.o
   `.exit.text' referenced in section `__jump_table' of drivers/usb/gadget/legacy/g_ffs.o: defined in discarded section `.exit.text' of drivers/usb/gadget/legacy/g_ffs.o
   `.exit.text' referenced in section `__jump_table' of drivers/media/common/siano/smscoreapi.o: defined in discarded section `.exit.text' of drivers/media/common/siano/smscoreapi.o
   `.exit.text' referenced in section `__jump_table' of drivers/media/common/siano/smscoreapi.o: defined in discarded section `.exit.text' of drivers/media/common/siano/smscoreapi.o
   `.exit.text' referenced in section `__jump_table' of drivers/vme/bridges/vme_fake.o: defined in discarded section `.exit.text' of drivers/vme/bridges/vme_fake.o
   `.exit.text' referenced in section `__jump_table' of drivers/vme/bridges/vme_fake.o: defined in discarded section `.exit.text' of drivers/vme/bridges/vme_fake.o
   `.exit.text' referenced in section `__jump_table' of net/netfilter/nf_conntrack_h323_main.o: defined in discarded section `.exit.text' of net/netfilter/nf_conntrack_h323_main.o
   `.exit.text' referenced in section `__jump_table' of net/netfilter/nf_conntrack_h323_main.o: defined in discarded section `.exit.text' of net/netfilter/nf_conntrack_h323_main.o
   `.exit.text' referenced in section `__jump_table' of net/netfilter/ipset/ip_set_core.o: defined in discarded section `.exit.text' of net/netfilter/ipset/ip_set_core.o
   `.exit.text' referenced in section `__jump_table' of net/netfilter/ipset/ip_set_core.o: defined in discarded section `.exit.text' of net/netfilter/ipset/ip_set_core.o
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
