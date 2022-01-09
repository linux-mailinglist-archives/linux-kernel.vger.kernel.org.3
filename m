Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A2548871D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 01:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiAIA4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 19:56:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:44803 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235051AbiAIA4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 19:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641689777; x=1673225777;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6REeg58/Ll7LfkeN58RUh+/3go/bo+Bn/kC/eSCMcCc=;
  b=aUOloGzFfs+RxPn7QO+y/Eb8k2Yr5HYv3t59ZdT9D/eoUOLMOpjXMpw8
   IXxNm2KpWJnXBAvPX/8cM4xv4f0DTuESkEUctk/Gz1QPu+JoN410DsPO2
   nlfFYCxtKM6EXLvsE7M6489+HQJHiCtQnGxxYpTSC3FVl4f+XDcprwZsN
   YYJLH+L0v9uj5TFIprTI/6x0XLPKSP5fCuSgHzkz6DY0JWadeAJBVEWPu
   72lmjJewuGi9VwoKFKTegOQvSfMwbcWQhGkM+vbohUxJJs4wv0ACIQd2B
   oZ+mu1i/acuCYNAUy9F0HEdGRrMdqqDkf8d4rPF3yGd7MfEhQBHCVjxzK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="329391532"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="329391532"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 16:56:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="473735590"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2022 16:56:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6MVK-0001EO-OY; Sun, 09 Jan 2022 00:56:14 +0000
Date:   Sun, 9 Jan 2022 08:56:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Subject: [ammarfaizi2-block:tiwai/sound/master 182/191]
 cs35l41_hda.c:undefined reference to `cs35l41_set_channels'
Message-ID: <202201090857.2SBm5aTL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tiwai/sound/master
head:   d678af1433773cd81ebc1054131c8efc9ff00269
commit: 7b2f3eb492dac7665c75df067e4d8e4869589f4a [182/191] ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems
config: ia64-buildonly-randconfig-r005-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090857.2SBm5aTL-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7b2f3eb492dac7665c75df067e4d8e4869589f4a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tiwai/sound/master
        git checkout 7b2f3eb492dac7665c75df067e4d8e4869589f4a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/tiwai/sound/master HEAD 1847f902f2a4c9143cb79507713fae0716928a27 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   ia64-linux-ld: sound/pci/hda/cs35l41_hda.o: in function `cs35l41_hda_channel_map':
>> cs35l41_hda.c:(.text+0x222): undefined reference to `cs35l41_set_channels'
   ia64-linux-ld: sound/pci/hda/cs35l41_hda.o: in function `cs35l41_hda_apply_properties':
>> cs35l41_hda.c:(.text+0xd52): undefined reference to `cs35l41_boost_config'
>> ia64-linux-ld: cs35l41_hda.c:(.text+0xdf2): undefined reference to `cs35l41_set_channels'
   ia64-linux-ld: sound/pci/hda/cs35l41_hda.o: in function `cs35l41_hda_probe':
>> cs35l41_hda.c:(.text+0x1252): undefined reference to `cs35l41_register_errata_patch'
>> ia64-linux-ld: cs35l41_hda.c:(.text+0x1282): undefined reference to `cs35l41_otp_unpack'
   ia64-linux-ld: sound/pci/hda/cs35l41_hda_spi.o: in function `cs35l41_hda_spi_probe':
>> cs35l41_hda_spi.c:(.text+0x82): undefined reference to `cs35l41_regmap_spi'
>> ia64-linux-ld: cs35l41_hda_spi.c:(.text+0xa0): undefined reference to `cs35l41_regmap_spi'
>> ia64-linux-ld: cs35l41_hda_spi.c:(.text+0xc2): undefined reference to `__devm_regmap_init_spi'
   ia64-linux-ld: sound/pci/hda/cs35l41_hda_spi.o: in function `cs35l41_spi_driver_init':
>> cs35l41_hda_spi.c:(.init.text+0x22): undefined reference to `__spi_register_driver'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_SOC_CS35L41_LIB
   Depends on SOUND && !UML && SND && SND_SOC
   Selected by
   - SND_HDA_SCODEC_CS35L41_SPI && SOUND && !UML && SND && SND_HDA && ACPI

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
