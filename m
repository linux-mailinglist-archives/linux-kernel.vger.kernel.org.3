Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9E509873
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384741AbiDUGyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385400AbiDUGwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:52:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1DE19C3B;
        Wed, 20 Apr 2022 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523592; x=1682059592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7178CiCoImQ+f/EA4vdj+Vck0criqevbU3FVIO5GGOw=;
  b=QBxlQveBE1UHvx3pkn0Sj7FZyvBN7NC6hIB/aLO9bUXLQzZYqo6z2KyS
   cIqCddWfjTpqrEXqO7E80uLPDs9eJ1ICQCzvUudNCdgtidWIUyC3m0YvR
   uuoYYyL48oxb31fRlgWv0exU8MLzJnfo9JbsVZt29r32vJ2mADcEdh8l7
   h4917yjChM3KTKIOlIRfG8he6g1I9jg5e4PZMA8xyFXBoyOshKrdTyRHm
   wLWkP1JsWU8cRRwBzadtUGkhwwkqCMIYoeBp7I/OgZXnDBsWGjitWwt/d
   0zeyZnElVZDANdDSwp15tvMeDdQIUpyMDFllseK4VDGB+dC2t8Ef2C6/l
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263109847"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263109847"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="530132418"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Apr 2022 23:45:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQZb-00082l-RB;
        Thu, 21 Apr 2022 06:45:51 +0000
Date:   Thu, 21 Apr 2022 14:45:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>, dan@dlrobertson.com,
        jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/9] iio: accel: bma400: Add support for activity and
 inactivity events
Message-ID: <202204211211.febbJ6fy-lkp@intel.com>
References: <20220420211105.14654-10-jagathjog1996@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420211105.14654-10-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagath,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v5.18-rc3 next-20220420]
[cannot apply to linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jagath-Jog-J/iio-accel-bma400-Add-buffer-step-and-activity-inactivity/20220421-051244
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: mips-randconfig-r031-20220420 (https://download.01.org/0day-ci/archive/20220421/202204211211.febbJ6fy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/b33d9910aa7588ec8db7c1694dbc03c3ed200ebb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jagath-Jog-J/iio-accel-bma400-Add-buffer-step-and-activity-inactivity/20220421-051244
        git checkout b33d9910aa7588ec8db7c1694dbc03c3ed200ebb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/bma400_core.c:1047:17: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((msk), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (msk)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
                   field_value = FIELD_PREP(msk, state);
                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/iio/accel/bma400_core.c:1053:17: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((msk), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (msk)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
                   field_value = FIELD_PREP(msk, state);
                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   2 warnings generated.


vim +1047 drivers/iio/accel/bma400_core.c

  1035	
  1036	static int bma400_activity_event_en(struct bma400_data *data,
  1037					    enum iio_event_direction dir,
  1038					    int state)
  1039	{
  1040		int ret, reg, msk, value, field_value;
  1041	
  1042		switch (dir) {
  1043		case IIO_EV_DIR_RISING:
  1044			reg = BMA400_GEN1INT_CONFIG0;
  1045			msk = BMA400_INT_GEN1_MSK;
  1046			value = 2;
> 1047			field_value = FIELD_PREP(msk, state);
  1048			break;
  1049		case IIO_EV_DIR_FALLING:
  1050			reg = BMA400_GEN2INT_CONFIG0;
  1051			msk = BMA400_INT_GEN2_MSK;
  1052			value = 0;
  1053			field_value = FIELD_PREP(msk, state);
  1054			break;
  1055		default:
  1056			return -EINVAL;
  1057		}
  1058	
  1059		/* Enabling all axis for interrupt evaluation */
  1060		ret = regmap_write(data->regmap, reg, 0xF8);
  1061		if (ret)
  1062			return ret;
  1063	
  1064		/* OR combination of all axis for interrupt evaluation */
  1065		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF, value);
  1066		if (ret)
  1067			return ret;
  1068	
  1069		/* Initial value to avoid interrupts while enabling*/
  1070		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF, 0x0A);
  1071		if (ret)
  1072			return ret;
  1073	
  1074		/* Initial duration value to avoid interrupts while enabling*/
  1075		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF, 0x0F);
  1076		if (ret)
  1077			return ret;
  1078	
  1079		ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, msk,
  1080					 field_value);
  1081		if (ret)
  1082			return ret;
  1083	
  1084		ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, msk,
  1085					 field_value);
  1086		if (ret)
  1087			return ret;
  1088	
  1089		set_mask_bits(&data->generic_event_en, msk, field_value);
  1090		return 0;
  1091	}
  1092	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
