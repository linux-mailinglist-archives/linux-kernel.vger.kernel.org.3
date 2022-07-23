Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7139357F0A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 19:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbiGWRgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 13:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiGWRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 13:36:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515521EECE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658597803; x=1690133803;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mxDrj0GNw+TYoowO9aT78traMLI87uIfx9dQPoHBqjc=;
  b=Hx/+zVpa+TcYuUfR/Pf2SMCEVxOGjTNlCDlomUb3HfV1CmTVcopI+i7B
   Tuh+We8p/27SJqRpJu4T/P6roB7WoKwmcCFJyPCMoWL1kELmRe/f52H3n
   lBlh7cWXeG47O4BNs5fzMsevjPGKUM/oA9NvQhx/eIoSs8mCrgrn/bu8p
   5fkNySojGxgjwlluZvRdIRrnkitE/kOBuCdmRil55NDOeiLCxdH27nmVa
   Lhaoa/GhcjpWowzcnJZNXHkJhAzCbVsd0GD6RqWnA9+n6hCqKY6MwnF3S
   QfFWffE0E+/fwr0cwKgtscJphAWoUgc/Z75DnN7cBop+mYwCKCf+kkYUx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="313221830"
X-IronPort-AV: E=Sophos;i="5.93,188,1654585200"; 
   d="scan'208";a="313221830"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 10:36:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,188,1654585200"; 
   d="scan'208";a="631892575"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Jul 2022 10:36:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFJ3P-0002th-0R;
        Sat, 23 Jul 2022 17:36:39 +0000
Date:   Sun, 24 Jul 2022 01:36:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/13] net/llc/af_llc.c:1171:14: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202207240147.WLjqo9EH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   8f1ad76e5cd0e91e574027038c51ace7789f8401
commit: badfa95b53ee2d7247e30f8ba0d418d162f6523d [5/13] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220724/202207240147.WLjqo9EH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=badfa95b53ee2d7247e30f8ba0d418d162f6523d
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout badfa95b53ee2d7247e30f8ba0d418d162f6523d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> net/llc/af_llc.c:1171:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/llc/af_llc.c:1171:14: sparse:     expected int [noderef] __user *__ptr_clean
   net/llc/af_llc.c:1171:14: sparse:     got int *
   net/llc/af_llc.c:1202:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/llc/af_llc.c:1202:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/llc/af_llc.c:1202:13: sparse:     got int *
--
>> net/smc/af_smc.c:2812:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/smc/af_smc.c:2812:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/smc/af_smc.c:2812:13: sparse:     got int *
   net/smc/af_smc.c:2828:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/smc/af_smc.c:2828:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/smc/af_smc.c:2828:13: sparse:     got int *
   net/smc/af_smc.c:3060:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/smc/af_smc.c:3060:16: sparse:     expected int [noderef] __user *__ptr_clean
   net/smc/af_smc.c:3060:16: sparse:     got int *
--
>> sound/core/compress_offload.c:975:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/compress_offload.c:975:26: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/compress_offload.c:975:26: sparse:     got int *
--
>> drivers/auxdisplay/charlcd.c:482:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/auxdisplay/charlcd.c:482:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/auxdisplay/charlcd.c:482:21: sparse:     got char const *
--
>> drivers/vdpa/vdpa_user/vduse_dev.c:976:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/vdpa/vdpa_user/vduse_dev.c:976:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/vdpa/vdpa_user/vduse_dev.c:976:23: sparse:     got unsigned long long *
>> drivers/vdpa/vdpa_user/vduse_dev.c:1081:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/vdpa/vdpa_user/vduse_dev.c:1081:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/vdpa/vdpa_user/vduse_dev.c:1081:21: sparse:     got unsigned int *
   drivers/vdpa/vdpa_user/vduse_dev.c:1382:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/vdpa/vdpa_user/vduse_dev.c:1382:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/vdpa/vdpa_user/vduse_dev.c:1382:23: sparse:     got unsigned long long *
   drivers/vdpa/vdpa_user/vduse_dev.c:1388:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/vdpa/vdpa_user/vduse_dev.c:1388:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/vdpa/vdpa_user/vduse_dev.c:1388:21: sparse:     got unsigned long long *
