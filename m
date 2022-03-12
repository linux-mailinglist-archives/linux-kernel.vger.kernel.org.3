Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBBE4D6D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 08:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiCLHE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 02:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiCLHEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 02:04:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A3C16A5A9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 23:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647068597; x=1678604597;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mq+yxatIfFg6Adkr4V+wz6SUO06zkgbVREe2zAP6jdk=;
  b=KiC2xnsjz/m9GGa/q/rdDv3G/nX+6p0bxUiesoMxvopU1YkrD3c2zyvY
   XUV3DzNK0OY+Ip9JdpgZer0mf5DQrTSququgcKLJZ/dwrdeh3XDMVa3v6
   t7xJ5KR/F+91ZD5FkdkbwG116691KlL2r/LKygptCj0/EsBni78uD0d8/
   ro0atT0BJiVwrRBGNePuZvZAlUY0MsaDDX84mNnaMIlalHa4bPggHDa2D
   eeysbJw6HBhVtrwkaTSCBl4Rz22TFrTs55wWcBMsF4TyaXdZA0lF0Nc4j
   VccBcRXRAh8HpoFCUhET6gJ0DABytSGoMc+IY/g1lypdRKKY97cLh2KFJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255717228"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255717228"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 23:03:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="514804860"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2022 23:03:14 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSvmU-0007eC-8J; Sat, 12 Mar 2022 07:03:14 +0000
Date:   Sat, 12 Mar 2022 15:02:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Chao Gao <chao.gao@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yuan Yao <yuan.yao@intel.com>
Subject: [intel-tdx:kvm 114/195] arch/x86/kvm/vmx/common.h: tdx.h is included
 more than once.
Message-ID: <202203121540.sZcSHg7j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm
head:   2329ab1a0d8e32cf28b08c635c051738d12301c3
commit: bd8051a37f63f4840847dd4577034413ed48585a [114/195] KVM: TDX: Add "basic" support for building and running Trust Domains
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/x86/kvm/vmx/common.h: tdx.h is included more than once.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
