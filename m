Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8484851E1F4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444886AbiEFXGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442188AbiEFXGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:06:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A82CCBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651878152; x=1683414152;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gig5j/5iJoeVy/71WLoNiigdO1vKZfgbUOF4HqFLBr0=;
  b=hoYT82cXETkj9W6x7bcfXXK77g7VBgKska0uUnpT04kYxfMQWJ213YB9
   qk4BgTZ/VDBX2zMspaAMPyIxILCr/3Dc+/223mY85vr3hoiuImIoGpOB9
   42Gmb8CRscWptO9vgKCFLGm797GjwtlklFH9DzGpTYvKrkqGxacMwg3D4
   kHFUhUDBMPdK49oDWg0JY8NITOtUgXsxiz81ZP0bG7DbCU7uF07whmyCK
   wdJuzc6BTZXVfh6C1XQaGSXc1uUqaNl+SS9khomGG5XnlxUzHGPoVym5b
   k9k/OfLoG/DZenn8kebi+f2IyfPm2jGDROClpCj2OmQteOjQWjkF7LK1c
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="331588160"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="331588160"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 16:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="600761018"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2022 16:02:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn6xx-000Dzk-Qo;
        Fri, 06 May 2022 23:02:29 +0000
Date:   Sat, 7 May 2022 07:01:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 186/361]
 arch/x86/virt/vmx/tdx/seamcall.S:53: Error: invalid character '(' in
 mnemonic
Message-ID: <202205070603.bsmYiwOS-lkp@intel.com>
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
commit: b4cfd2e1b4daf91899a95ab3e2a4e2ea1d25773c [186/361] KVM: TDX: Add C wrapper functions for SEAMCALLs to the TDX module
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220507/202205070603.bsmYiwOS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/b4cfd2e1b4daf91899a95ab3e2a4e2ea1d25773c
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout b4cfd2e1b4daf91899a95ab3e2a4e2ea1d25773c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the intel-tdx/kvm-upstream-workaround HEAD 3b5b338cdf10dca7a2435d1f86b2dd9f1a3ad833 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   arch/x86/virt/vmx/tdx/seamcall.S: Assembler messages:
>> arch/x86/virt/vmx/tdx/seamcall.S:53: Error: invalid character '(' in mnemonic


vim +53 arch/x86/virt/vmx/tdx/seamcall.S

     6	
     7	/*
     8	 * __seamcall()  - Host-side interface functions to SEAM software module
     9	 *		   (the P-SEAMLDR or the TDX module)
    10	 *
    11	 * Transform function call register arguments into the SEAMCALL register
    12	 * ABI.  Return TDX_SEAMCALL_VMFAILINVALID, or the completion status of
    13	 * the SEAMCALL.  Additional output operands are saved in @out (if it is
    14	 * provided by caller).
    15	 *
    16	 *-------------------------------------------------------------------------
    17	 * SEAMCALL ABI:
    18	 *-------------------------------------------------------------------------
    19	 * Input Registers:
    20	 *
    21	 * RAX                 - SEAMCALL Leaf number.
    22	 * RCX,RDX,R8-R9       - SEAMCALL Leaf specific input registers.
    23	 *
    24	 * Output Registers:
    25	 *
    26	 * RAX                 - SEAMCALL completion status code.
    27	 * RCX,RDX,R8-R11      - SEAMCALL Leaf specific output registers.
    28	 *
    29	 *-------------------------------------------------------------------------
    30	 *
    31	 * __seamcall() function ABI:
    32	 *
    33	 * @fn  (RDI)          - SEAMCALL Leaf number, moved to RAX
    34	 * @rcx (RSI)          - Input parameter 1, moved to RCX
    35	 * @rdx (RDX)          - Input parameter 2, moved to RDX
    36	 * @r8  (RCX)          - Input parameter 3, moved to R8
    37	 * @r9  (R8)           - Input parameter 4, moved to R9
    38	 *
    39	 * @out (R9)           - struct tdx_module_output pointer
    40	 *                       stored temporarily in R12 (not
    41	 *                       used by the P-SEAMLDR or the TDX
    42	 *			 module). It can be NULL.
    43	 *
    44	 * Return (via RAX) the completion status of the SEAMCALL, or
    45	 * TDX_SEAMCALL_VMFAILINVALID.
    46	 */
    47	SYM_FUNC_START(__seamcall)
    48		FRAME_BEGIN
    49		TDX_MODULE_CALL host=1
    50		FRAME_END
    51		ret
    52	SYM_FUNC_END(__seamcall)
  > 53	EXPORT_SYMBOL_GPL(__seamcall)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
