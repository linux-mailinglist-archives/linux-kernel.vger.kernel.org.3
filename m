Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A045885E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiHCCkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiHCCku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:40:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7423336D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 19:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659494446; x=1691030446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yVFhvIS7NQeKYiY0GSlS4yMwyPXgUNByClDnGPPpBUo=;
  b=AgJIXQhdwVOd2rvy7bw8qjbOQcJsxYbCJxKtGcNZHi8+iXhYlnC4SMlz
   gTQ7HjhWiLF6VJ2jjf/T87pIaHctlsmG+EAiJmCvpf/LJNqHiAzjuLOLL
   0wkDXXYJ4kQIxovYrqSc7wBlEeydFq6hXJG+eR9UEr/iwujWYVHVn1HvO
   n3exj76dCiXnITHtZ66YM9uoi63w+T3DMM9DUHAzdmDU1fqeK72faRpSf
   DVyWmzVGkeS4a3tOnHSGsW5rtPUUyq9+wZL73/khkpIk0bI9q4RMr7CnD
   vRCyfml/LSMCQiqiL4bUIwFq7jIIW0UdcM9PbXbRTyUtI6M/VzDCA7Gfq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="289577583"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="289577583"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 19:40:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="744897226"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2022 19:40:44 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ4JP-000GiB-1z;
        Wed, 03 Aug 2022 02:40:43 +0000
