Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B98515467
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiD2TZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbiD2TZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:25:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F536D95E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651260143; x=1682796143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2kUmuCkprRO76bHPyW2P4Bi58L2aFW3MxVRrfp5ZrV8=;
  b=JXYyAGefG0LRhto8+IMjgzT12rMm80Tk/6icEHb/5f2X+YWdSv5Aw0Y1
   RyLGmpxEc6LIJ8o6y+ByTOuNoclaTAfQAcO7q5D9pJPHJcJNfoRKgL1/I
   S8cnG/04l+lX1BAj6zaD4sMn7I9RxLw4ylpxAYEmLI++CKR+Uz/PgBxo/
   f/iQ9LO44LOYssTxFd2xI/HuDVdt/D8UXrkFoiBdpYVyyivf3eXH9CXgU
   mHL8sHEauc9WisMc6RT0a4WYN6QzC/3FsikbWBfKKVIjC8mZSMpSH7LlE
   5US6wWBIY7FEp8mBxGSQ6ro/W18M/CEZ5QhAXFvCKzSrvI2OC8oEAW0M9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="246667858"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="246667858"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 12:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="651891891"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Apr 2022 12:22:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkWC4-0006Zn-CQ;
        Fri, 29 Apr 2022 19:22:20 +0000
Date:   Sat, 30 Apr 2022 03:21:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 6/10] net/smc/af_smc.c:2705:13: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202204300311.KFrz4bUn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   956305b67dd062e5a58c68c871dee2ee1d579feb
commit: 2d7493c0421d267a906653b33aca69bf87f0595f [6/10] x86/uaccess: Remove tags from the address before checking
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220430/202204300311.KFrz4bUn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=2d7493c0421d267a906653b33aca69bf87f0595f
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 2d7493c0421d267a906653b33aca69bf87f0595f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/mce/ block/ drivers/acpi/ drivers/android/ drivers/ata/ drivers/auxdisplay/ drivers/block/ drivers/comedi/ drivers/fpga/ drivers/hwmon/ drivers/infiniband/core/ drivers/mtd/ drivers/nvme/host/ drivers/platform/x86/ drivers/scsi/ drivers/usb/gadget/function/ drivers/vdpa/vdpa_user/ drivers/vhost/ fs/cifs/ fs/ext2/ fs/ext4/ fs/f2fs/ fs/fat/ fs/fuse/ fs/jfs/ fs/reiserfs/ fs/xfs/ ipc/ kernel/ net/bluetooth/ net/core/ net/decnet/ net/ipv4/ net/l2tp/ net/llc/ net/nfc/ net/sctp/ net/smc/ net/tipc/ net/tls/ net/vmw_vsock/ sound/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/smc/af_smc.c:2705:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/smc/af_smc.c:2705:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/smc/af_smc.c:2705:13: sparse:     got int *
   net/smc/af_smc.c:2721:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/smc/af_smc.c:2721:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/smc/af_smc.c:2721:13: sparse:     got int *
   net/smc/af_smc.c:2953:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/smc/af_smc.c:2953:16: sparse:     expected int [noderef] __user *__ptr_clean
   net/smc/af_smc.c:2953:16: sparse:     got int *
--
>> net/tipc/socket.c:3242:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/tipc/socket.c:3242:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/tipc/socket.c:3242:24: sparse:     got int *
   net/tipc/socket.c:3245:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/tipc/socket.c:3245:15: sparse:     expected int [noderef] __user *__ptr_clean
   net/tipc/socket.c:3245:15: sparse:     got int *
   net/tipc/socket.c:3295:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/tipc/socket.c:3295:16: sparse:     expected int [noderef] __user *__ptr_clean
   net/tipc/socket.c:3295:16: sparse:     got int *
--
>> net/tls/tls_main.c:344:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/tls/tls_main.c:344:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/tls/tls_main.c:344:13: sparse:     got int *
--
>> drivers/android/binder.c:3555:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:3555:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:3555:21: sparse:     got unsigned int *
   drivers/android/binder.c:3575:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:3575:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:3575:29: sparse:     got unsigned int *
>> drivers/android/binder.c:3642:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:3642:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:3642:29: sparse:     got unsigned long long *
   drivers/android/binder.c:3645:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:3645:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:3645:29: sparse:     got unsigned long long *
   drivers/android/binder.c:3714:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:3714:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:3714:29: sparse:     got unsigned long long *
   drivers/android/binder.c:3811:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:3811:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:3811:29: sparse:     got unsigned int *
   drivers/android/binder.c:3814:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:3814:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:3814:29: sparse:     got unsigned long long *
   drivers/android/binder.c:3933:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:3933:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:3933:29: sparse:     got unsigned long long *
   drivers/android/binder.c:4009:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4009:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4009:13: sparse:     got unsigned int *
   drivers/android/binder.c:4013:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:4013:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:4013:13: sparse:     got unsigned long long *
   drivers/android/binder.c:4017:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:4017:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:4017:13: sparse:     got unsigned long long *
   drivers/android/binder.c:4140:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4140:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4140:21: sparse:     got unsigned int *
   drivers/android/binder.c:4222:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4222:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4222:29: sparse:     got unsigned int *
   drivers/android/binder.c:4240:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4240:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4240:29: sparse:     got unsigned int *
   drivers/android/binder.c:4366:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4366:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4366:29: sparse:     got unsigned int *
   drivers/android/binder.c:4369:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:4369:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:4369:29: sparse:     got unsigned long long *
   drivers/android/binder.c:4441:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4441:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4441:37: sparse:     got unsigned int *
   drivers/android/binder.c:4461:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4461:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4461:21: sparse:     got unsigned int *
   drivers/android/binder.c:4526:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4526:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4526:21: sparse:     got unsigned int *
   drivers/android/binder.c:4780:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int @@
   drivers/android/binder.c:4780:24: sparse:     expected restricted __poll_t
   drivers/android/binder.c:4780:24: sparse:     got int
