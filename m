Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC2468A7E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhLELf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 06:35:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:33686 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233191AbhLELf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 06:35:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="300563645"
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="300563645"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 03:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="461504198"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Dec 2021 03:32:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtpkp-000K5p-4f; Sun, 05 Dec 2021 11:32:27 +0000
Date:   Sun, 5 Dec 2021 19:31:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/interconnect/qcom/icc-rpmh.c:166:28: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202112051921.ZzJnG6CY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79a72162048e42a677bc7336a9f5d86fc3ff9558
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   7 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211205/202112051921.ZzJnG6CY-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d991bb1c8da842a2a0b9dc83b1005e655783f861
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d991bb1c8da842a2a0b9dc83b1005e655783f861
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/ drivers/gpu/drm/msm/ drivers/gpu/drm/tegra/ drivers/interconnect/qcom/ drivers/net/vmxnet3/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/remoteproc/ drivers/scsi/bnx2fc/ drivers/scsi/lpfc/ drivers/staging/ fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/interconnect/qcom/icc-rpmh.c:166:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] unit @@     got unsigned int [usertype] @@
   drivers/interconnect/qcom/icc-rpmh.c:166:28: sparse:     expected restricted __le32 [usertype] unit
   drivers/interconnect/qcom/icc-rpmh.c:166:28: sparse:     got unsigned int [usertype]
>> drivers/interconnect/qcom/icc-rpmh.c:167:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] width @@     got unsigned short [usertype] @@
   drivers/interconnect/qcom/icc-rpmh.c:167:29: sparse:     expected restricted __le16 [usertype] width
   drivers/interconnect/qcom/icc-rpmh.c:167:29: sparse:     got unsigned short [usertype]