Date:   Wed, 3 Aug 2022 10:40:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/kgdb.c:310:38: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202208031043.E7TRI29G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1dbe9a1c86da098a29dcdca1a67b65e2de7ec3a
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   1 year, 11 months ago
config: sh-randconfig-s052-20220731 (https://download.01.org/0day-ci/archive/20220803/202208031043.E7TRI29G-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/ block/ drivers/hid/ drivers/input/serio/ drivers/net/hamradio/ drivers/scsi/ drivers/staging/greybus/ drivers/tty/ drivers/usb/core/ drivers/watchdog/ fs/ kernel/ net/ sound/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/sh/kernel/kgdb.c:49:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long pc @@
   arch/sh/kernel/kgdb.c:49:26: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/kgdb.c:49:26: sparse:     got unsigned long pc
   arch/sh/kernel/kgdb.c:146:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got long @@
   arch/sh/kernel/kgdb.c:146:26: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/kgdb.c:146:26: sparse:     got long
   arch/sh/kernel/kgdb.c:160:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long static [assigned] [toplevel] stepped_address @@
   arch/sh/kernel/kgdb.c:160:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/kgdb.c:160:17: sparse:     got unsigned long static [assigned] [toplevel] stepped_address
>> arch/sh/kernel/kgdb.c:310:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/kgdb.c:310:38: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/kgdb.c:310:38: sparse:     got unsigned long
--
   drivers/watchdog/watchdog_dev.c:683:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/watchdog/watchdog_dev.c:683:21: sparse:     expected char const *__gu_addr
   drivers/watchdog/watchdog_dev.c:683:21: sparse:     got char const [noderef] __user *
>> drivers/watchdog/watchdog_dev.c:683:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/watchdog/watchdog_dev.c:683:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:683:21: sparse:     got char const *__gu_addr
   drivers/watchdog/watchdog_dev.c:749:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/watchdog_dev.c:749:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/watchdog_dev.c:749:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/watchdog_dev.c:749:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/watchdog_dev.c:749:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:749:21: sparse:     got int const *__gu_addr
   drivers/watchdog/watchdog_dev.c:769:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/watchdog_dev.c:769:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/watchdog_dev.c:769:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/watchdog_dev.c:769:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/watchdog_dev.c:769:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:769:21: sparse:     got int const *__gu_addr
   drivers/watchdog/watchdog_dev.c:798:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/watchdog_dev.c:798:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/watchdog_dev.c:798:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/watchdog_dev.c:798:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/watchdog_dev.c:798:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:798:21: sparse:     got int const *__gu_addr
--
   drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected char const *__gu_addr
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const [noderef] __user *
>> drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const *__gu_addr
   drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int const *__gu_addr
--
   drivers/usb/core/devio.c:937:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:937:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:937:13: sparse:     got unsigned int [noderef] __user *
>> drivers/usb/core/devio.c:937:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:937:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:937:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:938:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:938:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:938:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:938:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:938:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:938:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:953:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   drivers/usb/core/devio.c:953:21: sparse:     expected unsigned char const *__gu_addr
   drivers/usb/core/devio.c:953:21: sparse:     got unsigned char [noderef] __user *
>> drivers/usb/core/devio.c:953:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   drivers/usb/core/devio.c:953:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:953:21: sparse:     got unsigned char const *__gu_addr
   drivers/usb/core/devio.c:1290:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:1290:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1290:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:1290:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:1290:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1290:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1309:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:1309:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1309:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:1309:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:1309:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1309:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1441:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/usb/core/devio.c:1441:13: sparse:     expected int const *__gu_addr
   drivers/usb/core/devio.c:1441:13: sparse:     got int [noderef] __user *
>> drivers/usb/core/devio.c:1441:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/usb/core/devio.c:1441:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1441:13: sparse:     got int const *__gu_addr
   drivers/usb/core/devio.c:2189:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2189:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2189:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2189:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2189:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2189:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2199:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2199:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2199:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2199:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2199:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2199:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2315:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2315:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2315:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2315:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2315:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2315:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2328:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2328:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2328:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2328:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2328:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2328:13: sparse:     got unsigned int const *__gu_addr
--
   kernel/futex.c:1993:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr1 @@
   kernel/futex.c:1993:31: sparse:     expected unsigned int const *__gu_addr
   kernel/futex.c:1993:31: sparse:     got unsigned int [noderef] [usertype] __user *uaddr1
>> kernel/futex.c:1993:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/futex.c:1993:31: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:1993:31: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:2647:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   kernel/futex.c:2647:23: sparse:     expected unsigned int const *__gu_addr
   kernel/futex.c:2647:23: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex.c:2647:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/futex.c:2647:23: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:2647:23: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:2955:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   kernel/futex.c:2955:13: sparse:     expected unsigned int const *__gu_addr
   kernel/futex.c:2955:13: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex.c:2955:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/futex.c:2955:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:2955:13: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:3428:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   kernel/futex.c:3428:13: sparse:     expected unsigned int const *__gu_addr
   kernel/futex.c:3428:13: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex.c:3428:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/futex.c:3428:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:3428:13: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:3566:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   kernel/futex.c:3566:13: sparse:     expected long const *__gu_addr
   kernel/futex.c:3566:13: sparse:     got long [noderef] __user *
>> kernel/futex.c:3566:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long const *__gu_addr @@
   kernel/futex.c:3566:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:3566:13: sparse:     got long const *__gu_addr
   kernel/futex.c: note: in included file (through arch/sh/include/asm/futex.h):
   arch/sh/include/asm/futex-irq.h:15:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     expected unsigned int const *__gu_addr
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
>> arch/sh/include/asm/futex-irq.h:15:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:1544:9: sparse: sparse: context imbalance in 'wake_futex_pi' - unexpected unlock
   kernel/futex.c: note: in included file:
   arch/sh/include/asm/futex.h:36:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/sh/include/asm/futex.h:36:23: sparse:     expected unsigned int const *__gu_addr
   arch/sh/include/asm/futex.h:36:23: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
>> arch/sh/include/asm/futex.h:36:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   arch/sh/include/asm/futex.h:36:23: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/include/asm/futex.h:36:23: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c: note: in included file (through arch/sh/include/asm/futex.h):
   arch/sh/include/asm/futex-irq.h:15:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     expected unsigned int const *__gu_addr
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
>> arch/sh/include/asm/futex-irq.h:15:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/include/asm/futex-irq.h:15:15: sparse:     got unsigned int const *__gu_addr
   kernel/futex.c:1708:25: sparse: sparse: context imbalance in 'futex_wake_op' - different lock contexts for basic block
   kernel/futex.c:1990:41: sparse: sparse: context imbalance in 'futex_requeue' - different lock contexts for basic block
   kernel/futex.c:2453:9: sparse: sparse: context imbalance in 'fixup_pi_state_owner' - unexpected unlock
   kernel/futex.c:2561:13: sparse: sparse: context imbalance in 'futex_wait_queue_me' - unexpected unlock
   kernel/futex.c:2662:9: sparse: sparse: context imbalance in 'futex_wait_setup' - different lock contexts for basic block
   kernel/futex.c:2943:12: sparse: sparse: context imbalance in 'futex_unlock_pi' - different lock contexts for basic block
   kernel/futex.c:3218:29: sparse: sparse: context imbalance in 'futex_wait_requeue_pi' - unexpected unlock
   kernel/futex.c:3530:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user * @@
   kernel/futex.c:3530:13: sparse:     expected unsigned long const *__gu_addr
   kernel/futex.c:3530:13: sparse:     got unsigned long [noderef] __user *
>> kernel/futex.c:3530:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   kernel/futex.c:3530:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:3530:13: sparse:     got unsigned long const *__gu_addr
   kernel/futex.c:3530:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user * @@
   kernel/futex.c:3530:13: sparse:     expected unsigned long const *__gu_addr
   kernel/futex.c:3530:13: sparse:     got unsigned long [noderef] __user *
>> kernel/futex.c:3530:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   kernel/futex.c:3530:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:3530:13: sparse:     got unsigned long const *__gu_addr
   kernel/futex.c:3530:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user * @@
   kernel/futex.c:3530:13: sparse:     expected unsigned long const *__gu_addr
   kernel/futex.c:3530:13: sparse:     got unsigned long [noderef] __user *
>> kernel/futex.c:3530:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   kernel/futex.c:3530:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex.c:3530:13: sparse:     got unsigned long const *__gu_addr
--
   fs/binfmt_elf_fdpic.c:858:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:858:37: sparse:     expected signed int const *__gu_addr
   fs/binfmt_elf_fdpic.c:858:37: sparse:     got signed int [noderef] __user *
>> fs/binfmt_elf_fdpic.c:858:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   fs/binfmt_elf_fdpic.c:858:37: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_elf_fdpic.c:858:37: sparse:     got signed int const *__gu_addr
   fs/binfmt_elf_fdpic.c:618:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:618:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:618:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:622:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:622:17: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:622:17: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:629:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:629:17: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:629:17: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:636:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:636:17: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:636:17: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:641:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:641:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:641:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:645:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:645:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:645:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:646:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:646:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:646:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:647:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:647:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:647:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:648:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:648:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:648:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:649:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:649:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:649:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:650:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:650:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:650:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:651:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:651:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:651:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:652:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:652:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:652:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:653:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:653:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:653:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:654:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:654:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:654:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:655:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:655:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:655:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:656:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:656:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:656:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:657:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:657:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:657:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:658:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:658:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:658:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:667:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:667:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:667:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:667:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:667:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:667:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:667:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:667:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:667:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:667:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:667:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:667:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:667:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct <noident> [noderef] __user * @@
   fs/binfmt_elf_fdpic.c:667:9: sparse:     expected void const *from
   fs/binfmt_elf_fdpic.c:667:9: sparse:     got struct <noident> [noderef] __user *
   fs/binfmt_elf_fdpic.c:694:21: sparse: sparse: cast removes address space '__user' of expression
   fs/binfmt_elf_fdpic.c:981:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *__cl_addr @@     got void * @@
   fs/binfmt_elf_fdpic.c:981:29: sparse:     expected void [noderef] __user *__cl_addr
   fs/binfmt_elf_fdpic.c:981:29: sparse:     got void *
   fs/binfmt_elf_fdpic.c:981:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user *__cl_addr @@
   fs/binfmt_elf_fdpic.c:981:29: sparse:     expected void *addr
   fs/binfmt_elf_fdpic.c:981:29: sparse:     got void [noderef] __user *__cl_addr
   fs/binfmt_elf_fdpic.c:1115:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user *__cl_addr @@
   fs/binfmt_elf_fdpic.c:1115:29: sparse:     expected void *addr
   fs/binfmt_elf_fdpic.c:1115:29: sparse:     got void [noderef] __user *__cl_addr
   fs/binfmt_elf_fdpic.c:1158:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *__cl_addr @@     got void * @@
   fs/binfmt_elf_fdpic.c:1158:29: sparse:     expected void [noderef] __user *__cl_addr
   fs/binfmt_elf_fdpic.c:1158:29: sparse:     got void *
   fs/binfmt_elf_fdpic.c:1158:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user *__cl_addr @@
   fs/binfmt_elf_fdpic.c:1158:29: sparse:     expected void *addr
   fs/binfmt_elf_fdpic.c:1158:29: sparse:     got void [noderef] __user *__cl_addr
   fs/binfmt_elf_fdpic.c:618:9: sparse: sparse: dereference of noderef expression
   fs/binfmt_elf_fdpic.c:618:9: sparse: sparse: dereference of noderef expression
   fs/binfmt_elf_fdpic.c:622:17: sparse: sparse: dereference of noderef expression
   fs/binfmt_elf_fdpic.c:622:17: sparse: sparse: dereference of noderef expression
   fs/binfmt_elf_fdpic.c:629:17: sparse: sparse: dereference of noderef expression
   fs/binfmt_elf_fdpic.c:629:17: sparse: sparse: dereference of noderef expression
   fs/binfmt_elf_fdpic.c:636:17: sparse: sparse: dereference of noderef expression
   fs/binfmt_elf_fdpic.c:636:17: sparse: sparse: dereference of noderef expression
   fs/binfmt_elf_fdpic.c:641:9: sparse: sparse: dereference of noderef expression
   fs/binfmt_elf_fdpic.c:641:9: sparse: sparse: dereference of noderef expression
--
   block/ioctl.c:66:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   block/ioctl.c:66:13: sparse:     expected int const *__gu_addr
   block/ioctl.c:66:13: sparse:     got int [noderef] __user *
>> block/ioctl.c:66:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/ioctl.c:66:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:66:13: sparse:     got int const *__gu_addr
   block/ioctl.c:66:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *const *__gu_addr @@     got void [noderef] __user *[noderef] __user * @@
   block/ioctl.c:66:39: sparse:     expected void [noderef] __user *const *__gu_addr
   block/ioctl.c:66:39: sparse:     got void [noderef] __user *[noderef] __user *
>> block/ioctl.c:66:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got void [noderef] __user *const *__gu_addr @@
   block/ioctl.c:66:39: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:66:39: sparse:     got void [noderef] __user *const *__gu_addr
   block/ioctl.c:393:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   block/ioctl.c:393:13: sparse:     expected int const *__gu_addr
   block/ioctl.c:393:13: sparse:     got int [noderef] __user *
   block/ioctl.c:393:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/ioctl.c:393:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:393:13: sparse:     got int const *__gu_addr
   block/ioctl.c:474:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *argp @@
   block/ioctl.c:474:13: sparse:     expected int const *__gu_addr
   block/ioctl.c:474:13: sparse:     got int [noderef] __user *argp
   block/ioctl.c:474:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/ioctl.c:474:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:474:13: sparse:     got int const *__gu_addr
--
   block/scsi_ioctl.c:65:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   block/scsi_ioctl.c:65:28: sparse:     expected int const *__gu_addr
   block/scsi_ioctl.c:65:28: sparse:     got int [noderef] __user *p
>> block/scsi_ioctl.c:65:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/scsi_ioctl.c:65:28: sparse:     expected void const volatile [noderef] __user *ptr
   block/scsi_ioctl.c:65:28: sparse:     got int const *__gu_addr
   block/scsi_ioctl.c:91:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   block/scsi_ioctl.c:91:25: sparse:     expected int const *__gu_addr
   block/scsi_ioctl.c:91:25: sparse:     got int [noderef] __user *p
   block/scsi_ioctl.c:91:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/scsi_ioctl.c:91:25: sparse:     expected void const volatile [noderef] __user *ptr
   block/scsi_ioctl.c:91:25: sparse:     got int const *__gu_addr
   block/scsi_ioctl.c:433:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   block/scsi_ioctl.c:433:13: sparse:     expected unsigned int const *__gu_addr
   block/scsi_ioctl.c:433:13: sparse:     got unsigned int [noderef] __user *
>> block/scsi_ioctl.c:433:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   block/scsi_ioctl.c:433:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/scsi_ioctl.c:433:13: sparse:     got unsigned int const *__gu_addr
   block/scsi_ioctl.c:435:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   block/scsi_ioctl.c:435:13: sparse:     expected unsigned int const *__gu_addr
   block/scsi_ioctl.c:435:13: sparse:     got unsigned int [noderef] __user *
   block/scsi_ioctl.c:435:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   block/scsi_ioctl.c:435:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/scsi_ioctl.c:435:13: sparse:     got unsigned int const *__gu_addr
   block/scsi_ioctl.c:439:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   block/scsi_ioctl.c:439:13: sparse:     expected unsigned char const *__gu_addr
   block/scsi_ioctl.c:439:13: sparse:     got unsigned char [noderef] __user *
>> block/scsi_ioctl.c:439:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   block/scsi_ioctl.c:439:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/scsi_ioctl.c:439:13: sparse:     got unsigned char const *__gu_addr
--
   block/bsg.c:336:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *uarg @@
   block/bsg.c:336:13: sparse:     expected int const *__gu_addr
   block/bsg.c:336:13: sparse:     got int [noderef] __user *uarg
>> block/bsg.c:336:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/bsg.c:336:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:336:13: sparse:     got int const *__gu_addr
--
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/x25/af_x25.c:470:13: sparse:     expected int const *__gu_addr
   net/x25/af_x25.c:470:13: sparse:     got int [noderef] __user *optlen
>> net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/x25/af_x25.c:470:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/x25/af_x25.c:470:13: sparse:     got int const *__gu_addr
--
   fs/ext2/ioctl.c:47:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:47:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:47:21: sparse:     got int [noderef] __user *
>> fs/ext2/ioctl.c:47:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ext2/ioctl.c:47:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:47:21: sparse:     got int const *__gu_addr
   fs/ext2/ioctl.c:92:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:92:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:92:21: sparse:     got int [noderef] __user *
   fs/ext2/ioctl.c:92:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ext2/ioctl.c:92:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:92:21: sparse:     got int const *__gu_addr
   fs/ext2/ioctl.c:123:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:123:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:123:21: sparse:     got int [noderef] __user *
   fs/ext2/ioctl.c:123:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ext2/ioctl.c:123:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:123:21: sparse:     got int const *__gu_addr
--
   fs/fat/file.c:44:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *user_attr @@
   fs/fat/file.c:44:15: sparse:     expected unsigned int const *__gu_addr
   fs/fat/file.c:44:15: sparse:     got unsigned int [noderef] [usertype] __user *user_attr
>> fs/fat/file.c:44:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/fat/file.c:44:15: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/file.c:44:15: sparse:     got unsigned int const *__gu_addr
--
   drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hid/hidraw.c:389:37: sparse:     expected int const *__gu_addr
   drivers/hid/hidraw.c:389:37: sparse:     got int [noderef] __user *
>> drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/hid/hidraw.c:389:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hid/hidraw.c:389:37: sparse:     got int const *__gu_addr
--
   net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
   net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/netrom/af_netrom.c:359:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/netrom/af_netrom.c:359:13: sparse:     got int const *__gu_addr
--
   sound/core/pcm.c:92:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/pcm.c:92:29: sparse:     expected int const *__gu_addr
   sound/core/pcm.c:92:29: sparse:     got int [noderef] __user *
>> sound/core/pcm.c:92:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/pcm.c:92:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:92:29: sparse:     got int const *__gu_addr
   sound/core/pcm.c:112:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm.c:112:29: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm.c:112:29: sparse:     got unsigned int [noderef] __user *
>> sound/core/pcm.c:112:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm.c:112:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:112:29: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/pcm.c:114:29: sparse:     expected int const *__gu_addr
   sound/core/pcm.c:114:29: sparse:     got int [noderef] __user *
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/pcm.c:114:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:114:29: sparse:     got int const *__gu_addr
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm.c:119:29: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm.c:119:29: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm.c:119:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:119:29: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/pcm.c:155:29: sparse:     expected int const *__gu_addr
   sound/core/pcm.c:155:29: sparse:     got int [noderef] __user *
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/pcm.c:155:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:155:29: sparse:     got int const *__gu_addr
   sound/core/pcm.c:999:9: sparse: sparse: context imbalance in 'snd_pcm_detach_substream' - different lock contexts for basic block
--
   sound/core/pcm_native.c:1010:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   sound/core/pcm_native.c:1010:20: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:1010:20: sparse:     got unsigned int [noderef] [usertype] __user *
>> sound/core/pcm_native.c:1010:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:1010:20: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:1010:20: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:1036:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   sound/core/pcm_native.c:1036:20: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:1036:20: sparse:     got unsigned int [noderef] [usertype] __user *
   sound/core/pcm_native.c:1036:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:1036:20: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:1036:20: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:2944:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:2944:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:2944:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:2944:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:2944:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:2944:13: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:3037:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3037:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3037:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3037:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3037:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3037:13: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:3038:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3038:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3038:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3038:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3038:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3038:13: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3039:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3039:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:3087:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *_arg @@
   sound/core/pcm_native.c:3087:13: sparse:     expected int const *__gu_addr
   sound/core/pcm_native.c:3087:13: sparse:     got int [noderef] __user *_arg
>> sound/core/pcm_native.c:3087:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/pcm_native.c:3087:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3087:13: sparse:     got int const *__gu_addr
   sound/core/pcm_native.c:3153:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3153:13: sparse:     expected unsigned long const *__gu_addr
   sound/core/pcm_native.c:3153:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
>> sound/core/pcm_native.c:3153:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   sound/core/pcm_native.c:3153:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3153:13: sparse:     got unsigned long const *__gu_addr
   sound/core/pcm_native.c:3169:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3169:13: sparse:     expected unsigned long const *__gu_addr
   sound/core/pcm_native.c:3169:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
   sound/core/pcm_native.c:3169:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   sound/core/pcm_native.c:3169:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3169:13: sparse:     got unsigned long const *__gu_addr
   sound/core/pcm_native.c:3203:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3203:21: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3203:21: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3203:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3203:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3203:21: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:95:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock' - different lock contexts for basic block
   sound/core/pcm_native.c:96:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock' - unexpected unlock
   sound/core/pcm_native.c:97:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock_irq' - different lock contexts for basic block
   sound/core/pcm_native.c:98:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
   sound/core/pcm_native.c:145:9: sparse: sparse: context imbalance in 'snd_pcm_stream_lock_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:171:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave' - different lock contexts for basic block
   sound/core/pcm_native.c:188:39: sparse: sparse: context imbalance in 'snd_pcm_stream_unlock_irqrestore' - unexpected unlock
   sound/core/pcm_native.c:1186:52: sparse: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
   sound/core/pcm_native.c:1257:37: sparse: sparse: context imbalance in 'snd_pcm_stream_group_ref' - different lock contexts for basic block
--
   sound/core/rawmidi.c:654:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/rawmidi.c:654:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/rawmidi.c:654:13: sparse:     got unsigned int [noderef] __user *
>> sound/core/rawmidi.c:654:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/rawmidi.c:654:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:654:13: sparse:     got unsigned int const *__gu_addr
   sound/core/rawmidi.c:656:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:656:13: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:656:13: sparse:     got int [noderef] __user *
>> sound/core/rawmidi.c:656:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:656:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:656:13: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:658:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/rawmidi.c:658:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/rawmidi.c:658:13: sparse:     got unsigned int [noderef] __user *
   sound/core/rawmidi.c:658:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/core/rawmidi.c:658:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:658:13: sparse:     got unsigned int const *__gu_addr
   sound/core/rawmidi.c:836:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:836:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:836:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:836:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:836:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:836:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:874:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:874:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:874:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:874:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:874:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:874:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:889:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:889:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:889:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:889:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:889:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:889:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:923:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:923:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:923:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:923:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:923:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:923:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:945:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:945:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:945:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:945:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:945:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/rawmidi.c:945:21: sparse:     got int const *__gu_addr
--
   sound/core/control.c:776:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:776:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:777:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:777:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:796:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:825:41: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:918:34: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1462:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1565:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ptr @@
   sound/core/control.c:1565:13: sparse:     expected int const *__gu_addr
   sound/core/control.c:1565:13: sparse:     got int [noderef] __user *ptr
>> sound/core/control.c:1565:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/control.c:1565:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/control.c:1565:13: sparse:     got int const *__gu_addr
--
   net/rose/af_rose.c:438:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/rose/af_rose.c:438:13: sparse:     expected int const *__gu_addr
   net/rose/af_rose.c:438:13: sparse:     got int [noderef] __user *optlen
>> net/rose/af_rose.c:438:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/rose/af_rose.c:438:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rose/af_rose.c:438:13: sparse:     got int const *__gu_addr
--
   net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ax25/af_ax25.c:695:13: sparse:     expected int const *__gu_addr
   net/ax25/af_ax25.c:695:13: sparse:     got int [noderef] __user *optlen
>> net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ax25/af_ax25.c:695:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ax25/af_ax25.c:695:13: sparse:     got int const *__gu_addr
   net/ax25/af_ax25.c:1742:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   net/ax25/af_ax25.c:1742:21: sparse:     expected long const *__gu_addr
   net/ax25/af_ax25.c:1742:21: sparse:     got long [noderef] __user *
>> net/ax25/af_ax25.c:1742:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long const *__gu_addr @@
   net/ax25/af_ax25.c:1742:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ax25/af_ax25.c:1742:21: sparse:     got long const *__gu_addr
--
   net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/hci_core.c:2099:13: sparse:     expected unsigned short const *__gu_addr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   net/bluetooth/hci_core.c:2099:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short const *__gu_addr
--
   net/bluetooth/l2cap_sock.c:428:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/l2cap_sock.c:428:13: sparse:     expected int const *__gu_addr
   net/bluetooth/l2cap_sock.c:428:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/l2cap_sock.c:428:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/l2cap_sock.c:428:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:428:13: sparse:     got int const *__gu_addr
   net/bluetooth/l2cap_sock.c:553:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/l2cap_sock.c:553:13: sparse:     expected int const *__gu_addr
   net/bluetooth/l2cap_sock.c:553:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/l2cap_sock.c:553:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/l2cap_sock.c:553:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:553:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/sco.c:892:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:892:13: sparse:     expected int const *__gu_addr
   net/bluetooth/sco.c:892:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/sco.c:892:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/sco.c:892:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:892:13: sparse:     got int const *__gu_addr
   net/bluetooth/sco.c:957:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:957:13: sparse:     expected int const *__gu_addr
   net/bluetooth/sco.c:957:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/sco.c:957:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/sco.c:957:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:957:13: sparse:     got int const *__gu_addr
--
   net/rxrpc/af_rxrpc.c:697:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *_optlen @@
   net/rxrpc/af_rxrpc.c:697:13: sparse:     expected int const *__gu_addr
   net/rxrpc/af_rxrpc.c:697:13: sparse:     got int [noderef] __user *_optlen
>> net/rxrpc/af_rxrpc.c:697:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/rxrpc/af_rxrpc.c:697:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rxrpc/af_rxrpc.c:697:13: sparse:     got int const *__gu_addr
--
   net/kcm/kcmsock.c:1310:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/kcm/kcmsock.c:1310:13: sparse:     expected int const *__gu_addr
   net/kcm/kcmsock.c:1310:13: sparse:     got int [noderef] __user *optlen
>> net/kcm/kcmsock.c:1310:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/kcm/kcmsock.c:1310:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/kcm/kcmsock.c:1310:13: sparse:     got int const *__gu_addr
--
   net/phonet/socket.c:367:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/phonet/socket.c:367:21: sparse:     expected unsigned short const *__gu_addr
   net/phonet/socket.c:367:21: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/phonet/socket.c:367:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   net/phonet/socket.c:367:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/socket.c:367:21: sparse:     got unsigned short const *__gu_addr
   net/phonet/socket.c:623:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:623:14: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:623:14: sparse:    struct sock *
   net/phonet/socket.c:646:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:646:17: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:646:17: sparse:    struct sock *
   net/phonet/socket.c:662:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:662:17: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:662:17: sparse:    struct sock *
   net/phonet/socket.c:681:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:681:25: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:681:25: sparse:    struct sock *
--
   net/phonet/datagram.c:47:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/phonet/datagram.c:47:29: sparse:     expected unsigned int const *__gu_addr
   net/phonet/datagram.c:47:29: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/phonet/datagram.c:47:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   net/phonet/datagram.c:47:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/datagram.c:47:29: sparse:     got unsigned int const *__gu_addr
--
   net/phonet/pep.c:1047:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/phonet/pep.c:1047:13: sparse:     expected int const *__gu_addr
   net/phonet/pep.c:1047:13: sparse:     got int [noderef] __user *optlen
>> net/phonet/pep.c:1047:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/phonet/pep.c:1047:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/pep.c:1047:13: sparse:     got int const *__gu_addr
--
   net/dccp/proto.c:535:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] service @@     got int [addressable] val @@
   net/dccp/proto.c:535:52: sparse:     expected restricted __be32 const [usertype] service
   net/dccp/proto.c:535:52: sparse:     got int [addressable] val
   net/dccp/proto.c:620:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/proto.c:620:13: sparse:     expected int const *__gu_addr
   net/dccp/proto.c:620:13: sparse:     got int [noderef] __user *optlen
