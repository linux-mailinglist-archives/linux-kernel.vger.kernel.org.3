Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CA253697F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 02:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355295AbiE1Awb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 20:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiE1Aw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 20:52:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F1761604
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 17:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653699147; x=1685235147;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sm5xN1CbYEC903RWClkDQVhhzGBR/HpfpYxCNdoZcqc=;
  b=KuFGfRohfX1wRhAPdo18lpdboqy75Y3fKRB9/T7qQABkF96RLWiSzQuV
   6uwNGuNKaxVoSN1nWwtUDkxN/q6e5DTL6hWkZlyC4XOdb8jSa+wnGExlG
   dFFAijh6MnN4jdwRG5MSkp9dg2iDDqoOGkQO6lXq8fg6B6GDrQgzTC1Q8
   bX4r8amVinZv4/cTTdoS/WZUhMZJeeRbpGOurFmt8FfcnkNdrDAkU958R
   IY87O4ZE+EAU0Jyl/qAy13XqiB2LWJoA4Az2TR7fsP7wPl4MMbYHxieRu
   VDA95WrS9FiaIZyfrUhcjUo2V78RCWxaVMUzb3uLzcmq4u6NKRuZR2Mtw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="299955261"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="299955261"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 17:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="747315475"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2022 17:52:26 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nukgr-0005JR-Jj;
        Sat, 28 May 2022 00:52:25 +0000
Date:   Sat, 28 May 2022 08:51:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Subject: sound/pci/hda/patch_cs8409-tables.c:79:25: sparse: sparse: symbol
 'cs8409_cs42l42_pincfgs_no_dmic' was not declared. Should it be static?
Message-ID: <202205280812.a2WZ85Fx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bf272460d744112bacd4c4d562592decbf0edf64
commit: 22bb82264c655ef297adf442cdc796849e5a2a8c ALSA: hda/cs8409: Support new Odin Variants
date:   2 weeks ago
config: arc-randconfig-s031-20220527 (https://download.01.org/0day-ci/archive/20220528/202205280812.a2WZ85Fx-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=22bb82264c655ef297adf442cdc796849e5a2a8c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 22bb82264c655ef297adf442cdc796849e5a2a8c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash drivers/misc/lkdtm/ sound/pci/hda/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> sound/pci/hda/patch_cs8409-tables.c:79:25: sparse: sparse: symbol 'cs8409_cs42l42_pincfgs_no_dmic' was not declared. Should it be static?

vim +/cs8409_cs42l42_pincfgs_no_dmic +79 sound/pci/hda/patch_cs8409-tables.c

    78	
  > 79	const struct hda_pintbl cs8409_cs42l42_pincfgs_no_dmic[] = {
    80		{ CS8409_PIN_ASP1_TRANSMITTER_A, 0x042120f0 },	/* ASP-1-TX */
    81		{ CS8409_PIN_ASP1_RECEIVER_A, 0x04a12050 },	/* ASP-1-RX */
    82		{ CS8409_PIN_ASP2_TRANSMITTER_A, 0x901000f0 },	/* ASP-2-TX */
    83		{} /* terminator */
    84	};
    85	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
