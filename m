Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AD55AE723
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiIFMCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiIFMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:02:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E60785A2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662465742; x=1694001742;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B+zp+waDKjmV3+F5STc49zhhhMwE8xa40R3YdBcNWRk=;
  b=Qro1wpNWT1J2yRdP7FjHa+3tHiRZ1SQwPyfwEG2A+3fEWXvjZRW49yH9
   mo0NfO6FgPIveHG6dC9H3OaPgGgth+yfZK+PIv6W4xj1mXaAl+exWyNuf
   huRBpFucWrpOM8IuIouCbaXfEWQ5TDRu7ub3qVo23/j6WYjZa8dbzLPr0
   w2iT7ThuZbiuRPqb8BbXJM8ML7ydPwweY9xRRSe+rFD85ozT9piqXk4IU
   nihSmIC3S4ir3Jeld5k0AzU3djLOiEEoqWWTf3BLfII3nm09WWhXwbDhN
   oMFznwyFnQKKoyae1nGQ3OpbMUZRc4WP22Mx8+YU3QPunXHjolv29NNQU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="382868807"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="382868807"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="591239910"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2022 05:02:20 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVXHY-000551-0b;
        Tue, 06 Sep 2022 12:02:20 +0000
Date:   Tue, 6 Sep 2022 20:02:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sound/soc/codecs/wm8731-i2c.c:65:1: error: type defaults to 'int' in
 declaration of 'module_i2c_driver'
Message-ID: <202209061939.wShjoFWE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   53e99dcff61e1523ec1c3628b2d564ba15d32eb7
commit: 9dc15f81baf273b5aaaa3302ee8faacd78f361fd ASoC: wm8731: Factor out the I2C and SPI bus code into separate modules
date:   5 months ago
config: mips-randconfig-s033-20220906 (https://download.01.org/0day-ci/archive/20220906/202209061939.wShjoFWE-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9dc15f81baf273b5aaaa3302ee8faacd78f361fd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9dc15f81baf273b5aaaa3302ee8faacd78f361fd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> sound/soc/codecs/wm8731-i2c.c:65:1: warning: data definition has no type or storage class
      65 | module_i2c_driver(wm8731_i2c_driver);
         | ^~~~~~~~~~~~~~~~~
>> sound/soc/codecs/wm8731-i2c.c:65:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
>> sound/soc/codecs/wm8731-i2c.c:65:1: warning: parameter names (without types) in function declaration
   sound/soc/codecs/wm8731-i2c.c:56:26: warning: 'wm8731_i2c_driver' defined but not used [-Wunused-variable]
      56 | static struct i2c_driver wm8731_i2c_driver = {
         |                          ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_SOC_WM8731_I2C
   Depends on [n]: SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && I2C [=n]
   Selected by [m]:
   - SND_SOC_DB1200 [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_AU1XPSC [=m]


vim +65 sound/soc/codecs/wm8731-i2c.c

    64	
  > 65	module_i2c_driver(wm8731_i2c_driver);
    66	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