>> net/dccp/proto.c:620:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/dccp/proto.c:620:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/dccp/proto.c:620:13: sparse:     got int const *__gu_addr
   net/dccp/proto.c:718:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] param @@     got int cmsg_type @@
   net/dccp/proto.c:718:57: sparse:     expected restricted __be32 [usertype] param
   net/dccp/proto.c:718:57: sparse:     got int cmsg_type
--
   net/llc/af_llc.c:1147:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/llc/af_llc.c:1147:14: sparse:     expected int const *__gu_addr
   net/llc/af_llc.c:1147:14: sparse:     got int [noderef] __user *optlen
>> net/llc/af_llc.c:1147:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/llc/af_llc.c:1147:14: sparse:     expected void const volatile [noderef] __user *ptr
   net/llc/af_llc.c:1147:14: sparse:     got int const *__gu_addr
--
   fs/udf/file.c:207:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   fs/udf/file.c:207:21: sparse:     expected long const *__gu_addr
   fs/udf/file.c:207:21: sparse:     got long [noderef] __user *
>> fs/udf/file.c:207:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long const *__gu_addr @@
   fs/udf/file.c:207:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/udf/file.c:207:21: sparse:     got long const *__gu_addr
--
   fs/jfs/ioctl.c:83:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/jfs/ioctl.c:83:21: sparse:     expected int const *__gu_addr
   fs/jfs/ioctl.c:83:21: sparse:     got int [noderef] __user *
