Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBCF5A3765
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbiH0Ljy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiH0Ljt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:39:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7666273
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661600387; x=1693136387;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gLMBOJdeYAp1LiPWyZwBX5tq/swH15L8tbKcpP5En0E=;
  b=Zv7MpNPOxYUI9DTtRYWMFwQzlg6EP8+q0KM7R6Ug6iudkqI2v6d+1MC+
   Dd6SWUAQ7GPONuUX1s9u5q8Ea8MW3KpWGJk6N1sPYmtync9FLLx9O71f2
   XLubE/PFVo2UwS9//qMtLScn9+C01TBxU76kccMBesSAI1HfsRvebICwo
   9/o5TlGbFMRh6LE+OeolpaMHR8w0LYhihZPnxqNHwBltpsWZS/H7heWNl
   src//egVhF1N9OQf+GTqE/lfZOgKT448ksHq4JsB4OJPdP+LTm8+o+56P
   NabBjTlHLleBNQZtw3uMTTiBL6bZwwhVWnyoheyKP8f7b7ljEGSHD0ZIF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="292235319"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="292235319"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 04:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="640375352"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2022 04:39:46 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRuAD-00008B-25;
        Sat, 27 Aug 2022 11:39:45 +0000
Date:   Sat, 27 Aug 2022 19:39:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 16/36]
 arch/x86/coco/tdx/tdx-tests.c:66:12: sparse: sparse: symbol
 'kvm_unit_test_debug_init' was not declared. Should it be static?
Message-ID: <202208271936.XF68Nvt2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   d941f409a509c084250b50a3b5fc1c3c84a596a0
commit: 5091d7c6068bf030df54dc48b303a1d25a7ef0a0 [16/36] x86/tdx-tests: Add a port of a kvm unit test
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220827/202208271936.XF68Nvt2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/5091d7c6068bf030df54dc48b303a1d25a7ef0a0
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 5091d7c6068bf030df54dc48b303a1d25a7ef0a0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/x86/coco/tdx/tdx-tests.c:66:12: sparse: sparse: symbol 'kvm_unit_test_debug_init' was not declared. Should it be static?

vim +/kvm_unit_test_debug_init +66 arch/x86/coco/tdx/tdx-tests.c

    65	
  > 66	int __init kvm_unit_test_debug_init(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
