Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3871D488246
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiAHIUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:20:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:26737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbiAHIUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641630046; x=1673166046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sDIAKwdc3voi51EpcS9YtWRjtcJLSc0ZbXDdDegfcrA=;
  b=c9QxVIJ061i5eYjVsQ3O716WXpRNu7zmI12jZ9nP2k4UGpO5AK86tbFs
   jRy9cOAG5XT7eV6VT5SSfZnj0hg3XHaXHQMewKOWHLXRofrS4meNUHAGO
   +Fk0nuzN5pe6giT2R1WFbpwGlkQ9TZrwl6H+/uN/zAjzOeoM7hIwIeykJ
   XeRsu9aZDhG9vf4Q1cSYSeluaNIu6TG5Y9NqoyddaQPMG7nycB1Kf7T5k
   2ao9vJ2H5o8WBitZD2Tk4KpYW4ksJuG8p1/ae2OrRT4eNhyAj9vscBrNd
   f6yRsZ8XFrJ7cdS6X9U7F4QnzheSFOGzSSKjuMMoZO2UEngBiEJEQv8yP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="303740191"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="303740191"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 00:20:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="591927883"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jan 2022 00:20:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n66xw-0000PU-25; Sat, 08 Jan 2022 08:20:44 +0000
Date:   Sat, 8 Jan 2022 16:20:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Colin Downs-Razouk <colindr@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android11-kiwi-5.4
 9998/9999] drivers/virtio/virtio_pvclock.c:48:6: warning: no previous
 prototype for 'update_suspend_time'
Message-ID: <202201081651.n1OTPsay-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android11-kiwi-5.4
head:   7d1d5848183bd1d9086d0572f9af431d3ded407f
commit: 04f660d6724f5df1b07f8cf9e1c55f70fb43d1d2 [9998/9999] ANDROID: virtio: virtio_pvclock: initial driver impl
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220108/202201081651.n1OTPsay-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/04f660d6724f5df1b07f8cf9e1c55f70fb43d1d2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android11-kiwi-5.4
        git checkout 04f660d6724f5df1b07f8cf9e1c55f70fb43d1d2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio_pvclock.c:48:6: warning: no previous prototype for 'update_suspend_time' [-Wmissing-prototypes]
      48 | void update_suspend_time(struct work_struct *work)
         |      ^~~~~~~~~~~~~~~~~~~
   drivers/virtio/virtio_pvclock.c: In function 'virtpvclock_validate':
>> drivers/virtio/virtio_pvclock.c:294:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     294 |  uint32_t rating =
         |  ^~~~~~~~


vim +/update_suspend_time +48 drivers/virtio/virtio_pvclock.c

    47	
  > 48	void update_suspend_time(struct work_struct *work)
    49	{
    50		u64 suspend_ns, suspend_time_delta = 0;
    51		struct timespec64 inject_time;
    52		struct virtio_pvclock *vp;
    53	
    54		vp = container_of(work, struct virtio_pvclock,
    55				  update_suspend_time_work);
    56	
    57		virtio_cread(vp->vdev, struct virtio_pvclock_config, suspend_time_ns,
    58			     &suspend_ns);
    59	
    60		mutex_lock(&vp->inject_suspend_lock);
    61		if (suspend_ns > vp->injected_suspend_ns) {
    62			suspend_time_delta = suspend_ns - vp->injected_suspend_ns;
    63			vp->injected_suspend_ns = suspend_ns;
    64		}
    65		mutex_unlock(&vp->inject_suspend_lock);
    66	
    67		if (suspend_time_delta == 0) {
    68			dev_err(&vp->vdev->dev,
    69				"%s: suspend_time_ns is less than injected_suspend_ns\n",
    70				__func__);
    71			return;
    72		}
    73	
    74		inject_time = ns_to_timespec64(suspend_time_delta);
    75	
    76		timekeeping_inject_sleeptime64(&inject_time);
    77	
    78		dev_info(&vp->vdev->dev, "injected sleeptime: %llu ns\n",
    79			 suspend_time_delta);
    80	}
    81	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
