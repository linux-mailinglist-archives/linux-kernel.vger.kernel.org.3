Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C29B4E8091
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiCZL0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 07:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiCZL0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:26:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80606E29EB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 04:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648293915; x=1679829915;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hXHNwgPBIRt0+wbu4TFE2q+9RNOrj73WbjQEe9q4QiY=;
  b=akjU90LcyI2ghnRQ+x6iaI2PP69T/ik8iJuJfcV26dZdXKIl60drCkzK
   bbxGdk47l98uscoMHWo33WJcXgKmDENp0JzYq6V2SxA/kpq/j21IPD4bw
   lMG9bm6J8m9OM5kWnk00TIqicutat2FhWzjpwRneAwEiZNdHp9Py02WCS
   Ezbg+/etqus15QXg1gDeGC/ObVfO+Z+SPARCNd03LoLIE7GhNrIca/5Qe
   FtoAezZ1aj47jpFG0uyMnLso/l+Y7t3O4TxQEL2kWWUmva9hqZ8YVOSFM
   zvn4N97UNhTwgbeg5ZclCn1P+Bta2NILM+30S8FAKDwG8wS5gAAaXsgpz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="257605828"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="257605828"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 04:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="693918864"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2022 04:25:14 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY4Xh-000NJw-FI; Sat, 26 Mar 2022 11:25:13 +0000
Date:   Sat, 26 Mar 2022 19:24:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [andersson:wip/sc8180x-next-20220301 6/27] ld.lld: error: undefined
 symbol: typec_switch_register
Message-ID: <202203261918.Lch5cHKw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220301
head:   0289eb1e5447f549241a40b2a0742a796467ecd8
commit: 2b468636da740585f10846641a44f7f8c1ce89c3 [6/27] phy: qcom-qmp: Register as a typec switch for orientation detection
config: arm-randconfig-r032-20220324 (https://download.01.org/0day-ci/archive/20220326/202203261918.Lch5cHKw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/andersson/kernel/commit/2b468636da740585f10846641a44f7f8c1ce89c3
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220301
        git checkout 2b468636da740585f10846641a44f7f8c1ce89c3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: typec_switch_register
   >>> referenced by phy-qcom-qmp.c
   >>> phy/qualcomm/phy-qcom-qmp.o:(qcom_qmp_phy_typec_switch_register) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: typec_switch_get_drvdata
   >>> referenced by phy-qcom-qmp.c
   >>> phy/qualcomm/phy-qcom-qmp.o:(qcom_qmp_phy_typec_switch_set) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
