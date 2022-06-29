Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5752560B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiF2U7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiF2U7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:59:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B963E5C7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656536348; x=1688072348;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eI37OGL13Hq09p26Lvb+cTfEdQ84i7ieM9yAE1uQ6qU=;
  b=cD3QY+kdAOGSaJObfq7TWODpgQYvf2eTV1Qllqvc2XfaoxlMFbfc7Fp4
   TCEfKngQw5cGDdS/8ZlqC/jlLlpXN8/989NFox3mBI6xHmeV0PuqZNRPZ
   eH0COZR5zBVvppVoMNGovAnKZ2Q+5rA/pZsKd9qsuZilHA9OKdn9HT7aI
   kM2e2Bv2vDrvpaofwuXMyVoZtDsduL0sYxFjcIconGWsppTEQsd9hlvJP
   cFA1athakwtFKqh3yxZZnFttOPr/fXKX/fapZqs2hwJmur4z2H4IIxhse
   Ra+4kac2NmsEJPD+u56feT55HL2ISHeCqxATaEGnfYNoJ+KYR7w6Tzs+X
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="270924028"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="270924028"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 13:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="658709167"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2022 13:59:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6emA-000BgA-7m;
        Wed, 29 Jun 2022 20:59:06 +0000
Date:   Thu, 30 Jun 2022 04:59:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ogabbay:gaudi2 52/62] ERROR: modpost: "__umoddi3"
 [drivers/misc/habanalabs/habanalabs.ko] undefined!
Message-ID: <202206300434.0CSfpTs9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git gaudi2
head:   cdf0db9c5190d3f87662583db935ef9f5c0b7e4a
commit: db0c0cf75ce55851443487f3b7c6e033f112102d [52/62] habanalabs: add gaudi2 asic-specific code
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220630/202206300434.0CSfpTs9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=db0c0cf75ce55851443487f3b7c6e033f112102d
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay gaudi2
        git checkout db0c0cf75ce55851443487f3b7c6e033f112102d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [drivers/misc/habanalabs/habanalabs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
