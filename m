Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE9E538241
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbiE3OWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbiE3ORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 10:17:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2431105C8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653918272; x=1685454272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nbH+BT+jNCzIIO5uzvmvgYlB3KrG8atxoCtN2hrlcLg=;
  b=hxhkFZHdOpHM0wdQX62rQ4EYQIStIn3Oy08zTfKILkcVtgs99d94AtoT
   MUcjRXfMi8POLj9oY4Ab61Bjzc1rwhiZ0ca7wGjJ8Da9O+hR5Jm+xR75t
   B4xMkriWUfwA7r934UHPnZO86TC/Cp1FDfqBb+gc+NfZWBZLvj3qf0OQr
   cIykBKpU0reCYOvXNhBZ9ZSoYHGQuWpIb1Bcg9oJFN0ZdOrujHcVWnWyd
   CuYLL35NVoRhXVrbEbjCenJ11YtKLcgMBLB6NBHOI/Jqga5spViLKRtN4
   Se/i/+GJvaMtpxT0edMottCs7LkkkXeX0r3w0upM4aOtRBcqvcLgJ3EIv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="275006047"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="275006047"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 06:44:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="719903618"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 May 2022 06:44:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvfgl-0001kY-4N;
        Mon, 30 May 2022 13:44:07 +0000
Date:   Mon, 30 May 2022 21:43:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Watson Chow <watson.chow@avnet.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/regulator/max20086-regulator.c:288:34: warning:
 'max20086_dt_ids' defined but not used
Message-ID: <202205302156.U6VFwn3R-lkp@intel.com>
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

Hi Watson,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b00ed48bb0a7c295facf9036135a573a5cdbe7de
commit: bfff546aae50ae68ed395bf0e0848188d27b0ba3 regulator: Add MAX20086-MAX20089 driver
date:   5 months ago
config: x86_64-buildonly-randconfig-r002-20220530 (https://download.01.org/0day-ci/archive/20220530/202205302156.U6VFwn3R-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfff546aae50ae68ed395bf0e0848188d27b0ba3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bfff546aae50ae68ed395bf0e0848188d27b0ba3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/regulator/ kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/regulator/max20086-regulator.c:288:34: warning: 'max20086_dt_ids' defined but not used [-Wunused-const-variable=]
     288 | static const struct of_device_id max20086_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~~


vim +/max20086_dt_ids +288 drivers/regulator/max20086-regulator.c

   287	
 > 288	static const struct of_device_id max20086_dt_ids[] = {
   289		{
   290			.compatible = "maxim,max20086",
   291			.data = &(const struct max20086_chip_info) {
   292				.id = MAX20086_DEVICE_ID_MAX20086,
   293				.num_outputs = 4,
   294			}
   295		}, {
   296			.compatible = "maxim,max20087",
   297			.data = &(const struct max20086_chip_info) {
   298				.id = MAX20086_DEVICE_ID_MAX20087,
   299				.num_outputs = 4,
   300			}
   301		}, {
   302			.compatible = "maxim,max20088",
   303			.data = &(const struct max20086_chip_info) {
   304				.id = MAX20086_DEVICE_ID_MAX20088,
   305				.num_outputs = 2,
   306			}
   307		}, {
   308			.compatible = "maxim,max20089",
   309			.data = &(const struct max20086_chip_info) {
   310				.id = MAX20086_DEVICE_ID_MAX20089,
   311				.num_outputs = 2,
   312			}
   313		},
   314		{ /* Sentinel */ },
   315	};
   316	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
