Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7576B53D8BA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 00:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbiFDWVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 18:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbiFDWU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 18:20:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00EF36164
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654381256; x=1685917256;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RabymgCqmi/AtvPh/kFx3QlZbW6c/B7cgP+iUjv4WjY=;
  b=M++gJ+8N9pkRvh+0HGXc+aQESsAqr8dUoBr+eYb56XTQfGxd7afqPk8I
   cctzGnodM9tI9p3bap64UV5B9AEAoniB80zjQUrnaVAb5ZJSSElflg6TQ
   BMZt/jd5Hzm78o8491mgaGHfZWSqw5wcjRJ46ArCD94X9S0RDCvB+cEXW
   H3xb8MntnqW9esk0Bg6jgzo4HZ3yeEQFBAwdjiLq1/waCkMX+Ba3UirUW
   Lbe8tWfo7FomTnDsq+t1kqbMSMaRZOyVpNWPTAbU//gcXGlps39PtMLvE
   +4g5sVkJ5eBPSOnTtJkbVbjs8KS36Ck5Q9DTSIeS4EgDaIi97FjV9h58N
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="337166458"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="337166458"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 15:20:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="668948595"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2022 15:20:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxc8b-000BFb-RM;
        Sat, 04 Jun 2022 22:20:53 +0000
Date:   Sun, 5 Jun 2022 06:20:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Sean Wang <sean.wang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [nbd168-wireless:mt76 5/13]
 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c:64:68: sparse: sparse:
 Using plain integer as NULL pointer
Message-ID: <202206050617.FMBZUzPN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mt76
head:   bf744ed33b209f6d8de1b2a5b806c5fe38cd1e7c
commit: ab79a7d7a96f3325a120b6658ea9d8a3eaa2eb09 [5/13] mt76: mt7921: introduce ACPI SAR support
config: ia64-randconfig-s031-20220605 (https://download.01.org/0day-ci/archive/20220605/202206050617.FMBZUzPN-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://github.com/nbd168/wireless/commit/ab79a7d7a96f3325a120b6658ea9d8a3eaa2eb09
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mt76
        git checkout ab79a7d7a96f3325a120b6658ea9d8a3eaa2eb09
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/mt7921/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c:64:68: sparse: sparse: Using plain integer as NULL pointer

vim +64 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c

    59	
    60	/* MTCL : Country List Table for 6G band */
    61	static int
    62	mt7921_asar_acpi_read_mtcl(struct mt7921_dev *dev, u8 **table, u8 *version)
    63	{
  > 64		*version = (mt7921_acpi_read(dev, MT7921_ACPI_MTCL, table, 0) < 0)
    65			   ? 1 : 2;
    66		return 0;
    67	}
    68	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
