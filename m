Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193D059B0EA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 01:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiHTXm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 19:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHTXmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 19:42:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68DB3335E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 16:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661038942; x=1692574942;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VWxadWcE0GXTyoOZkTqJWcV2fzwt+33uyrkamk7ILag=;
  b=H4Afeb9wVeUXXewD/7fuu0LLH+H51t0KQO3G+gE6vPBlUHloYxMPY5H2
   ulgTKlbib/HJXGMQyzjua1VngInTypM2z+HCWzRU4wWDBaGPl0HTOf2R7
   UD5WU4terVZeBFNIiLNROyWdxMsDzRBhBdgmPYFIYiD6P4LhIVoZ7Y69o
   EKMNtdKDockELTSyK9kd2mdrxAbHYfP0RZSR+nbW+HM1gXmwKxnuC4Fkd
   A7CImuFSVfz0tpIzyslmMlQWiUDxPEP7T+gw0fG4cA8MBrfemHX7v13Pc
   W/Bzc+Wa7ziOhRcoeZ22Ce/nSl5zNPBmPVO3mLAyXwhvS13HcQbmVnV4d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="280174130"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="280174130"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 16:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="676805846"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2022 16:42:21 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPY6e-0003MF-27;
        Sat, 20 Aug 2022 23:42:20 +0000
Date:   Sun, 21 Aug 2022 07:41:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-meson-spicc.c:570:22: sparse: sparse: symbol
 'meson_spicc_pow2_clk_ops' was not declared. Should it be static?
Message-ID: <202208210739.y85trbHY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15b3f48a4339e3c16acf18624e2b7f60bc5e9a2c
commit: 09992025dacd258c823f50e82db09d7ef06cdac4 spi: meson-spicc: add local pow2 clock ops to preserve rate between messages
date:   9 days ago
config: mips-randconfig-s032-20220821 (https://download.01.org/0day-ci/archive/20220821/202208210739.y85trbHY-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09992025dacd258c823f50e82db09d7ef06cdac4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09992025dacd258c823f50e82db09d7ef06cdac4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-meson-spicc.c:570:22: sparse: sparse: symbol 'meson_spicc_pow2_clk_ops' was not declared. Should it be static?

vim +/meson_spicc_pow2_clk_ops +570 drivers/spi/spi-meson-spicc.c

   569	
 > 570	const struct clk_ops meson_spicc_pow2_clk_ops = {
   571		.recalc_rate = meson_spicc_pow2_recalc_rate,
   572		.determine_rate = meson_spicc_pow2_determine_rate,
   573		.set_rate = meson_spicc_pow2_set_rate,
   574	};
   575	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
