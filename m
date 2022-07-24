Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9B57F21F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 02:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiGXANV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 20:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGXANQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 20:13:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B183AB43
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 17:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658621595; x=1690157595;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FgbnEhB4B7/tiGmWtFlUcZlVuB4qLIcnAgg6VOF17HM=;
  b=Jn2dN5rx0OuNIVuqVyufN4IldT5buv4wIhEOEgu6qD1GpXE+YTJv6dfu
   RAQbPab+YT5NwugIbtcXYPRZqR5nzhW6N4mgECDVcQWO2MeVmu0nMLC9j
   Stj17zhTq5ZNW4Kez7263AzBCwxV9hq2wybrzziw5FSp2E+n+pr+L1fu2
   NrpPa1CPIfHCaDp/rksuwgQD3CTEc/p8UPCTyxxXC1matw/bhZ1V+c4HA
   yOI3y8VNTjJaEns4oAF52fiPir+X03KD56caOoJEDH/hqqu4WpPxBSFmp
   7iskPxuPOhRh4aFonirG//+ha/VcOnuZBA2McDg25JfChggZVUtq6ofoK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="288682016"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="288682016"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 17:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="741432728"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2022 17:13:13 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFPFA-0003Gh-2t;
        Sun, 24 Jul 2022 00:13:12 +0000
Date:   Sun, 24 Jul 2022 08:12:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/crypto/qcom-rng.c:190:34: warning: 'qcom_rng_of_match'
 defined but not used
Message-ID: <202207240830.NxaVYPVM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: ceec5f5b59882b871a722ca4d49b767a09a4bde9 crypto: qcom-rng - Add Qcom prng driver
date:   4 years ago
config: i386-buildonly-randconfig-r004-20220718 (https://download.01.org/0day-ci/archive/20220724/202207240830.NxaVYPVM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ceec5f5b59882b871a722ca4d49b767a09a4bde9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ceec5f5b59882b871a722ca4d49b767a09a4bde9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/crypto/ drivers/i2c/busses/ drivers/mailbox/ drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/crypto/qcom-rng.c:190:34: warning: 'qcom_rng_of_match' defined but not used [-Wunused-const-variable=]
     190 | static const struct of_device_id qcom_rng_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~


vim +/qcom_rng_of_match +190 drivers/crypto/qcom-rng.c

   189	
 > 190	static const struct of_device_id qcom_rng_of_match[] = {
   191		{ .compatible = "qcom,prng" },
   192		{}
   193	};
   194	MODULE_DEVICE_TABLE(of, qcom_rng_of_match);
   195	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