>> drivers/android/binder.c:5139:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/android/binder.c:5139:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/android/binder.c:5139:21: sparse:     got signed int *
--
>> drivers/ata/libata-scsi.c:571:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/ata/libata-scsi.c:571:24: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/ata/libata-scsi.c:571:24: sparse:     got unsigned long *
--
>> drivers/auxdisplay/charlcd.c:482:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/auxdisplay/charlcd.c:482:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/auxdisplay/charlcd.c:482:21: sparse:     got char const *
--
>> net/vmw_vsock/af_vsock.c:1681:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/vmw_vsock/af_vsock.c:1681:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/vmw_vsock/af_vsock.c:1681:13: sparse:     got int *
   net/vmw_vsock/af_vsock.c:1716:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/vmw_vsock/af_vsock.c:1716:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/vmw_vsock/af_vsock.c:1716:13: sparse:     got int *
>> net/vmw_vsock/af_vsock.c:2245:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/vmw_vsock/af_vsock.c:2245:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/vmw_vsock/af_vsock.c:2245:21: sparse:     got unsigned int *
--
>> drivers/block/xen-blkfront.c:515:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/block/xen-blkfront.c:515:29: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/block/xen-blkfront.c:515:29: sparse:     got char *
--
>> drivers/comedi/comedi_fops.c:1083:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/comedi/comedi_fops.c:1083:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/comedi/comedi_fops.c:1083:29: sparse:     got unsigned int *
--
>> drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int *
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int *
--
>> drivers/hwmon/w83793.c:1370:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/hwmon/w83793.c:1370:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1370:37: sparse:     got char const *
>> drivers/hwmon/w83793.c:1406:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1406:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1406:23: sparse:     got int *
   drivers/hwmon/w83793.c:1410:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1410:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1410:23: sparse:     got int *
   drivers/hwmon/w83793.c:1419:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1419:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1419:23: sparse:     got int *
   drivers/hwmon/w83793.c:1423:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1423:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1423:21: sparse:     got int *
   drivers/hwmon/w83793.c:1429:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1429:31: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1429:31: sparse:     got int *
   drivers/hwmon/w83793.c:1433:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1433:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1433:21: sparse:     got int *
--
>> drivers/hwmon/fschmd.c:866:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/hwmon/fschmd.c:866:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:866:37: sparse:     got char const *
>> drivers/hwmon/fschmd.c:900:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:900:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:900:23: sparse:     got int *
   drivers/hwmon/fschmd.c:905:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:905:31: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:905:31: sparse:     got int *
   drivers/hwmon/fschmd.c:907:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:907:31: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:907:31: sparse:     got int *
   drivers/hwmon/fschmd.c:916:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:916:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:916:23: sparse:     got int *
   drivers/hwmon/fschmd.c:920:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:920:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:920:21: sparse:     got int *
   drivers/hwmon/fschmd.c:926:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:926:31: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:926:31: sparse:     got int *
   drivers/hwmon/fschmd.c:930:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:930:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:930:21: sparse:     got int *
--
   drivers/infiniband/core/user_mad.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/ib_umad.h):
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   drivers/infiniband/core/user_mad.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/ib_umad.h):
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qpn @@     got restricted __be32 [usertype] qpn @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qpn
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qpn
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qkey @@     got restricted __be32 [usertype] qkey @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] lid @@     got restricted __be16 [usertype] lid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] lid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] lid
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flow_label @@     got restricted __be32 [usertype] flow_label @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] mad_status @@     got restricted __be16 [usertype] status @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] mad_status
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] status
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] class_specific @@     got restricted __be16 [usertype] class_specific @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] tid @@     got restricted __be64 [usertype] tid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned long long [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be64 [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] attr_id @@     got restricted __be16 [usertype] attr_id @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] attr_mod @@     got restricted __be32 [usertype] attr_mod @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] attr_mod
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] attr_mod
   drivers/infiniband/core/user_mad.c: note: in included file (through include/trace/perf.h, include/trace/define_trace.h, include/trace/events/ib_umad.h):
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qpn @@     got restricted __be32 [usertype] qpn @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qpn
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qpn
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qkey @@     got restricted __be32 [usertype] qkey @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] lid @@     got restricted __be16 [usertype] lid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] lid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] lid
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flow_label @@     got restricted __be32 [usertype] flow_label @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] mad_status @@     got restricted __be16 [usertype] status @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] mad_status
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] status
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] class_specific @@     got restricted __be16 [usertype] class_specific @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] tid @@     got restricted __be64 [usertype] tid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned long long [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be64 [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] attr_id @@     got restricted __be16 [usertype] attr_id @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] attr_mod @@     got restricted __be32 [usertype] attr_mod @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] attr_mod
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] attr_mod
>> drivers/infiniband/core/user_mad.c:749:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/infiniband/core/user_mad.c:749:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/infiniband/core/user_mad.c:749:13: sparse:     got unsigned int *
   drivers/infiniband/core/user_mad.c:815:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/infiniband/core/user_mad.c:815:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/infiniband/core/user_mad.c:815:21: sparse:     got unsigned int *
   drivers/infiniband/core/user_mad.c:863:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/infiniband/core/user_mad.c:863:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/infiniband/core/user_mad.c:863:13: sparse:     got unsigned int *
   drivers/infiniband/core/user_mad.c:896:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/infiniband/core/user_mad.c:896:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/infiniband/core/user_mad.c:896:13: sparse:     got unsigned int *
