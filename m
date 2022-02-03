Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C014A85C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351005AbiBCOGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:06:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:54566 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350989AbiBCOGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643897194; x=1675433194;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EOGKB5/dHnYRfH4X4MGhJCq1Ozfmtx54RuY8vRippoA=;
  b=DDs7m9L9Euf/SJZjfmgpy+eTnJrwmSUS5u3TeZqxxf0hqfPt/CIj0V0Y
   /IGHOn3BEmSIVlAZCw1FzPB3V6J/r78dXd+4jHAJhN5O/PmZKwa/Gp1hC
   v4s4UDyZ7cSHL4GK/j3wm6IW7lqgA4njWu7l9KCPgdMMDIfzTrLg7m6D6
   1Ki6gTOB+4Wryhla9eo3vfBuqMVDHb3JQuaQm4vJcx0v7dgUHyu0OL/Zl
   gUXX0HUC/z5AK0MBVsdlf7+fJhjJ97YECtDcD3BJRo5G0XO5XXoM6j/qt
   BbYOZabp/eRajyNyQppQu+UPksqCYc5USbkWiXsYK5Dez8zRF2J+fdrmI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="245742918"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="245742918"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="535209180"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Feb 2022 06:06:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFckY-000WC3-Gu; Thu, 03 Feb 2022 14:06:14 +0000
Date:   Thu, 3 Feb 2022 22:05:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Andrew Lunn <andrew@lunn.ch>
Subject: dtbs_check: arch/arm/boot/dts/armada-385-atl-x530.dt.yaml:
 partitions: 'partition@errlog', 'partition@nand-bbt', 'partition@user' do
 not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$',
 '^#[a-zA-Z0-9,+\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9...
Message-ID: <202202031529.ItJcanZX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26291c54e111ff6ba87a164d85d4a4e134b7315c
commit: c6dfc019c239c76c179ebbccbac27170ba1e3bb6 ARM: dts: mvebu: Add device tree for ATL-x530 Board
date:   10 months ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
