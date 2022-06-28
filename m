Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA455D4A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbiF1IdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343522AbiF1IdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:33:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B94A2BB2F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656405198; x=1687941198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ff2L2IophYDl1rpQ/eTlmzuxptC9ABgNDsjlOKelJ/8=;
  b=l273kgR+vtV+dtdzZQ4k5db3UwMNHFDowQMuiC2hP2AOCgJv6YAx2uh0
   3XBah7g3nY6sOOcg/gZfcQNiCsXpKprgD8BVcntvDBeTyt3z3AZZCjiDD
   QaqKobUB9wpHe9YejecsJ/KMSnvPCU7cRQ3Ze3Y0lI4LBIu+Dwf71bbE8
   y1yP13BS50xaYmbeCHsArWcQ80kQsYYxpVYWdXeO9gLzV7bcNeLwZvUBh
   P2tJgRuB/aDMYNx+Y8VIh0UQSyOgfpRZloQg8t9YM5WuHI62pK3lck9fJ
   xpqtWjBqcxa3fyrwXF3MDgtDHtlMeIjoEWiSSmWYSEF0cjWo9a9Oi3gVk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345673022"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="345673022"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:33:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="540413916"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2022 01:33:16 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o66eq-0009lQ-1P;
        Tue, 28 Jun 2022 08:33:16 +0000
Date:   Tue, 28 Jun 2022 16:32:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Moti Haimovski <mhaimovski@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:gaudi2 59/61] drivers/misc/habanalabs/common/mmu/mmu.c:785:
 Error: unrecognized opcode `mfence'
Message-ID: <202206281642.qItsyHKa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git gaudi2
head:   a76819ab38942fcb341142a55e9dc81f3eaf08e3
commit: 950d1a3888fe751fb5b2e51a44ebf89d963fdde5 [59/61] habanalabs: add gaudi2 MMU support
config: riscv-randconfig-c023-20220627 (https://download.01.org/0day-ci/archive/20220628/202206281642.qItsyHKa-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=950d1a3888fe751fb5b2e51a44ebf89d963fdde5
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay gaudi2
        git checkout 950d1a3888fe751fb5b2e51a44ebf89d963fdde5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/misc/habanalabs/common/mmu/mmu.c: Assembler messages:
>> drivers/misc/habanalabs/common/mmu/mmu.c:785: Error: unrecognized opcode `mfence'


vim +785 drivers/misc/habanalabs/common/mmu/mmu.c

   780	
   781	void hl_mmu_hr_flush(struct hl_ctx *ctx)
   782	{
   783		/* a flush operation requires memory barrier */
   784		mb();
 > 785		asm volatile ("mfence" : : : "memory");
   786	}
   787	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
