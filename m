Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF744F8B94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiDHAWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiDHAWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:22:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36807765B3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649377224; x=1680913224;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=n7NrEDvmPfmCVU6r9UBCko8qTOTqgWb6IkVc97iswOs=;
  b=FZJm3pw6iw8/50oo50h60QT7rZzdCP2BQwu79WoIavUZEfGbriu7Of/X
   pVwScd+DZEdtdJeK0+mWcurVvWrnFO8yZEcYKqX1dzCF2XT4h7oXaGUlr
   FD5OqLpRfZkODKrDEPT+/6eKwv57cCGlxH8OlLZ7GMocZqk8XsnXQahmY
   G5KsxxkKhr3x07+8JVZuYqZLL27NMXHm67h+WFLhL7JT1NBGeyTWjop1r
   r1ZJG+lKRBfOaz8yt9dAikqMENWdWLwDIMMeDJCxLhJA0ikGAKo5/6QZz
   rZqrR5uu56OBKFnns/qhwFS1HVgFKv7lCvX3sAMK77mGYoCyTkwXW5lfJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="259068910"
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="259068910"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 17:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="609538265"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 07 Apr 2022 17:20:21 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nccMO-0005td-IM;
        Fri, 08 Apr 2022 00:20:20 +0000
Date:   Fri, 8 Apr 2022 08:20:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 6/10] net/ethtool/ioctl.c:107:13: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202204080826.HPPWt749-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   73447e771c55e18598a6fbf6adee1002aee18ea0
commit: 92948bd2c12648f2fb8256ae69dd092ce4398a3a [6/10] x86/uaccess: Remove tags from the address before checking
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220408/202204080826.HPPWt749-lkp@intel.com/config)
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
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/entry/ arch/x86/kernel/ drivers/auxdisplay/ drivers/char/ drivers/firewire/ drivers/fsi/ drivers/gpu/drm/ drivers/hid/ drivers/hwmon/ drivers/i2c/ drivers/input/ drivers/misc/ drivers/mtd/ drivers/pps/ drivers/rtc/ drivers/tty/ drivers/usb/core/ drivers/usb/image/ drivers/usb/mon/ drivers/vfio/ drivers/video/fbdev/aty/ drivers/video/fbdev/sis/ drivers/video/fbdev/via/ fs/ ipc/ kernel/ net/ sound/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/ethtool/ioctl.c:107:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *[assigned] sizeaddr @@
   net/ethtool/ioctl.c:107:13: sparse:     expected unsigned int *__ptr_clean
   net/ethtool/ioctl.c:107:13: sparse:     got unsigned int [noderef] [usertype] __user *[assigned] sizeaddr
   net/ethtool/ioctl.c:107:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ethtool/ioctl.c:107:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ethtool/ioctl.c:107:13: sparse:     got unsigned int *__ptr_clean
--
>> kernel/futex/core.c:648:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   kernel/futex/core.c:648:13: sparse:     expected unsigned int *__ptr_clean
   kernel/futex/core.c:648:13: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex/core.c:648:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/futex/core.c:648:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/core.c:648:13: sparse:     got unsigned int *__ptr_clean
>> kernel/futex/core.c:783:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   kernel/futex/core.c:783:13: sparse:     expected long *__ptr_clean
   kernel/futex/core.c:783:13: sparse:     got long [noderef] __user *
   kernel/futex/core.c:783:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/futex/core.c:783:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/core.c:783:13: sparse:     got long *__ptr_clean
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long [noderef] __user *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   kernel/futex/core.c:750:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/core.c:750:13: sparse:     got unsigned long *__ptr_clean
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long [noderef] __user *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   kernel/futex/core.c:750:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/core.c:750:13: sparse:     got unsigned long *__ptr_clean
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long [noderef] __user *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   kernel/futex/core.c:750:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/core.c:750:13: sparse:     got unsigned long *__ptr_clean
--
>> kernel/futex/syscalls.c:75:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *len_ptr @@
   kernel/futex/syscalls.c:75:13: sparse:     expected unsigned int *__ptr_clean
   kernel/futex/syscalls.c:75:13: sparse:     got unsigned int [noderef] [usertype] __user *len_ptr
>> kernel/futex/syscalls.c:75:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/futex/syscalls.c:75:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/syscalls.c:75:13: sparse:     got unsigned int *__ptr_clean
>> kernel/futex/syscalls.c:75:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/futex/syscalls.c:75:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/futex/syscalls.c:75:13: sparse:     got unsigned int *__ptr_clean
>> kernel/futex/syscalls.c:77:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct robust_list_head [noderef] __user **__ptr_clean @@     got struct robust_list_head [noderef] __user *[noderef] __user *head_ptr @@
   kernel/futex/syscalls.c:77:16: sparse:     expected struct robust_list_head [noderef] __user **__ptr_clean
   kernel/futex/syscalls.c:77:16: sparse:     got struct robust_list_head [noderef] __user *[noderef] __user *head_ptr
   kernel/futex/syscalls.c:77:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got struct robust_list_head [noderef] __user **__ptr_clean @@
   kernel/futex/syscalls.c:77:16: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/syscalls.c:77:16: sparse:     got struct robust_list_head [noderef] __user **__ptr_clean
   kernel/futex/syscalls.c:77:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got struct robust_list_head [noderef] __user **__ptr_clean @@
   kernel/futex/syscalls.c:77:16: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/futex/syscalls.c:77:16: sparse:     got struct robust_list_head [noderef] __user **__ptr_clean
--
>> kernel/futex/pi.c:1112:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   kernel/futex/pi.c:1112:13: sparse:     expected unsigned int *__ptr_clean
   kernel/futex/pi.c:1112:13: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex/pi.c:1112:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/futex/pi.c:1112:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/pi.c:1112:13: sparse:     got unsigned int *__ptr_clean
   kernel/futex/pi.c:675:9: sparse: sparse: context imbalance in 'wake_futex_pi' - unexpected unlock
   kernel/futex/pi.c:803:9: sparse: sparse: context imbalance in '__fixup_pi_state_owner' - unexpected unlock
   kernel/futex/pi.c:1068:9: sparse: sparse: context imbalance in 'futex_lock_pi' - unexpected unlock
   kernel/futex/pi.c:1100:5: sparse: sparse: context imbalance in 'futex_unlock_pi' - different lock contexts for basic block
--
>> kernel/futex/requeue.c:458:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *uaddr1 @@
   kernel/futex/requeue.c:458:31: sparse:     expected unsigned int *__ptr_clean
   kernel/futex/requeue.c:458:31: sparse:     got unsigned int [noderef] [usertype] __user *uaddr1
   kernel/futex/requeue.c:458:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/futex/requeue.c:458:31: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/requeue.c:458:31: sparse:     got unsigned int *__ptr_clean
   kernel/futex/requeue.c:455:41: sparse: sparse: context imbalance in 'futex_requeue' - different lock contexts for basic block
--
>> kernel/futex/waitwake.c:473:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   kernel/futex/waitwake.c:473:29: sparse:     expected unsigned int *__ptr_clean
   kernel/futex/waitwake.c:473:29: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex/waitwake.c:473:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/futex/waitwake.c:473:29: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/waitwake.c:473:29: sparse:     got unsigned int *__ptr_clean
   kernel/futex/waitwake.c:614:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   kernel/futex/waitwake.c:614:23: sparse:     expected unsigned int *__ptr_clean
   kernel/futex/waitwake.c:614:23: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex/waitwake.c:614:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/futex/waitwake.c:614:23: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/waitwake.c:614:23: sparse:     got unsigned int *__ptr_clean
   kernel/futex/waitwake.c:262:33: sparse: sparse: context imbalance in 'futex_wake_op' - different lock contexts for basic block
   kernel/futex/waitwake.c:328:6: sparse: sparse: context imbalance in 'futex_wait_queue' - unexpected unlock
   kernel/futex/waitwake.c:449:36: sparse: sparse: context imbalance in 'futex_wait_multiple_setup' - unexpected unlock
--
>> drivers/pps/pps.c:170:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *iuarg @@
   drivers/pps/pps.c:170:23: sparse:     expected int *__ptr_clean
   drivers/pps/pps.c:170:23: sparse:     got int [noderef] __user *iuarg
   drivers/pps/pps.c:170:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/pps/pps.c:170:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/pps/pps.c:170:23: sparse:     got int *__ptr_clean
   drivers/pps/pps.c:170:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/pps/pps.c:170:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/pps/pps.c:170:23: sparse:     got int *__ptr_clean
--
   kernel/trace/trace.c:5739:1: sparse: sparse: trying to concatenate 11638-character string (8191 bytes max)
   kernel/trace/trace.c:406:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:406:28: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:406:28: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:420:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:420:33: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:420:33: sparse:     got struct trace_export [noderef] __rcu **
>> kernel/trace/trace.c:1601:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user * @@
   kernel/trace/trace.c:1601:15: sparse:     expected char const *__ptr_clean
   kernel/trace/trace.c:1601:15: sparse:     got char const [noderef] __user *
   kernel/trace/trace.c:1601:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   kernel/trace/trace.c:1601:15: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/trace/trace.c:1601:15: sparse:     got char const *__ptr_clean
   kernel/trace/trace.c:1615:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user * @@
   kernel/trace/trace.c:1615:31: sparse:     expected char const *__ptr_clean
   kernel/trace/trace.c:1615:31: sparse:     got char const [noderef] __user *
   kernel/trace/trace.c:1615:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   kernel/trace/trace.c:1615:31: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/trace/trace.c:1615:31: sparse:     got char const *__ptr_clean
   kernel/trace/trace.c:1640:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user * @@
   kernel/trace/trace.c:1640:23: sparse:     expected char const *__ptr_clean
   kernel/trace/trace.c:1640:23: sparse:     got char const [noderef] __user *
   kernel/trace/trace.c:1640:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   kernel/trace/trace.c:1640:23: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/trace/trace.c:1640:23: sparse:     got char const *__ptr_clean
   kernel/trace/trace.c:2861:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace.c:2861:38: sparse:     expected struct event_filter *filter
   kernel/trace/trace.c:2861:38: sparse:     got struct event_filter [noderef] __rcu *filter
   kernel/trace/trace.c:360:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:360:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:360:9: sparse:    struct trace_export *
   kernel/trace/trace.c:375:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:375:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:375:9: sparse:    struct trace_export *
--
>> drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *[usertype] value @@
   drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse:     expected int *__ptr_clean
   drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse:     got int [noderef] __user *[usertype] value
>> drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse:     got int *__ptr_clean
>> drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse:     got int *__ptr_clean
--
>> drivers/gpu/drm/i915/i915_perf.c:3623:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user *uprop @@
   drivers/gpu/drm/i915/i915_perf.c:3623:23: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:3623:23: sparse:     got unsigned long long [noderef] [usertype] __user *uprop
>> drivers/gpu/drm/i915/i915_perf.c:3623:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/i915_perf.c:3623:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_perf.c:3623:23: sparse:     got unsigned long long *__ptr_clean
>> drivers/gpu/drm/i915/i915_perf.c:3627:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/gpu/drm/i915/i915_perf.c:3627:23: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:3627:23: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/gpu/drm/i915/i915_perf.c:3627:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/i915_perf.c:3627:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_perf.c:3627:23: sparse:     got unsigned long long *__ptr_clean
>> drivers/gpu/drm/i915/i915_perf.c:4026:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *regs @@
   drivers/gpu/drm/i915/i915_perf.c:4026:23: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:4026:23: sparse:     got unsigned int [noderef] [usertype] __user *regs
>> drivers/gpu/drm/i915/i915_perf.c:4026:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/i915/i915_perf.c:4026:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_perf.c:4026:23: sparse:     got unsigned int *__ptr_clean
>> drivers/gpu/drm/i915/i915_perf.c:4036:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/i915/i915_perf.c:4036:23: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:4036:23: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/i915/i915_perf.c:4036:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/i915/i915_perf.c:4036:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_perf.c:4036:23: sparse:     got unsigned int *__ptr_clean
--
>> drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse:     got unsigned int [noderef] __user *
>> drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse:     got unsigned int [noderef] __user *
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse:     got unsigned int [noderef] __user *
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse:     got unsigned int *__ptr_clean
>> drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse:     got unsigned long long [noderef] __user *
>> drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse:     got unsigned long long *__ptr_clean
--
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:411:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:411:13: sparse:     expected unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:411:13: sparse:     got unsigned short [noderef] __user *
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:411:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:411:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:411:13: sparse:     got unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:427:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:427:13: sparse:     expected unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:427:13: sparse:     got unsigned short [noderef] __user *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:427:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:427:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:427:13: sparse:     got unsigned short *__ptr_clean
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:430:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:430:15: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:430:15: sparse:     got unsigned int [noderef] __user *
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:430:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:430:15: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:430:15: sparse:     got unsigned int *__ptr_clean
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:434:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:434:15: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:434:15: sparse:     got unsigned long long [noderef] __user *
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:434:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:434:15: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:434:15: sparse:     got unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:502:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:502:13: sparse:     expected unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:502:13: sparse:     got unsigned short [noderef] __user *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:502:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:502:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:502:13: sparse:     got unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:524:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:524:15: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:524:15: sparse:     got unsigned long long [noderef] __user *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:524:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:524:15: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:524:15: sparse:     got unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:529:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:529:23: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:529:23: sparse:     got unsigned long long [noderef] __user *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:529:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:529:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:529:23: sparse:     got unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:552:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:552:13: sparse:     expected unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:552:13: sparse:     got unsigned short [noderef] __user *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:552:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:552:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:552:13: sparse:     got unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:590:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:590:13: sparse:     expected unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:590:13: sparse:     got unsigned short [noderef] __user *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:590:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:590:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:590:13: sparse:     got unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:593:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:593:13: sparse:     expected unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:593:13: sparse:     got unsigned short [noderef] __user *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:593:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:593:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:593:13: sparse:     got unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:596:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:596:13: sparse:     expected unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:596:13: sparse:     got unsigned short [noderef] __user *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:596:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:596:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:596:13: sparse:     got unsigned short *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:618:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:618:13: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:618:13: sparse:     got unsigned long long [noderef] __user *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:618:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:618:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:618:13: sparse:     got unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:627:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:627:23: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:627:23: sparse:     got unsigned long long [noderef] __user *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:627:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:627:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:627:23: sparse:     got unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:795:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:795:14: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:795:14: sparse:     got unsigned long long [noderef] __user *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:795:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:795:14: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/gem/i915_gem_context.c:795:14: sparse:     got unsigned long long *__ptr_clean
--
>> drivers/gpu/drm/i915/i915_query.c:224:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/gpu/drm/i915/i915_query.c:224:13: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:224:13: sparse:     got unsigned int [noderef] __user *
>> drivers/gpu/drm/i915/i915_query.c:224:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/i915/i915_query.c:224:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_query.c:224:13: sparse:     got unsigned int *__ptr_clean
>> drivers/gpu/drm/i915/i915_query.c:251:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/gpu/drm/i915/i915_query.c:251:21: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:251:21: sparse:     got unsigned long long [noderef] __user *
>> drivers/gpu/drm/i915/i915_query.c:251:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/i915_query.c:251:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_query.c:251:21: sparse:     got unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/gpu/drm/i915/i915_query.c:354:13: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:354:13: sparse:     got unsigned int [noderef] __user *
   drivers/gpu/drm/i915/i915_query.c:354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/i915/i915_query.c:354:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_query.c:354:13: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:394:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/gpu/drm/i915/i915_query.c:394:13: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:394:13: sparse:     got unsigned long long [noderef] __user *
   drivers/gpu/drm/i915/i915_query.c:394:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/i915_query.c:394:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_query.c:394:13: sparse:     got unsigned long long *__ptr_clean
>> drivers/gpu/drm/i915/i915_query.c:394:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/i915/i915_query.c:394:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/i915/i915_query.c:394:13: sparse:     got unsigned long long *__ptr_clean
>> drivers/gpu/drm/i915/i915_query.c:525:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   drivers/gpu/drm/i915/i915_query.c:525:43: sparse:     expected signed int *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:525:43: sparse:     got signed int [noderef] __user *
>> drivers/gpu/drm/i915/i915_query.c:525:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/i915/i915_query.c:525:43: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/i915/i915_query.c:525:43: sparse:     got signed int *__ptr_clean
>> drivers/gpu/drm/i915/i915_query.c:525:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/i915/i915_query.c:525:43: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/i915/i915_query.c:525:43: sparse:     got signed int *__ptr_clean
--
>> drivers/rtc/rtc-abx80x.c:527:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/rtc-abx80x.c:527:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/rtc-abx80x.c:527:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/rtc/rtc-pcf2127.c:231:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/rtc-pcf2127.c:231:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/rtc-pcf2127.c:231:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/rtc/rtc-pcf85063.c:304:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/rtc-pcf85063.c:304:24: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/rtc-pcf85063.c:304:24: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/rtc-pcf85063.c:304:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-pcf85063.c:304:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-pcf85063.c:304:24: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/rtc-pcf85063.c:304:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-pcf85063.c:304:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-pcf85063.c:304:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/rtc/rtc-rv3029c2.c:463:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/rtc-rv3029c2.c:463:24: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/rtc-rv3029c2.c:463:24: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/rtc-rv3029c2.c:463:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rv3029c2.c:463:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-rv3029c2.c:463:24: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/rtc-rv3029c2.c:463:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rv3029c2.c:463:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-rv3029c2.c:463:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/rtc/rtc-rx8010.c:350:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/rtc-rx8010.c:350:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/rtc-rx8010.c:350:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/rtc/rtc-pcf8523.c:332:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/rtc-pcf8523.c:332:24: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/rtc-pcf8523.c:332:24: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/rtc-pcf8523.c:332:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-pcf8523.c:332:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-pcf8523.c:332:24: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/rtc-pcf8523.c:332:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-pcf8523.c:332:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-pcf8523.c:332:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/rtc/rtc-pcf8563.c:288:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/rtc-pcf8563.c:288:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/rtc-pcf8563.c:288:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/rtc/rtc-rv8803.c:432:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/rtc-rv8803.c:432:24: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/rtc-rv8803.c:432:24: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/rtc-rv8803.c:432:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rv8803.c:432:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-rv8803.c:432:24: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/rtc-rv8803.c:432:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rv8803.c:432:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-rv8803.c:432:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/mtd/ubi/cdev.c:467:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:467:23: sparse:     expected signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:467:23: sparse:     got signed int [noderef] [usertype] __user *
>> drivers/mtd/ubi/cdev.c:467:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/mtd/ubi/cdev.c:467:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:467:23: sparse:     got signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:512:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:512:23: sparse:     expected signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:512:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:512:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/mtd/ubi/cdev.c:512:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:512:23: sparse:     got signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:526:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:526:23: sparse:     expected signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:526:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:526:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/mtd/ubi/cdev.c:526:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:526:23: sparse:     got signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:869:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:869:23: sparse:     expected signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:869:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:869:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/mtd/ubi/cdev.c:869:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:869:23: sparse:     got signed int *__ptr_clean
>> drivers/mtd/ubi/cdev.c:869:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/mtd/ubi/cdev.c:869:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/mtd/ubi/cdev.c:869:23: sparse:     got signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:882:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:882:23: sparse:     expected signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:882:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:882:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/mtd/ubi/cdev.c:882:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:882:23: sparse:     got signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:969:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:969:23: sparse:     expected signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:969:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:969:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/mtd/ubi/cdev.c:969:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:969:23: sparse:     got signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:984:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:984:23: sparse:     expected signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:984:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:984:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/mtd/ubi/cdev.c:984:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:984:23: sparse:     got signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:1050:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     expected signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:1050:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     got signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:1050:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     got signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:1061:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     expected signed int *__ptr_clean
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:1061:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     got signed int *__ptr_clean
--
>> net/mptcp/protocol.c:3352:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/mptcp/protocol.c:3352:16: sparse:     expected int *__ptr_clean
   net/mptcp/protocol.c:3352:16: sparse:     got int [noderef] __user *
   net/mptcp/protocol.c:3352:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/protocol.c:3352:16: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/protocol.c:3352:16: sparse:     got int *__ptr_clean
   net/mptcp/protocol.c:3352:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/mptcp/protocol.c:3352:16: sparse:     expected void [noderef] __user *__ptr_pu
   net/mptcp/protocol.c:3352:16: sparse:     got int *__ptr_clean
   net/mptcp/protocol.c:2922:24: sparse: sparse: context imbalance in 'mptcp_sk_clone' - unexpected unlock
--
>> net/mptcp/sockopt.c:895:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/mptcp/sockopt.c:895:13: sparse:     expected int *__ptr_clean
   net/mptcp/sockopt.c:895:13: sparse:     got int [noderef] __user *optlen
   net/mptcp/sockopt.c:895:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:895:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:895:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:902:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/mptcp/sockopt.c:902:13: sparse:     expected int *__ptr_clean
   net/mptcp/sockopt.c:902:13: sparse:     got int [noderef] __user *optlen
   net/mptcp/sockopt.c:902:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:902:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:902:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:902:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:902:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/mptcp/sockopt.c:902:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:923:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/mptcp/sockopt.c:923:13: sparse:     expected int *__ptr_clean
   net/mptcp/sockopt.c:923:13: sparse:     got int [noderef] __user *optlen
   net/mptcp/sockopt.c:923:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:923:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:923:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:923:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:923:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/mptcp/sockopt.c:923:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:937:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/mptcp/sockopt.c:937:13: sparse:     expected int *__ptr_clean
   net/mptcp/sockopt.c:937:13: sparse:     got int [noderef] __user *optlen
   net/mptcp/sockopt.c:937:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:937:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:937:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:1119:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/mptcp/sockopt.c:1119:13: sparse:     expected int *__ptr_clean
   net/mptcp/sockopt.c:1119:13: sparse:     got int [noderef] __user *optlen
   net/mptcp/sockopt.c:1119:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:1119:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:1119:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:1128:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/mptcp/sockopt.c:1128:21: sparse:     expected int *__ptr_clean
   net/mptcp/sockopt.c:1128:21: sparse:     got int [noderef] __user *optlen
   net/mptcp/sockopt.c:1128:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:1128:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:1128:21: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:1128:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:1128:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/mptcp/sockopt.c:1128:21: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:1134:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/mptcp/sockopt.c:1134:21: sparse:     expected int *__ptr_clean
   net/mptcp/sockopt.c:1134:21: sparse:     got int [noderef] __user *optlen
   net/mptcp/sockopt.c:1134:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:1134:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:1134:21: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:1134:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:1134:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/mptcp/sockopt.c:1134:21: sparse:     got int *__ptr_clean
--
>> drivers/tty/tty_io.c:2285:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *p @@
   drivers/tty/tty_io.c:2285:13: sparse:     expected char *__ptr_clean
   drivers/tty/tty_io.c:2285:13: sparse:     got char [noderef] __user *p
   drivers/tty/tty_io.c:2285:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   drivers/tty/tty_io.c:2285:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2285:13: sparse:     got char *__ptr_clean
>> drivers/tty/tty_io.c:2430:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   drivers/tty/tty_io.c:2430:13: sparse:     expected int *__ptr_clean
   drivers/tty/tty_io.c:2430:13: sparse:     got int [noderef] __user *p
   drivers/tty/tty_io.c:2430:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2430:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2430:13: sparse:     got int *__ptr_clean
   drivers/tty/tty_io.c:2456:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   drivers/tty/tty_io.c:2456:15: sparse:     expected int *__ptr_clean
   drivers/tty/tty_io.c:2456:15: sparse:     got int [noderef] __user *p
   drivers/tty/tty_io.c:2456:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2456:15: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2456:15: sparse:     got int *__ptr_clean
   drivers/tty/tty_io.c:2456:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2456:15: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_io.c:2456:15: sparse:     got int *__ptr_clean
   drivers/tty/tty_io.c:2517:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   drivers/tty/tty_io.c:2517:34: sparse:     expected int *__ptr_clean
   drivers/tty/tty_io.c:2517:34: sparse:     got int [noderef] __user *p
   drivers/tty/tty_io.c:2517:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2517:34: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2517:34: sparse:     got int *__ptr_clean
   drivers/tty/tty_io.c:2517:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2517:34: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_io.c:2517:34: sparse:     got int *__ptr_clean
