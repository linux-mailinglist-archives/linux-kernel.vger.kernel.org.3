Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6571595F84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbiHPPqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbiHPPpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:45:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BFB7C513
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660664475; x=1692200475;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q5RAz/tXzClI1/eqMoYCwbxv+9PIZwDrLGmyUJrJjds=;
  b=HuetKqOltGFzKeEaZqTEm3sv09D1dZWKi4hJqEtVTzpVD96yO6NBhDch
   N42B7XDbpEv46Vni7Mh38+P+0E3dWr1WAm5/nKakb3FvmZEXS6s16XriL
   7kybHgsKqpQMiYbLBWTx5ZmMd9qMA1ew/PXmJ/LS4PQ9TCt06+hwxJTte
   nmO3EYEqb7Mo2/MUOmecv1yL8QDfNIbd7kkp3DEC1tHjedUB8HJqG62I1
   lsuGtHcqG/0JFZTVIpPWV8k+ztCRLJGGXJ8neDsKM66Y29FVbMZYHkxxY
   LxFgFye4cwQXWhXu620tiV0N+1YQU2CE9A1UFaKS9QGMFt2ZdNqCviYT0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="289826400"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="289826400"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 08:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="635939193"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2022 08:40:55 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNygZ-00002K-12;
        Tue, 16 Aug 2022 15:40:55 +0000
Date:   Tue, 16 Aug 2022 23:40:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/13] kernel/futex/core.c:878:13: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202208162350.5ooSAhSV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="D49ob4yFRDnY1HjA"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D49ob4yFRDnY1HjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   8836fbd6cd3120383a0bc63cd54c7dd55639ed49
commit: 2600a472582e2968633831d430c2a1366ad3e8b1 [5/13] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s022-20220815
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=2600a472582e2968633831d430c2a1366ad3e8b1
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 2600a472582e2968633831d430c2a1366ad3e8b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/ arch/x86/kernel/ block/ drivers/ata/ drivers/fsi/ drivers/hid/ drivers/hwmon/ drivers/i2c/ drivers/input/serio/ drivers/media/v4l2-core/ drivers/mtd/ubi/ drivers/scsi/ drivers/video/fbdev/core/ drivers/watchdog/ fs/ ipc/ kernel/ net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   kernel/futex/core.c:648:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:648:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:648:13: sparse:     got unsigned int *
   kernel/futex/core.c:783:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/futex/core.c:783:13: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/futex/core.c:783:13: sparse:     got long *
>> kernel/futex/core.c:878:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   kernel/futex/core.c:878:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   kernel/futex/core.c:878:13: sparse:     got signed int *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
   kernel/futex/core.c:844:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:844:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:844:13: sparse:     got unsigned int *
   kernel/futex/core.c:844:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:844:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:844:13: sparse:     got unsigned int *
   kernel/futex/core.c:844:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:844:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:844:13: sparse:     got unsigned int *
