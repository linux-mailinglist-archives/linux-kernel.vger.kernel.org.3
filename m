Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB450FCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbiDZM2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346809AbiDZM2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:28:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14F617AA0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650975917; x=1682511917;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tGwiiAq/AyILdUgXsGoOt0BVavq4XkHHO7RIMveHi4E=;
  b=FV30eo43fKkE/9eIrOfFz4wHfg1AYuHUJzItLiBnQ2F+O5XuQ6ouQrX2
   AbZgO1ZaDleorFzftMeVVaoIperrWRsqCOhsPOg9OMY19m/eTy8WrG5ii
   crPk18Va2b9nxDMaOKUUuf/5ai6M/FP3X6k2IlNLc5gWds6/83770ns8w
   U8zIuaare02a8xpYawPZ+sdvWL6a1aIhsII6tqUZ6+6sT9lpciRrgc67l
   nKDUKSdAW0biAJ2mssX0FBINZF5LZsug7RlecpWoygfeZ2AWxu+nkeXyX
   bFoF/2Cz6qIUaALXWU6bhRvDfj0RFhk2dGM28djS1R6n9m+UdkkAYDX20
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="326047767"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="326047767"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="705025307"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Apr 2022 05:25:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njKFo-0003Xq-2U;
        Tue, 26 Apr 2022 12:25:16 +0000
Date:   Tue, 26 Apr 2022 20:25:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rostedt-trace:ftrace/core 5/27] ERROR: modpost: "del_timer_free"
 [drivers/bluetooth/hci_uart.ko] undefined!
Message-ID: <202204262014.jLVxAaWT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git ftrace/core
head:   34013efca7a53dc163483fae58c114bd8b2c47f4
commit: c0c1fa7de9ef7b30b95044910ce8b115e24dbb20 [5/27] timers: Add del_time_free() to be called before freeing timer
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220426/202204262014.jLVxAaWT-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/commit/?id=c0c1fa7de9ef7b30b95044910ce8b115e24dbb20
        git remote add rostedt-trace https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
        git fetch --no-tags rostedt-trace ftrace/core
        git checkout c0c1fa7de9ef7b30b95044910ce8b115e24dbb20
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "del_timer_free" [drivers/bluetooth/hci_uart.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