>> drivers/tty/tty_io.c:2542:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *p @@
   drivers/tty/tty_io.c:2542:18: sparse:     expected unsigned int *__ptr_clean
   drivers/tty/tty_io.c:2542:18: sparse:     got unsigned int [noderef] __user *p
   drivers/tty/tty_io.c:2542:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/tty_io.c:2542:18: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2542:18: sparse:     got unsigned int *__ptr_clean
>> drivers/tty/tty_io.c:2709:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/tty/tty_io.c:2709:24: sparse:     expected int *__ptr_clean
   drivers/tty/tty_io.c:2709:24: sparse:     got int [noderef] __user *
   drivers/tty/tty_io.c:2709:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2709:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2709:24: sparse:     got int *__ptr_clean
   drivers/tty/tty_io.c:2709:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2709:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_io.c:2709:24: sparse:     got int *__ptr_clean
>> drivers/tty/tty_io.c:2724:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tty/tty_io.c:2724:24: sparse:     expected unsigned int *__ptr_clean
   drivers/tty/tty_io.c:2724:24: sparse:     got unsigned int [noderef] __user *
   drivers/tty/tty_io.c:2724:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/tty_io.c:2724:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2724:24: sparse:     got unsigned int *__ptr_clean
   drivers/tty/tty_io.c:2724:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tty/tty_io.c:2724:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_io.c:2724:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/tty/tty_ioctl.c:801:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/tty/tty_ioctl.c:801:23: sparse:     expected int *__ptr_clean
   drivers/tty/tty_ioctl.c:801:23: sparse:     got int [noderef] __user *
   drivers/tty/tty_ioctl.c:801:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_ioctl.c:801:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_ioctl.c:801:23: sparse:     got int *__ptr_clean
   drivers/tty/tty_ioctl.c:801:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_ioctl.c:801:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_ioctl.c:801:23: sparse:     got int *__ptr_clean
>> drivers/tty/tty_ioctl.c:805:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tty/tty_ioctl.c:805:21: sparse:     expected unsigned int *__ptr_clean
   drivers/tty/tty_ioctl.c:805:21: sparse:     got unsigned int [noderef] __user *
   drivers/tty/tty_ioctl.c:805:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/tty_ioctl.c:805:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_ioctl.c:805:21: sparse:     got unsigned int *__ptr_clean
   drivers/tty/tty_ioctl.c: note: in included file (through arch/x86/include/generated/uapi/asm/termios.h, include/uapi/linux/termios.h):
>> include/asm-generic/termios.h:25:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__ptr_clean @@     got unsigned short const [noderef] __user * @@
   include/asm-generic/termios.h:25:13: sparse:     expected unsigned short const *__ptr_clean
   include/asm-generic/termios.h:25:13: sparse:     got unsigned short const [noderef] __user *
   include/asm-generic/termios.h:25:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__ptr_clean @@
   include/asm-generic/termios.h:25:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:25:13: sparse:     got unsigned short const *__ptr_clean
   include/asm-generic/termios.h:29:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__ptr_clean @@     got unsigned short const [noderef] __user * @@
   include/asm-generic/termios.h:29:13: sparse:     expected unsigned short const *__ptr_clean
   include/asm-generic/termios.h:29:13: sparse:     got unsigned short const [noderef] __user *
   include/asm-generic/termios.h:29:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__ptr_clean @@
   include/asm-generic/termios.h:29:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:29:13: sparse:     got unsigned short const *__ptr_clean
   include/asm-generic/termios.h:33:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__ptr_clean @@     got unsigned short const [noderef] __user * @@
   include/asm-generic/termios.h:33:13: sparse:     expected unsigned short const *__ptr_clean
   include/asm-generic/termios.h:33:13: sparse:     got unsigned short const [noderef] __user *
   include/asm-generic/termios.h:33:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__ptr_clean @@
   include/asm-generic/termios.h:33:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:33:13: sparse:     got unsigned short const *__ptr_clean
   include/asm-generic/termios.h:37:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__ptr_clean @@     got unsigned short const [noderef] __user * @@
   include/asm-generic/termios.h:37:13: sparse:     expected unsigned short const *__ptr_clean
   include/asm-generic/termios.h:37:13: sparse:     got unsigned short const [noderef] __user *
   include/asm-generic/termios.h:37:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__ptr_clean @@
   include/asm-generic/termios.h:37:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:37:13: sparse:     got unsigned short const *__ptr_clean
>> include/asm-generic/termios.h:41:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__ptr_clean @@     got unsigned char const [noderef] __user * @@
   include/asm-generic/termios.h:41:13: sparse:     expected unsigned char const *__ptr_clean
   include/asm-generic/termios.h:41:13: sparse:     got unsigned char const [noderef] __user *
   include/asm-generic/termios.h:41:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__ptr_clean @@
   include/asm-generic/termios.h:41:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:41:13: sparse:     got unsigned char const *__ptr_clean
>> include/asm-generic/termios.h:59:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   include/asm-generic/termios.h:59:13: sparse:     expected unsigned short *__ptr_clean
   include/asm-generic/termios.h:59:13: sparse:     got unsigned short [noderef] __user *
   include/asm-generic/termios.h:59:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:59:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:59:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:59:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:59:13: sparse:     expected void [noderef] __user *__ptr_pu
   include/asm-generic/termios.h:59:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:60:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   include/asm-generic/termios.h:60:13: sparse:     expected unsigned short *__ptr_clean
   include/asm-generic/termios.h:60:13: sparse:     got unsigned short [noderef] __user *
   include/asm-generic/termios.h:60:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:60:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:60:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:60:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:60:13: sparse:     expected void [noderef] __user *__ptr_pu
   include/asm-generic/termios.h:60:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:61:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   include/asm-generic/termios.h:61:13: sparse:     expected unsigned short *__ptr_clean
   include/asm-generic/termios.h:61:13: sparse:     got unsigned short [noderef] __user *
   include/asm-generic/termios.h:61:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:61:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:61:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:61:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:61:13: sparse:     expected void [noderef] __user *__ptr_pu
   include/asm-generic/termios.h:61:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:62:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   include/asm-generic/termios.h:62:13: sparse:     expected unsigned short *__ptr_clean
   include/asm-generic/termios.h:62:13: sparse:     got unsigned short [noderef] __user *
   include/asm-generic/termios.h:62:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:62:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:62:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:62:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:62:13: sparse:     expected void [noderef] __user *__ptr_pu
   include/asm-generic/termios.h:62:13: sparse:     got unsigned short *__ptr_clean
>> include/asm-generic/termios.h:63:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__ptr_clean @@     got unsigned char [noderef] __user * @@
   include/asm-generic/termios.h:63:13: sparse:     expected unsigned char *__ptr_clean
   include/asm-generic/termios.h:63:13: sparse:     got unsigned char [noderef] __user *
   include/asm-generic/termios.h:63:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   include/asm-generic/termios.h:63:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:63:13: sparse:     got unsigned char *__ptr_clean
   include/asm-generic/termios.h:63:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned char *__ptr_clean @@
   include/asm-generic/termios.h:63:13: sparse:     expected void [noderef] __user *__ptr_pu
   include/asm-generic/termios.h:63:13: sparse:     got unsigned char *__ptr_clean
--
>> drivers/tty/n_tty.c:2371:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/tty/n_tty.c:2371:24: sparse:     expected int *__ptr_clean
   drivers/tty/n_tty.c:2371:24: sparse:     got int [noderef] __user *
   drivers/tty/n_tty.c:2371:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/n_tty.c:2371:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/n_tty.c:2371:24: sparse:     got int *__ptr_clean
   drivers/tty/n_tty.c:2371:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/n_tty.c:2371:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/n_tty.c:2371:24: sparse:     got int *__ptr_clean
>> drivers/tty/n_tty.c:2379:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tty/n_tty.c:2379:24: sparse:     expected unsigned int *__ptr_clean
   drivers/tty/n_tty.c:2379:24: sparse:     got unsigned int [noderef] __user *
   drivers/tty/n_tty.c:2379:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/n_tty.c:2379:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/n_tty.c:2379:24: sparse:     got unsigned int *__ptr_clean
   drivers/tty/n_tty.c:2379:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tty/n_tty.c:2379:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/n_tty.c:2379:24: sparse:     got unsigned int *__ptr_clean
--
   drivers/tty/tty_jobctrl.c:80:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:80:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:80:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:83:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:83:34: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:83:34: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:124:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:124:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:124:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:126:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:126:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:126:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:135:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:135:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:135:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:156:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:156:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:156:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:165:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:165:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:167:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:167:40: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:167:40: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:205:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:205:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:205:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:215:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:215:51: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:215:51: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:227:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:227:43: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:227:43: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:291:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:291:39: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:291:39: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:294:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:294:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:294:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:303:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:303:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:303:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:307:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:307:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:307:33: sparse:     got struct spinlock [noderef] __rcu *
>> drivers/tty/tty_jobctrl.c:472:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] [usertype] __user *p @@
   drivers/tty/tty_jobctrl.c:472:16: sparse:     expected int *__ptr_clean
   drivers/tty/tty_jobctrl.c:472:16: sparse:     got int [noderef] [usertype] __user *p
   drivers/tty/tty_jobctrl.c:472:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_jobctrl.c:472:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_jobctrl.c:472:16: sparse:     got int *__ptr_clean
   drivers/tty/tty_jobctrl.c:472:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_jobctrl.c:472:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_jobctrl.c:472:16: sparse:     got int *__ptr_clean
   drivers/tty/tty_jobctrl.c:499:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] [usertype] __user *p @@
   drivers/tty/tty_jobctrl.c:499:13: sparse:     expected int *__ptr_clean
   drivers/tty/tty_jobctrl.c:499:13: sparse:     got int [noderef] [usertype] __user *p
   drivers/tty/tty_jobctrl.c:499:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_jobctrl.c:499:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_jobctrl.c:499:13: sparse:     got int *__ptr_clean
   drivers/tty/tty_jobctrl.c:556:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] [usertype] __user *p @@
   drivers/tty/tty_jobctrl.c:556:16: sparse:     expected int *__ptr_clean
   drivers/tty/tty_jobctrl.c:556:16: sparse:     got int [noderef] [usertype] __user *p
   drivers/tty/tty_jobctrl.c:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_jobctrl.c:556:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_jobctrl.c:556:16: sparse:     got int *__ptr_clean
   drivers/tty/tty_jobctrl.c:556:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_jobctrl.c:556:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_jobctrl.c:556:16: sparse:     got int *__ptr_clean
   drivers/tty/tty_jobctrl.c:19:41: sparse: sparse: dereference of noderef expression
--
>> drivers/tty/pty.c:151:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *arg @@
   drivers/tty/pty.c:151:13: sparse:     expected int *__ptr_clean
   drivers/tty/pty.c:151:13: sparse:     got int [noderef] __user *arg
   drivers/tty/pty.c:151:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/pty.c:151:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:151:13: sparse:     got int *__ptr_clean
   drivers/tty/pty.c:164:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *arg @@
   drivers/tty/pty.c:164:16: sparse:     expected int *__ptr_clean
   drivers/tty/pty.c:164:16: sparse:     got int [noderef] __user *arg
   drivers/tty/pty.c:164:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/pty.c:164:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:164:16: sparse:     got int *__ptr_clean
   drivers/tty/pty.c:164:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/pty.c:164:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/pty.c:164:16: sparse:     got int *__ptr_clean
   drivers/tty/pty.c:172:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *arg @@
   drivers/tty/pty.c:172:13: sparse:     expected int *__ptr_clean
   drivers/tty/pty.c:172:13: sparse:     got int [noderef] __user *arg
   drivers/tty/pty.c:172:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/pty.c:172:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:172:13: sparse:     got int *__ptr_clean
   drivers/tty/pty.c:194:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *arg @@
   drivers/tty/pty.c:194:16: sparse:     expected int *__ptr_clean
   drivers/tty/pty.c:194:16: sparse:     got int [noderef] __user *arg
   drivers/tty/pty.c:194:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/pty.c:194:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:194:16: sparse:     got int *__ptr_clean
   drivers/tty/pty.c:194:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/pty.c:194:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/pty.c:194:16: sparse:     got int *__ptr_clean
>> drivers/tty/pty.c:665:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tty/pty.c:665:24: sparse:     expected unsigned int *__ptr_clean
   drivers/tty/pty.c:665:24: sparse:     got unsigned int [noderef] __user *
   drivers/tty/pty.c:665:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/pty.c:665:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:665:24: sparse:     got unsigned int *__ptr_clean
   drivers/tty/pty.c:665:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tty/pty.c:665:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/pty.c:665:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/tty/sysrq.c:1158:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user *buf @@
   drivers/tty/sysrq.c:1158:21: sparse:     expected char const *__ptr_clean
   drivers/tty/sysrq.c:1158:21: sparse:     got char const [noderef] __user *buf
   drivers/tty/sysrq.c:1158:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/tty/sysrq.c:1158:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/sysrq.c:1158:21: sparse:     got char const *__ptr_clean
   drivers/tty/sysrq.c:150:13: sparse: sparse: context imbalance in 'sysrq_handle_crash' - unexpected unlock
--
>> drivers/tty/moxa.c:632:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   drivers/tty/moxa.c:632:23: sparse:     expected unsigned long *__ptr_clean
   drivers/tty/moxa.c:632:23: sparse:     got unsigned long [noderef] __user *
>> drivers/tty/moxa.c:632:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   drivers/tty/moxa.c:632:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/moxa.c:632:23: sparse:     got unsigned long *__ptr_clean
>> drivers/tty/moxa.c:632:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   drivers/tty/moxa.c:632:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/moxa.c:632:23: sparse:     got unsigned long *__ptr_clean
   drivers/tty/moxa.c:636:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   drivers/tty/moxa.c:636:23: sparse:     expected unsigned long *__ptr_clean
   drivers/tty/moxa.c:636:23: sparse:     got unsigned long [noderef] __user *
   drivers/tty/moxa.c:636:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   drivers/tty/moxa.c:636:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/moxa.c:636:23: sparse:     got unsigned long *__ptr_clean
   drivers/tty/moxa.c:636:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   drivers/tty/moxa.c:636:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/moxa.c:636:23: sparse:     got unsigned long *__ptr_clean
--
>> drivers/tty/synclink_gt.c:2555:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *idle_mode @@
   drivers/tty/synclink_gt.c:2555:13: sparse:     expected int *__ptr_clean
   drivers/tty/synclink_gt.c:2555:13: sparse:     got int [noderef] __user *idle_mode
>> drivers/tty/synclink_gt.c:2555:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/synclink_gt.c:2555:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/synclink_gt.c:2555:13: sparse:     got int *__ptr_clean
>> drivers/tty/synclink_gt.c:2555:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/synclink_gt.c:2555:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/synclink_gt.c:2555:13: sparse:     got int *__ptr_clean
>> drivers/tty/synclink_gt.c:2662:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *mask_ptr @@
   drivers/tty/synclink_gt.c:2662:13: sparse:     expected int *__ptr_clean
   drivers/tty/synclink_gt.c:2662:13: sparse:     got int [noderef] __user *mask_ptr
   drivers/tty/synclink_gt.c:2662:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/synclink_gt.c:2662:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/synclink_gt.c:2662:13: sparse:     got int *__ptr_clean
   drivers/tty/synclink_gt.c:2761:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *mask_ptr @@
   drivers/tty/synclink_gt.c:2761:22: sparse:     expected int *__ptr_clean
   drivers/tty/synclink_gt.c:2761:22: sparse:     got int [noderef] __user *mask_ptr
   drivers/tty/synclink_gt.c:2761:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/synclink_gt.c:2761:22: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/synclink_gt.c:2761:22: sparse:     got int *__ptr_clean
   drivers/tty/synclink_gt.c:2761:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/synclink_gt.c:2761:22: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/synclink_gt.c:2761:22: sparse:     got int *__ptr_clean
>> drivers/tty/synclink_gt.c:2768:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *if_mode @@
   drivers/tty/synclink_gt.c:2768:13: sparse:     expected int *__ptr_clean
   drivers/tty/synclink_gt.c:2768:13: sparse:     got int [noderef] __user *if_mode
   drivers/tty/synclink_gt.c:2768:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/synclink_gt.c:2768:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/synclink_gt.c:2768:13: sparse:     got int *__ptr_clean
   drivers/tty/synclink_gt.c:2768:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/synclink_gt.c:2768:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/synclink_gt.c:2768:13: sparse:     got int *__ptr_clean
>> drivers/tty/synclink_gt.c:2799:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *xsync @@
   drivers/tty/synclink_gt.c:2799:13: sparse:     expected int *__ptr_clean
   drivers/tty/synclink_gt.c:2799:13: sparse:     got int [noderef] __user *xsync
   drivers/tty/synclink_gt.c:2799:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/synclink_gt.c:2799:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/synclink_gt.c:2799:13: sparse:     got int *__ptr_clean
   drivers/tty/synclink_gt.c:2799:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/synclink_gt.c:2799:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/synclink_gt.c:2799:13: sparse:     got int *__ptr_clean
>> drivers/tty/synclink_gt.c:2825:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *xctrl @@
   drivers/tty/synclink_gt.c:2825:13: sparse:     expected int *__ptr_clean
   drivers/tty/synclink_gt.c:2825:13: sparse:     got int [noderef] __user *xctrl
   drivers/tty/synclink_gt.c:2825:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/synclink_gt.c:2825:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/synclink_gt.c:2825:13: sparse:     got int *__ptr_clean
   drivers/tty/synclink_gt.c:2825:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/synclink_gt.c:2825:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/synclink_gt.c:2825:13: sparse:     got int *__ptr_clean
--
   drivers/tty/mxser.c:291:32: sparse: sparse: array of flexible structures
>> drivers/tty/mxser.c:1093:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *value @@
   drivers/tty/mxser.c:1093:16: sparse:     expected unsigned int *__ptr_clean
   drivers/tty/mxser.c:1093:16: sparse:     got unsigned int [noderef] __user *value
>> drivers/tty/mxser.c:1093:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/mxser.c:1093:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/mxser.c:1093:16: sparse:     got unsigned int *__ptr_clean
>> drivers/tty/mxser.c:1093:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tty/mxser.c:1093:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/mxser.c:1093:16: sparse:     got unsigned int *__ptr_clean
>> drivers/tty/mxser.c:1178:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *u_opmode @@
   drivers/tty/mxser.c:1178:21: sparse:     expected int *__ptr_clean
   drivers/tty/mxser.c:1178:21: sparse:     got int [noderef] __user *u_opmode
>> drivers/tty/mxser.c:1178:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/mxser.c:1178:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/mxser.c:1178:21: sparse:     got int *__ptr_clean
   drivers/tty/mxser.c:1198:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *u_opmode @@
   drivers/tty/mxser.c:1198:16: sparse:     expected int *__ptr_clean
   drivers/tty/mxser.c:1198:16: sparse:     got int [noderef] __user *u_opmode
   drivers/tty/mxser.c:1198:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/mxser.c:1198:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/mxser.c:1198:16: sparse:     got int *__ptr_clean
>> drivers/tty/mxser.c:1198:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/mxser.c:1198:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/mxser.c:1198:16: sparse:     got int *__ptr_clean
--
>> drivers/tty/serial/serial_core.c:1041:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *value @@
   drivers/tty/serial/serial_core.c:1041:16: sparse:     expected unsigned int *__ptr_clean
   drivers/tty/serial/serial_core.c:1041:16: sparse:     got unsigned int [noderef] __user *value
   drivers/tty/serial/serial_core.c:1041:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/serial/serial_core.c:1041:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/serial/serial_core.c:1041:16: sparse:     got unsigned int *__ptr_clean
   drivers/tty/serial/serial_core.c:1041:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tty/serial/serial_core.c:1041:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/serial/serial_core.c:1041:16: sparse:     got unsigned int *__ptr_clean
   drivers/tty/serial/serial_core.c:139:9: sparse: sparse: context imbalance in 'uart_start' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:211:17: sparse: sparse: context imbalance in 'uart_port_startup' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:320:9: sparse: sparse: context imbalance in 'uart_shutdown' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:540:9: sparse: sparse: context imbalance in 'uart_put_char' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:588:9: sparse: sparse: context imbalance in 'uart_write' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:601:9: sparse: sparse: context imbalance in 'uart_write_room' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:614:9: sparse: sparse: context imbalance in 'uart_chars_in_buffer' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:641:9: sparse: sparse: context imbalance in 'uart_flush_buffer' - different lock contexts for basic block
--
   kernel/events/core.c:1493:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1493:15: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1493:15: sparse:    struct perf_event_context *
   kernel/events/core.c:1506:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1506:28: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1506:28: sparse:    struct perf_event_context *
   kernel/events/core.c:3492:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3492:18: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3492:18: sparse:    struct perf_event_context *
   kernel/events/core.c:3493:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3493:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3493:23: sparse:    struct perf_event_context *
   kernel/events/core.c:3541:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3541:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3541:25: sparse:    struct perf_event_context *
   kernel/events/core.c:3542:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3542:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3542:25: sparse:    struct perf_event_context *
   kernel/events/core.c:4788:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:4788:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:4788:25: sparse:    struct perf_event_context *
   kernel/events/core.c:6053:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:6053:9: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:6053:9: sparse:    struct perf_buffer *
   kernel/events/core.c:5525:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] events @@     got int @@
>> kernel/events/core.c:11814:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   kernel/events/core.c:11814:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/events/core.c:11926:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   kernel/events/core.c:11926:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/events/core.c:11926:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/events/core.c:5769:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5769:22: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5769:22: sparse:    struct perf_buffer *
   kernel/events/core.c:5893:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5893:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5893:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5926:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5926:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5926:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5983:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5983:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5983:14: sparse:    struct perf_buffer *
   kernel/events/core.c:6074:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:6074:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:6074:14: sparse:    struct perf_buffer *
   kernel/events/core.c:6090:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:6090:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:6090:14: sparse:    struct perf_buffer *
   kernel/events/core.c:7733:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7733:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:7733:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7785:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7785:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:7785:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7824:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7824:13: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:7824:13: sparse:    struct perf_buffer *
   kernel/events/core.c:7929:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7929:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7929:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:7931:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7931:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7931:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:8632:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8632:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:8632:23: sparse:    struct perf_event_context *
   kernel/events/core.c:9626:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9626:9: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9626:9: sparse:    struct swevent_hlist *
   kernel/events/core.c:9665:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9665:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9665:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9846:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9846:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:9846:23: sparse:    struct perf_event_context *
   kernel/events/core.c:11025:1: sparse: sparse: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
   kernel/events/core.c:12826:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12826:9: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12826:9: sparse:    struct perf_event_context *
   kernel/events/core.c:12936:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12936:17: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12936:17: sparse:    struct perf_event_context *
   kernel/events/core.c:13366:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:13366:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:13366:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:167:9: sparse: sparse: context imbalance in 'perf_ctx_lock' - wrong count at exit
   kernel/events/core.c:175:17: sparse: sparse: context imbalance in 'perf_ctx_unlock' - unexpected unlock
   kernel/events/core.c: note: in included file (through include/linux/rcupdate.h, include/linux/rculist.h, include/linux/dcache.h, ...):
   include/linux/rcutiny.h:101:44: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
   kernel/events/core.c:1540:17: sparse: sparse: context imbalance in 'perf_pin_task_context' - unexpected unlock
   kernel/events/core.c:2865:9: sparse: sparse: context imbalance in '__perf_install_in_context' - wrong count at exit
   kernel/events/core.c:4760:17: sparse: sparse: context imbalance in 'find_get_context' - unexpected unlock
   kernel/events/core.c: note: in included file:
   kernel/events/internal.h:204:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *buf @@
   kernel/events/core.c:9475:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9475:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9475:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9495:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9495:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9495:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9615:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9615:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9615:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist *
--
>> drivers/usb/core/devio.c:950:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:950:13: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/core/devio.c:950:13: sparse:     got unsigned int [noderef] __user *
>> drivers/usb/core/devio.c:950:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:950:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:950:13: sparse:     got unsigned int *__ptr_clean
   drivers/usb/core/devio.c:951:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:951:13: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/core/devio.c:951:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:951:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:951:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:951:13: sparse:     got unsigned int *__ptr_clean