--
>> drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] addr @@     got unsigned long long [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse:     expected restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse:     got unsigned long long [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse:     expected unsigned int [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:1248:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got restricted __be16 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1248:43: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/vmxnet3/vmxnet3_drv.c:1248:43: sparse:     got restricted __be16 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:1390:17: sparse: sparse: restricted __le64 degrades to integer
   drivers/net/vmxnet3/vmxnet3_drv.c:1661:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le64 [usertype] addr @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1661:33: sparse:     expected unsigned int [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1661:33: sparse:     got restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1667:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le64 [usertype] addr @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1667:33: sparse:     expected unsigned int [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1667:33: sparse:     got restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:2289:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2289:31: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2289:31: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2306:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2306:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2306:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2328:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2328:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2328:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2380:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2380:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2380:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2426:31: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/vmxnet3/vmxnet3_drv.c:2439:17: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le16 [usertype] mfTableLen @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2439:17: sparse:     expected unsigned int [usertype] size
   drivers/net/vmxnet3/vmxnet3_drv.c:2439:17: sparse:     got restricted __le16 [usertype] mfTableLen
   drivers/net/vmxnet3/vmxnet3_drv.c:2476:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2476:49: sparse:     expected unsigned int [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2476:49: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2517:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] txDataRingDescSize @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2517:41: sparse:     expected restricted __le16 [usertype] txDataRingDescSize
   drivers/net/vmxnet3/vmxnet3_drv.c:2517:41: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2566:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] confVer @@     got int @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2566:46: sparse:     expected restricted __le32 [usertype] confVer
   drivers/net/vmxnet3/vmxnet3_drv.c:2566:46: sparse:     got int
   drivers/net/vmxnet3/vmxnet3_drv.c:2603:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] confVer @@     got int @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2603:34: sparse:     expected restricted __le32 [usertype] confVer
   drivers/net/vmxnet3/vmxnet3_drv.c:2603:34: sparse:     got int
--
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:470:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_id @@     got unsigned int [usertype] fcoe_conn_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:470:29: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:470:29: sparse:     got unsigned int [usertype] fcoe_conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:504:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] context_id @@     got unsigned int [usertype] context_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:504:32: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] context_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:504:32: sparse:     got unsigned int [usertype] context_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_id @@     got unsigned int [usertype] fcoe_conn_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse:     got unsigned int [usertype] fcoe_conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] fr_crc @@     got restricted __le32 [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse:     expected unsigned int [usertype] fr_crc
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:695:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] xid @@     got restricted __le16 [usertype] ox_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:695:21: sparse:     expected unsigned short [usertype] xid
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:695:21: sparse:     got restricted __le16 [usertype] ox_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:727:27: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:728:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:807:23: sparse: sparse: cast from restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:807:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] xid @@     got restricted __be16 [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:807:21: sparse:     expected unsigned short [usertype] xid
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:807:21: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:821:27: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:822:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:886:45: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:963:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] doorbell_cq_cons @@     got int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:963:33: sparse:     expected restricted __le16 [usertype] doorbell_cq_cons
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:963:33: sparse:     got int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:966:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1019:43: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1089:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] wqe @@     got restricted __le16 [usertype] wqe @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1089:22: sparse:     expected unsigned short [usertype] wqe
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1089:22: sparse:     got restricted __le16 [usertype] wqe
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1253:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] conn_id @@     got restricted __le32 [usertype] fcoe_conn_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1253:17: sparse:     expected unsigned int [usertype] conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1253:17: sparse:     got restricted __le32 [usertype] fcoe_conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1369:53: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] err_code @@     got restricted __le32 [usertype] completion_status @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1369:53: sparse:     expected unsigned int [usertype] err_code
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1369:53: sparse:     got restricted __le32 [usertype] completion_status
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1420:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] wqe @@     got int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1420:18: sparse:     expected restricted __le16 [usertype] wqe
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1420:18: sparse:     got int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1421:18: sparse: sparse: invalid assignment: |=
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1421:18: sparse:    left side has type restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1421:18: sparse:    right side has type int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1439:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1522:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] init_flags @@     got unsigned int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1522:46: sparse:     expected restricted __le32 [usertype] init_flags
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1522:46: sparse:     got unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1524:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] init_flags @@     got unsigned int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1524:46: sparse:     expected restricted __le32 [usertype] init_flags
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1524:46: sparse:     got unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1527:63: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cleaned_task_id @@     got unsigned short [usertype] orig_xid @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1527:63: sparse:     expected restricted __le16 [usertype] cleaned_task_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1527:63: sparse:     got unsigned short [usertype] orig_xid
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1530:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] rolled_tx_data_offset @@     got unsigned int [usertype] offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1530:69: sparse:     expected restricted __le32 [usertype] rolled_tx_data_offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1530:69: sparse:     got unsigned int [usertype] offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1536:35: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1538:24: sparse: sparse: invalid assignment: -=
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1538:24: sparse:    left side has type unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1538:24: sparse:    right side has type restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1543:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1543:69: sparse:     expected restricted __le32 [usertype] lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1543:69: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1545:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1545:69: sparse:     expected restricted __le32 [usertype] hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1545:69: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1549:65: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cur_sge_off @@     got unsigned int [usertype] offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1549:65: sparse:     expected restricted __le16 [usertype] cur_sge_off
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1549:65: sparse:     got unsigned int [usertype] offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1556:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1556:46: sparse:     expected restricted __le32 [usertype] lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1556:46: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1557:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1557:46: sparse:     expected restricted __le32 [usertype] hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1557:46: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1559:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cur_sge_off @@     got unsigned int [usertype] offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1559:42: sparse:     expected restricted __le16 [usertype] cur_sge_off
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1559:42: sparse:     got unsigned int [usertype] offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1564:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] low_exp_ro @@     got unsigned int [usertype] orig_offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1564:55: sparse:     expected restricted __le32 [usertype] low_exp_ro
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1564:55: sparse:     got unsigned int [usertype] orig_offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1565:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] high_exp_ro @@     got unsigned int [usertype] orig_offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1565:56: sparse:     expected restricted __le32 [usertype] high_exp_ro
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1565:56: sparse:     got unsigned int [usertype] orig_offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1592:63: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cleaned_task_id @@     got unsigned short [usertype] orig_xid @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1592:63: sparse:     expected restricted __le16 [usertype] cleaned_task_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1592:63: sparse:     got unsigned short [usertype] orig_xid
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1600:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] init_flags @@     got unsigned int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1600:46: sparse:     expected restricted __le32 [usertype] init_flags
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1600:46: sparse:     got unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1602:42: sparse: sparse: invalid assignment: |=
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1602:42: sparse:    left side has type restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1602:42: sparse:    right side has type int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1638:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1638:69: sparse:     expected restricted __le32 [usertype] lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1638:69: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1640:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1640:69: sparse:     expected restricted __le32 [usertype] hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1640:69: sparse:     got unsigned int [usertype]
>> drivers/scsi/bnx2fc/bnx2fc_hwi.c:1665:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] data_2_trns @@     got unsigned int [usertype] data_xfer_len @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1665:47: sparse:     expected restricted __le32 [usertype] data_2_trns
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1665:47: sparse:     got unsigned int [usertype] data_xfer_len
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1668:42: sparse: sparse: invalid assignment: |=
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1668:42: sparse:    left side has type restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1668:42: sparse:    right side has type int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1672:46: sparse: sparse: too many warnings
--
   drivers/scsi/lpfc/lpfc_scsi.c:129:30: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:131:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:131:28: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:131:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:399:35: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:400:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:403:32: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:406:35: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:407:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:410:32: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:695:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:695:22: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:695:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:696:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:696:22: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:696:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:697:22: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:699:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:699:20: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:699:20: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:700:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:700:22: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:700:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:705:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:705:22: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:705:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:706:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:706:22: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:706:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:707:22: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:709:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:709:20: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:709:20: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:710:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:710:22: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:710:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:825:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:825:39: sparse:     expected unsigned int [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:825:39: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:913:46: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:915:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:917:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:958:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] fcpDl @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:958:25: sparse:     expected unsigned int [usertype] fcpDl
   drivers/scsi/lpfc/lpfc_scsi.c:958:25: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1092:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] prot_data @@     got restricted __be32 [usertype] ref_tag @@
   drivers/scsi/lpfc/lpfc_scsi.c:1092:69: sparse:     expected unsigned int [usertype] prot_data
   drivers/scsi/lpfc/lpfc_scsi.c:1092:69: sparse:     got restricted __be32 [usertype] ref_tag
   drivers/scsi/lpfc/lpfc_scsi.c:1213:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] prot_data @@     got restricted __be16 [usertype] app_tag @@
   drivers/scsi/lpfc/lpfc_scsi.c:1213:69: sparse:     expected unsigned int [usertype] prot_data
   drivers/scsi/lpfc/lpfc_scsi.c:1213:69: sparse:     got restricted __be16 [usertype] app_tag
   drivers/scsi/lpfc/lpfc_scsi.c:1616:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word0 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1616:21: sparse:     expected unsigned int [usertype] word0
   drivers/scsi/lpfc/lpfc_scsi.c:1616:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1617:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] reftag @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1617:22: sparse:     expected unsigned int [usertype] reftag
   drivers/scsi/lpfc/lpfc_scsi.c:1617:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1650:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word0 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1650:21: sparse:     expected unsigned int [usertype] word0
   drivers/scsi/lpfc/lpfc_scsi.c:1650:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1651:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word1 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1651:21: sparse:     expected unsigned int [usertype] word1
   drivers/scsi/lpfc/lpfc_scsi.c:1651:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1652:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1652:21: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:1652:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1661:32: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1662:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1668:30: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1785:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word0 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1785:29: sparse:     expected unsigned int [usertype] word0
   drivers/scsi/lpfc/lpfc_scsi.c:1785:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1786:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] reftag @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1786:30: sparse:     expected unsigned int [usertype] reftag
   drivers/scsi/lpfc/lpfc_scsi.c:1786:30: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1814:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word0 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1814:29: sparse:     expected unsigned int [usertype] word0
   drivers/scsi/lpfc/lpfc_scsi.c:1814:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1815:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word1 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1815:29: sparse:     expected unsigned int [usertype] word1
   drivers/scsi/lpfc/lpfc_scsi.c:1815:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1816:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1816:29: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:1816:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1833:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1834:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1868:40: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1869:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1892:38: sparse: sparse: cast to restricted __le32
