Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E265569FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiGGKaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiGGKan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:30:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A075720F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657189839; x=1688725839;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7tQQX/smw29lp1drVhlqhkUlpjGeGjwP8YJ/+5wpbNs=;
  b=IbmM1+41O2VQpTH3hhrhFFuJiH7MHRbdJHXwVo3+Wopi2ctyDUcSRBK5
   mRiSPvgVSEgZJobTYQMFtdA+XJUOrLZu14IOK9YwWP9Z+sn/8Gej98JvW
   lLjws7FpMYlsGJr5az9xBX+SsR9Iq8ZCbpofBcu5DklHP5AWn1pYXvHEf
   ypJXp4+DyFtvlBClskD0O4u7V45ZHP/D23CUC4dim0SNGb/n7HuWMFbtz
   lGSHa+6xudjP9StNjeH8unHiUOiSqhpHmHdQur8ZtRt7p/wuU7O561a/I
   l6n6CeyvOCYnRzldGPDI9E9K0vsZJGoKOMceMmyHpmb91la2delpDctK7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="284732769"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="284732769"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 03:30:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="770385508"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2022 03:30:38 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9OmL-000Lrw-Oi;
        Thu, 07 Jul 2022 10:30:37 +0000
Date:   Thu, 7 Jul 2022 18:29:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ogabbay:habanalabs-next 52/76] ERROR: modpost: "__divdi3"
 [drivers/misc/habanalabs/habanalabs.ko] undefined!
Message-ID: <202207071847.f6UdRWG9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   0af9772bc4c189e29557a0e1f3af22918f51ccaa
commit: c5c630faa00de0cc343fa0e5a236ed117ef454a3 [52/76] habanalabs: add gaudi2 asic-specific code
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220707/202207071847.f6UdRWG9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=c5c630faa00de0cc343fa0e5a236ed117ef454a3
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout c5c630faa00de0cc343fa0e5a236ed117ef454a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the ogabbay/habanalabs-next HEAD 0af9772bc4c189e29557a0e1f3af22918f51ccaa builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__divdi3" [drivers/misc/habanalabs/habanalabs.ko] undefined!
ERROR: modpost: "__udivdi3" [drivers/misc/habanalabs/habanalabs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