>> drivers/usb/core/devio.c:966:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__ptr_clean @@     got unsigned char [noderef] __user * @@
   drivers/usb/core/devio.c:966:21: sparse:     expected unsigned char *__ptr_clean
   drivers/usb/core/devio.c:966:21: sparse:     got unsigned char [noderef] __user *
>> drivers/usb/core/devio.c:966:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   drivers/usb/core/devio.c:966:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:966:21: sparse:     got unsigned char *__ptr_clean
   drivers/usb/core/devio.c:1385:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:1385:13: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/core/devio.c:1385:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:1385:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:1385:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1385:13: sparse:     got unsigned int *__ptr_clean
   drivers/usb/core/devio.c:1404:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:1404:13: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/core/devio.c:1404:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:1404:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:1404:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1404:13: sparse:     got unsigned int *__ptr_clean
>> drivers/usb/core/devio.c:1536:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/usb/core/devio.c:1536:13: sparse:     expected int *__ptr_clean
   drivers/usb/core/devio.c:1536:13: sparse:     got int [noderef] __user *
>> drivers/usb/core/devio.c:1536:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/usb/core/devio.c:1536:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1536:13: sparse:     got int *__ptr_clean
   drivers/usb/core/devio.c:2039:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/usb/core/devio.c:2039:13: sparse:     expected int *__ptr_clean
   drivers/usb/core/devio.c:2039:13: sparse:     got int [noderef] __user *
   drivers/usb/core/devio.c:2039:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/usb/core/devio.c:2039:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2039:13: sparse:     got int *__ptr_clean
>> drivers/usb/core/devio.c:2039:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/usb/core/devio.c:2039:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/core/devio.c:2039:13: sparse:     got int *__ptr_clean
   drivers/usb/core/devio.c:2041:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/usb/core/devio.c:2041:13: sparse:     expected int *__ptr_clean
   drivers/usb/core/devio.c:2041:13: sparse:     got int [noderef] __user *
   drivers/usb/core/devio.c:2041:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/usb/core/devio.c:2041:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2041:13: sparse:     got int *__ptr_clean
   drivers/usb/core/devio.c:2041:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/usb/core/devio.c:2041:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/core/devio.c:2041:13: sparse:     got int *__ptr_clean
   drivers/usb/core/devio.c:2043:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/usb/core/devio.c:2043:13: sparse:     expected int *__ptr_clean
   drivers/usb/core/devio.c:2043:13: sparse:     got int [noderef] __user *
   drivers/usb/core/devio.c:2043:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/usb/core/devio.c:2043:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2043:13: sparse:     got int *__ptr_clean
   drivers/usb/core/devio.c:2043:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/usb/core/devio.c:2043:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/core/devio.c:2043:13: sparse:     got int *__ptr_clean
   drivers/usb/core/devio.c:2048:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2048:29: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2048:29: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2048:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:2048:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2048:29: sparse:     got unsigned int *__ptr_clean
>> drivers/usb/core/devio.c:2048:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:2048:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/core/devio.c:2048:29: sparse:     got unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2051:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2051:29: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2051:29: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2051:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:2051:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2051:29: sparse:     got unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2051:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:2051:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/core/devio.c:2051:29: sparse:     got unsigned int *__ptr_clean
>> drivers/usb/core/devio.c:2057:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user **__ptr_clean @@     got void [noderef] __user *[noderef] __user * @@
   drivers/usb/core/devio.c:2057:13: sparse:     expected void [noderef] __user **__ptr_clean
   drivers/usb/core/devio.c:2057:13: sparse:     got void [noderef] __user *[noderef] __user *
>> drivers/usb/core/devio.c:2057:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got void [noderef] __user **__ptr_clean @@
   drivers/usb/core/devio.c:2057:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2057:13: sparse:     got void [noderef] __user **__ptr_clean
>> drivers/usb/core/devio.c:2057:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got void [noderef] __user **__ptr_clean @@
   drivers/usb/core/devio.c:2057:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/core/devio.c:2057:13: sparse:     got void [noderef] __user **__ptr_clean
   drivers/usb/core/devio.c:2284:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2284:13: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2284:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2284:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:2284:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2284:13: sparse:     got unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2294:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2294:13: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2294:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2294:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:2294:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2294:13: sparse:     got unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2410:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2410:13: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2410:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2410:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:2410:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2410:13: sparse:     got unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2423:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2423:13: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2423:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2423:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:2423:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2423:13: sparse:     got unsigned int *__ptr_clean
>> drivers/usb/core/devio.c:2441:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/core/devio.c:2441:13: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2441:13: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/usb/core/devio.c:2441:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:2441:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2441:13: sparse:     got unsigned int *__ptr_clean
   drivers/usb/core/devio.c:2441:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/usb/core/devio.c:2441:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/core/devio.c:2441:13: sparse:     got unsigned int *__ptr_clean
--
>> drivers/vfio/vfio.c:1449:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/vfio/vfio.c:1449:21: sparse:     expected int *__ptr_clean
   drivers/vfio/vfio.c:1449:21: sparse:     got int [noderef] __user *
>> drivers/vfio/vfio.c:1449:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/vfio/vfio.c:1449:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vfio/vfio.c:1449:21: sparse:     got int *__ptr_clean
--
>> drivers/video/fbdev/aty/atyfb_base.c:1850:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/video/fbdev/aty/atyfb_base.c:1850:29: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/aty/atyfb_base.c:1850:29: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/video/fbdev/aty/atyfb_base.c:1850:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/aty/atyfb_base.c:1850:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/aty/atyfb_base.c:1850:29: sparse:     got unsigned int *__ptr_clean
--
>> drivers/video/fbdev/aty/aty128fb.c:2310:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/video/fbdev/aty/aty128fb.c:2310:22: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/aty/aty128fb.c:2310:22: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/video/fbdev/aty/aty128fb.c:2310:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/aty/aty128fb.c:2310:22: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/aty/aty128fb.c:2310:22: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/aty/aty128fb.c:2324:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/video/fbdev/aty/aty128fb.c:2324:24: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/aty/aty128fb.c:2324:24: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/video/fbdev/aty/aty128fb.c:2324:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/aty/aty128fb.c:2324:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/aty/aty128fb.c:2324:24: sparse:     got unsigned int *__ptr_clean
>> drivers/video/fbdev/aty/aty128fb.c:2324:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/aty/aty128fb.c:2324:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/aty/aty128fb.c:2324:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/usb/image/mdc800.c:806:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user * @@
   drivers/usb/image/mdc800.c:806:20: sparse:     expected char const *__ptr_clean
   drivers/usb/image/mdc800.c:806:20: sparse:     got char const [noderef] __user *
>> drivers/usb/image/mdc800.c:806:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/usb/image/mdc800.c:806:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/image/mdc800.c:806:20: sparse:     got char const *__ptr_clean
--
>> drivers/usb/mon/mon_bin.c:928:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/mon/mon_bin.c:928:21: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:928:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/usb/mon/mon_bin.c:928:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/mon/mon_bin.c:928:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/mon/mon_bin.c:928:21: sparse:     got unsigned int *__ptr_clean
>> drivers/usb/mon/mon_bin.c:928:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/usb/mon/mon_bin.c:928:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/mon/mon_bin.c:928:21: sparse:     got unsigned int *__ptr_clean
>> drivers/usb/mon/mon_bin.c:1094:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     got unsigned int [noderef] __user *
   drivers/usb/mon/mon_bin.c:1094:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     got unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:1094:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     got unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:1100:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     got unsigned int [noderef] __user *
   drivers/usb/mon/mon_bin.c:1100:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     got unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:1100:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     got unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:1118:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     got unsigned int [noderef] __user *
   drivers/usb/mon/mon_bin.c:1118:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     got unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:1118:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     got unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:1120:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     expected unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     got unsigned int [noderef] __user *
   drivers/usb/mon/mon_bin.c:1120:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     got unsigned int *__ptr_clean
   drivers/usb/mon/mon_bin.c:1120:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     got unsigned int *__ptr_clean
--
>> drivers/video/fbdev/sis/sis_main.c:1717:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/sis/sis_main.c:1717:20: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1717:20: sparse:     got unsigned int [noderef] [usertype] __user *argp
>> drivers/video/fbdev/sis/sis_main.c:1717:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1717:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/sis/sis_main.c:1717:20: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     got unsigned int *__ptr_clean
>> drivers/video/fbdev/sis/sis_main.c:1736:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse:     got unsigned int *__ptr_clean
--
>> drivers/video/fbdev/via/viafbdev.c:409:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     got unsigned int [noderef] [usertype] __user *argp
>> drivers/video/fbdev/via/viafbdev.c:409:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     got unsigned int *__ptr_clean
>> drivers/video/fbdev/via/viafbdev.c:409:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     expected unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     got unsigned int *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     got unsigned int *__ptr_clean
--
>> arch/x86/entry/common.c:161:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   arch/x86/entry/common.c:161:23: sparse:     expected unsigned int *__ptr_clean
   arch/x86/entry/common.c:161:23: sparse:     got unsigned int [noderef] [usertype] __user *
>> arch/x86/entry/common.c:161:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   arch/x86/entry/common.c:161:23: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/entry/common.c:161:23: sparse:     got unsigned int *__ptr_clean
--
>> arch/x86/kernel/ptrace.c:741:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user *datap @@
   arch/x86/kernel/ptrace.c:741:23: sparse:     expected unsigned long *__ptr_clean
   arch/x86/kernel/ptrace.c:741:23: sparse:     got unsigned long [noderef] __user *datap
   arch/x86/kernel/ptrace.c:741:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   arch/x86/kernel/ptrace.c:741:23: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/ptrace.c:741:23: sparse:     got unsigned long *__ptr_clean
   arch/x86/kernel/ptrace.c:741:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   arch/x86/kernel/ptrace.c:741:23: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/ptrace.c:741:23: sparse:     got unsigned long *__ptr_clean
--
>> arch/x86/kernel/tls.c:138:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   arch/x86/kernel/tls.c:138:21: sparse:     expected unsigned int *__ptr_clean
   arch/x86/kernel/tls.c:138:21: sparse:     got unsigned int [noderef] __user *
>> arch/x86/kernel/tls.c:138:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   arch/x86/kernel/tls.c:138:21: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/tls.c:138:21: sparse:     got unsigned int *__ptr_clean
>> arch/x86/kernel/tls.c:138:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   arch/x86/kernel/tls.c:138:21: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/tls.c:138:21: sparse:     got unsigned int *__ptr_clean
   arch/x86/kernel/tls.c:220:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   arch/x86/kernel/tls.c:220:26: sparse:     expected unsigned int *__ptr_clean
   arch/x86/kernel/tls.c:220:26: sparse:     got unsigned int [noderef] __user *
   arch/x86/kernel/tls.c:220:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   arch/x86/kernel/tls.c:220:26: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/tls.c:220:26: sparse:     got unsigned int *__ptr_clean
--
>> arch/x86/kernel/traps.c:620:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user * @@
   arch/x86/kernel/traps.c:620:13: sparse:     expected char const *__ptr_clean
   arch/x86/kernel/traps.c:620:13: sparse:     got char const [noderef] __user *
   arch/x86/kernel/traps.c:620:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   arch/x86/kernel/traps.c:620:13: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/traps.c:620:13: sparse:     got char const *__ptr_clean
--
>> net/ipv4/ip_sockglue.c:1485:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1485:13: sparse:     expected int *__ptr_clean
   net/ipv4/ip_sockglue.c:1485:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1485:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1485:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1485:13: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1485:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1485:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1485:13: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1517:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1517:13: sparse:     expected int *__ptr_clean
   net/ipv4/ip_sockglue.c:1517:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1517:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1517:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1517:13: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1517:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1517:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1517:13: sparse:     got int *__ptr_clean
>> net/ipv4/ip_sockglue.c:1518:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   net/ipv4/ip_sockglue.c:1518:13: sparse:     expected unsigned int *__ptr_clean
   net/ipv4/ip_sockglue.c:1518:13: sparse:     got unsigned int [noderef] __user *
   net/ipv4/ip_sockglue.c:1518:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1518:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1518:13: sparse:     got unsigned int *__ptr_clean
   net/ipv4/ip_sockglue.c:1518:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1518:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1518:13: sparse:     got unsigned int *__ptr_clean
   net/ipv4/ip_sockglue.c:1519:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   net/ipv4/ip_sockglue.c:1519:13: sparse:     expected unsigned int *__ptr_clean
   net/ipv4/ip_sockglue.c:1519:13: sparse:     got unsigned int [noderef] __user *
   net/ipv4/ip_sockglue.c:1519:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1519:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1519:13: sparse:     got unsigned int *__ptr_clean
   net/ipv4/ip_sockglue.c:1519:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1519:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1519:13: sparse:     got unsigned int *__ptr_clean
   net/ipv4/ip_sockglue.c:1538:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1538:13: sparse:     expected int *__ptr_clean
   net/ipv4/ip_sockglue.c:1538:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1538:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1538:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1538:13: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1564:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1564:32: sparse:     expected int *__ptr_clean
   net/ipv4/ip_sockglue.c:1564:32: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1564:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1564:32: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1564:32: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1564:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1564:32: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1564:32: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1569:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1569:21: sparse:     expected int *__ptr_clean
   net/ipv4/ip_sockglue.c:1569:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1569:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1569:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1569:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1569:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1569:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1569:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1662:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1662:21: sparse:     expected int *__ptr_clean
   net/ipv4/ip_sockglue.c:1662:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1662:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1662:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1662:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1662:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1662:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1662:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1725:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1725:24: sparse:     expected int *__ptr_clean
   net/ipv4/ip_sockglue.c:1725:24: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1725:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1725:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1725:24: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1725:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1725:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1725:24: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1745:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1745:21: sparse:     expected int *__ptr_clean
   net/ipv4/ip_sockglue.c:1745:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1745:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1745:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1745:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1745:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1745:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1745:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1751:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1751:21: sparse:     expected int *__ptr_clean
   net/ipv4/ip_sockglue.c:1751:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1751:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1751:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1751:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1751:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1751:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1751:21: sparse:     got int *__ptr_clean
--
>> net/ipv4/tcp.c:637:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/ipv4/tcp.c:637:16: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:637:16: sparse:     got int [noderef] __user *
   net/ipv4/tcp.c:637:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:637:16: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:637:16: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:637:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:637:16: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:637:16: sparse:     got int *__ptr_clean
>> net/ipv4/tcp.c:3958:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3958:13: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:3958:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3958:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:3958:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3958:13: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4007:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4007:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4007:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4007:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4007:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4007:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4013:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4013:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4013:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4013:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4013:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4013:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4013:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4013:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4013:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4025:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4025:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4025:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4025:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4025:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4025:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4033:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4033:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4033:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4033:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4033:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4033:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4033:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4033:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4033:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4044:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4044:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4044:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4044:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4044:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4044:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4047:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4047:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4047:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4047:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4047:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4047:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4047:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4047:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4047:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4054:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4054:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4054:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4054:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4054:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4054:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4058:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4058:29: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4058:29: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4058:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4058:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4058:29: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4058:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4058:29: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4058:29: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4062:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4062:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4062:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4062:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4062:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4062:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4062:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4062:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4062:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4072:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4072:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4072:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4072:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4072:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4072:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4078:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4078:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4078:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4078:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4078:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4078:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4078:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4078:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4078:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4106:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4106:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4106:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4106:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4106:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4106:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4167:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:4167:21: sparse:     expected int *__ptr_clean
   net/ipv4/tcp.c:4167:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:4167:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4167:21: sparse:     expected void const volatile [noderef] __user *ptr
--
>> net/ipv4/raw.c:830:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/raw.c:830:13: sparse:     expected int *__ptr_clean
   net/ipv4/raw.c:830:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/raw.c:830:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/raw.c:830:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/raw.c:830:13: sparse:     got int *__ptr_clean
   net/ipv4/raw.c:838:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/raw.c:838:13: sparse:     expected int *__ptr_clean
   net/ipv4/raw.c:838:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/raw.c:838:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/raw.c:838:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/raw.c:838:13: sparse:     got int *__ptr_clean
   net/ipv4/raw.c:838:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/raw.c:838:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/raw.c:838:13: sparse:     got int *__ptr_clean
>> net/ipv4/raw.c:891:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/ipv4/raw.c:891:24: sparse:     expected int *__ptr_clean
   net/ipv4/raw.c:891:24: sparse:     got int [noderef] __user *
   net/ipv4/raw.c:891:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/raw.c:891:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/raw.c:891:24: sparse:     got int *__ptr_clean
   net/ipv4/raw.c:891:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/raw.c:891:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/raw.c:891:24: sparse:     got int *__ptr_clean
   net/ipv4/raw.c:902:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/ipv4/raw.c:902:24: sparse:     expected int *__ptr_clean
   net/ipv4/raw.c:902:24: sparse:     got int [noderef] __user *
   net/ipv4/raw.c:902:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/raw.c:902:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/raw.c:902:24: sparse:     got int *__ptr_clean
   net/ipv4/raw.c:902:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/raw.c:902:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/raw.c:902:24: sparse:     got int *__ptr_clean
--
>> net/ipv4/udp.c:1710:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/ipv4/udp.c:1710:24: sparse:     expected int *__ptr_clean
   net/ipv4/udp.c:1710:24: sparse:     got int [noderef] __user *
   net/ipv4/udp.c:1710:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/udp.c:1710:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/udp.c:1710:24: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:1710:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/udp.c:1710:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/udp.c:1710:24: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:1717:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/ipv4/udp.c:1717:24: sparse:     expected int *__ptr_clean
   net/ipv4/udp.c:1717:24: sparse:     got int [noderef] __user *
   net/ipv4/udp.c:1717:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/udp.c:1717:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/udp.c:1717:24: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:1717:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/udp.c:1717:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/udp.c:1717:24: sparse:     got int *__ptr_clean
>> net/ipv4/udp.c:2808:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/udp.c:2808:13: sparse:     expected int *__ptr_clean
   net/ipv4/udp.c:2808:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/udp.c:2808:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/udp.c:2808:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/udp.c:2808:13: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:2855:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/udp.c:2855:13: sparse:     expected int *__ptr_clean
   net/ipv4/udp.c:2855:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/udp.c:2855:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/udp.c:2855:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/udp.c:2855:13: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:2855:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/udp.c:2855:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/udp.c:2855:13: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:1476:28: sparse: sparse: context imbalance in 'udp_rmem_release' - unexpected unlock
   net/ipv4/udp.c:1508:19: sparse: sparse: context imbalance in 'busylock_acquire' - wrong count at exit
   net/ipv4/udp.c:1520:28: sparse: sparse: context imbalance in 'busylock_release' - unexpected unlock
   net/ipv4/udp.c:2994:9: sparse: sparse: context imbalance in 'udp_get_first' - wrong count at exit
   net/ipv4/udp.c:3016:39: sparse: sparse: context imbalance in 'udp_get_next' - unexpected unlock
   net/ipv4/udp.c:3066:31: sparse: sparse: context imbalance in 'udp_seq_stop' - unexpected unlock
--
>> net/ipv4/igmp.c:2568:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv4/igmp.c:2568:13: sparse:     expected int *__ptr_clean
   net/ipv4/igmp.c:2568:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/igmp.c:2568:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/igmp.c:2568:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/igmp.c:2568:13: sparse:     got int *__ptr_clean
   net/ipv4/igmp.c:2568:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/igmp.c:2568:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/igmp.c:2568:13: sparse:     got int *__ptr_clean
   net/ipv4/igmp.c:2919:31: sparse: sparse: context imbalance in 'igmp_mcf_get_next' - unexpected unlock
   net/ipv4/igmp.c:2947:9: sparse: sparse: context imbalance in 'igmp_mcf_get_idx' - wrong count at exit
   net/ipv4/igmp.c:2964:9: sparse: sparse: context imbalance in 'igmp_mcf_seq_next' - wrong count at exit
   net/ipv4/igmp.c:2976:9: sparse: sparse: context imbalance in 'igmp_mcf_seq_stop' - unexpected unlock
--
>> arch/x86/kernel/fpu/xstate.c:1703:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user *uptr @@
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse:     expected unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse:     got unsigned long long [noderef] [usertype] __user *uptr
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse:     got unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse:     got unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user *uptr @@
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse:     expected unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse:     got unsigned long long [noderef] [usertype] __user *uptr
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse:     got unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse:     got unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user *uptr @@
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse:     expected unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse:     got unsigned long long [noderef] [usertype] __user *uptr
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse:     got unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse:     got unsigned long long *__ptr_clean
--
   kernel/fork.c:1094:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *owner @@     got struct task_struct *p @@
   kernel/fork.c:1094:19: sparse:     expected struct task_struct [noderef] __rcu *owner
   kernel/fork.c:1094:19: sparse:     got struct task_struct *p
   kernel/fork.c:1304:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *__ret @@     got struct file *new_exe_file @@
   kernel/fork.c:1304:24: sparse:     expected struct file [noderef] __rcu *__ret
   kernel/fork.c:1304:24: sparse:     got struct file *new_exe_file
   kernel/fork.c:1304:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   kernel/fork.c:1304:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1304:22: sparse:     got struct file [noderef] __rcu *[assigned] __ret
>> kernel/fork.c:1469:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *clear_child_tid @@
   kernel/fork.c:1469:25: sparse:     expected int *__ptr_clean
   kernel/fork.c:1469:25: sparse:     got int [noderef] __user *clear_child_tid
   kernel/fork.c:1469:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/fork.c:1469:25: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/fork.c:1469:25: sparse:     got int *__ptr_clean
   kernel/fork.c:1469:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/fork.c:1469:25: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/fork.c:1469:25: sparse:     got int *__ptr_clean
   kernel/fork.c:1635:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1635:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1635:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1644:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1644:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1644:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1645:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1645:9: sparse:     expected void const *
   kernel/fork.c:1645:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1645:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1645:9: sparse:     expected void const *
   kernel/fork.c:1645:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1645:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1645:9: sparse:     expected void const *
   kernel/fork.c:1645:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1646:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1646:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1646:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2058:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2058:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2058:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2062:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2062:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2062:33: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/fork.c:2279:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *pidfd @@
   kernel/fork.c:2279:26: sparse:     expected int *__ptr_clean
   kernel/fork.c:2279:26: sparse:     got int [noderef] __user *pidfd
   kernel/fork.c:2279:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/fork.c:2279:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/fork.c:2279:26: sparse:     got int *__ptr_clean
   kernel/fork.c:2279:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/fork.c:2279:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/fork.c:2279:26: sparse:     got int *__ptr_clean
   kernel/fork.c:2379:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
   kernel/fork.c:2379:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2379:32: sparse:     got struct task_struct *
   kernel/fork.c:2388:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2388:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2388:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2433:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2433:54: sparse:     expected struct list_head *head
   kernel/fork.c:2433:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2454:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2454:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2454:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2475:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2475:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2475:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2502:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2502:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2502:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2531:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2531:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2531:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2533:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2533:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2533:33: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/fork.c:2655:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *parent_tid @@
   kernel/fork.c:2655:17: sparse:     expected int *__ptr_clean
   kernel/fork.c:2655:17: sparse:     got int [noderef] __user *parent_tid
   kernel/fork.c:2655:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/fork.c:2655:17: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/fork.c:2655:17: sparse:     got int *__ptr_clean
   kernel/fork.c:2655:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/fork.c:2655:17: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/fork.c:2655:17: sparse:     got int *__ptr_clean
   kernel/fork.c:2942:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2942:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2942:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3023:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3023:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3023:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:2100:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:217:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:217:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:217:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:217:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:217:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:217:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2431:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2432:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1086:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/fork.c:1086:23: sparse:    struct task_struct [noderef] __rcu *
   kernel/fork.c:1086:23: sparse:    struct task_struct *
