Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD724527849
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbiEOOxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiEOOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:53:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B069580
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652626390; x=1684162390;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cUQYn6TGdJ3nVA2dB8bj2bThZDvxjScemUOotDa0jlY=;
  b=f0jyqOn9ZLYEpC7fByfnd2xO6zFE7vdTUmfZmSfOTGBDOV5KBb0xXwFI
   Ulmwiy22Zz8mggv4i2EdLRpLAAu9TuSnsghWi8Q7np49o5v5V3dQCmle7
   WpwEV1vOQayAv7nfAAR9iQ7q/mHHdBFSXxvcXfcLq+LqpnTUJ7BwgVV1k
   YqBmPQugwYZ9MatZWJEr7I/gWoQ8fKPRIQSysw0lBC12Wdb/hPXxdU34i
   LVZ86+mvETvKpl6pUTVSJor2Wlf8peHk9Oz89ZkMVaysG8Dua7PgvoGNY
   4VTIC1wMpl/4Fs6Rs+cny1s/zQFXr0GwmzRj2ALTX25UpC06A7LWEDd/F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="357050207"
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="357050207"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 07:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="604512669"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2022 07:53:08 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqFcI-0001i9-Ok;
        Sun, 15 May 2022 14:53:06 +0000
Date:   Sun, 15 May 2022 22:52:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [iwlwifi-next:_ggreenman_test 1/1]
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c:35:5: error: expected ';'
 before 'static'
Message-ID: <202205152209.1ne45jzV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git _ggreenman_test
head:   11860abc64f2e232963cd2dd9f1187986d20e2ff
commit: 11860abc64f2e232963cd2dd9f1187986d20e2ff [1/1] TEST push config
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220515/202205152209.1ne45jzV-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/commit/?id=11860abc64f2e232963cd2dd9f1187986d20e2ff
        git remote add iwlwifi-next https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
        git fetch --no-tags iwlwifi-next _ggreenman_test
        git checkout 11860abc64f2e232963cd2dd9f1187986d20e2ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/wireless/intel/iwlwifi/mvm/ops.c:35:5: error: expected ';' before 'static'
      35 | TEST
         |     ^
         |     ;


vim +35 drivers/net/wireless/intel/iwlwifi/mvm/ops.c

    33	
    34	
  > 35	TEST
    36	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
