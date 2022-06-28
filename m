Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB855F1C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiF1XJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiF1XJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:09:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CC3369C4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656457796; x=1687993796;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wUj6mi1i6Mz/4b+vZQugUFHfysI4IESJ2PixHryeAeU=;
  b=B0zdXFsxm21GEjx5vaHsZ9FkPwmna9h7kmj0GafmcvcANehqIE+v3oE9
   j85lR9CsHIRwAvRvlffjCxeJmhRk7RLiy0O5Wy3V8xtnxIeIASpkI7Vwr
   akokzJcgCY3a9j0uMJrzGuLqRioDNKOnkYGjuVgUU3feei2qBMBWCDXFm
   epSx8W9LqNCejhCJHeM36Hmjb84S9u6PJtxs2aZp3E8R6dwxDX/i25b39
   5cd23TcMZtxAY+6Cd9hmmFGrXLebUw2tmNNlA8HNQNUfJlZ8wTzKuINim
   cXo55v9KTXNL7a4yNfcfwoseIP30Zk0yE/QuARTTHp0CpaVRUsYBKbkEa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270634542"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="270634542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 16:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="732941827"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jun 2022 16:09:39 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6KKw-000Aj8-SK;
        Tue, 28 Jun 2022 23:09:38 +0000
Date:   Wed, 29 Jun 2022 07:08:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Moti Haimovski <mhaimovski@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:gaudi2 60/61]
 drivers/misc/habanalabs/common/mmu/mmu.c:998:19: sparse: sparse: non
 size-preserving integer to pointer cast
Message-ID: <202206290743.xHHvh1c5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git gaudi2
head:   f645d04ce63b73c46a8839a621e34a28f1b2a7ba
commit: 374bb7eeacb91bc4e53fc429c17d1d55c0e1fc6b [60/61] habanalabs: add gaudi2 MMU support
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220629/202206290743.xHHvh1c5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=374bb7eeacb91bc4e53fc429c17d1d55c0e1fc6b
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay gaudi2
        git checkout 374bb7eeacb91bc4e53fc429c17d1d55c0e1fc6b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/misc/habanalabs/common/mmu/mmu.c:998:19: sparse: sparse: non size-preserving integer to pointer cast

vim +998 drivers/misc/habanalabs/common/mmu/mmu.c

   980	
   981	/**
   982	 * hl_mmu_hr_write_pte() - write HR PTE
   983	 * @ctx: pointer to the context structure
   984	 * @pgt_info: HOP's page table info structure
   985	 * @phys_pte_addr: phys PTE address
   986	 * @val: raw PTE data
   987	 * @hop_table_size: HOP table size
   988	 */
   989	void hl_mmu_hr_write_pte(struct hl_ctx *ctx, struct pgt_info *pgt_info, u64 phys_pte_addr,
   990									u64 val, u32 hop_table_size)
   991	{
   992		/*
   993		 * The value to write is the phys address of the next hop +
   994		 * flags at the 12 LSBs.
   995		 */
   996		u64 virt_addr = hl_mmu_hr_pte_phys_to_virt(ctx, pgt_info, phys_pte_addr, hop_table_size);
   997	
 > 998		*((u64 *) virt_addr) = val;
   999	}
  1000	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
