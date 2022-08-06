Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F358B5D4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 16:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiHFOJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 10:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiHFOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 10:09:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC69111A1B
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659794939; x=1691330939;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wy9tQj2vVx6PdmRmRCDoXdkzsYBBuX6j+8FMZufhnWg=;
  b=UdZfXoK/FsIS3KpWEcHb+XS8B7irsFZXnJAUFjI0JJJdNVkE4X7AE96M
   KWhmcngMYuwGlob2+zbRoRf7DWZiF9PkmESLc5Qmvj6HTXZSuuedL88wJ
   DUw3T1s/ZmtZJEAQTcSS9ZZTdTwvH5oFmvuFj87bS4iNLeQzxtB+cojXk
   6MdlSl+m7CxEBkNsGOQqOjW4Aoed5EZau6HSrd3dPyfMf2uaSeR4RzX7T
   GCWdrnpZSaTI9vuiisZ5q5QqTaysCyymwRalvPLM57SlODpGXj2JdrEWM
   SX6Hvl91Onv0mvMeyCJ4+mSi0Az7Fo6oBdL0qZGGfL6poQe+dp5fJRjkW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="289126975"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289126975"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 07:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="579820314"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2022 07:08:58 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKKU5-000KQB-1h;
        Sat, 06 Aug 2022 14:08:57 +0000
Date:   Sat, 6 Aug 2022 22:08:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/21]
 drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous
 prototype for 'spihid_get_data'
Message-ID: <202208062244.g28920ao-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   740efddf69b264d6439f9cf124d36acab812dd39
commit: 80d39405629267931171cbca14121b266e8d9152 [11/21] WIP: HID: transport: spi: add Apple SPI transport
config: parisc64-allyesconfig (https://download.01.org/0day-ci/archive/20220806/202208062244.g28920ao-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/80d39405629267931171cbca14121b266e8d9152
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 80d39405629267931171cbca14121b266e8d9152
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/hid/ drivers/net/ethernet/aquantia/atlantic/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/spi-hid/spi-hid-apple-core.c:259:22: warning: no previous prototype for 'spihid_get_data' [-Wmissing-prototypes]
     259 | struct spihid_apple *spihid_get_data(struct spihid_interface *idev)
         |                      ^~~~~~~~~~~~~~~
--
>> drivers/hid/spi-hid/spi-hid-apple-of.c:24:5: warning: no previous prototype for 'spihid_apple_of_power_on' [-Wmissing-prototypes]
      24 | int spihid_apple_of_power_on(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple-of.c:40:5: warning: no previous prototype for 'spihid_apple_of_power_off' [-Wmissing-prototypes]
      40 | int spihid_apple_of_power_off(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple-of.c:50:5: warning: no previous prototype for 'spihid_apple_of_enable_irq' [-Wmissing-prototypes]
      50 | int spihid_apple_of_enable_irq(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/spi-hid/spi-hid-apple-of.c:59:5: warning: no previous prototype for 'spihid_apple_of_disable_irq' [-Wmissing-prototypes]
      59 | int spihid_apple_of_disable_irq(struct spihid_apple_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/spihid_get_data +259 drivers/hid/spi-hid/spi-hid-apple-core.c

   258	
 > 259	struct spihid_apple *spihid_get_data(struct spihid_interface *idev)
   260	{
   261		switch (idev->id) {
   262		case SPIHID_DEVICE_ID_KBD:
   263			return container_of(idev, struct spihid_apple, kbd);
   264		case SPIHID_DEVICE_ID_TP:
   265			return container_of(idev, struct spihid_apple, tp);
   266		default:
   267			return NULL;
   268		}
   269	}
   270	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
