Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13724F81E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344107AbiDGOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344125AbiDGOjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:39:09 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D6E168D6F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649342221; x=1680878221;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wid2ezEob6rJE0VytFKxDsGPND7ITVZMWidLpzYU9WY=;
  b=GAIDC2EYaYCkrqAZtPi73845D1iotVcEk3sKnI749ySBk7VWRYMgfHG8
   McEYbrMREb8/HxLolUM1aj8NkPWOmTORaxG7/YLvdExsQnvUxojj7X29x
   Rfv1+Cm/kfSPjuTX1+iJrj4RXarXn2+Ugtys2s+iri0qfpaGG5MWyRzkL
   dNVAMM37EYI5lj3q1krMkX61oFA3WEbveo4UUvh1Ao2m2rA+ULpWdchE/
   Z2uNRK1eAOe7uzr3Res+5E9gMrPktFcz0AKoJ+9zaBhZvgNB9WkHfrQoo
   G0y/tiL9uHeC3UeCxZYzbArmI72G+dMaiOGxKXw+e4w1/xenXCQkP4kQ1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="322029008"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="322029008"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 07:35:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="642504142"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2022 07:35:47 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncTEg-0005VD-Bq;
        Thu, 07 Apr 2022 14:35:46 +0000
Date:   Thu, 7 Apr 2022 22:35:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 6/10] drivers/scsi/scsi_ioctl.c:49:21: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202204072240.us5nOO6H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   73447e771c55e18598a6fbf6adee1002aee18ea0
commit: 92948bd2c12648f2fb8256ae69dd092ce4398a3a [6/10] x86/uaccess: Remove tags from the address before checking
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220407/202204072240.us5nOO6H-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=92948bd2c12648f2fb8256ae69dd092ce4398a3a
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 92948bd2c12648f2fb8256ae69dd092ce4398a3a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/mce/ block/ drivers/acpi/ drivers/android/ drivers/ata/ drivers/block/ drivers/comedi/ drivers/fpga/ drivers/infiniband/core/ drivers/nvme/host/ drivers/platform/x86/ drivers/scsi/ drivers/usb/gadget/function/ drivers/vdpa/vdpa_user/ drivers/vhost/ fs/cifs/ fs/ext2/ fs/ext4/ fs/f2fs/ fs/jfs/ fs/reiserfs/ fs/xfs/ kernel/ net/bluetooth/ net/core/ net/decnet/ net/ipv4/ net/l2tp/ net/llc/ net/nfc/ net/sctp/ net/smc/ net/tipc/ net/tls/ sound/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/scsi_ioctl.c:49:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:49:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:49:21: sparse:     got unsigned int *__ptr_clean
>> drivers/scsi/scsi_ioctl.c:173:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:173:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:173:16: sparse:     got int *__ptr_clean
>> drivers/scsi/scsi_ioctl.c:173:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:173:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/scsi/scsi_ioctl.c:173:16: sparse:     got int *__ptr_clean
   drivers/scsi/scsi_ioctl.c:178:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:178:28: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:178:28: sparse:     got int *__ptr_clean
   drivers/scsi/scsi_ioctl.c:191:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:191:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:191:16: sparse:     got int *__ptr_clean
   drivers/scsi/scsi_ioctl.c:191:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:191:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/scsi/scsi_ioctl.c:191:16: sparse:     got int *__ptr_clean
   drivers/scsi/scsi_ioctl.c:196:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:196:25: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:196:25: sparse:     got int *__ptr_clean
   drivers/scsi/scsi_ioctl.c:215:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:215:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:215:16: sparse:     got int *__ptr_clean
   drivers/scsi/scsi_ioctl.c:215:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:215:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/scsi/scsi_ioctl.c:215:16: sparse:     got int *__ptr_clean
   drivers/scsi/scsi_ioctl.c:532:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:532:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:532:13: sparse:     got unsigned int *__ptr_clean
   drivers/scsi/scsi_ioctl.c:534:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:534:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:534:13: sparse:     got unsigned int *__ptr_clean
>> drivers/scsi/scsi_ioctl.c:538:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:538:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:538:13: sparse:     got unsigned char *__ptr_clean
   drivers/scsi/scsi_ioctl.c:924:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:924:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:924:24: sparse:     got int *__ptr_clean
   drivers/scsi/scsi_ioctl.c:924:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/scsi/scsi_ioctl.c:924:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/scsi/scsi_ioctl.c:924:24: sparse:     got int *__ptr_clean
--
>> drivers/scsi/scsi_error.c:2388:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/scsi/scsi_error.c:2388:17: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_error.c:2388:17: sparse:     got int *__ptr_clean
--
>> drivers/scsi/ch.c:552:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   drivers/scsi/ch.c:552:17: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/ch.c:552:17: sparse:     got unsigned char *__ptr_clean
>> drivers/scsi/ch.c:552:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned char *__ptr_clean @@
   drivers/scsi/ch.c:552:17: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/scsi/ch.c:552:17: sparse:     got unsigned char *__ptr_clean
--
   drivers/scsi/st.c: note: in included file:
>> include/linux/mtio.h:55:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   include/linux/mtio.h:55:24: sparse:     expected void const volatile [noderef] __user *ptr
   include/linux/mtio.h:55:24: sparse:     got unsigned int *__ptr_clean
>> include/linux/mtio.h:55:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   include/linux/mtio.h:55:24: sparse:     expected void [noderef] __user *__ptr_pu
   include/linux/mtio.h:55:24: sparse:     got unsigned int *__ptr_clean
>> include/linux/mtio.h:57:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   include/linux/mtio.h:57:24: sparse:     expected void const volatile [noderef] __user *ptr
   include/linux/mtio.h:57:24: sparse:     got long *__ptr_clean
>> include/linux/mtio.h:57:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   include/linux/mtio.h:57:24: sparse:     expected void [noderef] __user *__ptr_pu
   include/linux/mtio.h:57:24: sparse:     got long *__ptr_clean
--
>> drivers/usb/gadget/function/rndis.c:1138:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/usb/gadget/function/rndis.c:1138:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/gadget/function/rndis.c:1138:21: sparse:     got char const *__ptr_clean
--
>> drivers/vdpa/vdpa_user/vduse_dev.c:975:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/vdpa/vdpa_user/vduse_dev.c:975:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vdpa/vdpa_user/vduse_dev.c:975:23: sparse:     got unsigned long long *__ptr_clean
>> drivers/vdpa/vdpa_user/vduse_dev.c:975:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/vdpa/vdpa_user/vduse_dev.c:975:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/vdpa/vdpa_user/vduse_dev.c:975:23: sparse:     got unsigned long long *__ptr_clean
>> drivers/vdpa/vdpa_user/vduse_dev.c:1080:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/vdpa/vdpa_user/vduse_dev.c:1080:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vdpa/vdpa_user/vduse_dev.c:1080:21: sparse:     got unsigned int *__ptr_clean
   drivers/vdpa/vdpa_user/vduse_dev.c:1381:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/vdpa/vdpa_user/vduse_dev.c:1381:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vdpa/vdpa_user/vduse_dev.c:1381:23: sparse:     got unsigned long long *__ptr_clean
   drivers/vdpa/vdpa_user/vduse_dev.c:1381:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/vdpa/vdpa_user/vduse_dev.c:1381:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/vdpa/vdpa_user/vduse_dev.c:1381:23: sparse:     got unsigned long long *__ptr_clean
   drivers/vdpa/vdpa_user/vduse_dev.c:1387:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/vdpa/vdpa_user/vduse_dev.c:1387:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vdpa/vdpa_user/vduse_dev.c:1387:21: sparse:     got unsigned long long *__ptr_clean
