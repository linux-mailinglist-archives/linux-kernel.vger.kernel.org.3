Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8C758B437
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 09:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbiHFHg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 03:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHFHg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 03:36:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E18D4E
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659771416; x=1691307416;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kbS4+7kvZDvL7ji3aktMd6UfvwS44cAG4xhoAYXX6Eo=;
  b=JBBm865FZzsSmgApoUYUmQ6G6mEt35+rStcZcUWz1UzJJqbVic1rW+HN
   x7oSOXvp/FkOKzhQLcvTLIb8VWrPRLYBpYR/tvx4wVgbOuOKAIsg+B1QM
   0xrH7GIZWkUd9hNygLGqCy7sN+vPOXtIa7a1IVPTpZbII/QFg7F6W/St+
   tXGWtH8NkUdh511BdArvEg8/gtpd1GvxrpaMEJcbq6G4EIcQeANw+7Odi
   G4zVa6nLDS2rKqcYI2/s6EH1s5/BvtPjlBXoFiXEUH5lOazWKVUhtzFdf
   6HEjUafNQCV6ub40Y6zk7zAfQFW20pCTq8JomlxLSP8CfIhW58xybZ6Cu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="270121750"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="270121750"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 00:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="579761869"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2022 00:36:49 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKEMa-000KAR-1Q;
        Sat, 06 Aug 2022 07:36:48 +0000
Date:   Sat, 6 Aug 2022 15:36:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 11/23]
 arch/x86/coco/tdx/tdx.c:297:14: sparse: sparse: symbol 'tdx_write_msr' was
 not declared. Should it be static?
Message-ID: <202208061521.03fT4xpR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   c170462888e1dab8e3e80c1c6e3708dd473ad1ed
commit: d1a7216a37f68b347a3622a0c8498134d5cb8970 [11/23] x86/tdx: Use direct paravirt call for wrmsrl
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220806/202208061521.03fT4xpR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/d1a7216a37f68b347a3622a0c8498134d5cb8970
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout d1a7216a37f68b347a3622a0c8498134d5cb8970
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/x86/coco/tdx/tdx.c:297:14: sparse: sparse: symbol 'tdx_write_msr' was not declared. Should it be static?

vim +/tdx_write_msr +297 arch/x86/coco/tdx/tdx.c

   296	
 > 297	void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
   298	{
   299		struct tdx_hypercall_args args = {
   300			.r10 = TDX_HYPERCALL_STANDARD,
   301			.r11 = hcall_func(EXIT_REASON_MSR_WRITE),
   302			.r12 = msr,
   303			.r13 = (u64)high << 32 | low,
   304		};
   305	
   306		if (tdx_fast_tdcall_path_msr(msr))
   307			__tdx_hypercall(&args, 0);
   308		else
   309			native_write_msr(msr, low, high);
   310	}
   311	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
