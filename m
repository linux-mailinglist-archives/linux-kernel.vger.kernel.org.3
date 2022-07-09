Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6AB56CB63
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 22:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiGIUiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 16:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIUiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 16:38:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC4E0A2;
        Sat,  9 Jul 2022 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657399095; x=1688935095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UsCG2LP+eMsf8h/hHDidHHdX1fTkku1D4E2O+r5yQcI=;
  b=dz6Vi8IDVGbIB6uWAnW4SDM41rN0BiDYsIFp8lO/i0oncLNroEo68775
   SP5q3IF/kxwmJqOG3FncotyWL54151nri4bTaB+KoDAfYpPcsm59nKuqU
   ub6+BbhfMijwNhvrepWS/umGdXRMIBWo/EdcswdOLhi0is1Agc+UqxFIF
   stQI/h84rfdQ2lmwbNhlQKeNuiyiFoGMdr/9Q2dIFoG0VKlVCAaWmus9z
   efoXStWszqFDhTkJzGHoNL0Wff7MNc1eebdjXF4K+Bw6eBR8xjHcgTIs7
   Oz5PEU7hBJfHrpJDd9EDTanDy3yPrDt28sjgjjuL9G5pUIb3vuypuZL5J
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="285202639"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="285202639"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 13:38:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="621617706"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2022 13:38:13 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAHDQ-000P4i-J3;
        Sat, 09 Jul 2022 20:38:12 +0000
Date:   Sun, 10 Jul 2022 04:37:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 295/418] htmldocs:
 Documentation/virt/kvm/api.rst:1364: WARNING: Inline emphasis start-string
 without end-string.
Message-ID: <202207100439.e7j8H8ek-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   c2b43d6ee32b2f2de54395e7b2d7ba9bfa727608
commit: 4a84476dadcc3d7640c22b327464bdc9488787fd [295/418] KVM: Extend the memslot to support fd-based private memory
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/virt/kvm/api.rst:1364: WARNING: Inline emphasis start-string without end-string.

vim +1364 Documentation/virt/kvm/api.rst

4a84476dadcc3d Documentation/virt/kvm/api.rst    Chao Peng      2021-11-15  1363  
0f2d8f4dd0663d Documentation/kvm/api.txt         Avi Kivity     2010-03-25 @1364    /* for kvm_memory_region::flags */
4d8b81abc47b83 Documentation/virtual/kvm/api.txt Xiao Guangrong 2012-08-21  1365    #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
4d8b81abc47b83 Documentation/virtual/kvm/api.txt Xiao Guangrong 2012-08-21  1366    #define KVM_MEM_READONLY	(1UL << 1)
4a84476dadcc3d Documentation/virt/kvm/api.rst    Chao Peng      2021-11-15  1367    #define KVM_MEM_PRIVATE		(1UL << 2)
0f2d8f4dd0663d Documentation/kvm/api.txt         Avi Kivity     2010-03-25  1368  

:::::: The code at line 1364 was first introduced by commit
:::::: 0f2d8f4dd0663defff8c1738d33478c1fb65a4f5 KVM: Document KVM_SET_USER_MEMORY_REGION

:::::: TO: Avi Kivity <avi@redhat.com>
:::::: CC: Avi Kivity <avi@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