>> fs/jfs/ioctl.c:83:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/jfs/ioctl.c:83:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/jfs/ioctl.c:83:21: sparse:     got int const *__gu_addr
--
   fs/nilfs2/ioctl.c:138:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/nilfs2/ioctl.c:138:13: sparse:     expected int const *__gu_addr
   fs/nilfs2/ioctl.c:138:13: sparse:     got int [noderef] __user *
>> fs/nilfs2/ioctl.c:138:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/nilfs2/ioctl.c:138:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/nilfs2/ioctl.c:138:13: sparse:     got int const *__gu_addr
--
   net/rds/af_rds.c:245:22: sparse: sparse: invalid assignment: |=
   net/rds/af_rds.c:245:22: sparse:    left side has type restricted __poll_t
   net/rds/af_rds.c:245:22: sparse:    right side has type int
   net/rds/af_rds.c:262:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   net/rds/af_rds.c:262:21: sparse:     expected unsigned char const *__gu_addr
   net/rds/af_rds.c:262:21: sparse:     got unsigned char [noderef] [usertype] __user *
>> net/rds/af_rds.c:262:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   net/rds/af_rds.c:262:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/rds/af_rds.c:262:21: sparse:     got unsigned char const *__gu_addr
   net/rds/af_rds.c:493:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/rds/af_rds.c:493:13: sparse:     expected int const *__gu_addr
   net/rds/af_rds.c:493:13: sparse:     got int [noderef] __user *optlen