>> drivers/scsi/lpfc/lpfc_scsi.c:2010:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ref_tag @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2010:25: sparse:     expected unsigned int [usertype] ref_tag
   drivers/scsi/lpfc/lpfc_scsi.c:2010:25: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2037:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2037:23: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:2037:23: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/lpfc/lpfc_scsi.c:2038:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word3 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2038:23: sparse:     expected unsigned int [usertype] word3
   drivers/scsi/lpfc/lpfc_scsi.c:2038:23: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2063:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2063:38: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:2063:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2065:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2065:38: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:2065:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2077:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2077:38: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:2077:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2078:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2078:38: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:2078:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2081:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2081:36: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:2081:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2082:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2082:38: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:2082:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2092:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2092:36: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:2092:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2093:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2093:38: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:2093:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2226:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2226:46: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:2226:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2228:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2228:46: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:2228:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2232:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2232:36: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:2232:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2233:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2233:38: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:2233:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2245:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ref_tag @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2245:33: sparse:     expected unsigned int [usertype] ref_tag
   drivers/scsi/lpfc/lpfc_scsi.c:2245:33: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2280:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2280:31: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:2280:31: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2281:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word3 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2281:31: sparse:     expected unsigned int [usertype] word3
   drivers/scsi/lpfc/lpfc_scsi.c:2281:31: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2299:32: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:2300:32: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:2301:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2301:28: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:2301:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2353:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2353:54: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:2353:54: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2355:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2355:54: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:2355:54: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2359:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2359:44: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:2359:44: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2360:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2360:46: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:2360:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2389:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2389:46: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:2389:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2391:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2391:46: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:2391:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2398:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2398:46: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:2398:46: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/lpfc/lpfc_scsi.c:2663:27: sparse: sparse: cast to restricted __be32
>> drivers/scsi/lpfc/lpfc_scsi.c:2712:11: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] x @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2712:11: sparse:     expected unsigned short [usertype] x
   drivers/scsi/lpfc/lpfc_scsi.c:2712:11: sparse:     got restricted __be16 [usertype]
>> drivers/scsi/lpfc/lpfc_scsi.c:2726:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] ret @@     got restricted __sum16 @@
   drivers/scsi/lpfc/lpfc_scsi.c:2726:13: sparse:     expected unsigned short [usertype] ret
   drivers/scsi/lpfc/lpfc_scsi.c:2726:13: sparse:     got restricted __sum16
>> drivers/scsi/lpfc/lpfc_scsi.c:2788:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] start_app_tag @@     got restricted __be16 [usertype] app_tag @@
   drivers/scsi/lpfc/lpfc_scsi.c:2788:31: sparse:     expected unsigned short [usertype] start_app_tag
   drivers/scsi/lpfc/lpfc_scsi.c:2788:31: sparse:     got restricted __be16 [usertype] app_tag