--
   kernel/exit.c:281:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:281:37: sparse:     expected struct task_struct *tsk
   kernel/exit.c:281:37: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:284:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:284:32: sparse:     expected struct task_struct *task
   kernel/exit.c:284:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:285:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:285:35: sparse:     expected struct task_struct *task
   kernel/exit.c:285:35: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:330:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:330:24: sparse:     expected struct task_struct *parent
   kernel/exit.c:330:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:357:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:357:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:357:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:360:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:360:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:360:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:399:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/exit.c:399:23: sparse:    struct task_struct [noderef] __rcu *
   kernel/exit.c:399:23: sparse:    struct task_struct *
   kernel/exit.c:423:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/exit.c:423:9: sparse:    struct list_head *
   kernel/exit.c:423:9: sparse:    struct list_head [noderef] __rcu *
   kernel/exit.c:583:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:585:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:909:63: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *const sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/exit.c:1064:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1089:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1178:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1193:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1244:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1247:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1253:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1434:59: sparse: sparse: incompatible types in comparison expression (different base types):
   kernel/exit.c:1434:59: sparse:    void *
   kernel/exit.c:1434:59: sparse:    struct task_struct [noderef] __rcu *
   kernel/exit.c:1450:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu * @@
   kernel/exit.c:1450:25: sparse:     expected struct task_struct *parent
   kernel/exit.c:1450:25: sparse:     got struct task_struct [noderef] __rcu *
>> kernel/exit.c:1683:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *stat_addr @@
   kernel/exit.c:1683:37: sparse:     expected int *__ptr_clean
   kernel/exit.c:1683:37: sparse:     got int [noderef] __user *stat_addr
   kernel/exit.c:1683:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/exit.c:1683:37: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/exit.c:1683:37: sparse:     got int *__ptr_clean
   kernel/exit.c:1683:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/exit.c:1683:37: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/exit.c:1683:37: sparse:     got int *__ptr_clean
   kernel/exit.c:423:9: sparse: sparse: dereference of noderef expression
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/exit.c: note: in included file (through include/linux/sched/signal.h, include/linux/rcuwait.h, include/linux/percpu-rwsem.h, ...):
   include/linux/sched/task.h:106:21: sparse: sparse: context imbalance in 'wait_task_zombie' - unexpected unlock
   include/linux/sched/task.h:106:21: sparse: sparse: context imbalance in 'wait_task_stopped' - unexpected unlock
   include/linux/sched/task.h:106:21: sparse: sparse: context imbalance in 'wait_task_continued' - unexpected unlock
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/exit.c:1542:9: sparse: sparse: context imbalance in 'do_wait' - wrong count at exit
--
>> kernel/capability.c:86:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   kernel/capability.c:86:13: sparse:     expected unsigned int *__ptr_clean
   kernel/capability.c:86:13: sparse:     got unsigned int [noderef] __user *
   kernel/capability.c:86:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/capability.c:86:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/capability.c:86:13: sparse:     got unsigned int *__ptr_clean
   kernel/capability.c:101:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   kernel/capability.c:101:21: sparse:     expected unsigned int *__ptr_clean
   kernel/capability.c:101:21: sparse:     got unsigned int [noderef] __user *
   kernel/capability.c:101:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/capability.c:101:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/capability.c:101:21: sparse:     got unsigned int *__ptr_clean
   kernel/capability.c:101:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/capability.c:101:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/capability.c:101:21: sparse:     got unsigned int *__ptr_clean
>> kernel/capability.c:159:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   kernel/capability.c:159:13: sparse:     expected int *__ptr_clean
   kernel/capability.c:159:13: sparse:     got int [noderef] __user *
   kernel/capability.c:159:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/capability.c:159:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/capability.c:159:13: sparse:     got int *__ptr_clean
   kernel/capability.c:195:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct __user_cap_data_struct [noderef] __user * @@
   kernel/capability.c:195:43: sparse:     expected void const *from
   kernel/capability.c:195:43: sparse:     got struct __user_cap_data_struct [noderef] __user *
   kernel/capability.c:171:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:172:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:173:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:235:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   kernel/capability.c:235:13: sparse:     expected int *__ptr_clean
   kernel/capability.c:235:13: sparse:     got int [noderef] __user *
   kernel/capability.c:235:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/capability.c:235:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/capability.c:235:13: sparse:     got int *__ptr_clean
   kernel/capability.c:246:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct __user_cap_data_struct [noderef] __user ( * )[2] @@
   kernel/capability.c:246:29: sparse:     expected void *to
   kernel/capability.c:246:29: sparse:     got struct __user_cap_data_struct [noderef] __user ( * )[2]
   kernel/capability.c:250:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:251:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:252:43: sparse: sparse: dereference of noderef expression
--
   kernel/ptrace.c:54:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:54:22: sparse:    struct task_struct *
   kernel/ptrace.c:54:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:73:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *parent @@     got struct task_struct *new_parent @@
   kernel/ptrace.c:73:23: sparse:     expected struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:73:23: sparse:     got struct task_struct *new_parent
   kernel/ptrace.c:74:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] __rcu *ptracer_cred @@     got struct cred const * @@
   kernel/ptrace.c:74:29: sparse:     expected struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:74:29: sparse:     got struct cred const *
   kernel/ptrace.c:128:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   kernel/ptrace.c:128:18: sparse:     expected struct cred const *old_cred
   kernel/ptrace.c:128:18: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:132:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:132:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:132:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:170:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:170:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:170:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:197:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:197:28: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:197:28: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:203:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:203:30: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:203:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:213:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:213:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:213:9: sparse:    struct task_struct *
   kernel/ptrace.c:258:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:258:44: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:258:44: sparse:    struct task_struct *
   kernel/ptrace.c:458:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:458:24: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:458:24: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:481:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:481:26: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:481:26: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:517:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/ptrace.c:517:54: sparse:     expected struct task_struct *parent
   kernel/ptrace.c:517:54: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:525:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:525:53: sparse:     expected struct task_struct *new_parent
   kernel/ptrace.c:525:53: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:573:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:573:41: sparse:     expected struct task_struct *p1
   kernel/ptrace.c:573:41: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:575:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sigh @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/ptrace.c:575:50: sparse:     expected struct sighand_struct *sigh
   kernel/ptrace.c:575:50: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/ptrace.c:766:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:766:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:766:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:774:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:774:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:774:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:897:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:897:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:897:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:901:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:901:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:901:39: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/ptrace.c:1071:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user *datalp @@
   kernel/ptrace.c:1071:23: sparse:     expected unsigned long *__ptr_clean
   kernel/ptrace.c:1071:23: sparse:     got unsigned long [noderef] __user *datalp
   kernel/ptrace.c:1071:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   kernel/ptrace.c:1071:23: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/ptrace.c:1071:23: sparse:     got unsigned long *__ptr_clean
   kernel/ptrace.c:1071:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   kernel/ptrace.c:1071:23: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/ptrace.c:1071:23: sparse:     got unsigned long *__ptr_clean
   kernel/ptrace.c:1131:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1131:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1131:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1133:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1133:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1133:39: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/ptrace.c:1346:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   kernel/ptrace.c:1346:16: sparse:     expected unsigned long *__ptr_clean
   kernel/ptrace.c:1346:16: sparse:     got unsigned long [noderef] __user *
   kernel/ptrace.c:1346:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   kernel/ptrace.c:1346:16: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/ptrace.c:1346:16: sparse:     got unsigned long *__ptr_clean
   kernel/ptrace.c:1346:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   kernel/ptrace.c:1346:16: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/ptrace.c:1346:16: sparse:     got unsigned long *__ptr_clean
   kernel/ptrace.c:523:38: sparse: sparse: dereference of noderef expression
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:713:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:729:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   kernel/ptrace.c:903:9: sparse: sparse: context imbalance in 'ptrace_resume' - different lock contexts for basic block
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1285:9: sparse: sparse: context imbalance in 'ptrace_request' - different lock contexts for basic block
--
>> kernel/sys.c:1971:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   kernel/sys.c:1971:24: sparse:     expected unsigned int *__ptr_clean
   kernel/sys.c:1971:24: sparse:     got unsigned int [noderef] __user *
   kernel/sys.c:1971:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:1971:24: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:1971:24: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:1971:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:1971:24: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:1971:24: sparse:     got unsigned int *__ptr_clean
>> kernel/sys.c:2238:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user **__ptr_clean @@     got int [noderef] __user *[noderef] __user *tid_addr @@
   kernel/sys.c:2238:16: sparse:     expected int [noderef] __user **__ptr_clean
   kernel/sys.c:2238:16: sparse:     got int [noderef] __user *[noderef] __user *tid_addr
   kernel/sys.c:2238:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int [noderef] __user **__ptr_clean @@
   kernel/sys.c:2238:16: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:2238:16: sparse:     got int [noderef] __user **__ptr_clean
   kernel/sys.c:2238:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int [noderef] __user **__ptr_clean @@
   kernel/sys.c:2238:16: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:2238:16: sparse:     got int [noderef] __user **__ptr_clean
>> kernel/sys.c:738:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *ruidp @@
   kernel/sys.c:738:18: sparse:     expected unsigned int *__ptr_clean
   kernel/sys.c:738:18: sparse:     got unsigned int [noderef] [usertype] __user *ruidp
   kernel/sys.c:738:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:738:18: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:738:18: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:738:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:738:18: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:738:18: sparse:     got unsigned int *__ptr_clean
>> kernel/sys.c:740:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *euidp @@
   kernel/sys.c:740:26: sparse:     expected unsigned int *__ptr_clean
   kernel/sys.c:740:26: sparse:     got unsigned int [noderef] [usertype] __user *euidp
   kernel/sys.c:740:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:740:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:740:26: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:740:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:740:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:740:26: sparse:     got unsigned int *__ptr_clean
>> kernel/sys.c:742:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *suidp @@
   kernel/sys.c:742:32: sparse:     expected unsigned int *__ptr_clean
   kernel/sys.c:742:32: sparse:     got unsigned int [noderef] [usertype] __user *suidp
   kernel/sys.c:742:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:742:32: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:742:32: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:742:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:742:32: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:742:32: sparse:     got unsigned int *__ptr_clean
>> kernel/sys.c:821:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *rgidp @@
   kernel/sys.c:821:18: sparse:     expected unsigned int *__ptr_clean
   kernel/sys.c:821:18: sparse:     got unsigned int [noderef] [usertype] __user *rgidp
   kernel/sys.c:821:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:821:18: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:821:18: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:821:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:821:18: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:821:18: sparse:     got unsigned int *__ptr_clean
>> kernel/sys.c:823:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *egidp @@
   kernel/sys.c:823:26: sparse:     expected unsigned int *__ptr_clean
   kernel/sys.c:823:26: sparse:     got unsigned int [noderef] [usertype] __user *egidp
   kernel/sys.c:823:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:823:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:823:26: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:823:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:823:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:823:26: sparse:     got unsigned int *__ptr_clean
>> kernel/sys.c:825:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *sgidp @@
   kernel/sys.c:825:34: sparse:     expected unsigned int *__ptr_clean
   kernel/sys.c:825:34: sparse:     got unsigned int [noderef] [usertype] __user *sgidp
   kernel/sys.c:825:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:825:34: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:825:34: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:825:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:825:34: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:825:34: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:1077:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/sys.c:1077:32: sparse:     expected struct task_struct *p1
   kernel/sys.c:1077:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/sys.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/sys.c:2363:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   kernel/sys.c:2363:25: sparse:     expected int *__ptr_clean
   kernel/sys.c:2363:25: sparse:     got int [noderef] __user *
   kernel/sys.c:2363:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/sys.c:2363:25: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:2363:25: sparse:     got int *__ptr_clean
   kernel/sys.c:2363:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/sys.c:2363:25: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:2363:25: sparse:     got int *__ptr_clean
   kernel/sys.c:2499:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   kernel/sys.c:2499:25: sparse:     expected int *__ptr_clean
   kernel/sys.c:2499:25: sparse:     got int [noderef] __user *
   kernel/sys.c:2499:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/sys.c:2499:25: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:2499:25: sparse:     got int *__ptr_clean
   kernel/sys.c:2499:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/sys.c:2499:25: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:2499:25: sparse:     got int *__ptr_clean
>> kernel/sys.c:2628:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *cpup @@
   kernel/sys.c:2628:24: sparse:     expected unsigned int *__ptr_clean
   kernel/sys.c:2628:24: sparse:     got unsigned int [noderef] __user *cpup
   kernel/sys.c:2628:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:2628:24: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:2628:24: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:2628:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:2628:24: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:2628:24: sparse:     got unsigned int *__ptr_clean
>> kernel/sys.c:2630:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *nodep @@
   kernel/sys.c:2630:24: sparse:     expected unsigned int *__ptr_clean
   kernel/sys.c:2630:24: sparse:     got unsigned int [noderef] __user *nodep
   kernel/sys.c:2630:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:2630:24: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:2630:24: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:2630:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:2630:24: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:2630:24: sparse:     got unsigned int *__ptr_clean
--
   kernel/signal.c: note: in included file (through arch/x86/include/uapi/asm/signal.h, arch/x86/include/asm/signal.h, include/uapi/linux/signal.h, ...):
   include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
   kernel/signal.c:195:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:195:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:195:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:198:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:198:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:198:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:480:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:480:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:480:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:484:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:484:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:484:34: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:517:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:517:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:517:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:520:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:520:36: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:520:36: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:542:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct k_sigaction *ka @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:542:53: sparse:     expected struct k_sigaction *ka
   kernel/signal.c:542:53: sparse:     got struct k_sigaction [noderef] __rcu *
   include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
   kernel/signal.c:698:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:698:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:698:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:700:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:700:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:700:31: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/signal.c:1263:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   kernel/signal.c:1263:29: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/signal.c:1263:29: sparse:     got unsigned char *__ptr_clean
   kernel/signal.c:1330:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1330:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1330:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1331:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *action @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:1331:16: sparse:     expected struct k_sigaction *action
   kernel/signal.c:1331:16: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:1351:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1351:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1351:34: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1929:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1929:36: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1929:36: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2039:44: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2058:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2058:65: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2058:65: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2059:40: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2077:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *psig @@     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand @@
   kernel/signal.c:2077:14: sparse:     expected struct sighand_struct *psig
   kernel/signal.c:2077:14: sparse:     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand
   kernel/signal.c:2106:46: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *t @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2106:46: sparse:     expected struct task_struct *t
   kernel/signal.c:2106:46: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2107:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2107:34: sparse:     expected struct task_struct *parent
   kernel/signal.c:2107:34: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2136:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2136:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2136:24: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2139:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/signal.c:2139:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2139:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/signal.c:2172:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2172:17: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2172:17: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2213:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2213:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2213:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2215:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2215:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2215:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2266:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2266:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2266:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2322:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2322:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2322:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2363:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2363:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2363:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2365:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2365:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2365:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2464:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2464:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2464:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2548:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2548:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2548:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2560:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2560:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2560:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2595:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2595:52: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2595:52: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2597:49: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2635:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2635:49: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2635:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2964:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2964:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2964:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2984:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2984:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2984:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3051:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3051:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3051:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3053:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3053:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3053:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3204:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3204:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3204:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3207:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3207:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3207:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3594:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3594:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3594:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3606:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3606:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3606:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3611:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3611:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3611:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3616:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3616:29: sparse:     expected struct spinlock [usertype] *lock
--
>> kernel/groups.c:47:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   kernel/groups.c:47:21: sparse:     expected unsigned int *__ptr_clean
   kernel/groups.c:47:21: sparse:     got unsigned int [noderef] [usertype] __user *
   kernel/groups.c:47:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/groups.c:47:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/groups.c:47:21: sparse:     got unsigned int *__ptr_clean
   kernel/groups.c:47:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/groups.c:47:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/groups.c:47:21: sparse:     got unsigned int *__ptr_clean
   kernel/groups.c:64:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   kernel/groups.c:64:21: sparse:     expected unsigned int *__ptr_clean
   kernel/groups.c:64:21: sparse:     got unsigned int [noderef] [usertype] __user *
   kernel/groups.c:64:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/groups.c:64:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/groups.c:64:21: sparse:     got unsigned int *__ptr_clean
--
>> kernel/profile.c:409:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *buf @@
   kernel/profile.c:409:21: sparse:     expected char *__ptr_clean
   kernel/profile.c:409:21: sparse:     got char [noderef] __user *buf
>> kernel/profile.c:409:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   kernel/profile.c:409:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/profile.c:409:21: sparse:     got char *__ptr_clean
>> kernel/profile.c:409:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   kernel/profile.c:409:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/profile.c:409:21: sparse:     got char *__ptr_clean
--
>> kernel/uid16.c:125:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user * @@
   kernel/uid16.c:125:21: sparse:     expected unsigned short *__ptr_clean
   kernel/uid16.c:125:21: sparse:     got unsigned short [noderef] [usertype] __user *
>> kernel/uid16.c:125:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:125:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/uid16.c:125:21: sparse:     got unsigned short *__ptr_clean
>> kernel/uid16.c:125:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:125:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/uid16.c:125:21: sparse:     got unsigned short *__ptr_clean
   kernel/uid16.c:141:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user * @@
   kernel/uid16.c:141:21: sparse:     expected unsigned short *__ptr_clean
   kernel/uid16.c:141:21: sparse:     got unsigned short [noderef] [usertype] __user *
   kernel/uid16.c:141:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:141:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/uid16.c:141:21: sparse:     got unsigned short *__ptr_clean
>> kernel/uid16.c:74:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user *ruidp @@
   kernel/uid16.c:74:26: sparse:     expected unsigned short *__ptr_clean
   kernel/uid16.c:74:26: sparse:     got unsigned short [noderef] [usertype] __user *ruidp
   kernel/uid16.c:74:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:74:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/uid16.c:74:26: sparse:     got unsigned short *__ptr_clean
   kernel/uid16.c:74:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:74:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/uid16.c:74:26: sparse:     got unsigned short *__ptr_clean
>> kernel/uid16.c:75:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user *euidp @@
   kernel/uid16.c:75:26: sparse:     expected unsigned short *__ptr_clean
   kernel/uid16.c:75:26: sparse:     got unsigned short [noderef] [usertype] __user *euidp
   kernel/uid16.c:75:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:75:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/uid16.c:75:26: sparse:     got unsigned short *__ptr_clean
   kernel/uid16.c:75:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:75:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/uid16.c:75:26: sparse:     got unsigned short *__ptr_clean
>> kernel/uid16.c:76:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user *suidp @@
   kernel/uid16.c:76:26: sparse:     expected unsigned short *__ptr_clean
   kernel/uid16.c:76:26: sparse:     got unsigned short [noderef] [usertype] __user *suidp
   kernel/uid16.c:76:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:76:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/uid16.c:76:26: sparse:     got unsigned short *__ptr_clean
   kernel/uid16.c:76:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:76:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/uid16.c:76:26: sparse:     got unsigned short *__ptr_clean
>> kernel/uid16.c:97:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user *rgidp @@
   kernel/uid16.c:97:26: sparse:     expected unsigned short *__ptr_clean
   kernel/uid16.c:97:26: sparse:     got unsigned short [noderef] [usertype] __user *rgidp
   kernel/uid16.c:97:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:97:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/uid16.c:97:26: sparse:     got unsigned short *__ptr_clean
   kernel/uid16.c:97:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:97:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/uid16.c:97:26: sparse:     got unsigned short *__ptr_clean
>> kernel/uid16.c:98:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user *egidp @@
   kernel/uid16.c:98:26: sparse:     expected unsigned short *__ptr_clean
   kernel/uid16.c:98:26: sparse:     got unsigned short [noderef] [usertype] __user *egidp
   kernel/uid16.c:98:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:98:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/uid16.c:98:26: sparse:     got unsigned short *__ptr_clean
   kernel/uid16.c:98:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:98:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/uid16.c:98:26: sparse:     got unsigned short *__ptr_clean
>> kernel/uid16.c:99:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user *sgidp @@
   kernel/uid16.c:99:26: sparse:     expected unsigned short *__ptr_clean
   kernel/uid16.c:99:26: sparse:     got unsigned short [noderef] [usertype] __user *sgidp
   kernel/uid16.c:99:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:99:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/uid16.c:99:26: sparse:     got unsigned short *__ptr_clean
   kernel/uid16.c:99:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   kernel/uid16.c:99:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/uid16.c:99:26: sparse:     got unsigned short *__ptr_clean
--
   kernel/sched/core.c:790:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:790:48: sparse:     expected struct task_struct *p
   kernel/sched/core.c:790:48: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1043:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1043:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1043:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2200:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2200:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:2200:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2200:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2200:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2200:68: sparse:     got struct task_struct [noderef] __rcu *curr
>> kernel/sched/core.c:5013:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *set_child_tid @@
   kernel/sched/core.c:5013:17: sparse:     expected int *__ptr_clean
   kernel/sched/core.c:5013:17: sparse:     got int [noderef] __user *set_child_tid
   kernel/sched/core.c:5013:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/sched/core.c:5013:17: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sched/core.c:5013:17: sparse:     got int *__ptr_clean
   kernel/sched/core.c:5013:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/sched/core.c:5013:17: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sched/core.c:5013:17: sparse:     got int *__ptr_clean
   kernel/sched/core.c:5331:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5331:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5331:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6271:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6271:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6271:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6796:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6796:17: sparse:    struct task_struct *
   kernel/sched/core.c:6796:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7000:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7000:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7000:22: sparse:    struct task_struct *
>> kernel/sched/core.c:7633:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   kernel/sched/core.c:7633:15: sparse:     expected unsigned int *__ptr_clean
   kernel/sched/core.c:7633:15: sparse:     got unsigned int [noderef] __user *
   kernel/sched/core.c:7633:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sched/core.c:7633:15: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sched/core.c:7633:15: sparse:     got unsigned int *__ptr_clean
   kernel/sched/core.c:7663:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   kernel/sched/core.c:7663:9: sparse:     expected unsigned int *__ptr_clean
   kernel/sched/core.c:7663:9: sparse:     got unsigned int [noderef] __user *
   kernel/sched/core.c:7663:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sched/core.c:7663:9: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sched/core.c:7663:9: sparse:     got unsigned int *__ptr_clean
   kernel/sched/core.c:7663:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sched/core.c:7663:9: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sched/core.c:7663:9: sparse:     got unsigned int *__ptr_clean
   kernel/sched/core.c:11028:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11028:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11028:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:547:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/core.c:580:23: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:596:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c:634:36: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/core.c:675:36: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c:790:11: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2191:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2192:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2193:37: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:3721:25: sparse: sparse: context imbalance in 'ttwu_runnable' - wrong count at exit
   kernel/sched/core.c:4265:9: sparse: sparse: context imbalance in 'task_call_func' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   include/trace/events/sched.h:185:1: sparse: sparse: context imbalance in 'wake_up_new_task' - wrong count at exit
   kernel/sched/core.c:4990:9: sparse: sparse: context imbalance in 'finish_task_switch' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2017:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2017:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2017:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2017:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2017:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2017:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
--
>> fs/fcntl.c:258:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/fcntl.c:258:16: sparse:     expected unsigned int *__ptr_clean
   fs/fcntl.c:258:16: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/fcntl.c:258:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/fcntl.c:258:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fcntl.c:258:16: sparse:     got unsigned int *__ptr_clean
   fs/fcntl.c:258:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/fcntl.c:258:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fcntl.c:258:16: sparse:     got unsigned int *__ptr_clean
   fs/fcntl.c:259:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/fcntl.c:259:16: sparse:     expected unsigned int *__ptr_clean
   fs/fcntl.c:259:16: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/fcntl.c:259:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/fcntl.c:259:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fcntl.c:259:16: sparse:     got unsigned int *__ptr_clean
   fs/fcntl.c:259:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/fcntl.c:259:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fcntl.c:259:16: sparse:     got unsigned int *__ptr_clean
   fs/fcntl.c:931:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:931:9: sparse:    struct fasync_struct [noderef] __rcu *
   fs/fcntl.c:931:9: sparse:    struct fasync_struct *
   fs/fcntl.c:1006:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:1006:22: sparse:    struct fasync_struct [noderef] __rcu *
   fs/fcntl.c:1006:22: sparse:    struct fasync_struct *
   fs/fcntl.c:1017:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:1017:33: sparse:    struct fasync_struct [noderef] __rcu *
   fs/fcntl.c:1017:33: sparse:    struct fasync_struct *
