Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3617C515FD4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbiD3ShE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiD3ShB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 14:37:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F772FE45
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651343616; x=1682879616;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6g093YqxLQv/G6jqchP9C0z36ezLwjRjnuax+x9VfJA=;
  b=Cn/htXhsstgXW1OwYpeIMKxEqJANoNOAqUx7O1VHJwBZoHgS3N38j+Ta
   Vo+G8608gqk2/NybymiQuLnNMK9PrItwvgNq8LRmLsasSX/MvXf3pdGcm
   kuafJIIBw1ATwoGeFLnX2vSwicQFuAQQiad/oTa6MWeY7kwDlcAo+PH46
   tPwq29+i99AMP0xShTPojLmjgsuHV/H6s5gqH61AkJgslLJc4aNdaUEyh
   YWPoJ/Wygt9Rv3Uu9VDBPFOWgNYvlhdQ7P5wqaZ2QZkFWUGi5IazciJBr
   XacuvJ7/YTvpXYSpG5rd1JUFpcb+rf5+HCRMNIry9eXrPgW9fY+RVCVZ6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="353339558"
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="353339558"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 11:33:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="535071493"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Apr 2022 11:33:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkruL-0007VD-7v;
        Sat, 30 Apr 2022 18:33:29 +0000
Date:   Sun, 1 May 2022 02:32:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 6/10] arch/x86/entry/common.c:161:23: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202205010252.k0GSQM4i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   956305b67dd062e5a58c68c871dee2ee1d579feb
commit: 2d7493c0421d267a906653b33aca69bf87f0595f [6/10] x86/uaccess: Remove tags from the address before checking
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220501/202205010252.k0GSQM4i-lkp@intel.com/config)
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
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/entry/common.c:161:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/entry/common.c:161:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/entry/common.c:161:23: sparse:     got unsigned int *
--
>> arch/x86/kvm/../../../virt/kvm/vfio.c:196:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   arch/x86/kvm/../../../virt/kvm/vfio.c:196:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   arch/x86/kvm/../../../virt/kvm/vfio.c:196:21: sparse:     got signed int *
   arch/x86/kvm/../../../virt/kvm/vfio.c:240:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   arch/x86/kvm/../../../virt/kvm/vfio.c:240:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   arch/x86/kvm/../../../virt/kvm/vfio.c:240:21: sparse:     got signed int *
--
   arch/x86/kvm/x86.c:241:47: sparse: sparse: array of flexible structures
   arch/x86/kvm/x86.c: note: in included file:
   include/linux/kvm_host.h:1882:54: sparse: sparse: array of flexible structures
   arch/x86/kvm/x86.c:267:49: sparse: sparse: array of flexible structures
   include/linux/kvm_host.h:1884:56: sparse: sparse: array of flexible structures
>> arch/x86/kvm/x86.c:4404:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   arch/x86/kvm/x86.c:4404:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   arch/x86/kvm/x86.c:4404:21: sparse:     got unsigned long long *
   arch/x86/kvm/x86.c:5141:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   arch/x86/kvm/x86.c:5141:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   arch/x86/kvm/x86.c:5141:21: sparse:     got unsigned long long *
   arch/x86/kvm/x86.c:5169:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   arch/x86/kvm/x86.c:5169:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   arch/x86/kvm/x86.c:5169:21: sparse:     got unsigned long long *
>> arch/x86/kvm/x86.c:5602:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kvm/x86.c:5602:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kvm/x86.c:5602:21: sparse:     got unsigned int *
   arch/x86/kvm/x86.c:5611:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kvm/x86.c:5611:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kvm/x86.c:5611:29: sparse:     got unsigned int *
   arch/x86/kvm/x86.c:2875:9: sparse: sparse: context imbalance in '__kvm_start_pvclock_update' - wrong count at exit
   arch/x86/kvm/x86.c:2886:13: sparse: sparse: context imbalance in 'kvm_end_pvclock_update' - unexpected unlock
   arch/x86/kvm/x86.c: note: in included file (through include/linux/notifier.h, arch/x86/include/asm/uprobes.h, include/linux/uprobes.h, ...):
   include/linux/srcu.h:189:9: sparse: sparse: context imbalance in 'vcpu_enter_guest' - unexpected unlock
   include/linux/srcu.h:189:9: sparse: sparse: context imbalance in 'vcpu_run' - unexpected unlock
--
   arch/x86/kernel/ptrace.c:741:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   arch/x86/kernel/ptrace.c:741:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   arch/x86/kernel/ptrace.c:741:23: sparse:     got unsigned long *
>> arch/x86/kernel/ptrace.c:1057:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/ptrace.c:1057:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/ptrace.c:1057:31: sparse:     got unsigned int *
--
>> arch/x86/kernel/tls.c:138:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/tls.c:138:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/tls.c:138:21: sparse:     got unsigned int *
   arch/x86/kernel/tls.c:220:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/tls.c:220:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/tls.c:220:26: sparse:     got unsigned int *
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
   kernel/ptrace.c:1071:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/ptrace.c:1071:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/ptrace.c:1071:23: sparse:     got unsigned long *
   kernel/ptrace.c:1131:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1131:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1131:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1133:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1133:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1133:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1346:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/ptrace.c:1346:16: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/ptrace.c:1346:16: sparse:     got unsigned long *
