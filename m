Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3231F48D070
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiAMCae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:30:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:6035 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231704AbiAMCac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642041032; x=1673577032;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=llyDvRTelZCAnt1K0f0oxqdRLViW4Y9cQ/+Ftuh5YAE=;
  b=l+5R2B/GgyiPoEeFsimJOi9oJ3ZvHZgiQZBRYHECjLyu5iNMhAvEhpPT
   oZyFxpeHYqLEpCCI6bpCltqjHsRaZpD0bP3a69Jih3b7CBJURz59Hi/Jz
   +XjKglBgpQYyszoLtifF7TYNQ7yyWr6eWrKSPRjZP27muOpxv/DerBVBb
   WGKgJBAqh30dwnVY9dncXhfHiMEiVoUhZ6fT8t4yK3NqxCZsgQgUiBIsX
   UmG6SyFEhMGT8pPitVpBxUFOC9P4zamshLyuQIOjQWd6dK5l9PTvpYp82
   fPaTvAvZSDvB6XUJW1uk2XaTGiBrpZ2YXe1QzdyE9sCY4MNiouN6kHqyY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="241469108"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="241469108"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 18:30:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="473064002"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 12 Jan 2022 18:30:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7psi-0006jt-Gf; Thu, 13 Jan 2022 02:30:28 +0000
Date:   Thu, 13 Jan 2022 10:29:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rmk-arm:sa1100 50/57] ERROR: modpost: "ipaq_micro_tx_msg"
 [arch/arm/mach-sa1100/h3xxx-sleeve.ko] undefined!
Message-ID: <202201131035.r0YR2iwn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm sa1100
head:   7c5e0e177553f8a9ef3424e59fb3ef69c6b71689
commit: e0903a11cbed3fcc17d26af1d2a9d7f842e60ac7 [50/57] ARM: sa1100/h3xxx: sleeve support
config: arm-shannon_defconfig (https://download.01.org/0day-ci/archive/20220113/202201131035.r0YR2iwn-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 244dd2913a43a200f5a6544d424cdc37b771028b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm sa1100
        git checkout e0903a11cbed3fcc17d26af1d2a9d7f842e60ac7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ipaq_micro_tx_msg" [arch/arm/mach-sa1100/h3xxx-sleeve.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
