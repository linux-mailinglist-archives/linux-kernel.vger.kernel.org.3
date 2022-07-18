Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE335782FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiGRNBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbiGRNBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:01:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD56A478
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658149301; x=1689685301;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GuNv+WERZ4OKRmzqbudfzOIipBdBgrjjAczL0729xSY=;
  b=Z48mXeXl9XCEKqMCx289yQUWHGNn/ymKTMZ9kgpfnXuTz17qyMq9Xuzp
   YgkayDUiDo6b0mJMjSz25slj9jcCi5/Z04/yLfjlSHm7gCC01jsfDk6JZ
   3VE2BP1qSOVqMZWRKEBi4hFA3DBOvO2QdbPS6ipD0P5as4e9l3P1bsU1D
   5vd9aqQ3bZTNawdOsa+tiJZFLMUlmZGepmnN2nG/FST5AOqmFCF8+8BFv
   aqSOI88NW7eI+WLpQMH19HZtN7DgMWdzsB0d1QMg+RyiijW6hsQJq0Zw9
   KiuYOlyjUf5euLTQ/Pkgb64PYSk0cqvYHmiM9RX5gJML3gs7aQSIqI5O/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="266617077"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="266617077"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 06:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="924331879"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jul 2022 06:01:39 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDQNX-0004MU-ED;
        Mon, 18 Jul 2022 13:01:39 +0000
Date:   Mon, 18 Jul 2022 21:00:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 34/37] arch/riscv/kvm/aia.c:262:2-3:
 Unneeded semicolon
Message-ID: <202207182011.MK0xctHH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   c69e408948f99c2a874b010718a0fca5128db40f
commit: e264b8eb44a5f87ae3ba3624ca8343918f70e396 [34/37] RISC-V: KVM: Virtualize per-HART AIA CSRs
config: riscv-randconfig-c034-20220717 (https://download.01.org/0day-ci/archive/20220718/202207182011.MK0xctHH-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/riscv/kvm/aia.c:262:2-3: Unneeded semicolon
   arch/riscv/kvm/aia.c:295:2-3: Unneeded semicolon
   arch/riscv/kvm/aia.c:321:2-3: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
