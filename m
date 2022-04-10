Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3514FAF61
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbiDJRu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiDJRuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:50:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D74830B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649612894; x=1681148894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bzQ4b4BOoU26R39Qb50Ig73Hi9r7SDnG5ycG7frQyHg=;
  b=WdsWb76b/6mdVOugNGHZUzjkPU2G0zXF5E4XArWNEyeF0nPDpkmfFdxY
   kFS0S0sLqYt5oH2FlDC+sx6yses07AAdJfPGgmMqwVwqtJMaMFPBKDoDn
   xNXckPiwhQUNDLf9Mk3r87SQwMT87OOzieYl86cj+c0Th3kAs04dWCc/K
   xFOFM+kW8oEy66DF8tsFBTKLn60PsnqTDcdYIt89U96cMht0MOu2GEsS1
   gOw/cUo+0vvhxyF2XuV8qlip+uSdmjKk1Z1uRcNsp0NujDXqhJWyqmqGM
   7+aFG8PuaUdgMhg0anoahJRN/uiybzCVRdJMQAB5L8JeaCtpVbFc1jO0H
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261424146"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="261424146"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 10:48:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="589506144"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2022 10:48:13 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndbfY-000101-DI;
        Sun, 10 Apr 2022 17:48:12 +0000
Date:   Mon, 11 Apr 2022 01:47:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:jd/not-zero-entropy-ktime 4/13] ERROR: modpost:
 "ktime_read_raw_clock" [crypto/jitterentropy_rng.ko] undefined!
Message-ID: <202204110129.BjVchxsJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git jd/not-zero-entropy-ktime
head:   340a25fe529e8fc1df1a82b42f021a9d0fa4fb51
commit: 58b58e8a703d0ae8da60cbbaea9b1032feff00cc [4/13] random: use ktime_read_raw_clock() for random_get_entropy() if no get_cycles()
config: parisc-generic-32bit_defconfig (https://download.01.org/0day-ci/archive/20220411/202204110129.BjVchxsJ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=58b58e8a703d0ae8da60cbbaea9b1032feff00cc
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random jd/not-zero-entropy-ktime
        git checkout 58b58e8a703d0ae8da60cbbaea9b1032feff00cc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ktime_read_raw_clock" [crypto/jitterentropy_rng.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
