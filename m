Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB0A462D75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbhK3H14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:27:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:6984 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhK3H1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:27:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="236104983"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="236104983"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 23:24:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="676722466"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2021 23:24:34 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrxVB-000Cto-FN; Tue, 30 Nov 2021 07:24:33 +0000
Date:   Tue, 30 Nov 2021 15:24:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tglx-devel:msi 12/101] arch/x86/kernel/apic/msi.c:352:9: error:
 implicit declaration of function 'xen_initdom_restore_msi'
Message-ID: <202111301541.76r8diQD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi
head:   1fd2d0e8970556f4495ebc122b6e7f249393022e
commit: 0d4bbd35acbeb675aa06a4b8b5b2ea4cbd776365 [12/101] PCI/MSI: Make arch_restore_msi_irqs() less horrible.
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20211130/202111301541.76r8diQD-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=0d4bbd35acbeb675aa06a4b8b5b2ea4cbd776365
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel msi
        git checkout 0d4bbd35acbeb675aa06a4b8b5b2ea4cbd776365
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/apic/msi.c: In function 'arch_restore_msi_irqs':
>> arch/x86/kernel/apic/msi.c:352:9: error: implicit declaration of function 'xen_initdom_restore_msi' [-Werror=implicit-function-declaration]
     352 |  return xen_initdom_restore_msi(dev);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/xen_initdom_restore_msi +352 arch/x86/kernel/apic/msi.c

   349	
   350	bool arch_restore_msi_irqs(struct pci_dev *dev)
   351	{
 > 352		return xen_initdom_restore_msi(dev);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