>> drivers/scsi/lpfc/lpfc_scsi.c:2805:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] guard_tag @@     got restricted __be16 [usertype] guard_tag @@
   drivers/scsi/lpfc/lpfc_scsi.c:2805:51: sparse:     expected unsigned short [assigned] [usertype] guard_tag
   drivers/scsi/lpfc/lpfc_scsi.c:2805:51: sparse:     got restricted __be16 [usertype] guard_tag
>> drivers/scsi/lpfc/lpfc_scsi.c:2827:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] app_tag @@     got restricted __be16 [usertype] app_tag @@
   drivers/scsi/lpfc/lpfc_scsi.c:2827:41: sparse:     expected unsigned short [usertype] app_tag
   drivers/scsi/lpfc/lpfc_scsi.c:2827:41: sparse:     got restricted __be16 [usertype] app_tag
   drivers/scsi/lpfc/lpfc_scsi.c:3252:30: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:3254:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3254:28: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:3254:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3310:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3310:54: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:3310:54: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3312:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3312:54: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:3312:54: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3328:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3328:46: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:3328:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3330:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3330:46: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:3330:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3334:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3334:44: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:3334:44: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3335:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3335:46: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:3335:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3344:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3344:44: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:3344:44: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3345:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3345:46: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:3345:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3368:41: sparse: sparse: cast to restricted __le32
>> drivers/scsi/lpfc/lpfc_scsi.c:3370:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3370:36: sparse:     expected unsigned int [usertype] w
   drivers/scsi/lpfc/lpfc_scsi.c:3370:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3378:30: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:3380:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3380:28: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:3380:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3400:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] fcpDl @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3400:25: sparse:     expected unsigned int [usertype] fcpDl
   drivers/scsi/lpfc/lpfc_scsi.c:3400:25: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3407:29: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_scsi.c:3416:25: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_scsi.c:3492:30: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:3494:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:3494:28: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:3494:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:3595:27: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_scsi.c:3603:29: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_scsi.c:3612:25: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_scsi.c:3780:24: sparse: sparse: too many warnings
--
   drivers/scsi/lpfc/lpfc_sli.c:18587:38: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:18588:38: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:18589:38: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:18590:38: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:18591:38: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:18592:38: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17344:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg0_addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17344:47: sparse:     expected unsigned int [usertype] sgl_pg0_addr_lo
   drivers/scsi/lpfc/lpfc_sli.c:17344:47: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17346:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg0_addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17346:47: sparse:     expected unsigned int [usertype] sgl_pg0_addr_hi
   drivers/scsi/lpfc/lpfc_sli.c:17346:47: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17348:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg1_addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17348:47: sparse:     expected unsigned int [usertype] sgl_pg1_addr_lo
   drivers/scsi/lpfc/lpfc_sli.c:17348:47: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17350:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg1_addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17350:47: sparse:     expected unsigned int [usertype] sgl_pg1_addr_hi
   drivers/scsi/lpfc/lpfc_sli.c:17350:47: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17363:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word0 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17363:20: sparse:     expected unsigned int [usertype] word0
   drivers/scsi/lpfc/lpfc_sli.c:17363:20: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:14625:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:14626:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:14626:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:14626:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:14626:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:14635:16: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:8194:16: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:8197:21: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:8198:23: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:695:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:715:17: sparse: sparse: cast to restricted __le32
>> drivers/scsi/lpfc/lpfc_sli.c:715:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word3 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:715:17: sparse:     expected unsigned int [usertype] word3
   drivers/scsi/lpfc/lpfc_sli.c:715:17: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:454:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:580:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:580:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word0 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:580:17: sparse:     expected unsigned int [usertype] word0
   drivers/scsi/lpfc/lpfc_sli.c:580:17: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:602:24: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:2084:35: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:2186:38: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:2187:38: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:2190:35: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:2191:36: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:8648:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:8694:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:9582:38: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:9590:37: sparse: sparse: cast to restricted __le32