--
>> drivers/infiniband/core/uverbs_main.c:632:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const [noderef] __user *__ptr_clean @@     got unsigned long long const * @@
   drivers/infiniband/core/uverbs_main.c:632:31: sparse:     expected unsigned long long const [noderef] __user *__ptr_clean
   drivers/infiniband/core/uverbs_main.c:632:31: sparse:     got unsigned long long const *
--
>> drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse:     got unsigned short *
>> drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse:     got unsigned long long *
   drivers/infiniband/core/uverbs_ioctl.c:423:17: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected int ( *handler )( ... ) @@     got int ( [noderef] * )( ... ) @@
   drivers/infiniband/core/uverbs_ioctl.c:423:17: sparse:     expected int ( *handler )( ... )
   drivers/infiniband/core/uverbs_ioctl.c:423:17: sparse:     got int ( [noderef] * )( ... )
--
>> drivers/mtd/mtdchar.c:409:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:409:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:409:13: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:754:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:754:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:754:21: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:762:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:762:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:762:21: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:763:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:763:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:763:24: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:764:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:764:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:764:24: sparse:     got unsigned int *
--
>> drivers/nvme/host/ioctl.c:246:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/nvme/host/ioctl.c:246:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/nvme/host/ioctl.c:246:21: sparse:     got unsigned int *
>> drivers/nvme/host/ioctl.c:292:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/nvme/host/ioctl.c:292:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/nvme/host/ioctl.c:292:21: sparse:     got unsigned long long *
--
>> drivers/platform/x86/wmi.c:903:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/platform/x86/wmi.c:903:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/platform/x86/wmi.c:903:13: sparse:     got unsigned long long *
--
>> drivers/scsi/scsi_ioctl.c:49:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/scsi_ioctl.c:49:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:49:21: sparse:     got unsigned int *
>> drivers/scsi/scsi_ioctl.c:173:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:173:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:173:16: sparse:     got int *
   drivers/scsi/scsi_ioctl.c:178:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:178:28: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:178:28: sparse:     got int *
   drivers/scsi/scsi_ioctl.c:191:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:191:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:191:16: sparse:     got int *
   drivers/scsi/scsi_ioctl.c:196:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:196:25: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:196:25: sparse:     got int *
   drivers/scsi/scsi_ioctl.c:215:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:215:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:215:16: sparse:     got int *
   drivers/scsi/scsi_ioctl.c:532:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/scsi_ioctl.c:532:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:532:13: sparse:     got unsigned int *
   drivers/scsi/scsi_ioctl.c:534:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/scsi_ioctl.c:534:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:534:13: sparse:     got unsigned int *
>> drivers/scsi/scsi_ioctl.c:538:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/scsi_ioctl.c:538:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:538:13: sparse:     got unsigned char *
   drivers/scsi/scsi_ioctl.c:924:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_ioctl.c:924:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_ioctl.c:924:24: sparse:     got int *
--
>> drivers/scsi/scsi_error.c:2388:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/scsi_error.c:2388:17: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/scsi_error.c:2388:17: sparse:     got int *
--
>> drivers/scsi/ch.c:552:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/ch.c:552:17: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/ch.c:552:17: sparse:     got unsigned char *
--
   drivers/scsi/st.c: note: in included file:
>> include/linux/mtio.h:55:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   include/linux/mtio.h:55:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   include/linux/mtio.h:55:24: sparse:     got unsigned int *
>> include/linux/mtio.h:57:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   include/linux/mtio.h:57:24: sparse:     expected long [noderef] __user *__ptr_clean
   include/linux/mtio.h:57:24: sparse:     got long *
