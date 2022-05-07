Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C849B51E68E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 12:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384558AbiEGLDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 07:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbiEGLDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 07:03:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37B433884
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 03:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651921159; x=1683457159;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m7doKvTKexgwsPcQxOnDf7MP53mdFF8U3rmG7pdOVQE=;
  b=Bm7oPx4KNFUXpka4b5bDlU876YZyUgcIuMQavDhCadWh2a1aUyVmOI94
   +TGRxrHC7mSuPIVnoPL70qMVsFRAkkhh104hAhvSDeYe9gUGOOl3N6gey
   0JIZUrGyNEPig4P6XPdk/4AukVRqwtmAhkaIcIWcsFWA+9pElLv2WIjxS
   zGuM0RBMrcgVO3fekkEXkpxlNa+QAb9fDF47FSB3i5TQPt6VHwQ0rea5T
   Mcq0zt7LN2LYemBkcTGkfvmyisSNlhWjcPJUO7qv70uG1f0v2yZxEC3OR
   /n2s3o/i0AAYxgE5p5KUC4rb9fr3FdRTfpJvqdrXAVoItKDv8GPvF4Kxr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268591437"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="268591437"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 03:59:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="665880769"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 May 2022 03:59:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnI9c-000EUW-MU;
        Sat, 07 May 2022 10:59:16 +0000
Date:   Sat, 7 May 2022 18:58:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [intel-tdx:kvm-upstream-workaround 99/361]
 arch/x86/kvm/vmx/vmx.c:4410:5: sparse: sparse: symbol
 'vmx_get_pid_table_order' was not declared. Should it be static?
Message-ID: <202205071817.k6ejQDOR-lkp@intel.com>
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

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   3b5b338cdf10dca7a2435d1f86b2dd9f1a3ad833
commit: 833404c859e4357ba656b2d19d5a405ba7bf4ec4 [99/361] KVM: VMX: enable IPI virtualization
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220507/202205071817.k6ejQDOR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel/tdx/commit/833404c859e4357ba656b2d19d5a405ba7bf4ec4
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 833404c859e4357ba656b2d19d5a405ba7bf4ec4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/kvm/vmx/vmx.c:4410:5: sparse: sparse: symbol 'vmx_get_pid_table_order' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
