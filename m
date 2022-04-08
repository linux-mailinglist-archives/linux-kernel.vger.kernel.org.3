Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED14F9E67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiDHUxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbiDHUxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:53:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2502EF15B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649451081; x=1680987081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u1zt2GErlMYJ+NdZYUUhcH4dQfa9vZ0KgBSF7aAR2Is=;
  b=kYtHmSkui9maeEHsDfVCdfVEQfnCwe6nFbhy2RFJl8io1u9w1B3gZYf9
   dq4kEi3UoEzrkGVPRBJga2igv0PUMZCXkEBX2BbHCO2NqkAiOe/SzbhgO
   L6aJErg6GWtvSxl9/F2s+c590UJM9Y/20wRLjcimDzhn4FaM1O8nz0ma8
   M4COOY3rjGdn+6k/+MbROszgMEpSelFeu2g1QPLA5+jbsPe2UGrX85Rck
   0KSD8dMG01+/TjFcnMS4od4vSjF3b4ejovDlxQoRHCtaKrLhtJZzu7D+j
   gZ4tZ3SJW1d+NXZIzJ/tiIheQXOuYk9BqyEHhpOqPv6l+Q7kgOV5xVcDJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="241619997"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="241619997"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 13:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="524920240"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2022 13:51:19 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncvZe-0000dB-En;
        Fri, 08 Apr 2022 20:51:18 +0000
Date:   Sat, 9 Apr 2022 04:50:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Sudeep Holla <sudeep.holla@arm.com>,
        op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Balint Dobszay <balint.dobszay@arm.com>
Subject: Re: [PATCH] tee: Add Arm FF-A TEE driver
Message-ID: <202204090424.doAuWAHT-lkp@intel.com>
References: <20220408134144.1532704-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408134144.1532704-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on linux/master v5.18-rc1]
[cannot apply to next-20220408]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sudeep-Holla/tee-Add-Arm-FF-A-TEE-driver/20220408-214327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1831fed559732b132aef0ea8261ac77e73f7eadf
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220409/202204090424.doAuWAHT-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e95f1810cd4b79dd9b7378d1d7769ddbd2d9e1df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sudeep-Holla/tee-Add-Arm-FF-A-TEE-driver/20220408-214327
        git checkout e95f1810cd4b79dd9b7378d1d7769ddbd2d9e1df
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc INSTALL_HDR_PATH=/tmp/usr/src/linux-headers-powerpc-allnoconfig-e95f1810cd4b79dd9b7378d1d7769ddbd2d9e1df headers_install

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/arm_ffa_tee.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/linux/arm_ffa_tee.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1280: headers] Error 2
   make[1]: Target 'headers_install' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'headers_install' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
