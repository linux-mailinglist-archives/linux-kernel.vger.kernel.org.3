Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334959114B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbiHLNVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHLNVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:21:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659DC6554D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660310505; x=1691846505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eCKWbymhNzifUYzZxAhoCbx2DRrRb2h8+g0Au8fUQR8=;
  b=iNISRtNj4UYQQfsGg28dsPQgTx71zA6BIsqRpfBqPRIWjoiJOVmRYDXg
   6u5ttBZzUY2KX1LFjNtm57C6aU06Md7eYX5GDBcdlvXJTWsqj1eEq2fQX
   z7A4HG0j7O4BLGxqmEj0Wk6ZKNPOw7Gt8gkjIctIjx8E2UoxuyUJFf2yS
   CPlSqi41Wa2/Jw/yxuxI2SrleDb0C24pTXpMtQNOPqOF0MXWvOsF8J01b
   u5FLUeI0NVILFo6wtN+MnlcBPMuEIuUzp6I4EuhcQHsu5SS9eG/Cxy1bo
   8CW9ykPCBcAkvb5gXXo2ZSlv4C2aQ99hhxHNovyX5OP8RCOjwQyEL64RZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="317562712"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="317562712"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 06:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="748194133"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2022 06:21:43 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMUbe-0000YF-32;
        Fri, 12 Aug 2022 13:21:42 +0000
Date:   Fri, 12 Aug 2022 21:21:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:totally-untested/remaining-fam0 1/2]
 sound/pci/hda/patch_hdmi.c:232:5: error: flexible array member 'bytes' in a
 union is not allowed
Message-ID: <202208122119.FT6MKKrV-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git totally-untested/remaining-fam0
head:   b0684d2f714f4ae515c283697c48d14e3ccef21b
commit: 9b8e2a44bb97e6316a5d268f9812543e2f6f1d44 [1/2] totally-untested: remaining zero-length arrays in unions in next-20220811
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220812/202208122119.FT6MKKrV-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=9b8e2a44bb97e6316a5d268f9812543e2f6f1d44
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars totally-untested/remaining-fam0
        git checkout 9b8e2a44bb97e6316a5d268f9812543e2f6f1d44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/pci/hda/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/pci/hda/patch_hdmi.c:232:5: error: flexible array member 'bytes' in a union is not allowed
           u8 bytes[];
              ^
   1 error generated.


vim +/bytes +232 sound/pci/hda/patch_hdmi.c

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
