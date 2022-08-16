Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B179C5953CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiHPHcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiHPHbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:31:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD518B8AF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 21:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660622987; x=1692158987;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IzQEN72TmBDMzkJL4xzg5eFSIZtKllar5ZCeHaEg3wo=;
  b=B45YLX81hN11Vv1vakI1LEkM21X416UK6p3K0t+HHfhs8+GrR+bLQKWR
   xslw3HIiKDTj3aDYnGEoCjDoewWivyil86ZhfFx7a06HLo4dz+KJRtTnr
   18sRz4LarWBtHPFMyFpaYZnglebbc5VGVXaHkejbsQV/MXzzJ4tPhBV4V
   w9BTN1TVqr52rTsC30esh1zBbIdaDxnVbxrSMcYnAsQi9cmJiSpS8lYP6
   JhgTaU1coc/cu1JYONThtFDpLUYxhlvTbEd+yddlCzcknzFtj5io981kO
   HuABjJy8GMKKiwkzaFJlJqGgwQOOKcYsHp1Z5qFccGKYtAj28jba81XKx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292915366"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="292915366"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 21:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="934733071"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2022 21:09:45 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNntg-0001RR-31;
        Tue, 16 Aug 2022 04:09:44 +0000
Date:   Tue, 16 Aug 2022 12:09:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 4/17]
 drivers/platform/apple/smc_core.c:210:26: sparse: sparse: cast to restricted
 __be32
Message-ID: <202208161228.iyoLmbTO-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   85225bbe01a2a74102db8d75e316b4e46f1cb07f
commit: 59000ffdca0f77c3f45fe7610510b17382fc8974 [4/17] platform/apple: Add new Apple Mac SMC driver
config: arm64-randconfig-s053-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161228.iyoLmbTO-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/59000ffdca0f77c3f45fe7610510b17382fc8974
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 59000ffdca0f77c3f45fe7610510b17382fc8974
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/platform/apple/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/apple/smc_core.c:210:26: sparse: sparse: cast to restricted __be32

vim +210 drivers/platform/apple/smc_core.c

   190	
   191	struct apple_smc *apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops, void *cookie)
   192	{
   193		struct apple_smc *smc;
   194		u32 count;
   195		int ret;
   196	
   197		smc = devm_kzalloc(dev, sizeof(*smc), GFP_KERNEL);
   198		if (!smc)
   199			return ERR_PTR(-ENOMEM);
   200	
   201		smc->dev = dev;
   202		smc->be_cookie = cookie;
   203		smc->be = ops;
   204		mutex_init(&smc->mutex);
   205		BLOCKING_INIT_NOTIFIER_HEAD(&smc->event_handlers);
   206	
   207		ret = apple_smc_read_u32(smc, SMC_KEY(#KEY), &count);
   208		if (ret)
   209			return ERR_PTR(dev_err_probe(dev, ret, "Failed to get key count"));
 > 210		smc->key_count = be32_to_cpu(count);
   211	
   212		ret = apple_smc_get_key_by_index(smc, 0, &smc->first_key);
   213		if (ret)
   214			return ERR_PTR(dev_err_probe(dev, ret, "Failed to get first key"));
   215	
   216		ret = apple_smc_get_key_by_index(smc, smc->key_count - 1, &smc->last_key);
   217		if (ret)
   218			return ERR_PTR(dev_err_probe(dev, ret, "Failed to get last key"));
   219	
   220		/* Enable notifications */
   221		apple_smc_write_flag(smc, SMC_KEY(NTAP), 1);
   222	
   223		dev_info(dev, "Initialized (%d keys %p4ch..%p4ch)\n",
   224			 smc->key_count, &smc->first_key, &smc->last_key);
   225	
   226		dev_set_drvdata(dev, smc);
   227	
   228		ret = mfd_add_devices(dev, -1, apple_smc_devs, ARRAY_SIZE(apple_smc_devs), NULL, 0, NULL);
   229		if (ret)
   230			return ERR_PTR(dev_err_probe(dev, ret, "Subdevice initialization failed"));
   231	
   232		return smc;
   233	}
   234	EXPORT_SYMBOL(apple_smc_probe);
   235	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
