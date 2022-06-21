Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675705535EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352771AbiFUPWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352733AbiFUPWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:22:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CEF252BE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655824926; x=1687360926;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yEBUtIOheC/WYcncg6ED2ZB1yFtMBsOurDw3XTo+UJE=;
  b=HsR7+GOz2l0YEJ2ZBLoNnkMg2U7P37UVnOoXAomaCeO57+S+eP1sg2TY
   kSzhOR22luE0nbEI1pWqOJtKYQrOgdKn7U9/MKqxHkyYsyuR8pi3Hs9GS
   PP0bP2uPj2YMYYVBYNrqq80xVBf+gIWHGuUpB+Pw81sPiCMQBdHCu7fRP
   Kc2zaE4mBGbp3bsgpi2Dg380qM8zfi/j+UcN6l797pSIueU7qYlZRcyTT
   rgev4lZDH5juuvBTpB6kruUG32t9vhMM3Ts5Q60MmI8iaal9H/PMOlva3
   yWLYz3P/JZ2yYS7auhijYLXB5qLytP6bZzIFNGLwcKcHfgy3LJeYi74Ud
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="259965800"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="259965800"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 08:22:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="764494114"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2022 08:22:02 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3fhZ-00004b-Lc;
        Tue, 21 Jun 2022 15:22:01 +0000
Date:   Tue, 21 Jun 2022 23:21:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 6458/7962] drivers/hwmon/dme1737.o:
 warning: objtool: show_zone()+0x40: unreachable instruction
Message-ID: <202206212304.C9O9bVTc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   3797b8fe60254ac3f5306d5e452b088e9d57f180
commit: 370d33da35e31c1544eb77bcf2539f09b1064b9c [6458/7962] x86: Add straight-line-speculation mitigation
config: x86_64-randconfig-a003-20220620 (https://download.01.org/0day-ci/archive/20220621/202206212304.C9O9bVTc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=370d33da35e31c1544eb77bcf2539f09b1064b9c
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 370d33da35e31c1544eb77bcf2539f09b1064b9c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/ drivers/ kernel/ net// security/integrity/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwmon/dme1737.o: warning: objtool: show_zone()+0x40: unreachable instruction
--
>> drivers/hwmon/ltc2947-core.o: warning: objtool: ltc2947_is_visible()+0x44: unreachable instruction
--
>> drivers/iio/accel/mma8452.o: warning: objtool: mma8452_read_raw()+0x4c: unreachable instruction
--
>> drivers/iio/adc/ad7192.o: warning: objtool: ad7192_read_raw()+0x3f: unreachable instruction
--
>> drivers/iio/dac/ad5360.o: warning: objtool: ad5360_read_raw()+0x36: unreachable instruction
--
>> drivers/iio/dac/ad5421.o: warning: objtool: ad5421_read_raw()+0x37: unreachable instruction
--
>> drivers/iio/dac/ad5764.o: warning: objtool: ad5764_read_raw()+0x31: unreachable instruction
--
>> drivers/iio/dummy/iio_simple_dummy.o: warning: objtool: iio_dummy_read_raw()+0x4c: unreachable instruction
--
>> drivers/edac/ghes_edac.o: warning: objtool: assign_dmi_dimm_info()+0x6d: unreachable instruction
--
>> drivers/power/supply/da9030_battery.o: warning: objtool: da9030_battery_get_property()+0x25: unreachable instruction
--
>> drivers/power/supply/max14577_charger.o: warning: objtool: max14577_charger_get_property()+0x36: unreachable instruction
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
