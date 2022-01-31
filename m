Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E024A3C61
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357231AbiAaAwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:52:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:21741 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbiAaAwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643590322; x=1675126322;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LEbL7AwcMyFVN80lxroY/ruCOLS5Oay2M/N67w9nhh4=;
  b=HdBKGDxpuk1wIVdAN53z+UQ2EUKyTDf04enQXD0yrlZ1tvlwU1KxBa0h
   5YUVjHB9LksucpllQA39ISIftlnRohshfWpRXOvonOlky5XexLQGXVcx5
   L7kaQBmnyhNEm+CPHpL/sSEjvIcx+zxT5NTQxf5Wg80d+g1EvWafV9ZdC
   5ZcOS1XIu3z+akbwPyGQUPr16/IV9/zHNMdCerXDtUDUJ9FXqE5KnEMQ1
   2PP2MUfFD0l5B0j6YSvKF6c9algSJbLlfwnRHq0EYsS40r7FTFq0Xhs7O
   OoGcLuheaooyowDQ2v7hTbcL51ot5RTdZXZwJI4B4kpC9OSRDfmgG+QV6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="227356985"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="227356985"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 16:52:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="522472652"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2022 16:52:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEKvH-000RBY-Nm; Mon, 31 Jan 2022 00:51:59 +0000
Date:   Mon, 31 Jan 2022 08:51:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [linux-stable-rc:queue/4.9 9687/9999] wacom_sys.c:undefined
 reference to `usb_hid_driver'
Message-ID: <202201310835.dNisxE9I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.9
head:   7ef5087ab3f5ed886dded42cff14ec6a40040a05
commit: 1309eb2ef1001c4cc7e07b867ad9576d2cfeab47 [9687/9999] HID: wacom: fix problems when device is not a valid USB device
config: ia64-randconfig-r035-20220131 (https://download.01.org/0day-ci/archive/20220131/202201310835.dNisxE9I-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=1309eb2ef1001c4cc7e07b867ad9576d2cfeab47
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.9
        git checkout 1309eb2ef1001c4cc7e07b867ad9576d2cfeab47
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock' at 0x5035b2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x503ce2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x503d82 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x503e32 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x503ec2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x503f62 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x504462 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_unlock' at 0x5047c2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_unlock' at 0x504802 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_lock_irqsave' at 0x505aa2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x505b72 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x507712 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x507782 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x507842 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `.text.unlikely' at 0x508bb2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x50a2a2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `.text.unlikely' at 0x50c572 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_lock_irqsave' at 0x50d832 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x50d992 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x50e552 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x50e622 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x50e692 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `__irq_domain_add' at 0x50ec12 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x510412 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x5109f2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x5120b2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock' at 0x51a1c2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_unlock' at 0x522002 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_unlock' at 0x5233c2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_unlock' at 0x523562 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x525742 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x52bc52 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock_irqrestore' at 0x5333a2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x5396b2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_lock' at 0x542f32 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_lock' at 0x550c52 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_unlock' at 0x550fb2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_unlock' at 0x553302 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_lock' at 0x553622 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_lock' at 0x553752 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x55bb82 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x55bcc2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock' at 0x55fe72 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock' at 0x560132 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `ww_mutex_unlock' at 0x560152 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x564a82 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x564ad2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x564bd2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_lock' at 0x565362 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x56cba2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x56fb92 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x577422 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `memcpy_fromio' at 0x57c522 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `memcpy_toio' at 0x57c5f2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `memset_io' at 0x57c6a2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x584ed2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `ww_mutex_unlock' at 0x590922 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `__mutex_init' at 0x590ad2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_destroy' at 0x590d52 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `memcpy_toio' at 0x591042 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `udelay' at 0x596192 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_lock' at 0x5981f2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_lock' at 0x598f22 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_lock' at 0x5993d2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock' at 0x59a692 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock' at 0x59a812 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `mutex_lock' at 0x59b542 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `vmalloc_to_page' at 0x5a0042 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kfree' at 0x5a09a2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kfree' at 0x5a0d92 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock' at 0x5a1212 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `__wake_up' at 0x5a13e2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `queue_delayed_work_on' at 0x5a1a52 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_unlock' at 0x5a1a62 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `__wake_up' at 0x5a1ba2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `init_wait_entry' at 0x5a1d62 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `finish_wait' at 0x5a1e82 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `__wake_up' at 0x5a1f82 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `__wake_up' at 0x5a1fe2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `finish_wait' at 0x5a2042 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `__wake_up' at 0x5a21a2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `__wake_up' at 0x5a2252 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `__wake_up' at 0x5a2322 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `finish_wait' at 0x5a2762 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_lock' at 0x5a2982 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `_raw_spin_lock' at 0x5a2b52 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `__init_waitqueue_head' at 0x5a3152 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kmem_cache_free' at 0x5a3682 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kmem_cache_create' at 0x5a36f2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kmem_cache_alloc' at 0x5a4ba2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kfree' at 0x5a6242 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kfree' at 0x5a7442 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kfree' at 0x5a7492 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kfree' at 0x5a7512 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kfree' at 0x5a75d2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kfree' at 0x5a7762 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kfree' at 0x5a78d2 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kfree' at 0x5a9552 in section `.text' with size 0x15b1f80 (> 0x1000000).
   ia64-linux-ld: drivers/built-in.o: Can't relax br (PCREL21B) to `kfree' at 0x5a9562 in section `.text' with size 0x15b1f80 (> 0x1000000).
   drivers/built-in.o: In function `wacom_probe':
>> wacom_sys.c:(.text+0x14b0171): undefined reference to `usb_hid_driver'
   wacom_sys.c:(.text+0x14b01b0): undefined reference to `usb_hid_driver'
   ia64-linux-ld: final link failed: Symbol needs debug section which does not exist

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
