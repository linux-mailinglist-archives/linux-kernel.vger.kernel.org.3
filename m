Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301175675E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiGERkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiGERkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:40:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFCE17E14;
        Tue,  5 Jul 2022 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657042805; x=1688578805;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tbN9HBw9meoAuTFi8WRaht1ogLbillXd6XljgI3uiHk=;
  b=cKpSQTs2tt106OcJyw5X+WJnTI+vKA/kh4LqZwUzJ17GaHFIDqrNT/wh
   TIAJfVOaqps2kDxrYlaDpZFxEQn5EeSj2KUgrAloC455hf0UyxKahUaIc
   /v9/KOsFH0L4LFOALaUQ+BREAwuAlWRM4zewVnPe2VsJMdNULuFIvv0nh
   b3SnFAKbycNW+OVdvYOK1Tdt4VTFK5+BlPkv+Gy+vUMOdoZB7Ic3c3s08
   TB7j1nSH552SV0mx4M3parsBcPpb95aP6EQEObL8dDShhnNW3b0zeQeO6
   g9fAWjMn8L53iImy6wN3FmFuwTB+9k/O1VzNKdECDLk1SyjWSjcKMnJT8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="282170518"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="282170518"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 10:37:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="735238072"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2022 10:37:48 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8mUd-000JQt-N5;
        Tue, 05 Jul 2022 17:37:47 +0000
Date:   Wed, 6 Jul 2022 01:37:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 329/442] htmldocs:
 Documentation/virt/kvm/api.rst:1364: WARNING: Inline emphasis start-string
 without end-string.
Message-ID: <202207060157.oZAr0KUU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   8af973ebaf30642129fc1ca63f155a469f9615ed
commit: 088ff1f7cc255f6cef6bbe6bdeac7bef64d76ba5 [329/442] KVM: Extend the memslot to support fd-based private memory
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/virt/kvm/api.rst:1364: WARNING: Inline emphasis start-string without end-string.

vim +1364 Documentation/virt/kvm/api.rst

088ff1f7cc255f Documentation/virt/kvm/api.rst    Chao Peng      2021-11-15  1363  
0f2d8f4dd0663d Documentation/kvm/api.txt         Avi Kivity     2010-03-25 @1364    /* for kvm_memory_region::flags */
4d8b81abc47b83 Documentation/virtual/kvm/api.txt Xiao Guangrong 2012-08-21  1365    #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
4d8b81abc47b83 Documentation/virtual/kvm/api.txt Xiao Guangrong 2012-08-21  1366    #define KVM_MEM_READONLY	(1UL << 1)
088ff1f7cc255f Documentation/virt/kvm/api.rst    Chao Peng      2021-11-15  1367    #define KVM_MEM_PRIVATE		(1UL << 2)
0f2d8f4dd0663d Documentation/kvm/api.txt         Avi Kivity     2010-03-25  1368  

:::::: The code at line 1364 was first introduced by commit
:::::: 0f2d8f4dd0663defff8c1738d33478c1fb65a4f5 KVM: Document KVM_SET_USER_MEMORY_REGION

:::::: TO: Avi Kivity <avi@redhat.com>
:::::: CC: Avi Kivity <avi@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
