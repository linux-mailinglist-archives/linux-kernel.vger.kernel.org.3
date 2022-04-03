Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FB84F0A18
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358968AbiDCOJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiDCOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:09:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB94C369C6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648994853; x=1680530853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cgO1TvmQjjRmNXymTCUbVPt+M4DxOV30j566IEdNhJU=;
  b=iDb/Rdtm3lksp5L9m1ep2s48IUjdA0axcHqQwR1777Awn+RQ3fpT8d9g
   cRpHT9sw5KtQQWgUoKpSVtrF8c8Y/aboqmB+oGFc2MsIuiUluF5GrOWX9
   pvrrmSk+dGUgVNcz8AjCSsIuHXrTfpOERW/5Xo9FcvV71EDcC9QDPMDnj
   fJq+MMmF0zdJ/AGs5mm+m9mwGdGFD0x6dfT8haGK7+70WpMzC9GpVCYNH
   fFMF/DxUeWnNCey7Uy3uXOqyaORxJdKcavPfvpzZRPQ1BLP4cYR1QPzh1
   4a1CKwaztLc5EBy4bHQoV/I6qEGVe9YczAK/N9kGMuNuEyjLqdbvzHz+/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="240325324"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="240325324"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 07:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="504646914"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Apr 2022 07:07:31 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nb0t9-000115-8M;
        Sun, 03 Apr 2022 14:07:31 +0000
Date:   Sun, 3 Apr 2022 22:06:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Subject: drivers/bus/imx-weim.c:373:23: sparse: sparse: symbol
 'weim_of_notifier' was not declared. Should it be static?
Message-ID: <202204032238.7EWqnzoQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
commit: e6cb5408289f4202f4088731a4ac98c7ffaedb9d bus: imx-weim: add DT overlay support for WEIM bus
date:   6 weeks ago
config: arm64-randconfig-s031-20220403 (https://download.01.org/0day-ci/archive/20220403/202204032238.7EWqnzoQ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e6cb5408289f4202f4088731a4ac98c7ffaedb9d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e6cb5408289f4202f4088731a4ac98c7ffaedb9d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/bus/ drivers/firmware/meson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/bus/imx-weim.c:373:23: sparse: sparse: symbol 'weim_of_notifier' was not declared. Should it be static?

vim +/weim_of_notifier +373 drivers/bus/imx-weim.c

   372	
 > 373	struct notifier_block weim_of_notifier = {
   374		.notifier_call = of_weim_notify,
   375	};
   376	#endif /* IS_ENABLED(CONFIG_OF_DYNAMIC) */
   377	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
