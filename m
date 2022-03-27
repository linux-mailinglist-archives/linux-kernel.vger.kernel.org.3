Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605BC4E88CA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiC0QRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiC0QRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:17:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB10240E68
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648397773; x=1679933773;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bDJl/E6TRK92jHGFkoVLxk1asdnc05rBLkYxMQzqq4s=;
  b=YqmjqS0b/T1rdj5u62HfdkZy9UEqaJTx7DIues0z58FeNj+cf0Na0WEf
   D1E0psxjIBv0BqZd+3sO8QISdMiM5n4n+XhVF2fsFuqrMWLWtcS39XUVv
   KKn54KzDfTu4LNs7pyF9ydAL9joPczVtpeXeRbd1aAPieV2pjsWMnXqnk
   Xr2HzJNcAXfzESOW2FGFLpvZ0yQLx9wVWCnYK+Ag9FJ39ZqpW0wpUw5H3
   KTJR9Oi2tt2lmy4YpYOPFsS4h1lOEq6dWthOqYNQXBDBtR9tlF5TJdC37
   5NMcZkzj2htaLBdSKDgw+++fzcsOTOTw9sYk18hlk+QqLMU79sdJaXETK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="246349371"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="246349371"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 09:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="562436283"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2022 09:16:12 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYVYp-0001Dj-Jm; Sun, 27 Mar 2022 16:16:11 +0000
Date:   Mon, 28 Mar 2022 00:15:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:pr/22 96/189] drivers/platform/apple/smc_core.c:202:26:
 sparse: sparse: cast to restricted __be32
Message-ID: <202203280041.0z3zY6Vd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux pr/22
head:   7ee315306d1a3b0da8cf2a53e7f55889d0e7f034
commit: 322906b25cbf56148e4b57a6368f6d715e48b022 [96/189] platform/apple: Add new Apple Mac SMC driver
config: arm64-randconfig-s032-20220327 (https://download.01.org/0day-ci/archive/20220328/202203280041.0z3zY6Vd-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/AsahiLinux/linux/commit/322906b25cbf56148e4b57a6368f6d715e48b022
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux pr/22
        git checkout 322906b25cbf56148e4b57a6368f6d715e48b022
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/platform/apple/smc_core.c:202:26: sparse: sparse: cast to restricted __be32

vim +202 drivers/platform/apple/smc_core.c

   182	
   183	struct apple_smc *apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops, void *cookie)
   184	{
   185		struct apple_smc *smc;
   186		u32 count;
   187		int ret;
   188	
   189		smc = devm_kzalloc(dev, sizeof(*smc), GFP_KERNEL);
   190		if (!smc)
   191			return ERR_PTR(-ENOMEM);
   192	
   193		smc->dev = dev;
   194		smc->be_cookie = cookie;
   195		smc->be = ops;
   196		mutex_init(&smc->mutex);
   197		RAW_INIT_NOTIFIER_HEAD(&smc->event_handlers);
   198	
   199		ret = apple_smc_read_u32(smc, SMC_KEY(#KEY), &count);
   200		if (ret)
   201			return ERR_PTR(dev_err_probe(dev, ret, "Failed to get key count"));
 > 202		smc->key_count = be32_to_cpu(count);
   203	
   204		ret = apple_smc_get_key_by_index(smc, 0, &smc->first_key);
   205		if (ret)
   206			return ERR_PTR(dev_err_probe(dev, ret, "Failed to get first key"));
   207	
   208		ret = apple_smc_get_key_by_index(smc, smc->key_count - 1, &smc->last_key);
   209		if (ret)
   210			return ERR_PTR(dev_err_probe(dev, ret, "Failed to get last key"));
   211	
   212		/* Enable notifications */
   213		apple_smc_write_flag(smc, SMC_KEY(NTAP), 1);
   214	
   215		dev_info(dev, "Initialized (%d keys %p4ch..%p4ch)\n",
   216			 smc->key_count, &smc->first_key, &smc->last_key);
   217	
   218		dev_set_drvdata(dev, smc);
   219	
   220		ret = mfd_add_devices(dev, -1, apple_smc_devs, ARRAY_SIZE(apple_smc_devs), NULL, 0, NULL);
   221		if (ret)
   222			return ERR_PTR(dev_err_probe(dev, ret, "Subdevice initialization failed"));
   223	
   224		return smc;
   225	}
   226	EXPORT_SYMBOL(apple_smc_probe);
   227	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
