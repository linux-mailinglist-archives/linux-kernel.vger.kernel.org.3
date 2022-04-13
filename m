Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7604FFFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiDMUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiDMUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:03:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99A56220
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649880038; x=1681416038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0tkUvXJR37PdPMdtjyIHWr7quKwefrxZE2fM/eHBDvo=;
  b=DcYpbx+mn3ZJGUKtndC3QTn6lYhk1BXftL1nvT4i/LRIC08AV6eWmVxk
   rVJocFJw4eWgraDiQOGA5oJDTU+XGQ+E9vz8YpeGA1pMssOEYE3ATu2DY
   WIbcUa0afaIAO7uUTUYUn0othvwCk2OckProgRfAaBV47OF5sZi8Pqn8d
   7uqGGxK0oLwXE0b2DJTHR2enlNZR8QS280M11Us50b+Cx6n/cYTodYLyu
   4ZRqkR+Ide7l4LqQcxHzq9BLQ+5xVrIlVVWwvAjRO+e73caakpIVq6eEn
   SVBkmgDxYSuE3l7tg5tdlt35OKMhoBVj6kosn4fAycvzP109rY1d8B+Tn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="244646244"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="244646244"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 13:00:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="612018573"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2022 13:00:34 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nejAI-0000ZA-9n;
        Wed, 13 Apr 2022 20:00:34 +0000
Date:   Thu, 14 Apr 2022 03:59:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:djwong-wtf 399/400] hppa-linux-ld:
 fs/xfs/xfs_trace.o(.text+0x3fee8): cannot reach
 00005b1d___trace_trigger_soft_disabled+0, recompile with -ffunction-sections
Message-ID: <202204140330.biy5ckQP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git djwong-wtf
head:   4b24106233a017435a70bc0e8ff7afbaddd479d6
commit: ff88d33413f541442f302e44b95dfdc08a52e415 [399/400] xfs: fallocate free space into a file
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220414/202204140330.biy5ckQP-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=ff88d33413f541442f302e44b95dfdc08a52e415
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs djwong-wtf
        git checkout ff88d33413f541442f302e44b95dfdc08a52e415
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x3fee8): cannot reach 00005b1d___trace_trigger_soft_disabled+0, recompile with -ffunction-sections
>> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x3fee8): cannot handle R_PARISC_PCREL17F for __trace_trigger_soft_disabled
   hppa-linux-ld: final link failed: bad value

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
