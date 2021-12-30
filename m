Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9CB481C12
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbhL3MbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:31:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:29232 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239217AbhL3MbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640867460; x=1672403460;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QDIieert6OogZxxf65NFc6m5KkDJzQDxyVG3CKLgS7o=;
  b=FxH2Ay2KzySNexY/8NeCOsBNKxGiGCO3VvcAYXn5zmY5TxH91wI9APYs
   IdSW/MWN0XARll0vQQ7J3YF0JHSl27pMNBPZTicoLZbRINae2W9D2/din
   8sUlcdT9BIy5JvgF1QRpcENuEM3HB/ee3PkZZo6Uvef1rLp21HPLky6j3
   PR37iN6lr9zJIcZZHxlPr/eb/Ko1VBf9uj9dDtEsOjTjSNhatUxrnlgsb
   8qELjMdd/fvA1lB1bSCIDH+YjBN9xrF9skE3ehttLJAWZzKoC9QvVnQuc
   Wzdum41dEnoS+sqYe7nD+RLmFo1hhwO0yZM3FnHxecJ6qbgWiF6HyMjnQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="241465025"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="241465025"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 04:31:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="510877037"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Dec 2021 04:30:58 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2ua9-000A7E-HA; Thu, 30 Dec 2021 12:30:57 +0000
