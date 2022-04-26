Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BD4510AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355043AbiDZUlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiDZUll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:41:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706E76E4CF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651005512; x=1682541512;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qh+uGKxXeeI6qvvTw6mz04btbKD2n7pIfIveGNz4wqo=;
  b=KJz65jfmSl1SdQIIzeZbM3qsAwlcVbz4MRtjNgb23UmhANkbOjgw6VgO
   N3RwlbddQ2AFJyfeht0yBpiWAQhHthXo+5OqRoXwOLW2kc+MlhZ4X0flB
   JjKNmBXPkkxHWqsXUvf+eEX18OEWRQxIsKqzCaFPotjXi+xwxwhHb2KxA
   TKb5EynxWLTmt8XqzMVW6uTZDRw8ryWjITBC9w+ty/dIwRjmR9TTecP0o
   Zv4zQUwYKt11QkfjCqjtuO0MzDPeXC0qK7BJP/4sTZ4qJZxEgiTxMnxhy
   r2wuMo7TabPgvFptoiO/B8GvsqNhyvTjeRZeMWwR6S64otuzvXkKD14Ct
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="263307504"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="263307504"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 13:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="679187536"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Apr 2022 13:38:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njRx7-0003xw-8f;
        Tue, 26 Apr 2022 20:38:29 +0000
Date:   Wed, 27 Apr 2022 04:37:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Watson Chow <watson.chow@avnet.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/regulator/max20086-regulator.c:288:34: warning: unused
 variable 'max20086_dt_ids'
Message-ID: <202204270439.GkdfXdmL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Watson,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d615b5416f8a1afeb82d13b238f8152c572d59c0
commit: bfff546aae50ae68ed395bf0e0848188d27b0ba3 regulator: Add MAX20086-MAX20089 driver
date:   4 months ago
config: arm-randconfig-c002-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270439.GkdfXdmL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfff546aae50ae68ed395bf0e0848188d27b0ba3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bfff546aae50ae68ed395bf0e0848188d27b0ba3
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/regulator/max20086-regulator.c:288:34: warning: unused variable 'max20086_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id max20086_dt_ids[] = {
                                    ^
   1 warning generated.


vim +/max20086_dt_ids +288 drivers/regulator/max20086-regulator.c

   287	
 > 288	static const struct of_device_id max20086_dt_ids[] = {
   289		{
   290			.compatible = "maxim,max20086",
   291			.data = &(const struct max20086_chip_info) {
   292				.id = MAX20086_DEVICE_ID_MAX20086,
   293				.num_outputs = 4,
   294			}
   295		}, {
   296			.compatible = "maxim,max20087",
   297			.data = &(const struct max20086_chip_info) {
   298				.id = MAX20086_DEVICE_ID_MAX20087,
   299				.num_outputs = 4,
   300			}
   301		}, {
   302			.compatible = "maxim,max20088",
   303			.data = &(const struct max20086_chip_info) {
   304				.id = MAX20086_DEVICE_ID_MAX20088,
   305				.num_outputs = 2,
   306			}
   307		}, {
   308			.compatible = "maxim,max20089",
   309			.data = &(const struct max20086_chip_info) {
   310				.id = MAX20086_DEVICE_ID_MAX20089,
   311				.num_outputs = 2,
   312			}
   313		},
   314		{ /* Sentinel */ },
   315	};
   316	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
