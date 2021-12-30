Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811F7481816
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 02:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhL3B23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 20:28:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:41975 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234009AbhL3B22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 20:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640827708; x=1672363708;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T1BRpgtTzTMGUhrkDuKAO2kJs/QvxfkdFHstWKsnIQk=;
  b=lmxq5HKFZ1VcQNgIQSF8ibIFRBFyd4g5lHHz+PGpcpXVx9cQRPjaUa5N
   poh7bQ9EdF82shjtUD4PviA2avkgvATAqaVLFEakIKshxvNhD3b2CCox6
   wLoK9RnGzsaAuub4weQr7Dv+zCI9VHaB/yK7ukob9Us0kK32fJUTXwlKU
   qnLmBMdfbdbOrw95c3AnJkrkPLUT1LtHsUXojl3oIetdnnhl4lxoTdsBr
   y7sxbjflpyjSp+EwhZrn9r7dC17yxPDSSlc0BWTdwcX5txJ1Ce24NInZT
   RzteWrPnMdSVPWmajdvflgv+4mwtTj70e/MG3pmbgkoms3Pd2Ofvh6Gc7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="241398655"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="241398655"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 17:28:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="510719762"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Dec 2021 17:28:27 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2kF0-0009Xc-GL; Thu, 30 Dec 2021 01:28:26 +0000
Date:   Thu, 30 Dec 2021 09:27:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/dsa/ocelot/seville_vsc9953.c:1107:34: warning: unused
 variable 'seville_of_match'
Message-ID: <202112300929.wXa5Kh1J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eec4df26e24e978e49ccf9bcf49ca0f2ccdaeffe
commit: d60bc62de4ae068ed4b215c24cdfdd5035aa986e net: dsa: seville: build as separate module
date:   1 year, 3 months ago
config: x86_64-randconfig-r005-20211230 (https://download.01.org/0day-ci/archive/20211230/202112300929.wXa5Kh1J-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project cd284b7ac0615afc6e0f1a30da2777e361de27a3)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d60bc62de4ae068ed4b215c24cdfdd5035aa986e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d60bc62de4ae068ed4b215c24cdfdd5035aa986e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/dsa/ocelot/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/ocelot/seville_vsc9953.c:1107:34: warning: unused variable 'seville_of_match' [-Wunused-const-variable]
   static const struct of_device_id seville_of_match[] = {
                                    ^
   1 warning generated.


vim +/seville_of_match +1107 drivers/net/dsa/ocelot/seville_vsc9953.c

84705fc165526e Maxim Kochetkov 2020-07-13  1106  
84705fc165526e Maxim Kochetkov 2020-07-13 @1107  static const struct of_device_id seville_of_match[] = {
84705fc165526e Maxim Kochetkov 2020-07-13  1108  	{ .compatible = "mscc,vsc9953-switch" },
84705fc165526e Maxim Kochetkov 2020-07-13  1109  	{ },
84705fc165526e Maxim Kochetkov 2020-07-13  1110  };
84705fc165526e Maxim Kochetkov 2020-07-13  1111  MODULE_DEVICE_TABLE(of, seville_of_match);
84705fc165526e Maxim Kochetkov 2020-07-13  1112  

:::::: The code at line 1107 was first introduced by commit
:::::: 84705fc165526e8e55d208b2b10a48cc720a106a net: dsa: felix: introduce support for Seville VSC9953 switch

:::::: TO: Maxim Kochetkov <fido_max@inbox.ru>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
