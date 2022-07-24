Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B6157F30A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 06:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbiGXEia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 00:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiGXEi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 00:38:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C688513F6D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 21:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658637508; x=1690173508;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wyJqwPdjFzBtBm1ds6R57zqn26JOGmUDckaLZWFLCpo=;
  b=CSGi5EzKhfwVU14l7XSLftCESxcI3ODGq2PhcvLHWMlPwm3PkRW9XmaV
   gwn7ku8AFOqZ33smPU+HkSLfrvdWWkzLsiIvK4eiPaon1SMiMPoYJKUX7
   2VpGqQXcbY+47uWlIqHKIAKDf2JAdqvuhab/thZcY7BGSg87BkeHbjeAg
   no0ewbJhe/ojNMlJhEp/iUDRaOK+t3zb9XX+jYRsZK98bv6hIQuchex8p
   xLIsF/JkN+woIBb55dPsDJWQ9PmWzqlW2j/Kyto3aRZjw147rT0HchenH
   lUyAnBtgxi84yBEXwzw3L+giakAkEfmmeGHCWZUyiyx5jy+qDfPnZpWRo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="288272447"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="288272447"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 21:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="667096426"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2022 21:38:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFTNq-0003Xy-0R;
        Sun, 24 Jul 2022 04:38:26 +0000
Date:   Sun, 24 Jul 2022 12:38:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Furquan Shaikh <furquan@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14-rebase 199/9999]
 drivers/idle/intel_idle.c:1000:72: sparse: sparse: incompatible types in
 conditional expression (different base types):
Message-ID: <202207241232.utAadQDp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: 984b012fc9b1fc849276848135307edabd0d5a58 [199/9999] CHROMIUM: intel_idle: dump debug info when S0ix fails
config: i386-randconfig-s003 (https://download.01.org/0day-ci/archive/20220724/202207241232.utAadQDp-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/jsarha/linux/commit/984b012fc9b1fc849276848135307edabd0d5a58
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14-rebase
        git checkout 984b012fc9b1fc849276848135307edabd0d5a58
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/idle/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/idle/intel_idle.c:1000:72: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/idle/intel_idle.c:1000:72: sparse:    int
>> drivers/idle/intel_idle.c:1000:72: sparse:    void

vim +1000 drivers/idle/intel_idle.c

   988	
   989	static int check_slp_s0(u64 slp_s0_saved_count)
   990	{
   991		u64 slp_s0_new_count;
   992	
   993		if (get_slpS0_count(&slp_s0_new_count)) {
   994			pr_warn("After s2idle attempt: Unable to read SLP S0 residency counter\n");
   995			return -EIO;
   996		}
   997	
   998		if (slp_s0_saved_count == slp_s0_new_count) {
   999			WARN(1, "CPU did not enter SLP S0 for suspend-to-idle.\n");
> 1000			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GEMINI_LAKE ?
  1001					telem_soc_states_display() : pmc_core_ppfear_display();
  1002			return -EIO;
  1003		}
  1004	
  1005		return 0;
  1006	}
  1007	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