--
>> drivers/vhost/scsi.c:1872:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/vhost/scsi.c:1872:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/scsi.c:1872:21: sparse:     got unsigned int *__ptr_clean
   drivers/vhost/scsi.c:1882:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/vhost/scsi.c:1882:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/scsi.c:1882:21: sparse:     got unsigned int *__ptr_clean
>> drivers/vhost/scsi.c:1882:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/vhost/scsi.c:1882:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/vhost/scsi.c:1882:21: sparse:     got unsigned int *__ptr_clean
--
>> drivers/vhost/vhost.c:1602:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/vhost/vhost.c:1602:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vhost.c:1602:13: sparse:     got unsigned int *__ptr_clean
>> drivers/vhost/vhost.c:1800:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/vhost/vhost.c:1800:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vhost.c:1800:21: sparse:     got int *__ptr_clean
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
>> drivers/infiniband/core/user_mad.c:749:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/infiniband/core/user_mad.c:749:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/infiniband/core/user_mad.c:749:13: sparse:     got unsigned int *__ptr_clean
>> drivers/infiniband/core/user_mad.c:749:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/infiniband/core/user_mad.c:749:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/infiniband/core/user_mad.c:749:13: sparse:     got unsigned int *__ptr_clean
   drivers/infiniband/core/user_mad.c:815:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/infiniband/core/user_mad.c:815:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/infiniband/core/user_mad.c:815:21: sparse:     got unsigned int *__ptr_clean
   drivers/infiniband/core/user_mad.c:815:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/infiniband/core/user_mad.c:815:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/infiniband/core/user_mad.c:815:21: sparse:     got unsigned int *__ptr_clean
   drivers/infiniband/core/user_mad.c:863:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/infiniband/core/user_mad.c:863:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/infiniband/core/user_mad.c:863:13: sparse:     got unsigned int *__ptr_clean
   drivers/infiniband/core/user_mad.c:863:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/infiniband/core/user_mad.c:863:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/infiniband/core/user_mad.c:863:13: sparse:     got unsigned int *__ptr_clean
   drivers/infiniband/core/user_mad.c:896:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/infiniband/core/user_mad.c:896:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/infiniband/core/user_mad.c:896:13: sparse:     got unsigned int *__ptr_clean
--
>> drivers/infiniband/core/uverbs_main.c:632:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long const *__ptr_clean @@
   drivers/infiniband/core/uverbs_main.c:632:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/infiniband/core/uverbs_main.c:632:31: sparse:     got unsigned long long const *__ptr_clean
--
>> drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse:     got unsigned short *__ptr_clean
>> drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse:     got unsigned short *__ptr_clean
>> drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse:     got unsigned long long *__ptr_clean
>> drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse:     got unsigned long long *__ptr_clean
   drivers/infiniband/core/uverbs_ioctl.c:423:17: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected int ( *handler )( ... ) @@     got int ( [noderef] * )( ... ) @@
   drivers/infiniband/core/uverbs_ioctl.c:423:17: sparse:     expected int ( *handler )( ... )
   drivers/infiniband/core/uverbs_ioctl.c:423:17: sparse:     got int ( [noderef] * )( ... )
--
>> net/tipc/socket.c:3242:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/tipc/socket.c:3242:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/tipc/socket.c:3242:24: sparse:     got int *__ptr_clean
>> net/tipc/socket.c:3242:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/tipc/socket.c:3242:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/tipc/socket.c:3242:24: sparse:     got int *__ptr_clean
   net/tipc/socket.c:3245:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/tipc/socket.c:3245:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/tipc/socket.c:3245:15: sparse:     got int *__ptr_clean
   net/tipc/socket.c:3295:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/tipc/socket.c:3295:16: sparse:     expected void const volatile [noderef] __user *ptr
   net/tipc/socket.c:3295:16: sparse:     got int *__ptr_clean
   net/tipc/socket.c:3295:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/tipc/socket.c:3295:16: sparse:     expected void [noderef] __user *__ptr_pu
   net/tipc/socket.c:3295:16: sparse:     got int *__ptr_clean
--
   net/sctp/socket.c: note: in included file (through include/net/sctp/sctp.h):
   include/net/sctp/structs.h:335:41: sparse: sparse: array of flexible structures
>> net/sctp/socket.c:1423:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:1423:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:1423:21: sparse:     got int *__ptr_clean
>> net/sctp/socket.c:1423:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:1423:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:1423:21: sparse:     got int *__ptr_clean
   net/sctp/socket.c:4922:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:4922:22: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:4922:22: sparse:     got int *__ptr_clean
   net/sctp/socket.c:4922:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:4922:22: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:4922:22: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5446:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:5446:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:5446:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5446:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:5446:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:5446:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5514:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:5514:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:5514:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5514:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:5514:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:5514:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5545:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:5545:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:5545:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5545:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:5545:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:5545:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5568:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:5568:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:5568:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5568:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:5568:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:5568:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5600:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:5600:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:5600:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5600:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:5600:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:5600:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5602:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:5602:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:5602:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5602:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:5602:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:5602:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5711:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:5711:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:5711:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5711:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:5711:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:5711:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5746:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:5746:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:5746:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5746:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:5746:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:5746:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5996:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:5996:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:5996:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:5996:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:5996:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:5996:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6094:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6094:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6094:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6094:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6094:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6094:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6116:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6116:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6116:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6116:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6116:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6116:13: sparse:     got int *__ptr_clean