>> net/rds/af_rds.c:493:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/rds/af_rds.c:493:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rds/af_rds.c:493:13: sparse:     got int const *__gu_addr
--
   net/rds/info.c:171:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/rds/info.c:171:13: sparse:     expected int const *__gu_addr
   net/rds/info.c:171:13: sparse:     got int [noderef] __user *optlen
>> net/rds/info.c:171:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/rds/info.c:171:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rds/info.c:171:13: sparse:     got int const *__gu_addr
--
   net/tipc/socket.c:3213:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ol @@
   net/tipc/socket.c:3213:15: sparse:     expected int const *__gu_addr
   net/tipc/socket.c:3213:15: sparse:     got int [noderef] __user *ol
>> net/tipc/socket.c:3213:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/tipc/socket.c:3213:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/tipc/socket.c:3213:15: sparse:     got int const *__gu_addr
--
   net/vmw_vsock/af_vsock.c:1612:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     expected int const *__gu_addr
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     got int [noderef] __user *optlen
>> net/vmw_vsock/af_vsock.c:1612:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     got int const *__gu_addr
--
   drivers/input/serio/serport.c:213:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user * @@
   drivers/input/serio/serport.c:213:21: sparse:     expected unsigned long const *__gu_addr
   drivers/input/serio/serport.c:213:21: sparse:     got unsigned long [noderef] __user *