--
>> drivers/usb/gadget/function/rndis.c:1138:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/usb/gadget/function/rndis.c:1138:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/usb/gadget/function/rndis.c:1138:21: sparse:     got char const *
--
>> drivers/mtd/ubi/cdev.c:467:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:467:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:467:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:512:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:512:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:512:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:526:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:526:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:526:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:869:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:869:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:869:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:882:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:882:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:882:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:969:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:969:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:969:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:984:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:984:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:984:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:1050:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:1061:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     got signed int *
--
>> drivers/vdpa/vdpa_user/vduse_dev.c:975:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/vdpa/vdpa_user/vduse_dev.c:975:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/vdpa/vdpa_user/vduse_dev.c:975:23: sparse:     got unsigned long long *
>> drivers/vdpa/vdpa_user/vduse_dev.c:1080:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/vdpa/vdpa_user/vduse_dev.c:1080:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/vdpa/vdpa_user/vduse_dev.c:1080:21: sparse:     got unsigned int *
   drivers/vdpa/vdpa_user/vduse_dev.c:1381:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/vdpa/vdpa_user/vduse_dev.c:1381:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/vdpa/vdpa_user/vduse_dev.c:1381:23: sparse:     got unsigned long long *
   drivers/vdpa/vdpa_user/vduse_dev.c:1387:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/vdpa/vdpa_user/vduse_dev.c:1387:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/vdpa/vdpa_user/vduse_dev.c:1387:21: sparse:     got unsigned long long *
--
>> drivers/vhost/scsi.c:1872:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/vhost/scsi.c:1872:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/vhost/scsi.c:1872:21: sparse:     got unsigned int *
   drivers/vhost/scsi.c:1882:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/vhost/scsi.c:1882:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/vhost/scsi.c:1882:21: sparse:     got unsigned int *
--
>> drivers/vhost/vhost.c:1602:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/vhost/vhost.c:1602:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/vhost/vhost.c:1602:13: sparse:     got unsigned int *
>> drivers/vhost/vhost.c:1800:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/vhost/vhost.c:1800:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/vhost/vhost.c:1800:21: sparse:     got int *
--
>> block/ioctl.c:58:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:58:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:58:13: sparse:     got int *
>> block/ioctl.c:58:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   block/ioctl.c:58:39: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   block/ioctl.c:58:39: sparse:     got void [noderef] __user **
>> block/ioctl.c:170:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   block/ioctl.c:170:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   block/ioctl.c:170:16: sparse:     got unsigned short *
   block/ioctl.c:175:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:175:16: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:175:16: sparse:     got int *
>> block/ioctl.c:180:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:180:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:180:16: sparse:     got unsigned int *
>> block/ioctl.c:185:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   block/ioctl.c:185:16: sparse:     expected long [noderef] __user *__ptr_clean
   block/ioctl.c:185:16: sparse:     got long *
>> block/ioctl.c:190:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   block/ioctl.c:190:16: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   block/ioctl.c:190:16: sparse:     got unsigned long *
>> block/ioctl.c:195:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   block/ioctl.c:195:16: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   block/ioctl.c:195:16: sparse:     got unsigned long long *
   block/ioctl.c:338:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:338:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:338:13: sparse:     got int *
   block/ioctl.c:424:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:424:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:424:13: sparse:     got int *
--
>> block/bsg.c:87:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:87:16: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:87:16: sparse:     got int *
   block/bsg.c:94:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:94:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:94:13: sparse:     got int *
   block/bsg.c:123:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:123:24: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:123:24: sparse:     got int *
   block/bsg.c:125:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:125:24: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:125:24: sparse:     got int *
   block/bsg.c:127:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:127:24: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:127:24: sparse:     got int *
   block/bsg.c:129:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:129:21: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:129:21: sparse:     got int *
   block/bsg.c:136:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:136:24: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:136:24: sparse:     got int *
   block/bsg.c:139:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:139:21: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:139:21: sparse:     got int *
   block/bsg.c:147:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/bsg.c:147:24: sparse:     expected int [noderef] __user *__ptr_clean
   block/bsg.c:147:24: sparse:     got int *
--
>> fs/fuse/dev.c:2261:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fuse/dev.c:2261:22: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fuse/dev.c:2261:22: sparse:     got unsigned int *
--
>> fs/jfs/jfs_debug.c:36:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   fs/jfs/jfs_debug.c:36:13: sparse:     expected char const [noderef] __user *__ptr_clean
   fs/jfs/jfs_debug.c:36:13: sparse:     got char const *
--
>> drivers/acpi/ec_sys.c:53:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/acpi/ec_sys.c:53:21: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/acpi/ec_sys.c:53:21: sparse:     got char *
>> drivers/acpi/ec_sys.c:87:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/acpi/ec_sys.c:87:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/acpi/ec_sys.c:87:21: sparse:     got char const *
--
>> sound/core/compress_offload.c:975:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/compress_offload.c:975:26: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/compress_offload.c:975:26: sparse:     got int *
--
>> fs/reiserfs/ioctl.c:96:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/reiserfs/ioctl.c:96:23: sparse:     expected int [noderef] __user *__ptr_clean
   fs/reiserfs/ioctl.c:96:23: sparse:     got int *
   fs/reiserfs/ioctl.c:106:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/reiserfs/ioctl.c:106:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/reiserfs/ioctl.c:106:21: sparse:     got int *
--
>> net/bluetooth/hci_sock.c:1968:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/hci_sock.c:1968:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:1968:13: sparse:     got int *
>> net/bluetooth/hci_sock.c:1985:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/bluetooth/hci_sock.c:1985:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:1985:21: sparse:     got char *
   net/bluetooth/hci_sock.c:1995:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/bluetooth/hci_sock.c:1995:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:1995:21: sparse:     got char *
