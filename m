Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE685911BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbiHLNxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiHLNwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:52:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189CAAA3E2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660312368; x=1691848368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r0u+Q8J1cvyrZr7B7FMnz/ZafIDnZ/ghcyBSTY7CW0E=;
  b=X/ITG55NixzjvQopQO6DPLYzmqmLRqx1cOZZQLTmadC6c9y2HRZNx4zo
   kOm9JlANtUljbnPa+Hgb0TDp0LG3S8qjXBejuWWIvn/prtiy/mNK1gUry
   kZm/4dJxwumi3hQ3P1V1Gx6ihTgHvXNMuXSYPAoDHb6Hlr8Au96Dkuakm
   X1S63cSH00pCsWdZEsR8wsZV0qCHMSv6U0WkrRYJ2ql1wgWFtp7eE61cP
   oeNUkUvdLbhf1WXTQe++zmiiYAiHWeqdf92w4cqT5sbOz8W3l+YW4H9i2
   DY0S5AO2HLA0DavPDnkAm9J6Jr+pKVK9+0FDM+iPHiSfQulvbIKm+jXiO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278548579"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="278548579"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 06:52:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="605919569"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Aug 2022 06:52:44 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMV5g-0000ah-0I;
        Fri, 12 Aug 2022 13:52:44 +0000
Date:   Fri, 12 Aug 2022 21:52:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:totally-untested/remaining-fam0 1/2]
 sound/pci/hda/patch_hdmi.c:232:12: error: flexible array member in union
Message-ID: <202208122152.55690beQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git totally-untested/remaining-fam0
head:   b0684d2f714f4ae515c283697c48d14e3ccef21b
commit: 9b8e2a44bb97e6316a5d268f9812543e2f6f1d44 [1/2] totally-untested: remaining zero-length arrays in unions in next-20220811
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220812/202208122152.55690beQ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=9b8e2a44bb97e6316a5d268f9812543e2f6f1d44
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars totally-untested/remaining-fam0
        git checkout 9b8e2a44bb97e6316a5d268f9812543e2f6f1d44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash sound/pci/hda/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/pci/hda/patch_hdmi.c:232:12: error: flexible array member in union
     232 |         u8 bytes[];
         |            ^~~~~


vim +232 sound/pci/hda/patch_hdmi.c

   228	
   229	union audio_infoframe {
   230		struct hdmi_audio_infoframe hdmi;
   231		struct dp_audio_infoframe dp;
 > 232		u8 bytes[];
   233	};
   234	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
