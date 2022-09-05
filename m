Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C945AD0A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiIEKs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiIEKsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:48:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21D44C63C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662374892; x=1693910892;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZJQiYw3bQrc4/+dvLKFmUeDrSnc2G4Jtg9vxg1wuj78=;
  b=kCBjLJnzuJnA1vyVRcIxdSg1WXQQUGS2l/UXaMMmhmMhx4xtB/a5x2PK
   a35J1YdStuXxYyvu2+IHFFRMf4kCYLyWHBzdVNYRNVTEVhQ0id5lM3oj+
   A5eA9onIxGwritozRrQxsKZc8/873rsKosIFBGMCpuZoGluOxqbPk1Hpz
   2YB/ZT10jnCzyjiNFYeB5jZam8TDBlcjpS73bC/pRErQtvZNwzSt9Nwc4
   GtJzVFnbQDaJKGVywlIp7P4AZuAJQn5wQU6UbU93ZD55MrWQi/Tu/AdEz
   5yx6H/l9S+gwbf+JiWuj/vtFTBPFP1w2vuZRRYRlHM/hkt3fL0cUxq46S
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="297674622"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="297674622"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 03:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="682021391"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2022 03:48:11 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oV9eE-00043b-1i;
        Mon, 05 Sep 2022 10:48:10 +0000
Date:   Mon, 5 Sep 2022 18:47:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/spi/spi-mpc52xx-psc.c:195:5: warning: no previous prototype
 for function 'mpc52xx_psc_spi_transfer_one_message'
Message-ID: <202209051823.XJdrEu9F-lkp@intel.com>
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

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e18e42e4b280c85b76967a9106a13ca61c16179
commit: 145cfc3840e5931a789a8e2e76af841ab4cad44b spi: mpc52xx-psc: Switch to using core message queue
date:   2 months ago
config: powerpc-randconfig-r026-20220905 (https://download.01.org/0day-ci/archive/20220905/202209051823.XJdrEu9F-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=145cfc3840e5931a789a8e2e76af841ab4cad44b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 145cfc3840e5931a789a8e2e76af841ab4cad44b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-mpc52xx-psc.c:195:5: warning: no previous prototype for function 'mpc52xx_psc_spi_transfer_one_message' [-Wmissing-prototypes]
   int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
       ^
   drivers/spi/spi-mpc52xx-psc.c:195:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
   ^
   static 
   1 warning generated.


vim +/mpc52xx_psc_spi_transfer_one_message +195 drivers/spi/spi-mpc52xx-psc.c

   194	
 > 195	int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
   196						 struct spi_message *m)
   197	{
   198		struct spi_device *spi;
   199		struct spi_transfer *t = NULL;
   200		unsigned cs_change;
   201		int status;
   202	
   203		spi = m->spi;
   204		cs_change = 1;
   205		status = 0;
   206		list_for_each_entry (t, &m->transfers, transfer_list) {
   207			if (t->bits_per_word || t->speed_hz) {
   208				status = mpc52xx_psc_spi_transfer_setup(spi, t);
   209				if (status < 0)
   210					break;
   211			}
   212	
   213			if (cs_change)
   214				mpc52xx_psc_spi_activate_cs(spi);
   215			cs_change = t->cs_change;
   216	
   217			status = mpc52xx_psc_spi_transfer_rxtx(spi, t);
   218			if (status)
   219				break;
   220			m->actual_length += t->len;
   221	
   222			spi_transfer_delay_exec(t);
   223	
   224			if (cs_change)
   225				mpc52xx_psc_spi_deactivate_cs(spi);
   226		}
   227	
   228		m->status = status;
   229		if (status || !cs_change)
   230			mpc52xx_psc_spi_deactivate_cs(spi);
   231	
   232		mpc52xx_psc_spi_transfer_setup(spi, NULL);
   233	
   234		spi_finalize_current_message(ctlr);
   235	
   236		return 0;
   237	}
   238	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