>> net/sctp/socket.c:6166:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/sctp/socket.c:6166:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6166:13: sparse:     got unsigned int *__ptr_clean
>> net/sctp/socket.c:6166:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/sctp/socket.c:6166:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6166:13: sparse:     got unsigned int *__ptr_clean
   net/sctp/socket.c:6169:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6169:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6169:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6169:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6169:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6169:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6308:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/sctp/socket.c:6308:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6308:13: sparse:     got unsigned int *__ptr_clean
   net/sctp/socket.c:6308:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/sctp/socket.c:6308:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6308:13: sparse:     got unsigned int *__ptr_clean
   net/sctp/socket.c:6315:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6315:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6315:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6315:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6315:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6315:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6356:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6356:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6356:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6356:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6356:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6356:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6382:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6382:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6382:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6382:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6382:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6382:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6444:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6444:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6444:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6444:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6444:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6444:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6488:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6488:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6488:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6488:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6488:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6488:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6516:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6516:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6516:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6516:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6516:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6516:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6569:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6569:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6569:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6569:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6569:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6569:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6639:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6639:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6639:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6639:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6639:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6639:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6669:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6669:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6669:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6669:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6669:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6669:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6703:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6703:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6703:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6703:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6703:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6703:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6768:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6768:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6768:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6768:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6768:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6768:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6796:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6796:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6796:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6796:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6796:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6796:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6820:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6820:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6820:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6820:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6820:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6820:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6895:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sctp/socket.c:6895:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:6895:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6895:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sctp/socket.c:6895:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/sctp/socket.c:6895:13: sparse:     got int *__ptr_clean
   net/sctp/socket.c:6897:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/sctp/socket.c:6897:13: sparse:     expected void const volatile [noderef] __user *ptr
--
>> net/tls/tls_main.c:344:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/tls/tls_main.c:344:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/tls/tls_main.c:344:13: sparse:     got int *__ptr_clean
--
>> drivers/nvme/host/ioctl.c:246:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/nvme/host/ioctl.c:246:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/nvme/host/ioctl.c:246:21: sparse:     got unsigned int *__ptr_clean
>> drivers/nvme/host/ioctl.c:246:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/nvme/host/ioctl.c:246:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/nvme/host/ioctl.c:246:21: sparse:     got unsigned int *__ptr_clean
>> drivers/nvme/host/ioctl.c:292:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/nvme/host/ioctl.c:292:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/nvme/host/ioctl.c:292:21: sparse:     got unsigned long long *__ptr_clean
>> drivers/nvme/host/ioctl.c:292:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/nvme/host/ioctl.c:292:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/nvme/host/ioctl.c:292:21: sparse:     got unsigned long long *__ptr_clean
--
>> drivers/platform/x86/wmi.c:903:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/platform/x86/wmi.c:903:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/platform/x86/wmi.c:903:13: sparse:     got unsigned long long *__ptr_clean
--
>> arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse:     got int *__ptr_clean
>> arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse:     got int *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse:     got int *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse:     got int *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse:     got int *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse:     got int *__ptr_clean
--
   kernel/rseq.c:110:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:110:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/rseq.c:110:13: sparse:     got unsigned int *__ptr_clean
   kernel/rseq.c:110:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:110:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/rseq.c:110:13: sparse:     got unsigned int *__ptr_clean
   kernel/rseq.c:117:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:117:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/rseq.c:117:13: sparse:     got unsigned int *__ptr_clean
   kernel/rseq.c:117:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:117:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/rseq.c:117:13: sparse:     got unsigned int *__ptr_clean
>> kernel/rseq.c:131:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   kernel/rseq.c:131:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/rseq.c:131:13: sparse:     got unsigned long long *__ptr_clean
   kernel/rseq.c:160:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:160:15: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/rseq.c:160:15: sparse:     got unsigned int *__ptr_clean
   kernel/rseq.c:179:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:179:15: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/rseq.c:179:15: sparse:     got unsigned int *__ptr_clean
   kernel/rseq.c:220:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   kernel/rseq.c:220:16: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/rseq.c:220:16: sparse:     got unsigned long long *__ptr_clean
>> kernel/rseq.c:220:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   kernel/rseq.c:220:16: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/rseq.c:220:16: sparse:     got unsigned long long *__ptr_clean
--
>> fs/cifs/dfs_cache.c:308:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   fs/cifs/dfs_cache.c:308:14: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/dfs_cache.c:308:14: sparse:     got char const *__ptr_clean
--
>> fs/ext2/ioctl.c:65:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ext2/ioctl.c:65:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:65:24: sparse:     got int *__ptr_clean
>> fs/ext2/ioctl.c:65:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/ext2/ioctl.c:65:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ext2/ioctl.c:65:24: sparse:     got int *__ptr_clean
   fs/ext2/ioctl.c:74:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ext2/ioctl.c:74:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:74:21: sparse:     got int *__ptr_clean
   fs/ext2/ioctl.c:94:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ext2/ioctl.c:94:32: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:94:32: sparse:     got int *__ptr_clean
   fs/ext2/ioctl.c:94:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/ext2/ioctl.c:94:32: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ext2/ioctl.c:94:32: sparse:     got int *__ptr_clean
   fs/ext2/ioctl.c:105:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ext2/ioctl.c:105:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:105:21: sparse:     got int *__ptr_clean
--
>> fs/ext4/ioctl.c:806:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/ext4/ioctl.c:806:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext4/ioctl.c:806:13: sparse:     got unsigned int *__ptr_clean
>> fs/ext4/ioctl.c:1163:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ext4/ioctl.c:1163:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext4/ioctl.c:1163:24: sparse:     got int *__ptr_clean
>> fs/ext4/ioctl.c:1163:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/ext4/ioctl.c:1163:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ext4/ioctl.c:1163:24: sparse:     got int *__ptr_clean
   fs/ext4/ioctl.c:1183:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ext4/ioctl.c:1183:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext4/ioctl.c:1183:21: sparse:     got int *__ptr_clean
   fs/ext4/ioctl.c:1216:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/ext4/ioctl.c:1216:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext4/ioctl.c:1216:21: sparse:     got unsigned int *__ptr_clean
   fs/ext4/ioctl.c:1536:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/ext4/ioctl.c:1536:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext4/ioctl.c:1536:24: sparse:     got unsigned int *__ptr_clean
>> fs/ext4/ioctl.c:1536:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/ext4/ioctl.c:1536:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ext4/ioctl.c:1536:24: sparse:     got unsigned int *__ptr_clean
--
   fs/f2fs/file.c:49:54: sparse: sparse: cast from restricted vm_fault_t
