Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079D0488511
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiAHRnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:43:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:43859 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234837AbiAHRnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641663784; x=1673199784;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4LhS2nW7IgC9Pe0XvrqVAH3EhyDOv53MCZCFt6Sw1/A=;
  b=SBLR2JK7/rpXRBoiF54SrYJO+SLKx0b7G4N/g8y9uMfFKj0DIBUp5ret
   NaMXTcg4DN3DphAFm/wVDSSjyy6u4nRgaiAJKWVRzbqozw5mpOOJo8Gl2
   0vKpuO6CDSn4cQ6DdaCk9xxf7hKscEVCmHru4BOs6KVy9r8uXPvEgwwWq
   slcGQr0RxM1gF7aDMFn1AV8m+Pr1BGIQ9ngMCfFDNUFHDlmMbvm5XZwt6
   JTZI9Nc4tgi9bVgdxxrD4OtakpEWvR8x7RwwrdHy3sJPKWUwttPIojLae
   mPELhcPhZo5CfDGF6zL3Fa3ay2zQgwbq3B987qeHiH99Hvf8M8vsvWVKl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="303772571"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="303772571"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 09:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="514198392"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2022 09:43:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6Fk6-0000s4-5Y; Sat, 08 Jan 2022 17:43:02 +0000
Date:   Sun, 9 Jan 2022 01:42:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     xieliujie <xieliujie@oppo.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Todd Kjos <tkjos@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 4849/9999] xtensa-linux-ld: drivers/android/debug_symbols.o:undefined
 reference to `sysctl_legacy_va_layout'
Message-ID: <202201090118.WTyftXkY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   d5c19346d14b2bdccf8b127cdbcc36696539d6bb
commit: a2b3afb2f7437d3c84a5ebdeb2ff957deadaee57 [4849/9999] ANDROID: android: Add symbols to debug_symbols driver
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220109/202201090118.WTyftXkY-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/a2b3afb2f7437d3c84a5ebdeb2ff957deadaee57
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout a2b3afb2f7437d3c84a5ebdeb2ff957deadaee57
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
   `.exit.text' referenced in section `__jump_table' of drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.o: defined in discarded section `.exit.text' of drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.o
   `.exit.text' referenced in section `__jump_table' of drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.o: defined in discarded section `.exit.text' of drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.o
   `.exit.text' referenced in section `__jump_table' of drivers/misc/phantom.o: defined in discarded section `.exit.text' of drivers/misc/phantom.o
   `.exit.text' referenced in section `__jump_table' of drivers/misc/phantom.o: defined in discarded section `.exit.text' of drivers/misc/phantom.o
   `.exit.text' referenced in section `__jump_table' of drivers/misc/habanalabs/common/habanalabs_drv.o: defined in discarded section `.exit.text' of drivers/misc/habanalabs/common/habanalabs_drv.o
   `.exit.text' referenced in section `__jump_table' of drivers/misc/habanalabs/common/habanalabs_drv.o: defined in discarded section `.exit.text' of drivers/misc/habanalabs/common/habanalabs_drv.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/fcoe/fcoe.o: defined in discarded section `.exit.text' of drivers/scsi/fcoe/fcoe.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/fcoe/fcoe.o: defined in discarded section `.exit.text' of drivers/scsi/fcoe/fcoe.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/fcoe/fcoe.o: defined in discarded section `.exit.text' of drivers/scsi/fcoe/fcoe.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/fcoe/fcoe.o: defined in discarded section `.exit.text' of drivers/scsi/fcoe/fcoe.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/cxgbi/libcxgbi.o: defined in discarded section `.exit.text' of drivers/scsi/cxgbi/libcxgbi.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/cxgbi/libcxgbi.o: defined in discarded section `.exit.text' of drivers/scsi/cxgbi/libcxgbi.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/cxgbi/libcxgbi.o: defined in discarded section `.exit.text' of drivers/scsi/cxgbi/libcxgbi.o
   `.exit.text' referenced in section `__jump_table' of drivers/scsi/cxgbi/libcxgbi.o: defined in discarded section `.exit.text' of drivers/scsi/cxgbi/libcxgbi.o
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
>> xtensa-linux-ld: drivers/android/debug_symbols.o:(.rodata+0x50c): undefined reference to `sysctl_legacy_va_layout'
   `.exit.text' referenced in section `__jump_table' of net/netfilter/nf_conntrack_h323_main.o: defined in discarded section `.exit.text' of net/netfilter/nf_conntrack_h323_main.o
   `.exit.text' referenced in section `__jump_table' of net/netfilter/nf_conntrack_h323_main.o: defined in discarded section `.exit.text' of net/netfilter/nf_conntrack_h323_main.o
   `.exit.text' referenced in section `__jump_table' of net/netfilter/ipset/ip_set_core.o: defined in discarded section `.exit.text' of net/netfilter/ipset/ip_set_core.o
   `.exit.text' referenced in section `__jump_table' of net/netfilter/ipset/ip_set_core.o: defined in discarded section `.exit.text' of net/netfilter/ipset/ip_set_core.o
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
