Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1971D488735
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 02:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiAIB1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 20:27:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:46209 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbiAIB1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 20:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641691637; x=1673227637;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4YeicfVBQeHcvDEk0vcF0T29V+pc8uYFRoJ+tNGqVfE=;
  b=NJ0byEOBJcjiTyeJhFuJdcBGXcIhdLiFiUG2LWSFyiFBKTdub67M8ik+
   r0KtkG1fvmjK40xYT1FMUhW7SqcxDrl0gUt0zADsEk8PyzvFt9/mm22la
   DlmHX2gwWIjYIs3pyfRdmCP0w3XgYsPBClCz0XKNtmEEz4nWc11sLoXPi
   sz3fTpaSmWx1l8tOAkJh+xkg92RATHc3DH/v2E88gTliTWbGqQkeob04h
   4RcxTTJA7jbC6GRUB9FrG3WSfmAAWq2OX8rLzdvvMlkOHd0pL4HvXVDVZ
   TDf6o9U013eTTDcB69cvah4P79OhS99hMNzgsUS7KUy3ZKanrBmqlAEkA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="223749491"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="223749491"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 17:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="690193927"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2022 17:27:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6MzL-0001Fs-HE; Sun, 09 Jan 2022 01:27:15 +0000
Date:   Sun, 9 Jan 2022 09:26:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Subject: [ammarfaizi2-block:tiwai/sound/master 182/191]
 cs35l41_hda_spi.c:undefined reference to `__devm_regmap_init_spi'
Message-ID: <202201090923.rxJv49Vw-lkp@intel.com>
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
config: ia64-randconfig-r035-20220106 (https://download.01.org/0day-ci/archive/20220109/202201090923.rxJv49Vw-lkp@intel.com/config)
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

All errors (new ones prefixed by >>):

   ia64-linux-ld: sound/pci/hda/cs35l41_hda_spi.o: in function `cs35l41_hda_spi_probe':
>> cs35l41_hda_spi.c:(.text+0xd2): undefined reference to `__devm_regmap_init_spi'
   ia64-linux-ld: sound/pci/hda/cs35l41_hda_spi.o: in function `cs35l41_spi_driver_init':
>> cs35l41_hda_spi.c:(.init.text+0x22): undefined reference to `__spi_register_driver'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