>> drivers/input/serio/serport.c:213:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   drivers/input/serio/serport.c:213:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/serio/serport.c:213:21: sparse:     got unsigned long const *__gu_addr
--
   fs/ocfs2/ioctl.c:860:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ocfs2/ioctl.c:860:21: sparse:     expected int const *__gu_addr
   fs/ocfs2/ioctl.c:860:21: sparse:     got int [noderef] __user *
>> fs/ocfs2/ioctl.c:860:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ocfs2/ioctl.c:860:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ocfs2/ioctl.c:860:21: sparse:     got int const *__gu_addr
   fs/ocfs2/ioctl.c:882:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ocfs2/ioctl.c:882:21: sparse:     expected int const *__gu_addr
   fs/ocfs2/ioctl.c:882:21: sparse:     got int [noderef] __user *
   fs/ocfs2/ioctl.c:882:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ocfs2/ioctl.c:882:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ocfs2/ioctl.c:882:21: sparse:     got int const *__gu_addr
--
   fs/gfs2/file.c:306:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *ptr @@
   fs/gfs2/file.c:306:13: sparse:     expected unsigned int const *__gu_addr
   fs/gfs2/file.c:306:13: sparse:     got unsigned int [noderef] [usertype] __user *ptr
>> fs/gfs2/file.c:306:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/gfs2/file.c:306:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/gfs2/file.c:306:13: sparse:     got unsigned int const *__gu_addr
--
   net/xdp/xsk.c:835:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/xdp/xsk.c:835:13: sparse:     expected int const *__gu_addr
   net/xdp/xsk.c:835:13: sparse:     got int [noderef] __user *optlen
>> net/xdp/xsk.c:835:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/xdp/xsk.c:835:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/xdp/xsk.c:835:13: sparse:     got int const *__gu_addr
--
   drivers/net/hamradio/mkiss.c:829:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/hamradio/mkiss.c:829:21: sparse:     expected int const *__gu_addr
   drivers/net/hamradio/mkiss.c:829:21: sparse:     got int [noderef] __user *
>> drivers/net/hamradio/mkiss.c:829:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/hamradio/mkiss.c:829:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/hamradio/mkiss.c:829:21: sparse:     got int const *__gu_addr
--
   fs/verity/measure.c:42:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   fs/verity/measure.c:42:13: sparse:     expected unsigned short const *__gu_addr
   fs/verity/measure.c:42:13: sparse:     got unsigned short [noderef] __user *
>> fs/verity/measure.c:42:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   fs/verity/measure.c:42:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/verity/measure.c:42:13: sparse:     got unsigned short const *__gu_addr
--
   drivers/scsi/scsi_error.c:2341:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   drivers/scsi/scsi_error.c:2341:17: sparse:     expected int const *__gu_addr
   drivers/scsi/scsi_error.c:2341:17: sparse:     got int [noderef] __user *arg
>> drivers/scsi/scsi_error.c:2341:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/scsi_error.c:2341:17: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_error.c:2341:17: sparse:     got int const *__gu_addr
--
   drivers/scsi/scsi_ioctl.c:48:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/scsi/scsi_ioctl.c:48:21: sparse:     expected unsigned int const *__gu_addr
   drivers/scsi/scsi_ioctl.c:48:21: sparse:     got unsigned int [noderef] __user *
