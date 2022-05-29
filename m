Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18596537232
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiE2Sj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiE2Sj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:39:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7588443FF
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 11:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653849594; x=1685385594;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mw4OLyZlhpNG8BczN2VoJGylmhJnOW76NSfJ0YmKvh8=;
  b=kiD4OtKP74GCCg1Xl7zkQXef6KqBPHIrHWIKNGKimyV8YQcz98njg7WK
   3GQL0pdibn/RDU45dxnzzi7FWAF0oZZD8Po73YtcaGvKwEG0vGFmh62b7
   wLqWbwJ4jPTXGJWKAMTAjnpNtmq0622btaHRqCE4wivNR+JzxlaV/FLi9
   XWyHd8J8sKJXYYCZdJv4nIus4upm6GfY0V5thcjL/bjq3TrHGnYjs2bW+
   qdauPRCXaqfBe2AlYbDSBnFRZeBhUZmrpCi3hKzpNH3luaUQLNCQuQ2OT
   TiPNFeM2NhlbUpbJ+jDEBHen135wjbKiukaoXYT8TuKVPxqQvJzng8GxV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="274921234"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="274921234"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 11:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="611162588"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2022 11:39:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvNpQ-0001BU-2x;
        Sun, 29 May 2022 18:39:52 +0000
Date:   Mon, 30 May 2022 02:39:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: sound/soc/intel/avs/board_selection.c:328:36: warning: format '%ld'
 expects argument of type 'long int', but argument 5 has type 'int'
Message-ID: <202205300203.HEMfMnDi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   664a393a2663a0f62fc1b18157ccae33dcdbb8c8
commit: beed983621fbdfd291e6e3a0cdc4d10517e60af8 ASoC: Intel: avs: Machine board registration
date:   12 days ago
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220530/202205300203.HEMfMnDi-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=beed983621fbdfd291e6e3a0cdc4d10517e60af8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout beed983621fbdfd291e6e3a0cdc4d10517e60af8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/amd/display/dc/ drivers/scsi/mpi3mr/ sound/soc/intel/avs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:15,
                    from sound/soc/intel/avs/board_selection.c:9:
   sound/soc/intel/avs/board_selection.c: In function 'avs_register_i2s_board':
>> sound/soc/intel/avs/board_selection.c:328:36: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'int' [-Wformat=]
     328 |                 dev_err(adev->dev, "Platform supports %d SSPs but board %s requires SSP%ld\n",
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/intel/avs/board_selection.c:328:17: note: in expansion of macro 'dev_err'
     328 |                 dev_err(adev->dev, "Platform supports %d SSPs but board %s requires SSP%ld\n",
         |                 ^~~~~~~
   sound/soc/intel/avs/board_selection.c:328:90: note: format string is defined here
     328 |                 dev_err(adev->dev, "Platform supports %d SSPs but board %s requires SSP%ld\n",
         |                                                                                        ~~^
         |                                                                                          |
         |                                                                                          long int
         |                                                                                        %d


vim +328 sound/soc/intel/avs/board_selection.c

   318	
   319	static int avs_register_i2s_board(struct avs_dev *adev, struct snd_soc_acpi_mach *mach)
   320	{
   321		struct platform_device *board;
   322		int num_ssps;
   323		char *name;
   324		int ret;
   325	
   326		num_ssps = adev->hw_cfg.i2s_caps.ctrl_count;
   327		if (fls(mach->mach_params.i2s_link_mask) > num_ssps) {
 > 328			dev_err(adev->dev, "Platform supports %d SSPs but board %s requires SSP%ld\n",
   329				num_ssps, mach->drv_name, __fls(mach->mach_params.i2s_link_mask));
   330			return -ENODEV;
   331		}
   332	
   333		name = devm_kasprintf(adev->dev, GFP_KERNEL, "%s.%d-platform", mach->drv_name,
   334				      mach->mach_params.i2s_link_mask);
   335		if (!name)
   336			return -ENOMEM;
   337	
   338		ret = avs_i2s_platform_register(adev, name, mach->mach_params.i2s_link_mask, mach->pdata);
   339		if (ret < 0)
   340			return ret;
   341	
   342		mach->mach_params.platform = name;
   343	
   344		board = platform_device_register_data(NULL, mach->drv_name, mach->mach_params.i2s_link_mask,
   345						      (const void *)mach, sizeof(*mach));
   346		if (IS_ERR(board)) {
   347			dev_err(adev->dev, "ssp board register failed\n");
   348			return PTR_ERR(board);
   349		}
   350	
   351		ret = devm_add_action(adev->dev, board_pdev_unregister, board);
   352		if (ret < 0) {
   353			platform_device_unregister(board);
   354			return ret;
   355		}
   356	
   357		return 0;
   358	}
   359	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
