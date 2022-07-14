Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C304574F22
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiGNNZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiGNNZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:25:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D208D545E9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657805121; x=1689341121;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RuFRG0/ZJX88NDSYob41Q/oOTsgyS57BrDvcG2bbXBE=;
  b=SQ2oO/LhwOAjeUWNTdR5/sBTPsTyqjEAk9uNYC94ptLvBWWW+TRkqpO3
   8WbVDdiRLAi4iT1xC/I4gTjx11sK4hHA7ZmQdr3H68RubhIWetSu7NdTG
   YgJuW391mYMERVcDzznyva99PNfPvjKI7tPbaefpkfamaUflq1TguVh6h
   QkuhUjXdQziRa40kY+GrUksQu3HOGe47R4Sv2UHZCTeDvnul+GbNtyWei
   AkONGsGh+OlxjbO/MD2YoXphRVTUkUFac66T81DGJMsCsjiWb+5Z9zpYE
   zQ5Nl6qXtNVC/JpiGezA+aOfzOn7m90BZ8MgtmiWJnQBMYwQnwbJIiowW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="283065797"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="283065797"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 06:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="623411193"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2022 06:25:20 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oByqF-0000hd-9Q;
        Thu, 14 Jul 2022 13:25:19 +0000
Date:   Thu, 14 Jul 2022 21:25:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [tglx-devel:depthtracking 35/38] arch/x86/kernel/callthunks.c:501:9:
 error: implicit declaration of function 'kprobe_add_area_blacklist'
Message-ID: <202207142151.EbbJvHp7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git depthtracking
head:   81d2c1b17a61bfeca4b92a5d6e1fb6f5ff464826
commit: 57b6f2ca7edda679f0a9fe58087ecc9dd9f8dafb [35/38] kprobes: Add callthunk blacklisting
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220714/202207142151.EbbJvHp7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=57b6f2ca7edda679f0a9fe58087ecc9dd9f8dafb
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel depthtracking
        git checkout 57b6f2ca7edda679f0a9fe58087ecc9dd9f8dafb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/callthunks.c: In function 'callthunks_init':
>> arch/x86/kernel/callthunks.c:501:9: error: implicit declaration of function 'kprobe_add_area_blacklist' [-Werror=implicit-function-declaration]
     501 |         kprobe_add_area_blacklist(base, base + size);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/kprobe_add_area_blacklist +501 arch/x86/kernel/callthunks.c

   477	
   478	static __init noinline void callthunks_init(struct callthunk_sites *cs)
   479	{
   480		unsigned long base, size;
   481		int ret;
   482	
   483		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH)) {
   484			callthunk_desc.template = skl_call_thunk_template;
   485			callthunk_desc.template_size = SKL_TMPL_SIZE;
   486			callthunk_desc.thunk_size = SKL_CALLTHUNK_SIZE;
   487		}
   488	
   489		if (!callthunk_desc.template)
   490			return;
   491	
   492		if (WARN_ON_ONCE(btree_init64(&call_thunks)))
   493			return;
   494	
   495		ret = callthunks_setup(cs, &builtin_layout);
   496		if (WARN_ON_ONCE(ret))
   497			return;
   498	
   499		base = (unsigned long)builtin_layout.base;
   500		size = builtin_layout.size;
 > 501		kprobe_add_area_blacklist(base, base + size);
   502		static_call_force_reinit();
   503		thunks_initialized = true;
   504	}
   505	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
