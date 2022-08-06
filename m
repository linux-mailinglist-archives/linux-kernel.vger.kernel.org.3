Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD958B30A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 02:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241425AbiHFA0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 20:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiHFA0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 20:26:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB2A186DA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 17:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659745598; x=1691281598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SBXKwsPmPV/JsyuFml8F3Ty43E27/gteRhVMUKJ6ij0=;
  b=TmXqL0cinXhELlhmr9JB6aHG0+kN2fOik2XHeGccD/mDxXhzWSb66Iqp
   wrcMjn9vLc4D/efmY6RaaBqIF/sDd4p3BuuMKwAFSAgfL/Sw1JMPMfxiW
   ziNneFeO1el92aA2Lx6zmI4SBeX0Udv3KCGKeMyU+xwOC1DhrAwiP2RhP
   YfK9XuL3gJDpC2pab3Z5vJsA7HdzleKgSBTEmCctwayeuZN9f4Etuoarw
   3op8vuN//arlocaANkmzVpRVhUFgVesAiqnZ9BqQ0d7oD6X3keIdut1Xh
   QWSGDYT9zEpH33v1qu3dzwmhxB1JPonCL2ONTyo2VE9/1KbnZVC4HVRKu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289078729"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289078729"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 17:26:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="579693818"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2022 17:26:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK7eG-000Jqd-0o;
        Sat, 06 Aug 2022 00:26:36 +0000
Date:   Sat, 6 Aug 2022 08:26:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-s3c64xx.c:387:34: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202208060820.GKre8FkO-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   74cae210a335d159f2eb822e261adee905b6951a
commit: 82295bc0d192d7e35e0568b18ca66da2c3058fd5 spi: s3c64xx: move dma_release_channel to unprepare
date:   6 weeks ago
config: arm64-randconfig-s052-20220804 (https://download.01.org/0day-ci/archive/20220806/202208060820.GKre8FkO-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=82295bc0d192d7e35e0568b18ca66da2c3058fd5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 82295bc0d192d7e35e0568b18ca66da2c3058fd5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/block/null_blk/./ drivers/spi/ fs/zonefs/./

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-s3c64xx.c:387:34: sparse: sparse: Using plain integer as NULL pointer
   drivers/spi/spi-s3c64xx.c:388:34: sparse: sparse: Using plain integer as NULL pointer

vim +387 drivers/spi/spi-s3c64xx.c

   375	
   376	static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
   377	{
   378		struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
   379	
   380		if (is_polling(sdd))
   381			return 0;
   382	
   383		/* Releases DMA channels if they are allocated */
   384		if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
   385			dma_release_channel(sdd->rx_dma.ch);
   386			dma_release_channel(sdd->tx_dma.ch);
 > 387			sdd->rx_dma.ch = 0;
   388			sdd->tx_dma.ch = 0;
   389		}
   390	
   391		return 0;
   392	}
   393	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
