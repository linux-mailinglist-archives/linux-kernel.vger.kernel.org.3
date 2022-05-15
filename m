Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74752751C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 05:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiEODQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 23:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiEODQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 23:16:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8216348
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 20:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652584561; x=1684120561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g1DSQ1zyN816go7DcJKHybUfpIuljXI0j4GyED+EeOM=;
  b=MLHBjxOUMxqKdAwP1lv+OwW4zR1IIB5UESJ7YFQGsOpVQKQ+882A4XFo
   LZ3+DKdiYpRl2XzCCaz8SOaYKl+kH6yxtR8qqMvyzAvYggO0MMKIgcedA
   k/V5hG1VUuNGRysoz6LBiXHykEVYbMTducskTHxUKoyzxkDggET3Cti1l
   iX9WA8mYKdTGznJoOKCewJ1yHBMY5VCeZ67HczProdtIqgVeOa7jjBZrv
   Cmq69PSq/CGh8XakuqohzE2ISgV+vCpA+iSJJkLVt4dzD6rJIhxSSnJyX
   U//+U6mBXS1rL+NAiDcGILjBGmiAA7CeJIfrMNaEhDU9olWo49PXAbDdB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="331195831"
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="331195831"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 20:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="604356111"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 May 2022 20:15:56 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nq4jb-0001FF-Fc;
        Sun, 15 May 2022 03:15:55 +0000
Date:   Sun, 15 May 2022 11:14:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-5.18-kprobes 46/46] xtensa-linux-ld:
 arch/xtensa/kernel/kprobes.o:undefined reference to `xtensa_modules'
Message-ID: <202205151157.FM7NjwSY-lkp@intel.com>
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

Hi Max,

First bad commit (maybe != root cause):

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-5.18-kprobes
head:   8d9b04fec534d588aeb00d6003276eebf2eb73e0
commit: 8d9b04fec534d588aeb00d6003276eebf2eb73e0 [46/46] WIP: xtensa: implement kprobes
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220515/202205151157.FM7NjwSY-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/8d9b04fec534d588aeb00d6003276eebf2eb73e0
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-5.18-kprobes
        git checkout 8d9b04fec534d588aeb00d6003276eebf2eb73e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

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
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o
   `.exit.text' referenced in section `__jump_table' of net/netfilter/nf_conntrack_h323_main.o: defined in discarded section `.exit.text' of net/netfilter/nf_conntrack_h323_main.o
   `.exit.text' referenced in section `__jump_table' of net/netfilter/nf_conntrack_h323_main.o: defined in discarded section `.exit.text' of net/netfilter/nf_conntrack_h323_main.o
   `.exit.text' referenced in section `__jump_table' of net/netfilter/ipset/ip_set_core.o: defined in discarded section `.exit.text' of net/netfilter/ipset/ip_set_core.o
   `.exit.text' referenced in section `__jump_table' of net/netfilter/ipset/ip_set_core.o: defined in discarded section `.exit.text' of net/netfilter/ipset/ip_set_core.o
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o
>> xtensa-linux-ld: arch/xtensa/kernel/kprobes.o:(.init.literal+0x1c): undefined reference to `xtensa_modules'
--
   arch/xtensa/kernel/traps.c: In function 'do_debug':
>> arch/xtensa/kernel/traps.c:405:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     405 |         void kprobe_handler(struct pt_regs *regs);
         |         ^~~~
   arch/xtensa/kernel/traps.c: At top level:
   arch/xtensa/kernel/traps.c:465:13: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
     465 | void __init trap_init(void)
         |             ^~~~~~~~~
--
>> arch/xtensa/kernel/kprobes.c:76:16: warning: no previous prototype for 'kprobe_handler' [-Wmissing-prototypes]
      76 | void __kprobes kprobe_handler(struct pt_regs *regs)
         |                ^~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
