Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA4C560AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiF2TwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiF2TwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:52:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789F29CB1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656532321; x=1688068321;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eKfq4qTugIYYDtip5GDHxrXVDZByPpmrFjWUMbuhqDw=;
  b=bxxGHRtJT8CFbi9FcZZITVLr6XpCE9HulAOtNPVA9EdGqZJ9PRaAqLxM
   REmnmgtOZykfzt+SrrbJj0rWqdqrJHsFT9vvDbqG7njoUR1FrtnxuC61w
   vj9rKyzjJLlN0PJ79dHnigOiggfSC8g/8Tk8JR1c82I05d0i9NC7I8Gej
   KYl9nkcvA85iQj0Dko2u6wUJ2QoISK0Qk3q5utTt2nXnwwGrLCh2xv2bz
   TWq1G9pVPF9wRR2bFBSEvSrQzlYdsqjc0EkROVzZktUF18D3qB9eoynxl
   THplhOhuLUhDqFRLuIwUbt6+cB2k/5zeJ5jw+y7P42Gn3Bhmrp91wQv9v
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="280907523"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="280907523"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="658687306"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2022 12:48:02 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6dfO-000BZ0-6J;
        Wed, 29 Jun 2022 19:48:02 +0000
Date:   Thu, 30 Jun 2022 03:47:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ogabbay:gaudi2 52/62] ERROR: modpost: "__udivdi3"
 [drivers/misc/habanalabs/habanalabs.ko] undefined!
Message-ID: <202206300327.XHoto1QZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git gaudi2
head:   cdf0db9c5190d3f87662583db935ef9f5c0b7e4a
commit: db0c0cf75ce55851443487f3b7c6e033f112102d [52/62] habanalabs: add gaudi2 asic-specific code
config: microblaze-randconfig-r002-20220629 (https://download.01.org/0day-ci/archive/20220630/202206300327.XHoto1QZ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=db0c0cf75ce55851443487f3b7c6e033f112102d
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay gaudi2
        git checkout db0c0cf75ce55851443487f3b7c6e033f112102d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [drivers/misc/habanalabs/habanalabs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