--
>> fs/ioctl.c:69:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   fs/ioctl.c:69:17: sparse:     expected int *__ptr_clean
   fs/ioctl.c:69:17: sparse:     got int [noderef] __user *p
   fs/ioctl.c:69:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:69:17: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:69:17: sparse:     got int *__ptr_clean
   fs/ioctl.c:91:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   fs/ioctl.c:91:13: sparse:     expected int *__ptr_clean
   fs/ioctl.c:91:13: sparse:     got int [noderef] __user *p
   fs/ioctl.c:91:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:91:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:91:13: sparse:     got int *__ptr_clean
   fs/ioctl.c:91:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/ioctl.c:91:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ioctl.c:91:13: sparse:     got int *__ptr_clean
>> fs/ioctl.c:346:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *argp @@
   fs/ioctl.c:346:17: sparse:     expected int *__ptr_clean
   fs/ioctl.c:346:17: sparse:     got int [noderef] __user *argp
   fs/ioctl.c:346:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:346:17: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:346:17: sparse:     got int *__ptr_clean
   fs/ioctl.c:370:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *argp @@
   fs/ioctl.c:370:17: sparse:     expected int *__ptr_clean
   fs/ioctl.c:370:17: sparse:     got int [noderef] __user *argp
   fs/ioctl.c:370:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:370:17: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:370:17: sparse:     got int *__ptr_clean
>> fs/ioctl.c:424:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   fs/ioctl.c:424:13: sparse:     expected unsigned short *__ptr_clean
   fs/ioctl.c:424:13: sparse:     got unsigned short [noderef] __user *
   fs/ioctl.c:424:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/ioctl.c:424:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:424:13: sparse:     got unsigned short *__ptr_clean
>> fs/ioctl.c:711:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *argp @@
   fs/ioctl.c:711:23: sparse:     expected unsigned int *__ptr_clean
   fs/ioctl.c:711:23: sparse:     got unsigned int [noderef] __user *argp
   fs/ioctl.c:711:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/ioctl.c:711:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:711:23: sparse:     got unsigned int *__ptr_clean
   fs/ioctl.c:711:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/ioctl.c:711:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ioctl.c:711:23: sparse:     got unsigned int *__ptr_clean
   fs/ioctl.c:723:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *argp @@
   fs/ioctl.c:723:15: sparse:     expected unsigned int *__ptr_clean
   fs/ioctl.c:723:15: sparse:     got unsigned int [noderef] __user *argp
   fs/ioctl.c:723:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/ioctl.c:723:15: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:723:15: sparse:     got unsigned int *__ptr_clean
>> fs/ioctl.c:817:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/ioctl.c:817:24: sparse:     expected int *__ptr_clean
   fs/ioctl.c:817:24: sparse:     got int [noderef] __user *
   fs/ioctl.c:817:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:817:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:817:24: sparse:     got int *__ptr_clean
   fs/ioctl.c:817:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/ioctl.c:817:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ioctl.c:817:24: sparse:     got int *__ptr_clean
   fs/ioctl.c:832:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/ioctl.c:832:24: sparse:     expected int *__ptr_clean
   fs/ioctl.c:832:24: sparse:     got int [noderef] __user *
   fs/ioctl.c:832:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:832:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:832:24: sparse:     got int *__ptr_clean
   fs/ioctl.c:832:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/ioctl.c:832:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ioctl.c:832:24: sparse:     got int *__ptr_clean
--
>> fs/readdir.c:293:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   fs/readdir.c:293:21: sparse:     expected unsigned long *__ptr_clean
   fs/readdir.c:293:21: sparse:     got unsigned long [noderef] __user *
   fs/readdir.c:293:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   fs/readdir.c:293:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/readdir.c:293:21: sparse:     got unsigned long *__ptr_clean
   fs/readdir.c:293:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   fs/readdir.c:293:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/readdir.c:293:21: sparse:     got unsigned long *__ptr_clean
>> fs/readdir.c:377:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long *__ptr_clean @@     got signed long long [noderef] __user * @@
   fs/readdir.c:377:21: sparse:     expected signed long long *__ptr_clean
   fs/readdir.c:377:21: sparse:     got signed long long [noderef] __user *
   fs/readdir.c:377:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long long *__ptr_clean @@
   fs/readdir.c:377:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/readdir.c:377:21: sparse:     got signed long long *__ptr_clean
   fs/readdir.c:377:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long long *__ptr_clean @@
   fs/readdir.c:377:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/readdir.c:377:21: sparse:     got signed long long *__ptr_clean
--
   fs/file.c:379:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **old_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:379:17: sparse:     expected struct file **old_fds
   fs/file.c:379:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:380:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **new_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:380:17: sparse:     expected struct file **new_fds
   fs/file.c:380:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:395:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/file.c:395:17: sparse:    struct file [noderef] __rcu *
   fs/file.c:395:17: sparse:    struct file *
   fs/file.c:430:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   fs/file.c:470:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fdtable [noderef] __rcu *fdt @@     got struct fdtable * @@
   fs/file.c:649:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] file @@     got struct file [noderef] __rcu * @@
   fs/file.c:807:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:858:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:1127:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *tofree @@     got struct file [noderef] __rcu * @@
>> fs/file.c:1200:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *ufd @@
   fs/file.c:1200:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/file.c:1200:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
--
>> fs/namespace.c:3261:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user * @@
   fs/namespace.c:3261:21: sparse:     expected char const *__ptr_clean
   fs/namespace.c:3261:21: sparse:     got char const [noderef] __user *
   fs/namespace.c:3261:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   fs/namespace.c:3261:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/namespace.c:3261:21: sparse:     got char const *__ptr_clean
--
>> fs/utimes.c:273:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/utimes.c:273:21: sparse:     expected signed int *__ptr_clean
   fs/utimes.c:273:21: sparse:     got signed int [noderef] __user *
   fs/utimes.c:273:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:273:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:273:21: sparse:     got signed int *__ptr_clean
   fs/utimes.c:274:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/utimes.c:274:21: sparse:     expected signed int *__ptr_clean
   fs/utimes.c:274:21: sparse:     got signed int [noderef] __user *
   fs/utimes.c:274:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:274:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:274:21: sparse:     got signed int *__ptr_clean
   fs/utimes.c:275:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/utimes.c:275:21: sparse:     expected signed int *__ptr_clean
   fs/utimes.c:275:21: sparse:     got signed int [noderef] __user *
   fs/utimes.c:275:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:275:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:275:21: sparse:     got signed int *__ptr_clean
   fs/utimes.c:276:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/utimes.c:276:21: sparse:     expected signed int *__ptr_clean
   fs/utimes.c:276:21: sparse:     got signed int [noderef] __user *
   fs/utimes.c:276:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:276:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:276:21: sparse:     got signed int *__ptr_clean
   fs/utimes.c:241:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/utimes.c:241:21: sparse:     expected signed int *__ptr_clean
   fs/utimes.c:241:21: sparse:     got signed int [noderef] __user *
   fs/utimes.c:241:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:241:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:241:21: sparse:     got signed int *__ptr_clean
   fs/utimes.c:242:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/utimes.c:242:21: sparse:     expected signed int *__ptr_clean
   fs/utimes.c:242:21: sparse:     got signed int [noderef] __user *
   fs/utimes.c:242:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:242:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:242:21: sparse:     got signed int *__ptr_clean
--
>> fs/nsfs.c:211:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *[assigned] argp @@
   fs/nsfs.c:211:24: sparse:     expected unsigned int *__ptr_clean
   fs/nsfs.c:211:24: sparse:     got unsigned int [noderef] [usertype] __user *[assigned] argp
   fs/nsfs.c:211:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/nsfs.c:211:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/nsfs.c:211:24: sparse:     got unsigned int *__ptr_clean
   fs/nsfs.c:211:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/nsfs.c:211:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/nsfs.c:211:24: sparse:     got unsigned int *__ptr_clean
--
>> fs/timerfd.c:316:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user * @@
   fs/timerfd.c:316:23: sparse:     expected unsigned long long *__ptr_clean
   fs/timerfd.c:316:23: sparse:     got unsigned long long [noderef] [usertype] __user *
   fs/timerfd.c:316:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/timerfd.c:316:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/timerfd.c:316:23: sparse:     got unsigned long long *__ptr_clean
   fs/timerfd.c:316:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/timerfd.c:316:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/timerfd.c:316:23: sparse:     got unsigned long long *__ptr_clean
--
   fs/aio.c:616:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got struct kioctx_cpu *cpu @@
   fs/aio.c:616:24: sparse:     expected void [noderef] __percpu *__pdata
   fs/aio.c:616:24: sparse:     got struct kioctx_cpu *cpu
   fs/aio.c:782:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct kioctx_cpu *cpu @@     got struct kioctx_cpu [noderef] __percpu * @@
   fs/aio.c:782:18: sparse:     expected struct kioctx_cpu *cpu
   fs/aio.c:782:18: sparse:     got struct kioctx_cpu [noderef] __percpu *
   fs/aio.c:829:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got struct kioctx_cpu *cpu @@
   fs/aio.c:829:24: sparse:     expected void [noderef] __percpu *__pdata
   fs/aio.c:829:24: sparse:     got struct kioctx_cpu *cpu
   fs/aio.c:934:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct kioctx_cpu * @@
   fs/aio.c:934:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   fs/aio.c:934:16: sparse:     got struct kioctx_cpu *
   fs/aio.c:952:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct kioctx_cpu * @@
   fs/aio.c:952:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   fs/aio.c:952:16: sparse:     got struct kioctx_cpu *
>> fs/aio.c:1081:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   fs/aio.c:1081:13: sparse:     expected unsigned int *__ptr_clean
   fs/aio.c:1081:13: sparse:     got unsigned int [noderef] __user *
>> fs/aio.c:1081:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/aio.c:1081:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/aio.c:1081:13: sparse:     got unsigned int *__ptr_clean
   fs/aio.c:1961:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   fs/aio.c:1961:13: sparse:     expected unsigned int *__ptr_clean
   fs/aio.c:1961:13: sparse:     got unsigned int [noderef] __user *
   fs/aio.c:1961:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/aio.c:1961:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/aio.c:1961:13: sparse:     got unsigned int *__ptr_clean
>> fs/aio.c:1961:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/aio.c:1961:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/aio.c:1961:13: sparse:     got unsigned int *__ptr_clean
>> fs/aio.c:1344:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] [usertype] __user *ctxp @@
   fs/aio.c:1344:15: sparse:     expected unsigned long *__ptr_clean
   fs/aio.c:1344:15: sparse:     got unsigned long [noderef] [usertype] __user *ctxp
>> fs/aio.c:1344:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   fs/aio.c:1344:15: sparse:     expected void const volatile [noderef] __user *ptr
   fs/aio.c:1344:15: sparse:     got unsigned long *__ptr_clean
   fs/aio.c:1358:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] [usertype] __user *ctxp @@
   fs/aio.c:1358:23: sparse:     expected unsigned long *__ptr_clean
   fs/aio.c:1358:23: sparse:     got unsigned long [noderef] [usertype] __user *ctxp
   fs/aio.c:1358:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   fs/aio.c:1358:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/aio.c:1358:23: sparse:     got unsigned long *__ptr_clean
>> fs/aio.c:1358:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   fs/aio.c:1358:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/aio.c:1358:23: sparse:     got unsigned long *__ptr_clean
   fs/aio.c:1656:13: sparse: sparse: context imbalance in 'poll_iocb_lock_wq' - different lock contexts for basic block
   fs/aio.c:1687:13: sparse: sparse: context imbalance in 'poll_iocb_unlock_wq' - unexpected unlock
>> fs/aio.c:2076:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct iocb [noderef] __user **__ptr_clean @@     got struct iocb [noderef] __user *[noderef] __user * @@
   fs/aio.c:2076:21: sparse:     expected struct iocb [noderef] __user **__ptr_clean
   fs/aio.c:2076:21: sparse:     got struct iocb [noderef] __user *[noderef] __user *
>> fs/aio.c:2076:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got struct iocb [noderef] __user **__ptr_clean @@
   fs/aio.c:2076:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/aio.c:2076:21: sparse:     got struct iocb [noderef] __user **__ptr_clean
   fs/aio.c:2154:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   fs/aio.c:2154:13: sparse:     expected unsigned int *__ptr_clean
   fs/aio.c:2154:13: sparse:     got unsigned int [noderef] __user *
   fs/aio.c:2154:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/aio.c:2154:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/aio.c:2154:13: sparse:     got unsigned int *__ptr_clean
--
>> fs/binfmt_elf.c:326:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/binfmt_elf.c:326:13: sparse:     expected unsigned int *__ptr_clean
   fs/binfmt_elf.c:326:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> fs/binfmt_elf.c:326:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/binfmt_elf.c:326:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_elf.c:326:13: sparse:     got unsigned int *__ptr_clean
>> fs/binfmt_elf.c:326:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/binfmt_elf.c:326:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/binfmt_elf.c:326:13: sparse:     got unsigned int *__ptr_clean
   fs/binfmt_elf.c:333:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/binfmt_elf.c:333:21: sparse:     expected unsigned int *__ptr_clean
   fs/binfmt_elf.c:333:21: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/binfmt_elf.c:333:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/binfmt_elf.c:333:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_elf.c:333:21: sparse:     got unsigned int *__ptr_clean
   fs/binfmt_elf.c:333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/binfmt_elf.c:333:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/binfmt_elf.c:333:21: sparse:     got unsigned int *__ptr_clean
   fs/binfmt_elf.c:340:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/binfmt_elf.c:340:13: sparse:     expected unsigned int *__ptr_clean
   fs/binfmt_elf.c:340:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/binfmt_elf.c:340:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/binfmt_elf.c:340:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_elf.c:340:13: sparse:     got unsigned int *__ptr_clean
   fs/binfmt_elf.c:340:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/binfmt_elf.c:340:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/binfmt_elf.c:340:13: sparse:     got unsigned int *__ptr_clean
   fs/binfmt_elf.c:348:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/binfmt_elf.c:348:21: sparse:     expected unsigned int *__ptr_clean
   fs/binfmt_elf.c:348:21: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/binfmt_elf.c:348:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/binfmt_elf.c:348:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_elf.c:348:21: sparse:     got unsigned int *__ptr_clean
   fs/binfmt_elf.c:348:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/binfmt_elf.c:348:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/binfmt_elf.c:348:21: sparse:     got unsigned int *__ptr_clean
   fs/binfmt_elf.c:355:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/binfmt_elf.c:355:13: sparse:     expected unsigned int *__ptr_clean
   fs/binfmt_elf.c:355:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/binfmt_elf.c:355:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/binfmt_elf.c:355:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_elf.c:355:13: sparse:     got unsigned int *__ptr_clean
   fs/binfmt_elf.c:355:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/binfmt_elf.c:355:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/binfmt_elf.c:355:13: sparse:     got unsigned int *__ptr_clean
--
>> fs/fhandle.c:72:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *mnt_id @@
   fs/fhandle.c:72:13: sparse:     expected int *__ptr_clean
   fs/fhandle.c:72:13: sparse:     got int [noderef] __user *mnt_id
   fs/fhandle.c:72:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/fhandle.c:72:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fhandle.c:72:13: sparse:     got int *__ptr_clean
   fs/fhandle.c:72:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/fhandle.c:72:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fhandle.c:72:13: sparse:     got int *__ptr_clean
--
>> fs/read_write.c:1285:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] [usertype] __user *offset @@
   fs/read_write.c:1285:21: sparse:     expected long *__ptr_clean
   fs/read_write.c:1285:21: sparse:     got long [noderef] [usertype] __user *offset
   fs/read_write.c:1285:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   fs/read_write.c:1285:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/read_write.c:1285:21: sparse:     got long *__ptr_clean
   fs/read_write.c:1289:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] [usertype] __user *offset @@
   fs/read_write.c:1289:21: sparse:     expected long *__ptr_clean
   fs/read_write.c:1289:21: sparse:     got long [noderef] [usertype] __user *offset
   fs/read_write.c:1289:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   fs/read_write.c:1289:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/read_write.c:1289:21: sparse:     got long *__ptr_clean
   fs/read_write.c:1289:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   fs/read_write.c:1289:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/read_write.c:1289:21: sparse:     got long *__ptr_clean
>> fs/read_write.c:1306:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long long *__ptr_clean @@     got long long [noderef] [usertype] __user *offset @@
   fs/read_write.c:1306:21: sparse:     expected long long *__ptr_clean
   fs/read_write.c:1306:21: sparse:     got long long [noderef] [usertype] __user *offset
   fs/read_write.c:1306:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long long *__ptr_clean @@
   fs/read_write.c:1306:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/read_write.c:1306:21: sparse:     got long long *__ptr_clean
   fs/read_write.c:1306:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long long *__ptr_clean @@
   fs/read_write.c:1306:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/read_write.c:1306:21: sparse:     got long long *__ptr_clean
--
>> fs/exec.c:420:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *const *__ptr_clean @@     got char const [noderef] __user *const [noderef] __user * @@
   fs/exec.c:420:13: sparse:     expected char const [noderef] __user *const *__ptr_clean
   fs/exec.c:420:13: sparse:     got char const [noderef] __user *const [noderef] __user *
   fs/exec.c:420:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const [noderef] __user *const *__ptr_clean @@
   fs/exec.c:420:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/exec.c:420:13: sparse:     got char const [noderef] __user *const *__ptr_clean
   fs/exec.c:421:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __user * @@     got void * @@
   fs/exec.c:421:31: sparse:     expected char const [noderef] __user *
   fs/exec.c:421:31: sparse:     got void *
   fs/exec.c:1044:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1044:48: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1044:48: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1151:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1151:56: sparse:     expected struct task_struct *parent
   fs/exec.c:1151:56: sparse:     got struct task_struct [noderef] __rcu *parent
   fs/exec.c:1186:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1186:47: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1186:47: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1758:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1758:70: sparse:     expected struct task_struct *tsk
   fs/exec.c:1758:70: sparse:     got struct task_struct [noderef] __rcu *parent
--
>> fs/pipe.c:626:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/pipe.c:626:24: sparse:     expected int *__ptr_clean
   fs/pipe.c:626:24: sparse:     got int [noderef] __user *
   fs/pipe.c:626:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/pipe.c:626:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/pipe.c:626:24: sparse:     got int *__ptr_clean
   fs/pipe.c:626:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/pipe.c:626:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/pipe.c:626:24: sparse:     got int *__ptr_clean
--
>> fs/notify/inotify/inotify_user.c:322:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/notify/inotify/inotify_user.c:322:23: sparse:     expected int *__ptr_clean
   fs/notify/inotify/inotify_user.c:322:23: sparse:     got int [noderef] __user *
   fs/notify/inotify/inotify_user.c:322:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/notify/inotify/inotify_user.c:322:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/notify/inotify/inotify_user.c:322:23: sparse:     got int *__ptr_clean
   fs/notify/inotify/inotify_user.c:322:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/notify/inotify/inotify_user.c:322:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/notify/inotify/inotify_user.c:322:23: sparse:     got int *__ptr_clean
   fs/notify/inotify/inotify_user.c:563:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct fsnotify_mark_connector *conn @@     got struct fsnotify_mark_connector [noderef] __rcu *i_fsnotify_marks @@
   fs/notify/inotify/inotify_user.c:563:51: sparse:     expected struct fsnotify_mark_connector *conn
   fs/notify/inotify/inotify_user.c:563:51: sparse:     got struct fsnotify_mark_connector [noderef] __rcu *i_fsnotify_marks
--
>> ipc/syscall.c:48:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   ipc/syscall.c:48:21: sparse:     expected unsigned long *__ptr_clean
   ipc/syscall.c:48:21: sparse:     got unsigned long [noderef] __user *
>> ipc/syscall.c:48:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   ipc/syscall.c:48:21: sparse:     expected void const volatile [noderef] __user *ptr
   ipc/syscall.c:48:21: sparse:     got unsigned long *__ptr_clean
   ipc/syscall.c:89:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   ipc/syscall.c:89:32: sparse:     expected unsigned long *__ptr_clean
   ipc/syscall.c:89:32: sparse:     got unsigned long [noderef] __user *
   ipc/syscall.c:89:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   ipc/syscall.c:89:32: sparse:     expected void const volatile [noderef] __user *ptr
   ipc/syscall.c:89:32: sparse:     got unsigned long *__ptr_clean
>> ipc/syscall.c:89:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   ipc/syscall.c:89:32: sparse:     expected void [noderef] __user *__ptr_pu
   ipc/syscall.c:89:32: sparse:     got unsigned long *__ptr_clean
--
>> ipc/msg.c:960:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   ipc/msg.c:960:13: sparse:     expected long *__ptr_clean
   ipc/msg.c:960:13: sparse:     got long [noderef] __user *
>> ipc/msg.c:960:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   ipc/msg.c:960:13: sparse:     expected void const volatile [noderef] __user *ptr
   ipc/msg.c:960:13: sparse:     got long *__ptr_clean
   ipc/msg.c:1025:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   ipc/msg.c:1025:13: sparse:     expected long *__ptr_clean
   ipc/msg.c:1025:13: sparse:     got long [noderef] __user *
   ipc/msg.c:1025:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   ipc/msg.c:1025:13: sparse:     expected void const volatile [noderef] __user *ptr
   ipc/msg.c:1025:13: sparse:     got long *__ptr_clean
>> ipc/msg.c:1025:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   ipc/msg.c:1025:13: sparse:     expected void [noderef] __user *__ptr_pu
   ipc/msg.c:1025:13: sparse:     got long *__ptr_clean
   ipc/msg.c:180:26: sparse: sparse: context imbalance in 'newque' - unexpected unlock
--
>> fs/crypto/keyring.c:1003:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   fs/crypto/keyring.c:1003:23: sparse:     expected unsigned int *__ptr_clean
   fs/crypto/keyring.c:1003:23: sparse:     got unsigned int [noderef] __user *
   fs/crypto/keyring.c:1003:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/crypto/keyring.c:1003:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/crypto/keyring.c:1003:23: sparse:     got unsigned int *__ptr_clean
   fs/crypto/keyring.c:1003:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/crypto/keyring.c:1003:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/crypto/keyring.c:1003:23: sparse:     got unsigned int *__ptr_clean
--
>> fs/crypto/policy.c:445:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__ptr_clean @@     got unsigned char const [noderef] [usertype] __user * @@
   fs/crypto/policy.c:445:13: sparse:     expected unsigned char const *__ptr_clean
   fs/crypto/policy.c:445:13: sparse:     got unsigned char const [noderef] [usertype] __user *
   fs/crypto/policy.c:445:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__ptr_clean @@
   fs/crypto/policy.c:445:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/crypto/policy.c:445:13: sparse:     got unsigned char const *__ptr_clean
--
>> net/unix/af_unix.c:3080:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/unix/af_unix.c:3080:23: sparse:     expected int *__ptr_clean
   net/unix/af_unix.c:3080:23: sparse:     got int [noderef] __user *
   net/unix/af_unix.c:3080:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3080:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/unix/af_unix.c:3080:23: sparse:     got int *__ptr_clean
   net/unix/af_unix.c:3080:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3080:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/unix/af_unix.c:3080:23: sparse:     got int *__ptr_clean
   net/unix/af_unix.c:3087:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/unix/af_unix.c:3087:31: sparse:     expected int *__ptr_clean
   net/unix/af_unix.c:3087:31: sparse:     got int [noderef] __user *
   net/unix/af_unix.c:3087:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3087:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/unix/af_unix.c:3087:31: sparse:     got int *__ptr_clean
   net/unix/af_unix.c:3087:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3087:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/unix/af_unix.c:3087:31: sparse:     got int *__ptr_clean
   net/unix/af_unix.c:3101:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/unix/af_unix.c:3101:31: sparse:     expected int *__ptr_clean
   net/unix/af_unix.c:3101:31: sparse:     got int [noderef] __user *
   net/unix/af_unix.c:3101:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3101:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/unix/af_unix.c:3101:31: sparse:     got int *__ptr_clean
   net/unix/af_unix.c:3101:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3101:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/unix/af_unix.c:3101:31: sparse:     got int *__ptr_clean
   net/unix/af_unix.c:161:13: sparse: sparse: context imbalance in 'unix_table_double_lock' - wrong count at exit
   net/unix/af_unix.c:174:13: sparse: sparse: context imbalance in 'unix_table_double_unlock' - unexpected unlock
   net/unix/af_unix.c:1268:13: sparse: sparse: context imbalance in 'unix_state_double_lock' - wrong count at exit
   net/unix/af_unix.c:1286:17: sparse: sparse: context imbalance in 'unix_state_double_unlock' - unexpected unlock
   net/unix/af_unix.c:1590:18: sparse: sparse: context imbalance in 'unix_stream_connect' - different lock contexts for basic block
   net/unix/af_unix.c:1956:25: sparse: sparse: context imbalance in 'unix_dgram_sendmsg' - unexpected unlock
   net/unix/af_unix.c:3245:20: sparse: sparse: context imbalance in 'unix_get_first' - wrong count at exit
   net/unix/af_unix.c:3274:20: sparse: sparse: context imbalance in 'unix_get_next' - unexpected unlock
   net/unix/af_unix.c:3304:28: sparse: sparse: context imbalance in 'unix_seq_stop' - unexpected unlock
