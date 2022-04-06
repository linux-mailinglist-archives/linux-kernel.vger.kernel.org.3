Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1324F6328
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiDFP2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbiDFP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:28:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA3855B5E4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649248070; x=1680784070;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mhFf4MzmEvEBuBGPHkwVC+jjG9nj2neUKRDHonPyJwc=;
  b=jnNpAtdv0vkU9bcXGHD5O/puHak6+NB6IAgbYZSow40ddNnrLFTiz6Jg
   GyVHiUAYWliLXtPwwNcrkxXioxxtp/U9FWh2fMStpiBiB83A5x4akhAdf
   2Ouce+gTLjfXWw3BtK8/t8NYm468l5fH9/HfI0iOq+VpqYkhvLvIH1POv
   OVJPzq1HEDfmMEDZP4RAfvnzxKPutClZo5MBW3s+EVYRXWyzMJiln8dDn
   BGy8jgJUu3lFcGY6jLvvx1ARVpjmHeRHT16wN6fX6we+qSNYvNI/abi4g
   wmifHM3xlvv4ufqexp9rXVyU80lU5DhJybqGGohFPcsgqluvEpwlALRq8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260730212"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="260730212"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 05:27:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="570491704"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.173.64]) ([10.249.173.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 05:27:33 -0700
Subject: Re: [kbuild-all] Re: drivers/cpuidle/cpuidle-riscv-sbi.c:79:16:
 error: variable has incomplete type 'struct sbiret'
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
References: <202204051441.dQ4w35Ga-lkp@intel.com>
 <019baa48-a594-ba00-67a9-b0eb62b32ac0@infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <fbd31f81-9c83-0e0b-38ba-a42ed1e49ec4@intel.com>
Date:   Wed, 6 Apr 2022 20:27:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <019baa48-a594-ba00-67a9-b0eb62b32ac0@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/2022 2:26 AM, Randy Dunlap wrote:
> Hi,
> 
> On 4/4/22 23:11, kernel test robot wrote:
>> Hi Anup,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   3123109284176b1532874591f7c81f3837bbdc17
>> commit: c5179ef1ca0c39dab6955be6b0e3c034cc4164c8 RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
>> date:   4 weeks ago
>> config: riscv-randconfig-r022-20220405 (https://download.01.org/0day-ci/archive/20220405/202204051441.dQ4w35Ga-lkp@intel.com/config)
>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install riscv cross compiling tool for clang build
>>          # apt-get install binutils-riscv64-linux-gnu
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c5179ef1ca0c39dab6955be6b0e3c034cc4164c8
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout c5179ef1ca0c39dab6955be6b0e3c034cc4164c8
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
> 
> [delete many build warnings and errors]
> 
>>     3 warnings and 17 errors generated.
>>
>> Kconfig warnings: (for reference only)
>>     WARNING: unmet direct dependencies detected for RISCV_SBI_CPUIDLE
>>     Depends on CPU_IDLE && RISCV && RISCV_SBI
>>     Selected by
>>     - SOC_VIRT && CPU_IDLE
> 
> This Kconfig warning is the root of the problem. All of the build errors
> and warnings can be fixed by something like so. Is it OK?
> 
> ---
>   arch/riscv/Kconfig.socs |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20220404.orig/arch/riscv/Kconfig.socs
> +++ linux-next-20220404/arch/riscv/Kconfig.socs
> @@ -38,7 +38,7 @@ config SOC_VIRT
>   	select SIFIVE_PLIC
>   	select PM_GENERIC_DOMAINS if PM
>   	select PM_GENERIC_DOMAINS_OF if PM && OF
> -	select RISCV_SBI_CPUIDLE if CPU_IDLE
> +	select RISCV_SBI_CPUIDLE if CPU_IDLE && RISCV_SBI
>   	help
>   	  This enables support for QEMU Virt Machine.
>   
> [snip]
> 
> Also, to the @bot:
> 
> Why does the reported Kconfig warning look like it was generated
> by some older kconfig software?  Current Kconfig reports more info:

Hi Randy,

The contents were from a special method, not from the output directly,
I will take a look to keep the same with below results.

Best Regards,
Rong Chen

> 
> WARNING: unmet direct dependencies detected for RISCV_SBI_CPUIDLE
>    Depends on [n]: CPU_IDLE [=y] && RISCV [=y] && RISCV_SBI [=n]
>    Selected by [y]:
>    - SOC_VIRT [=y] && CPU_IDLE [=y]
> 
> Thanks.
>>
>> :::::: The code at line 79 was first introduced by commit
>> :::::: 6abf32f1d9c5009dcccded2c1e7ca899a4ab587b cpuidle: Add RISC-V SBI CPU idle driver
>>
>> :::::: TO: Anup Patel <anup.patel@wdc.com>
>> :::::: CC: Palmer Dabbelt <palmer@rivosinc.com>
>>
> 