>> net/bluetooth/hci_sock.c:2045:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/bluetooth/hci_sock.c:2045:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:2045:21: sparse:     got unsigned short *
--
>> net/bluetooth/l2cap_sock.c:464:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/l2cap_sock.c:464:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:464:13: sparse:     got int *
>> net/bluetooth/l2cap_sock.c:539:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/l2cap_sock.c:539:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:539:21: sparse:     got unsigned int *
   net/bluetooth/l2cap_sock.c:589:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/l2cap_sock.c:589:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:589:13: sparse:     got int *
   net/bluetooth/l2cap_sock.c:625:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/l2cap_sock.c:625:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:625:21: sparse:     got unsigned int *
   net/bluetooth/l2cap_sock.c:632:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/l2cap_sock.c:632:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:632:21: sparse:     got unsigned int *
   net/bluetooth/l2cap_sock.c:654:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/l2cap_sock.c:654:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:654:21: sparse:     got unsigned int *
>> net/bluetooth/l2cap_sock.c:669:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/bluetooth/l2cap_sock.c:669:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:669:21: sparse:     got unsigned short *
   net/bluetooth/l2cap_sock.c:679:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/bluetooth/l2cap_sock.c:679:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:679:21: sparse:     got unsigned short *
   net/bluetooth/l2cap_sock.c:691:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bluetooth/l2cap_sock.c:691:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:691:21: sparse:     got unsigned int *
>> net/bluetooth/l2cap_sock.c:712:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   net/bluetooth/l2cap_sock.c:712:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   net/bluetooth/l2cap_sock.c:712:21: sparse:     got unsigned char *
--
>> net/bluetooth/af_bluetooth.c:511:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/af_bluetooth.c:511:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/af_bluetooth.c:511:23: sparse:     got int *
   net/bluetooth/af_bluetooth.c:522:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/af_bluetooth.c:522:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/af_bluetooth.c:522:23: sparse:     got int *
   net/bluetooth/af_bluetooth.c:176:25: sparse: sparse: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
--
>> net/bluetooth/hci_core.c:825:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/bluetooth/hci_core.c:825:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/bluetooth/hci_core.c:825:13: sparse:     got unsigned short *
--
>> net/core/pktgen.c:756:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   net/core/pktgen.c:756:21: sparse:     expected char const [noderef] __user *__ptr_clean
   net/core/pktgen.c:756:21: sparse:     got char const *
   net/core/pktgen.c:774:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   net/core/pktgen.c:774:21: sparse:     expected char const [noderef] __user *__ptr_clean
   net/core/pktgen.c:774:21: sparse:     got char const *
   net/core/pktgen.c:800:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   net/core/pktgen.c:800:21: sparse:     expected char const [noderef] __user *__ptr_clean
   net/core/pktgen.c:800:21: sparse:     got char const *
   net/core/pktgen.c:817:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   net/core/pktgen.c:817:21: sparse:     expected char const [noderef] __user *__ptr_clean
   net/core/pktgen.c:817:21: sparse:     got char const *
   net/core/pktgen.c:857:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   net/core/pktgen.c:857:21: sparse:     expected char const [noderef] __user *__ptr_clean
   net/core/pktgen.c:857:21: sparse:     got char const *
   net/core/pktgen.c:877:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   net/core/pktgen.c:877:21: sparse:     expected char const [noderef] __user *__ptr_clean
   net/core/pktgen.c:877:21: sparse:     got char const *
   net/core/pktgen.c:907:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   net/core/pktgen.c:907:21: sparse:     expected char const [noderef] __user *__ptr_clean
   net/core/pktgen.c:907:21: sparse:     got char const *
--
>> arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse:     expected int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse:     got int *
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse:     expected int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse:     got int *
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse:     expected int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse:     got int *
--
>> kernel/profile.c:409:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   kernel/profile.c:409:21: sparse:     expected char [noderef] __user *__ptr_clean
   kernel/profile.c:409:21: sparse:     got char *
--
>> kernel/rseq.c:110:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:110:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:110:13: sparse:     got unsigned int *
   kernel/rseq.c:117:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:117:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:117:13: sparse:     got unsigned int *
>> kernel/rseq.c:131:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/rseq.c:131:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/rseq.c:131:13: sparse:     got unsigned long long *
   kernel/rseq.c:160:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:160:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:160:15: sparse:     got unsigned int *
   kernel/rseq.c:179:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:179:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:179:15: sparse:     got unsigned int *
   kernel/rseq.c:220:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/rseq.c:220:16: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/rseq.c:220:16: sparse:     got unsigned long long *
--
>> fs/cifs/dfs_cache.c:308:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   fs/cifs/dfs_cache.c:308:14: sparse:     expected char const [noderef] __user *__ptr_clean
   fs/cifs/dfs_cache.c:308:14: sparse:     got char const *
--
>> fs/ext2/ioctl.c:65:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext2/ioctl.c:65:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext2/ioctl.c:65:24: sparse:     got int *
   fs/ext2/ioctl.c:74:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext2/ioctl.c:74:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext2/ioctl.c:74:21: sparse:     got int *
   fs/ext2/ioctl.c:94:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext2/ioctl.c:94:32: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext2/ioctl.c:94:32: sparse:     got int *
   fs/ext2/ioctl.c:105:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext2/ioctl.c:105:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext2/ioctl.c:105:21: sparse:     got int *
