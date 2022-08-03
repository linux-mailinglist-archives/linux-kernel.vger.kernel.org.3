Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7622D5892FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbiHCUL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbiHCULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:11:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429A92CE33
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659557483; x=1691093483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XbZ53r6B8R3LHJCIt1u2TZm9MjwOkIGTnjtsaMOUn4M=;
  b=nHa8rKdknD0vOiRAeiE6KVA7qDCkR3UbYYZaulnZV0E6ZdJReHh5BMpC
   E9wXtlr9q0vmoajIcOlwhCaMA90/C0yrKVIq4trYhBallaiMo0a6cPON1
   pMCWF4BUlak8zgGqSygBLpb6hHqQXwZVk3pMPwtSbZINRXPNIl31KUceQ
   l0vpXpihltQBh+FzxZnuhjbNZZg1PmfM1gEElA/KqmqxokRUL92GZQ/IM
   dVputpTyUrC6jlU3k67R9bKLRwkKoiI/oIfBdwc8Gr8HQDqPaepjlIZ8y
   qCClDO/SZPCZDlIh/WMiOnzz0WKYZVl1303PmH8FVW9aWj1g85O9UmgLZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="270149266"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="270149266"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 13:11:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="692370071"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2022 13:11:21 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJKi9-000HcO-0e;
        Wed, 03 Aug 2022 20:11:21 +0000
Date:   Thu, 4 Aug 2022 04:10:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest 2/4] arch/x86/kernel/tdx-tests.c:66:12: sparse:
 sparse: symbol 'kvm_unit_test_debug_init' was not declared. Should it be
 static?
Message-ID: <202208040410.dDBmxB5X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest
head:   f3d7a7e86bf2f0d5ce629f2fb7be11dca88ac06d
commit: 4cd6be90a565d847e1d7ccfe28264a1610a02a34 [2/4] x86/tdx-tests: Add a port of a kvm unit test
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220804/202208040410.dDBmxB5X-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/4cd6be90a565d847e1d7ccfe28264a1610a02a34
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout 4cd6be90a565d847e1d7ccfe28264a1610a02a34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/ lib/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/tdx-tests.c:66:12: sparse: sparse: symbol 'kvm_unit_test_debug_init' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
