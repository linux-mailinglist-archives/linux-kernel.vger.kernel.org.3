Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE5520AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiEJBaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiEJBaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:30:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B55C220CA
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652145968; x=1683681968;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2Sqn2athaxElwwG2zpAn1IuDsVNVGMiUwFPzbvdd13A=;
  b=F3N9vZSULSLUpCk16WeBNQXvpe1sww3WJxyOFDIDku1/MQz11anG6AAo
   9Pqs2bxRu//9WN6mscwQgsxaXTdkR8Qt4gAP3YmB7kHYUE68nnkIpWmQw
   avhl8UCHBPmObXqHM7avHoLNH3bqL5oX5GkTLJIC059zdjzlvAbasCV88
   QaatMpbPRlKjND1dn4RivSxo5ksKagY1rGVVB/CQ5PAd9jokYLAGsU5bO
   Q1NBiNG4sLGCL6D1DFtc7JLm8+omN4Zj/sNZw4jl7qOXm9iC7W4aY+RFP
   YUTMOcjX1X1y6qMNkBO6Cn1Xp1EguSQSEUqYOgWIL5R23GzyCNAiG0HxS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="251268555"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="251268555"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 18:26:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="657405112"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 May 2022 18:26:06 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noEdZ-000H5h-Hm;
        Tue, 10 May 2022 01:26:05 +0000
Date:   Tue, 10 May 2022 09:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.4.y 2166/3542]
 arch/powerpc/kernel/smp.c:599:6: error: no previous prototype for
 'crash_smp_send_stop'
Message-ID: <202205100902.Ey56VTam-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
head:   7dae5fe9ddc036e00696eb0f54f4e7cabc04bb81
commit: 2a8870f5cb2ab56fdf17ef219d9389061ca9a774 [2166/3542] powerpc: handle kdump appropriately with crash_kexec_post_notifiers option
config: powerpc-randconfig-r002-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100902.Ey56VTam-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=2a8870f5cb2ab56fdf17ef219d9389061ca9a774
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.4.y
        git checkout 2a8870f5cb2ab56fdf17ef219d9389061ca9a774
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-stable-rc/linux-5.4.y HEAD 7dae5fe9ddc036e00696eb0f54f4e7cabc04bb81 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/smp.c:539:6: error: no previous prototype for 'tick_broadcast' [-Werror=missing-prototypes]
     539 | void tick_broadcast(const struct cpumask *mask)
         |      ^~~~~~~~~~~~~~
   arch/powerpc/kernel/smp.c:549:6: error: no previous prototype for 'debugger_ipi_callback' [-Werror=missing-prototypes]
     549 | void debugger_ipi_callback(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/smp.c:599:6: error: no previous prototype for 'crash_smp_send_stop' [-Werror=missing-prototypes]
     599 | void crash_smp_send_stop(void)
         |      ^~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/crash_smp_send_stop +599 arch/powerpc/kernel/smp.c

   598	
 > 599	void crash_smp_send_stop(void)
   600	{
   601		static bool stopped = false;
   602	
   603		if (stopped)
   604			return;
   605	
   606		stopped = true;
   607	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
