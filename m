Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA98853B981
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiFBNOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiFBNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:14:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F09FCE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654175674; x=1685711674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rVJywBaPpNw+rAw7ZxAFgh1cOROwJvdlz4npHNBxst8=;
  b=FhCtCa6NBZ4tzgWmSqqE30f/51gQcZB0WZ4JSgwHtwEJmcz4gUKvlQaQ
   7iFpMQRjNbwoQhCrVbjemdfGkUOxgeduF5OeqoF8wDVJ1rw5U0z5rXDp2
   QnqYHRvYJ9j9+j7spChRG1X5Xbm6/uaN9xLeQuaOkI6dC8WGXE5bvEh5D
   N3er1J2oR7AB6MLzrlKa2OjR/R4aLJxvtXKGcY4uweo7ZDKaPr1D5gkfV
   7mhmfSO1AFkg1XD8N7VuwiTi/oeXsHVDqzwhXhMcDG4luL/S0yNfg4tU4
   xCDROR1GYLwtXJhYveX1rfGPddJApiHT5OfTU8c/FY67/hpKdaw6aEjNf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="301308572"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="301308572"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 06:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="563303147"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2022 06:14:28 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwkeh-00056g-EO;
        Thu, 02 Jun 2022 13:14:27 +0000
Date:   Thu, 2 Jun 2022 21:13:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     kbuild-all@lists.01.org, Tzung-Bi Shih <tzungbi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [tzungbi-chrome-platform:dev 35/40] ERROR: modpost:
 "cros_kunit_ec_cmd_xfer_mock_called"
 [drivers/platform/chrome/cros_ec_proto_test.ko] undefined!
Message-ID: <202206022104.J6wQ08Jb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tzungbi/chrome-platform.git dev
head:   09a34602eeb230a0bbf339457c1b339220f817d3
commit: 9a1aa601ff843e92990a29ffd8510aa12ccf7cf4 [35/40] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_cmd_xfer()
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220602/202206022104.J6wQ08Jb-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tzungbi/chrome-platform.git/commit/?id=9a1aa601ff843e92990a29ffd8510aa12ccf7cf4
        git remote add tzungbi-chrome-platform https://git.kernel.org/pub/scm/linux/kernel/git/tzungbi/chrome-platform.git
        git fetch --no-tags tzungbi-chrome-platform dev
        git checkout 9a1aa601ff843e92990a29ffd8510aa12ccf7cf4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "cros_kunit_ec_cmd_xfer_mock_called" [drivers/platform/chrome/cros_ec_proto_test.ko] undefined!
>> ERROR: modpost: "cros_kunit_ec_pkt_xfer_mock_called" [drivers/platform/chrome/cros_ec_proto_test.ko] undefined!
>> ERROR: modpost: "cros_kunit_ec_xfer_mock_default_ret" [drivers/platform/chrome/cros_ec_proto_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