--
   fs/notify/fanotify/fanotify_user.c:267:63: sparse: sparse: restricted fmode_t degrades to integer
>> fs/notify/fanotify/fanotify_user.c:929:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/notify/fanotify/fanotify_user.c:929:23: sparse:     expected int *__ptr_clean
   fs/notify/fanotify/fanotify_user.c:929:23: sparse:     got int [noderef] __user *
   fs/notify/fanotify/fanotify_user.c:929:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/notify/fanotify/fanotify_user.c:929:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/notify/fanotify/fanotify_user.c:929:23: sparse:     got int *__ptr_clean
   fs/notify/fanotify/fanotify_user.c:929:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/notify/fanotify/fanotify_user.c:929:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/notify/fanotify/fanotify_user.c:929:23: sparse:     got int *__ptr_clean
   fs/notify/fanotify/fanotify_user.c:1351:28: sparse: sparse: restricted fmode_t degrades to integer
--
>> drivers/auxdisplay/charlcd.c:482:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user *tmp @@
   drivers/auxdisplay/charlcd.c:482:21: sparse:     expected char const *__ptr_clean
   drivers/auxdisplay/charlcd.c:482:21: sparse:     got char const [noderef] __user *tmp
>> drivers/auxdisplay/charlcd.c:482:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/auxdisplay/charlcd.c:482:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/auxdisplay/charlcd.c:482:21: sparse:     got char const *__ptr_clean
--
>> drivers/auxdisplay/panel.c:1041:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *tmp @@
   drivers/auxdisplay/panel.c:1041:17: sparse:     expected char *__ptr_clean
   drivers/auxdisplay/panel.c:1041:17: sparse:     got char [noderef] __user *tmp
>> drivers/auxdisplay/panel.c:1041:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   drivers/auxdisplay/panel.c:1041:17: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/auxdisplay/panel.c:1041:17: sparse:     got char *__ptr_clean
>> drivers/auxdisplay/panel.c:1041:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   drivers/auxdisplay/panel.c:1041:17: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/auxdisplay/panel.c:1041:17: sparse:     got char *__ptr_clean
--
>> drivers/char/random.c:1578:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   drivers/char/random.c:1578:21: sparse:     expected int *__ptr_clean
   drivers/char/random.c:1578:21: sparse:     got int [noderef] __user *p
   drivers/char/random.c:1578:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/char/random.c:1578:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/random.c:1578:21: sparse:     got int *__ptr_clean
   drivers/char/random.c:1578:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/char/random.c:1578:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/char/random.c:1578:21: sparse:     got int *__ptr_clean
   drivers/char/random.c:1584:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   drivers/char/random.c:1584:21: sparse:     expected int *__ptr_clean
   drivers/char/random.c:1584:21: sparse:     got int [noderef] __user *p
   drivers/char/random.c:1584:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/char/random.c:1584:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/random.c:1584:21: sparse:     got int *__ptr_clean
>> drivers/char/random.c:1593:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/char/random.c:1593:21: sparse:     expected int *__ptr_clean
   drivers/char/random.c:1593:21: sparse:     got int [noderef] __user *
   drivers/char/random.c:1593:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/char/random.c:1593:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/random.c:1593:21: sparse:     got int *__ptr_clean
   drivers/char/random.c:1597:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/char/random.c:1597:21: sparse:     expected int *__ptr_clean
   drivers/char/random.c:1597:21: sparse:     got int [noderef] __user *
   drivers/char/random.c:1597:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/char/random.c:1597:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/random.c:1597:21: sparse:     got int *__ptr_clean
--
>> drivers/char/sonypi.c:916:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user * @@
   drivers/char/sonypi.c:916:21: sparse:     expected char *__ptr_clean
   drivers/char/sonypi.c:916:21: sparse:     got char [noderef] __user *
>> drivers/char/sonypi.c:916:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   drivers/char/sonypi.c:916:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/sonypi.c:916:21: sparse:     got char *__ptr_clean
>> drivers/char/sonypi.c:916:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   drivers/char/sonypi.c:916:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/char/sonypi.c:916:21: sparse:     got char *__ptr_clean
--
>> drivers/char/nsc_gpio.c:53:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user * @@
   drivers/char/nsc_gpio.c:53:21: sparse:     expected char const *__ptr_clean
   drivers/char/nsc_gpio.c:53:21: sparse:     got char const [noderef] __user *
>> drivers/char/nsc_gpio.c:53:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/char/nsc_gpio.c:53:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/nsc_gpio.c:53:21: sparse:     got char const *__ptr_clean
>> drivers/char/nsc_gpio.c:113:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *buf @@
   drivers/char/nsc_gpio.c:113:13: sparse:     expected char *__ptr_clean
   drivers/char/nsc_gpio.c:113:13: sparse:     got char [noderef] __user *buf
>> drivers/char/nsc_gpio.c:113:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   drivers/char/nsc_gpio.c:113:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/nsc_gpio.c:113:13: sparse:     got char *__ptr_clean
>> drivers/char/nsc_gpio.c:113:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   drivers/char/nsc_gpio.c:113:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/char/nsc_gpio.c:113:13: sparse:     got char *__ptr_clean
--
   sound/core/control.c:815:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:815:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:816:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:816:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:835:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:864:41: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:957:34: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1529:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
>> sound/core/control.c:1638:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *ptr @@
   sound/core/control.c:1638:13: sparse:     expected int *__ptr_clean
   sound/core/control.c:1638:13: sparse:     got int [noderef] __user *ptr
   sound/core/control.c:1638:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/control.c:1638:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/control.c:1638:13: sparse:     got int *__ptr_clean
   sound/core/control.c:1642:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *ptr @@
   sound/core/control.c:1642:21: sparse:     expected int *__ptr_clean
   sound/core/control.c:1642:21: sparse:     got int [noderef] __user *ptr
   sound/core/control.c:1642:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/control.c:1642:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/control.c:1642:21: sparse:     got int *__ptr_clean
   sound/core/control.c:1642:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/control.c:1642:21: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/control.c:1642:21: sparse:     got int *__ptr_clean
>> sound/core/control.c:1779:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *ip @@
   sound/core/control.c:1779:24: sparse:     expected int *__ptr_clean
   sound/core/control.c:1779:24: sparse:     got int [noderef] __user *ip
   sound/core/control.c:1779:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/control.c:1779:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/control.c:1779:24: sparse:     got int *__ptr_clean
   sound/core/control.c:1779:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/control.c:1779:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/control.c:1779:24: sparse:     got int *__ptr_clean
   sound/core/control.c:1820:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *ip @@
   sound/core/control.c:1820:24: sparse:     expected int *__ptr_clean
   sound/core/control.c:1820:24: sparse:     got int [noderef] __user *ip
   sound/core/control.c:1820:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/control.c:1820:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/control.c:1820:24: sparse:     got int *__ptr_clean
   sound/core/control.c:1820:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/control.c:1820:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/control.c:1820:24: sparse:     got int *__ptr_clean
--
>> sound/core/timer.c:2044:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   sound/core/timer.c:2044:13: sparse:     expected int *__ptr_clean
   sound/core/timer.c:2044:13: sparse:     got int [noderef] __user *p
   sound/core/timer.c:2044:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/timer.c:2044:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/timer.c:2044:13: sparse:     got int *__ptr_clean
   sound/core/timer.c:2083:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   sound/core/timer.c:2083:24: sparse:     expected int *__ptr_clean
   sound/core/timer.c:2083:24: sparse:     got int [noderef] __user *p
   sound/core/timer.c:2083:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/timer.c:2083:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/timer.c:2083:24: sparse:     got int *__ptr_clean
   sound/core/timer.c:2083:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/timer.c:2083:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/timer.c:2083:24: sparse:     got int *__ptr_clean
   sound/core/timer.c:790:25: sparse: sparse: context imbalance in 'snd_timer_process_callbacks' - unexpected unlock
--
>> sound/core/pcm.c:92:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   sound/core/pcm.c:92:29: sparse:     expected int *__ptr_clean
   sound/core/pcm.c:92:29: sparse:     got int [noderef] __user *
   sound/core/pcm.c:92:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm.c:92:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:92:29: sparse:     got int *__ptr_clean
   sound/core/pcm.c:97:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   sound/core/pcm.c:97:29: sparse:     expected int *__ptr_clean
   sound/core/pcm.c:97:29: sparse:     got int [noderef] __user *
   sound/core/pcm.c:97:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm.c:97:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:97:29: sparse:     got int *__ptr_clean
   sound/core/pcm.c:97:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/pcm.c:97:29: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm.c:97:29: sparse:     got int *__ptr_clean
>> sound/core/pcm.c:112:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm.c:112:29: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm.c:112:29: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm.c:112:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm.c:112:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:112:29: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   sound/core/pcm.c:114:29: sparse:     expected int *__ptr_clean
   sound/core/pcm.c:114:29: sparse:     got int [noderef] __user *
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm.c:114:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:114:29: sparse:     got int *__ptr_clean
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm.c:119:29: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm.c:119:29: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm.c:119:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:119:29: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   sound/core/pcm.c:155:29: sparse:     expected int *__ptr_clean
   sound/core/pcm.c:155:29: sparse:     got int [noderef] __user *
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm.c:155:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:155:29: sparse:     got int *__ptr_clean
--
>> sound/core/pcm_lib.c:2436:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *tlv @@
   sound/core/pcm_lib.c:2436:13: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2436:13: sparse:     got unsigned int [noderef] __user *tlv
   sound/core/pcm_lib.c:2436:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2436:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_lib.c:2436:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2436:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2436:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_lib.c:2436:13: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_lib.c:2446:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *[assigned] dst @@
   sound/core/pcm_lib.c:2446:21: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2446:21: sparse:     got unsigned int [noderef] __user *[assigned] dst
   sound/core/pcm_lib.c:2446:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2446:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_lib.c:2446:21: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2446:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2446:21: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_lib.c:2446:21: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_lib.c:2447:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_lib.c:2447:21: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2447:21: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_lib.c:2447:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2447:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_lib.c:2447:21: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2447:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2447:21: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_lib.c:2447:21: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2457:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *[assigned] dst @@
   sound/core/pcm_lib.c:2457:29: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2457:29: sparse:     got unsigned int [noderef] __user *[assigned] dst
   sound/core/pcm_lib.c:2457:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2457:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_lib.c:2457:29: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2457:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2457:29: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_lib.c:2457:29: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2462:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_lib.c:2462:13: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2462:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_lib.c:2462:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2462:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_lib.c:2462:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2462:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2462:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_lib.c:2462:13: sparse:     got unsigned int *__ptr_clean
--
>> sound/core/pcm_native.c:1082:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   sound/core/pcm_native.c:1082:20: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_native.c:1082:20: sparse:     got unsigned int [noderef] [usertype] __user *
   sound/core/pcm_native.c:1082:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:1082:20: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:1082:20: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:1108:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   sound/core/pcm_native.c:1108:20: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_native.c:1108:20: sparse:     got unsigned int [noderef] [usertype] __user *
   sound/core/pcm_native.c:1108:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:1108:20: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:1108:20: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3039:13: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3039:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3134:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3134:13: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_native.c:3134:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3134:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3134:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3134:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3135:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3135:13: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_native.c:3135:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3135:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3135:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3135:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3136:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3136:13: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_native.c:3136:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3136:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3136:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3136:13: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_native.c:3171:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted snd_pcm_state_t *__ptr_clean @@     got restricted snd_pcm_state_t [noderef] __user * @@
   sound/core/pcm_native.c:3171:13: sparse:     expected restricted snd_pcm_state_t *__ptr_clean
   sound/core/pcm_native.c:3171:13: sparse:     got restricted snd_pcm_state_t [noderef] __user *
   sound/core/pcm_native.c:3171:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted snd_pcm_state_t *__ptr_clean @@
   sound/core/pcm_native.c:3171:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3171:13: sparse:     got restricted snd_pcm_state_t *__ptr_clean
   sound/core/pcm_native.c:3171:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got restricted snd_pcm_state_t *__ptr_clean @@
   sound/core/pcm_native.c:3171:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3171:13: sparse:     got restricted snd_pcm_state_t *__ptr_clean
   sound/core/pcm_native.c:3172:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3172:13: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_native.c:3172:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3172:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3172:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3172:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3172:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3172:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3172:13: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_native.c:3173:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   sound/core/pcm_native.c:3173:13: sparse:     expected signed int *__ptr_clean
   sound/core/pcm_native.c:3173:13: sparse:     got signed int [noderef] __user *
   sound/core/pcm_native.c:3173:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3173:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3173:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3173:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3173:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3173:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3174:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   sound/core/pcm_native.c:3174:13: sparse:     expected signed int *__ptr_clean
   sound/core/pcm_native.c:3174:13: sparse:     got signed int [noderef] __user *
   sound/core/pcm_native.c:3174:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3174:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3174:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3174:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3174:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3174:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3175:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted snd_pcm_state_t *__ptr_clean @@     got restricted snd_pcm_state_t [noderef] __user * @@
   sound/core/pcm_native.c:3175:13: sparse:     expected restricted snd_pcm_state_t *__ptr_clean
   sound/core/pcm_native.c:3175:13: sparse:     got restricted snd_pcm_state_t [noderef] __user *
   sound/core/pcm_native.c:3175:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted snd_pcm_state_t *__ptr_clean @@
   sound/core/pcm_native.c:3175:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3175:13: sparse:     got restricted snd_pcm_state_t *__ptr_clean
   sound/core/pcm_native.c:3175:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got restricted snd_pcm_state_t *__ptr_clean @@
   sound/core/pcm_native.c:3175:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3175:13: sparse:     got restricted snd_pcm_state_t *__ptr_clean
   sound/core/pcm_native.c:3176:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   sound/core/pcm_native.c:3176:13: sparse:     expected signed int *__ptr_clean
   sound/core/pcm_native.c:3176:13: sparse:     got signed int [noderef] __user *
   sound/core/pcm_native.c:3176:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3176:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3176:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3176:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3176:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3176:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3177:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   sound/core/pcm_native.c:3177:13: sparse:     expected signed int *__ptr_clean
   sound/core/pcm_native.c:3177:13: sparse:     got signed int [noderef] __user *
   sound/core/pcm_native.c:3177:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3177:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3177:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3177:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3177:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3177:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3178:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3178:13: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_native.c:3178:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3178:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3178:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3178:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3178:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3178:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3178:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3179:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3179:13: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_native.c:3179:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3179:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3179:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3179:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3179:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3179:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3179:13: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_native.c:3191:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *_arg @@
   sound/core/pcm_native.c:3191:13: sparse:     expected int *__ptr_clean
   sound/core/pcm_native.c:3191:13: sparse:     got int [noderef] __user *_arg
   sound/core/pcm_native.c:3191:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm_native.c:3191:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3191:13: sparse:     got int *__ptr_clean
>> sound/core/pcm_native.c:3208:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long *__ptr_clean @@     got signed long [noderef] __user * @@
   sound/core/pcm_native.c:3208:13: sparse:     expected signed long *__ptr_clean
   sound/core/pcm_native.c:3208:13: sparse:     got signed long [noderef] __user *
   sound/core/pcm_native.c:3208:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3208:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3208:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3208:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3208:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3208:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3216:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long *__ptr_clean @@     got signed long [noderef] __user * @@
   sound/core/pcm_native.c:3216:13: sparse:     expected signed long *__ptr_clean
   sound/core/pcm_native.c:3216:13: sparse:     got signed long [noderef] __user *
   sound/core/pcm_native.c:3216:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3216:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3216:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3216:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3216:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3216:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3233:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long *__ptr_clean @@     got signed long [noderef] __user * @@
   sound/core/pcm_native.c:3233:13: sparse:     expected signed long *__ptr_clean
   sound/core/pcm_native.c:3233:13: sparse:     got signed long [noderef] __user *
   sound/core/pcm_native.c:3233:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3233:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3233:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3233:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3233:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3233:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3246:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long *__ptr_clean @@     got signed long [noderef] __user * @@
   sound/core/pcm_native.c:3246:13: sparse:     expected signed long *__ptr_clean
   sound/core/pcm_native.c:3246:13: sparse:     got signed long [noderef] __user *
   sound/core/pcm_native.c:3246:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3246:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3246:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3246:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3246:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3246:13: sparse:     got signed long *__ptr_clean
>> sound/core/pcm_native.c:3257:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3257:13: sparse:     expected unsigned long *__ptr_clean
   sound/core/pcm_native.c:3257:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
   sound/core/pcm_native.c:3257:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3257:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3257:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3259:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3259:13: sparse:     expected unsigned long *__ptr_clean
   sound/core/pcm_native.c:3259:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
   sound/core/pcm_native.c:3259:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3259:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3259:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3259:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3259:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3259:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3262:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3262:13: sparse:     expected unsigned long *__ptr_clean
   sound/core/pcm_native.c:3262:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
   sound/core/pcm_native.c:3262:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3262:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3262:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3262:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3262:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3262:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3273:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3273:13: sparse:     expected unsigned long *__ptr_clean
   sound/core/pcm_native.c:3273:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
   sound/core/pcm_native.c:3273:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3273:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3273:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3275:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3275:13: sparse:     expected unsigned long *__ptr_clean
   sound/core/pcm_native.c:3275:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
   sound/core/pcm_native.c:3275:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3275:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3275:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3275:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3275:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3275:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3278:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3278:13: sparse:     expected unsigned long *__ptr_clean
   sound/core/pcm_native.c:3278:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
   sound/core/pcm_native.c:3278:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3278:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3278:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3278:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3278:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3278:13: sparse:     got unsigned long *__ptr_clean
>> sound/core/pcm_native.c:3302:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   sound/core/pcm_native.c:3302:24: sparse:     expected int *__ptr_clean
   sound/core/pcm_native.c:3302:24: sparse:     got int [noderef] __user *
   sound/core/pcm_native.c:3302:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm_native.c:3302:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3302:24: sparse:     got int *__ptr_clean
   sound/core/pcm_native.c:3302:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/pcm_native.c:3302:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3302:24: sparse:     got int *__ptr_clean
   sound/core/pcm_native.c:3310:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3310:21: sparse:     expected unsigned int *__ptr_clean
   sound/core/pcm_native.c:3310:21: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3310:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3310:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3310:21: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_native.c:3357:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long *__ptr_clean @@     got signed long [noderef] [usertype] __user *res @@
   sound/core/pcm_native.c:3357:21: sparse:     expected signed long *__ptr_clean
   sound/core/pcm_native.c:3357:21: sparse:     got signed long [noderef] [usertype] __user *res
   sound/core/pcm_native.c:3357:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3357:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3357:21: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3357:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3357:21: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3357:21: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:95:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock' - different lock contexts for basic block
   sound/core/pcm_native.c:96:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock' - unexpected unlock
   sound/core/pcm_native.c:97:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock_irq' - different lock contexts for basic block
   sound/core/pcm_native.c:98:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
   sound/core/pcm_native.c:145:9: sparse: sparse: context imbalance in 'snd_pcm_stream_lock_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:171:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave' - different lock contexts for basic block
   sound/core/pcm_native.c:184:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:201:39: sparse: sparse: context imbalance in 'snd_pcm_stream_unlock_irqrestore' - unexpected unlock
   sound/core/pcm_native.c:1261:44: sparse: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
   sound/core/pcm_native.c:1331:37: sparse: sparse: context imbalance in 'snd_pcm_stream_group_ref' - different lock contexts for basic block
--
>> net/socket.c:1180:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/socket.c:1180:29: sparse:     expected int *__ptr_clean
   net/socket.c:1180:29: sparse:     got int [noderef] __user *
   net/socket.c:1180:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/socket.c:1180:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:1180:29: sparse:     got int *__ptr_clean
   net/socket.c:1186:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/socket.c:1186:31: sparse:     expected int *__ptr_clean
   net/socket.c:1186:31: sparse:     got int [noderef] __user *
   net/socket.c:1186:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/socket.c:1186:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:1186:31: sparse:     got int *__ptr_clean
   net/socket.c:1186:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/socket.c:1186:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/socket.c:1186:31: sparse:     got int *__ptr_clean
>> net/socket.c:278:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *ulen @@
   net/socket.c:278:15: sparse:     expected int *__ptr_clean
   net/socket.c:278:15: sparse:     got int [noderef] __user *ulen
   net/socket.c:278:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/socket.c:278:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:278:15: sparse:     got int *__ptr_clean
   net/socket.c:1606:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/socket.c:1606:15: sparse:     expected int *__ptr_clean
   net/socket.c:1606:15: sparse:     got int [noderef] __user *
   net/socket.c:1606:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/socket.c:1606:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:1606:15: sparse:     got int *__ptr_clean
   net/socket.c:1606:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/socket.c:1606:15: sparse:     expected void [noderef] __user *__ptr_pu
   net/socket.c:1606:15: sparse:     got int *__ptr_clean
   net/socket.c:1610:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/socket.c:1610:15: sparse:     expected int *__ptr_clean
   net/socket.c:1610:15: sparse:     got int [noderef] __user *
   net/socket.c:1610:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/socket.c:1610:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:1610:15: sparse:     got int *__ptr_clean
   net/socket.c:1610:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/socket.c:1610:15: sparse:     expected void [noderef] __user *__ptr_pu
   net/socket.c:1610:15: sparse:     got int *__ptr_clean
>> net/socket.c:2558:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   net/socket.c:2558:31: sparse:     expected unsigned int *__ptr_clean
   net/socket.c:2558:31: sparse:     got unsigned int [noderef] __user *
   net/socket.c:2558:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/socket.c:2558:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:2558:31: sparse:     got unsigned int *__ptr_clean
   net/socket.c:2558:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/socket.c:2558:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/socket.c:2558:31: sparse:     got unsigned int *__ptr_clean
   net/socket.c:2774:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   net/socket.c:2774:31: sparse:     expected unsigned int *__ptr_clean
   net/socket.c:2774:31: sparse:     got unsigned int [noderef] __user *
   net/socket.c:2774:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/socket.c:2774:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:2774:31: sparse:     got unsigned int *__ptr_clean
   net/socket.c:2774:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/socket.c:2774:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/socket.c:2774:31: sparse:     got unsigned int *__ptr_clean
--
>> net/core/dev_ioctl.c:79:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/core/dev_ioctl.c:79:16: sparse:     expected int *__ptr_clean
   net/core/dev_ioctl.c:79:16: sparse:     got int [noderef] __user *
   net/core/dev_ioctl.c:79:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/dev_ioctl.c:79:16: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/dev_ioctl.c:79:16: sparse:     got int *__ptr_clean
   net/core/dev_ioctl.c:79:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/dev_ioctl.c:79:16: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/dev_ioctl.c:79:16: sparse:     got int *__ptr_clean
--
>> net/core/sock.c:717:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/core/sock.c:717:13: sparse:     expected int *__ptr_clean
   net/core/sock.c:717:13: sparse:     got int [noderef] __user *optlen
   net/core/sock.c:717:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/sock.c:717:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:717:13: sparse:     got int *__ptr_clean
   net/core/sock.c:717:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/sock.c:717:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/sock.c:717:13: sparse:     got int *__ptr_clean