>> drivers/scsi/lpfc/lpfc_sli.c:9591:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:9591:38: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_sli.c:9591:38: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/lpfc/lpfc_sli.c:9608:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:9608:36: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_sli.c:9608:36: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/lpfc/lpfc_sli.c:9617:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:9617:38: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_sli.c:9617:38: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/lpfc/lpfc_sli.c:9619:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:9619:38: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_sli.c:9619:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:9621:38: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:9623:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:9623:36: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_sli.c:9623:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:9624:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:9624:38: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_sli.c:9624:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:9694:46: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:9695:45: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:9699:43: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:9703:38: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:10015:37: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:11347:25: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:11375:25: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:13372:37: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:13384:45: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:14053:16: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:17156:57: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg0_addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17156:57: sparse:     expected unsigned int [usertype] sgl_pg0_addr_lo
   drivers/scsi/lpfc/lpfc_sli.c:17156:57: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17158:57: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg0_addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17158:57: sparse:     expected unsigned int [usertype] sgl_pg0_addr_hi
   drivers/scsi/lpfc/lpfc_sli.c:17158:57: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17161:57: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg1_addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17161:57: sparse:     expected unsigned int [usertype] sgl_pg1_addr_lo
   drivers/scsi/lpfc/lpfc_sli.c:17161:57: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17163:57: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg1_addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17163:57: sparse:     expected unsigned int [usertype] sgl_pg1_addr_hi
   drivers/scsi/lpfc/lpfc_sli.c:17163:57: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17456:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg0_addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17456:47: sparse:     expected unsigned int [usertype] sgl_pg0_addr_lo
   drivers/scsi/lpfc/lpfc_sli.c:17456:47: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17458:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg0_addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17458:47: sparse:     expected unsigned int [usertype] sgl_pg0_addr_hi
   drivers/scsi/lpfc/lpfc_sli.c:17458:47: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17465:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg1_addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17465:47: sparse:     expected unsigned int [usertype] sgl_pg1_addr_lo
   drivers/scsi/lpfc/lpfc_sli.c:17465:47: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17467:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_pg1_addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17467:47: sparse:     expected unsigned int [usertype] sgl_pg1_addr_hi
   drivers/scsi/lpfc/lpfc_sli.c:17467:47: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17478:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word0 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:17478:20: sparse:     expected unsigned int [usertype] word0
   drivers/scsi/lpfc/lpfc_sli.c:17478:20: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_sli.c:17702:9: sparse: sparse: cast to restricted __be32
>> drivers/scsi/lpfc/lpfc_sli.c:18318:16: sparse: sparse: restricted __be16 degrades to integer
>> drivers/scsi/lpfc/lpfc_sli.c:20010:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:20010:45: sparse:     expected unsigned int
   drivers/scsi/lpfc/lpfc_sli.c:20010:45: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:20378:38: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:20386:37: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:20387:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:20387:38: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_sli.c:20387:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:20421:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:20421:36: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_sli.c:20421:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:20430:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:20430:30: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_sli.c:20430:30: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:20431:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:20431:30: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_sli.c:20431:30: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:20432:30: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_sli.c:20434:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:20434:28: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_sli.c:20434:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:20435:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_sli.c:20435:30: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_sli.c:20435:30: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_sli.c:12081:36: sparse: sparse: context imbalance in 'lpfc_sli_abort_taskmgmt' - different lock contexts for basic block
--
   drivers/scsi/lpfc/lpfc_els.c:5527:28: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5529:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] flags @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5529:30: sparse:     expected unsigned short [usertype] flags
   drivers/scsi/lpfc/lpfc_els.c:5529:30: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5530:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5530:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5530:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5541:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5541:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5541:19: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5545:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] port_type @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5545:30: sparse:     expected unsigned int [usertype] port_type
   drivers/scsi/lpfc/lpfc_els.c:5545:30: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5547:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] link_failure_cnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5547:49: sparse:     expected unsigned int [usertype] link_failure_cnt
   drivers/scsi/lpfc/lpfc_els.c:5547:49: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5549:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] loss_of_synch_cnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5549:50: sparse:     expected unsigned int [usertype] loss_of_synch_cnt
   drivers/scsi/lpfc/lpfc_els.c:5549:50: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5551:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] loss_of_signal_cnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5551:51: sparse:     expected unsigned int [usertype] loss_of_signal_cnt
   drivers/scsi/lpfc/lpfc_els.c:5551:51: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5553:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] primitive_seq_proto_err @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5553:56: sparse:     expected unsigned int [usertype] primitive_seq_proto_err
   drivers/scsi/lpfc/lpfc_els.c:5553:56: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5555:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] invalid_trans_word @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5555:51: sparse:     expected unsigned int [usertype] invalid_trans_word
   drivers/scsi/lpfc/lpfc_els.c:5555:51: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5557:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] invalid_crc_cnt @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5557:48: sparse:     expected unsigned int [usertype] invalid_crc_cnt
   drivers/scsi/lpfc/lpfc_els.c:5557:48: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5559:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5559:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5559:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5570:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5570:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5570:19: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5574:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] port_bbc @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5574:33: sparse:     expected unsigned int [usertype] port_bbc
   drivers/scsi/lpfc/lpfc_els.c:5574:33: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5578:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] attached_port_bbc @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5578:50: sparse:     expected unsigned int [usertype] attached_port_bbc
   drivers/scsi/lpfc/lpfc_els.c:5578:50: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5584:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5584:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5584:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5595:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5595:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5595:19: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5612:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] function_flags @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5612:39: sparse:     expected unsigned int [usertype] function_flags
   drivers/scsi/lpfc/lpfc_els.c:5612:39: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5613:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5613:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5613:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5624:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5624:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5624:19: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5641:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] function_flags @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5641:39: sparse:     expected unsigned int [usertype] function_flags
   drivers/scsi/lpfc/lpfc_els.c:5641:39: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5642:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5642:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5642:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5653:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5653:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5653:19: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5670:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] function_flags @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5670:39: sparse:     expected unsigned int [usertype] function_flags
   drivers/scsi/lpfc/lpfc_els.c:5670:39: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5671:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5671:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5671:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5682:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5682:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5682:19: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5699:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] function_flags @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5699:39: sparse:     expected unsigned int [usertype] function_flags
   drivers/scsi/lpfc/lpfc_els.c:5699:39: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5700:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5700:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5700:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5712:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5712:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5712:19: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5729:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] function_flags @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5729:39: sparse:     expected unsigned int [usertype] function_flags
   drivers/scsi/lpfc/lpfc_els.c:5729:39: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5730:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5730:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5730:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5738:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5738:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5738:19: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5744:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5744:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5744:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5753:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5753:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5753:19: sparse:     got restricted __be32 [usertype]
