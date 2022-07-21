Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDABE57C4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiGUGso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiGUGsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:48:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547DB643C7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658386121; x=1689922121;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EgGw3gG1BUFEcA9eZtTV+x5vKzTY8QZdPgfZEDKZ+xg=;
  b=NRji1B1SNigvIqMD06PJUfhXoteX0bKruwbxWskrzZM7YXKxw6J0HrIA
   z+T5dANFeMp7uHK7wE8dCeYiEHhD56lDKjJbNdDCwbqqUckvv5iW/s/RY
   PsBhX4YXqoBCxJ1kJwTMnOpA8FQsUPZrkdIypxq8aISli088rxGQnK/fW
   dNtgR2vv9Obx3fKO2w3ytvRMBmTJIuWPhKk5Bdj839cvDFfUhK7/ty7YS
   YQH8Vq+vFX0UxDkxHDJmRWnhDr7X2sDFCGpKx/nw40Dz8t7icqOocayV5
   k2Uw8dBLbs/Axm7lURzNjGDBKcoNkOch+SeZu1vk6MP3lukOYqxDqx++2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="284524850"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="284524850"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 23:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="573616525"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Jul 2022 23:48:39 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEPzD-0001ZD-33;
        Thu, 21 Jul 2022 06:48:39 +0000
Date:   Thu, 21 Jul 2022 14:47:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dani Liberman <dliberman@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 1/12] undefined reference to
 `hl_engine_data_sprintf'
Message-ID: <202207211437.0TR61ERC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   b96d130bd4ce16ea38aba5a8d3f20e9c1f66c7f7
commit: a8ed58698e1e0aabcb8dc5bd63aa5e910424088a [1/12] habanalabs: removed seq_file parameter from is_idle asic functions
config: parisc-randconfig-r005-20220718 (https://download.01.org/0day-ci/archive/20220721/202207211437.0TR61ERC-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=a8ed58698e1e0aabcb8dc5bd63aa5e910424088a
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout a8ed58698e1e0aabcb8dc5bd63aa5e910424088a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/misc/habanalabs/goya/goya.o: in function `goya_is_device_idle':
>> (.text+0x674c): undefined reference to `hl_engine_data_sprintf'
>> hppa-linux-ld: (.text+0x6800): undefined reference to `hl_engine_data_sprintf'
   hppa-linux-ld: (.text+0x6820): undefined reference to `hl_engine_data_sprintf'
   hppa-linux-ld: (.text+0x6900): undefined reference to `hl_engine_data_sprintf'
   hppa-linux-ld: (.text+0x6920): undefined reference to `hl_engine_data_sprintf'
   hppa-linux-ld: drivers/misc/habanalabs/goya/goya.o:(.text+0x69cc): more undefined references to `hl_engine_data_sprintf' follow

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
