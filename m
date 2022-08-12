Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE725911D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbiHLOCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiHLOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:02:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A869E112
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660312966; x=1691848966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tURBSLvapNKWKLrlqWooe5/2I5z7MCFJwhSBW2wdemg=;
  b=Ov4dUDvFiVkMJE6RLqRQc7vlZJFzGX/xQmbmQ4ximy1dfju5jChL40az
   cWkGxBiXjxetyq9rjCuEQOym4r2sdkVQmCIkDyM1kdhXMZOHug98u5Dx/
   sZlFubIKJTUZRSPYqlep+GhAE4gm2qWAJ7+Ez9X1uSlrboZXNrSLz2Ndb
   ftPJpJJvaRFwiqTdeI4ps536KcsHYx0eI5dLQdy/xKl/xqgzwkPHzwiUE
   9WWmCPAs8+ESXiatXKW0WVlRwmyWBLnnBfPvhDQY0An3uO9MsP/O53z0S
   RlmnmnzoYsyQLLaXuEfk6fQQO9Y4/zT76RrUrkiH9SJkOnMrma4eO5wb/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355603823"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="355603823"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="556523354"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Aug 2022 07:02:45 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMVFM-0000bJ-1K;
        Fri, 12 Aug 2022 14:02:44 +0000
Date:   Fri, 12 Aug 2022 22:02:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:totally-untested/remaining-fam0 1/2]
 drivers/net/can/usb/etas_es58x/es58x_core.h:225:5: error: flexible array
 member 'raw_cmd' in a union is not allowed
Message-ID: <202208122128.dEarB7X1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git totally-untested/remaining-fam0
head:   b0684d2f714f4ae515c283697c48d14e3ccef21b
commit: 9b8e2a44bb97e6316a5d268f9812543e2f6f1d44 [1/2] totally-untested: remaining zero-length arrays in unions in next-20220811
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220812/202208122128.dEarB7X1-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/can/usb/etas_es58x/es58x_core.c:20:
>> drivers/net/can/usb/etas_es58x/es58x_core.h:225:5: error: flexible array member 'raw_cmd' in a union is not allowed
           u8 raw_cmd[];
              ^
   1 error generated.


vim +/raw_cmd +225 drivers/net/can/usb/etas_es58x/es58x_core.h

   216	
   217	union es58x_urb_cmd {
   218		struct es581_4_urb_cmd es581_4_urb_cmd;
   219		struct es58x_fd_urb_cmd es58x_fd_urb_cmd;
   220		struct {		/* Common header parts of all variants */
   221			__le16 sof;
   222			u8 cmd_type;
   223			u8 cmd_id;
   224		} __packed;
 > 225		u8 raw_cmd[];
   226	};
   227	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