>> kernel/ptrace.c:1377:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/ptrace.c:1377:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/ptrace.c:1377:31: sparse:     got unsigned int *
   kernel/ptrace.c:1388:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/ptrace.c:1388:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/ptrace.c:1388:23: sparse:     got unsigned int *
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
   kernel/signal.c:3616:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4070:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4070:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4070:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4082:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4082:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4082:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4100:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *k @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:4100:11: sparse:     expected struct k_sigaction *k
   kernel/signal.c:4100:11: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:4102:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4102:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4102:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4104:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4104:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4104:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4152:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4152:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4152:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:69:34: sparse: sparse: dereference of noderef expression
   kernel/signal.c:529:35: sparse: sparse: dereference of noderef expression
   kernel/signal.c:557:52: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1034:13: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file:
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:21:13: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:     got struct wait_queue_head [noderef] __rcu *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:22:17: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:     got struct wait_queue_head [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1301:9: sparse: sparse: context imbalance in 'do_send_sig_info' - different lock contexts for basic block
   kernel/signal.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:723:9: sparse: sparse: context imbalance in '__lock_task_sighand' - different lock contexts for basic block
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c: note: in included file:
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:21:13: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:     got struct wait_queue_head [noderef] __rcu *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:22:17: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:     got struct wait_queue_head [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:725:9: sparse: sparse: context imbalance in 'send_sigqueue' - wrong count at exit
   kernel/signal.c:2059:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2059:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2391:13: sparse: sparse: context imbalance in 'do_signal_stop' - different lock contexts for basic block
   kernel/signal.c:2597:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2597:49: sparse: sparse: dereference of noderef expression
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2717:33: sparse: sparse: context imbalance in 'get_signal' - unexpected unlock
   kernel/signal.c:4071:33: sparse: sparse: dereference of noderef expression
   kernel/signal.c:4160:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4160:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4160:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4166:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4166:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4166:33: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/signal.c:4349:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4349:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4349:16: sparse:     got unsigned int *
>> kernel/signal.c:4456:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   kernel/signal.c:4456:23: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   kernel/signal.c:4456:23: sparse:     got unsigned int const *
   kernel/signal.c:4459:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   kernel/signal.c:4459:24: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   kernel/signal.c:4459:24: sparse:     got unsigned int const *
   kernel/signal.c:4463:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   kernel/signal.c:4463:24: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   kernel/signal.c:4463:24: sparse:     got unsigned int const *
   kernel/signal.c:4470:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4470:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4470:23: sparse:     got unsigned int *
   kernel/signal.c:4474:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4474:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4474:24: sparse:     got unsigned int *
   kernel/signal.c:4476:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4476:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4476:24: sparse:     got unsigned int *
--
>> kernel/uid16.c:125:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:125:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:125:21: sparse:     got unsigned short *
   kernel/uid16.c:141:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:141:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:141:21: sparse:     got unsigned short *
   kernel/uid16.c:74:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:74:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:74:26: sparse:     got unsigned short *
   kernel/uid16.c:75:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:75:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:75:26: sparse:     got unsigned short *
   kernel/uid16.c:76:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:76:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:76:26: sparse:     got unsigned short *
   kernel/uid16.c:97:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:97:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:97:26: sparse:     got unsigned short *
   kernel/uid16.c:98:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:98:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:98:26: sparse:     got unsigned short *
   kernel/uid16.c:99:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:99:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:99:26: sparse:     got unsigned short *
--
>> kernel/compat.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/compat.c:50:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/compat.c:50:21: sparse:     got unsigned int *
   kernel/compat.c:74:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/compat.c:74:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/compat.c:74:21: sparse:     got unsigned int *
--
>> mm/mempolicy.c:1696:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   mm/mempolicy.c:1696:23: sparse:     expected int [noderef] __user *__ptr_clean
   mm/mempolicy.c:1696:23: sparse:     got int *
   mm/mempolicy.c:517:17: sparse: sparse: context imbalance in 'queue_pages_pte_range' - unexpected unlock
--
>> mm/migrate.c:1569:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   mm/migrate.c:1569:21: sparse:     expected int [noderef] __user *__ptr_clean
   mm/migrate.c:1569:21: sparse:     got int *
>> mm/migrate.c:1714:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *[noderef] __user *__ptr_clean @@     got void const [noderef] __user ** @@
   mm/migrate.c:1714:21: sparse:     expected void const [noderef] __user *[noderef] __user *__ptr_clean
   mm/migrate.c:1714:21: sparse:     got void const [noderef] __user **
>> mm/migrate.c:1716:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__ptr_clean @@     got int const * @@
   mm/migrate.c:1716:21: sparse:     expected int const [noderef] __user *__ptr_clean
   mm/migrate.c:1716:21: sparse:     got int const *
>> mm/migrate.c:1833:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   mm/migrate.c:1833:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   mm/migrate.c:1833:21: sparse:     got unsigned int *
   mm/migrate.c:283:6: sparse: sparse: context imbalance in '__migration_entry_wait' - different lock contexts for basic block
   mm/migrate.c:320:6: sparse: sparse: context imbalance in 'pmd_migration_entry_wait' - different lock contexts for basic block
   mm/migrate.c:722:9: sparse: sparse: context imbalance in '__buffer_migrate_page' - different lock contexts for basic block
--
>> fs/exec.c:413:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   fs/exec.c:413:21: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   fs/exec.c:413:21: sparse:     got unsigned int const *
   fs/exec.c:414:39: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __user * @@     got void * @@
   fs/exec.c:414:39: sparse:     expected char const [noderef] __user *
   fs/exec.c:414:39: sparse:     got void *
   fs/exec.c:420:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *const [noderef] __user *__ptr_clean @@     got char const [noderef] __user *const * @@
   fs/exec.c:420:13: sparse:     expected char const [noderef] __user *const [noderef] __user *__ptr_clean
   fs/exec.c:420:13: sparse:     got char const [noderef] __user *const *
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
   fs/read_write.c:1285:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/read_write.c:1285:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/read_write.c:1285:21: sparse:     got long *
   fs/read_write.c:1289:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/read_write.c:1289:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/read_write.c:1289:21: sparse:     got long *
   fs/read_write.c:1306:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long long [noderef] __user *__ptr_clean @@     got long long * @@
   fs/read_write.c:1306:21: sparse:     expected long long [noderef] __user *__ptr_clean
   fs/read_write.c:1306:21: sparse:     got long long *
>> fs/read_write.c:1323:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/read_write.c:1323:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/read_write.c:1323:21: sparse:     got signed int *
   fs/read_write.c:1327:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/read_write.c:1327:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/read_write.c:1327:21: sparse:     got signed int *
>> fs/read_write.c:1345:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/read_write.c:1345:21: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/read_write.c:1345:21: sparse:     got signed long long *
--
   fs/readdir.c:293:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/readdir.c:293:21: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/readdir.c:293:21: sparse:     got unsigned long *
   fs/readdir.c:377:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/readdir.c:377:21: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/readdir.c:377:21: sparse:     got signed long long *
>> fs/readdir.c:544:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/readdir.c:544:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/readdir.c:544:21: sparse:     got unsigned int *
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
>> fs/aio.c:1081:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:1081:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:1081:13: sparse:     got unsigned int *
   fs/aio.c:1961:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:1961:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:1961:13: sparse:     got unsigned int *
>> fs/aio.c:1344:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/aio.c:1344:15: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/aio.c:1344:15: sparse:     got unsigned long *
   fs/aio.c:1358:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/aio.c:1358:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/aio.c:1358:23: sparse:     got unsigned long *
   fs/aio.c:1375:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:1375:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:1375:15: sparse:     got unsigned int *
   fs/aio.c:1390:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:1390:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:1390:23: sparse:     got unsigned int *
   fs/aio.c:1656:13: sparse: sparse: context imbalance in 'poll_iocb_lock_wq' - different lock contexts for basic block
   fs/aio.c:1687:13: sparse: sparse: context imbalance in 'poll_iocb_unlock_wq' - unexpected unlock
>> fs/aio.c:2076:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct iocb [noderef] __user *[noderef] __user *__ptr_clean @@     got struct iocb [noderef] __user ** @@
   fs/aio.c:2076:21: sparse:     expected struct iocb [noderef] __user *[noderef] __user *__ptr_clean
   fs/aio.c:2076:21: sparse:     got struct iocb [noderef] __user **
   fs/aio.c:2118:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:2118:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:2118:21: sparse:     got unsigned int *
   fs/aio.c:2154:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:2154:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:2154:13: sparse:     got unsigned int *
--
   fs/compat_binfmt_elf.c: note: in included file:
>> fs/binfmt_elf.c:326:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:326:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:326:13: sparse:     got unsigned int *
   fs/binfmt_elf.c:333:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:333:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:333:21: sparse:     got unsigned int *
   fs/binfmt_elf.c:340:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:340:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:340:13: sparse:     got unsigned int *
   fs/binfmt_elf.c:348:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:348:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:348:21: sparse:     got unsigned int *
   fs/binfmt_elf.c:355:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:355:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:355:13: sparse:     got unsigned int *
--
>> drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:415:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:415:21: sparse:     got int *
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:419:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:419:32: sparse:     got int *
>> drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/scsi/sg.c:425:32: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:425:32: sparse:     got signed int *
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:431:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:431:32: sparse:     got int *
>> drivers/scsi/sg.c:641:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/scsi/sg.c:641:13: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:641:13: sparse:     got char const *
>> drivers/scsi/sg.c:909:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/sg.c:909:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:909:21: sparse:     got unsigned int *
   drivers/scsi/sg.c:910:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/sg.c:910:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:910:21: sparse:     got unsigned int *
   drivers/scsi/sg.c:911:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:911:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:911:21: sparse:     got int *
   drivers/scsi/sg.c:956:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:956:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:956:26: sparse:     got int *
   drivers/scsi/sg.c:979:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:979:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:979:24: sparse:     got int *
   drivers/scsi/sg.c:999:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:999:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:999:26: sparse:     got int *
   drivers/scsi/sg.c:1010:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1010:40: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1010:40: sparse:     got int *
   drivers/scsi/sg.c:1014:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1014:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1014:24: sparse:     got int *
   drivers/scsi/sg.c:1023:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1023:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1023:24: sparse:     got int *
   drivers/scsi/sg.c:1025:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1025:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1025:24: sparse:     got int *
   drivers/scsi/sg.c:1027:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1027:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1027:26: sparse:     got int *
   drivers/scsi/sg.c:1050:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1050:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1050:24: sparse:     got int *
   drivers/scsi/sg.c:1052:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1052:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1052:26: sparse:     got int *
   drivers/scsi/sg.c:1058:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1058:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1058:24: sparse:     got int *
   drivers/scsi/sg.c:1060:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1060:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1060:26: sparse:     got int *
   drivers/scsi/sg.c:1066:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1066:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1066:24: sparse:     got int *
   drivers/scsi/sg.c:1068:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1068:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1068:26: sparse:     got int *
   drivers/scsi/sg.c:1076:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1076:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1076:24: sparse:     got int *
   drivers/scsi/sg.c:1080:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1080:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1080:24: sparse:     got int *
   drivers/scsi/sg.c:1106:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1106:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1106:24: sparse:     got int *
   drivers/scsi/sg.c:1112:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1112:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1112:26: sparse:     got int *
   drivers/scsi/sg.c:1118:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1118:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1118:24: sparse:     got int *
--
>> ipc/msg.c:679:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   ipc/msg.c:679:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   ipc/msg.c:679:21: sparse:     got unsigned int *
>> ipc/msg.c:685:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   ipc/msg.c:685:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   ipc/msg.c:685:21: sparse:     got unsigned short *
   ipc/msg.c:960:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   ipc/msg.c:960:13: sparse:     expected long [noderef] __user *__ptr_clean
   ipc/msg.c:960:13: sparse:     got long *
>> ipc/msg.c:984:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   ipc/msg.c:984:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   ipc/msg.c:984:13: sparse:     got signed int *
   ipc/msg.c:1025:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   ipc/msg.c:1025:13: sparse:     expected long [noderef] __user *__ptr_clean
   ipc/msg.c:1025:13: sparse:     got long *
   ipc/msg.c:1276:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   ipc/msg.c:1276:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   ipc/msg.c:1276:13: sparse:     got signed int *
   ipc/msg.c:180:26: sparse: sparse: context imbalance in 'newque' - unexpected unlock
--
>> ipc/syscall.c:153:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   ipc/syscall.c:153:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   ipc/syscall.c:153:21: sparse:     got unsigned int *
   ipc/syscall.c:192:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   ipc/syscall.c:192:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   ipc/syscall.c:192:24: sparse:     got unsigned int *
--
>> ipc/mqueue.c:1261:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   ipc/mqueue.c:1261:36: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   ipc/mqueue.c:1261:36: sparse:     got unsigned int *
--
>> kernel/power/user.c:298:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/power/user.c:298:33: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/power/user.c:298:33: sparse:     got int *
>> kernel/power/user.c:340:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long long [noderef] __user *__ptr_clean @@     got long long * @@
   kernel/power/user.c:340:25: sparse:     expected long long [noderef] __user *__ptr_clean
   kernel/power/user.c:340:25: sparse:     got long long *
   kernel/power/user.c:346:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long long [noderef] __user *__ptr_clean @@     got long long * @@
   kernel/power/user.c:346:25: sparse:     expected long long [noderef] __user *__ptr_clean
   kernel/power/user.c:346:25: sparse:     got long long *
   kernel/power/user.c:357:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long long [noderef] __user *__ptr_clean @@     got long long * @@
   kernel/power/user.c:357:33: sparse:     expected long long [noderef] __user *__ptr_clean
   kernel/power/user.c:357:33: sparse:     got long long *
--
>> net/ipv6/ip6mr.c:1856:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ip6mr.c:1856:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ip6mr.c:1856:13: sparse:     got int *
   net/ipv6/ip6mr.c:1863:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ip6mr.c:1863:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ip6mr.c:1863:13: sparse:     got int *
   net/ipv6/ip6mr.c:400:13: sparse: sparse: context imbalance in 'ip6mr_vif_seq_start' - different lock contexts for basic block
   net/ipv6/ip6mr.c: note: in included file (through include/linux/mroute6.h):
   include/linux/mroute_base.h:429:31: sparse: sparse: context imbalance in 'mr_mfc_seq_stop' - unexpected unlock
--
>> net/ipv6/af_inet6.c:611:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:611:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:611:13: sparse:     got unsigned int *
>> net/ipv6/af_inet6.c:612:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv6/af_inet6.c:612:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:612:13: sparse:     got unsigned short *
   net/ipv6/af_inet6.c:613:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv6/af_inet6.c:613:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:613:13: sparse:     got unsigned short *
   net/ipv6/af_inet6.c:614:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:614:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:614:13: sparse:     got unsigned int *
   net/ipv6/af_inet6.c:615:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:615:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:615:13: sparse:     got unsigned int *
   net/ipv6/af_inet6.c:616:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:616:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:616:13: sparse:     got unsigned int *
>> net/ipv6/af_inet6.c:617:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   net/ipv6/af_inet6.c:617:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:617:13: sparse:     got signed int *
--
>> net/ipv6/netfilter/ip6_tables.c:1265:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv6/netfilter/ip6_tables.c:1265:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv6/netfilter/ip6_tables.c:1265:13: sparse:     got unsigned short *
   net/ipv6/netfilter/ip6_tables.c:1266:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv6/netfilter/ip6_tables.c:1266:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv6/netfilter/ip6_tables.c:1266:13: sparse:     got unsigned short *
   net/ipv6/netfilter/ip6_tables.c:1229:41: sparse: sparse: array of flexible structures
   net/ipv6/netfilter/ip6_tables.c:1550:44: sparse: sparse: array of flexible structures
   net/ipv6/netfilter/ip6_tables.c:42:16: sparse: sparse: Initializer entry defined twice
   net/ipv6/netfilter/ip6_tables.c:42:16: sparse:   also defined here
   net/ipv6/netfilter/ip6_tables.c:42:16: sparse: sparse: Initializer entry defined twice
   net/ipv6/netfilter/ip6_tables.c:42:16: sparse:   also defined here
--
>> arch/x86/kernel/cpu/mtrr/if.c:196:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:196:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:196:23: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:197:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:197:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:197:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:198:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:198:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:198:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:208:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:208:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:208:23: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:209:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:209:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:209:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:210:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:210:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:210:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:211:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:211:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:211:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:327:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:327:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:327:23: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:328:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:328:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:328:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:329:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:329:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:329:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:330:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:330:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:330:24: sparse:     got unsigned int *
--
>> drivers/net/tun.c:3049:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/net/tun.c:3049:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/net/tun.c:3049:24: sparse:     got unsigned int *
>> drivers/net/tun.c:3259:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/tun.c:3259:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/tun.c:3259:21: sparse:     got int *
   drivers/net/tun.c:3264:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/tun.c:3264:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/tun.c:3264:21: sparse:     got int *
--
>> drivers/cdrom/cdrom.c:3292:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/cdrom/cdrom.c:3292:24: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/cdrom/cdrom.c:3292:24: sparse:     got signed int *
>> drivers/cdrom/cdrom.c:3294:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   drivers/cdrom/cdrom.c:3294:16: sparse:     expected long [noderef] __user *__ptr_clean
   drivers/cdrom/cdrom.c:3294:16: sparse:     got long *
--
   block/ioctl.c:58:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:58:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:58:13: sparse:     got int *
   block/ioctl.c:58:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   block/ioctl.c:58:39: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   block/ioctl.c:58:39: sparse:     got void [noderef] __user **
>> block/ioctl.c:78:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   block/ioctl.c:78:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   block/ioctl.c:78:13: sparse:     got signed int *
   block/ioctl.c:78:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:78:39: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:78:39: sparse:     got unsigned int *
   block/ioctl.c:170:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   block/ioctl.c:170:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   block/ioctl.c:170:16: sparse:     got unsigned short *
   block/ioctl.c:175:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:175:16: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:175:16: sparse:     got int *
   block/ioctl.c:180:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:180:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:180:16: sparse:     got unsigned int *
   block/ioctl.c:185:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   block/ioctl.c:185:16: sparse:     expected long [noderef] __user *__ptr_clean
   block/ioctl.c:185:16: sparse:     got long *
   block/ioctl.c:190:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   block/ioctl.c:190:16: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   block/ioctl.c:190:16: sparse:     got unsigned long *
   block/ioctl.c:195:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   block/ioctl.c:195:16: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   block/ioctl.c:195:16: sparse:     got unsigned long long *
   block/ioctl.c:201:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   block/ioctl.c:201:16: sparse:     expected signed int [noderef] __user *__ptr_clean
   block/ioctl.c:201:16: sparse:     got signed int *
   block/ioctl.c:206:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:206:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:206:16: sparse:     got unsigned int *
   block/ioctl.c:338:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:338:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:338:13: sparse:     got int *
   block/ioctl.c:406:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:406:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:406:16: sparse:     got unsigned int *
   block/ioctl.c:424:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:424:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:424:13: sparse:     got int *
--
   fs/ext4/ioctl.c:806:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:806:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:806:13: sparse:     got unsigned int *
   fs/ext4/ioctl.c:1163:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
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
   fs/ext4/ioctl.c:1613:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:1613:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1613:23: sparse:     got unsigned int *
>> fs/ext4/ioctl.c:1614:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/ext4/ioctl.c:1614:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1614:24: sparse:     got unsigned long long *
   fs/ext4/ioctl.c:1615:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/ext4/ioctl.c:1615:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1615:24: sparse:     got unsigned long long *
   fs/ext4/ioctl.c:1616:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/ext4/ioctl.c:1616:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1616:24: sparse:     got unsigned long long *
   fs/ext4/ioctl.c:1617:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:1617:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1617:24: sparse:     got unsigned int *
>> fs/ext4/ioctl.c:1618:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/ext4/ioctl.c:1618:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1618:24: sparse:     got unsigned short *
--
>> net/compat.c:157:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/compat.c:157:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/compat.c:157:21: sparse:     got unsigned int *
>> net/compat.c:309:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   net/compat.c:309:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   net/compat.c:309:23: sparse:     got signed int *
   net/compat.c:311:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   net/compat.c:311:31: sparse:     expected signed int [noderef] __user *__ptr_clean
   net/compat.c:311:31: sparse:     got signed int *
   net/compat.c:313:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/compat.c:313:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/compat.c:313:31: sparse:     got unsigned int *
--
   kernel/futex/core.c:648:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:648:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:648:13: sparse:     got unsigned int *
   kernel/futex/core.c:783:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/futex/core.c:783:13: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/futex/core.c:783:13: sparse:     got long *
>> kernel/futex/core.c:878:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   kernel/futex/core.c:878:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   kernel/futex/core.c:878:13: sparse:     got signed int *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
   kernel/futex/core.c:844:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:844:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:844:13: sparse:     got unsigned int *
   kernel/futex/core.c:844:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:844:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:844:13: sparse:     got unsigned int *
   kernel/futex/core.c:844:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:844:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:844:13: sparse:     got unsigned int *
--
   kernel/futex/syscalls.c:75:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/syscalls.c:75:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:75:13: sparse:     got unsigned long *
   kernel/futex/syscalls.c:77:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct robust_list_head [noderef] __user *[noderef] __user *__ptr_clean @@     got struct robust_list_head [noderef] __user ** @@
   kernel/futex/syscalls.c:77:16: sparse:     expected struct robust_list_head [noderef] __user *[noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:77:16: sparse:     got struct robust_list_head [noderef] __user **
>> kernel/futex/syscalls.c:344:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/syscalls.c:344:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:344:13: sparse:     got unsigned int *
   kernel/futex/syscalls.c:346:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/syscalls.c:346:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:346:16: sparse:     got unsigned int *
--
>> drivers/usb/core/devio.c:950:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:950:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:950:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:951:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:951:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:951:13: sparse:     got unsigned int *
>> drivers/usb/core/devio.c:966:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/core/devio.c:966:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:966:21: sparse:     got unsigned char *
   drivers/usb/core/devio.c:1385:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:1385:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:1385:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:1404:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:1404:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:1404:13: sparse:     got unsigned int *
>> drivers/usb/core/devio.c:1536:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/usb/core/devio.c:1536:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:1536:13: sparse:     got int *
   drivers/usb/core/devio.c:2039:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/usb/core/devio.c:2039:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2039:13: sparse:     got int *
   drivers/usb/core/devio.c:2041:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/usb/core/devio.c:2041:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2041:13: sparse:     got int *
   drivers/usb/core/devio.c:2043:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/usb/core/devio.c:2043:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2043:13: sparse:     got int *
   drivers/usb/core/devio.c:2048:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2048:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2048:29: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2051:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2051:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2051:29: sparse:     got unsigned int *
>> drivers/usb/core/devio.c:2057:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   drivers/usb/core/devio.c:2057:13: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2057:13: sparse:     got void [noderef] __user **
   drivers/usb/core/devio.c:2129:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2129:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2129:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2141:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2141:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2141:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2142:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2142:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2142:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2143:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2143:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2143:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2144:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2144:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2144:13: sparse:     got unsigned int *
>> drivers/usb/core/devio.c:2210:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/usb/core/devio.c:2210:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2210:13: sparse:     got signed int *
   drivers/usb/core/devio.c:2212:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/usb/core/devio.c:2212:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2212:13: sparse:     got signed int *
   drivers/usb/core/devio.c:2214:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/usb/core/devio.c:2214:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2214:13: sparse:     got signed int *
   drivers/usb/core/devio.c:2219:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2219:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2219:29: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2222:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2222:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2222:29: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2228:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2228:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2228:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2284:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2284:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2284:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2294:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2294:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2294:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2410:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2410:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2410:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2423:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2423:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2423:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2441:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2441:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2441:13: sparse:     got unsigned int *
--
>> kernel/bpf/cgroup.c:1544:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/bpf/cgroup.c:1544:21: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/bpf/cgroup.c:1544:21: sparse:     got int *
   kernel/bpf/cgroup.c:1576:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/bpf/cgroup.c:1576:21: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/bpf/cgroup.c:1576:21: sparse:     got int *
--
>> drivers/usb/mon/mon_bin.c:928:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:928:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:928:21: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1094:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1100:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1118:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1120:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1173:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1173:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1173:29: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1180:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1180:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1180:21: sparse:     got unsigned int *
--
>> lib/test_user_copy.c:239:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   lib/test_user_copy.c:239:9: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   lib/test_user_copy.c:239:9: sparse:     got unsigned char *
>> lib/test_user_copy.c:239:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   lib/test_user_copy.c:239:9: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   lib/test_user_copy.c:239:9: sparse:     got unsigned char *
>> lib/test_user_copy.c:240:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   lib/test_user_copy.c:240:9: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   lib/test_user_copy.c:240:9: sparse:     got unsigned short *
>> lib/test_user_copy.c:240:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   lib/test_user_copy.c:240:9: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   lib/test_user_copy.c:240:9: sparse:     got unsigned short *
>> lib/test_user_copy.c:241:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   lib/test_user_copy.c:241:9: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   lib/test_user_copy.c:241:9: sparse:     got unsigned int *
>> lib/test_user_copy.c:241:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   lib/test_user_copy.c:241:9: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   lib/test_user_copy.c:241:9: sparse:     got unsigned int *
>> lib/test_user_copy.c:243:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   lib/test_user_copy.c:243:9: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   lib/test_user_copy.c:243:9: sparse:     got unsigned long long *
>> lib/test_user_copy.c:243:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   lib/test_user_copy.c:243:9: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   lib/test_user_copy.c:243:9: sparse:     got unsigned long long *
   lib/test_user_copy.c:302:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   lib/test_user_copy.c:302:9: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   lib/test_user_copy.c:302:9: sparse:     got unsigned char *
   lib/test_user_copy.c:302:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   lib/test_user_copy.c:302:9: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   lib/test_user_copy.c:302:9: sparse:     got unsigned char *
   lib/test_user_copy.c:303:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   lib/test_user_copy.c:303:9: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   lib/test_user_copy.c:303:9: sparse:     got unsigned short *
   lib/test_user_copy.c:303:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   lib/test_user_copy.c:303:9: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   lib/test_user_copy.c:303:9: sparse:     got unsigned short *
   lib/test_user_copy.c:304:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   lib/test_user_copy.c:304:9: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   lib/test_user_copy.c:304:9: sparse:     got unsigned int *
   lib/test_user_copy.c:304:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   lib/test_user_copy.c:304:9: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   lib/test_user_copy.c:304:9: sparse:     got unsigned int *
   lib/test_user_copy.c:306:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   lib/test_user_copy.c:306:9: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   lib/test_user_copy.c:306:9: sparse:     got unsigned long long *
   lib/test_user_copy.c:306:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   lib/test_user_copy.c:306:9: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   lib/test_user_copy.c:306:9: sparse:     got unsigned long long *
--
   drivers/input/serio/serport.c:216:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/input/serio/serport.c:216:21: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/input/serio/serport.c:216:21: sparse:     got unsigned long *
>> drivers/input/serio/serport.c:235:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/input/serio/serport.c:235:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/input/serio/serport.c:235:21: sparse:     got unsigned int *
--
>> drivers/input/serio/serio_raw.c:178:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/input/serio/serio_raw.c:178:29: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/input/serio/serio_raw.c:178:29: sparse:     got char *
>> drivers/input/serio/serio_raw.c:219:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/input/serio/serio_raw.c:219:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/input/serio/serio_raw.c:219:21: sparse:     got char const *
--
>> drivers/input/mousedev.c:683:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/input/mousedev.c:683:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/input/mousedev.c:683:21: sparse:     got char const *
--
>> drivers/input/evdev.c:819:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:819:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:819:13: sparse:     got int *
   drivers/input/evdev.c:854:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:854:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:854:13: sparse:     got int *
   drivers/input/evdev.c:928:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:928:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:928:13: sparse:     got int *
   drivers/input/evdev.c:936:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:936:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:936:21: sparse:     got int *
>> drivers/input/evdev.c:1017:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/input/evdev.c:1017:37: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1017:37: sparse:     got unsigned char *
   drivers/input/evdev.c:1047:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1047:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1047:24: sparse:     got int *
   drivers/input/evdev.c:1057:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1057:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1057:21: sparse:     got int *
   drivers/input/evdev.c:1059:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1059:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1059:21: sparse:     got int *
   drivers/input/evdev.c:1066:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1066:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1066:21: sparse:     got int *
   drivers/input/evdev.c:1068:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1068:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1068:21: sparse:     got int *
   drivers/input/evdev.c:1082:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1082:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1082:21: sparse:     got int *
>> drivers/input/evdev.c:1187:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed short [noderef] __user *__ptr_clean @@     got signed short * @@
   drivers/input/evdev.c:1187:21: sparse:     expected signed short [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1187:21: sparse:     got signed short *
--
>> drivers/input/joydev.c:530:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/input/joydev.c:530:24: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/input/joydev.c:530:24: sparse:     got signed int *
   drivers/input/joydev.c:533:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/input/joydev.c:533:24: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/input/joydev.c:533:24: sparse:     got signed int *
>> drivers/input/joydev.c:536:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/input/joydev.c:536:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/input/joydev.c:536:24: sparse:     got unsigned int *
>> drivers/input/joydev.c:539:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/input/joydev.c:539:24: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/input/joydev.c:539:24: sparse:     got unsigned char *
   drivers/input/joydev.c:542:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/input/joydev.c:542:24: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/input/joydev.c:542:24: sparse:     got unsigned char *
   drivers/input/joydev.c:617:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/input/joydev.c:617:26: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/input/joydev.c:617:26: sparse:     got signed int *
   drivers/input/joydev.c:624:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/input/joydev.c:624:26: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/input/joydev.c:624:26: sparse:     got signed int *
>> drivers/input/joydev.c:682:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   drivers/input/joydev.c:682:26: sparse:     expected long [noderef] __user *__ptr_clean
   drivers/input/joydev.c:682:26: sparse:     got long *
   drivers/input/joydev.c:687:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   drivers/input/joydev.c:687:26: sparse:     expected long [noderef] __user *__ptr_clean
   drivers/input/joydev.c:687:26: sparse:     got long *
--
>> drivers/rtc/dev.c:182:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/dev.c:182:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/dev.c:182:31: sparse:     got unsigned int *
>> drivers/rtc/dev.c:185:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/rtc/dev.c:185:31: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/rtc/dev.c:185:31: sparse:     got unsigned long *
   drivers/rtc/dev.c:367:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/rtc/dev.c:367:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/rtc/dev.c:367:23: sparse:     got unsigned long *
   drivers/rtc/dev.c:480:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/dev.c:480:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/dev.c:480:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-m41t80.c:741:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/rtc/rtc-m41t80.c:741:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-m41t80.c:741:24: sparse:     got int *
   drivers/rtc/rtc-m41t80.c:746:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/rtc/rtc-m41t80.c:746:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-m41t80.c:746:21: sparse:     got int *
   drivers/rtc/rtc-m41t80.c:755:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/rtc/rtc-m41t80.c:755:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-m41t80.c:755:24: sparse:     got int *
--
>> drivers/rtc/rtc-pcf8523.c:332:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-pcf8523.c:332:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-pcf8523.c:332:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-pcf8563.c:288:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rs5c372.c:527:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rs5c372.c:527:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rs5c372.c:527:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rv3029c2.c:463:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rv3029c2.c:463:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rv3029c2.c:463:24: sparse:     got unsigned int *
--
   drivers/i2c/i2c-dev.c:432:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/i2c/i2c-dev.c:432:24: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/i2c/i2c-dev.c:432:24: sparse:     got unsigned long *
>> drivers/i2c/i2c-dev.c:526:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/i2c/i2c-dev.c:526:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/i2c/i2c-dev.c:526:24: sparse:     got unsigned int *
   drivers/i2c/i2c-dev.c:560:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [usertype] *buf @@     got void [noderef] __user * @@
   drivers/i2c/i2c-dev.c:560:50: sparse:     expected unsigned char [usertype] *buf
   drivers/i2c/i2c-dev.c:560:50: sparse:     got void [noderef] __user *
--
   fs/autofs/root.c:820:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:820:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:820:16: sparse:     got int *
   fs/autofs/root.c:827:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:827:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:827:16: sparse:     got int *
   fs/autofs/root.c:798:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/autofs/root.c:798:14: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/autofs/root.c:798:14: sparse:     got unsigned long *
   fs/autofs/root.c:802:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/autofs/root.c:802:14: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/autofs/root.c:802:14: sparse:     got unsigned long *
>> fs/autofs/root.c:773:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/autofs/root.c:773:14: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/autofs/root.c:773:14: sparse:     got unsigned int *
   fs/autofs/root.c:777:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/autofs/root.c:777:14: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/autofs/root.c:777:14: sparse:     got unsigned int *
   fs/autofs/root.c:842:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:842:18: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:842:18: sparse:     got int *
--
>> drivers/media/rc/lirc_dev.c:365:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/rc/lirc_dev.c:365:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/rc/lirc_dev.c:365:23: sparse:     got unsigned int *
   drivers/media/rc/lirc_dev.c:569:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/rc/lirc_dev.c:569:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/rc/lirc_dev.c:569:23: sparse:     got unsigned int *
--
>> drivers/video/fbdev/core/fbmem.c:1256:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1256:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1256:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1258:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1258:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1258:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1259:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1259:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1259:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1260:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1260:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1260:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1261:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1261:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1261:16: sparse:     got unsigned int *
>> drivers/video/fbdev/core/fbmem.c:1262:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/video/fbdev/core/fbmem.c:1262:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1262:16: sparse:     got unsigned short *
   drivers/video/fbdev/core/fbmem.c:1263:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/video/fbdev/core/fbmem.c:1263:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1263:16: sparse:     got unsigned short *
   drivers/video/fbdev/core/fbmem.c:1264:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/video/fbdev/core/fbmem.c:1264:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1264:16: sparse:     got unsigned short *
   drivers/video/fbdev/core/fbmem.c:1265:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1265:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1265:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1268:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1268:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1268:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1270:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1270:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1270:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1271:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1271:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1271:16: sparse:     got unsigned int *
--
>> drivers/watchdog/pcwd_pci.c:450:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/pcwd_pci.c:450:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:450:37: sparse:     got char const *
>> drivers/watchdog/pcwd_pci.c:486:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:486:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:486:24: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:490:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:490:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:490:24: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:499:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:499:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:499:24: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:506:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:506:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:506:21: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:537:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:537:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:537:21: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:548:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:548:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:548:24: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:557:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:557:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:557:24: sparse:     got int *
--
>> drivers/watchdog/wdt_pci.c:365:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/wdt_pci.c:365:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/wdt_pci.c:365:37: sparse:     got char const *
>> drivers/watchdog/wdt_pci.c:417:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wdt_pci.c:417:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wdt_pci.c:417:24: sparse:     got int *
   drivers/watchdog/wdt_pci.c:419:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wdt_pci.c:419:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wdt_pci.c:419:24: sparse:     got int *
   drivers/watchdog/wdt_pci.c:424:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wdt_pci.c:424:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wdt_pci.c:424:21: sparse:     got int *
   drivers/watchdog/wdt_pci.c:431:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wdt_pci.c:431:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wdt_pci.c:431:24: sparse:     got int *
--
>> drivers/watchdog/alim1535_wdt.c:153:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/alim1535_wdt.c:153:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/alim1535_wdt.c:153:37: sparse:     got char const *
>> drivers/watchdog/alim1535_wdt.c:194:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim1535_wdt.c:194:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim1535_wdt.c:194:24: sparse:     got int *
   drivers/watchdog/alim1535_wdt.c:199:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim1535_wdt.c:199:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim1535_wdt.c:199:21: sparse:     got int *
   drivers/watchdog/alim1535_wdt.c:217:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim1535_wdt.c:217:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim1535_wdt.c:217:21: sparse:     got int *
   drivers/watchdog/alim1535_wdt.c:225:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim1535_wdt.c:225:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim1535_wdt.c:225:24: sparse:     got int *
--
>> drivers/watchdog/alim7101_wdt.c:199:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/alim7101_wdt.c:199:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/alim7101_wdt.c:199:37: sparse:     got char const *
>> drivers/watchdog/alim7101_wdt.c:250:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim7101_wdt.c:250:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim7101_wdt.c:250:24: sparse:     got int *
   drivers/watchdog/alim7101_wdt.c:255:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim7101_wdt.c:255:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim7101_wdt.c:255:21: sparse:     got int *
   drivers/watchdog/alim7101_wdt.c:274:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim7101_wdt.c:274:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim7101_wdt.c:274:21: sparse:     got int *
   drivers/watchdog/alim7101_wdt.c:284:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim7101_wdt.c:284:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim7101_wdt.c:284:24: sparse:     got int *
--
>> drivers/watchdog/ibmasr.c:259:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/ibmasr.c:259:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:259:37: sparse:     got char const *
>> drivers/watchdog/ibmasr.c:286:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ibmasr.c:286:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:286:24: sparse:     got int *
   drivers/watchdog/ibmasr.c:290:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ibmasr.c:290:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:290:21: sparse:     got int *
   drivers/watchdog/ibmasr.c:312:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ibmasr.c:312:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:312:24: sparse:     got int *
--
>> drivers/watchdog/nv_tco.c:197:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/nv_tco.c:197:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/nv_tco.c:197:37: sparse:     got char const *
>> drivers/watchdog/nv_tco.c:230:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/nv_tco.c:230:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/nv_tco.c:230:24: sparse:     got int *
   drivers/watchdog/nv_tco.c:232:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/nv_tco.c:232:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/nv_tco.c:232:21: sparse:     got int *
   drivers/watchdog/nv_tco.c:248:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/nv_tco.c:248:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/nv_tco.c:248:21: sparse:     got int *
   drivers/watchdog/nv_tco.c:255:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/nv_tco.c:255:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/nv_tco.c:255:24: sparse:     got int *
--
>> drivers/watchdog/sch311x_wdt.c:232:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/sch311x_wdt.c:232:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:232:37: sparse:     got char const *
>> drivers/watchdog/sch311x_wdt.c:267:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sch311x_wdt.c:267:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:267:24: sparse:     got int *
   drivers/watchdog/sch311x_wdt.c:270:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sch311x_wdt.c:270:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:270:24: sparse:     got int *
   drivers/watchdog/sch311x_wdt.c:276:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sch311x_wdt.c:276:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:276:21: sparse:     got int *
   drivers/watchdog/sch311x_wdt.c:293:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sch311x_wdt.c:293:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:293:21: sparse:     got int *
   drivers/watchdog/sch311x_wdt.c:300:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sch311x_wdt.c:300:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:300:24: sparse:     got int *
--
>> drivers/watchdog/w83877f_wdt.c:202:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/w83877f_wdt.c:202:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:202:37: sparse:     got char const *
>> drivers/watchdog/w83877f_wdt.c:255:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:255:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:255:24: sparse:     got int *
   drivers/watchdog/w83877f_wdt.c:260:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:260:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:260:21: sparse:     got int *
   drivers/watchdog/w83877f_wdt.c:282:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:282:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:282:21: sparse:     got int *
   drivers/watchdog/w83877f_wdt.c:294:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:294:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:294:24: sparse:     got int *
--
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/fat/dir.c:759:1: sparse:     expected long [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got long *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/fat/dir.c:759:1: sparse:     expected long [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got long *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
   fs/fat/dir.c:812:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:812:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:812:13: sparse:     got unsigned short *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
>> fs/fat/dir.c:823:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned int *
>> fs/fat/dir.c:823:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/fat/dir.c:823:1: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got signed int *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
   fs/fat/dir.c:850:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:850:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:850:13: sparse:     got unsigned short *
--
>> fs/nfsd/nfs4recover.c:798:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__ptr_clean @@     got unsigned char const * @@
   fs/nfsd/nfs4recover.c:798:13: sparse:     expected unsigned char const [noderef] __user *__ptr_clean
   fs/nfsd/nfs4recover.c:798:13: sparse:     got unsigned char const *
>> fs/nfsd/nfs4recover.c:807:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__ptr_clean @@     got unsigned short const * @@
   fs/nfsd/nfs4recover.c:807:29: sparse:     expected unsigned short const [noderef] __user *__ptr_clean
   fs/nfsd/nfs4recover.c:807:29: sparse:     got unsigned short const *
   fs/nfsd/nfs4recover.c:813:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__ptr_clean @@     got unsigned char const * @@
   fs/nfsd/nfs4recover.c:813:25: sparse:     expected unsigned char const [noderef] __user *__ptr_clean
   fs/nfsd/nfs4recover.c:813:25: sparse:     got unsigned char const *
   fs/nfsd/nfs4recover.c:827:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__ptr_clean @@     got unsigned short const * @@
   fs/nfsd/nfs4recover.c:827:29: sparse:     expected unsigned short const [noderef] __user *__ptr_clean
   fs/nfsd/nfs4recover.c:827:29: sparse:     got unsigned short const *
>> fs/nfsd/nfs4recover.c:878:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed short [noderef] __user *__ptr_clean @@     got signed short * @@
   fs/nfsd/nfs4recover.c:878:13: sparse:     expected signed short [noderef] __user *__ptr_clean
   fs/nfsd/nfs4recover.c:878:13: sparse:     got signed short *
--
>> net/bpf/bpf_dummy_struct_ops.c:122:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bpf/bpf_dummy_struct_ops.c:122:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bpf/bpf_dummy_struct_ops.c:122:13: sparse:     got unsigned int *
--
>> drivers/tty/n_hdlc.c:628:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/n_hdlc.c:628:25: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/n_hdlc.c:628:25: sparse:     got int *
   drivers/tty/n_hdlc.c:641:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/n_hdlc.c:641:25: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/n_hdlc.c:641:25: sparse:     got int *
--
>> drivers/tty/n_gsm.c:2728:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/n_gsm.c:2728:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/n_gsm.c:2728:24: sparse:     got unsigned int *
   drivers/tty/n_gsm.c:2893:29: sparse: sparse: restricted __be16 degrades to integer
--
>> drivers/tty/synclink_gt.c:2555:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/synclink_gt.c:2555:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/synclink_gt.c:2555:13: sparse:     got int *
   drivers/tty/synclink_gt.c:2662:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/synclink_gt.c:2662:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/synclink_gt.c:2662:13: sparse:     got int *
   drivers/tty/synclink_gt.c:2761:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/synclink_gt.c:2761:22: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/synclink_gt.c:2761:22: sparse:     got int *
   drivers/tty/synclink_gt.c:2768:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/synclink_gt.c:2768:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/synclink_gt.c:2768:13: sparse:     got int *
   drivers/tty/synclink_gt.c:2799:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/synclink_gt.c:2799:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/synclink_gt.c:2799:13: sparse:     got int *
   drivers/tty/synclink_gt.c:2825:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/synclink_gt.c:2825:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/synclink_gt.c:2825:13: sparse:     got int *
--
>> drivers/tty/vt/vt_ioctl.c:328:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt_ioctl.c:328:24: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:328:24: sparse:     got char *
>> drivers/tty/vt/vt_ioctl.c:386:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:386:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:386:24: sparse:     got int *
   drivers/tty/vt/vt_ioctl.c:406:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:406:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:406:24: sparse:     got int *
   drivers/tty/vt/vt_ioctl.c:415:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:415:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:415:24: sparse:     got int *
>> drivers/tty/vt/vt_ioctl.c:811:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:811:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:811:21: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:821:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:821:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:821:24: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:834:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:834:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:834:24: sparse:     got int *
   drivers/tty/vt/vt_ioctl.c:917:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:917:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:917:21: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:918:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:918:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:918:21: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:952:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:952:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:952:24: sparse:     got unsigned short *
--
>> drivers/tty/vt/keyboard.c:1724:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1724:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1724:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1751:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1751:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1751:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1769:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1769:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1769:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1807:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1807:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1807:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1913:30: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1913:30: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1913:30: sparse:     got unsigned int *
>> drivers/tty/vt/keyboard.c:2033:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/keyboard.c:2033:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2033:24: sparse:     got unsigned short *
>> drivers/tty/vt/keyboard.c:2067:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/tty/vt/keyboard.c:2067:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2067:13: sparse:     got unsigned char *
>> drivers/tty/vt/keyboard.c:2125:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/keyboard.c:2125:24: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2125:24: sparse:     got char *
   drivers/tty/vt/keyboard.c:2143:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/keyboard.c:2143:24: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2143:24: sparse:     got char *
--
>> drivers/tty/vt/consolemap.c:776:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/consolemap.c:776:9: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/consolemap.c:776:9: sparse:     got unsigned short *
--
>> drivers/tty/vt/vt.c:4338:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:4338:13: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:4338:13: sparse:     got char *
   drivers/tty/vt/vt.c:3193:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3193:13: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3193:13: sparse:     got char *
   drivers/tty/vt/vt.c:3225:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3225:31: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3225:31: sparse:     got char *
   drivers/tty/vt/vt.c:3231:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3231:31: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3231:31: sparse:     got char *
   drivers/tty/vt/vt.c:3240:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3240:31: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3240:31: sparse:     got char *
   drivers/tty/vt/vt.c:3246:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3246:37: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3246:37: sparse:     got char *
>> drivers/tty/vt/vt.c:3259:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/tty/vt/vt.c:3259:29: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3259:29: sparse:     got signed int *
--
>> drivers/char/hpet.c:317:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/char/hpet.c:317:18: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/char/hpet.c:317:18: sparse:     got unsigned long *
>> drivers/char/hpet.c:686:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/char/hpet.c:686:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/char/hpet.c:686:21: sparse:     got unsigned int *
   drivers/char/hpet.c:687:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/char/hpet.c:687:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/char/hpet.c:687:21: sparse:     got unsigned int *
>> drivers/char/hpet.c:688:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/hpet.c:688:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/hpet.c:688:21: sparse:     got unsigned short *
   drivers/char/hpet.c:689:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/hpet.c:689:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/hpet.c:689:21: sparse:     got unsigned short *
--
>> net/xdp/xsk.c:1151:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/xdp/xsk.c:1151:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/xdp/xsk.c:1151:13: sparse:     got int *
   net/xdp/xsk.c:1188:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/xdp/xsk.c:1188:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/xdp/xsk.c:1188:21: sparse:     got int *
   net/xdp/xsk.c:1240:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/xdp/xsk.c:1240:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/xdp/xsk.c:1240:21: sparse:     got int *
   net/xdp/xsk.c:1260:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/xdp/xsk.c:1260:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/xdp/xsk.c:1260:21: sparse:     got int *
--
>> net/bridge/netfilter/ebt_mark_m.c:62:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bridge/netfilter/ebt_mark_m.c:62:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebt_mark_m.c:62:13: sparse:     got unsigned int *
   net/bridge/netfilter/ebt_mark_m.c:63:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bridge/netfilter/ebt_mark_m.c:63:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebt_mark_m.c:63:13: sparse:     got unsigned int *
>> net/bridge/netfilter/ebt_mark_m.c:64:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   net/bridge/netfilter/ebt_mark_m.c:64:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebt_mark_m.c:64:13: sparse:     got unsigned char *
   net/bridge/netfilter/ebt_mark_m.c:65:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   net/bridge/netfilter/ebt_mark_m.c:65:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebt_mark_m.c:65:13: sparse:     got unsigned char *
--
>> net/bridge/netfilter/ebt_mark.c:76:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bridge/netfilter/ebt_mark.c:76:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebt_mark.c:76:13: sparse:     got unsigned int *
   net/bridge/netfilter/ebt_mark.c:77:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bridge/netfilter/ebt_mark.c:77:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebt_mark.c:77:13: sparse:     got unsigned int *
--
>> net/bridge/netfilter/ebtables.c:1652:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   net/bridge/netfilter/ebtables.c:1652:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1652:13: sparse:     got unsigned char *
>> net/bridge/netfilter/ebtables.c:1653:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bridge/netfilter/ebtables.c:1653:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1653:13: sparse:     got unsigned int *
   net/bridge/netfilter/ebtables.c:1684:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   net/bridge/netfilter/ebtables.c:1684:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1684:13: sparse:     got unsigned char *
   net/bridge/netfilter/ebtables.c:1685:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bridge/netfilter/ebtables.c:1685:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1685:13: sparse:     got unsigned int *
   net/bridge/netfilter/ebtables.c:1758:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bridge/netfilter/ebtables.c:1758:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1758:13: sparse:     got unsigned int *
   net/bridge/netfilter/ebtables.c:1759:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bridge/netfilter/ebtables.c:1759:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1759:13: sparse:     got unsigned int *
   net/bridge/netfilter/ebtables.c:1760:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/bridge/netfilter/ebtables.c:1760:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1760:13: sparse:     got unsigned int *
   net/bridge/netfilter/ebtables.c:1451:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   net/bridge/netfilter/ebtables.c:1451:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1451:13: sparse:     got unsigned char *
>> net/bridge/netfilter/ebtables.c:1452:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bridge/netfilter/ebtables.c:1452:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1452:13: sparse:     got int *
   net/bridge/netfilter/ebtables.c:1451:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   net/bridge/netfilter/ebtables.c:1451:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1451:13: sparse:     got unsigned char *
>> net/bridge/netfilter/ebtables.c:1452:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bridge/netfilter/ebtables.c:1452:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1452:13: sparse:     got int *
   net/bridge/netfilter/ebtables.c:1451:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   net/bridge/netfilter/ebtables.c:1451:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1451:13: sparse:     got unsigned char *
>> net/bridge/netfilter/ebtables.c:1452:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/bridge/netfilter/ebtables.c:1452:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/bridge/netfilter/ebtables.c:1452:13: sparse:     got int *
--
>> net/can/raw.c:698:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/raw.c:698:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/raw.c:698:13: sparse:     got int *
   net/can/raw.c:713:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/raw.c:713:37: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/raw.c:713:37: sparse:     got int *
   net/can/raw.c:727:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/raw.c:727:31: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/raw.c:727:31: sparse:     got int *
   net/can/raw.c:764:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/raw.c:764:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/raw.c:764:13: sparse:     got int *
--
>> net/atm/ioctl.c:70:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:70:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:70:25: sparse:     got int *
   net/atm/ioctl.c:82:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:82:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:82:25: sparse:     got int *
>> net/atm/ioctl.c:125:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/atm/ioctl.c:125:25: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/atm/ioctl.c:125:25: sparse:     got unsigned short *
>> net/atm/ioctl.c:173:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:173:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:173:29: sparse:     got unsigned int *
>> net/atm/ioctl.c:180:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   net/atm/ioctl.c:180:29: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   net/atm/ioctl.c:180:29: sparse:     got void [noderef] __user **
   net/atm/ioctl.c:193:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:193:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:193:29: sparse:     got unsigned int *
   net/atm/ioctl.c:196:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:196:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:196:29: sparse:     got int *
   net/atm/ioctl.c:203:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   net/atm/ioctl.c:203:29: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   net/atm/ioctl.c:203:29: sparse:     got void [noderef] __user **
   net/atm/ioctl.c:205:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:205:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:205:29: sparse:     got int *
   net/atm/ioctl.c:280:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:280:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:280:13: sparse:     got unsigned int *
   net/atm/ioctl.c:293:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:293:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:293:13: sparse:     got unsigned int *
   net/atm/ioctl.c:293:45: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:293:45: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:293:45: sparse:     got int *
--
>> net/atm/svc.c:509:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/svc.c:509:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/svc.c:509:13: sparse:     got int *
--
>> net/atm/common.c:795:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/common.c:795:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/common.c:795:13: sparse:     got int *
>> net/atm/common.c:808:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   net/atm/common.c:808:24: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   net/atm/common.c:808:24: sparse:     got unsigned long *
--
>> net/atm/resources.c:201:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:201:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:201:13: sparse:     got int *
   net/atm/resources.c:221:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:221:18: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:221:18: sparse:     got int *
   net/atm/resources.c:233:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:233:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:233:13: sparse:     got int *
   net/atm/resources.c:352:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:352:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:352:25: sparse:     got int *
   net/atm/resources.c:395:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:395:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:395:25: sparse:     got int *
--
>> net/atm/br2684.c:733:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/atm/br2684.c:733:23: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/atm/br2684.c:733:23: sparse:     got unsigned short *
--
>> fs/udf/file.c:208:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/udf/file.c:208:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/udf/file.c:208:21: sparse:     got long *
   fs/udf/file.c:213:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/udf/file.c:213:34: sparse:     expected long [noderef] __user *__ptr_clean
   fs/udf/file.c:213:34: sparse:     got long *
>> fs/udf/file.c:216:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/udf/file.c:216:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/udf/file.c:216:24: sparse:     got int *
--
>> fs/xfs/xfs_ioctl32.c:49:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:49:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:49:13: sparse:     got unsigned long long *
>> fs/xfs/xfs_ioctl32.c:50:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:50:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:50:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:60:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:60:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:60:13: sparse:     got unsigned long long *
   fs/xfs/xfs_ioctl32.c:61:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:61:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:61:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:77:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:77:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:77:13: sparse:     got unsigned long long *
>> fs/xfs/xfs_ioctl32.c:78:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:78:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:78:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:79:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:79:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:79:13: sparse:     got unsigned long long *
   fs/xfs/xfs_ioctl32.c:96:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:96:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:96:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:97:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:97:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:97:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:112:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:112:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:112:13: sparse:     got unsigned long long *
>> fs/xfs/xfs_ioctl32.c:113:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:113:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:113:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:114:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:114:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:114:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:115:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:115:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:115:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:116:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:116:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:116:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:117:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:117:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:117:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:118:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:118:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:118:13: sparse:     got signed int *
>> fs/xfs/xfs_ioctl32.c:119:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl32.c:119:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:119:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl32.c:123:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl32.c:123:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:123:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl32.c:124:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl32.c:124:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:124:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl32.c:125:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:125:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:125:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:126:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:126:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:126:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:127:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:127:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:127:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:128:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:128:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:128:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:129:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:129:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:129:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:130:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:130:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:130:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:131:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:131:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:131:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:132:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:132:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:132:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:133:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:133:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:133:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:148:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:148:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:148:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:149:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:149:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:149:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:166:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:166:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:166:13: sparse:     got unsigned long long *
   fs/xfs/xfs_ioctl32.c:167:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:167:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:167:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:168:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:168:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:168:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:169:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:169:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:169:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:170:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:170:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:170:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:171:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:171:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:171:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:172:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:172:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:172:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:173:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl32.c:173:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:173:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl32.c:177:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl32.c:177:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:177:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl32.c:178:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:178:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:178:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:179:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:179:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:179:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:180:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:180:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:180:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:181:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:181:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:181:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:182:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:182:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:182:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:183:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:183:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:183:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:184:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:184:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:184:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:185:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:185:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:185:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:186:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:186:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:186:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:187:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:187:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:187:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:244:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:244:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
--
>> drivers/gpu/drm/drm_ioc32.c:903:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_ioc32.c:903:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:903:13: sparse:     got unsigned int *
--
>> drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse:     got int *
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     got int *
>> drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     got int *
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     got int *
>> drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     got unsigned int *
--
>> net/netfilter/x_tables.c:297:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/netfilter/x_tables.c:297:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/netfilter/x_tables.c:297:13: sparse:     got unsigned short *
>> net/netfilter/x_tables.c:301:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   net/netfilter/x_tables.c:301:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   net/netfilter/x_tables.c:301:13: sparse:     got unsigned char *
--
>> drivers/hid/hidraw.c:381:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/hidraw.c:381:29: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/hidraw.c:381:29: sparse:     got int *
   drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/hidraw.c:389:37: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/hidraw.c:389:37: sparse:     got int *
--
>> drivers/hid/uhid.c:425:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/hid/uhid.c:425:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/hid/uhid.c:425:21: sparse:     got char const *
--
>> net/rfkill/core.c:1354:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/rfkill/core.c:1354:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/rfkill/core.c:1354:21: sparse:     got unsigned int *
--
>> fs/ocfs2/ioctl.c:867:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ocfs2/ioctl.c:867:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ocfs2/ioctl.c:867:21: sparse:     got int *
>> fs/ocfs2/ioctl.c:47:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ocfs2/ioctl.c:47:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ocfs2/ioctl.c:47:15: sparse:     got unsigned int *
>> fs/ocfs2/ioctl.c:47:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ocfs2/ioctl.c:47:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ocfs2/ioctl.c:47:15: sparse:     got unsigned int *
--
>> net/ieee802154/socket.c:533:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:533:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:533:24: sparse:     got int *
   net/ieee802154/socket.c:552:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:552:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:552:24: sparse:     got int *
   net/ieee802154/socket.c:836:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:836:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:836:13: sparse:     got int *
   net/ieee802154/socket.c:866:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:866:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:866:13: sparse:     got int *
--
>> fs/btrfs/ioctl.c:464:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/btrfs/ioctl.c:464:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/btrfs/ioctl.c:464:16: sparse:     got int *
   fs/btrfs/ioctl.c:413:6: sparse: sparse: context imbalance in 'btrfs_exclop_start_try_lock' - wrong count at exit
   fs/btrfs/ioctl.c:426:6: sparse: sparse: context imbalance in 'btrfs_exclop_start_unlock' - unexpected unlock
--
>> drivers/platform/x86/sony-laptop.c:4085:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/platform/x86/sony-laptop.c:4085:21: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/platform/x86/sony-laptop.c:4085:21: sparse:     got char *
--
>> net/ipv4/af_inet.c:991:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv4/af_inet.c:991:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:991:13: sparse:     got unsigned short *
>> net/ipv4/af_inet.c:992:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected short [noderef] __user *__ptr_clean @@     got short * @@
   net/ipv4/af_inet.c:992:13: sparse:     expected short [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:992:13: sparse:     got short *
>> net/ipv4/af_inet.c:993:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/af_inet.c:993:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:993:13: sparse:     got unsigned int *
   net/ipv4/af_inet.c:994:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/af_inet.c:994:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:994:13: sparse:     got unsigned int *
   net/ipv4/af_inet.c:995:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv4/af_inet.c:995:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:995:13: sparse:     got unsigned short *
   net/ipv4/af_inet.c:996:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/af_inet.c:996:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:996:13: sparse:     got unsigned int *
   net/ipv4/af_inet.c:1501:59: sparse: sparse: restricted __be16 degrades to integer
--
   net/ipv4/netfilter/arp_tables.c:1058:48: sparse: sparse: array of flexible structures
>> net/ipv4/netfilter/arp_tables.c:1325:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv4/netfilter/arp_tables.c:1325:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv4/netfilter/arp_tables.c:1325:13: sparse:     got unsigned short *
   net/ipv4/netfilter/arp_tables.c:1326:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv4/netfilter/arp_tables.c:1326:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv4/netfilter/arp_tables.c:1326:13: sparse:     got unsigned short *
   net/ipv4/netfilter/arp_tables.c:1362:44: sparse: sparse: array of flexible structures
   net/ipv4/netfilter/arp_tables.c:40:16: sparse: sparse: Initializer entry defined twice
   net/ipv4/netfilter/arp_tables.c:40:16: sparse:   also defined here
   net/ipv4/netfilter/arp_tables.c:40:16: sparse: sparse: Initializer entry defined twice
   net/ipv4/netfilter/arp_tables.c:40:16: sparse:   also defined here
--
>> net/ipv4/netfilter/ip_tables.c:1249:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv4/netfilter/ip_tables.c:1249:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv4/netfilter/ip_tables.c:1249:13: sparse:     got unsigned short *
   net/ipv4/netfilter/ip_tables.c:1250:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv4/netfilter/ip_tables.c:1250:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv4/netfilter/ip_tables.c:1250:13: sparse:     got unsigned short *
   net/ipv4/netfilter/ip_tables.c:1213:40: sparse: sparse: array of flexible structures
   net/ipv4/netfilter/ip_tables.c:1541:43: sparse: sparse: array of flexible structures
   net/ipv4/netfilter/ip_tables.c:38:16: sparse: sparse: Initializer entry defined twice
   net/ipv4/netfilter/ip_tables.c:38:16: sparse:   also defined here
   net/ipv4/netfilter/ip_tables.c:38:16: sparse: sparse: Initializer entry defined twice
   net/ipv4/netfilter/ip_tables.c:38:16: sparse:   also defined here
--
>> drivers/ata/libata-scsi.c:569:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/ata/libata-scsi.c:569:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/ata/libata-scsi.c:569:32: sparse:     got unsigned int *
   drivers/ata/libata-scsi.c:571:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/ata/libata-scsi.c:571:24: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/ata/libata-scsi.c:571:24: sparse:     got unsigned long *
--
>> drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_getparam.c:176:13: sparse:     got int *
--
>> drivers/gpu/drm/i915/i915_perf.c:3623:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_perf.c:3623:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:3623:23: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/i915_perf.c:3627:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_perf.c:3627:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:3627:23: sparse:     got unsigned long long *
>> drivers/gpu/drm/i915/i915_perf.c:4026:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_perf.c:4026:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:4026:23: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_perf.c:4036:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_perf.c:4036:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:4036:23: sparse:     got unsigned int *
--
>> drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse:     got unsigned int *
>> drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse:     got unsigned long long *
--
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:411:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:411:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:411:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:427:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:427:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:427:13: sparse:     got unsigned short *
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:430:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:430:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:430:15: sparse:     got unsigned int *
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:434:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:434:15: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:434:15: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:502:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:502:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:502:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:524:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:524:15: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:524:15: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:529:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:529:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:529:23: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:552:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:552:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:552:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:590:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:590:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:590:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:593:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:593:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:593:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:596:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:596:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:596:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:618:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:618:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:618:13: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:627:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:627:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:627:23: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:795:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:795:14: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:795:14: sparse:     got unsigned long long *
--
>> drivers/gpu/drm/i915/i915_query.c:224:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_query.c:224:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:224:13: sparse:     got unsigned int *
>> drivers/gpu/drm/i915/i915_query.c:251:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_query.c:251:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:251:21: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/i915_query.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_query.c:354:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:354:13: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_query.c:394:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_query.c:394:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:394:13: sparse:     got unsigned long long *
>> drivers/gpu/drm/i915/i915_query.c:525:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/gpu/drm/i915/i915_query.c:525:43: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:525:43: sparse:     got signed int *
--
>> drivers/vfio/vfio.c:1449:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/vfio/vfio.c:1449:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/vfio/vfio.c:1449:21: sparse:     got int *

vim +161 arch/x86/entry/common.c

8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  137  
0b085e68f40720 Thomas Gleixner        2020-07-23  138  static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  139  {
2978996f620001 H. Peter Anvin (Intel  2021-05-18  140) 	int nr = syscall_32_enter(regs);
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  141  	int res;
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  142  
fe950f6020338c Kees Cook              2021-04-01  143  	add_random_kstack_offset();
4facb95b7adaf7 Thomas Gleixner        2020-09-02  144  	/*
4facb95b7adaf7 Thomas Gleixner        2020-09-02  145  	 * This cannot use syscall_enter_from_user_mode() as it has to
4facb95b7adaf7 Thomas Gleixner        2020-09-02  146  	 * fetch EBP before invoking any of the syscall entry work
4facb95b7adaf7 Thomas Gleixner        2020-09-02  147  	 * functions.
4facb95b7adaf7 Thomas Gleixner        2020-09-02  148  	 */
4facb95b7adaf7 Thomas Gleixner        2020-09-02  149  	syscall_enter_from_user_mode_prepare(regs);
4facb95b7adaf7 Thomas Gleixner        2020-09-02  150  
0b085e68f40720 Thomas Gleixner        2020-07-23  151  	instrumentation_begin();
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  152  	/* Fetch EBP from where the vDSO stashed it. */
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  153  	if (IS_ENABLED(CONFIG_X86_64)) {
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  154  		/*
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  155  		 * Micro-optimization: the pointer we're following is
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  156  		 * explicitly 32 bits, so it can't be out of range.
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  157  		 */
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  158  		res = __get_user(*(u32 *)&regs->bp,
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  159  			 (u32 __user __force *)(unsigned long)(u32)regs->sp);
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  160  	} else {
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10 @161  		res = get_user(*(u32 *)&regs->bp,
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  162  		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  163  	}
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  164  
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  165  	if (res) {
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  166  		/* User code screwed up. */
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  167  		regs->ax = -EFAULT;
9caa7ff509add5 Peter Zijlstra         2021-01-06  168  
5d5675df792ff6 Andy Lutomirski        2021-03-04  169  		local_irq_disable();
240001d4e30418 Peter Zijlstra         2021-06-21  170  		instrumentation_end();
5d5675df792ff6 Andy Lutomirski        2021-03-04  171  		irqentry_exit_to_user_mode(regs);
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  172  		return false;
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  173  	}
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  174  
2978996f620001 H. Peter Anvin (Intel  2021-05-18  175) 	nr = syscall_enter_from_user_mode_work(regs, nr);
4facb95b7adaf7 Thomas Gleixner        2020-09-02  176  
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  177  	/* Now this is just like a normal syscall. */
0b085e68f40720 Thomas Gleixner        2020-07-23  178  	do_syscall_32_irqs_on(regs, nr);
9caa7ff509add5 Peter Zijlstra         2021-01-06  179  
9caa7ff509add5 Peter Zijlstra         2021-01-06  180  	instrumentation_end();
167fd210ec0555 Thomas Gleixner        2020-07-23  181  	syscall_exit_to_user_mode(regs);
8f159f1dfa1ea2 Thomas Gleixner        2020-03-10  182  	return true;
8b13c2552ffc8e Andy Lutomirski        2015-10-05  183  }
8b13c2552ffc8e Andy Lutomirski        2015-10-05  184  

:::::: The code at line 161 was first introduced by commit
:::::: 8f159f1dfa1ea29d70a84335fe6a8bd501a9eecd x86/entry/common: Protect against instrumentation

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