>> net/core/sock.c:1498:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/core/sock.c:1498:21: sparse:     expected unsigned int *__ptr_clean
   net/core/sock.c:1498:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/core/sock.c:1498:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/core/sock.c:1498:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:1498:21: sparse:     got unsigned int *__ptr_clean
   net/core/sock.c:1498:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/core/sock.c:1498:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/sock.c:1498:21: sparse:     got unsigned int *__ptr_clean
   net/core/sock.c:1524:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/core/sock.c:1524:13: sparse:     expected int *__ptr_clean
   net/core/sock.c:1524:13: sparse:     got int [noderef] __user *optlen
   net/core/sock.c:1524:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/sock.c:1524:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:1524:13: sparse:     got int *__ptr_clean
   net/core/sock.c:1677:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/core/sock.c:1677:32: sparse:     expected int *__ptr_clean
   net/core/sock.c:1677:32: sparse:     got int [noderef] __user *optlen
   net/core/sock.c:1677:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/sock.c:1677:32: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:1677:32: sparse:     got int *__ptr_clean
   net/core/sock.c:1677:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/sock.c:1677:32: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/sock.c:1677:32: sparse:     got int *__ptr_clean
   net/core/sock.c:1862:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/core/sock.c:1862:13: sparse:     expected int *__ptr_clean
   net/core/sock.c:1862:13: sparse:     got int [noderef] __user *optlen
   net/core/sock.c:1862:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/sock.c:1862:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:1862:13: sparse:     got int *__ptr_clean
   net/core/sock.c:1862:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/sock.c:1862:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/sock.c:1862:13: sparse:     got int *__ptr_clean
   net/core/sock.c:2249:9: sparse: sparse: context imbalance in 'sk_clone_lock' - wrong count at exit
   net/core/sock.c:2253:6: sparse: sparse: context imbalance in 'sk_free_unlock_clone' - unexpected unlock
   net/core/sock.c:3810:13: sparse: sparse: context imbalance in 'proto_seq_start' - wrong count at exit
   net/core/sock.c:3822:13: sparse: sparse: context imbalance in 'proto_seq_stop' - wrong count at exit
--
>> net/core/scm.c:324:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/core/scm.c:324:23: sparse:     expected int *__ptr_clean
   net/core/scm.c:324:23: sparse:     got int [noderef] __user *
   net/core/scm.c:324:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/scm.c:324:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/scm.c:324:23: sparse:     got int *__ptr_clean
   net/core/scm.c:324:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/scm.c:324:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/scm.c:324:23: sparse:     got int *__ptr_clean
   net/core/scm.c:326:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/core/scm.c:326:31: sparse:     expected int *__ptr_clean
   net/core/scm.c:326:31: sparse:     got int [noderef] __user *
   net/core/scm.c:326:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/scm.c:326:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/scm.c:326:31: sparse:     got int *__ptr_clean
   net/core/scm.c:326:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/scm.c:326:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/scm.c:326:31: sparse:     got int *__ptr_clean
>> net/core/scm.c:328:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   net/core/scm.c:328:31: sparse:     expected unsigned int *__ptr_clean
   net/core/scm.c:328:31: sparse:     got unsigned int [noderef] __user *
>> net/core/scm.c:328:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/core/scm.c:328:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/scm.c:328:31: sparse:     got unsigned int *__ptr_clean
>> net/core/scm.c:328:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/core/scm.c:328:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/scm.c:328:31: sparse:     got unsigned int *__ptr_clean
--
>> drivers/firewire/core-cdev.c:1108:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/firewire/core-cdev.c:1108:21: sparse:     expected unsigned int *__ptr_clean
   drivers/firewire/core-cdev.c:1108:21: sparse:     got unsigned int [noderef] __user *
   drivers/firewire/core-cdev.c:1108:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/firewire/core-cdev.c:1108:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firewire/core-cdev.c:1108:21: sparse:     got unsigned int *__ptr_clean
--
>> net/netlink/af_netlink.c:1730:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/netlink/af_netlink.c:1730:13: sparse:     expected int *__ptr_clean
   net/netlink/af_netlink.c:1730:13: sparse:     got int [noderef] __user *optlen
   net/netlink/af_netlink.c:1730:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1730:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1730:13: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1741:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/netlink/af_netlink.c:1741:21: sparse:     expected int *__ptr_clean
   net/netlink/af_netlink.c:1741:21: sparse:     got int [noderef] __user *optlen
   net/netlink/af_netlink.c:1741:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1741:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1741:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1741:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1741:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1741:21: sparse:     got int *__ptr_clean
>> net/netlink/af_netlink.c:1742:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *optval @@
   net/netlink/af_netlink.c:1742:21: sparse:     expected char *__ptr_clean
   net/netlink/af_netlink.c:1742:21: sparse:     got char [noderef] __user *optval
   net/netlink/af_netlink.c:1742:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1742:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1742:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1742:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1742:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1742:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1751:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/netlink/af_netlink.c:1751:21: sparse:     expected int *__ptr_clean
   net/netlink/af_netlink.c:1751:21: sparse:     got int [noderef] __user *optlen
   net/netlink/af_netlink.c:1751:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1751:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1751:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1751:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1751:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1751:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1752:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *optval @@
   net/netlink/af_netlink.c:1752:21: sparse:     expected char *__ptr_clean
   net/netlink/af_netlink.c:1752:21: sparse:     got char [noderef] __user *optval
   net/netlink/af_netlink.c:1752:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1752:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1752:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1752:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1752:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1752:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1761:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/netlink/af_netlink.c:1761:21: sparse:     expected int *__ptr_clean
   net/netlink/af_netlink.c:1761:21: sparse:     got int [noderef] __user *optlen
   net/netlink/af_netlink.c:1761:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1761:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1761:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1761:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1761:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1761:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1762:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *optval @@
   net/netlink/af_netlink.c:1762:21: sparse:     expected char *__ptr_clean
   net/netlink/af_netlink.c:1762:21: sparse:     got char [noderef] __user *optval
   net/netlink/af_netlink.c:1762:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1762:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1762:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1762:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1762:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1762:21: sparse:     got char *__ptr_clean
>> net/netlink/af_netlink.c:1777:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/netlink/af_netlink.c:1777:29: sparse:     expected unsigned int *__ptr_clean
   net/netlink/af_netlink.c:1777:29: sparse:     got unsigned int [noderef] [usertype] __user *
   net/netlink/af_netlink.c:1777:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/netlink/af_netlink.c:1777:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1777:29: sparse:     got unsigned int *__ptr_clean
   net/netlink/af_netlink.c:1777:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/netlink/af_netlink.c:1777:29: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1777:29: sparse:     got unsigned int *__ptr_clean
   net/netlink/af_netlink.c:1783:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/netlink/af_netlink.c:1783:21: sparse:     expected int *__ptr_clean
   net/netlink/af_netlink.c:1783:21: sparse:     got int [noderef] __user *optlen
   net/netlink/af_netlink.c:1783:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1783:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1783:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1783:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1783:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1783:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1793:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/netlink/af_netlink.c:1793:21: sparse:     expected int *__ptr_clean
   net/netlink/af_netlink.c:1793:21: sparse:     got int [noderef] __user *optlen
   net/netlink/af_netlink.c:1793:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1793:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1793:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1793:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1793:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1793:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1794:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *optval @@
   net/netlink/af_netlink.c:1794:21: sparse:     expected char *__ptr_clean
   net/netlink/af_netlink.c:1794:21: sparse:     got char [noderef] __user *optval
   net/netlink/af_netlink.c:1794:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1794:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1794:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1794:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1794:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1794:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1803:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/netlink/af_netlink.c:1803:21: sparse:     expected int *__ptr_clean
   net/netlink/af_netlink.c:1803:21: sparse:     got int [noderef] __user *optlen
   net/netlink/af_netlink.c:1803:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1803:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1803:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1803:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1803:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1803:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1803:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *optval @@
   net/netlink/af_netlink.c:1803:46: sparse:     expected char *__ptr_clean
   net/netlink/af_netlink.c:1803:46: sparse:     got char [noderef] __user *optval
   net/netlink/af_netlink.c:1803:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1803:46: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1803:46: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1803:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1803:46: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1803:46: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1812:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/netlink/af_netlink.c:1812:21: sparse:     expected int *__ptr_clean
   net/netlink/af_netlink.c:1812:21: sparse:     got int [noderef] __user *optlen
   net/netlink/af_netlink.c:1812:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1812:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1812:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1812:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1812:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1812:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1812:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *optval @@
   net/netlink/af_netlink.c:1812:46: sparse:     expected char *__ptr_clean
   net/netlink/af_netlink.c:1812:46: sparse:     got char [noderef] __user *optval
   net/netlink/af_netlink.c:1812:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1812:46: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1812:46: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1812:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1812:46: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1812:46: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:2563:13: sparse: sparse: context imbalance in 'netlink_walk_start' - wrong count at exit
   net/netlink/af_netlink.c:2569:13: sparse: sparse: context imbalance in 'netlink_walk_stop' - unexpected unlock
   net/netlink/af_netlink.c:2619:9: sparse: sparse: context imbalance in 'netlink_seq_start' - wrong count at exit
--
>> drivers/misc/xilinx_sdfec.c:735:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int enum xsdfec_order *__ptr_clean @@     got unsigned int enum xsdfec_order [noderef] __user * @@
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     expected unsigned int enum xsdfec_order *__ptr_clean
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     got unsigned int enum xsdfec_order [noderef] __user *
   drivers/misc/xilinx_sdfec.c:735:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int enum xsdfec_order *__ptr_clean @@
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     got unsigned int enum xsdfec_order *__ptr_clean
>> drivers/misc/xilinx_sdfec.c:760:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected bool *__ptr_clean @@     got bool [noderef] [usertype] __user *arg @@
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     expected bool *__ptr_clean
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     got bool [noderef] [usertype] __user *arg
   drivers/misc/xilinx_sdfec.c:760:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got bool *__ptr_clean @@
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     got bool *__ptr_clean
   drivers/misc/xilinx_sdfec.c:787:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected bool *__ptr_clean @@     got bool [noderef] [usertype] __user *arg @@
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     expected bool *__ptr_clean
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     got bool [noderef] [usertype] __user *arg
   drivers/misc/xilinx_sdfec.c:787:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got bool *__ptr_clean @@
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     got bool *__ptr_clean
   drivers/misc/xilinx_sdfec.c:787:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got bool *__ptr_clean @@
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     got bool *__ptr_clean
--
>> drivers/fsi/fsi-scom.c:457:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/fsi/fsi-scom.c:457:13: sparse:     expected unsigned int *__ptr_clean
   drivers/fsi/fsi-scom.c:457:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/fsi/fsi-scom.c:457:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/fsi/fsi-scom.c:457:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fsi/fsi-scom.c:457:13: sparse:     got unsigned int *__ptr_clean
   drivers/fsi/fsi-scom.c:471:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/fsi/fsi-scom.c:471:16: sparse:     expected unsigned int *__ptr_clean
   drivers/fsi/fsi-scom.c:471:16: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/fsi/fsi-scom.c:471:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/fsi/fsi-scom.c:471:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fsi/fsi-scom.c:471:16: sparse:     got unsigned int *__ptr_clean
>> drivers/fsi/fsi-scom.c:471:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/fsi/fsi-scom.c:471:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/fsi/fsi-scom.c:471:16: sparse:     got unsigned int *__ptr_clean
--
>> fs/cifs/ioctl.c:163:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/cifs/ioctl.c:163:13: sparse:     expected unsigned int *__ptr_clean
   fs/cifs/ioctl.c:163:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/cifs/ioctl.c:163:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/cifs/ioctl.c:163:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/ioctl.c:163:13: sparse:     got unsigned int *__ptr_clean
>> fs/cifs/ioctl.c:353:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/cifs/ioctl.c:353:38: sparse:     expected int *__ptr_clean
   fs/cifs/ioctl.c:353:38: sparse:     got int [noderef] __user *
   fs/cifs/ioctl.c:353:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/cifs/ioctl.c:353:38: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/ioctl.c:353:38: sparse:     got int *__ptr_clean
   fs/cifs/ioctl.c:353:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/cifs/ioctl.c:353:38: sparse:     expected void [noderef] __user *__ptr_pu
   fs/cifs/ioctl.c:353:38: sparse:     got int *__ptr_clean
   fs/cifs/ioctl.c:363:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/cifs/ioctl.c:363:29: sparse:     expected int *__ptr_clean
   fs/cifs/ioctl.c:363:29: sparse:     got int [noderef] __user *
   fs/cifs/ioctl.c:363:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/cifs/ioctl.c:363:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/ioctl.c:363:29: sparse:     got int *__ptr_clean
--
>> fs/cifs/smb2ops.c:2207:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   fs/cifs/smb2ops.c:2207:13: sparse:     expected unsigned int *__ptr_clean
   fs/cifs/smb2ops.c:2207:13: sparse:     got unsigned int [noderef] __user *
   fs/cifs/smb2ops.c:2207:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/cifs/smb2ops.c:2207:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/smb2ops.c:2207:13: sparse:     got unsigned int *__ptr_clean
--
>> fs/cifs/cifs_debug.c:798:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user *buffer @@
   fs/cifs/cifs_debug.c:798:14: sparse:     expected char const *__ptr_clean
   fs/cifs/cifs_debug.c:798:14: sparse:     got char const [noderef] __user *buffer
   fs/cifs/cifs_debug.c:798:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   fs/cifs/cifs_debug.c:798:14: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/cifs_debug.c:798:14: sparse:     got char const *__ptr_clean
--
>> fs/autofs/root.c:820:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   fs/autofs/root.c:820:16: sparse:     expected int *__ptr_clean
   fs/autofs/root.c:820:16: sparse:     got int [noderef] __user *p
   fs/autofs/root.c:820:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/autofs/root.c:820:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/root.c:820:16: sparse:     got int *__ptr_clean
   fs/autofs/root.c:820:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/autofs/root.c:820:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/autofs/root.c:820:16: sparse:     got int *__ptr_clean
   fs/autofs/root.c:827:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   fs/autofs/root.c:827:16: sparse:     expected int *__ptr_clean
   fs/autofs/root.c:827:16: sparse:     got int [noderef] __user *p
   fs/autofs/root.c:827:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/autofs/root.c:827:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/root.c:827:16: sparse:     got int *__ptr_clean
   fs/autofs/root.c:827:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/autofs/root.c:827:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/autofs/root.c:827:16: sparse:     got int *__ptr_clean
>> fs/autofs/root.c:798:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user *p @@
   fs/autofs/root.c:798:14: sparse:     expected unsigned long *__ptr_clean
   fs/autofs/root.c:798:14: sparse:     got unsigned long [noderef] __user *p
   fs/autofs/root.c:798:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   fs/autofs/root.c:798:14: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/root.c:798:14: sparse:     got unsigned long *__ptr_clean
   fs/autofs/root.c:802:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user *p @@
   fs/autofs/root.c:802:14: sparse:     expected unsigned long *__ptr_clean
   fs/autofs/root.c:802:14: sparse:     got unsigned long [noderef] __user *p
   fs/autofs/root.c:802:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   fs/autofs/root.c:802:14: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/root.c:802:14: sparse:     got unsigned long *__ptr_clean
   fs/autofs/root.c:802:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   fs/autofs/root.c:802:14: sparse:     expected void [noderef] __user *__ptr_pu
   fs/autofs/root.c:802:14: sparse:     got unsigned long *__ptr_clean
   fs/autofs/root.c:842:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *p @@
   fs/autofs/root.c:842:18: sparse:     expected int *__ptr_clean
   fs/autofs/root.c:842:18: sparse:     got int [noderef] __user *p
   fs/autofs/root.c:842:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/autofs/root.c:842:18: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/root.c:842:18: sparse:     got int *__ptr_clean
   fs/autofs/root.c:842:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/autofs/root.c:842:18: sparse:     expected void [noderef] __user *__ptr_pu
   fs/autofs/root.c:842:18: sparse:     got int *__ptr_clean
--
>> fs/autofs/expire.c:616:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *arg @@
   fs/autofs/expire.c:616:20: sparse:     expected int *__ptr_clean
   fs/autofs/expire.c:616:20: sparse:     got int [noderef] __user *arg
   fs/autofs/expire.c:616:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/autofs/expire.c:616:20: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/expire.c:616:20: sparse:     got int *__ptr_clean
--
>> drivers/gpu/drm/drm_crtc.c:785:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_crtc.c:785:29: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_crtc.c:785:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_crtc.c:785:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_crtc.c:785:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_crtc.c:785:29: sparse:     got unsigned int *__ptr_clean
--
>> drivers/gpu/drm/drm_property.c:484:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_property.c:484:21: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/drm_property.c:484:21: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/gpu/drm/drm_property.c:484:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/drm_property.c:484:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_property.c:484:21: sparse:     got unsigned long long *__ptr_clean
   drivers/gpu/drm/drm_property.c:484:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/drm_property.c:484:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_property.c:484:21: sparse:     got unsigned long long *__ptr_clean
--
>> drivers/gpu/drm/drm_connector.c:2683:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_connector.c:2683:29: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_connector.c:2683:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_connector.c:2683:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_connector.c:2683:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_connector.c:2683:29: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_connector.c:2683:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_connector.c:2683:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_connector.c:2683:29: sparse:     got unsigned int *__ptr_clean
--
>> drivers/gpu/drm/drm_mode_object.c:404:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     got unsigned int *__ptr_clean
>> drivers/gpu/drm/drm_mode_object.c:407:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     expected unsigned long long *__ptr_clean
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     got unsigned long long *__ptr_clean
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     got unsigned long long *__ptr_clean
--
>> drivers/gpu/drm/drm_mode_config.c:113:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse:     got unsigned int *__ptr_clean
--
>> drivers/gpu/drm/drm_plane.c:672:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_plane.c:672:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_plane.c:672:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     got unsigned int *__ptr_clean
--
>> drivers/gpu/drm/drm_lease.c:614:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_lease.c:614:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_lease.c:614:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_lease.c:669:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_lease.c:669:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_lease.c:669:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     got unsigned int *__ptr_clean
--
>> drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user *fence_ptr @@
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse:     expected signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse:     got signed int [noderef] [usertype] __user *fence_ptr
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user *fence_ptr @@
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse:     expected signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse:     got signed int [noderef] [usertype] __user *fence_ptr
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse:     got signed int *__ptr_clean
>> drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user *out_fence_ptr @@
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse:     expected signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse:     got signed int [noderef] [usertype] __user *out_fence_ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user *out_fence_ptr @@
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse:     expected signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse:     got signed int [noderef] [usertype] __user *out_fence_ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse:     got signed int *__ptr_clean
>> drivers/gpu/drm/drm_atomic_uapi.c:1389:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1389:21: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1389:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_atomic_uapi.c:1389:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1389:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1389:21: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1406:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1406:21: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1406:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_atomic_uapi.c:1406:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1406:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1406:21: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1419:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1419:29: sparse:     expected unsigned int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1419:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/gpu/drm/drm_atomic_uapi.c:1419:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1419:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1419:29: sparse:     got unsigned int *__ptr_clean
--
>> fs/fuse/dev.c:2261:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/fuse/dev.c:2261:22: sparse:     expected unsigned int *__ptr_clean
   fs/fuse/dev.c:2261:22: sparse:     got unsigned int [noderef] [usertype] __user *
>> fs/fuse/dev.c:2261:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/fuse/dev.c:2261:22: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fuse/dev.c:2261:22: sparse:     got unsigned int *__ptr_clean
--
>> drivers/hid/hidraw.c:381:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hid/hidraw.c:381:29: sparse:     expected int *__ptr_clean
   drivers/hid/hidraw.c:381:29: sparse:     got int [noderef] __user *
>> drivers/hid/hidraw.c:381:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hid/hidraw.c:381:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hid/hidraw.c:381:29: sparse:     got int *__ptr_clean
>> drivers/hid/hidraw.c:381:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/hid/hidraw.c:381:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/hid/hidraw.c:381:29: sparse:     got int *__ptr_clean
   drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hid/hidraw.c:389:37: sparse:     expected int *__ptr_clean
   drivers/hid/hidraw.c:389:37: sparse:     got int [noderef] __user *
   drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hid/hidraw.c:389:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hid/hidraw.c:389:37: sparse:     got int *__ptr_clean
--
>> drivers/hwmon/w83793.c:1370:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user * @@
   drivers/hwmon/w83793.c:1370:37: sparse:     expected char const *__ptr_clean
   drivers/hwmon/w83793.c:1370:37: sparse:     got char const [noderef] __user *
>> drivers/hwmon/w83793.c:1370:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/hwmon/w83793.c:1370:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/w83793.c:1370:37: sparse:     got char const *__ptr_clean
>> drivers/hwmon/w83793.c:1406:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1406:23: sparse:     expected int *__ptr_clean
   drivers/hwmon/w83793.c:1406:23: sparse:     got int [noderef] __user *
>> drivers/hwmon/w83793.c:1406:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/w83793.c:1406:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/w83793.c:1406:23: sparse:     got int *__ptr_clean
>> drivers/hwmon/w83793.c:1406:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/hwmon/w83793.c:1406:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/hwmon/w83793.c:1406:23: sparse:     got int *__ptr_clean
   drivers/hwmon/w83793.c:1410:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1410:23: sparse:     expected int *__ptr_clean
   drivers/hwmon/w83793.c:1410:23: sparse:     got int [noderef] __user *
   drivers/hwmon/w83793.c:1410:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/w83793.c:1410:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/w83793.c:1410:23: sparse:     got int *__ptr_clean
   drivers/hwmon/w83793.c:1410:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/hwmon/w83793.c:1410:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/hwmon/w83793.c:1410:23: sparse:     got int *__ptr_clean
   drivers/hwmon/w83793.c:1419:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1419:23: sparse:     expected int *__ptr_clean
   drivers/hwmon/w83793.c:1419:23: sparse:     got int [noderef] __user *
   drivers/hwmon/w83793.c:1419:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/w83793.c:1419:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/w83793.c:1419:23: sparse:     got int *__ptr_clean
   drivers/hwmon/w83793.c:1419:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/hwmon/w83793.c:1419:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/hwmon/w83793.c:1419:23: sparse:     got int *__ptr_clean
   drivers/hwmon/w83793.c:1423:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1423:21: sparse:     expected int *__ptr_clean
   drivers/hwmon/w83793.c:1423:21: sparse:     got int [noderef] __user *
   drivers/hwmon/w83793.c:1423:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/w83793.c:1423:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/w83793.c:1423:21: sparse:     got int *__ptr_clean
   drivers/hwmon/w83793.c:1429:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1429:31: sparse:     expected int *__ptr_clean
   drivers/hwmon/w83793.c:1429:31: sparse:     got int [noderef] __user *
   drivers/hwmon/w83793.c:1429:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/w83793.c:1429:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/w83793.c:1429:31: sparse:     got int *__ptr_clean
   drivers/hwmon/w83793.c:1429:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/hwmon/w83793.c:1429:31: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/hwmon/w83793.c:1429:31: sparse:     got int *__ptr_clean
   drivers/hwmon/w83793.c:1433:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1433:21: sparse:     expected int *__ptr_clean
   drivers/hwmon/w83793.c:1433:21: sparse:     got int [noderef] __user *
   drivers/hwmon/w83793.c:1433:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/w83793.c:1433:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/w83793.c:1433:21: sparse:     got int *__ptr_clean
--
>> drivers/i2c/i2c-dev.c:432:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   drivers/i2c/i2c-dev.c:432:24: sparse:     expected unsigned long *__ptr_clean
   drivers/i2c/i2c-dev.c:432:24: sparse:     got unsigned long [noderef] __user *
   drivers/i2c/i2c-dev.c:432:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   drivers/i2c/i2c-dev.c:432:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/i2c/i2c-dev.c:432:24: sparse:     got unsigned long *__ptr_clean
   drivers/i2c/i2c-dev.c:432:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   drivers/i2c/i2c-dev.c:432:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/i2c/i2c-dev.c:432:24: sparse:     got unsigned long *__ptr_clean
--
>> drivers/input/mousedev.c:683:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user * @@
   drivers/input/mousedev.c:683:21: sparse:     expected char const *__ptr_clean
   drivers/input/mousedev.c:683:21: sparse:     got char const [noderef] __user *
