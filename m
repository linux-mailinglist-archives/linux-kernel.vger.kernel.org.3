Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211A154BE45
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344618AbiFNXXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiFNXW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:22:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B492CE27
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655248976; x=1686784976;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N2rzx4u2KZLS0NYCVwK0dGeszokEfiC/OTlbKJIVTH0=;
  b=Mo4VDFiQNAww4s5SdSnNHCFA2a6VmAf4qhmV/Uxu6Yy6ViWC+UHTFklW
   zpBP/tiEsmdVWbKGjGrLoA+n0mwZqVmTBT5w6MfOsNMgWGjwCTIojukNF
   NiTY4zIARJKjnByiqTmaR82dgMl3nOdwpNlL4IsCITc05Vdu230ya1R9+
   odkhFqqm96fjDVGQTv9b89jMJ7XMBAugyvpR64aRzChYzZrS4HL2KO71x
   rbcg+HQYwTlDRdYOvlMSCmH1YdKMcrgSR9IvebHSGn3ocBmdrwmnj2J0V
   WQFwiu9og223qSWLsiv8RmQ05mk7+kntmAnRHPG6UJLOu7/Ra27HbgEuT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="261798381"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="261798381"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 16:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="652321963"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2022 16:22:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1Fs5-000MO3-Td;
        Tue, 14 Jun 2022 23:22:53 +0000
Date:   Wed, 15 Jun 2022 07:22:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/dsa/ocelot/seville_vsc9953.c:1107:34: warning:
 'seville_of_match' defined but not used
Message-ID: <202206150743.1cNDGvnK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   018ab4fabddd94f1c96f3b59e180691b9e88d5d8
commit: d60bc62de4ae068ed4b215c24cdfdd5035aa986e net: dsa: seville: build as separate module
date:   1 year, 9 months ago
config: i386-randconfig-s032-20220613 (https://download.01.org/0day-ci/archive/20220615/202206150743.1cNDGvnK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d60bc62de4ae068ed4b215c24cdfdd5035aa986e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d60bc62de4ae068ed4b215c24cdfdd5035aa986e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/dsa/ocelot/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/ocelot/seville_vsc9953.c:1107:34: warning: 'seville_of_match' defined but not used [-Wunused-const-variable=]
    1107 | static const struct of_device_id seville_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~


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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
