Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EABC5771A7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 23:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiGPVtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 17:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiGPVs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 17:48:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612701277C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658008137; x=1689544137;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l+oQm6gWemg/OC6TviMOgJXqtVzNmg6fl/jmVzCeO24=;
  b=KX4CrMSA7lSNiRMKP/32eoeK7C3Q8YYHYisayVv27uHef2ipqGcEs1yY
   WXY1tj0z/EhcIxvRfknYZUdvMjbaSEeocMFtyMhT0DgH+6+YM3lctQYCv
   Y810vYXvMEufV8r52toIuEWIyS4q+53w+Dj2/6KCUUOOmx8ElDpHRnly7
   1ZhZ0fKq/h78GU4jSkYAHQAzEQOQsfdr0FFTiC05IgqdJRm69Mcr6cTzm
   tu0Gi6GEOMGkCLV+WnS9jM2tyqtyJueHh4FyK/3NyE2yOE8F9Z3Mk6WLw
   sWIiN2YT31O7pmQdVXrbNVletfnVjhjIduBJZjoS1YS+6SLkz5FIpzNjt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="265793519"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="265793519"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 14:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="923897301"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2022 14:48:55 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCpeg-0002Be-PU;
        Sat, 16 Jul 2022 21:48:54 +0000
Date:   Sun, 17 Jul 2022 05:48:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Fred Oh <fred.oh@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: sof-client-ipc-flood-test.c:undefined reference to
 `sof_client_get_fw_state'
Message-ID: <202207170529.CoaJYL8a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ranjani,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5fe7a97f20c7f3070ac870144515c0fabc6b999
commit: 6e9548cdb30e5d6724236dd7b89a79a270751485 ASoC: SOF: Convert the generic IPC flood test into SOF client
date:   5 months ago
config: arm64-buildonly-randconfig-r006-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170529.CoaJYL8a-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e9548cdb30e5d6724236dd7b89a79a270751485
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e9548cdb30e5d6724236dd7b89a79a270751485
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: sound/soc/sof/sof-client-ipc-flood-test.o: in function `sof_ipc_flood_dfs_open':
>> sof-client-ipc-flood-test.c:(.text+0xfc): undefined reference to `sof_client_get_fw_state'
   aarch64-linux-ld: sound/soc/sof/sof-client-ipc-flood-test.o: in function `sof_debug_ipc_flood_test':
>> sof-client-ipc-flood-test.c:(.text+0x254): undefined reference to `sof_client_ipc_tx_message'
   aarch64-linux-ld: sound/soc/sof/sof-client-ipc-flood-test.o: in function `sof_ipc_flood_probe':
>> sof-client-ipc-flood-test.c:(.text+0xa54): undefined reference to `sof_client_get_debugfs_root'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