--
>> fs/ext4/ioctl.c:806:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:806:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:806:13: sparse:     got unsigned int *
>> fs/ext4/ioctl.c:1163:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext4/ioctl.c:1163:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1163:24: sparse:     got int *
   fs/ext4/ioctl.c:1183:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext4/ioctl.c:1183:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1183:21: sparse:     got int *
   fs/ext4/ioctl.c:1216:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:1216:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1216:21: sparse:     got unsigned int *
   fs/ext4/ioctl.c:1536:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:1536:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1536:24: sparse:     got unsigned int *
--
>> net/decnet/af_decnet.c:1537:12: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/decnet/af_decnet.c:1537:12: sparse:     expected int [noderef] __user *__ptr_clean
   net/decnet/af_decnet.c:1537:12: sparse:     got int *
   net/decnet/af_decnet.c:1632:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/decnet/af_decnet.c:1632:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/decnet/af_decnet.c:1632:21: sparse:     got int *
   net/decnet/af_decnet.c:250:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int hash @@     got restricted __le16 [usertype] sdn_objnamel @@
   net/decnet/af_decnet.c:250:22: sparse:     expected unsigned int hash
   net/decnet/af_decnet.c:250:22: sparse:     got restricted __le16 [usertype] sdn_objnamel
   net/decnet/af_decnet.c:1239:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/decnet/af_decnet.c:1239:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/decnet/af_decnet.c:1239:23: sparse:     got int *
   net/decnet/af_decnet.c:1252:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/decnet/af_decnet.c:1252:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/decnet/af_decnet.c:1252:23: sparse:     got int *
   net/decnet/af_decnet.c: note: in included file:
   include/net/dn.h:192:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] sport @@     got restricted __le16 [usertype] addrloc @@
   include/net/dn.h:192:24: sparse:     expected restricted __be16 [usertype] sport
   include/net/dn.h:192:24: sparse:     got restricted __le16 [usertype] addrloc
   include/net/dn.h:193:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] dport @@     got restricted __le16 [usertype] addrrem @@
   include/net/dn.h:193:24: sparse:     expected restricted __be16 [usertype] dport
   include/net/dn.h:193:24: sparse:     got restricted __le16 [usertype] addrrem
   net/decnet/af_decnet.c:2164:9: sparse: sparse: context imbalance in 'dn_socket_get_idx' - wrong count at exit
   net/decnet/af_decnet.c:2184:9: sparse: sparse: context imbalance in 'dn_socket_seq_next' - unexpected unlock
   net/decnet/af_decnet.c:2193:17: sparse: sparse: context imbalance in 'dn_socket_seq_stop' - unexpected unlock
--
   fs/f2fs/file.c:49:54: sparse: sparse: cast from restricted vm_fault_t