--
>> drivers/usb/gadget/function/rndis.c:1138:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/usb/gadget/function/rndis.c:1138:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/usb/gadget/function/rndis.c:1138:21: sparse:     got char const *
--
>> fs/reiserfs/ioctl.c:96:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/reiserfs/ioctl.c:96:23: sparse:     expected int [noderef] __user *__ptr_clean
   fs/reiserfs/ioctl.c:96:23: sparse:     got int *
   fs/reiserfs/ioctl.c:106:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/reiserfs/ioctl.c:106:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/reiserfs/ioctl.c:106:21: sparse:     got int *
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
>> drivers/infiniband/core/user_mad.c:749:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/infiniband/core/user_mad.c:749:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/infiniband/core/user_mad.c:749:13: sparse:     got unsigned int *
   drivers/infiniband/core/user_mad.c:815:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/infiniband/core/user_mad.c:815:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/infiniband/core/user_mad.c:815:21: sparse:     got unsigned int *
   drivers/infiniband/core/user_mad.c:863:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/infiniband/core/user_mad.c:863:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/infiniband/core/user_mad.c:863:13: sparse:     got unsigned int *
   drivers/infiniband/core/user_mad.c:896:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/infiniband/core/user_mad.c:896:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/infiniband/core/user_mad.c:896:13: sparse:     got unsigned int *
--
>> drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/infiniband/core/uverbs_ioctl.c:157:13: sparse:     got unsigned short *
>> drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/infiniband/core/uverbs_ioctl.c:334:29: sparse:     got unsigned long long *
   drivers/infiniband/core/uverbs_ioctl.c:423:17: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected int ( *handler )( ... ) @@     got int ( [noderef] * )( ... ) @@
   drivers/infiniband/core/uverbs_ioctl.c:423:17: sparse:     expected int ( *handler )( ... )
   drivers/infiniband/core/uverbs_ioctl.c:423:17: sparse:     got int ( [noderef] * )( ... )
--
>> drivers/infiniband/core/uverbs_main.c:632:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long const [noderef] __user *__ptr_clean @@     got unsigned long long const * @@
   drivers/infiniband/core/uverbs_main.c:632:31: sparse:     expected unsigned long long const [noderef] __user *__ptr_clean
   drivers/infiniband/core/uverbs_main.c:632:31: sparse:     got unsigned long long const *
--
>> net/bluetooth/hci_sock.c:1967:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/hci_sock.c:1967:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:1967:13: sparse:     got int *
>> net/bluetooth/hci_sock.c:1984:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/bluetooth/hci_sock.c:1984:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:1984:21: sparse:     got char *
   net/bluetooth/hci_sock.c:1994:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/bluetooth/hci_sock.c:1994:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:1994:21: sparse:     got char *
>> net/bluetooth/hci_sock.c:2044:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/bluetooth/hci_sock.c:2044:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/bluetooth/hci_sock.c:2044:21: sparse:     got unsigned short *
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
>> net/bluetooth/af_bluetooth.c:510:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/af_bluetooth.c:510:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/af_bluetooth.c:510:23: sparse:     got int *
   net/bluetooth/af_bluetooth.c:521:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bluetooth/af_bluetooth.c:521:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/bluetooth/af_bluetooth.c:521:23: sparse:     got int *
   net/bluetooth/af_bluetooth.c:176:25: sparse: sparse: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
--
>> net/bluetooth/hci_core.c:825:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/bluetooth/hci_core.c:825:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/bluetooth/hci_core.c:825:13: sparse:     got unsigned short *
--
>> drivers/block/xen-blkfront.c:513:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/block/xen-blkfront.c:513:29: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/block/xen-blkfront.c:513:29: sparse:     got char *
--
>> drivers/vhost/scsi.c:1870:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/vhost/scsi.c:1870:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/vhost/scsi.c:1870:21: sparse:     got unsigned int *
   drivers/vhost/scsi.c:1880:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/vhost/scsi.c:1880:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/vhost/scsi.c:1880:21: sparse:     got unsigned int *
--
>> drivers/comedi/comedi_fops.c:1083:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/comedi/comedi_fops.c:1083:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/comedi/comedi_fops.c:1083:29: sparse:     got unsigned int *
--
>> drivers/android/binder.c:3665:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:3665:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:3665:21: sparse:     got unsigned int *
   drivers/android/binder.c:3685:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:3685:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:3685:29: sparse:     got unsigned int *