>> drivers/input/mousedev.c:683:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/input/mousedev.c:683:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/mousedev.c:683:21: sparse:     got char const *__ptr_clean
--
>> drivers/input/joydev.c:530:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   drivers/input/joydev.c:530:24: sparse:     expected signed int *__ptr_clean
   drivers/input/joydev.c:530:24: sparse:     got signed int [noderef] [usertype] __user *
>> drivers/input/joydev.c:530:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/input/joydev.c:530:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/joydev.c:530:24: sparse:     got signed int *__ptr_clean
   drivers/input/joydev.c:533:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   drivers/input/joydev.c:533:24: sparse:     expected signed int *__ptr_clean
   drivers/input/joydev.c:533:24: sparse:     got signed int [noderef] [usertype] __user *
   drivers/input/joydev.c:533:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/input/joydev.c:533:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/joydev.c:533:24: sparse:     got signed int *__ptr_clean
>> drivers/input/joydev.c:533:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/input/joydev.c:533:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/joydev.c:533:24: sparse:     got signed int *__ptr_clean
>> drivers/input/joydev.c:536:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/input/joydev.c:536:24: sparse:     expected unsigned int *__ptr_clean
   drivers/input/joydev.c:536:24: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/input/joydev.c:536:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/input/joydev.c:536:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/joydev.c:536:24: sparse:     got unsigned int *__ptr_clean
>> drivers/input/joydev.c:536:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/input/joydev.c:536:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/joydev.c:536:24: sparse:     got unsigned int *__ptr_clean
>> drivers/input/joydev.c:539:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__ptr_clean @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/input/joydev.c:539:24: sparse:     expected unsigned char *__ptr_clean
   drivers/input/joydev.c:539:24: sparse:     got unsigned char [noderef] [usertype] __user *
>> drivers/input/joydev.c:539:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   drivers/input/joydev.c:539:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/joydev.c:539:24: sparse:     got unsigned char *__ptr_clean
>> drivers/input/joydev.c:539:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned char *__ptr_clean @@
   drivers/input/joydev.c:539:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/joydev.c:539:24: sparse:     got unsigned char *__ptr_clean
   drivers/input/joydev.c:542:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__ptr_clean @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/input/joydev.c:542:24: sparse:     expected unsigned char *__ptr_clean
   drivers/input/joydev.c:542:24: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/input/joydev.c:542:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   drivers/input/joydev.c:542:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/joydev.c:542:24: sparse:     got unsigned char *__ptr_clean
   drivers/input/joydev.c:542:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned char *__ptr_clean @@
   drivers/input/joydev.c:542:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/joydev.c:542:24: sparse:     got unsigned char *__ptr_clean
>> drivers/input/joydev.c:682:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   drivers/input/joydev.c:682:26: sparse:     expected long *__ptr_clean
   drivers/input/joydev.c:682:26: sparse:     got long [noderef] __user *
>> drivers/input/joydev.c:682:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   drivers/input/joydev.c:682:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/joydev.c:682:26: sparse:     got long *__ptr_clean
   drivers/input/joydev.c:687:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   drivers/input/joydev.c:687:26: sparse:     expected long *__ptr_clean
   drivers/input/joydev.c:687:26: sparse:     got long [noderef] __user *
   drivers/input/joydev.c:687:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   drivers/input/joydev.c:687:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/joydev.c:687:26: sparse:     got long *__ptr_clean
>> drivers/input/joydev.c:687:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   drivers/input/joydev.c:687:26: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/joydev.c:687:26: sparse:     got long *__ptr_clean
--
>> drivers/input/evdev.c:819:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/input/evdev.c:819:13: sparse:     expected int *__ptr_clean
   drivers/input/evdev.c:819:13: sparse:     got int [noderef] __user *
>> drivers/input/evdev.c:819:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/input/evdev.c:819:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:819:13: sparse:     got int *__ptr_clean
>> drivers/input/evdev.c:819:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/input/evdev.c:819:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/evdev.c:819:13: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:854:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/input/evdev.c:854:13: sparse:     expected int *__ptr_clean
   drivers/input/evdev.c:854:13: sparse:     got int [noderef] __user *
   drivers/input/evdev.c:854:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/input/evdev.c:854:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:854:13: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:928:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/input/evdev.c:928:13: sparse:     expected int *__ptr_clean
   drivers/input/evdev.c:928:13: sparse:     got int [noderef] __user *
   drivers/input/evdev.c:928:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/input/evdev.c:928:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:928:13: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:936:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/input/evdev.c:936:21: sparse:     expected int *__ptr_clean
   drivers/input/evdev.c:936:21: sparse:     got int [noderef] __user *
   drivers/input/evdev.c:936:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/input/evdev.c:936:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:936:21: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:936:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/input/evdev.c:936:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/evdev.c:936:21: sparse:     got int *__ptr_clean
>> drivers/input/evdev.c:1017:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__ptr_clean @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/input/evdev.c:1017:37: sparse:     expected unsigned char *__ptr_clean
   drivers/input/evdev.c:1017:37: sparse:     got unsigned char [noderef] [usertype] __user *
>> drivers/input/evdev.c:1017:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   drivers/input/evdev.c:1017:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:1017:37: sparse:     got unsigned char *__ptr_clean
>> drivers/input/evdev.c:1017:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned char *__ptr_clean @@
   drivers/input/evdev.c:1017:37: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/evdev.c:1017:37: sparse:     got unsigned char *__ptr_clean
>> drivers/input/evdev.c:1047:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *ip @@
   drivers/input/evdev.c:1047:24: sparse:     expected int *__ptr_clean
   drivers/input/evdev.c:1047:24: sparse:     got int [noderef] __user *ip
   drivers/input/evdev.c:1047:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/input/evdev.c:1047:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:1047:24: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:1047:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/input/evdev.c:1047:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/evdev.c:1047:24: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:1057:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *ip @@
   drivers/input/evdev.c:1057:21: sparse:     expected int *__ptr_clean
   drivers/input/evdev.c:1057:21: sparse:     got int [noderef] __user *ip
   drivers/input/evdev.c:1057:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/input/evdev.c:1057:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:1057:21: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:1057:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/input/evdev.c:1057:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/evdev.c:1057:21: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:1059:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/input/evdev.c:1059:21: sparse:     expected int *__ptr_clean
   drivers/input/evdev.c:1059:21: sparse:     got int [noderef] __user *
   drivers/input/evdev.c:1059:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/input/evdev.c:1059:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:1059:21: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:1059:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/input/evdev.c:1059:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/evdev.c:1059:21: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:1066:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *ip @@
   drivers/input/evdev.c:1066:21: sparse:     expected int *__ptr_clean
   drivers/input/evdev.c:1066:21: sparse:     got int [noderef] __user *ip
   drivers/input/evdev.c:1066:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/input/evdev.c:1066:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:1066:21: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:1068:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/input/evdev.c:1068:21: sparse:     expected int *__ptr_clean
   drivers/input/evdev.c:1068:21: sparse:     got int [noderef] __user *
   drivers/input/evdev.c:1068:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/input/evdev.c:1068:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:1068:21: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:1082:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *ip @@
   drivers/input/evdev.c:1082:21: sparse:     expected int *__ptr_clean
   drivers/input/evdev.c:1082:21: sparse:     got int [noderef] __user *ip
   drivers/input/evdev.c:1082:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/input/evdev.c:1082:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:1082:21: sparse:     got int *__ptr_clean
   drivers/input/evdev.c:1082:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/input/evdev.c:1082:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/evdev.c:1082:21: sparse:     got int *__ptr_clean
>> drivers/input/evdev.c:1187:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed short *__ptr_clean @@     got signed short [noderef] __user * @@
   drivers/input/evdev.c:1187:21: sparse:     expected signed short *__ptr_clean
   drivers/input/evdev.c:1187:21: sparse:     got signed short [noderef] __user *
>> drivers/input/evdev.c:1187:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed short *__ptr_clean @@
   drivers/input/evdev.c:1187:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/evdev.c:1187:21: sparse:     got signed short *__ptr_clean
>> drivers/input/evdev.c:1187:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed short *__ptr_clean @@
   drivers/input/evdev.c:1187:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/input/evdev.c:1187:21: sparse:     got signed short *__ptr_clean
--
>> drivers/mtd/mtdchar.c:409:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *retp @@
   drivers/mtd/mtdchar.c:409:13: sparse:     expected unsigned int *__ptr_clean
   drivers/mtd/mtdchar.c:409:13: sparse:     got unsigned int [noderef] [usertype] __user *retp
>> drivers/mtd/mtdchar.c:409:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/mtd/mtdchar.c:409:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/mtdchar.c:409:13: sparse:     got unsigned int *__ptr_clean
>> drivers/mtd/mtdchar.c:409:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/mtd/mtdchar.c:409:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/mtd/mtdchar.c:409:13: sparse:     got unsigned int *__ptr_clean
>> drivers/mtd/mtdchar.c:754:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/mtd/mtdchar.c:754:21: sparse:     expected unsigned int *__ptr_clean
   drivers/mtd/mtdchar.c:754:21: sparse:     got unsigned int [noderef] __user *
   drivers/mtd/mtdchar.c:754:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/mtd/mtdchar.c:754:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/mtdchar.c:754:21: sparse:     got unsigned int *__ptr_clean
   drivers/mtd/mtdchar.c:762:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/mtd/mtdchar.c:762:21: sparse:     expected unsigned int *__ptr_clean
   drivers/mtd/mtdchar.c:762:21: sparse:     got unsigned int [noderef] __user *
   drivers/mtd/mtdchar.c:762:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/mtd/mtdchar.c:762:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/mtdchar.c:762:21: sparse:     got unsigned int *__ptr_clean
   drivers/mtd/mtdchar.c:762:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/mtd/mtdchar.c:762:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/mtd/mtdchar.c:762:21: sparse:     got unsigned int *__ptr_clean
   drivers/mtd/mtdchar.c:763:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/mtd/mtdchar.c:763:24: sparse:     expected unsigned int *__ptr_clean
   drivers/mtd/mtdchar.c:763:24: sparse:     got unsigned int [noderef] __user *
   drivers/mtd/mtdchar.c:763:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/mtd/mtdchar.c:763:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/mtdchar.c:763:24: sparse:     got unsigned int *__ptr_clean
   drivers/mtd/mtdchar.c:763:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/mtd/mtdchar.c:763:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/mtd/mtdchar.c:763:24: sparse:     got unsigned int *__ptr_clean
   drivers/mtd/mtdchar.c:764:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/mtd/mtdchar.c:764:24: sparse:     expected unsigned int *__ptr_clean
   drivers/mtd/mtdchar.c:764:24: sparse:     got unsigned int [noderef] __user *
   drivers/mtd/mtdchar.c:764:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/mtd/mtdchar.c:764:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/mtdchar.c:764:24: sparse:     got unsigned int *__ptr_clean
   drivers/mtd/mtdchar.c:764:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/mtd/mtdchar.c:764:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/mtd/mtdchar.c:764:24: sparse:     got unsigned int *__ptr_clean
--
>> kernel/time/time.c:112:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user *tloc @@
   kernel/time/time.c:112:21: sparse:     expected signed int *__ptr_clean
   kernel/time/time.c:112:21: sparse:     got signed int [noderef] [usertype] __user *tloc
   kernel/time/time.c:112:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   kernel/time/time.c:112:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:112:21: sparse:     got signed int *__ptr_clean
   kernel/time/time.c:112:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   kernel/time/time.c:112:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/time/time.c:112:21: sparse:     got signed int *__ptr_clean
>> kernel/time/time.c:124:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user *tptr @@
   kernel/time/time.c:124:13: sparse:     expected signed int *__ptr_clean
   kernel/time/time.c:124:13: sparse:     got signed int [noderef] [usertype] __user *tptr
   kernel/time/time.c:124:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   kernel/time/time.c:124:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:124:13: sparse:     got signed int *__ptr_clean
>> kernel/time/time.c:147:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   kernel/time/time.c:147:21: sparse:     expected long *__ptr_clean
   kernel/time/time.c:147:21: sparse:     got long [noderef] __user *
   kernel/time/time.c:147:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/time/time.c:147:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:147:21: sparse:     got long *__ptr_clean
   kernel/time/time.c:147:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   kernel/time/time.c:147:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/time/time.c:147:21: sparse:     got long *__ptr_clean
   kernel/time/time.c:148:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   kernel/time/time.c:148:21: sparse:     expected long *__ptr_clean
   kernel/time/time.c:148:21: sparse:     got long [noderef] __user *
   kernel/time/time.c:148:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/time/time.c:148:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:148:21: sparse:     got long *__ptr_clean
   kernel/time/time.c:148:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   kernel/time/time.c:148:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/time/time.c:148:21: sparse:     got long *__ptr_clean
   kernel/time/time.c:206:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   kernel/time/time.c:206:21: sparse:     expected long *__ptr_clean
   kernel/time/time.c:206:21: sparse:     got long [noderef] __user *
   kernel/time/time.c:206:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/time/time.c:206:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:206:21: sparse:     got long *__ptr_clean
   kernel/time/time.c:207:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   kernel/time/time.c:207:21: sparse:     expected long *__ptr_clean
   kernel/time/time.c:207:21: sparse:     got long [noderef] __user *
   kernel/time/time.c:207:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/time/time.c:207:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:207:21: sparse:     got long *__ptr_clean
--
>> net/ipv6/ipv6_sockglue.c:1087:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     expected int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     got int [noderef] __user *optlen
   net/ipv6/ipv6_sockglue.c:1087:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1087:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1105:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/ipv6_sockglue.c:1105:13: sparse:     expected int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1105:13: sparse:     got int [noderef] __user *optlen
   net/ipv6/ipv6_sockglue.c:1105:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1105:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1105:13: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1128:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     expected int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     got int [noderef] __user *optlen
   net/ipv6/ipv6_sockglue.c:1128:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1128:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     got int *__ptr_clean
>> net/ipv6/ipv6_sockglue.c:1129:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     expected unsigned int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     got unsigned int [noderef] __user *
   net/ipv6/ipv6_sockglue.c:1129:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     got unsigned int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1129:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     got unsigned int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1130:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     expected unsigned int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     got unsigned int [noderef] __user *
   net/ipv6/ipv6_sockglue.c:1130:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     got unsigned int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1130:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     got unsigned int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1145:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/ipv6_sockglue.c:1145:13: sparse:     expected int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1145:13: sparse:     got int [noderef] __user *optlen
   net/ipv6/ipv6_sockglue.c:1145:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1145:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1145:13: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1215:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     expected int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     got int [noderef] __user *optlen
   net/ipv6/ipv6_sockglue.c:1215:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1215:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1275:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     expected int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     got int [noderef] __user *optlen
   net/ipv6/ipv6_sockglue.c:1275:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1275:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1329:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     expected int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     got int [noderef] __user *optlen
   net/ipv6/ipv6_sockglue.c:1329:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1329:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1423:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     expected int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     got int [noderef] __user *optlen
   net/ipv6/ipv6_sockglue.c:1423:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1423:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1477:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     expected int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     got int [noderef] __user *optlen
   net/ipv6/ipv6_sockglue.c:1477:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1477:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     got int *__ptr_clean
--
>> net/ipv6/raw.c:998:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/raw.c:998:21: sparse:     expected int *__ptr_clean
   net/ipv6/raw.c:998:21: sparse:     got int [noderef] __user *optlen
   net/ipv6/raw.c:998:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:998:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:998:21: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1004:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/raw.c:1004:21: sparse:     expected int *__ptr_clean
   net/ipv6/raw.c:1004:21: sparse:     got int [noderef] __user *optlen
   net/ipv6/raw.c:1004:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1004:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:1004:21: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1004:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1004:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/raw.c:1004:21: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1096:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/raw.c:1096:13: sparse:     expected int *__ptr_clean
   net/ipv6/raw.c:1096:13: sparse:     got int [noderef] __user *optlen
   net/ipv6/raw.c:1096:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1096:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:1096:13: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1121:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ipv6/raw.c:1121:13: sparse:     expected int *__ptr_clean
   net/ipv6/raw.c:1121:13: sparse:     got int [noderef] __user *optlen
   net/ipv6/raw.c:1121:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1121:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:1121:13: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1121:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1121:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/raw.c:1121:13: sparse:     got int *__ptr_clean
>> net/ipv6/raw.c:1157:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/ipv6/raw.c:1157:24: sparse:     expected int *__ptr_clean
   net/ipv6/raw.c:1157:24: sparse:     got int [noderef] __user *
   net/ipv6/raw.c:1157:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1157:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:1157:24: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1157:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1157:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/raw.c:1157:24: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1168:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/ipv6/raw.c:1168:24: sparse:     expected int *__ptr_clean
   net/ipv6/raw.c:1168:24: sparse:     got int [noderef] __user *
   net/ipv6/raw.c:1168:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1168:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:1168:24: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1168:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1168:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/raw.c:1168:24: sparse:     got int *__ptr_clean
--
>> net/ipv6/sit.c:361:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   net/ipv6/sit.c:361:54: sparse:     expected unsigned int *__ptr_clean
   net/ipv6/sit.c:361:54: sparse:     got unsigned int [noderef] __user *
   net/ipv6/sit.c:361:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ipv6/sit.c:361:54: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/sit.c:361:54: sparse:     got unsigned int *__ptr_clean
   net/ipv6/sit.c:361:54: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/ipv6/sit.c:361:54: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/sit.c:361:54: sparse:     got unsigned int *__ptr_clean
--
>> net/packet/af_packet.c:4019:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/packet/af_packet.c:4019:13: sparse:     expected int *__ptr_clean
   net/packet/af_packet.c:4019:13: sparse:     got int [noderef] __user *optlen
   net/packet/af_packet.c:4019:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4019:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/packet/af_packet.c:4019:13: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:4119:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/packet/af_packet.c:4119:13: sparse:     expected int *__ptr_clean
   net/packet/af_packet.c:4119:13: sparse:     got int [noderef] __user *optlen
   net/packet/af_packet.c:4119:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4119:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/packet/af_packet.c:4119:13: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:4119:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4119:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/packet/af_packet.c:4119:13: sparse:     got int *__ptr_clean
>> net/packet/af_packet.c:4187:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/packet/af_packet.c:4187:24: sparse:     expected int *__ptr_clean
   net/packet/af_packet.c:4187:24: sparse:     got int [noderef] __user *
   net/packet/af_packet.c:4187:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4187:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/packet/af_packet.c:4187:24: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:4187:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4187:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/packet/af_packet.c:4187:24: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:4199:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/packet/af_packet.c:4199:24: sparse:     expected int *__ptr_clean
   net/packet/af_packet.c:4199:24: sparse:     got int [noderef] __user *
   net/packet/af_packet.c:4199:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4199:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/packet/af_packet.c:4199:24: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:4199:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4199:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/packet/af_packet.c:4199:24: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:1050:13: sparse: sparse: context imbalance in '__packet_lookup_frame_in_block' - different lock contexts for basic block
   net/packet/af_packet.c:2480:17: sparse: sparse: context imbalance in 'tpacket_rcv' - unexpected unlock
--
>> net/sunrpc/cache.c:1003:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/sunrpc/cache.c:1003:16: sparse:     expected int *__ptr_clean
   net/sunrpc/cache.c:1003:16: sparse:     got int [noderef] __user *
   net/sunrpc/cache.c:1003:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sunrpc/cache.c:1003:16: sparse:     expected void const volatile [noderef] __user *ptr
   net/sunrpc/cache.c:1003:16: sparse:     got int *__ptr_clean
   net/sunrpc/cache.c:1003:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sunrpc/cache.c:1003:16: sparse:     expected void [noderef] __user *__ptr_pu
   net/sunrpc/cache.c:1003:16: sparse:     got int *__ptr_clean
--
>> net/sunrpc/rpc_pipe.c:380:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/sunrpc/rpc_pipe.c:380:24: sparse:     expected int *__ptr_clean
   net/sunrpc/rpc_pipe.c:380:24: sparse:     got int [noderef] __user *
   net/sunrpc/rpc_pipe.c:380:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sunrpc/rpc_pipe.c:380:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/sunrpc/rpc_pipe.c:380:24: sparse:     got int *__ptr_clean
   net/sunrpc/rpc_pipe.c:380:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sunrpc/rpc_pipe.c:380:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/sunrpc/rpc_pipe.c:380:24: sparse:     got int *__ptr_clean

vim +107 net/ethtool/ioctl.c

^1da177e4c3f415 net/core/ethtool.c  Linus Torvalds      2005-04-16   83  
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15   84  static int ethtool_get_features(struct net_device *dev, void __user *useraddr)
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15   85  {
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15   86  	struct ethtool_gfeatures cmd = {
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15   87  		.cmd = ETHTOOL_GFEATURES,
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15   88  		.size = ETHTOOL_DEV_FEATURE_WORDS,
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15   89  	};
475414f6f20cb12 net/core/ethtool.c  Michał Mirosław     2011-11-15   90  	struct ethtool_get_features_block features[ETHTOOL_DEV_FEATURE_WORDS];
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15   91  	u32 __user *sizeaddr;
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15   92  	u32 copy_size;
475414f6f20cb12 net/core/ethtool.c  Michał Mirosław     2011-11-15   93  	int i;
475414f6f20cb12 net/core/ethtool.c  Michał Mirosław     2011-11-15   94  
475414f6f20cb12 net/core/ethtool.c  Michał Mirosław     2011-11-15   95  	/* in case feature bits run out again */
475414f6f20cb12 net/core/ethtool.c  Michał Mirosław     2011-11-15   96  	BUILD_BUG_ON(ETHTOOL_DEV_FEATURE_WORDS * sizeof(u32) > sizeof(netdev_features_t));
475414f6f20cb12 net/core/ethtool.c  Michał Mirosław     2011-11-15   97  
475414f6f20cb12 net/core/ethtool.c  Michał Mirosław     2011-11-15   98  	for (i = 0; i < ETHTOOL_DEV_FEATURE_WORDS; ++i) {
475414f6f20cb12 net/core/ethtool.c  Michał Mirosław     2011-11-15   99  		features[i].available = (u32)(dev->hw_features >> (32 * i));
475414f6f20cb12 net/core/ethtool.c  Michał Mirosław     2011-11-15  100  		features[i].requested = (u32)(dev->wanted_features >> (32 * i));
475414f6f20cb12 net/core/ethtool.c  Michał Mirosław     2011-11-15  101  		features[i].active = (u32)(dev->features >> (32 * i));
09da71b1212f900 net/core/ethtool.c  Michał Mirosław     2011-11-16  102  		features[i].never_changed =
09da71b1212f900 net/core/ethtool.c  Michał Mirosław     2011-11-16  103  			(u32)(NETIF_F_NEVER_CHANGE >> (32 * i));
475414f6f20cb12 net/core/ethtool.c  Michał Mirosław     2011-11-15  104  	}
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  105  
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  106  	sizeaddr = useraddr + offsetof(struct ethtool_gfeatures, size);
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15 @107  	if (get_user(copy_size, sizeaddr))
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  108  		return -EFAULT;
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  109  
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  110  	if (copy_size > ETHTOOL_DEV_FEATURE_WORDS)
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  111  		copy_size = ETHTOOL_DEV_FEATURE_WORDS;
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  112  
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  113  	if (copy_to_user(useraddr, &cmd, sizeof(cmd)))
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  114  		return -EFAULT;
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  115  	useraddr += sizeof(cmd);
ed717613f972453 net/ethtool/ioctl.c Gustavo A. R. Silva 2021-09-28  116  	if (copy_to_user(useraddr, features,
ed717613f972453 net/ethtool/ioctl.c Gustavo A. R. Silva 2021-09-28  117  			 array_size(copy_size, sizeof(*features))))
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  118  		return -EFAULT;
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  119  
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  120  	return 0;
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  121  }
5455c6998d34dc9 net/core/ethtool.c  Michał Mirosław     2011-02-15  122  

:::::: The code at line 107 was first introduced by commit
:::::: 5455c6998d34dc983a8693500e4dffefc3682dc5 net: Introduce new feature setting ops

:::::: TO: Michał Mirosław <mirq-linux@rere.qmqm.pl>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