>> drivers/scsi/lpfc/lpfc_els.c:5755:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CorrectedBlocks @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5755:36: sparse:     expected unsigned int [usertype] CorrectedBlocks
   drivers/scsi/lpfc/lpfc_els.c:5755:36: sparse:     got restricted __be32 [usertype]
>> drivers/scsi/lpfc/lpfc_els.c:5757:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] UncorrectableBlocks @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5757:40: sparse:     expected unsigned int [usertype] UncorrectableBlocks
   drivers/scsi/lpfc/lpfc_els.c:5757:40: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5760:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5760:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5760:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5771:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5771:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5771:19: sparse:     got restricted __be32 [usertype]
>> drivers/scsi/lpfc/lpfc_els.c:5803:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] speed @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5803:37: sparse:     expected unsigned short [usertype] speed
   drivers/scsi/lpfc/lpfc_els.c:5803:37: sparse:     got restricted __be16 [usertype]
>> drivers/scsi/lpfc/lpfc_els.c:5829:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] capabilities @@     got restricted __be16 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5829:44: sparse:     expected unsigned short [usertype] capabilities
   drivers/scsi/lpfc/lpfc_els.c:5829:44: sparse:     got restricted __be16 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5830:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5830:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5830:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5839:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5839:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5839:19: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5847:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5847:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5847:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5856:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tag @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5856:19: sparse:     expected unsigned int [usertype] tag
   drivers/scsi/lpfc/lpfc_els.c:5856:19: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5871:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5871:22: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5871:22: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5962:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_els.c:5962:25: sparse:     expected unsigned int [usertype] length
   drivers/scsi/lpfc/lpfc_els.c:5962:25: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_els.c:5970:22: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_els.c:6101:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_els.c:6101:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_els.c:6101:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_els.c:6101:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_els.c:6101:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_els.c:6101:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_els.c:6101:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_els.c:6101:9: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_els.c:6110:25: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_els.c:6112:36: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_els.c:6115:25: sparse: sparse: cast to restricted __be32
>> drivers/scsi/lpfc/lpfc_els.c:6320:17: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_els.c:6325:21: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_els.c:6335:17: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_els.c:6380:9: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_els.c:6380:9: sparse: sparse: cast to restricted __be16
   drivers/scsi/lpfc/lpfc_els.c:6524:31: sparse: sparse: too many warnings
--
   drivers/staging/rtl8712/rtl871x_mlme.c:458:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:459:37: sparse: sparse: cast to restricted __le32
>> drivers/staging/rtl8712/rtl871x_mlme.c:460:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] Privacy @@     got unsigned int [usertype] @@
   drivers/staging/rtl8712/rtl871x_mlme.c:460:27: sparse:     expected restricted __le32 [usertype] Privacy
   drivers/staging/rtl8712/rtl871x_mlme.c:460:27: sparse:     got unsigned int [usertype]
   drivers/staging/rtl8712/rtl871x_mlme.c:461:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:462:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:464:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:466:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:468:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:470:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:472:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:474:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:476:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:478:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:480:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:481:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:677:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:678:34: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:679:36: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:681:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:682:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] Privacy @@     got unsigned int [usertype] @@
   drivers/staging/rtl8712/rtl871x_mlme.c:682:35: sparse:     expected restricted __le32 [usertype] Privacy
   drivers/staging/rtl8712/rtl871x_mlme.c:682:35: sparse:     got unsigned int [usertype]
   drivers/staging/rtl8712/rtl871x_mlme.c:683:34: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:685:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:687:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:689:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:691:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:693:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:696:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:699:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:701:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:703:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:705:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:706:38: sparse: sparse: cast to restricted __le32