>> drivers/scsi/scsi_ioctl.c:48:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/scsi/scsi_ioctl.c:48:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:48:21: sparse:     got unsigned int const *__gu_addr
--
   net/netlink/af_netlink.c:1734:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netlink/af_netlink.c:1734:13: sparse:     expected int const *__gu_addr
   net/netlink/af_netlink.c:1734:13: sparse:     got int [noderef] __user *optlen
>> net/netlink/af_netlink.c:1734:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/netlink/af_netlink.c:1734:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1734:13: sparse:     got int const *__gu_addr
--
   drivers/staging/greybus/fw-management.c:493:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/staging/greybus/fw-management.c:493:21: sparse:     expected unsigned int const *__gu_addr
   drivers/staging/greybus/fw-management.c:493:21: sparse:     got unsigned int [noderef] __user *
>> drivers/staging/greybus/fw-management.c:493:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/staging/greybus/fw-management.c:493:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/staging/greybus/fw-management.c:493:21: sparse:     got unsigned int const *__gu_addr
--
   net/ethtool/ioctl.c:81:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *[assigned] sizeaddr @@
   net/ethtool/ioctl.c:81:13: sparse:     expected unsigned int const *__gu_addr
   net/ethtool/ioctl.c:81:13: sparse:     got unsigned int [noderef] [usertype] __user *[assigned] sizeaddr
>> net/ethtool/ioctl.c:81:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   net/ethtool/ioctl.c:81:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ethtool/ioctl.c:81:13: sparse:     got unsigned int const *__gu_addr
--
   net/ipv4/tcp.c:3577:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3577:13: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3577:13: sparse:     got int [noderef] __user *optlen
>> net/ipv4/tcp.c:3577:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3577:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3577:13: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3626:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3626:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3626:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3626:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3626:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3626:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3644:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3644:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3644:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3644:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3644:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3644:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3663:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3663:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3663:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3663:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3663:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3663:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3673:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3673:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3673:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3673:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3673:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3673:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3691:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3691:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3691:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3691:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3691:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3691:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3725:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3725:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3725:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3725:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3725:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3725:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3786:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3786:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3786:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3786:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3786:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3786:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c: note: in included file (through include/net/inet_sock.h, include/net/ip.h, include/linux/errqueue.h):
   include/net/sock.h:1610:31: sparse: sparse: context imbalance in 'tcp_ioctl' - unexpected unlock
   include/net/sock.h:1610:31: sparse: sparse: context imbalance in 'tcp_get_info' - unexpected unlock
--
   drivers/tty/tty_io.c:2189:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user *p @@
   drivers/tty/tty_io.c:2189:13: sparse:     expected char const *__gu_addr
   drivers/tty/tty_io.c:2189:13: sparse:     got char [noderef] __user *p
>> drivers/tty/tty_io.c:2189:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/tty/tty_io.c:2189:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2189:13: sparse:     got char const *__gu_addr
   drivers/tty/tty_io.c:2330:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/tty/tty_io.c:2330:13: sparse:     expected int const *__gu_addr
   drivers/tty/tty_io.c:2330:13: sparse:     got int [noderef] __user *p
>> drivers/tty/tty_io.c:2330:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/tty_io.c:2330:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2330:13: sparse:     got int const *__gu_addr
   drivers/tty/tty_io.c:2448:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user *p @@
   drivers/tty/tty_io.c:2448:18: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/tty_io.c:2448:18: sparse:     got unsigned int [noderef] __user *p
>> drivers/tty/tty_io.c:2448:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tty/tty_io.c:2448:18: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2448:18: sparse:     got unsigned int const *__gu_addr
--
   drivers/tty/tty_ioctl.c:842:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/tty_ioctl.c:842:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/tty_ioctl.c:842:21: sparse:     got unsigned int [noderef] __user *
>> drivers/tty/tty_ioctl.c:842:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tty/tty_ioctl.c:842:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_ioctl.c:842:21: sparse:     got unsigned int const *__gu_addr
   drivers/tty/tty_ioctl.c: note: in included file (through arch/sh/include/generated/uapi/asm/termios.h, include/uapi/linux/termios.h):
   include/asm-generic/termios.h:25:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short const [noderef] __user * @@
   include/asm-generic/termios.h:25:13: sparse:     expected unsigned short const *__gu_addr
   include/asm-generic/termios.h:25:13: sparse:     got unsigned short const [noderef] __user *
>> include/asm-generic/termios.h:25:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   include/asm-generic/termios.h:25:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:25:13: sparse:     got unsigned short const *__gu_addr
   include/asm-generic/termios.h:29:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short const [noderef] __user * @@
   include/asm-generic/termios.h:29:13: sparse:     expected unsigned short const *__gu_addr
   include/asm-generic/termios.h:29:13: sparse:     got unsigned short const [noderef] __user *
   include/asm-generic/termios.h:29:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   include/asm-generic/termios.h:29:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:29:13: sparse:     got unsigned short const *__gu_addr
   include/asm-generic/termios.h:33:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short const [noderef] __user * @@
   include/asm-generic/termios.h:33:13: sparse:     expected unsigned short const *__gu_addr
   include/asm-generic/termios.h:33:13: sparse:     got unsigned short const [noderef] __user *
   include/asm-generic/termios.h:33:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   include/asm-generic/termios.h:33:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:33:13: sparse:     got unsigned short const *__gu_addr
   include/asm-generic/termios.h:37:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short const [noderef] __user * @@
   include/asm-generic/termios.h:37:13: sparse:     expected unsigned short const *__gu_addr
   include/asm-generic/termios.h:37:13: sparse:     got unsigned short const [noderef] __user *
   include/asm-generic/termios.h:37:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   include/asm-generic/termios.h:37:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:37:13: sparse:     got unsigned short const *__gu_addr
   include/asm-generic/termios.h:41:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char const [noderef] __user * @@
   include/asm-generic/termios.h:41:13: sparse:     expected unsigned char const *__gu_addr
   include/asm-generic/termios.h:41:13: sparse:     got unsigned char const [noderef] __user *