>> fs/f2fs/file.c:1986:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/f2fs/file.c:1986:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/f2fs/file.c:1986:16: sparse:     got int *
>> fs/f2fs/file.c:2214:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/f2fs/file.c:2214:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/f2fs/file.c:2214:13: sparse:     got unsigned int *
   fs/f2fs/file.c:2447:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/f2fs/file.c:2447:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/f2fs/file.c:2447:13: sparse:     got unsigned int *
   fs/f2fs/file.c:2980:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/f2fs/file.c:2980:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/f2fs/file.c:2980:16: sparse:     got unsigned int *
   fs/f2fs/file.c:3140:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/f2fs/file.c:3140:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/f2fs/file.c:3140:13: sparse:     got unsigned int *
   fs/f2fs/file.c:3197:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/f2fs/file.c:3197:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/f2fs/file.c:3197:16: sparse:     got unsigned int *
   fs/f2fs/file.c:3301:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3301:36: sparse:     expected unsigned short const [usertype] *pwcs
   fs/f2fs/file.c:3301:36: sparse:     got restricted __le16 *
   fs/f2fs/file.c:3337:28: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned short [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3337:28: sparse:     expected unsigned short [usertype] *pwcs
   fs/f2fs/file.c:3337:28: sparse:     got restricted __le16 *
>> fs/f2fs/file.c:3362:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/f2fs/file.c:3362:16: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/f2fs/file.c:3362:16: sparse:     got unsigned long long *
   fs/f2fs/file.c:3512:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/f2fs/file.c:3512:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/f2fs/file.c:3512:23: sparse:     got unsigned long long *
   fs/f2fs/file.c:3671:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/f2fs/file.c:3671:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/f2fs/file.c:3671:23: sparse:     got unsigned long long *
--
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/fat/dir.c:759:1: sparse:     expected long [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got long *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/fat/dir.c:759:1: sparse:     expected long [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got long *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
   fs/fat/dir.c:812:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:812:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:812:13: sparse:     got unsigned short *
--
>> fs/fat/file.c:32:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fat/file.c:32:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fat/file.c:32:16: sparse:     got unsigned int *
   fs/fat/file.c:44:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fat/file.c:44:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fat/file.c:44:15: sparse:     got unsigned int *
   fs/fat/file.c:122:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fat/file.c:122:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fat/file.c:122:16: sparse:     got unsigned int *
--
>> ipc/msg.c:960:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   ipc/msg.c:960:13: sparse:     expected long [noderef] __user *__ptr_clean
   ipc/msg.c:960:13: sparse:     got long *
   ipc/msg.c:1025:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   ipc/msg.c:1025:13: sparse:     expected long [noderef] __user *__ptr_clean
   ipc/msg.c:1025:13: sparse:     got long *
   ipc/msg.c:180:26: sparse: sparse: context imbalance in 'newque' - unexpected unlock
--
>> net/ipv4/ipmr.c:1568:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ipmr.c:1568:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ipmr.c:1568:13: sparse:     got int *
   net/ipv4/ipmr.c:1573:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ipmr.c:1573:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ipmr.c:1573:13: sparse:     got int *
   net/ipv4/ipmr.c:2889:13: sparse: sparse: context imbalance in 'ipmr_vif_seq_start' - different lock contexts for basic block
   net/ipv4/ipmr.c: note: in included file (through include/linux/mroute.h):
   include/linux/mroute_base.h:429:31: sparse: sparse: context imbalance in 'mr_mfc_seq_stop' - unexpected unlock
--
>> fs/xfs/xfs_ioctl.c:1420:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl.c:1421:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl.c:1422:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     got signed long long *
>> fs/xfs/xfs_ioctl.c:1423:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl.c:1424:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl.c:1428:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl.c:1429:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl.c:1430:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl.c:1431:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     got signed int *
>> fs/xfs/xfs_ioctl.c:1934:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     got int *
>> fs/xfs/xfs_ioctl.c:2096:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl.c:2096:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl.c:2096:21: sparse:     got unsigned int *
--
>> net/l2tp/l2tp_ip.c:583:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/l2tp/l2tp_ip.c:583:16: sparse:     expected int [noderef] __user *__ptr_clean
   net/l2tp/l2tp_ip.c:583:16: sparse:     got int *
--
>> net/llc/af_llc.c:1171:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/llc/af_llc.c:1171:14: sparse:     expected int [noderef] __user *__ptr_clean
   net/llc/af_llc.c:1171:14: sparse:     got int *
   net/llc/af_llc.c:1202:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/llc/af_llc.c:1202:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/llc/af_llc.c:1202:13: sparse:     got int *
--
>> net/nfc/llcp_sock.c:319:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/nfc/llcp_sock.c:319:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:319:13: sparse:     got int *
>> net/nfc/llcp_sock.c:333:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:333:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:333:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:342:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:342:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:342:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:351:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:351:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:351:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:357:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:357:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:357:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:363:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:363:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:363:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:375:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/nfc/llcp_sock.c:375:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:375:13: sparse:     got int *
--
   net/sctp/socket.c: note: in included file (through include/net/sctp/sctp.h):
   include/net/sctp/structs.h:335:41: sparse: sparse: array of flexible structures
>> net/sctp/socket.c:1423:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:1423:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:1423:21: sparse:     got int *
   net/sctp/socket.c:4922:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:4922:22: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:4922:22: sparse:     got int *
   net/sctp/socket.c:5446:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:5446:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:5446:13: sparse:     got int *
   net/sctp/socket.c:5514:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:5514:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:5514:13: sparse:     got int *
   net/sctp/socket.c:5545:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:5545:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:5545:13: sparse:     got int *
   net/sctp/socket.c:5568:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:5568:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:5568:13: sparse:     got int *
   net/sctp/socket.c:5600:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:5600:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:5600:13: sparse:     got int *
   net/sctp/socket.c:5602:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:5602:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:5602:13: sparse:     got int *
   net/sctp/socket.c:5711:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:5711:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:5711:13: sparse:     got int *
   net/sctp/socket.c:5746:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:5746:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:5746:13: sparse:     got int *
   net/sctp/socket.c:5996:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:5996:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:5996:13: sparse:     got int *
   net/sctp/socket.c:6094:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6094:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6094:13: sparse:     got int *
   net/sctp/socket.c:6116:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6116:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6116:13: sparse:     got int *
>> net/sctp/socket.c:6166:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/sctp/socket.c:6166:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6166:13: sparse:     got unsigned int *
   net/sctp/socket.c:6169:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6169:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6169:13: sparse:     got int *
   net/sctp/socket.c:6308:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/sctp/socket.c:6308:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6308:13: sparse:     got unsigned int *
   net/sctp/socket.c:6315:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6315:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6315:13: sparse:     got int *
   net/sctp/socket.c:6356:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6356:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6356:13: sparse:     got int *
   net/sctp/socket.c:6382:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6382:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6382:13: sparse:     got int *
   net/sctp/socket.c:6444:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6444:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6444:13: sparse:     got int *
   net/sctp/socket.c:6488:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6488:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6488:13: sparse:     got int *
   net/sctp/socket.c:6516:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6516:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6516:13: sparse:     got int *
   net/sctp/socket.c:6569:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6569:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6569:13: sparse:     got int *
   net/sctp/socket.c:6639:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6639:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6639:13: sparse:     got int *
   net/sctp/socket.c:6669:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6669:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6669:13: sparse:     got int *
   net/sctp/socket.c:6703:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6703:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6703:13: sparse:     got int *
   net/sctp/socket.c:6768:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6768:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6768:13: sparse:     got int *
   net/sctp/socket.c:6796:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6796:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6796:13: sparse:     got int *
   net/sctp/socket.c:6820:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6820:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6820:13: sparse:     got int *
   net/sctp/socket.c:6895:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6895:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6895:13: sparse:     got int *
   net/sctp/socket.c:6897:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/sctp/socket.c:6897:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6897:13: sparse:     got unsigned int *
   net/sctp/socket.c:6936:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6936:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6936:13: sparse:     got int *
   net/sctp/socket.c:6981:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:6981:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6981:13: sparse:     got int *
   net/sctp/socket.c:6983:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/sctp/socket.c:6983:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/sctp/socket.c:6983:13: sparse:     got unsigned int *
   net/sctp/socket.c:7031:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7031:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7031:13: sparse:     got int *
   net/sctp/socket.c:7033:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/sctp/socket.c:7033:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7033:13: sparse:     got unsigned int *
   net/sctp/socket.c:7063:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7063:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7063:13: sparse:     got int *
   net/sctp/socket.c:7086:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7086:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7086:13: sparse:     got int *
   net/sctp/socket.c:7133:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7133:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7133:13: sparse:     got int *
   net/sctp/socket.c:7196:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7196:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7196:13: sparse:     got int *
   net/sctp/socket.c:7255:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7255:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7255:13: sparse:     got int *
   net/sctp/socket.c:7278:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7278:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7278:13: sparse:     got int *
   net/sctp/socket.c:7298:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7298:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7298:13: sparse:     got int *
   net/sctp/socket.c:7333:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7333:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7333:13: sparse:     got int *
   net/sctp/socket.c:7379:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7379:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7379:13: sparse:     got int *
   net/sctp/socket.c:7434:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7434:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/sctp/socket.c:7434:13: sparse:     got int *
   net/sctp/socket.c:7503:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sctp/socket.c:7503:13: sparse:     expected int [noderef] __user *__ptr_clean

vim +2705 net/smc/af_smc.c

ac7138746e14137 Ursula Braun 2017-01-09  2696  
a6a6fe27bab48f0 D. Wythe     2022-02-10  2697  static int __smc_getsockopt(struct socket *sock, int level, int optname,
a6a6fe27bab48f0 D. Wythe     2022-02-10  2698  			    char __user *optval, int __user *optlen)
a6a6fe27bab48f0 D. Wythe     2022-02-10  2699  {
a6a6fe27bab48f0 D. Wythe     2022-02-10  2700  	struct smc_sock *smc;
a6a6fe27bab48f0 D. Wythe     2022-02-10  2701  	int val, len;
a6a6fe27bab48f0 D. Wythe     2022-02-10  2702  
a6a6fe27bab48f0 D. Wythe     2022-02-10  2703  	smc = smc_sk(sock->sk);
a6a6fe27bab48f0 D. Wythe     2022-02-10  2704  
a6a6fe27bab48f0 D. Wythe     2022-02-10 @2705  	if (get_user(len, optlen))
a6a6fe27bab48f0 D. Wythe     2022-02-10  2706  		return -EFAULT;
a6a6fe27bab48f0 D. Wythe     2022-02-10  2707  
a6a6fe27bab48f0 D. Wythe     2022-02-10  2708  	len = min_t(int, len, sizeof(int));
a6a6fe27bab48f0 D. Wythe     2022-02-10  2709  
a6a6fe27bab48f0 D. Wythe     2022-02-10  2710  	if (len < 0)
a6a6fe27bab48f0 D. Wythe     2022-02-10  2711  		return -EINVAL;
a6a6fe27bab48f0 D. Wythe     2022-02-10  2712  
a6a6fe27bab48f0 D. Wythe     2022-02-10  2713  	switch (optname) {
a6a6fe27bab48f0 D. Wythe     2022-02-10  2714  	case SMC_LIMIT_HS:
a6a6fe27bab48f0 D. Wythe     2022-02-10  2715  		val = smc->limit_smc_hs;
a6a6fe27bab48f0 D. Wythe     2022-02-10  2716  		break;
a6a6fe27bab48f0 D. Wythe     2022-02-10  2717  	default:
a6a6fe27bab48f0 D. Wythe     2022-02-10  2718  		return -EOPNOTSUPP;
a6a6fe27bab48f0 D. Wythe     2022-02-10  2719  	}
a6a6fe27bab48f0 D. Wythe     2022-02-10  2720  
a6a6fe27bab48f0 D. Wythe     2022-02-10  2721  	if (put_user(len, optlen))
a6a6fe27bab48f0 D. Wythe     2022-02-10  2722  		return -EFAULT;
a6a6fe27bab48f0 D. Wythe     2022-02-10  2723  	if (copy_to_user(optval, &val, len))
a6a6fe27bab48f0 D. Wythe     2022-02-10  2724  		return -EFAULT;
a6a6fe27bab48f0 D. Wythe     2022-02-10  2725  
a6a6fe27bab48f0 D. Wythe     2022-02-10  2726  	return 0;
a6a6fe27bab48f0 D. Wythe     2022-02-10  2727  }
a6a6fe27bab48f0 D. Wythe     2022-02-10  2728  

:::::: The code at line 2705 was first introduced by commit
:::::: a6a6fe27bab48f0d09a64b051e7bde432fcae081 net/smc: Dynamic control handshake limitation by socket options

:::::: TO: D. Wythe <alibuda@linux.alibaba.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