Date:   Thu, 30 Dec 2021 20:30:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/gpu/drm/drm_crtc.c:708:29: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202112302036.YHwG4gD5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eec4df26e24e978e49ccf9bcf49ca0f2ccdaeffe
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   1 year, 4 months ago
config: sh-randconfig-s032-20211230 (https://download.01.org/0day-ci/archive/20211230/202112302036.YHwG4gD5-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/ arch/sh/mm/ drivers/gpu/drm/ drivers/input/serio/ drivers/net/slip/ drivers/tty/ drivers/vhost/ fs/fat/ fs/hfsplus/ kernel/ lib/ security/tomoyo/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/drm_crtc.c:708:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_crtc.c:708:29: sparse:     expected unsigned int const *__gu_addr
   drivers/gpu/drm/drm_crtc.c:708:29: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/gpu/drm/drm_crtc.c:708:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/gpu/drm/drm_crtc.c:708:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_crtc.c:708:29: sparse:     got unsigned int const *__gu_addr
--
   drivers/input/serio/serport.c:213:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user * @@
   drivers/input/serio/serport.c:213:21: sparse:     expected unsigned long const *__gu_addr
   drivers/input/serio/serport.c:213:21: sparse:     got unsigned long [noderef] __user *
>> drivers/input/serio/serport.c:213:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   drivers/input/serio/serport.c:213:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/serio/serport.c:213:21: sparse:     got unsigned long const *__gu_addr
--
   drivers/net/slip/slip.c:458:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:458:14: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:458:14: sparse:    void *
   drivers/net/slip/slip.c:892:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:892:9: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:892:9: sparse:    void *
   drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
>> drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
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
   drivers/vhost/vhost.c:1571:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *idxp @@
   drivers/vhost/vhost.c:1571:13: sparse:     expected unsigned int const *__gu_addr
   drivers/vhost/vhost.c:1571:13: sparse:     got unsigned int [noderef] [usertype] __user *idxp
>> drivers/vhost/vhost.c:1571:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/vhost/vhost.c:1571:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vhost.c:1571:13: sparse:     got unsigned int const *__gu_addr
   drivers/vhost/vhost.c:1771:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/vhost/vhost.c:1771:21: sparse:     expected int const *__gu_addr
   drivers/vhost/vhost.c:1771:21: sparse:     got int [noderef] __user *
>> drivers/vhost/vhost.c:1771:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/vhost/vhost.c:1771:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vhost.c:1771:21: sparse:     got int const *__gu_addr
--
>> arch/sh/kernel/process_32.c:42:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/process_32.c:42:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/process_32.c:42:9: sparse:     got unsigned int
--
   arch/sh/kernel/setup.c: note: in included file:
>> arch/sh/include/asm/mmu_context.h:151:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/mmu_context.h:151:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/mmu_context.h:151:9: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse:     got unsigned long [assigned] addr0
>> arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse:     got unsigned long [assigned] addr1
>> arch/sh/kernel/cpu/sh3/probe.c:94:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/probe.c:94:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:94:17: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse:     got unsigned long
>> arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/setup-sh3.c:59:17: sparse:     got unsigned long
--
>> arch/sh/kernel/cpu/sh3/serial-sh770x.c:15:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:15:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:15:16: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:17:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:17:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:17:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:21:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:21:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:21:24: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:24:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:24:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:24:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:26:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:26:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:26:24: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:28:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:28:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:28:17: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh3/clock-sh7705.c:32:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:32:35: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:32:35: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:41:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:41:19: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:41:19: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:51:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:51:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:51:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:61:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:61:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:61:20: sparse:     got unsigned int
--
   arch/sh/mm/init.c: note: in included file (through arch/sh/include/asm/mmu_context.h):
>> arch/sh/include/asm/mmu_context_32.h:53:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/mmu_context_32.h:53:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/mmu_context_32.h:53:9: sparse:     got unsigned int
--
>> arch/sh/mm/cache-sh3.c:50:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh3.c:50:32: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh3.c:50:32: sparse:     got unsigned long [assigned] addr
   arch/sh/mm/cache-sh3.c:55:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh3.c:55:33: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh3.c:55:33: sparse:     got unsigned long [assigned] addr
   arch/sh/mm/cache-sh3.c:86:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh3.c:86:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh3.c:86:17: sparse:     got unsigned long [assigned] addr
--
>> arch/sh/mm/cache-sh7705.c:116:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh7705.c:116:32: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh7705.c:116:32: sparse:     got unsigned long [assigned] addr
   arch/sh/mm/cache-sh7705.c:119:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh7705.c:119:33: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh7705.c:119:33: sparse:     got unsigned long [assigned] addr
   arch/sh/mm/cache-sh7705.c:49:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh7705.c:49:32: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh7705.c:49:32: sparse:     got unsigned long [assigned] addr
   arch/sh/mm/cache-sh7705.c:52:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh7705.c:52:33: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh7705.c:52:33: sparse:     got unsigned long [assigned] addr
--
>> arch/sh/mm/tlb-sh3.c:41:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlb-sh3.c:41:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlb-sh3.c:41:9: sparse:     got unsigned int
   arch/sh/mm/tlb-sh3.c:48:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlb-sh3.c:48:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlb-sh3.c:48:9: sparse:     got unsigned int
>> arch/sh/mm/tlb-sh3.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/mm/tlb-sh3.c:75:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlb-sh3.c:75:17: sparse:     got unsigned long
   arch/sh/mm/tlb-sh3.c:90:18: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlb-sh3.c:90:18: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlb-sh3.c:90:18: sparse:     got unsigned int
   arch/sh/mm/tlb-sh3.c:92:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlb-sh3.c:92:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlb-sh3.c:92:9: sparse:     got unsigned int
--
>> arch/sh/mm/tlbflush_32.c:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlbflush_32.c:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlbflush_32.c:134:9: sparse:     got unsigned int
>> arch/sh/mm/tlbflush_32.c:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlbflush_32.c:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlbflush_32.c:134:9: sparse:     got unsigned int
--
   lib/test_user_copy.c:165:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user *__cl_addr @@
   lib/test_user_copy.c:165:16: sparse:     expected void *addr
   lib/test_user_copy.c:165:16: sparse:     got void [noderef] __user *__cl_addr
   lib/test_user_copy.c:239:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   lib/test_user_copy.c:239:9: sparse:     expected unsigned char const *__gu_addr
   lib/test_user_copy.c:239:9: sparse:     got unsigned char [noderef] [usertype] __user *
>> lib/test_user_copy.c:239:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   lib/test_user_copy.c:239:9: sparse:     expected void const volatile [noderef] __user *ptr
   lib/test_user_copy.c:239:9: sparse:     got unsigned char const *__gu_addr
   lib/test_user_copy.c:240:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   lib/test_user_copy.c:240:9: sparse:     expected unsigned short const *__gu_addr
   lib/test_user_copy.c:240:9: sparse:     got unsigned short [noderef] [usertype] __user *
>> lib/test_user_copy.c:240:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   lib/test_user_copy.c:240:9: sparse:     expected void const volatile [noderef] __user *ptr
   lib/test_user_copy.c:240:9: sparse:     got unsigned short const *__gu_addr
   lib/test_user_copy.c:241:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   lib/test_user_copy.c:241:9: sparse:     expected unsigned int const *__gu_addr
   lib/test_user_copy.c:241:9: sparse:     got unsigned int [noderef] [usertype] __user *
>> lib/test_user_copy.c:241:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   lib/test_user_copy.c:241:9: sparse:     expected void const volatile [noderef] __user *ptr
   lib/test_user_copy.c:241:9: sparse:     got unsigned int const *__gu_addr
   lib/test_user_copy.c:302:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   lib/test_user_copy.c:302:9: sparse:     expected unsigned char const *__gu_addr
   lib/test_user_copy.c:302:9: sparse:     got unsigned char [noderef] [usertype] __user *
   lib/test_user_copy.c:302:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   lib/test_user_copy.c:302:9: sparse:     expected void const volatile [noderef] __user *ptr
   lib/test_user_copy.c:302:9: sparse:     got unsigned char const *__gu_addr
   lib/test_user_copy.c:303:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   lib/test_user_copy.c:303:9: sparse:     expected unsigned short const *__gu_addr
   lib/test_user_copy.c:303:9: sparse:     got unsigned short [noderef] [usertype] __user *
   lib/test_user_copy.c:303:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   lib/test_user_copy.c:303:9: sparse:     expected void const volatile [noderef] __user *ptr
   lib/test_user_copy.c:303:9: sparse:     got unsigned short const *__gu_addr
   lib/test_user_copy.c:304:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   lib/test_user_copy.c:304:9: sparse:     expected unsigned int const *__gu_addr
   lib/test_user_copy.c:304:9: sparse:     got unsigned int [noderef] [usertype] __user *
   lib/test_user_copy.c:304:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   lib/test_user_copy.c:304:9: sparse:     expected void const volatile [noderef] __user *ptr
   lib/test_user_copy.c:304:9: sparse:     got unsigned int const *__gu_addr
--
   kernel/capability.c:86:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   kernel/capability.c:86:13: sparse:     expected unsigned int const *__gu_addr
   kernel/capability.c:86:13: sparse:     got unsigned int [noderef] __user *
>> kernel/capability.c:86:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/capability.c:86:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/capability.c:86:13: sparse:     got unsigned int const *__gu_addr
   kernel/capability.c:159:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   kernel/capability.c:159:13: sparse:     expected int const *__gu_addr
   kernel/capability.c:159:13: sparse:     got int [noderef] __user *
>> kernel/capability.c:159:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   kernel/capability.c:159:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/capability.c:159:13: sparse:     got int const *__gu_addr
   kernel/capability.c:195:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct __user_cap_data_struct [noderef] __user * @@
   kernel/capability.c:195:43: sparse:     expected void const *from
   kernel/capability.c:195:43: sparse:     got struct __user_cap_data_struct [noderef] __user *
   kernel/capability.c:171:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:172:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:173:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:235:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   kernel/capability.c:235:13: sparse:     expected int const *__gu_addr
   kernel/capability.c:235:13: sparse:     got int [noderef] __user *
   kernel/capability.c:235:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   kernel/capability.c:235:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/capability.c:235:13: sparse:     got int const *__gu_addr
   kernel/capability.c:246:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct __user_cap_data_struct [noderef] __user ( * )[2] @@
   kernel/capability.c:246:29: sparse:     expected void *to
   kernel/capability.c:246:29: sparse:     got struct __user_cap_data_struct [noderef] __user ( * )[2]
   kernel/capability.c:250:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:251:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:252:43: sparse: sparse: dereference of noderef expression
--
   kernel/groups.c:69:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   kernel/groups.c:69:21: sparse:     expected unsigned int const *__gu_addr
   kernel/groups.c:69:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> kernel/groups.c:69:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   kernel/groups.c:69:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/groups.c:69:21: sparse:     got unsigned int const *__gu_addr
--
   kernel/uid16.c:141:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   kernel/uid16.c:141:21: sparse:     expected unsigned short const *__gu_addr
   kernel/uid16.c:141:21: sparse:     got unsigned short [noderef] [usertype] __user *
>> kernel/uid16.c:141:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   kernel/uid16.c:141:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/uid16.c:141:21: sparse:     got unsigned short const *__gu_addr
--
   fs/fat/file.c:44:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *user_attr @@
   fs/fat/file.c:44:15: sparse:     expected unsigned int const *__gu_addr
   fs/fat/file.c:44:15: sparse:     got unsigned int [noderef] [usertype] __user *user_attr
>> fs/fat/file.c:44:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/fat/file.c:44:15: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/file.c:44:15: sparse:     got unsigned int const *__gu_addr
--
   security/tomoyo/common.c:915:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:915:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:915:9: sparse:    struct list_head *
   security/tomoyo/common.c:915:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:915:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:915:9: sparse:    struct list_head *
   security/tomoyo/common.c:1600:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1600:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1600:9: sparse:    struct list_head *
   security/tomoyo/common.c:1600:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1600:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1600:9: sparse:    struct list_head *
   security/tomoyo/common.c:1622:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1622:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1622:9: sparse:    struct list_head *
   security/tomoyo/common.c:1622:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1622:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1622:9: sparse:    struct list_head *
   security/tomoyo/common.c:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1803:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1803:9: sparse:    struct list_head *
   security/tomoyo/common.c:1807:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1807:17: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1807:17: sparse:    struct list_head *
   security/tomoyo/common.c:1807:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1807:17: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1807:17: sparse:    struct list_head *
   security/tomoyo/common.c:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1803:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1803:9: sparse:    struct list_head *
   security/tomoyo/common.c:1862:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1862:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1862:9: sparse:    struct list_head *
   security/tomoyo/common.c:1862:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1862:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1862:9: sparse:    struct list_head *
   security/tomoyo/common.c:2687:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buffer @@
   security/tomoyo/common.c:2687:21: sparse:     expected char const *__gu_addr
   security/tomoyo/common.c:2687:21: sparse:     got char const [noderef] __user *buffer
>> security/tomoyo/common.c:2687:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   security/tomoyo/common.c:2687:21: sparse:     expected void const volatile [noderef] __user *ptr
   security/tomoyo/common.c:2687:21: sparse:     got char const *__gu_addr
   security/tomoyo/common.c:948:26: sparse: sparse: dereference of noderef expression
   security/tomoyo/common.c:948:26: sparse: sparse: dereference of noderef expression
   security/tomoyo/common.c:949:26: sparse: sparse: dereference of noderef expression
   security/tomoyo/common.c:949:26: sparse: sparse: dereference of noderef expression
--
   drivers/tty/ipwireless/network.c:174:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *user_arg @@
   drivers/tty/ipwireless/network.c:174:21: sparse:     expected int const *__gu_addr
   drivers/tty/ipwireless/network.c:174:21: sparse:     got int [noderef] __user *user_arg
>> drivers/tty/ipwireless/network.c:174:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/ipwireless/network.c:174:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/ipwireless/network.c:174:21: sparse:     got int const *__gu_addr
   drivers/tty/ipwireless/network.c:188:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *user_arg @@
   drivers/tty/ipwireless/network.c:188:21: sparse:     expected int const *__gu_addr
   drivers/tty/ipwireless/network.c:188:21: sparse:     got int [noderef] __user *user_arg
   drivers/tty/ipwireless/network.c:188:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/ipwireless/network.c:188:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/ipwireless/network.c:188:21: sparse:     got int const *__gu_addr
   drivers/tty/ipwireless/network.c:200:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *user_arg @@
   drivers/tty/ipwireless/network.c:200:21: sparse:     expected int const *__gu_addr
   drivers/tty/ipwireless/network.c:200:21: sparse:     got int [noderef] __user *user_arg
   drivers/tty/ipwireless/network.c:200:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/ipwireless/network.c:200:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/ipwireless/network.c:200:21: sparse:     got int const *__gu_addr
   drivers/tty/ipwireless/network.c:228:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *user_arg @@
   drivers/tty/ipwireless/network.c:228:21: sparse:     expected int const *__gu_addr
   drivers/tty/ipwireless/network.c:228:21: sparse:     got int [noderef] __user *user_arg
   drivers/tty/ipwireless/network.c:228:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/tty/ipwireless/network.c:228:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/ipwireless/network.c:228:21: sparse:     got int const *__gu_addr
--
   fs/hfsplus/ioctl.c:42:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   fs/hfsplus/ioctl.c:42:50: sparse:     expected unsigned int
   fs/hfsplus/ioctl.c:42:50: sparse:     got restricted __be32 [usertype]
   fs/hfsplus/ioctl.c:50:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   fs/hfsplus/ioctl.c:50:50: sparse:     expected unsigned int
   fs/hfsplus/ioctl.c:50:50: sparse:     got restricted __be32 [usertype]
   fs/hfsplus/ioctl.c:53:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   fs/hfsplus/ioctl.c:53:50: sparse:     expected unsigned int
   fs/hfsplus/ioctl.c:53:50: sparse:     got restricted __be32 [usertype]
   fs/hfsplus/ioctl.c:99:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *user_flags @@
   fs/hfsplus/ioctl.c:99:13: sparse:     expected int const *__gu_addr
   fs/hfsplus/ioctl.c:99:13: sparse:     got int [noderef] __user *user_flags
>> fs/hfsplus/ioctl.c:99:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/hfsplus/ioctl.c:99:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/hfsplus/ioctl.c:99:13: sparse:     got int const *__gu_addr

vim +708 drivers/gpu/drm/drm_crtc.c

c11e928360777b Damien Lespiau    2013-09-25  538  
f453ba0460742a Dave Airlie       2008-11-07  539  /**
f453ba0460742a Dave Airlie       2008-11-07  540   * drm_mode_setcrtc - set CRTC configuration
065a50ed3ef75c Daniel Vetter     2012-12-02  541   * @dev: drm device for the ioctl
065a50ed3ef75c Daniel Vetter     2012-12-02  542   * @data: data pointer for the ioctl
065a50ed3ef75c Daniel Vetter     2012-12-02  543   * @file_priv: drm file for the ioctl call
f453ba0460742a Dave Airlie       2008-11-07  544   *
f453ba0460742a Dave Airlie       2008-11-07  545   * Build a new CRTC configuration based on user request.
f453ba0460742a Dave Airlie       2008-11-07  546   *
f453ba0460742a Dave Airlie       2008-11-07  547   * Called by the user via ioctl.
f453ba0460742a Dave Airlie       2008-11-07  548   *
c8e32cc1219fc1 Daniel Vetter     2014-03-10  549   * Returns:
1a49863349929f Daniel Vetter     2014-11-19  550   * Zero on success, negative errno on failure.
f453ba0460742a Dave Airlie       2008-11-07  551   */
f453ba0460742a Dave Airlie       2008-11-07  552  int drm_mode_setcrtc(struct drm_device *dev, void *data,
f453ba0460742a Dave Airlie       2008-11-07  553  		     struct drm_file *file_priv)
f453ba0460742a Dave Airlie       2008-11-07  554  {
f453ba0460742a Dave Airlie       2008-11-07  555  	struct drm_mode_config *config = &dev->mode_config;
f453ba0460742a Dave Airlie       2008-11-07  556  	struct drm_mode_crtc *crtc_req = data;
6653cc8d3b8d1c Ville Syrjälä     2012-03-13  557  	struct drm_crtc *crtc;
64c32b490333c9 Ville Syrjälä     2018-03-22  558  	struct drm_plane *plane;
c232e9f41b136c Sean Paul         2018-11-29  559  	struct drm_connector **connector_set = NULL, *connector;
c232e9f41b136c Sean Paul         2018-11-29  560  	struct drm_framebuffer *fb = NULL;
c232e9f41b136c Sean Paul         2018-11-29  561  	struct drm_display_mode *mode = NULL;
f453ba0460742a Dave Airlie       2008-11-07  562  	struct drm_mode_set set;
f453ba0460742a Dave Airlie       2008-11-07  563  	uint32_t __user *set_connectors_ptr;
2ceb585a956c10 Daniel Vetter     2017-03-22  564  	struct drm_modeset_acquire_ctx ctx;
4a1b0714275796 Laurent Pinchart  2012-05-17  565  	int ret;
f453ba0460742a Dave Airlie       2008-11-07  566  	int i;
f453ba0460742a Dave Airlie       2008-11-07  567  
fb3b06c8a1fd1a Dave Airlie       2011-02-08  568  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
69fdf4206a8ba9 Chris Wilson      2018-09-13  569  		return -EOPNOTSUPP;
fb3b06c8a1fd1a Dave Airlie       2011-02-08  570  
01447e9f04ba1c Zhao Junwang      2015-07-07  571  	/*
01447e9f04ba1c Zhao Junwang      2015-07-07  572  	 * Universal plane src offsets are only 16.16, prevent havoc for
01447e9f04ba1c Zhao Junwang      2015-07-07  573  	 * drivers using universal plane code internally.
01447e9f04ba1c Zhao Junwang      2015-07-07  574  	 */
01447e9f04ba1c Zhao Junwang      2015-07-07  575  	if (crtc_req->x & 0xffff0000 || crtc_req->y & 0xffff0000)
1d97e9154821d5 Ville Syrjälä     2012-03-13  576  		return -ERANGE;
1d97e9154821d5 Ville Syrjälä     2012-03-13  577  
418da17214aca5 Keith Packard     2017-03-14  578  	crtc = drm_crtc_find(dev, file_priv, crtc_req->crtc_id);
a2b34e226ac9fb Rob Clark         2013-10-05  579  	if (!crtc) {
58367ed65f3012 Zhao Yakui        2009-07-20  580  		DRM_DEBUG_KMS("Unknown CRTC ID %d\n", crtc_req->crtc_id);
2ceb585a956c10 Daniel Vetter     2017-03-22  581  		return -ENOENT;
f453ba0460742a Dave Airlie       2008-11-07  582  	}
fa3ab4c2113c74 Ville Syrjälä     2015-12-08  583  	DRM_DEBUG_KMS("[CRTC:%d:%s]\n", crtc->base.id, crtc->name);
f453ba0460742a Dave Airlie       2008-11-07  584  
64c32b490333c9 Ville Syrjälä     2018-03-22  585  	plane = crtc->primary;
64c32b490333c9 Ville Syrjälä     2018-03-22  586  
204f640da69148 Daniel Vetter     2019-02-28  587  	/* allow disabling with the primary plane leased */
204f640da69148 Daniel Vetter     2019-02-28  588  	if (crtc_req->mode_valid && !drm_lease_held(file_priv, plane->base.id))
204f640da69148 Daniel Vetter     2019-02-28  589  		return -EACCES;
204f640da69148 Daniel Vetter     2019-02-28  590  
53552d5df6694f Daniel Vetter     2017-04-06  591  	mutex_lock(&crtc->dev->mode_config.mutex);
b7ea04d299c78b Sean Paul         2018-11-29  592  	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx,
b7ea04d299c78b Sean Paul         2018-11-29  593  				   DRM_MODESET_ACQUIRE_INTERRUPTIBLE, ret);
bf2d5eb902e29d Ville Syrjälä     2018-03-22  594  
f453ba0460742a Dave Airlie       2008-11-07  595  	if (crtc_req->mode_valid) {
f453ba0460742a Dave Airlie       2008-11-07  596  		/* If we have a mode we need a framebuffer. */
f453ba0460742a Dave Airlie       2008-11-07  597  		/* If we pass -1, set the mode with the currently bound fb */
f453ba0460742a Dave Airlie       2008-11-07  598  		if (crtc_req->fb_id == -1) {
a36c027db57b6a Ville Syrjälä     2018-03-22  599  			struct drm_framebuffer *old_fb;
a36c027db57b6a Ville Syrjälä     2018-03-22  600  
a36c027db57b6a Ville Syrjälä     2018-03-22  601  			if (plane->state)
a36c027db57b6a Ville Syrjälä     2018-03-22  602  				old_fb = plane->state->fb;
a36c027db57b6a Ville Syrjälä     2018-03-22  603  			else
a36c027db57b6a Ville Syrjälä     2018-03-22  604  				old_fb = plane->fb;
a36c027db57b6a Ville Syrjälä     2018-03-22  605  
a36c027db57b6a Ville Syrjälä     2018-03-22  606  			if (!old_fb) {
6653cc8d3b8d1c Ville Syrjälä     2012-03-13  607  				DRM_DEBUG_KMS("CRTC doesn't have current FB\n");
6653cc8d3b8d1c Ville Syrjälä     2012-03-13  608  				ret = -EINVAL;
6653cc8d3b8d1c Ville Syrjälä     2012-03-13  609  				goto out;
f453ba0460742a Dave Airlie       2008-11-07  610  			}
bf2d5eb902e29d Ville Syrjälä     2018-03-22  611  
a36c027db57b6a Ville Syrjälä     2018-03-22  612  			fb = old_fb;
b0d1232589df55 Daniel Vetter     2012-12-11  613  			/* Make refcounting symmetric with the lookup path. */
a4a69da06bc11a Thierry Reding    2017-02-28  614  			drm_framebuffer_get(fb);
f453ba0460742a Dave Airlie       2008-11-07  615  		} else {
418da17214aca5 Keith Packard     2017-03-14  616  			fb = drm_framebuffer_lookup(dev, file_priv, crtc_req->fb_id);
786b99ed13223d Daniel Vetter     2012-12-02  617  			if (!fb) {
58367ed65f3012 Zhao Yakui        2009-07-20  618  				DRM_DEBUG_KMS("Unknown FB ID%d\n",
58367ed65f3012 Zhao Yakui        2009-07-20  619  						crtc_req->fb_id);
37c4e705fcc4ac Ville Syrjälä     2013-10-17  620  				ret = -ENOENT;
f453ba0460742a Dave Airlie       2008-11-07  621  				goto out;
f453ba0460742a Dave Airlie       2008-11-07  622  			}
f453ba0460742a Dave Airlie       2008-11-07  623  		}
f453ba0460742a Dave Airlie       2008-11-07  624  
f453ba0460742a Dave Airlie       2008-11-07  625  		mode = drm_mode_create(dev);
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  626  		if (!mode) {
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  627  			ret = -ENOMEM;
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  628  			goto out;
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  629  		}
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  630  		if (!file_priv->aspect_ratio_allowed &&
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  631  		    (crtc_req->mode.flags & DRM_MODE_FLAG_PIC_AR_MASK) != DRM_MODE_FLAG_PIC_AR_NONE) {
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  632  			DRM_DEBUG_KMS("Unexpected aspect-ratio flag bits\n");
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  633  			ret = -EINVAL;
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  634  			goto out;
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  635  		}
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  636  
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  637  
75a655e0a26cf0 Ville Syrjälä     2017-11-14  638  		ret = drm_mode_convert_umode(dev, mode, &crtc_req->mode);
90367bf6e98352 Ville Syrjälä     2012-03-13  639  		if (ret) {
6ab0edf4e79c42 Ville Syrjälä     2018-06-11  640  			DRM_DEBUG_KMS("Invalid mode (ret=%d, status=%s)\n",
6ab0edf4e79c42 Ville Syrjälä     2018-06-11  641  				      ret, drm_get_mode_status_name(mode->status));
6ab0edf4e79c42 Ville Syrjälä     2018-06-11  642  			drm_mode_debug_printmodeline(mode);
90367bf6e98352 Ville Syrjälä     2012-03-13  643  			goto out;
90367bf6e98352 Ville Syrjälä     2012-03-13  644  		}
90367bf6e98352 Ville Syrjälä     2012-03-13  645  
7eb5f302bbe78b Laurent Pinchart  2015-03-09  646  		/*
7eb5f302bbe78b Laurent Pinchart  2015-03-09  647  		 * Check whether the primary plane supports the fb pixel format.
7eb5f302bbe78b Laurent Pinchart  2015-03-09  648  		 * Drivers not implementing the universal planes API use a
7eb5f302bbe78b Laurent Pinchart  2015-03-09  649  		 * default formats list provided by the DRM core which doesn't
7eb5f302bbe78b Laurent Pinchart  2015-03-09  650  		 * match real hardware capabilities. Skip the check in that
7eb5f302bbe78b Laurent Pinchart  2015-03-09  651  		 * case.
7eb5f302bbe78b Laurent Pinchart  2015-03-09  652  		 */
64c32b490333c9 Ville Syrjälä     2018-03-22  653  		if (!plane->format_default) {
64c32b490333c9 Ville Syrjälä     2018-03-22  654  			ret = drm_plane_check_pixel_format(plane,
23163a7d4b0324 Ville Syrjälä     2017-12-22  655  							   fb->format->format,
23163a7d4b0324 Ville Syrjälä     2017-12-22  656  							   fb->modifier);
7eb5f302bbe78b Laurent Pinchart  2015-03-09  657  			if (ret) {
b3c11ac267d461 Eric Engestrom    2016-11-12  658  				struct drm_format_name_buf format_name;
948de84233d32b Suraj Upadhyay    2020-07-02  659  
23163a7d4b0324 Ville Syrjälä     2017-12-22  660  				DRM_DEBUG_KMS("Invalid pixel format %s, modifier 0x%llx\n",
438b74a5497c36 Ville Syrjälä     2016-12-14  661  					      drm_get_format_name(fb->format->format,
23163a7d4b0324 Ville Syrjälä     2017-12-22  662  								  &format_name),
23163a7d4b0324 Ville Syrjälä     2017-12-22  663  					      fb->modifier);
7eb5f302bbe78b Laurent Pinchart  2015-03-09  664  				goto out;
7eb5f302bbe78b Laurent Pinchart  2015-03-09  665  			}
7eb5f302bbe78b Laurent Pinchart  2015-03-09  666  		}
7eb5f302bbe78b Laurent Pinchart  2015-03-09  667  
c11e928360777b Damien Lespiau    2013-09-25  668  		ret = drm_crtc_check_viewport(crtc, crtc_req->x, crtc_req->y,
c11e928360777b Damien Lespiau    2013-09-25  669  					      mode, fb);
c11e928360777b Damien Lespiau    2013-09-25  670  		if (ret)
5f61bb421f0102 Ville Syrjälä     2012-03-13  671  			goto out;
c11e928360777b Damien Lespiau    2013-09-25  672  
f453ba0460742a Dave Airlie       2008-11-07  673  	}
f453ba0460742a Dave Airlie       2008-11-07  674  
f453ba0460742a Dave Airlie       2008-11-07  675  	if (crtc_req->count_connectors == 0 && mode) {
58367ed65f3012 Zhao Yakui        2009-07-20  676  		DRM_DEBUG_KMS("Count connectors is 0 but mode set\n");
f453ba0460742a Dave Airlie       2008-11-07  677  		ret = -EINVAL;
f453ba0460742a Dave Airlie       2008-11-07  678  		goto out;
f453ba0460742a Dave Airlie       2008-11-07  679  	}
f453ba0460742a Dave Airlie       2008-11-07  680  
7781de74568bdd Jakob Bornecrantz 2009-08-03  681  	if (crtc_req->count_connectors > 0 && (!mode || !fb)) {
58367ed65f3012 Zhao Yakui        2009-07-20  682  		DRM_DEBUG_KMS("Count connectors is %d but no mode or fb set\n",
f453ba0460742a Dave Airlie       2008-11-07  683  			  crtc_req->count_connectors);
f453ba0460742a Dave Airlie       2008-11-07  684  		ret = -EINVAL;
f453ba0460742a Dave Airlie       2008-11-07  685  		goto out;
f453ba0460742a Dave Airlie       2008-11-07  686  	}
f453ba0460742a Dave Airlie       2008-11-07  687  
f453ba0460742a Dave Airlie       2008-11-07  688  	if (crtc_req->count_connectors > 0) {
f453ba0460742a Dave Airlie       2008-11-07  689  		u32 out_id;
f453ba0460742a Dave Airlie       2008-11-07  690  
f453ba0460742a Dave Airlie       2008-11-07  691  		/* Avoid unbounded kernel memory allocation */
f453ba0460742a Dave Airlie       2008-11-07  692  		if (crtc_req->count_connectors > config->num_connector) {
f453ba0460742a Dave Airlie       2008-11-07  693  			ret = -EINVAL;
f453ba0460742a Dave Airlie       2008-11-07  694  			goto out;
f453ba0460742a Dave Airlie       2008-11-07  695  		}
f453ba0460742a Dave Airlie       2008-11-07  696  
2f6c538924108f Thierry Reding    2014-12-10  697  		connector_set = kmalloc_array(crtc_req->count_connectors,
f453ba0460742a Dave Airlie       2008-11-07  698  					      sizeof(struct drm_connector *),
f453ba0460742a Dave Airlie       2008-11-07  699  					      GFP_KERNEL);
f453ba0460742a Dave Airlie       2008-11-07  700  		if (!connector_set) {
f453ba0460742a Dave Airlie       2008-11-07  701  			ret = -ENOMEM;
f453ba0460742a Dave Airlie       2008-11-07  702  			goto out;
f453ba0460742a Dave Airlie       2008-11-07  703  		}
f453ba0460742a Dave Airlie       2008-11-07  704  
f453ba0460742a Dave Airlie       2008-11-07  705  		for (i = 0; i < crtc_req->count_connectors; i++) {
b164d31f50b292 Dave Airlie       2016-04-27  706  			connector_set[i] = NULL;
81f6c7f873a693 Ville Syrjälä     2011-12-20  707  			set_connectors_ptr = (uint32_t __user *)(unsigned long)crtc_req->set_connectors_ptr;
f453ba0460742a Dave Airlie       2008-11-07 @708  			if (get_user(out_id, &set_connectors_ptr[i])) {
f453ba0460742a Dave Airlie       2008-11-07  709  				ret = -EFAULT;
f453ba0460742a Dave Airlie       2008-11-07  710  				goto out;
f453ba0460742a Dave Airlie       2008-11-07  711  			}
f453ba0460742a Dave Airlie       2008-11-07  712  
418da17214aca5 Keith Packard     2017-03-14  713  			connector = drm_connector_lookup(dev, file_priv, out_id);
a2b34e226ac9fb Rob Clark         2013-10-05  714  			if (!connector) {
58367ed65f3012 Zhao Yakui        2009-07-20  715  				DRM_DEBUG_KMS("Connector id %d unknown\n",
58367ed65f3012 Zhao Yakui        2009-07-20  716  						out_id);
f27657f2ea7ffc Ville Syrjälä     2013-10-17  717  				ret = -ENOENT;
f453ba0460742a Dave Airlie       2008-11-07  718  				goto out;
f453ba0460742a Dave Airlie       2008-11-07  719  			}
9440106b460ddf Jerome Glisse     2010-07-15  720  			DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
9440106b460ddf Jerome Glisse     2010-07-15  721  					connector->base.id,
259338205c4284 Jani Nikula       2014-06-03  722  					connector->name);
f453ba0460742a Dave Airlie       2008-11-07  723  
f453ba0460742a Dave Airlie       2008-11-07  724  			connector_set[i] = connector;
f453ba0460742a Dave Airlie       2008-11-07  725  		}
f453ba0460742a Dave Airlie       2008-11-07  726  	}
f453ba0460742a Dave Airlie       2008-11-07  727  
f453ba0460742a Dave Airlie       2008-11-07  728  	set.crtc = crtc;
f453ba0460742a Dave Airlie       2008-11-07  729  	set.x = crtc_req->x;
f453ba0460742a Dave Airlie       2008-11-07  730  	set.y = crtc_req->y;
f453ba0460742a Dave Airlie       2008-11-07  731  	set.mode = mode;
f453ba0460742a Dave Airlie       2008-11-07  732  	set.connectors = connector_set;
f453ba0460742a Dave Airlie       2008-11-07  733  	set.num_connectors = crtc_req->count_connectors;
f453ba0460742a Dave Airlie       2008-11-07  734  	set.fb = fb;
69a8a1961c7bf5 Ville Syrjälä     2018-07-05  735  
69a8a1961c7bf5 Ville Syrjälä     2018-07-05  736  	if (drm_drv_uses_atomic_modeset(dev))
69a8a1961c7bf5 Ville Syrjälä     2018-07-05  737  		ret = crtc->funcs->set_config(&set, &ctx);
69a8a1961c7bf5 Ville Syrjälä     2018-07-05  738  	else
2ceb585a956c10 Daniel Vetter     2017-03-22  739  		ret = __drm_mode_set_config_internal(&set, &ctx);
f453ba0460742a Dave Airlie       2008-11-07  740  
f453ba0460742a Dave Airlie       2008-11-07  741  out:
b0d1232589df55 Daniel Vetter     2012-12-11  742  	if (fb)
a4a69da06bc11a Thierry Reding    2017-02-28  743  		drm_framebuffer_put(fb);
b0d1232589df55 Daniel Vetter     2012-12-11  744  
b164d31f50b292 Dave Airlie       2016-04-27  745  	if (connector_set) {
b164d31f50b292 Dave Airlie       2016-04-27  746  		for (i = 0; i < crtc_req->count_connectors; i++) {
b164d31f50b292 Dave Airlie       2016-04-27  747  			if (connector_set[i])
ad09360750afa1 Thierry Reding    2017-02-28  748  				drm_connector_put(connector_set[i]);
b164d31f50b292 Dave Airlie       2016-04-27  749  		}
b164d31f50b292 Dave Airlie       2016-04-27  750  	}
f453ba0460742a Dave Airlie       2008-11-07  751  	kfree(connector_set);
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  752  	drm_mode_destroy(dev, mode);
c232e9f41b136c Sean Paul         2018-11-29  753  
c232e9f41b136c Sean Paul         2018-11-29  754  	/* In case we need to retry... */
c232e9f41b136c Sean Paul         2018-11-29  755  	connector_set = NULL;
c232e9f41b136c Sean Paul         2018-11-29  756  	fb = NULL;
c232e9f41b136c Sean Paul         2018-11-29  757  	mode = NULL;
c232e9f41b136c Sean Paul         2018-11-29  758  
b7ea04d299c78b Sean Paul         2018-11-29  759  	DRM_MODESET_LOCK_ALL_END(ctx, ret);
53552d5df6694f Daniel Vetter     2017-04-06  760  	mutex_unlock(&crtc->dev->mode_config.mutex);
2ceb585a956c10 Daniel Vetter     2017-03-22  761  
f453ba0460742a Dave Airlie       2008-11-07  762  	return ret;
f453ba0460742a Dave Airlie       2008-11-07  763  }
f453ba0460742a Dave Airlie       2008-11-07  764  

:::::: The code at line 708 was first introduced by commit
:::::: f453ba0460742ad027ae0c4c7d61e62817b3e7ef DRM: add mode setting support

:::::: TO: Dave Airlie <airlied@redhat.com>
:::::: CC: Dave Airlie <airlied@linux.ie>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