>> fs/f2fs/file.c:1986:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/f2fs/file.c:1986:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:1986:16: sparse:     got int *__ptr_clean
>> fs/f2fs/file.c:1986:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/f2fs/file.c:1986:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:1986:16: sparse:     got int *__ptr_clean
>> fs/f2fs/file.c:2214:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:2214:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:2214:13: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:2447:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:2447:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:2447:13: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:2980:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:2980:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:2980:16: sparse:     got unsigned int *__ptr_clean
>> fs/f2fs/file.c:2980:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:2980:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:2980:16: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:3140:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:3140:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3140:13: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:3197:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:3197:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3197:16: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:3197:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:3197:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:3197:16: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:3301:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3301:36: sparse:     expected unsigned short const [usertype] *pwcs
   fs/f2fs/file.c:3301:36: sparse:     got restricted __le16 *
   fs/f2fs/file.c:3337:28: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned short [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3337:28: sparse:     expected unsigned short [usertype] *pwcs
   fs/f2fs/file.c:3337:28: sparse:     got restricted __le16 *
>> fs/f2fs/file.c:3362:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3362:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3362:16: sparse:     got unsigned long long *__ptr_clean
>> fs/f2fs/file.c:3362:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3362:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:3362:16: sparse:     got unsigned long long *__ptr_clean
   fs/f2fs/file.c:3512:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3512:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3512:23: sparse:     got unsigned long long *__ptr_clean
   fs/f2fs/file.c:3512:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3512:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:3512:23: sparse:     got unsigned long long *__ptr_clean
   fs/f2fs/file.c:3671:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3671:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3671:23: sparse:     got unsigned long long *__ptr_clean
   fs/f2fs/file.c:3671:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3671:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:3671:23: sparse:     got unsigned long long *__ptr_clean
--
>> fs/jfs/jfs_debug.c:36:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   fs/jfs/jfs_debug.c:36:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/jfs/jfs_debug.c:36:13: sparse:     got char const *__ptr_clean
--
>> fs/reiserfs/ioctl.c:96:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/reiserfs/ioctl.c:96:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/reiserfs/ioctl.c:96:23: sparse:     got int *__ptr_clean
>> fs/reiserfs/ioctl.c:96:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/reiserfs/ioctl.c:96:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/reiserfs/ioctl.c:96:23: sparse:     got int *__ptr_clean
   fs/reiserfs/ioctl.c:106:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/reiserfs/ioctl.c:106:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/reiserfs/ioctl.c:106:21: sparse:     got int *__ptr_clean
--
>> block/bsg.c:87:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/bsg.c:87:16: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:87:16: sparse:     got int *__ptr_clean
>> block/bsg.c:87:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   block/bsg.c:87:16: sparse:     expected void [noderef] __user *__ptr_pu
   block/bsg.c:87:16: sparse:     got int *__ptr_clean
   block/bsg.c:94:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/bsg.c:94:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:94:13: sparse:     got int *__ptr_clean
   block/bsg.c:123:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/bsg.c:123:24: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:123:24: sparse:     got int *__ptr_clean
   block/bsg.c:123:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   block/bsg.c:123:24: sparse:     expected void [noderef] __user *__ptr_pu
   block/bsg.c:123:24: sparse:     got int *__ptr_clean
   block/bsg.c:125:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/bsg.c:125:24: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:125:24: sparse:     got int *__ptr_clean
   block/bsg.c:125:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   block/bsg.c:125:24: sparse:     expected void [noderef] __user *__ptr_pu
   block/bsg.c:125:24: sparse:     got int *__ptr_clean
   block/bsg.c:127:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/bsg.c:127:24: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:127:24: sparse:     got int *__ptr_clean
   block/bsg.c:127:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   block/bsg.c:127:24: sparse:     expected void [noderef] __user *__ptr_pu
   block/bsg.c:127:24: sparse:     got int *__ptr_clean
   block/bsg.c:129:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/bsg.c:129:21: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:129:21: sparse:     got int *__ptr_clean
   block/bsg.c:136:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/bsg.c:136:24: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:136:24: sparse:     got int *__ptr_clean
   block/bsg.c:136:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   block/bsg.c:136:24: sparse:     expected void [noderef] __user *__ptr_pu
   block/bsg.c:136:24: sparse:     got int *__ptr_clean
   block/bsg.c:139:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/bsg.c:139:21: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:139:21: sparse:     got int *__ptr_clean
   block/bsg.c:147:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/bsg.c:147:24: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:147:24: sparse:     got int *__ptr_clean
   block/bsg.c:147:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   block/bsg.c:147:24: sparse:     expected void [noderef] __user *__ptr_pu
   block/bsg.c:147:24: sparse:     got int *__ptr_clean
--
>> drivers/acpi/ec_sys.c:53:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   drivers/acpi/ec_sys.c:53:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/acpi/ec_sys.c:53:21: sparse:     got char *__ptr_clean
>> drivers/acpi/ec_sys.c:53:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   drivers/acpi/ec_sys.c:53:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/acpi/ec_sys.c:53:21: sparse:     got char *__ptr_clean
>> drivers/acpi/ec_sys.c:87:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/acpi/ec_sys.c:87:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/acpi/ec_sys.c:87:21: sparse:     got char const *__ptr_clean
--
>> sound/core/compress_offload.c:975:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/compress_offload.c:975:26: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/compress_offload.c:975:26: sparse:     got int *__ptr_clean
>> sound/core/compress_offload.c:975:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/compress_offload.c:975:26: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/compress_offload.c:975:26: sparse:     got int *__ptr_clean
--
>> net/bluetooth/af_bluetooth.c:511:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/af_bluetooth.c:511:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/af_bluetooth.c:511:23: sparse:     got int *__ptr_clean
>> net/bluetooth/af_bluetooth.c:511:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/bluetooth/af_bluetooth.c:511:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/af_bluetooth.c:511:23: sparse:     got int *__ptr_clean
   net/bluetooth/af_bluetooth.c:522:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/af_bluetooth.c:522:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/af_bluetooth.c:522:23: sparse:     got int *__ptr_clean
   net/bluetooth/af_bluetooth.c:522:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/bluetooth/af_bluetooth.c:522:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/af_bluetooth.c:522:23: sparse:     got int *__ptr_clean
   net/bluetooth/af_bluetooth.c:176:25: sparse: sparse: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
--
>> net/bluetooth/hci_core.c:825:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/bluetooth/hci_core.c:825:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_core.c:825:13: sparse:     got unsigned short *__ptr_clean
--
>> net/bluetooth/hci_sock.c:1968:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/hci_sock.c:1968:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:1968:13: sparse:     got int *__ptr_clean
>> net/bluetooth/hci_sock.c:1985:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/bluetooth/hci_sock.c:1985:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:1985:21: sparse:     got char *__ptr_clean
>> net/bluetooth/hci_sock.c:1985:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/bluetooth/hci_sock.c:1985:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/hci_sock.c:1985:21: sparse:     got char *__ptr_clean
   net/bluetooth/hci_sock.c:1995:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/bluetooth/hci_sock.c:1995:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:1995:21: sparse:     got char *__ptr_clean
   net/bluetooth/hci_sock.c:1995:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/bluetooth/hci_sock.c:1995:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/hci_sock.c:1995:21: sparse:     got char *__ptr_clean
>> net/bluetooth/hci_sock.c:2045:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/bluetooth/hci_sock.c:2045:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:2045:21: sparse:     got unsigned short *__ptr_clean
>> net/bluetooth/hci_sock.c:2045:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   net/bluetooth/hci_sock.c:2045:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/hci_sock.c:2045:21: sparse:     got unsigned short *__ptr_clean
--
>> net/bluetooth/l2cap_sock.c:464:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:464:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:464:13: sparse:     got int *__ptr_clean
>> net/bluetooth/l2cap_sock.c:539:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:539:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:539:21: sparse:     got unsigned int *__ptr_clean
>> net/bluetooth/l2cap_sock.c:539:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:539:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:539:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:589:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:589:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:589:13: sparse:     got int *__ptr_clean
   net/bluetooth/l2cap_sock.c:625:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:625:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:625:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:625:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:625:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:625:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:632:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:632:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:632:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:632:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:632:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:632:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:654:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:654:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:654:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:654:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:654:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:654:21: sparse:     got unsigned int *__ptr_clean
>> net/bluetooth/l2cap_sock.c:669:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:669:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:669:21: sparse:     got unsigned short *__ptr_clean
>> net/bluetooth/l2cap_sock.c:669:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:669:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:669:21: sparse:     got unsigned short *__ptr_clean
   net/bluetooth/l2cap_sock.c:679:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:679:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:679:21: sparse:     got unsigned short *__ptr_clean
   net/bluetooth/l2cap_sock.c:679:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:679:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:679:21: sparse:     got unsigned short *__ptr_clean
   net/bluetooth/l2cap_sock.c:691:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:691:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:691:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:691:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:691:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:691:21: sparse:     got unsigned int *__ptr_clean
>> net/bluetooth/l2cap_sock.c:712:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:712:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:712:21: sparse:     got unsigned char *__ptr_clean
>> net/bluetooth/l2cap_sock.c:712:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned char *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:712:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:712:21: sparse:     got unsigned char *__ptr_clean
--
>> drivers/android/binder.c:3555:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:3555:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3555:21: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:3575:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:3575:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3575:29: sparse:     got unsigned int *__ptr_clean
>> drivers/android/binder.c:3642:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/android/binder.c:3642:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3642:29: sparse:     got unsigned long long *__ptr_clean
   drivers/android/binder.c:3645:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/android/binder.c:3645:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3645:29: sparse:     got unsigned long long *__ptr_clean
   drivers/android/binder.c:3714:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/android/binder.c:3714:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3714:29: sparse:     got unsigned long long *__ptr_clean
   drivers/android/binder.c:3811:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:3811:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3811:29: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:3814:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/android/binder.c:3814:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3814:29: sparse:     got unsigned long long *__ptr_clean
   drivers/android/binder.c:3933:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/android/binder.c:3933:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:3933:29: sparse:     got unsigned long long *__ptr_clean
   drivers/android/binder.c:4009:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4009:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:4009:13: sparse:     got unsigned int *__ptr_clean
>> drivers/android/binder.c:4009:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4009:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:4009:13: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4013:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/android/binder.c:4013:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:4013:13: sparse:     got unsigned long long *__ptr_clean
>> drivers/android/binder.c:4013:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/android/binder.c:4013:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:4013:13: sparse:     got unsigned long long *__ptr_clean
   drivers/android/binder.c:4017:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/android/binder.c:4017:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:4017:13: sparse:     got unsigned long long *__ptr_clean
   drivers/android/binder.c:4017:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/android/binder.c:4017:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:4017:13: sparse:     got unsigned long long *__ptr_clean
   drivers/android/binder.c:4140:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4140:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:4140:21: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4140:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4140:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:4140:21: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4222:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4222:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:4222:29: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4222:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4222:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:4222:29: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4240:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4240:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:4240:29: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4240:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4240:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:4240:29: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4366:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4366:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:4366:29: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4366:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4366:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:4366:29: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4369:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/android/binder.c:4369:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:4369:29: sparse:     got unsigned long long *__ptr_clean
   drivers/android/binder.c:4369:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/android/binder.c:4369:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:4369:29: sparse:     got unsigned long long *__ptr_clean
   drivers/android/binder.c:4441:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4441:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:4441:37: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4441:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4441:37: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:4441:37: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4461:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4461:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:4461:21: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4461:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4461:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:4461:21: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4526:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4526:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:4526:21: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4526:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/android/binder.c:4526:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:4526:21: sparse:     got unsigned int *__ptr_clean
   drivers/android/binder.c:4780:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int @@
   drivers/android/binder.c:4780:24: sparse:     expected restricted __poll_t
   drivers/android/binder.c:4780:24: sparse:     got int
>> drivers/android/binder.c:5139:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/android/binder.c:5139:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/android/binder.c:5139:21: sparse:     got signed int *__ptr_clean
>> drivers/android/binder.c:5139:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/android/binder.c:5139:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/android/binder.c:5139:21: sparse:     got signed int *__ptr_clean
--
>> net/core/pktgen.c:756:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   net/core/pktgen.c:756:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:756:21: sparse:     got char const *__ptr_clean
   net/core/pktgen.c:774:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   net/core/pktgen.c:774:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:774:21: sparse:     got char const *__ptr_clean
   net/core/pktgen.c:800:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   net/core/pktgen.c:800:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:800:21: sparse:     got char const *__ptr_clean
   net/core/pktgen.c:817:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   net/core/pktgen.c:817:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:817:21: sparse:     got char const *__ptr_clean
   net/core/pktgen.c:857:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   net/core/pktgen.c:857:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:857:21: sparse:     got char const *__ptr_clean
   net/core/pktgen.c:877:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   net/core/pktgen.c:877:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:877:21: sparse:     got char const *__ptr_clean
   net/core/pktgen.c:907:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   net/core/pktgen.c:907:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:907:21: sparse:     got char const *__ptr_clean
--
>> net/decnet/af_decnet.c:1537:12: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1537:12: sparse:     expected void const volatile [noderef] __user *ptr
   net/decnet/af_decnet.c:1537:12: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c:1632:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1632:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/decnet/af_decnet.c:1632:21: sparse:     got int *__ptr_clean
>> net/decnet/af_decnet.c:1632:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1632:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/decnet/af_decnet.c:1632:21: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c:250:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int hash @@     got restricted __le16 [usertype] sdn_objnamel @@
   net/decnet/af_decnet.c:250:22: sparse:     expected unsigned int hash
   net/decnet/af_decnet.c:250:22: sparse:     got restricted __le16 [usertype] sdn_objnamel
   net/decnet/af_decnet.c:1239:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1239:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/decnet/af_decnet.c:1239:23: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c:1239:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1239:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/decnet/af_decnet.c:1239:23: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c:1252:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1252:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/decnet/af_decnet.c:1252:23: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c:1252:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1252:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/decnet/af_decnet.c:1252:23: sparse:     got int *__ptr_clean
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
>> net/ipv4/ipmr.c:1568:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ipmr.c:1568:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ipmr.c:1568:13: sparse:     got int *__ptr_clean
   net/ipv4/ipmr.c:1573:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ipmr.c:1573:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ipmr.c:1573:13: sparse:     got int *__ptr_clean
>> net/ipv4/ipmr.c:1573:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ipmr.c:1573:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ipmr.c:1573:13: sparse:     got int *__ptr_clean
   net/ipv4/ipmr.c:2889:13: sparse: sparse: context imbalance in 'ipmr_vif_seq_start' - different lock contexts for basic block
   net/ipv4/ipmr.c: note: in included file (through include/linux/mroute.h):
   include/linux/mroute_base.h:429:31: sparse: sparse: context imbalance in 'mr_mfc_seq_stop' - unexpected unlock
--
>> fs/xfs/xfs_ioctl.c:1420:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     got signed long long *__ptr_clean
>> fs/xfs/xfs_ioctl.c:1420:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     got signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1421:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     got signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1421:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     got signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1422:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     got signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1422:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     got signed long long *__ptr_clean
>> fs/xfs/xfs_ioctl.c:1423:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     got signed int *__ptr_clean
>> fs/xfs/xfs_ioctl.c:1423:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1424:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1424:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1428:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1428:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1429:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1429:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1430:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1430:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1431:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1431:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     got signed int *__ptr_clean
>> fs/xfs/xfs_ioctl.c:1934:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     got int *__ptr_clean
>> fs/xfs/xfs_ioctl.c:1934:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     got int *__ptr_clean
>> fs/xfs/xfs_ioctl.c:2096:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:2096:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:2096:21: sparse:     got unsigned int *__ptr_clean
--
>> net/l2tp/l2tp_ip.c:583:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/l2tp/l2tp_ip.c:583:16: sparse:     expected void const volatile [noderef] __user *ptr
   net/l2tp/l2tp_ip.c:583:16: sparse:     got int *__ptr_clean
>> net/l2tp/l2tp_ip.c:583:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/l2tp/l2tp_ip.c:583:16: sparse:     expected void [noderef] __user *__ptr_pu
   net/l2tp/l2tp_ip.c:583:16: sparse:     got int *__ptr_clean
--
>> drivers/ata/libata-scsi.c:571:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   drivers/ata/libata-scsi.c:571:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/ata/libata-scsi.c:571:24: sparse:     got unsigned long *__ptr_clean
>> drivers/ata/libata-scsi.c:571:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   drivers/ata/libata-scsi.c:571:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/ata/libata-scsi.c:571:24: sparse:     got unsigned long *__ptr_clean
--
>> drivers/block/xen-blkfront.c:515:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   drivers/block/xen-blkfront.c:515:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/block/xen-blkfront.c:515:29: sparse:     got char *__ptr_clean
>> drivers/block/xen-blkfront.c:515:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   drivers/block/xen-blkfront.c:515:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/block/xen-blkfront.c:515:29: sparse:     got char *__ptr_clean
--
>> drivers/comedi/comedi_fops.c:1083:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/comedi/comedi_fops.c:1083:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/comedi/comedi_fops.c:1083:29: sparse:     got unsigned int *__ptr_clean
>> drivers/comedi/comedi_fops.c:1083:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/comedi/comedi_fops.c:1083:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/comedi/comedi_fops.c:1083:29: sparse:     got unsigned int *__ptr_clean
--
>> drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int *__ptr_clean
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int *__ptr_clean
--
>> net/llc/af_llc.c:1171:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/llc/af_llc.c:1171:14: sparse:     expected void const volatile [noderef] __user *ptr
   net/llc/af_llc.c:1171:14: sparse:     got int *__ptr_clean
   net/llc/af_llc.c:1202:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/llc/af_llc.c:1202:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/llc/af_llc.c:1202:13: sparse:     got int *__ptr_clean
>> net/llc/af_llc.c:1202:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/llc/af_llc.c:1202:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/llc/af_llc.c:1202:13: sparse:     got int *__ptr_clean
--
>> net/nfc/llcp_sock.c:319:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/nfc/llcp_sock.c:319:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:319:13: sparse:     got int *__ptr_clean
>> net/nfc/llcp_sock.c:333:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:333:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:333:21: sparse:     got unsigned int *__ptr_clean
>> net/nfc/llcp_sock.c:333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:333:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:333:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:342:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:342:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:342:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:342:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:342:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:342:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:351:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:351:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:351:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:351:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:351:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:351:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:357:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:357:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:357:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:357:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:357:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:357:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:363:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:363:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:363:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:363:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:363:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:363:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:375:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/nfc/llcp_sock.c:375:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:375:13: sparse:     got int *__ptr_clean
>> net/nfc/llcp_sock.c:375:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/nfc/llcp_sock.c:375:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:375:13: sparse:     got int *__ptr_clean
--
>> net/smc/af_smc.c:2705:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/smc/af_smc.c:2705:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/smc/af_smc.c:2705:13: sparse:     got int *__ptr_clean
   net/smc/af_smc.c:2721:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/smc/af_smc.c:2721:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/smc/af_smc.c:2721:13: sparse:     got int *__ptr_clean
>> net/smc/af_smc.c:2721:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/smc/af_smc.c:2721:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/smc/af_smc.c:2721:13: sparse:     got int *__ptr_clean
   net/smc/af_smc.c:2953:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/smc/af_smc.c:2953:16: sparse:     expected void const volatile [noderef] __user *ptr
   net/smc/af_smc.c:2953:16: sparse:     got int *__ptr_clean
   net/smc/af_smc.c:2953:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/smc/af_smc.c:2953:16: sparse:     expected void [noderef] __user *__ptr_pu
   net/smc/af_smc.c:2953:16: sparse:     got int *__ptr_clean

vim +49 drivers/scsi/scsi_ioctl.c

^1da177e4c3f415 Linus Torvalds      2005-04-16   34  
32993523dc59759 Christoph Hellwig   2005-09-06   35  /**
32993523dc59759 Christoph Hellwig   2005-09-06   36   * ioctl_probe  --  return host identification
32993523dc59759 Christoph Hellwig   2005-09-06   37   * @host:	host to identify
32993523dc59759 Christoph Hellwig   2005-09-06   38   * @buffer:	userspace buffer for identification
32993523dc59759 Christoph Hellwig   2005-09-06   39   *
32993523dc59759 Christoph Hellwig   2005-09-06   40   * Return an identifying string at @buffer, if @buffer is non-NULL, filling
32993523dc59759 Christoph Hellwig   2005-09-06   41   * to the length stored at * (int *) @buffer.
^1da177e4c3f415 Linus Torvalds      2005-04-16   42   */
^1da177e4c3f415 Linus Torvalds      2005-04-16   43  static int ioctl_probe(struct Scsi_Host *host, void __user *buffer)
^1da177e4c3f415 Linus Torvalds      2005-04-16   44  {
^1da177e4c3f415 Linus Torvalds      2005-04-16   45  	unsigned int len, slen;
^1da177e4c3f415 Linus Torvalds      2005-04-16   46  	const char *string;
^1da177e4c3f415 Linus Torvalds      2005-04-16   47  
32993523dc59759 Christoph Hellwig   2005-09-06   48  	if (buffer) {
^1da177e4c3f415 Linus Torvalds      2005-04-16  @49  		if (get_user(len, (unsigned int __user *) buffer))
^1da177e4c3f415 Linus Torvalds      2005-04-16   50  			return -EFAULT;
^1da177e4c3f415 Linus Torvalds      2005-04-16   51  
^1da177e4c3f415 Linus Torvalds      2005-04-16   52  		if (host->hostt->info)
^1da177e4c3f415 Linus Torvalds      2005-04-16   53  			string = host->hostt->info(host);
^1da177e4c3f415 Linus Torvalds      2005-04-16   54  		else
^1da177e4c3f415 Linus Torvalds      2005-04-16   55  			string = host->hostt->name;
^1da177e4c3f415 Linus Torvalds      2005-04-16   56  		if (string) {
^1da177e4c3f415 Linus Torvalds      2005-04-16   57  			slen = strlen(string);
^1da177e4c3f415 Linus Torvalds      2005-04-16   58  			if (len > slen)
^1da177e4c3f415 Linus Torvalds      2005-04-16   59  				len = slen + 1;
^1da177e4c3f415 Linus Torvalds      2005-04-16   60  			if (copy_to_user(buffer, string, len))
^1da177e4c3f415 Linus Torvalds      2005-04-16   61  				return -EFAULT;
^1da177e4c3f415 Linus Torvalds      2005-04-16   62  		}
^1da177e4c3f415 Linus Torvalds      2005-04-16   63  	}
32993523dc59759 Christoph Hellwig   2005-09-06   64  	return 1;
^1da177e4c3f415 Linus Torvalds      2005-04-16   65  }
^1da177e4c3f415 Linus Torvalds      2005-04-16   66  
^1da177e4c3f415 Linus Torvalds      2005-04-16   67  static int ioctl_internal_command(struct scsi_device *sdev, char *cmd,
^1da177e4c3f415 Linus Torvalds      2005-04-16   68  				  int timeout, int retries)
^1da177e4c3f415 Linus Torvalds      2005-04-16   69  {
^1da177e4c3f415 Linus Torvalds      2005-04-16   70  	int result;
^1da177e4c3f415 Linus Torvalds      2005-04-16   71  	struct scsi_sense_hdr sshdr;
^1da177e4c3f415 Linus Torvalds      2005-04-16   72  
e5f73ce3248f724 Hannes Reinecke     2014-06-25   73  	SCSI_LOG_IOCTL(1, sdev_printk(KERN_INFO, sdev,
e5f73ce3248f724 Hannes Reinecke     2014-06-25   74  				      "Trying ioctl with scsi command %d\n", *cmd));
^1da177e4c3f415 Linus Torvalds      2005-04-16   75  
1cf72699c1530c3 James Bottomley     2005-08-28   76  	result = scsi_execute_req(sdev, cmd, DMA_NONE, NULL, 0,
f4f4e47e4af6b02 FUJITA Tomonori     2008-12-04   77  				  &sshdr, timeout, retries, NULL);
^1da177e4c3f415 Linus Torvalds      2005-04-16   78  
e5f73ce3248f724 Hannes Reinecke     2014-06-25   79  	SCSI_LOG_IOCTL(2, sdev_printk(KERN_INFO, sdev,
e5f73ce3248f724 Hannes Reinecke     2014-06-25   80  				      "Ioctl returned  0x%x\n", result));
^1da177e4c3f415 Linus Torvalds      2005-04-16   81  
ced202f7bd78eb6 Hannes Reinecke     2021-04-27   82  	if (result < 0)
ced202f7bd78eb6 Hannes Reinecke     2021-04-27   83  		goto out;
464a00c9e0ad45e Hannes Reinecke     2021-04-27   84  	if (scsi_sense_valid(&sshdr)) {
^1da177e4c3f415 Linus Torvalds      2005-04-16   85  		switch (sshdr.sense_key) {
^1da177e4c3f415 Linus Torvalds      2005-04-16   86  		case ILLEGAL_REQUEST:
^1da177e4c3f415 Linus Torvalds      2005-04-16   87  			if (cmd[0] == ALLOW_MEDIUM_REMOVAL)
^1da177e4c3f415 Linus Torvalds      2005-04-16   88  				sdev->lockable = 0;
^1da177e4c3f415 Linus Torvalds      2005-04-16   89  			else
e5f73ce3248f724 Hannes Reinecke     2014-06-25   90  				sdev_printk(KERN_INFO, sdev,
e5f73ce3248f724 Hannes Reinecke     2014-06-25   91  					    "ioctl_internal_command: "
e5f73ce3248f724 Hannes Reinecke     2014-06-25   92  					    "ILLEGAL REQUEST "
e5f73ce3248f724 Hannes Reinecke     2014-06-25   93  					    "asc=0x%x ascq=0x%x\n",
^1da177e4c3f415 Linus Torvalds      2005-04-16   94  					    sshdr.asc, sshdr.ascq);
^1da177e4c3f415 Linus Torvalds      2005-04-16   95  			break;
^1da177e4c3f415 Linus Torvalds      2005-04-16   96  		case NOT_READY:	/* This happens if there is no disc in drive */
a75ad3c27a6ad78 Jens Axboe          2006-07-28   97  			if (sdev->removable)
^1da177e4c3f415 Linus Torvalds      2005-04-16   98  				break;
df561f6688fef77 Gustavo A. R. Silva 2020-08-23   99  			fallthrough;
^1da177e4c3f415 Linus Torvalds      2005-04-16  100  		case UNIT_ATTENTION:
^1da177e4c3f415 Linus Torvalds      2005-04-16  101  			if (sdev->removable) {
^1da177e4c3f415 Linus Torvalds      2005-04-16  102  				sdev->changed = 1;
1cf72699c1530c3 James Bottomley     2005-08-28  103  				result = 0;	/* This is no longer considered an error */
^1da177e4c3f415 Linus Torvalds      2005-04-16  104  				break;
^1da177e4c3f415 Linus Torvalds      2005-04-16  105  			}
df561f6688fef77 Gustavo A. R. Silva 2020-08-23  106  			fallthrough;	/* for non-removable media */
3bf2ff6749f0f87 Bart Van Assche     2017-08-25  107  		default:
9ccfc756a70d454 James Bottomley     2005-10-02  108  			sdev_printk(KERN_INFO, sdev,
9ccfc756a70d454 James Bottomley     2005-10-02  109  				    "ioctl_internal_command return code = %x\n",
1cf72699c1530c3 James Bottomley     2005-08-28  110  				    result);
d811b848ebb78a1 Hannes Reinecke     2014-10-24  111  			scsi_print_sense_hdr(sdev, NULL, &sshdr);
^1da177e4c3f415 Linus Torvalds      2005-04-16  112  			break;
^1da177e4c3f415 Linus Torvalds      2005-04-16  113  		}
^1da177e4c3f415 Linus Torvalds      2005-04-16  114  	}
ced202f7bd78eb6 Hannes Reinecke     2021-04-27  115  out:
e5f73ce3248f724 Hannes Reinecke     2014-06-25  116  	SCSI_LOG_IOCTL(2, sdev_printk(KERN_INFO, sdev,
e5f73ce3248f724 Hannes Reinecke     2014-06-25  117  				      "IOCTL Releasing command\n"));
^1da177e4c3f415 Linus Torvalds      2005-04-16  118  	return result;
^1da177e4c3f415 Linus Torvalds      2005-04-16  119  }
^1da177e4c3f415 Linus Torvalds      2005-04-16  120  
^1da177e4c3f415 Linus Torvalds      2005-04-16  121  int scsi_set_medium_removal(struct scsi_device *sdev, char state)
^1da177e4c3f415 Linus Torvalds      2005-04-16  122  {
^1da177e4c3f415 Linus Torvalds      2005-04-16  123  	char scsi_cmd[MAX_COMMAND_SIZE];
^1da177e4c3f415 Linus Torvalds      2005-04-16  124  	int ret;
^1da177e4c3f415 Linus Torvalds      2005-04-16  125  
^1da177e4c3f415 Linus Torvalds      2005-04-16  126  	if (!sdev->removable || !sdev->lockable)
^1da177e4c3f415 Linus Torvalds      2005-04-16  127  	       return 0;
^1da177e4c3f415 Linus Torvalds      2005-04-16  128  
^1da177e4c3f415 Linus Torvalds      2005-04-16  129  	scsi_cmd[0] = ALLOW_MEDIUM_REMOVAL;
^1da177e4c3f415 Linus Torvalds      2005-04-16  130  	scsi_cmd[1] = 0;
^1da177e4c3f415 Linus Torvalds      2005-04-16  131  	scsi_cmd[2] = 0;
^1da177e4c3f415 Linus Torvalds      2005-04-16  132  	scsi_cmd[3] = 0;
^1da177e4c3f415 Linus Torvalds      2005-04-16  133  	scsi_cmd[4] = state;
^1da177e4c3f415 Linus Torvalds      2005-04-16  134  	scsi_cmd[5] = 0;
^1da177e4c3f415 Linus Torvalds      2005-04-16  135  
^1da177e4c3f415 Linus Torvalds      2005-04-16  136  	ret = ioctl_internal_command(sdev, scsi_cmd,
^1da177e4c3f415 Linus Torvalds      2005-04-16  137  			IOCTL_NORMAL_TIMEOUT, NORMAL_RETRIES);
^1da177e4c3f415 Linus Torvalds      2005-04-16  138  	if (ret == 0)
^1da177e4c3f415 Linus Torvalds      2005-04-16  139  		sdev->locked = (state == SCSI_REMOVAL_PREVENT);
^1da177e4c3f415 Linus Torvalds      2005-04-16  140  	return ret;
^1da177e4c3f415 Linus Torvalds      2005-04-16  141  }
^1da177e4c3f415 Linus Torvalds      2005-04-16  142  EXPORT_SYMBOL(scsi_set_medium_removal);
^1da177e4c3f415 Linus Torvalds      2005-04-16  143  
^1da177e4c3f415 Linus Torvalds      2005-04-16  144  /*
^1da177e4c3f415 Linus Torvalds      2005-04-16  145   * The scsi_ioctl_get_pci() function places into arg the value
^1da177e4c3f415 Linus Torvalds      2005-04-16  146   * pci_dev::slot_name (8 characters) for the PCI device (if any).
^1da177e4c3f415 Linus Torvalds      2005-04-16  147   * Returns: 0 on success
^1da177e4c3f415 Linus Torvalds      2005-04-16  148   *          -ENXIO if there isn't a PCI device pointer
^1da177e4c3f415 Linus Torvalds      2005-04-16  149   *                 (could be because the SCSI driver hasn't been
^1da177e4c3f415 Linus Torvalds      2005-04-16  150   *                  updated yet, or because it isn't a SCSI
^1da177e4c3f415 Linus Torvalds      2005-04-16  151   *                  device)
^1da177e4c3f415 Linus Torvalds      2005-04-16  152   *          any copy_to_user() error on failure there
^1da177e4c3f415 Linus Torvalds      2005-04-16  153   */
^1da177e4c3f415 Linus Torvalds      2005-04-16  154  static int scsi_ioctl_get_pci(struct scsi_device *sdev, void __user *arg)
^1da177e4c3f415 Linus Torvalds      2005-04-16  155  {
^1da177e4c3f415 Linus Torvalds      2005-04-16  156  	struct device *dev = scsi_get_device(sdev->host);
71610f55fa4db63 Kay Sievers         2008-12-03  157  	const char *name;
^1da177e4c3f415 Linus Torvalds      2005-04-16  158  
^1da177e4c3f415 Linus Torvalds      2005-04-16  159          if (!dev)
^1da177e4c3f415 Linus Torvalds      2005-04-16  160  		return -ENXIO;
71610f55fa4db63 Kay Sievers         2008-12-03  161  
71610f55fa4db63 Kay Sievers         2008-12-03  162  	name = dev_name(dev);
71610f55fa4db63 Kay Sievers         2008-12-03  163  
71610f55fa4db63 Kay Sievers         2008-12-03  164  	/* compatibility with old ioctl which only returned
71610f55fa4db63 Kay Sievers         2008-12-03  165  	 * 20 characters */
71610f55fa4db63 Kay Sievers         2008-12-03  166          return copy_to_user(arg, name, min(strlen(name), (size_t)20))
71610f55fa4db63 Kay Sievers         2008-12-03  167  		? -EFAULT: 0;
^1da177e4c3f415 Linus Torvalds      2005-04-16  168  }
^1da177e4c3f415 Linus Torvalds      2005-04-16  169  
f2542a3be3277a6 Christoph Hellwig   2021-07-24  170  static int sg_get_version(int __user *p)
f2542a3be3277a6 Christoph Hellwig   2021-07-24  171  {
f2542a3be3277a6 Christoph Hellwig   2021-07-24  172  	static const int sg_version_num = 30527;
f2542a3be3277a6 Christoph Hellwig   2021-07-24 @173  	return put_user(sg_version_num, p);
f2542a3be3277a6 Christoph Hellwig   2021-07-24  174  }
f2542a3be3277a6 Christoph Hellwig   2021-07-24  175  

:::::: The code at line 49 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
