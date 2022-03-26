Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33394E8035
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 10:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiCZJyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 05:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiCZJyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 05:54:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F6CDBD1F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 02:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648288392; x=1679824392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RC/ESacicPywX2KFEkD6jYIPwu1sanOiS6NhBr4WtfQ=;
  b=TI94eYA9zgH3YMZv6/IZ5TVVdwE6RDD8+c0Ilz22O50zCaaak5JQm5Q4
   9Zu4CPn3Kh7u/wOw45Ts/1PiWhhnhkUsMvW0BJB1fFbaGphU6ht9HZutQ
   ChvAEyV/Ssu2C4y53lbtgVrvJVt+Gk/GRArm5GvZngfHGMI+H+gdSarUf
   UhseyiAoZwdBnBY8XepXYpZ1+LePwGiDGwuRBdH2Z9cQuToPconEKbJv1
   NJl99dcsdqMkzDr7u+imyTzSYgwv/Pr11uo6Cv/PLCSHaWVFuDp2Q7sw8
   0zfDZI1A9jJmsSA1r8MT4jyMN9cbYGjtLX08N0lOge7C9WCHWsX668x+K
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="257601806"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="257601806"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 02:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="693906603"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2022 02:53:10 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY36c-000NFu-1k; Sat, 26 Mar 2022 09:53:10 +0000
Date:   Sat, 26 Mar 2022 17:52:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 30/30]
 drivers/scsi/ufs-core/ufshcd-priv.h:32:20: error: redefinition of
 'ufs_hwmon_probe'
Message-ID: <202203261702.CNhXkyrF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   0887a8d6392738ee048acd84471bf8c5c860fdab
commit: 0887a8d6392738ee048acd84471bf8c5c860fdab [30/30] scsi: ufs: Split the drivers/scsi/ufs directory
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220326/202203261702.CNhXkyrF-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/0887a8d6392738ee048acd84471bf8c5c860fdab
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next
        git checkout 0887a8d6392738ee048acd84471bf8c5c860fdab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/ufs-core/ufshcd.c:36:
   In file included from drivers/scsi/ufs-core/ufshcd-crypto.h:12:
>> drivers/scsi/ufs-core/ufshcd-priv.h:32:20: error: redefinition of 'ufs_hwmon_probe'
   static inline void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask) {}
                      ^
   include/scsi/ufshcd.h:1081:20: note: previous definition is here
   static inline void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask) {}
                      ^
   In file included from drivers/scsi/ufs-core/ufshcd.c:36:
   In file included from drivers/scsi/ufs-core/ufshcd-crypto.h:12:
>> drivers/scsi/ufs-core/ufshcd-priv.h:33:20: error: redefinition of 'ufs_hwmon_remove'
   static inline void ufs_hwmon_remove(struct ufs_hba *hba) {}
                      ^
   include/scsi/ufshcd.h:1082:20: note: previous definition is here
   static inline void ufs_hwmon_remove(struct ufs_hba *hba) {}
                      ^
   In file included from drivers/scsi/ufs-core/ufshcd.c:36:
   In file included from drivers/scsi/ufs-core/ufshcd-crypto.h:12:
>> drivers/scsi/ufs-core/ufshcd-priv.h:34:20: error: redefinition of 'ufs_hwmon_notify_event'
   static inline void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask) {}
                      ^
   include/scsi/ufshcd.h:1083:20: note: previous definition is here
   static inline void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask) {}
                      ^
   drivers/scsi/ufs-core/ufshcd.c:9494:44: warning: shift count >= width of type [-Wshift-count-overflow]
                   if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
                                                            ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 3 errors generated.
--
   In file included from drivers/scsi/ufs-core/ufs-sysfs.c:10:
>> drivers/scsi/ufs-core/ufshcd-priv.h:32:20: error: redefinition of 'ufs_hwmon_probe'
   static inline void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask) {}
                      ^
   include/scsi/ufshcd.h:1081:20: note: previous definition is here
   static inline void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask) {}
                      ^
   In file included from drivers/scsi/ufs-core/ufs-sysfs.c:10:
>> drivers/scsi/ufs-core/ufshcd-priv.h:33:20: error: redefinition of 'ufs_hwmon_remove'
   static inline void ufs_hwmon_remove(struct ufs_hba *hba) {}
                      ^
   include/scsi/ufshcd.h:1082:20: note: previous definition is here
   static inline void ufs_hwmon_remove(struct ufs_hba *hba) {}
                      ^
   In file included from drivers/scsi/ufs-core/ufs-sysfs.c:10:
>> drivers/scsi/ufs-core/ufshcd-priv.h:34:20: error: redefinition of 'ufs_hwmon_notify_event'
   static inline void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask) {}
                      ^
   include/scsi/ufshcd.h:1083:20: note: previous definition is here
   static inline void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask) {}
                      ^
   3 errors generated.


vim +/ufs_hwmon_probe +32 drivers/scsi/ufs-core/ufshcd-priv.h

25d1c9ae8f23a80 drivers/scsi/ufs/ufshcd-priv.h Bart Van Assche 2022-03-21  26  
25d1c9ae8f23a80 drivers/scsi/ufs/ufshcd-priv.h Bart Van Assche 2022-03-21  27  #ifdef CONFIG_SCSI_UFS_HWMON
25d1c9ae8f23a80 drivers/scsi/ufs/ufshcd-priv.h Bart Van Assche 2022-03-21  28  void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask);
25d1c9ae8f23a80 drivers/scsi/ufs/ufshcd-priv.h Bart Van Assche 2022-03-21  29  void ufs_hwmon_remove(struct ufs_hba *hba);
25d1c9ae8f23a80 drivers/scsi/ufs/ufshcd-priv.h Bart Van Assche 2022-03-21  30  void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask);
25d1c9ae8f23a80 drivers/scsi/ufs/ufshcd-priv.h Bart Van Assche 2022-03-21  31  #else
25d1c9ae8f23a80 drivers/scsi/ufs/ufshcd-priv.h Bart Van Assche 2022-03-21 @32  static inline void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask) {}
25d1c9ae8f23a80 drivers/scsi/ufs/ufshcd-priv.h Bart Van Assche 2022-03-21 @33  static inline void ufs_hwmon_remove(struct ufs_hba *hba) {}
25d1c9ae8f23a80 drivers/scsi/ufs/ufshcd-priv.h Bart Van Assche 2022-03-21 @34  static inline void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask) {}
25d1c9ae8f23a80 drivers/scsi/ufs/ufshcd-priv.h Bart Van Assche 2022-03-21  35  #endif
25d1c9ae8f23a80 drivers/scsi/ufs/ufshcd-priv.h Bart Van Assche 2022-03-21  36  

:::::: The code at line 32 was first introduced by commit
:::::: 25d1c9ae8f23a80278721a9b66383128a51af746 scsi: ufs: Split the ufshcd.h header file

:::::: TO: Bart Van Assche <bvanassche@acm.org>
:::::: CC: Bart Van Assche <bvanassche@acm.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