>> drivers/android/binder.c:3752:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:3752:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:3752:29: sparse:     got unsigned long long *
   drivers/android/binder.c:3755:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:3755:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:3755:29: sparse:     got unsigned long long *
   drivers/android/binder.c:3824:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:3824:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:3824:29: sparse:     got unsigned long long *
   drivers/android/binder.c:3921:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:3921:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:3921:29: sparse:     got unsigned int *
   drivers/android/binder.c:3924:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:3924:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:3924:29: sparse:     got unsigned long long *
   drivers/android/binder.c:4043:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:4043:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:4043:29: sparse:     got unsigned long long *
   drivers/android/binder.c:4119:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4119:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4119:13: sparse:     got unsigned int *
   drivers/android/binder.c:4123:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:4123:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:4123:13: sparse:     got unsigned long long *
   drivers/android/binder.c:4127:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:4127:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:4127:13: sparse:     got unsigned long long *
   drivers/android/binder.c:4239:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4239:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4239:21: sparse:     got unsigned int *
   drivers/android/binder.c:4321:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4321:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4321:29: sparse:     got unsigned int *
   drivers/android/binder.c:4339:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4339:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4339:29: sparse:     got unsigned int *
   drivers/android/binder.c:4465:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4465:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4465:29: sparse:     got unsigned int *
   drivers/android/binder.c:4468:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/android/binder.c:4468:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/android/binder.c:4468:29: sparse:     got unsigned long long *
   drivers/android/binder.c:4540:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4540:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4540:37: sparse:     got unsigned int *
   drivers/android/binder.c:4560:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4560:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4560:21: sparse:     got unsigned int *
   drivers/android/binder.c:4625:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/android/binder.c:4625:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/android/binder.c:4625:21: sparse:     got unsigned int *
   drivers/android/binder.c:4880:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int @@
   drivers/android/binder.c:4880:24: sparse:     expected restricted __poll_t
   drivers/android/binder.c:4880:24: sparse:     got int
>> drivers/android/binder.c:5255:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/android/binder.c:5255:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/android/binder.c:5255:21: sparse:     got signed int *
--
>> drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int *
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int *
--
>> net/decnet/af_decnet.c:1537:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/decnet/af_decnet.c:1537:12: sparse:     expected int [noderef] __user *__ptr_clean
   net/decnet/af_decnet.c:1537:12: sparse:     got int *
   net/decnet/af_decnet.c:1632:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/decnet/af_decnet.c:1632:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/decnet/af_decnet.c:1632:21: sparse:     got int *
   net/decnet/af_decnet.c:250:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int hash @@     got restricted __le16 [usertype] sdn_objnamel @@
   net/decnet/af_decnet.c:250:22: sparse:     expected unsigned int hash
   net/decnet/af_decnet.c:250:22: sparse:     got restricted __le16 [usertype] sdn_objnamel
   net/decnet/af_decnet.c:1239:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/decnet/af_decnet.c:1239:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/decnet/af_decnet.c:1239:23: sparse:     got int *
   net/decnet/af_decnet.c:1252:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
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
>> drivers/mtd/ubi/cdev.c:467:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:467:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:467:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:512:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:512:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:512:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:526:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:526:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:526:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:869:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:869:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:869:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:882:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:882:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:882:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:969:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:969:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:969:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:984:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:984:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:984:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:1050:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:1061:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     got signed int *
--
>> drivers/mtd/mtdchar.c:409:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:409:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:409:13: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:754:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:754:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:754:21: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:762:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:762:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:762:21: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:763:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:763:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:763:24: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:764:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:764:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:764:24: sparse:     got unsigned int *
--
>> fs/jfs/jfs_debug.c:36:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   fs/jfs/jfs_debug.c:36:13: sparse:     expected char const [noderef] __user *__ptr_clean
   fs/jfs/jfs_debug.c:36:13: sparse:     got char const *

vim +1171 net/llc/af_llc.c