>> include/asm-generic/termios.h:41:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   include/asm-generic/termios.h:41:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:41:13: sparse:     got unsigned char const *__gu_addr
--
   drivers/tty/tty_jobctrl.c:77:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:77:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:77:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:80:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:80:34: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:80:34: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:120:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:120:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:120:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:122:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:122:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:122:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:131:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:131:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:131:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:152:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:152:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:152:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:161:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:161:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:163:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:163:40: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:163:40: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:200:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:200:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:200:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:208:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:208:51: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:208:51: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:219:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:219:43: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:219:43: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:281:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:281:39: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:281:39: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:284:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:284:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:284:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:293:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:293:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:293:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:309:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:309:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:309:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:484:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] [usertype] __user *p @@
   drivers/tty/tty_jobctrl.c:484:13: sparse:     expected int const *__gu_addr
   drivers/tty/tty_jobctrl.c:484:13: sparse:     got int [noderef] [usertype] __user *p
>> drivers/tty/tty_jobctrl.c:484:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/tty_jobctrl.c:484:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_jobctrl.c:484:13: sparse:     got int const *__gu_addr
   drivers/tty/tty_jobctrl.c:18:41: sparse: sparse: dereference of noderef expression
--
   drivers/tty/pty.c:163:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   drivers/tty/pty.c:163:13: sparse:     expected int const *__gu_addr
   drivers/tty/pty.c:163:13: sparse:     got int [noderef] __user *arg
>> drivers/tty/pty.c:163:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/pty.c:163:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:163:13: sparse:     got int const *__gu_addr
   drivers/tty/pty.c:183:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   drivers/tty/pty.c:183:13: sparse:     expected int const *__gu_addr
   drivers/tty/pty.c:183:13: sparse:     got int [noderef] __user *arg
   drivers/tty/pty.c:183:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/pty.c:183:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:183:13: sparse:     got int const *__gu_addr
--
   drivers/tty/vt/keyboard.c:1730:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1730:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1730:21: sparse:     got unsigned int [noderef] __user *
>> drivers/tty/vt/keyboard.c:1730:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tty/vt/keyboard.c:1730:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/keyboard.c:1730:21: sparse:     got unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1768:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1768:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1768:21: sparse:     got unsigned int [noderef] __user *
   drivers/tty/vt/keyboard.c:1768:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tty/vt/keyboard.c:1768:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/keyboard.c:1768:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/tty/vt/vt.c:4301:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user * @@
   drivers/tty/vt/vt.c:4301:13: sparse:     expected char const *__gu_addr
   drivers/tty/vt/vt.c:4301:13: sparse:     got char [noderef] __user *
>> drivers/tty/vt/vt.c:4301:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/tty/vt/vt.c:4301:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt.c:4301:13: sparse:     got char const *__gu_addr
   drivers/tty/vt/vt.c:3147:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user *p @@
   drivers/tty/vt/vt.c:3147:13: sparse:     expected char const *__gu_addr
   drivers/tty/vt/vt.c:3147:13: sparse:     got char [noderef] __user *p
   drivers/tty/vt/vt.c:3147:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/tty/vt/vt.c:3147:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt.c:3147:13: sparse:     got char const *__gu_addr
   drivers/tty/vt/vt.c:3200:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user * @@
   drivers/tty/vt/vt.c:3200:37: sparse:     expected char const *__gu_addr
   drivers/tty/vt/vt.c:3200:37: sparse:     got char [noderef] __user *
   drivers/tty/vt/vt.c:3200:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/tty/vt/vt.c:3200:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt.c:3200:37: sparse:     got char const *__gu_addr
   drivers/tty/vt/vt.c:3213:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/tty/vt/vt.c:3213:29: sparse:     expected signed int const *__gu_addr
   drivers/tty/vt/vt.c:3213:29: sparse:     got signed int [noderef] [usertype] __user *
>> drivers/tty/vt/vt.c:3213:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/tty/vt/vt.c:3213:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt.c:3213:29: sparse:     got signed int const *__gu_addr
--
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     expected unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     got unsigned short [noderef] __user *
>> drivers/tty/vt/vt_ioctl.c:1004:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     got unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     expected unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     got unsigned short [noderef] __user *
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     got unsigned short const *__gu_addr
--
   fs/reiserfs/ioctl.c:66:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/reiserfs/ioctl.c:66:29: sparse:     expected int const *__gu_addr
   fs/reiserfs/ioctl.c:66:29: sparse:     got int [noderef] __user *
>> fs/reiserfs/ioctl.c:66:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/reiserfs/ioctl.c:66:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/reiserfs/ioctl.c:66:29: sparse:     got int const *__gu_addr
   fs/reiserfs/ioctl.c:111:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/reiserfs/ioctl.c:111:21: sparse:     expected int const *__gu_addr
   fs/reiserfs/ioctl.c:111:21: sparse:     got int [noderef] __user *
   fs/reiserfs/ioctl.c:111:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/reiserfs/ioctl.c:111:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/reiserfs/ioctl.c:111:21: sparse:     got int const *__gu_addr

vim +310 arch/sh/kernel/kgdb.c

489022cc86ec88 Jason Wessel 2010-05-20  300  
ab6e570ba33dbe Paul Mundt   2008-12-11  301  /*
ab6e570ba33dbe Paul Mundt   2008-12-11  302   * The primary entry points for the kgdb debug trap table entries.
ab6e570ba33dbe Paul Mundt   2008-12-11  303   */
ab6e570ba33dbe Paul Mundt   2008-12-11  304  BUILD_TRAP_HANDLER(singlestep)
ab6e570ba33dbe Paul Mundt   2008-12-11  305  {
ab6e570ba33dbe Paul Mundt   2008-12-11  306  	unsigned long flags;
ab6e570ba33dbe Paul Mundt   2008-12-11  307  	TRAP_HANDLER_DECL;
ab6e570ba33dbe Paul Mundt   2008-12-11  308  
ab6e570ba33dbe Paul Mundt   2008-12-11  309  	local_irq_save(flags);
ab6e570ba33dbe Paul Mundt   2008-12-11 @310  	regs->pc -= instruction_size(__raw_readw(regs->pc - 4));
489022cc86ec88 Jason Wessel 2010-05-20  311  	kgdb_handle_exception(0, SIGTRAP, 0, regs);
ab6e570ba33dbe Paul Mundt   2008-12-11  312  	local_irq_restore(flags);
ab6e570ba33dbe Paul Mundt   2008-12-11  313  }
ab6e570ba33dbe Paul Mundt   2008-12-11  314  

:::::: The code at line 310 was first introduced by commit
:::::: ab6e570ba33dbee18c2520d386e0f367a9b573c3 sh: Generic kgdb stub support.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
