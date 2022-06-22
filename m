Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02055556EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358227AbiFVWmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiFVWmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:42:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3321341301
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655937759; x=1687473759;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/Aaew8nRjRBHQPVL+GtCxzvJIjfYGF2f4VfBi1VtCUU=;
  b=Wdv86hveQCQYoXOJkSNEaZ/fQG34jS9QX231JhUqpG4G+QuhhvSpsTlp
   lgg1e1qcIRCIrjuSvoThXtsrhljyltvts9aqXLsMtu12Y3xPvKMu57zgT
   i9pifd6U9fVQkYdqpkcmAY7pBgYpX2Z6bFje9R9WKdMaD8VmCr3kMWZyc
   sTlfQpug12auzdOOOCmdiNNVk6QZe0cjY2zjooCfb/gBXTMgGW2i4gq2r
   kOSXJLGKmwfANMqv0jzVZ54zK3C+LxSEwPS2QbOb9kGbWxNapQJm6K0cM
   YVlx5A/56b1foghoQQePkcjXGd+/uJZHWF13Dl+LwcE4I18XVgZJdtvCO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342248972"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="342248972"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="585918516"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2022 15:42:37 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o493U-0001ls-Co;
        Wed, 22 Jun 2022 22:42:36 +0000
Date:   Thu, 23 Jun 2022 06:42:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:kvalo/ath/ath12k-bringup-extras 2/3]
 drivers/net/wireless/ath/ath12k/pci.c:678:7: error: call to undeclared
 function 'of_property_read_u32'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <202206230637.ojZSI1do-lkp@intel.com>
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

Hi Kalle,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/ath12k-bringup-extras
head:   cc108fac9c287f5624daedca923743587adcafd1
commit: f6fc8dfbdd4f8aa245e4d22691f7ae3057a01dbf [2/3] Merge ath-next into ath12k-bringup
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220623/202206230637.ojZSI1do-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/f6fc8dfbdd4f8aa245e4d22691f7ae3057a01dbf
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/ath12k-bringup-extras
        git checkout f6fc8dfbdd4f8aa245e4d22691f7ae3057a01dbf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath12k/pci.c:678:7: error: call to undeclared function 'of_property_read_u32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (!of_property_read_u32(ab->dev->of_node, "qrtr_instance_id", &instance_id))
                ^
   1 error generated.


vim +/of_property_read_u32 +678 drivers/net/wireless/ath/ath12k/pci.c

f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  666  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  667  static void ath12k_pci_init_qmi_ce_config(struct ath12k_base *ab)
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  668  {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  669  	struct ath12k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  670  	u32 instance_id = 0;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  671  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  672  	cfg->tgt_ce = ab->hw_params.target_ce_config;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  673  	cfg->tgt_ce_len = ab->hw_params.target_ce_count;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  674  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  675  	cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  676  	cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  677  	ab->qmi.service_ins_id = ab->hw_params.qmi_service_ins_id;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01 @678  	if (!of_property_read_u32(ab->dev->of_node, "qrtr_instance_id", &instance_id))
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  679  		ab->qmi.service_ins_id = instance_id + ATH12K_QMI_WLFW_NODE_ID_BASE;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  680  }
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  681  

:::::: The code at line 678 was first introduced by commit
:::::: f40abb4788a2a3868606a29d99583421e0874350 ath12k: New driver for Qualcomm 11be hw family

:::::: TO: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
:::::: CC: Kalle Valo <quic_kvalo@quicinc.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