--
   kernel/futex/syscalls.c:75:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/syscalls.c:75:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:75:13: sparse:     got unsigned long *
   kernel/futex/syscalls.c:77:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct robust_list_head [noderef] __user *[noderef] __user *__ptr_clean @@     got struct robust_list_head [noderef] __user ** @@
   kernel/futex/syscalls.c:77:16: sparse:     expected struct robust_list_head [noderef] __user *[noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:77:16: sparse:     got struct robust_list_head [noderef] __user **
>> kernel/futex/syscalls.c:344:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/syscalls.c:344:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:344:13: sparse:     got unsigned int *
   kernel/futex/syscalls.c:346:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/syscalls.c:346:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:346:16: sparse:     got unsigned int *
--
   drivers/input/serio/serport.c:216:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/input/serio/serport.c:216:21: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/input/serio/serport.c:216:21: sparse:     got unsigned long *
>> drivers/input/serio/serport.c:235:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/input/serio/serport.c:235:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/input/serio/serport.c:235:21: sparse:     got unsigned int *
--
>> drivers/input/serio/serio_raw.c:178:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/input/serio/serio_raw.c:178:29: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/input/serio/serio_raw.c:178:29: sparse:     got char *
>> drivers/input/serio/serio_raw.c:219:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/input/serio/serio_raw.c:219:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/input/serio/serio_raw.c:219:21: sparse:     got char const *
--
>> drivers/media/v4l2-core/v4l2-compat-ioctl32.c:147:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:147:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:147:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:235:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:235:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:235:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:236:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:236:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:236:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:255:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:255:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:255:16: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:261:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:261:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:261:13: sparse:     got unsigned int *
>> drivers/media/v4l2-core/v4l2-compat-ioctl32.c:262:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:262:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:262:13: sparse:     got unsigned long long *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:266:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:266:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:266:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:605:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:605:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:605:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:606:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:606:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:606:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:607:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:607:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:607:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:618:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:618:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:618:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:619:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:619:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:619:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:620:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:620:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:620:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:774:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:774:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:774:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:776:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:776:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:776:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:777:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:777:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:777:13: sparse:     got unsigned int *
>> drivers/media/v4l2-core/v4l2-compat-ioctl32.c:778:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:778:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:778:13: sparse:     got signed long long *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:779:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:779:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:779:13: sparse:     got signed long long *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:780:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:780:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:780:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:805:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:805:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:805:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:807:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:807:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:807:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:808:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:808:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:808:13: sparse:     got unsigned int *
>> drivers/media/v4l2-core/v4l2-compat-ioctl32.c:809:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:809:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:809:13: sparse:     got signed int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:810:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:810:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:810:13: sparse:     got signed int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:811:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:811:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:811:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:832:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:832:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:832:13: sparse:     got unsigned int *
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1112:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1112:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1112:37: sparse:     got unsigned int *
--
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/fat/dir.c:759:1: sparse:     expected long [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got long *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/fat/dir.c:759:1: sparse:     expected long [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got long *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
   fs/fat/dir.c:812:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:812:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:812:13: sparse:     got unsigned short *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
>> fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned int *
>> fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/fat/dir.c:823:1: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got signed int *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
   fs/fat/dir.c:850:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:850:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:850:13: sparse:     got unsigned short *
--
>> fs/fat/file.c:32:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fat/file.c:32:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fat/file.c:32:16: sparse:     got unsigned int *
   fs/fat/file.c:44:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fat/file.c:44:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fat/file.c:44:15: sparse:     got unsigned int *
   fs/fat/file.c:123:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fat/file.c:123:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fat/file.c:123:16: sparse:     got unsigned int *
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
>> drivers/scsi/ch.c:552:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/ch.c:552:17: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/ch.c:552:17: sparse:     got unsigned char *
--
   drivers/scsi/st.c: note: in included file:
>> include/linux/mtio.h:55:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   include/linux/mtio.h:55:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   include/linux/mtio.h:55:24: sparse:     got unsigned int *
>> include/linux/mtio.h:57:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   include/linux/mtio.h:57:24: sparse:     expected long [noderef] __user *__ptr_clean
   include/linux/mtio.h:57:24: sparse:     got long *
--
>> drivers/video/fbdev/core/fbmem.c:1269:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1269:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1269:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1271:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1271:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1271:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1272:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1272:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1272:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1273:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1273:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1273:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1274:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1274:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1274:16: sparse:     got unsigned int *
>> drivers/video/fbdev/core/fbmem.c:1275:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/video/fbdev/core/fbmem.c:1275:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1275:16: sparse:     got unsigned short *
   drivers/video/fbdev/core/fbmem.c:1276:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/video/fbdev/core/fbmem.c:1276:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1276:16: sparse:     got unsigned short *
   drivers/video/fbdev/core/fbmem.c:1277:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/video/fbdev/core/fbmem.c:1277:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1277:16: sparse:     got unsigned short *
   drivers/video/fbdev/core/fbmem.c:1278:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1278:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1278:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1281:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1281:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1281:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1283:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1283:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1283:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1284:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1284:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1284:16: sparse:     got unsigned int *
--
>> drivers/watchdog/watchdog_dev.c:687:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/watchdog_dev.c:687:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:687:21: sparse:     got char const *
>> drivers/watchdog/watchdog_dev.c:749:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:749:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:749:23: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:752:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:752:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:752:23: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:755:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:755:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:755:21: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:775:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:775:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:775:21: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:795:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:795:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:795:23: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:801:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:801:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:801:23: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:804:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:804:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:804:21: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:811:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:811:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:811:23: sparse:     got int *
--
>> drivers/watchdog/advantechwdt.c:120:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/advantechwdt.c:120:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:120:37: sparse:     got char const *
>> drivers/watchdog/advantechwdt.c:152:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:152:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:152:24: sparse:     got int *
   drivers/watchdog/advantechwdt.c:158:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:158:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:158:21: sparse:     got int *
   drivers/watchdog/advantechwdt.c:175:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:175:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:175:21: sparse:     got int *
   drivers/watchdog/advantechwdt.c:182:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:182:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:182:24: sparse:     got int *
--
>> drivers/watchdog/acquirewdt.c:131:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/acquirewdt.c:131:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/acquirewdt.c:131:37: sparse:     got char const *
>> drivers/watchdog/acquirewdt.c:161:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/acquirewdt.c:161:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/acquirewdt.c:161:24: sparse:     got int *
   drivers/watchdog/acquirewdt.c:165:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/acquirewdt.c:165:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/acquirewdt.c:165:21: sparse:     got int *
   drivers/watchdog/acquirewdt.c:182:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/acquirewdt.c:182:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/acquirewdt.c:182:24: sparse:     got int *
--
>> drivers/watchdog/sbc_fitpc2_wdt.c:99:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/sbc_fitpc2_wdt.c:99:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:99:21: sparse:     got char const *
>> drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse:     got int *
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse:     got int *
   drivers/watchdog/sbc_fitpc2_wdt.c:146:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_fitpc2_wdt.c:146:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:146:23: sparse:     got int *
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse:     got int *
--
>> drivers/watchdog/wafer5823wdt.c:109:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/wafer5823wdt.c:109:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:109:37: sparse:     got char const *
>> drivers/watchdog/wafer5823wdt.c:143:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:143:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:143:24: sparse:     got int *
   drivers/watchdog/wafer5823wdt.c:149:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:149:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:149:21: sparse:     got int *
   drivers/watchdog/wafer5823wdt.c:170:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:170:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:170:21: sparse:     got int *
   drivers/watchdog/wafer5823wdt.c:179:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:179:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:179:24: sparse:     got int *
--
>> drivers/watchdog/ibmasr.c:259:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/ibmasr.c:259:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:259:37: sparse:     got char const *
>> drivers/watchdog/ibmasr.c:286:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ibmasr.c:286:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:286:24: sparse:     got int *
   drivers/watchdog/ibmasr.c:290:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ibmasr.c:290:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:290:21: sparse:     got int *
   drivers/watchdog/ibmasr.c:312:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ibmasr.c:312:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:312:24: sparse:     got int *
--
>> drivers/watchdog/sc1200wdt.c:200:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:200:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:200:24: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:203:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:203:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:203:24: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:209:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:209:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:209:21: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:229:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:229:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:229:21: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:240:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:240:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:240:24: sparse:     got int *
>> drivers/watchdog/sc1200wdt.c:276:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/sc1200wdt.c:276:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:276:37: sparse:     got char const *
--
>> drivers/watchdog/pc87413_wdt.c:354:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/pc87413_wdt.c:354:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:354:37: sparse:     got char const *
>> drivers/watchdog/pc87413_wdt.c:403:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:403:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:403:24: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:405:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:405:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:405:24: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:409:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:409:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:409:21: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:428:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:428:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:428:21: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:439:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:439:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:439:24: sparse:     got int *
--
>> drivers/watchdog/smsc37b787_wdt.c:404:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/smsc37b787_wdt.c:404:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:404:37: sparse:     got char const *
>> drivers/watchdog/smsc37b787_wdt.c:444:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:444:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:444:24: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse:     got int *
--
>> drivers/watchdog/w83877f_wdt.c:202:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/w83877f_wdt.c:202:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:202:37: sparse:     got char const *
>> drivers/watchdog/w83877f_wdt.c:255:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:255:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:255:24: sparse:     got int *
   drivers/watchdog/w83877f_wdt.c:260:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:260:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:260:21: sparse:     got int *
   drivers/watchdog/w83877f_wdt.c:282:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:282:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:282:21: sparse:     got int *
   drivers/watchdog/w83877f_wdt.c:294:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:294:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:294:24: sparse:     got int *
--
>> drivers/watchdog/w83977f_wdt.c:343:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/w83977f_wdt.c:343:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:343:37: sparse:     got char const *
>> drivers/watchdog/w83977f_wdt.c:392:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83977f_wdt.c:392:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:392:24: sparse:     got int *
   drivers/watchdog/w83977f_wdt.c:395:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83977f_wdt.c:395:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:395:24: sparse:     got int *
   drivers/watchdog/w83977f_wdt.c:398:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83977f_wdt.c:398:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:398:21: sparse:     got int *
   drivers/watchdog/w83977f_wdt.c:418:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83977f_wdt.c:418:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:418:21: sparse:     got int *
   drivers/watchdog/w83977f_wdt.c:428:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83977f_wdt.c:428:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:428:24: sparse:     got int *
--
>> drivers/watchdog/machzwd.c:285:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/machzwd.c:285:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/machzwd.c:285:37: sparse:     got char const *
>> drivers/watchdog/machzwd.c:315:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/machzwd.c:315:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/machzwd.c:315:24: sparse:     got int *
--
>> net/ipv4/af_inet.c:990:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv4/af_inet.c:990:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:990:13: sparse:     got unsigned short *
>> net/ipv4/af_inet.c:991:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected short [noderef] __user *__ptr_clean @@     got short * @@
   net/ipv4/af_inet.c:991:13: sparse:     expected short [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:991:13: sparse:     got short *
>> net/ipv4/af_inet.c:992:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/af_inet.c:992:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:992:13: sparse:     got unsigned int *
   net/ipv4/af_inet.c:993:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/af_inet.c:993:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:993:13: sparse:     got unsigned int *
   net/ipv4/af_inet.c:994:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv4/af_inet.c:994:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:994:13: sparse:     got unsigned short *
   net/ipv4/af_inet.c:995:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/af_inet.c:995:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:995:13: sparse:     got unsigned int *
   net/ipv4/af_inet.c:1501:59: sparse: sparse: restricted __be16 degrades to integer
--
>> net/ipv6/af_inet6.c:612:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:612:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:612:13: sparse:     got unsigned int *
>> net/ipv6/af_inet6.c:613:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv6/af_inet6.c:613:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:613:13: sparse:     got unsigned short *
   net/ipv6/af_inet6.c:614:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv6/af_inet6.c:614:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:614:13: sparse:     got unsigned short *
   net/ipv6/af_inet6.c:615:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:615:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:615:13: sparse:     got unsigned int *
   net/ipv6/af_inet6.c:616:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:616:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:616:13: sparse:     got unsigned int *
   net/ipv6/af_inet6.c:617:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:617:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:617:13: sparse:     got unsigned int *
>> net/ipv6/af_inet6.c:618:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   net/ipv6/af_inet6.c:618:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:618:13: sparse:     got signed int *
--
   fs/autofs/root.c:812:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:812:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:812:16: sparse:     got int *
   fs/autofs/root.c:819:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:819:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:819:16: sparse:     got int *
   fs/autofs/root.c:790:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/autofs/root.c:790:14: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/autofs/root.c:790:14: sparse:     got unsigned long *
   fs/autofs/root.c:794:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/autofs/root.c:794:14: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/autofs/root.c:794:14: sparse:     got unsigned long *
>> fs/autofs/root.c:765:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/autofs/root.c:765:14: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/autofs/root.c:765:14: sparse:     got unsigned int *
   fs/autofs/root.c:769:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/autofs/root.c:769:14: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/autofs/root.c:769:14: sparse:     got unsigned int *
   fs/autofs/root.c:834:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:834:18: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:834:18: sparse:     got int *
--
>> fs/fuse/dev.c:2260:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fuse/dev.c:2260:22: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fuse/dev.c:2260:22: sparse:     got unsigned int *
--
>> fs/jfs/jfs_debug.c:36:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   fs/jfs/jfs_debug.c:36:13: sparse:     expected char const [noderef] __user *__ptr_clean
   fs/jfs/jfs_debug.c:36:13: sparse:     got char const *
--
>> fs/xfs/xfs_ioctl32.c:51:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:51:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:51:13: sparse:     got unsigned long long *
>> fs/xfs/xfs_ioctl32.c:52:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:52:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:52:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:62:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:62:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:62:13: sparse:     got unsigned long long *
   fs/xfs/xfs_ioctl32.c:63:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:63:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:63:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:79:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:79:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:79:13: sparse:     got unsigned long long *
>> fs/xfs/xfs_ioctl32.c:80:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:80:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:80:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:81:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:81:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:81:13: sparse:     got unsigned long long *
   fs/xfs/xfs_ioctl32.c:98:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:98:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:98:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:99:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:99:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:99:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:114:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:114:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:114:13: sparse:     got unsigned long long *
>> fs/xfs/xfs_ioctl32.c:115:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:115:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:115:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:116:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:116:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:116:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:117:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:117:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:117:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:118:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:118:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:118:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:119:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:119:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:119:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:120:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:120:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:120:13: sparse:     got signed int *
>> fs/xfs/xfs_ioctl32.c:121:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl32.c:121:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:121:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl32.c:125:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl32.c:125:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:125:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl32.c:126:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl32.c:126:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:126:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl32.c:127:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:127:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:127:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:128:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:128:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:128:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:129:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:129:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:129:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:130:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:130:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:130:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:131:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:131:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:131:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:132:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:132:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:132:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:133:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:133:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:133:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:134:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:134:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:134:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:135:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:135:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:135:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:150:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:150:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:150:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:151:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:151:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:151:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:168:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/xfs/xfs_ioctl32.c:168:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:168:13: sparse:     got unsigned long long *
   fs/xfs/xfs_ioctl32.c:169:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:169:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:169:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:170:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:170:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:170:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:171:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:171:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:171:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:172:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:172:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:172:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:173:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:173:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:173:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:174:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:174:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:174:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:175:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl32.c:175:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:175:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl32.c:179:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/xfs/xfs_ioctl32.c:179:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:179:13: sparse:     got signed long long *
   fs/xfs/xfs_ioctl32.c:180:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:180:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:180:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:181:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:181:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:181:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:182:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/xfs/xfs_ioctl32.c:182:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:182:13: sparse:     got signed int *
   fs/xfs/xfs_ioctl32.c:183:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:183:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:183:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:184:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:184:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:184:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:185:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:185:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:185:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:186:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:186:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:186:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:187:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:187:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:187:13: sparse:     got unsigned int *
   fs/xfs/xfs_ioctl32.c:188:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:188:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:188:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:189:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/xfs/xfs_ioctl32.c:189:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/xfs/xfs_ioctl32.c:189:13: sparse:     got unsigned short *
   fs/xfs/xfs_ioctl32.c:246:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/xfs/xfs_ioctl32.c:246:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
--
>> arch/x86/entry/common.c:161:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/entry/common.c:161:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/entry/common.c:161:23: sparse:     got unsigned int *
--
   arch/x86/kernel/ptrace.c:741:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   arch/x86/kernel/ptrace.c:741:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   arch/x86/kernel/ptrace.c:741:23: sparse:     got unsigned long *
>> arch/x86/kernel/ptrace.c:1057:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/ptrace.c:1057:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/ptrace.c:1057:31: sparse:     got unsigned int *
--
>> arch/x86/kernel/tls.c:138:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/tls.c:138:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/tls.c:138:21: sparse:     got unsigned int *
   arch/x86/kernel/tls.c:220:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
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
   kernel/ptrace.c:202:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:202:28: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:202:28: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:208:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:208:30: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:208:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:261:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:261:44: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:261:44: sparse:    struct task_struct *
   kernel/ptrace.c:452:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:452:24: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:452:24: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:477:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:477:26: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:477:26: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:513:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/ptrace.c:513:54: sparse:     expected struct task_struct *parent
   kernel/ptrace.c:513:54: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:521:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:521:53: sparse:     expected struct task_struct *new_parent
   kernel/ptrace.c:521:53: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:569:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:569:41: sparse:     expected struct task_struct *p1
   kernel/ptrace.c:569:41: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:571:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sigh @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/ptrace.c:571:50: sparse:     expected struct sighand_struct *sigh
   kernel/ptrace.c:571:50: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/ptrace.c:762:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:762:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:762:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:770:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:770:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:770:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:881:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:881:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:881:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:885:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:885:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:885:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1055:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/ptrace.c:1055:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/ptrace.c:1055:23: sparse:     got unsigned long *
   kernel/ptrace.c:1115:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1115:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1115:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1117:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1117:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1117:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1315:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/ptrace.c:1315:16: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/ptrace.c:1315:16: sparse:     got unsigned long *
>> kernel/ptrace.c:1346:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/ptrace.c:1346:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/ptrace.c:1346:31: sparse:     got unsigned int *
   kernel/ptrace.c:1357:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/ptrace.c:1357:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/ptrace.c:1357:23: sparse:     got unsigned int *
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:519:38: sparse: sparse: dereference of noderef expression
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:709:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:725:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1266:9: sparse: sparse: context imbalance in 'ptrace_request' - different lock contexts for basic block
--
   kernel/signal.c:3197:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3197:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3200:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3200:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3200:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3589:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3589:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3589:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3601:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3601:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3601:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3606:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3606:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3606:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3611:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3611:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3611:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4065:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4065:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4065:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4077:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4077:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4077:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4095:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *k @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:4095:11: sparse:     expected struct k_sigaction *k
   kernel/signal.c:4095:11: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:4097:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4097:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4097:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4099:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4099:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4099:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4147:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4147:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4147:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:69:34: sparse: sparse: dereference of noderef expression
   kernel/signal.c:529:35: sparse: sparse: dereference of noderef expression
   kernel/signal.c:557:52: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1038:13: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file:
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:21:13: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:     got struct wait_queue_head [noderef] __rcu *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:22:17: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:     got struct wait_queue_head [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1299:9: sparse: sparse: context imbalance in 'do_send_sig_info' - different lock contexts for basic block
   kernel/signal.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:737:9: sparse: sparse: context imbalance in '__lock_task_sighand' - different lock contexts for basic block
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c: note: in included file:
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:21:13: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:     got struct wait_queue_head [noderef] __rcu *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:22:17: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:     got struct wait_queue_head [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/rcupdate.h, include/linux/rbtree.h, include/linux/mm_types.h, ...):
   include/linux/rcutiny.h:114:44: sparse: sparse: context imbalance in 'send_sigqueue' - wrong count at exit
   kernel/signal.c:2068:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2068:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2068:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2068:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2383:13: sparse: sparse: context imbalance in 'do_signal_stop' - different lock contexts for basic block
   kernel/signal.c:2590:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2590:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2590:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2590:49: sparse: sparse: dereference of noderef expression
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2710:33: sparse: sparse: context imbalance in 'get_signal' - unexpected unlock
   kernel/signal.c:4066:33: sparse: sparse: dereference of noderef expression
   kernel/signal.c:4155:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4155:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4155:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4161:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4161:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4161:33: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/signal.c:4344:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4344:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4344:16: sparse:     got unsigned int *
>> kernel/signal.c:4451:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   kernel/signal.c:4451:23: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   kernel/signal.c:4451:23: sparse:     got unsigned int const *
   kernel/signal.c:4454:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   kernel/signal.c:4454:24: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   kernel/signal.c:4454:24: sparse:     got unsigned int const *
   kernel/signal.c:4458:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   kernel/signal.c:4458:24: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   kernel/signal.c:4458:24: sparse:     got unsigned int const *
   kernel/signal.c:4465:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4465:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4465:23: sparse:     got unsigned int *
   kernel/signal.c:4469:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4469:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4469:24: sparse:     got unsigned int *
   kernel/signal.c:4471:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4471:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4471:24: sparse:     got unsigned int *
--
>> kernel/uid16.c:125:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:125:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:125:21: sparse:     got unsigned short *
   kernel/uid16.c:141:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:141:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:141:21: sparse:     got unsigned short *
   kernel/uid16.c:74:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:74:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:74:26: sparse:     got unsigned short *
   kernel/uid16.c:75:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:75:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:75:26: sparse:     got unsigned short *
   kernel/uid16.c:76:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:76:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:76:26: sparse:     got unsigned short *
   kernel/uid16.c:97:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:97:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:97:26: sparse:     got unsigned short *
   kernel/uid16.c:98:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:98:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:98:26: sparse:     got unsigned short *
   kernel/uid16.c:99:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:99:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:99:26: sparse:     got unsigned short *
--
>> kernel/compat.c:50:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/compat.c:50:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/compat.c:50:21: sparse:     got unsigned int *
   kernel/compat.c:74:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/compat.c:74:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/compat.c:74:21: sparse:     got unsigned int *
--
>> kernel/kcov.c:711:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/kcov.c:711:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/kcov.c:711:21: sparse:     got unsigned int *
--
   fs/read_write.c:1291:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/read_write.c:1291:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/read_write.c:1291:21: sparse:     got long *
   fs/read_write.c:1295:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/read_write.c:1295:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/read_write.c:1295:21: sparse:     got long *
   fs/read_write.c:1312:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long long [noderef] __user *__ptr_clean @@     got long long * @@
   fs/read_write.c:1312:21: sparse:     expected long long [noderef] __user *__ptr_clean
   fs/read_write.c:1312:21: sparse:     got long long *
>> fs/read_write.c:1329:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/read_write.c:1329:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/read_write.c:1329:21: sparse:     got signed int *
   fs/read_write.c:1333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/read_write.c:1333:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/read_write.c:1333:21: sparse:     got signed int *
>> fs/read_write.c:1351:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/read_write.c:1351:21: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/read_write.c:1351:21: sparse:     got signed long long *
--
>> fs/exec.c:414:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   fs/exec.c:414:21: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   fs/exec.c:414:21: sparse:     got unsigned int const *
   fs/exec.c:415:39: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __user * @@     got void * @@
   fs/exec.c:415:39: sparse:     expected char const [noderef] __user *
   fs/exec.c:415:39: sparse:     got void *
   fs/exec.c:421:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *const [noderef] __user *__ptr_clean @@     got char const [noderef] __user *const * @@
   fs/exec.c:421:13: sparse:     expected char const [noderef] __user *const [noderef] __user *__ptr_clean
   fs/exec.c:421:13: sparse:     got char const [noderef] __user *const *
   fs/exec.c:422:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __user * @@     got void * @@
   fs/exec.c:422:31: sparse:     expected char const [noderef] __user *
   fs/exec.c:422:31: sparse:     got void *
   fs/exec.c:1051:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1051:48: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1051:48: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1158:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1158:56: sparse:     expected struct task_struct *parent
   fs/exec.c:1158:56: sparse:     got struct task_struct [noderef] __rcu *parent
   fs/exec.c:1193:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1193:47: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1193:47: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1766:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1766:70: sparse:     expected struct task_struct *tsk
   fs/exec.c:1766:70: sparse:     got struct task_struct [noderef] __rcu *parent
--
   fs/readdir.c:293:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/readdir.c:293:21: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/readdir.c:293:21: sparse:     got unsigned long *
   fs/readdir.c:377:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/readdir.c:377:21: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/readdir.c:377:21: sparse:     got signed long long *
>> fs/readdir.c:544:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/readdir.c:544:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/readdir.c:544:21: sparse:     got unsigned int *
--
>> fs/userfaultfd.c:1488:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/userfaultfd.c:1488:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/userfaultfd.c:1488:21: sparse:     got unsigned long long *
>> fs/userfaultfd.c:1721:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/userfaultfd.c:1721:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/userfaultfd.c:1721:13: sparse:     got signed long long *
   fs/userfaultfd.c:1773:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/userfaultfd.c:1773:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/userfaultfd.c:1773:13: sparse:     got signed long long *
   fs/userfaultfd.c:1884:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/userfaultfd.c:1884:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/userfaultfd.c:1884:13: sparse:     got signed long long *
--
   fs/compat_binfmt_elf.c: note: in included file:
>> fs/binfmt_elf.c:326:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:326:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:326:13: sparse:     got unsigned int *
   fs/binfmt_elf.c:333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:333:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:333:21: sparse:     got unsigned int *
   fs/binfmt_elf.c:340:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:340:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:340:13: sparse:     got unsigned int *
   fs/binfmt_elf.c:348:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:348:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:348:21: sparse:     got unsigned int *
   fs/binfmt_elf.c:355:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:355:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:355:13: sparse:     got unsigned int *
--
>> fs/crypto/keyring.c:1043:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/crypto/keyring.c:1043:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/crypto/keyring.c:1043:23: sparse:     got unsigned int *
--
>> fs/crypto/policy.c:474:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char const [noderef] __user *__ptr_clean @@     got unsigned char const * @@
   fs/crypto/policy.c:474:13: sparse:     expected unsigned char const [noderef] __user *__ptr_clean
   fs/crypto/policy.c:474:13: sparse:     got unsigned char const *
--
>> fs/verity/measure.c:42:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/verity/measure.c:42:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/verity/measure.c:42:13: sparse:     got unsigned short *
--
>> ipc/msg.c:679:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   ipc/msg.c:679:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   ipc/msg.c:679:21: sparse:     got unsigned int *
>> ipc/msg.c:685:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   ipc/msg.c:685:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   ipc/msg.c:685:21: sparse:     got unsigned short *
>> ipc/msg.c:960:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   ipc/msg.c:960:13: sparse:     expected long [noderef] __user *__ptr_clean
   ipc/msg.c:960:13: sparse:     got long *
>> ipc/msg.c:984:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   ipc/msg.c:984:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   ipc/msg.c:984:13: sparse:     got signed int *
   ipc/msg.c:1025:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   ipc/msg.c:1025:13: sparse:     expected long [noderef] __user *__ptr_clean
   ipc/msg.c:1025:13: sparse:     got long *
   ipc/msg.c:1276:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   ipc/msg.c:1276:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   ipc/msg.c:1276:13: sparse:     got signed int *
   ipc/msg.c:180:26: sparse: sparse: context imbalance in 'newque' - unexpected unlock
--
>> ipc/syscall.c:153:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   ipc/syscall.c:153:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   ipc/syscall.c:153:21: sparse:     got unsigned int *
   ipc/syscall.c:192:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   ipc/syscall.c:192:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   ipc/syscall.c:192:24: sparse:     got unsigned int *
--
   block/ioctl.c:58:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:58:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:58:13: sparse:     got int *
   block/ioctl.c:58:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   block/ioctl.c:58:39: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   block/ioctl.c:58:39: sparse:     got void [noderef] __user **
>> block/ioctl.c:78:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   block/ioctl.c:78:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   block/ioctl.c:78:13: sparse:     got signed int *
   block/ioctl.c:78:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:78:39: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:78:39: sparse:     got unsigned int *
   block/ioctl.c:197:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   block/ioctl.c:197:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   block/ioctl.c:197:16: sparse:     got unsigned short *
   block/ioctl.c:202:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:202:16: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:202:16: sparse:     got int *
   block/ioctl.c:207:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:207:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:207:16: sparse:     got unsigned int *
   block/ioctl.c:212:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   block/ioctl.c:212:16: sparse:     expected long [noderef] __user *__ptr_clean
   block/ioctl.c:212:16: sparse:     got long *
   block/ioctl.c:217:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   block/ioctl.c:217:16: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   block/ioctl.c:217:16: sparse:     got unsigned long *
   block/ioctl.c:222:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   block/ioctl.c:222:16: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   block/ioctl.c:222:16: sparse:     got unsigned long long *
   block/ioctl.c:228:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   block/ioctl.c:228:16: sparse:     expected signed int [noderef] __user *__ptr_clean
   block/ioctl.c:228:16: sparse:     got signed int *
   block/ioctl.c:233:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:233:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:233:16: sparse:     got unsigned int *
   block/ioctl.c:365:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:365:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:365:13: sparse:     got int *
   block/ioctl.c:433:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:433:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:433:16: sparse:     got unsigned int *
   block/ioctl.c:451:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:451:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:451:13: sparse:     got int *
--
>> drivers/ata/libata-scsi.c:569:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/ata/libata-scsi.c:569:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/ata/libata-scsi.c:569:32: sparse:     got unsigned int *
   drivers/ata/libata-scsi.c:571:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/ata/libata-scsi.c:571:24: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/ata/libata-scsi.c:571:24: sparse:     got unsigned long *
--
>> kernel/power/user.c:309:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/power/user.c:309:33: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/power/user.c:309:33: sparse:     got int *
>> kernel/power/user.c:351:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long long [noderef] __user *__ptr_clean @@     got long long * @@
   kernel/power/user.c:351:25: sparse:     expected long long [noderef] __user *__ptr_clean
   kernel/power/user.c:351:25: sparse:     got long long *
   kernel/power/user.c:357:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long long [noderef] __user *__ptr_clean @@     got long long * @@
   kernel/power/user.c:357:25: sparse:     expected long long [noderef] __user *__ptr_clean
   kernel/power/user.c:357:25: sparse:     got long long *
   kernel/power/user.c:368:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long long [noderef] __user *__ptr_clean @@     got long long * @@
   kernel/power/user.c:368:33: sparse:     expected long long [noderef] __user *__ptr_clean
   kernel/power/user.c:368:33: sparse:     got long long *
--
>> drivers/fsi/fsi-sbefifo.c:942:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/fsi/fsi-sbefifo.c:942:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/fsi/fsi-sbefifo.c:942:13: sparse:     got unsigned int *
--
>> net/compat.c:153:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/compat.c:153:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/compat.c:153:21: sparse:     got unsigned int *
>> net/compat.c:305:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   net/compat.c:305:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   net/compat.c:305:23: sparse:     got signed int *
   net/compat.c:307:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   net/compat.c:307:31: sparse:     expected signed int [noderef] __user *__ptr_clean
   net/compat.c:307:31: sparse:     got signed int *
   net/compat.c:309:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/compat.c:309:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/compat.c:309:31: sparse:     got unsigned int *
--
>> drivers/hid/hidraw.c:381:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/hidraw.c:381:29: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/hidraw.c:381:29: sparse:     got int *
   drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/hidraw.c:389:37: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/hidraw.c:389:37: sparse:     got int *
--
>> drivers/hwmon/fschmd.c:866:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/hwmon/fschmd.c:866:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:866:37: sparse:     got char const *
>> drivers/hwmon/fschmd.c:900:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:900:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:900:23: sparse:     got int *
   drivers/hwmon/fschmd.c:905:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:905:31: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:905:31: sparse:     got int *
   drivers/hwmon/fschmd.c:907:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:907:31: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:907:31: sparse:     got int *
   drivers/hwmon/fschmd.c:916:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:916:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:916:23: sparse:     got int *
   drivers/hwmon/fschmd.c:920:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:920:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:920:21: sparse:     got int *
   drivers/hwmon/fschmd.c:926:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:926:31: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:926:31: sparse:     got int *
   drivers/hwmon/fschmd.c:930:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/fschmd.c:930:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/fschmd.c:930:21: sparse:     got int *
--
>> drivers/i2c/i2c-dev.c:432:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/i2c/i2c-dev.c:432:24: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/i2c/i2c-dev.c:432:24: sparse:     got unsigned long *
>> drivers/i2c/i2c-dev.c:526:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/i2c/i2c-dev.c:526:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/i2c/i2c-dev.c:526:24: sparse:     got unsigned int *

vim +878 kernel/futex/core.c

04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  852  
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  853  /*
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  854   * Walk curr->robust_list (very carefully, it's a userspace list!)
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  855   * and mark any locks found there dead, and notify any waiters.
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  856   *
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  857   * We silently return on any sign of list-walking problem.
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  858   */
ba31c1a48538992 kernel/futex.c      Thomas Gleixner 2019-11-06  859  static void compat_exit_robust_list(struct task_struct *curr)
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  860  {
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  861  	struct compat_robust_list_head __user *head = curr->compat_robust_list;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  862  	struct robust_list __user *entry, *next_entry, *pending;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  863  	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
3f649ab728cda80 kernel/futex.c      Kees Cook       2020-06-03  864  	unsigned int next_pi;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  865  	compat_uptr_t uentry, next_uentry, upending;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  866  	compat_long_t futex_offset;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  867  	int rc;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  868  
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  869  	/*
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  870  	 * Fetch the list head (which was registered earlier, via
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  871  	 * sys_set_robust_list()):
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  872  	 */
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  873  	if (compat_fetch_robust_entry(&uentry, &entry, &head->list.next, &pi))
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  874  		return;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  875  	/*
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  876  	 * Fetch the relative futex offset:
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  877  	 */
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17 @878  	if (get_user(futex_offset, &head->futex_offset))
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  879  		return;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  880  	/*
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  881  	 * Fetch any possibly pending lock-add first, and handle it
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  882  	 * if it exists:
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  883  	 */
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  884  	if (compat_fetch_robust_entry(&upending, &pending,
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  885  			       &head->list_op_pending, &pip))
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  886  		return;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  887  
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  888  	next_entry = NULL;	/* avoid warning with gcc */
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  889  	while (entry != (struct robust_list __user *) &head->list) {
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  890  		/*
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  891  		 * Fetch the next entry in the list before calling
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  892  		 * handle_futex_death:
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  893  		 */
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  894  		rc = compat_fetch_robust_entry(&next_uentry, &next_entry,
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  895  			(compat_uptr_t __user *)&entry->next, &next_pi);
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  896  		/*
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  897  		 * A pending lock might already be on the list, so
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  898  		 * dont process it twice:
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  899  		 */
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  900  		if (entry != pending) {
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  901  			void __user *uaddr = futex_uaddr(entry, futex_offset);
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  902  
ca16d5bee59807b kernel/futex.c      Yang Tao        2019-11-06  903  			if (handle_futex_death(uaddr, curr, pi,
ca16d5bee59807b kernel/futex.c      Yang Tao        2019-11-06  904  					       HANDLE_DEATH_LIST))
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  905  				return;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  906  		}
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  907  		if (rc)
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  908  			return;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  909  		uentry = next_uentry;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  910  		entry = next_entry;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  911  		pi = next_pi;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  912  		/*
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  913  		 * Avoid excessively long or circular lists:
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  914  		 */
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  915  		if (!--limit)
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  916  			break;
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  917  
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  918  		cond_resched();
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  919  	}
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  920  	if (pending) {
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  921  		void __user *uaddr = futex_uaddr(pending, futex_offset);
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  922  
ca16d5bee59807b kernel/futex.c      Yang Tao        2019-11-06  923  		handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  924  	}
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  925  }
af8cc9600bbf225 kernel/futex/core.c Peter Zijlstra  2021-09-23  926  #endif
04e7712f4460585 kernel/futex.c      Arnd Bergmann   2018-04-17  927  

:::::: The code at line 878 was first introduced by commit
:::::: 04e7712f4460585e5eed5b853fd8b82a9943958f y2038: futex: Move compat implementation into futex.c

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--D49ob4yFRDnY1HjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.0.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-5) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23890
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23890
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_UAPI_HEADER_TEST=y
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
CONFIG_KERNEL_LZMA=y
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_IO_URING is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_KCMP is not set
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
# CONFIG_MTRR is not set
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
CONFIG_ACORN_PARTITION_EESOX=y
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
# CONFIG_COMPACTION is not set
# CONFIG_PAGE_REPORTING is not set
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
CONFIG_ZONE_DMA32=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER=y
CONFIG_PTE_MARKER_UFFD_WP=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=y
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=y
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_SWAP=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
CONFIG_MTD_MAP_BANK_WIDTH_2=y
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
# CONFIG_MTD_CFI_I1 is not set
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_PHYSMAP_VERSATILE is not set
# CONFIG_MTD_PHYSMAP_GEMINI is not set
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
CONFIG_MTD_MCHP23K256=y
# CONFIG_MTD_MCHP48L640 is not set
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y
# CONFIG_MTD_NAND_CADENCE is not set
# CONFIG_MTD_NAND_ARASAN is not set
# CONFIG_MTD_NAND_INTEL_LGM is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_NAND_ECC_SW_BCH=y
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_MTD_HYPERBUS=y
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_FC=y
# CONFIG_NVME_TARGET_FCLOOP is not set
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_AD525X_DPOT_SPI=y
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HI6421V600_IRQ is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
CONFIG_SCSI_DH_HP_SW=y
# CONFIG_SCSI_DH_EMC is not set
# CONFIG_SCSI_DH_ALUA is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_CEVA is not set
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
CONFIG_PATA_PLATFORM=y
CONFIG_PATA_OF_PLATFORM=y
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
CONFIG_BCACHE=y
CONFIG_BCACHE_DEBUG=y
CONFIG_BCACHE_CLOSURES_DEBUG=y
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=y
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
# CONFIG_DM_UNSTRIPED is not set
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
CONFIG_DM_THIN_PROVISIONING=y
# CONFIG_DM_CACHE is not set
CONFIG_DM_WRITECACHE=y
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=y
CONFIG_DM_CLONE=y
CONFIG_DM_MIRROR=y
# CONFIG_DM_LOG_USERSPACE is not set
# CONFIG_DM_RAID is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
CONFIG_DM_DELAY=y
CONFIG_DM_DUST=y
# CONFIG_DM_INIT is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=y
CONFIG_DM_VERITY=y
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
# CONFIG_DM_SWITCH is not set
CONFIG_DM_LOG_WRITES=y
# CONFIG_DM_INTEGRITY is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=y
# CONFIG_JOYSTICK_ADC is not set
# CONFIG_JOYSTICK_ADI is not set
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
CONFIG_JOYSTICK_GAMECON=y
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_WALKERA0701=y
CONFIG_JOYSTICK_PSXPAD_SPI=y
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_QWIIC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
# CONFIG_JOYSTICK_SENSEHAT is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
# CONFIG_RMI4_F11 is not set
CONFIG_RMI4_F12=y
# CONFIG_RMI4_F30 is not set
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_CCTRNG is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_DEVMEM is not set
# CONFIG_NVRAM is not set
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
# CONFIG_TCG_TIS is not set
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TCG_TIS_ST33ZP24_SPI=y
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_FSI=y
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
# CONFIG_SVC_I3C_MASTER is not set
# CONFIG_MIPI_I3C_HCI is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CADENCE_QUADSPI is not set
# CONFIG_SPI_CADENCE_XSPI is not set
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_DMA is not set
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_FSI is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_INTEL_PCI is not set
# CONFIG_SPI_INTEL_PLATFORM is not set
CONFIG_SPI_LM70_LLP=y
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SIFIVE=y
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_AXP209 is not set
# CONFIG_PINCTRL_DA9062 is not set
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
CONFIG_PINCTRL_OCELOT=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_LOCHNAGAR=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_GW_PLD is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_BD9571MWV is not set
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
# CONFIG_GPIO_MAX77650 is not set
CONFIG_GPIO_RC5T583=y
# CONFIG_GPIO_TPS65910 is not set
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TWL4030 is not set
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
CONFIG_GPIO_MAX3191X=y
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set
CONFIG_GPIO_MOXTET=y
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CPCAP=y
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_DA9052=y
CONFIG_AXP20X_POWER=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_BATTERY_TWL4030_MADC=y
# CONFIG_BATTERY_RX51 is not set
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_TWL4030 is not set
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77650=y
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_MAX8997 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=y
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
CONFIG_I8K=y
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=y
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LOCHNAGAR=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_MLXREG_FAN=y
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_ADCXX=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SY7636A is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_CPU_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9055_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_RAVE_SP_WATCHDOG=y
CONFIG_MLX_WDT=y
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_TWL4030_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
# CONFIG_KEMPLD_WDT is not set
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=y
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_MFD_HI6421_SPMI is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77714 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=y
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
# CONFIG_MFD_WCD934X is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_RAVE_SP_CORE=y
# CONFIG_MFD_INTEL_M10_BMC is not set
# CONFIG_MFD_RSMU_I2C is not set
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AXP20X=y
# CONFIG_REGULATOR_BD718XX is not set
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LOCHNAGAR=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77802 is not set
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6315 is not set
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCAP=y
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RC5T583=y
# CONFIG_REGULATOR_RT4801 is not set
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS6286X is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS65217 is not set
CONFIG_REGULATOR_TPS6524X=y
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TWL4030 is not set
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8400=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
# CONFIG_RC_CORE is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=y
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_V4L2_FLASH_LED_CLASS is not set
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
# CONFIG_RADIO_SI470X is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
# CONFIG_VIDEO_CADENCE_CSI2TX is not set

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=y
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_SMS_SIANO_MDTV=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# Camera sensor devices
#
# CONFIG_VIDEO_AR0521 is not set
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX334 is not set
# CONFIG_VIDEO_IMX335 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_IMX412 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
CONFIG_VIDEO_MT9M111=y
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5640 is not set
# CONFIG_VIDEO_OV5645 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9282 is not set
CONFIG_VIDEO_OV9640=y
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_M5MOLS is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_SONY_BTF_MPX=y
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_TLV320AIC23B=y
# CONFIG_VIDEO_TVAUDIO is not set
CONFIG_VIDEO_UDA1342=y
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
CONFIG_VIDEO_ADV7183=y
# CONFIG_VIDEO_ADV748X is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_ISL7998X is not set
CONFIG_VIDEO_KS0127=y
# CONFIG_VIDEO_MAX9286 is not set
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=y
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_AD9389B is not set
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
# CONFIG_VIDEO_ADV7343 is not set
CONFIG_VIDEO_ADV7393=y
# CONFIG_VIDEO_ADV7511 is not set
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
CONFIG_VIDEO_UPD64083=y
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=y
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
CONFIG_VIDEO_THS7303=y
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# CONFIG_VIDEO_GS1662 is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
# CONFIG_MEDIA_TUNER_FC2580 is not set
# CONFIG_MEDIA_TUNER_IT913X is not set
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MXL301RF=y
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_QM1D1B0004=y
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QT1010=y
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
# CONFIG_MEDIA_TUNER_TDA18212 is not set
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=y
# CONFIG_DVB_MXL5XX is not set
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
# CONFIG_DVB_STV0910 is not set
CONFIG_DVB_STV6110x=y
CONFIG_DVB_STV6111=y

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y
CONFIG_DVB_SI2165=y
# CONFIG_DVB_TDA18271C2DD is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
CONFIG_DVB_CX24120=y
CONFIG_DVB_CX24123=y
# CONFIG_DVB_DS3000 is not set
CONFIG_DVB_MB86A16=y
# CONFIG_DVB_MT312 is not set
CONFIG_DVB_S5H1420=y
# CONFIG_DVB_SI21XX is not set
CONFIG_DVB_STB6000=y
# CONFIG_DVB_STV0288 is not set
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV0900=y
# CONFIG_DVB_STV6110 is not set
# CONFIG_DVB_TDA10071 is not set
CONFIG_DVB_TDA10086=y
# CONFIG_DVB_TDA8083 is not set
CONFIG_DVB_TDA8261=y
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_VES1X93=y
# CONFIG_DVB_ZL10036 is not set
# CONFIG_DVB_ZL10039 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=y
# CONFIG_DVB_CX22700 is not set
# CONFIG_DVB_CX22702 is not set
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=y
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_DRXD=y
CONFIG_DVB_EC100=y
# CONFIG_DVB_L64781 is not set
# CONFIG_DVB_MT352 is not set
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
# CONFIG_DVB_S5H1432 is not set
# CONFIG_DVB_SI2168 is not set
CONFIG_DVB_SP887X=y
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_TDA10048=y
CONFIG_DVB_TDA1004X=y
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_ZL10353=y
CONFIG_DVB_CXD2880=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=y
CONFIG_DVB_TDA10021=y
# CONFIG_DVB_TDA10023 is not set
CONFIG_DVB_VES1820=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
# CONFIG_DVB_AU8522_V4L is not set
CONFIG_DVB_BCM3510=y
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_LGDT3305=y
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LGDT330X=y
# CONFIG_DVB_MXL692 is not set
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
# CONFIG_DVB_OR51211 is not set
CONFIG_DVB_S5H1409=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_DIB8000 is not set
CONFIG_DVB_MB86A20S=y
# CONFIG_DVB_S921 is not set

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=y
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_A8293 is not set
CONFIG_DVB_AF9033=y
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_HELENE=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
# CONFIG_DVB_LNBH25 is not set
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_M88RS2000=y
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_DRX39XYJ=y

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
# CONFIG_DVB_SP2 is not set
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
# CONFIG_LCD_TDO24M is not set
CONFIG_LCD_VGG2432A4=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_AMS369FG06=y
# CONFIG_LCD_LMS501KF03 is not set
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_RAVE_SP is not set
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LCD is not set
# CONFIG_HID_PICOLCD_LEDS is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_ELAN is not set
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SPI=y
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_CPCAP=y
CONFIG_LEDS_CR0014114=y
# CONFIG_LEDS_EL15203000 is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77650=y
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_SPI_BYTE=y
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_TPS6105X=y
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_RT4505 is not set
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=y
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
CONFIG_CHROMEOS_LAPTOP=y
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_EC is not set
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_SENSORS_HDAPS=y
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_PMC_CORE is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
# CONFIG_P2SB is not set
# CONFIG_COMMON_CLK is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_AMD_IOMMU is not set
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_DMA is not set
# CONFIG_IIO_BUFFER_DMAENGINE is not set
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
CONFIG_ADIS16201=y
CONFIG_ADIS16209=y
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL313_SPI is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
# CONFIG_ADXL367_SPI is not set
# CONFIG_ADXL367_I2C is not set
CONFIG_ADXL372=y
# CONFIG_ADXL372_SPI is not set
CONFIG_ADXL372_I2C=y
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
# CONFIG_BMI088_ACCEL is not set
CONFIG_DA280=y
# CONFIG_DA311 is not set
CONFIG_DMARD06=y
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
# CONFIG_FXLS8962AF_I2C is not set
# CONFIG_FXLS8962AF_SPI is not set
CONFIG_HID_SENSOR_ACCEL_3D=y
CONFIG_KXSD9=y
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_SCA3000=y
# CONFIG_SCA3300 is not set
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
# CONFIG_AD7091R5 is not set
CONFIG_AD7124=y
# CONFIG_AD7192 is not set
CONFIG_AD7266=y
# CONFIG_AD7280 is not set
CONFIG_AD7291=y
# CONFIG_AD7292 is not set
CONFIG_AD7298=y
CONFIG_AD7476=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD7606_IFACE_SPI=y
CONFIG_AD7766=y
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
CONFIG_AD7793=y
CONFIG_AD7887=y
CONFIG_AD7923=y
CONFIG_AD7949=y
# CONFIG_AD799X is not set
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_AXP20X_ADC is not set
# CONFIG_AXP288_ADC is not set
# CONFIG_CPCAP_ADC is not set
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_HI8435 is not set
CONFIG_HX711=y
CONFIG_LTC2471=y
CONFIG_LTC2485=y
# CONFIG_LTC2496 is not set
CONFIG_LTC2497=y
# CONFIG_MAX1027 is not set
CONFIG_MAX11100=y
CONFIG_MAX1118=y
# CONFIG_MAX1241 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=y
CONFIG_MCP3422=y
# CONFIG_MCP3911 is not set
CONFIG_NAU7802=y
CONFIG_QCOM_VADC_COMMON=y
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=y
CONFIG_QCOM_SPMI_ADC5=y
CONFIG_SD_ADC_MODULATOR=y
CONFIG_TI_ADC081C=y
CONFIG_TI_ADC0832=y
CONFIG_TI_ADC084S021=y
CONFIG_TI_ADC12138=y
CONFIG_TI_ADC108S102=y
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=y
CONFIG_TI_ADS7950=y
CONFIG_TI_ADS8344=y
CONFIG_TI_ADS8688=y
CONFIG_TI_ADS124S08=y
# CONFIG_TI_ADS131E08 is not set
# CONFIG_TI_AM335X_ADC is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_TI_TSC2046 is not set
CONFIG_TWL4030_MADC=y
# CONFIG_TWL6030_GPADC is not set
CONFIG_VF610_ADC=y
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_AD74413R is not set
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_ADA4250 is not set
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_ATLAS_EZO_SENSOR is not set
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
CONFIG_PMS7003=y
# CONFIG_SCD30_CORE is not set
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SENSIRION_SGP40 is not set
# CONFIG_SPS30_I2C is not set
# CONFIG_SPS30_SERIAL is not set
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=y
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD3552R is not set
CONFIG_AD5064=y
# CONFIG_AD5360 is not set
CONFIG_AD5380=y
CONFIG_AD5421=y
# CONFIG_AD5446 is not set
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
# CONFIG_AD5593R is not set
CONFIG_AD5504=y
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC2688 is not set
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
CONFIG_AD5696_I2C=y
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
CONFIG_AD5764=y
# CONFIG_AD5766 is not set
# CONFIG_AD5770R is not set
CONFIG_AD5791=y
# CONFIG_AD7293 is not set
# CONFIG_AD7303 is not set
CONFIG_AD8801=y
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_LTC1660=y
CONFIG_LTC2632=y
# CONFIG_M62332 is not set
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
CONFIG_MCP4922=y
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=y
CONFIG_TI_DAC7311=y
CONFIG_TI_DAC7612=y
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=y
CONFIG_IIO_SIMPLE_DUMMY=y
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y
# CONFIG_ADF4371 is not set
# CONFIG_ADMV4420 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
CONFIG_ADIS16130=y
CONFIG_ADIS16136=y
CONFIG_ADIS16260=y
# CONFIG_ADXRS290 is not set
# CONFIG_ADXRS450 is not set
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_FXAS21002C_SPI=y
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
# CONFIG_HDC2010 is not set
CONFIG_HID_SENSOR_HUMIDITY=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16475 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
CONFIG_KMX61=y
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_INV_MPU6050_SPI=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_AS73211 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM3605=y
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=y
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# CONFIG_SENSORS_RM3100_SPI is not set
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE is not set
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=y
CONFIG_MCP4018=y
# CONFIG_MCP4131 is not set
CONFIG_MCP4531=y
# CONFIG_MCP41010 is not set
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=y
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
CONFIG_MPL115=y
# CONFIG_MPL115_I2C is not set
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
# CONFIG_T5403 is not set
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=y
# CONFIG_PING is not set
CONFIG_RFD77402=y
CONFIG_SRF04=y
# CONFIG_SX9310 is not set
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
CONFIG_SX9500=y
CONFIG_SRF08=y
# CONFIG_VCNL3020 is not set
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_HID_SENSOR_TEMP=y
CONFIG_MLX90614=y
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
CONFIG_TMP007=y
# CONFIG_TMP117 is not set
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
CONFIG_MAX31856=y
# CONFIG_MAX31865 is not set
# end of Temperature sensors

# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
CONFIG_PWM_TWL=y
# CONFIG_PWM_TWL_LED is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SALVO is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=y
# CONFIG_BLK_DEV_PMEM is not set
# CONFIG_BTT is not set
CONFIG_OF_PMEM=y
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_RAVE_SP_EEPROM is not set
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_ICE40_SPI=y
CONFIG_FPGA_MGR_MACHXO2_SPI=y
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=y
# CONFIG_FSI_MASTER_ASPEED is not set
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=y
CONFIG_FSI_OCC=y
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_CACHEFILES is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
CONFIG_NOINSTR_VALIDATION=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
# CONFIG_KCOV_ENABLE_COMPARISONS is not set
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--D49ob4yFRDnY1HjA--