--
   drivers/staging/rtl8712/rtl871x_cmd.c:438:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Length @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:438:29: sparse:     expected unsigned int [usertype] Length
   drivers/staging/rtl8712/rtl871x_cmd.c:438:29: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:439:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] SsidLength @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:439:38: sparse:     expected unsigned int [usertype] SsidLength
   drivers/staging/rtl8712/rtl871x_cmd.c:439:38: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:441:32: sparse: sparse: cast from restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:442:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int [usertype] Rssi @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:442:27: sparse:     expected signed int [usertype] Rssi
   drivers/staging/rtl8712/rtl871x_cmd.c:442:27: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:443:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int enum NDIS_802_11_NETWORK_TYPE NetworkTypeInUse @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:443:39: sparse:     expected unsigned int enum NDIS_802_11_NETWORK_TYPE NetworkTypeInUse
   drivers/staging/rtl8712/rtl871x_cmd.c:443:39: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:445:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ATIMWindow @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:445:47: sparse:     expected unsigned int [usertype] ATIMWindow
   drivers/staging/rtl8712/rtl871x_cmd.c:445:47: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:447:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] BeaconPeriod @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:447:49: sparse:     expected unsigned int [usertype] BeaconPeriod
   drivers/staging/rtl8712/rtl871x_cmd.c:447:49: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:449:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] DSConfig @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:449:45: sparse:     expected unsigned int [usertype] DSConfig
   drivers/staging/rtl8712/rtl871x_cmd.c:449:45: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:451:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] DwellTime @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:451:55: sparse:     expected unsigned int [usertype] DwellTime
   drivers/staging/rtl8712/rtl871x_cmd.c:451:55: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:453:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] HopPattern @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:453:56: sparse:     expected unsigned int [usertype] HopPattern
   drivers/staging/rtl8712/rtl871x_cmd.c:453:56: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:455:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] HopSet @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:455:52: sparse:     expected unsigned int [usertype] HopSet
   drivers/staging/rtl8712/rtl871x_cmd.c:455:52: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:457:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Length @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:457:52: sparse:     expected unsigned int [usertype] Length
   drivers/staging/rtl8712/rtl871x_cmd.c:457:52: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:459:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Length @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:459:43: sparse:     expected unsigned int [usertype] Length
   drivers/staging/rtl8712/rtl871x_cmd.c:459:43: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:461:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int enum NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:461:41: sparse:     expected unsigned int enum NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode
   drivers/staging/rtl8712/rtl871x_cmd.c:461:41: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:463:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] IELength @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:463:31: sparse:     expected unsigned int [usertype] IELength
   drivers/staging/rtl8712/rtl871x_cmd.c:463:31: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:668:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:669:37: sparse: sparse: cast to restricted __le32
>> drivers/staging/rtl8712/rtl871x_cmd.c:670:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] Privacy @@     got unsigned int [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:670:27: sparse:     expected restricted __le32 [usertype] Privacy
   drivers/staging/rtl8712/rtl871x_cmd.c:670:27: sparse:     got unsigned int [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:671:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:672:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:674:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:676:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:678:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:680:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:682:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:684:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:686:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:688:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:689:30: sparse: sparse: cast to restricted __le32
--
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c: note: in included file (through drivers/gpu/drm/msm/msm_gpu.h, drivers/gpu/drm/msm/adreno/adreno_gpu.h, drivers/gpu/drm/msm/adreno/a6xx_gpu.h):
   include/linux/adreno-smmu-priv.h:36:33: sparse: sparse: no newline at end of file
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:362:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:387:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:460:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:467:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:493:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1395:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1395:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1395:31: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1401:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1401:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1401:31: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:845:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:845:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:845:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:845:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:845:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:845:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:847:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:847:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:847:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:847:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:847:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:847:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:849:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:849:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:849:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:849:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:849:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:849:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:851:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:851:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:851:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:851:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:851:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:851:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1052:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1052:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1052:23: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1052:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1052:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1052:23: sparse:     got void *
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1441:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *[noderef] mmio @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1441:20: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1441:20: sparse:     got void *[noderef] mmio
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1443:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *[noderef] rscc @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1443:28: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1443:28: sparse:     got void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1527:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] mmio @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1527:19: sparse:     expected void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1527:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1534:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] rscc @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1534:27: sparse:     expected void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1534:27: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1565:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *[noderef] mmio @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1565:20: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1565:20: sparse:     got void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1567:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *[noderef] rscc @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1567:28: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1567:28: sparse:     got void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c: note: in included file (through drivers/gpu/drm/msm/adreno/a6xx_gpu.h):
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:26: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:26: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:26: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:26: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:26: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:26: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:26: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:26: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:44: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:97:34: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:320:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:92:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@

vim +166 drivers/interconnect/qcom/icc-rpmh.c