^1da177e4c3f41 Linus Torvalds           2005-04-16  1150  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1151  /**
^1da177e4c3f41 Linus Torvalds           2005-04-16  1152   *	llc_ui_getsockopt - get connection specific socket info
^1da177e4c3f41 Linus Torvalds           2005-04-16  1153   *	@sock: Socket to get information from.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1154   *	@level: Socket level user is requesting operations on.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1155   *	@optname: Operation name.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1156   *	@optval: Variable to return operation data in.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1157   *	@optlen: Length of optval.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1158   *
^1da177e4c3f41 Linus Torvalds           2005-04-16  1159   *	Get connection specific socket information.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1160   */
^1da177e4c3f41 Linus Torvalds           2005-04-16  1161  static int llc_ui_getsockopt(struct socket *sock, int level, int optname,
^1da177e4c3f41 Linus Torvalds           2005-04-16  1162  			     char __user *optval, int __user *optlen)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1163  {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1164  	struct sock *sk = sock->sk;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1165  	struct llc_sock *llc = llc_sk(sk);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1166  	int val = 0, len = 0, rc = -EINVAL;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1167  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1168  	lock_sock(sk);
af426d327c38bc Arnaldo Carvalho de Melo 2005-09-22  1169  	if (unlikely(level != SOL_LLC))
^1da177e4c3f41 Linus Torvalds           2005-04-16  1170  		goto out;
^1da177e4c3f41 Linus Torvalds           2005-04-16 @1171  	rc = get_user(len, optlen);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1172  	if (rc)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1173  		goto out;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1174  	rc = -EINVAL;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1175  	if (len != sizeof(int))
^1da177e4c3f41 Linus Torvalds           2005-04-16  1176  		goto out;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1177  	switch (optname) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1178  	case LLC_OPT_RETRY:
^1da177e4c3f41 Linus Torvalds           2005-04-16  1179  		val = llc->n2;					break;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1180  	case LLC_OPT_SIZE:
^1da177e4c3f41 Linus Torvalds           2005-04-16  1181  		val = llc->n1;					break;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1182  	case LLC_OPT_ACK_TMR_EXP:
590232a7150674 Arnaldo Carvalho de Melo 2005-09-22  1183  		val = llc->ack_timer.expire / HZ;		break;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1184  	case LLC_OPT_P_TMR_EXP:
590232a7150674 Arnaldo Carvalho de Melo 2005-09-22  1185  		val = llc->pf_cycle_timer.expire / HZ;		break;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1186  	case LLC_OPT_REJ_TMR_EXP:
590232a7150674 Arnaldo Carvalho de Melo 2005-09-22  1187  		val = llc->rej_sent_timer.expire / HZ;		break;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1188  	case LLC_OPT_BUSY_TMR_EXP:
590232a7150674 Arnaldo Carvalho de Melo 2005-09-22  1189  		val = llc->busy_state_timer.expire / HZ;	break;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1190  	case LLC_OPT_TX_WIN:
^1da177e4c3f41 Linus Torvalds           2005-04-16  1191  		val = llc->k;				break;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1192  	case LLC_OPT_RX_WIN:
^1da177e4c3f41 Linus Torvalds           2005-04-16  1193  		val = llc->rw;				break;
e5cd6fe391aa8c Octavian Purdila         2009-12-26  1194  	case LLC_OPT_PKTINFO:
e5cd6fe391aa8c Octavian Purdila         2009-12-26  1195  		val = (llc->cmsg_flags & LLC_CMSG_PKTINFO) != 0;
e5cd6fe391aa8c Octavian Purdila         2009-12-26  1196  		break;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1197  	default:
^1da177e4c3f41 Linus Torvalds           2005-04-16  1198  		rc = -ENOPROTOOPT;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1199  		goto out;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1200  	}
^1da177e4c3f41 Linus Torvalds           2005-04-16  1201  	rc = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1202  	if (put_user(len, optlen) || copy_to_user(optval, &val, len))
^1da177e4c3f41 Linus Torvalds           2005-04-16  1203  		rc = -EFAULT;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1204  out:
^1da177e4c3f41 Linus Torvalds           2005-04-16  1205  	release_sock(sk);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1206  	return rc;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1207  }
^1da177e4c3f41 Linus Torvalds           2005-04-16  1208  

:::::: The code at line 1171 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
