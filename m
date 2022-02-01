Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4C4A5588
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 04:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiBADQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 22:16:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:19606 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232503AbiBADQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643685375; x=1675221375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yfo674H4u4i0L+gHRBG+CTFi9ZyNwWj4pI6zYvCZZc4=;
  b=n2fl6QaEMysH9RqqrZrJWciJli7e3rmJMAwyb4WJJkzCWPzhbbOeJKQ8
   zNiHIRTFwy50530s7txqG4O8YnhhnmHio1RfSDDtcYx0XdN6ikh9DgGpj
   Y3FPCh0HqS6isApyn00eHnsC/lhadehmskrMGJ26V/7DLg2klNqkAfCVS
   m+G9N2s8tm4gVrL9qoEQiccAmIBIQ06cisZxD403yN+pFtRhqMH1GluwI
   LnLPrNL4ce0W7R5O7MbTVaNTPtSmMoVnSrmSqBanZOriJdkdBf43HQd6x
   r8ALPMjIJWHKdgikhmmxnYyEmKmag3EUvYtSK8p8FFQLi0vTq/XUb57D5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247381990"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="247381990"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 19:16:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="619655862"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jan 2022 19:16:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEjeP-000ShG-K7; Tue, 01 Feb 2022 03:16:13 +0000
Date:   Tue, 1 Feb 2022 11:16:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: undefined reference to `pci_remap_iospace'
Message-ID: <202202011148.MdzUvZDT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26291c54e111ff6ba87a164d85d4a4e134b7315c
commit: 09d97da660ff77df20984496aa0abcd6b88819f2 MIPS: Only define pci_remap_iospace() for Ralink
date:   8 weeks ago
config: mips-randconfig-r021-20220131 (https://download.01.org/0day-ci/archive/20220201/202202011148.MdzUvZDT-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09d97da660ff77df20984496aa0abcd6b88819f2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09d97da660ff77df20984496aa0abcd6b88819f2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mipsel-linux-ld: drivers/pci/pci.o: in function `devm_pci_remap_iospace':
>> (.text+0x2278): undefined reference to `pci_remap_iospace'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