6caa3070fd5955 Georgi Djakov 2020-09-03  128  
976daac4a1c581 David Dai     2020-02-28  129  /**
976daac4a1c581 David Dai     2020-02-28  130   * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
976daac4a1c581 David Dai     2020-02-28  131   * @bcm: bcm to be initialized
976daac4a1c581 David Dai     2020-02-28  132   * @dev: associated provider device
976daac4a1c581 David Dai     2020-02-28  133   *
976daac4a1c581 David Dai     2020-02-28  134   * Return: 0 on success, or an error code otherwise
976daac4a1c581 David Dai     2020-02-28  135   */
976daac4a1c581 David Dai     2020-02-28  136  int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
976daac4a1c581 David Dai     2020-02-28  137  {
976daac4a1c581 David Dai     2020-02-28  138  	struct qcom_icc_node *qn;
976daac4a1c581 David Dai     2020-02-28  139  	const struct bcm_db *data;
976daac4a1c581 David Dai     2020-02-28  140  	size_t data_count;
976daac4a1c581 David Dai     2020-02-28  141  	int i;
976daac4a1c581 David Dai     2020-02-28  142  
976daac4a1c581 David Dai     2020-02-28  143  	/* BCM is already initialised*/
976daac4a1c581 David Dai     2020-02-28  144  	if (bcm->addr)
976daac4a1c581 David Dai     2020-02-28  145  		return 0;
976daac4a1c581 David Dai     2020-02-28  146  
976daac4a1c581 David Dai     2020-02-28  147  	bcm->addr = cmd_db_read_addr(bcm->name);
976daac4a1c581 David Dai     2020-02-28  148  	if (!bcm->addr) {
976daac4a1c581 David Dai     2020-02-28  149  		dev_err(dev, "%s could not find RPMh address\n",
976daac4a1c581 David Dai     2020-02-28  150  			bcm->name);
976daac4a1c581 David Dai     2020-02-28  151  		return -EINVAL;
976daac4a1c581 David Dai     2020-02-28  152  	}
976daac4a1c581 David Dai     2020-02-28  153  
976daac4a1c581 David Dai     2020-02-28  154  	data = cmd_db_read_aux_data(bcm->name, &data_count);
976daac4a1c581 David Dai     2020-02-28  155  	if (IS_ERR(data)) {
976daac4a1c581 David Dai     2020-02-28  156  		dev_err(dev, "%s command db read error (%ld)\n",
976daac4a1c581 David Dai     2020-02-28  157  			bcm->name, PTR_ERR(data));
976daac4a1c581 David Dai     2020-02-28  158  		return PTR_ERR(data);
976daac4a1c581 David Dai     2020-02-28  159  	}
976daac4a1c581 David Dai     2020-02-28  160  	if (!data_count) {
976daac4a1c581 David Dai     2020-02-28  161  		dev_err(dev, "%s command db missing or partial aux data\n",
976daac4a1c581 David Dai     2020-02-28  162  			bcm->name);
976daac4a1c581 David Dai     2020-02-28  163  		return -EINVAL;
976daac4a1c581 David Dai     2020-02-28  164  	}
976daac4a1c581 David Dai     2020-02-28  165  
976daac4a1c581 David Dai     2020-02-28 @166  	bcm->aux_data.unit = le32_to_cpu(data->unit);
976daac4a1c581 David Dai     2020-02-28 @167  	bcm->aux_data.width = le16_to_cpu(data->width);
976daac4a1c581 David Dai     2020-02-28  168  	bcm->aux_data.vcd = data->vcd;
976daac4a1c581 David Dai     2020-02-28  169  	bcm->aux_data.reserved = data->reserved;
976daac4a1c581 David Dai     2020-02-28  170  	INIT_LIST_HEAD(&bcm->list);
976daac4a1c581 David Dai     2020-02-28  171  	INIT_LIST_HEAD(&bcm->ws_list);
976daac4a1c581 David Dai     2020-02-28  172  
cb30e0292db258 Mike Tipton   2020-09-03  173  	if (!bcm->vote_scale)
cb30e0292db258 Mike Tipton   2020-09-03  174  		bcm->vote_scale = 1000;
cb30e0292db258 Mike Tipton   2020-09-03  175  
976daac4a1c581 David Dai     2020-02-28  176  	/* Link Qnodes to their respective BCMs */
976daac4a1c581 David Dai     2020-02-28  177  	for (i = 0; i < bcm->num_nodes; i++) {
976daac4a1c581 David Dai     2020-02-28  178  		qn = bcm->nodes[i];
976daac4a1c581 David Dai     2020-02-28  179  		qn->bcms[qn->num_bcms] = bcm;
976daac4a1c581 David Dai     2020-02-28  180  		qn->num_bcms++;
976daac4a1c581 David Dai     2020-02-28  181  	}
976daac4a1c581 David Dai     2020-02-28  182  
976daac4a1c581 David Dai     2020-02-28  183  	return 0;
976daac4a1c581 David Dai     2020-02-28  184  }
976daac4a1c581 David Dai     2020-02-28  185  EXPORT_SYMBOL_GPL(qcom_icc_bcm_init);
976daac4a1c581 David Dai     2020-02-28  186  

:::::: The code at line 166 was first introduced by commit
:::::: 976daac4a1c581e5d5fd64047519fd6fcde39738 interconnect: qcom: Consolidate interconnect RPMh support

:::::: TO: David Dai <daidavid1@codeaurora.org>
:::::: CC: Georgi Djakov <georgi.djakov@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
