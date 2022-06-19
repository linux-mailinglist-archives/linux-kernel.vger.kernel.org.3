Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF42B550D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 00:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiFSWAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 18:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFSWAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 18:00:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE6D10F5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655676014; x=1687212014;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pjF3SIPPMLNdCJCf7SOkH9wnAaV/I0aI8aqc+bsK37A=;
  b=WzwOxf2ls3DFtMQP0wHUByH2IyDJc69QOdJ2hZh9YReHLw1afIjIuYSu
   SbHKM1Gj7S9lMXu9EFgSkiG7834iydgcr7Ab58mx7DYavDcfnjmWrufuo
   TivE1WOz/xhA/0DLio5jQE5m+fCo9Tmrl5c5vXbgDUHfuqgzeI4Hu4Hz6
   8NVEQzaRdtBmrwm9t2bgeQdpMcE6sF4Fl5Ink+ircL11NhdBw8zmYUfY5
   FPzsnoNNzjpf8oM7GrjWgZ771B57cPInmtrFrttk9a0LwQVKu9PZXo6bk
   0/kIgT2JnGQG/seW5KlvonKYqwsJppJtkypBjKvDFmDsYa5iPxY3C/+fO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305198406"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305198406"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 15:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642828580"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jun 2022 15:00:12 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o32xn-000RaP-Dm;
        Sun, 19 Jun 2022 22:00:11 +0000
Date:   Mon, 20 Jun 2022 05:59:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.18 128/146]
 drivers/platform/mpam/mpam_resctrl.c:309:25: warning: variable 'dom' is
 uninitialized when used here
Message-ID: <202206200512.vutoaRFq-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.18
head:   bac90d25cbdee0fc233b9b1c47d5b6f44101a384
commit: db8847e121228898d170f140698fb01359cff997 [128/146] arm_mpam: resctrl: Add resctrl_arch_rmid_read() and resctrl_arch_reset_rmid()
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220620/202206200512.vutoaRFq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=db8847e121228898d170f140698fb01359cff997
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.18
        git checkout db8847e121228898d170f140698fb01359cff997
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/perf/ drivers/platform/mpam/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/mpam/mpam_resctrl.c:309:25: warning: variable 'dom' is uninitialized when used here [-Wuninitialized]
                   mpam_msmon_reset_mbwu(dom->comp, &cfg);
                                         ^~~
   drivers/platform/mpam/mpam_resctrl.c:298:30: note: initialize the variable 'dom' to silence this warning
           struct mpam_resctrl_dom *dom;
                                       ^
                                        = NULL
   1 warning generated.


vim +/dom +309 drivers/platform/mpam/mpam_resctrl.c

   293	
   294	void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
   295				     u32 closid, u32 rmid, enum resctrl_event_id eventid)
   296	{
   297		struct mon_cfg cfg;
   298		struct mpam_resctrl_dom *dom;
   299	
   300		if (eventid != QOS_L3_MBM_LOCAL_EVENT_ID)
   301			return;
   302	
   303		cfg.mon = resctrl_arch_rmid_idx_encode(closid, rmid);
   304		cfg.match_pmg = true;
   305		cfg.pmg = rmid;
   306	
   307		if (cdp_enabled) {
   308			cfg.partid = closid << 1;
 > 309			mpam_msmon_reset_mbwu(dom->comp, &cfg);
   310	
   311			cfg.partid += 1;
   312			mpam_msmon_reset_mbwu(dom->comp, &cfg);
   313		} else {
   314			cfg.partid = closid;
   315			mpam_msmon_reset_mbwu(dom->comp, &cfg);
   316		}
   317	}
   318	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
