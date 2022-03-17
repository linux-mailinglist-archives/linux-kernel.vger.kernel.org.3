Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5584DBC01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346087AbiCQBC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344149AbiCQBCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:02:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B562813E31
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647478894; x=1679014894;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VQiljhJlY4NEbWUPcQrjbccYAUjqmZ4+gjB8oLUvsMI=;
  b=mvlwQLpP8Jx57wIXcBlGShcd0L+5GpJoQ2Y6UanQsUfOQTutEv+A1uqn
   x4FEcIQ2hrWvoS1WiKV/dFJp78cL++jwBmlWC46gCopE2feXSzpRrCMB5
   yYx2YIKtVESBNO2J1bWR6R954Q5+txrObf4jrWtghmJ60IDJDyashIm7/
   HgH4CEIVh2ssZo/i4lrdAmaPih8wgOKemPdBSqLWOsuYIM+5/vMEmRKpS
   YWDpc7M0oCTFTWCVf2o1r4EaZZMzMoriKhqH/FfE/YgYJRGPUnvZQl6VD
   yC/dSJnzghxxebNjiJuxlcw6i2FPUvACVY7D0WTpGxZCfyxe9oF03Nzi4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255582021"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="255582021"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 18:01:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="541165282"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.248]) ([10.255.28.248])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 18:01:30 -0700
Subject: Re: [kbuild-all] Re: arch/powerpc/mm/nohash/fsl_book3e.c:61:3:
 sparse: sparse: symbol 'tlbcam_addrs' was not declared. Should it be static?
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202203140259.PkwZKhTz-lkp@intel.com>
 <d457d752-1c31-7b3f-81c9-2ff2bc474ddd@csgroup.eu>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <460360f7-6dc5-f5f5-8f55-a3ee8aaf0ec4@intel.com>
Date:   Thu, 17 Mar 2022 09:01:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d457d752-1c31-7b3f-81c9-2ff2bc474ddd@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/2022 2:49 AM, Christophe Leroy wrote:
> 
> 
> Le 13/03/2022 à 19:29, kernel test robot a écrit :
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   aad611a868d16cdc16a7d4a764cef955293e47e3
>> commit: 44c14509b0dabb909ad1ec28800893ea71762732 powerpc/fsl_booke: Fix setting of exec flag when setting TLBCAMs
> 
> This problem as likely always existed. There is absolutely no link with
> the above commit.

Hi Christophe,

Thanks for the feedback, we checked the build results of commit 44c14509
and parent commit, the commit 44c14509 fixed a issue which triggered
sparse worked on fsl_book3e.c, so you are right, it's not related to the
above commit.

Best Regards,
Rong Chen

> 
>> date:   5 months ago
>> config: powerpc-randconfig-s031-20220313 (https://download.01.org/0day-ci/archive/20220314/202203140259.PkwZKhTz-lkp@intel.com/config)
>> compiler: powerpc-linux-gcc (GCC) 11.2.0
>> reproduce:
>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>           chmod +x ~/bin/make.cross
>>           # apt-get install sparse
>>           # sparse version: v0.6.4-dirty
>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44c14509b0dabb909ad1ec28800893ea71762732
>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>           git fetch --no-tags linus master
>>           git checkout 44c14509b0dabb909ad1ec28800893ea71762732
>>           # save the config file to linux build tree
>>           mkdir build_dir
>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/nohash/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>>> arch/powerpc/mm/nohash/fsl_book3e.c:61:3: sparse: sparse: symbol 'tlbcam_addrs' was not declared. Should it be static?
>>      arch/powerpc/mm/nohash/fsl_book3e.c:63:15: sparse: sparse: symbol 'tlbcam_sz' was not declared. Should it be static?
>>>> arch/powerpc/mm/nohash/fsl_book3e.c:277:30: sparse: sparse: Using plain integer as NULL pointer
>>
>> vim +/tlbcam_addrs +61 arch/powerpc/mm/nohash/fsl_book3e.c
>>
>> 14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  53
>> 78f622377f7d31 arch/powerpc/mm/fsl_booke_mmu.c Kumar Gala     2010-05-13  54  #define NUM_TLBCAMS	(64)
>> 78f622377f7d31 arch/powerpc/mm/fsl_booke_mmu.c Kumar Gala     2010-05-13 @55  struct tlbcam TLBCAM[NUM_TLBCAMS];
>> 14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  56
>> 14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  57  struct tlbcamrange {
>> 14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  58  	unsigned long start;
>> 14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  59  	unsigned long limit;
>> 14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  60  	phys_addr_t phys;
>> 14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26 @61  } tlbcam_addrs[NUM_TLBCAMS];
>> 14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  62
>>
>> :::::: The code at line 61 was first introduced by commit
>> :::::: 14cf11af6cf608eb8c23e989ddb17a715ddce109 powerpc: Merge enough to start building in arch/powerpc.
>>
>> :::::: TO: Paul Mackerras <paulus@samba.org>
>> :::::: CC: Paul Mackerras <paulus@samba.org>
>>
>> ---
>> 0-DAY CI Kernel Test Service
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
