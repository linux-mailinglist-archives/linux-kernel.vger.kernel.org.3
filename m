Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93604F5778
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbiDFHLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577694AbiDFGqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:46:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C656F33DC95
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 22:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649221491; x=1680757491;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OczbPPxYW0BCxFajxdauSyALL2YSGe5d39xyMD6vbAA=;
  b=ZKHKgtbAqvMt5sHspQxJQ3Jr1mQUoY2z9sJvoHMrGjt1cv01TCw1yLan
   xRd3OQHLimiKR8i0z0Tyon2IVxLocD0Cy63Ip5+AL4G+FjR0NSHCHEh8W
   cTLhGkxz3W6GGJJUaJAwrzKm6p3JkQ8tda7C5iAAEYBD/c0+EsndqOu2P
   d/MP+1Xdg9EG7oYE877Divdijdxi3wqxFAct9DJYtz3Ins03rjZpdlLR2
   ufbrasK54ThmZ4XPa4hw9240xxkI1EfdFH2iGyrAOsLR0b83KgyHwQUIF
   JLWRSuMO5blc9NcF8P32I/jLY5KDqLEA8hCYA4+AifjtJ2BchXWCPm4tr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="347394219"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="347394219"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 22:04:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="658363665"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Apr 2022 22:04:48 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbxqa-00044n-4v;
        Wed, 06 Apr 2022 05:04:48 +0000
Date:   Wed, 6 Apr 2022 13:04:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Schulman <james.schulman@cirrus.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [broonie-ci:20220318_rf_asoc_add_a_driver_for_the_cirrus_logic_cs35l45_smart_amplifier
 29/29] sound/soc/codecs/cs35l45-spi.c:66:27: error: initialization of 'void
 (*)(struct spi_device *)' from incompatible pointer type 'int (*)(struct
 spi_device *)'
Message-ID: <202204061233.zD5PMrQA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git 20220318_rf_asoc_add_a_driver_for_the_cirrus_logic_cs35l45_smart_amplifier
head:   22d0ed9e232c66cf1d388c39fafac77c0872ae79
commit: 22d0ed9e232c66cf1d388c39fafac77c0872ae79 [29/29] ASoC: cs35l45: Add driver for Cirrus Logic CS35L45 Smart Amp
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220406/202204061233.zD5PMrQA-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=22d0ed9e232c66cf1d388c39fafac77c0872ae79
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci 20220318_rf_asoc_add_a_driver_for_the_cirrus_logic_cs35l45_smart_amplifier
        git checkout 22d0ed9e232c66cf1d388c39fafac77c0872ae79
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/codecs/cs35l45-spi.c:66:27: error: initialization of 'void (*)(struct spi_device *)' from incompatible pointer type 'int (*)(struct spi_device *)' [-Werror=incompatible-pointer-types]
      66 |         .remove         = cs35l45_spi_remove,
         |                           ^~~~~~~~~~~~~~~~~~
   sound/soc/codecs/cs35l45-spi.c:66:27: note: (near initialization for 'cs35l45_spi_driver.remove')
   cc1: some warnings being treated as errors


vim +66 sound/soc/codecs/cs35l45-spi.c

    57	
    58	static struct spi_driver cs35l45_spi_driver = {
    59		.driver = {
    60			.name		= "cs35l45",
    61			.of_match_table = cs35l45_of_match,
    62			.pm		= &cs35l45_pm_ops,
    63		},
    64		.id_table	= cs35l45_id_spi,
    65		.probe		= cs35l45_spi_probe,
  > 66		.remove		= cs35l45_spi_remove,
    67	};
    68	module_spi_driver(cs35l45_spi_driver);
    69	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
