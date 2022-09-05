Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6755ACE92
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiIEJGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiIEJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:06:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4382409B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662368769; x=1693904769;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YosgPVubAkhecmElBd6Zv2prwZx+4dCrjw67EmJYa5Q=;
  b=jqzGIbrVd/pEZlbrEApt3lz+TYYKkBNNFcabRCPwUmhz1oVNTXFChLBD
   QLLmyIl/X6HK65PPNHPGqP3JhSWsJRz7x9f5MA3UkTw3KrXgjDUd0gbL3
   LpyFVn+bzGt69zbn6ksuGcVNiKjUaagc41ls49vF/aDm3ZEvWZi6nbVUZ
   YVWPH1Ii2tDtrvVhPFJYy1WiKicQw1PqKdWCG9YyccLuDiT2IxQHVlezT
   gi294/NYMqs5eHJHEDfcLJnIF142xwyIbku+woP+Cw00BxU9BcEeEgzFf
   +YHvgpN467W1KAxtBARlOI9qZPx3PN0u7gcKSCNUJ8e8lWQY3FLZj98GX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="279361187"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="279361187"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 02:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="681995482"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2022 02:06:08 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oV83T-000409-16;
        Mon, 05 Sep 2022 09:06:07 +0000
Date:   Mon, 5 Sep 2022 17:05:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [char-misc:char-misc-next 20/24] mchp_pci1xxxx_gp.c:undefined
 reference to `auxiliary_device_init'
Message-ID: <202209051640.fxbeBDn5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-next
head:   50e177c5bfd9abc3828cb57e14e6169170f6764a
commit: 393fc2f5948fd340d016a9557eea6e1ac2f6c60c [20/24] misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.
config: ia64-randconfig-c44-20220905 (https://download.01.org/0day-ci/archive/20220905/202209051640.fxbeBDn5-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=393fc2f5948fd340d016a9557eea6e1ac2f6c60c
        git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
        git fetch --no-tags char-misc char-misc-next
        git checkout 393fc2f5948fd340d016a9557eea6e1ac2f6c60c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.o: in function `gp_aux_bus_probe.part.0':
>> mchp_pci1xxxx_gp.c:(.text+0x342): undefined reference to `auxiliary_device_init'
>> ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x392): undefined reference to `__auxiliary_device_add'
>> ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x5c2): undefined reference to `auxiliary_device_init'
   ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x612): undefined reference to `__auxiliary_device_add'
   `adc3xxx_i2c_remove' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
