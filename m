Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3752E7BD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347189AbiETIio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344658AbiETIie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:38:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D03B9CF59;
        Fri, 20 May 2022 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653035912; x=1684571912;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rcWAqUmkaH3YekMgB1Mnm+5TYdr78RHJ0s3k6It8HII=;
  b=JgXhF/wCbuw2w5CKm754mh/3VtOzB0PmytXN2O9oDm0hRA0U6/dDG+Ax
   t4Z213uSmovOnch4+Se5zw8Jn/CU06RyW0rvjiI2MZkj5vFSMsHjVd+4Q
   c8ysu2psKpfb+TKpb7Gm6TsV9j5G97z+ck9LsbrCig0koL7cVuEJXyKqx
   7pk0p+HxVtT+9mTwECqSV1/pO2PLDC//R4yAKaGzFu6UpQX3xvURyvxaS
   7YXuF0kMv/2nN7dvq/7G7kfZZ671YNYDHG0wAKDuV0mubqp/6DsaWrdwW
   pvWkMZLZwDgjduIVeRgg97wNmJLDjFSFyelYFieRhK6byl1RQLBJW3bCV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272668270"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272668270"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 01:38:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="570705930"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.242]) ([10.255.28.242])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 01:38:28 -0700
Subject: Re: [kbuild-all] Re: arch/mips/include/asm/checksum.h:195:9: error:
 unsupported inline asm: input with type 'unsigned long' matching output with
 type '__wsum' (aka 'unsigned int')
To:     Paul Cercueil <paul@crapouillou.net>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips <linux-mips@vger.kernel.org>
References: <202205200128.layu7VXF-lkp@intel.com>
 <OB55CR.QAT1J8A48BK21@crapouillou.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <0b98eb74-5a70-7170-72ab-517e3df4b202@intel.com>
Date:   Fri, 20 May 2022 16:38:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <OB55CR.QAT1J8A48BK21@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/2022 1:45 AM, Paul Cercueil wrote:
> Hi Bot,
> 
> Le ven., mai 20 2022 at 01:23:43 +0800, kernel test robot 
> <lkp@intel.com> a écrit :
>> tree: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   f993aed406eaf968ba3867a76bb46c95336a33d0
>> commit: c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 MIPS: Kconfig: add 
>> MIPS_GENERIC_KERNEL symbol
> 
> I have no idea how that error could be even remotely related to the 
> commit above.

Hi Paul,

Sorry for the inconvience, the error is not introduced by the commit,
it's only bisected to it after kconfig changed.

Best Regards,
Rong Chen

> 
> About the real issue: Maybe the last "addu" in csum_tcpudp_nofold() 
> should be a "daddu"?
> 
> Cheers,
> -Paul
> 
>> date:   1 year, 8 months ago
>> config: mips-randconfig-r036-20220519 
>> (https://download.01.org/0day-ci/archive/20220520/202205200128.layu7VXF-lkp@intel.com/config) 
>>
>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 
>> e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
>> reproduce (this is a W=1 build):
>>         wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install mips cross compiling tool for clang build
>>         # apt-get install binutils-mips-linux-gnu
>>         # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 
>>
>>         git remote add linus 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 
>> O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/cavium-octeon/ 
>> drivers/dma-buf/heaps/ net/ipv6/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>    In file included from arch/mips/cavium-octeon/octeon-platform.c:10:
>>    In file included from include/linux/etherdevice.h:20:
>>    In file included from include/linux/if_ether.h:19:
>>    In file included from include/linux/skbuff.h:28:
>>    In file included from include/net/checksum.h:22:
>>>>  arch/mips/include/asm/checksum.h:195:9: error: unsupported inline 
>>>> asm: input with type 'unsigned long' matching output with type 
>>>> '__wsum' (aka 'unsigned int')
>>            : "0" ((__force unsigned long)daddr),
>>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    In file included from arch/mips/cavium-octeon/octeon-platform.c:15:
>>    In file included from arch/mips/include/asm/octeon/octeon.h:11:
>>    In file included from arch/mips/include/asm/octeon/cvmx.h:72:
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:323:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NULL)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:323:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:324:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_SIM)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:324:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:325:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBT3000)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:325:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:326:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_KODAMA)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:326:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:327:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NIAGARA)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:327:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:328:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NAC38)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:328:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:329:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_THUNDER)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:329:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:330:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_TRANTOR)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:330:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:331:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH3000)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:331:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:332:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH3100)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>> -- 
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:397:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>> ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:397:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:398:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E100)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:398:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:399:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_DSR1000N)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:399:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:400:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_KONTRON_S1901)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:400:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:401:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>> ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:401:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:412:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_NULL)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:412:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:413:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_SIM_TYPE_DEPRECATED)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:413:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:414:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_OCTEON_SAMPLE)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:414:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:415:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_MAX)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:415:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                              ^
>>    arch/mips/cavium-octeon/smp.c:99:6: warning: no previous prototype 
>> for function 'octeon_send_ipi_single' [-Wmissing-prototypes]
>>    void octeon_send_ipi_single(int cpu, unsigned int action)
>>         ^
>>    arch/mips/cavium-octeon/smp.c:99:1: note: declare 'static' if the 
>> function is not intended to be used outside of this translation unit
>>    void octeon_send_ipi_single(int cpu, unsigned int action)
>>    ^
>>    static
>>>>  arch/mips/cavium-octeon/smp.c:194:5: warning: no previous prototype 
>>>> for function 'plat_post_relocation' [-Wmissing-prototypes]
>>    int plat_post_relocation(long offset)
>>        ^
>>    arch/mips/cavium-octeon/smp.c:194:1: note: declare 'static' if the 
>> function is not intended to be used outside of this translation unit
>>    int plat_post_relocation(long offset)
>>    ^
>>    static
>>    81 warnings generated.
>>    Assembler messages:
>>    Warning: a different -march was already specified, is now octeon
>> -- 
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:394:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:397:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>> ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:397:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:398:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E100)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:398:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:399:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_DSR1000N)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:399:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:400:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_KONTRON_S1901)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:400:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:401:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>> ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:401:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note: expanded 
>> from macro 'ENUM_BRD_TYPE_CASE'
>>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:412:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_NULL)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:412:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:413:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_SIM_TYPE_DEPRECATED)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:413:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:414:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_OCTEON_SAMPLE)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:414:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                              ^
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:415:3: warning: adding 
>> 'int' to a string does not append to the string [-Wstring-plus-int]
>>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_MAX)
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                           ~~~^~~~
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:415:3: note: use array 
>> indexing to silence this warning
>>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note: expanded 
>> from macro 'ENUM_CHIP_TYPE_CASE'
>>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>>                              ^
>>    In file included from arch/mips/cavium-octeon/crypto/octeon-sha1.c:23:
>>    In file included from include/crypto/internal/hash.h:11:
>>    In file included from include/crypto/algapi.h:13:
>>    In file included from include/linux/skbuff.h:28:
>>    In file included from include/net/checksum.h:22:
>>>>  arch/mips/include/asm/checksum.h:195:9: error: unsupported inline 
>>>> asm: input with type 'unsigned long' matching output with type 
>>>> '__wsum' (aka 'unsigned int')
>>            : "0" ((__force unsigned long)daddr),
>>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    79 warnings and 1 error generated.
>> ..
>>
>>
>> vim +195 arch/mips/include/asm/checksum.h
>>
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  162
>> 01cfbad79a5e2b arch/mips/include/asm/checksum.h Alexander Duyck 
>> 2016-03-11  163  static inline __wsum csum_tcpudp_nofold(__be32 saddr, 
>> __be32 daddr,
>> 01cfbad79a5e2b arch/mips/include/asm/checksum.h Alexander Duyck 
>> 2016-03-11  164                      __u32 len, __u8 proto,
>> 8e3d8433d8c22c include/asm-mips/checksum.h      Al Viro 2006-11-14  
>> 165                      __wsum sum)
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  166  {
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  167      __asm__(
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  168      "    .set    push        # csum_tcpudp_nofold\n"
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  169      "    .set    noat        \n"
>> 875d43e72b5bf2 include/asm-mips/checksum.h      Ralf Baechle 
>> 2005-09-03  170  #ifdef CONFIG_32BIT
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  171      "    addu    %0, %2        \n"
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  172      "    sltu    $1, %0, %2    \n"
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  173      "    addu    %0, $1        \n"
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  174
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  175      "    addu    %0, %3        \n"
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  176      "    sltu    $1, %0, %3    \n"
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  177      "    addu    %0, $1        \n"
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  178
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  179      "    addu    %0, %4        \n"
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  180      "    sltu    $1, %0, %4    \n"
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  181      "    addu    %0, $1        \n"
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  182  #endif
>> 875d43e72b5bf2 include/asm-mips/checksum.h      Ralf Baechle 
>> 2005-09-03  183  #ifdef CONFIG_64BIT
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  184      "    daddu    %0, %2        \n"
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  185      "    daddu    %0, %3        \n"
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  186      "    daddu    %0, %4        \n"
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  187      "    dsll32    $1, %0, 0    \n"
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  188      "    daddu    %0, $1        \n"
>> 66fd848cadaa6b arch/mips/include/asm/checksum.h Ralf Baechle 
>> 2017-01-26  189      "    sltu    $1, %0, $1    \n"
>> e97288386a316e include/asm-mips/checksum.h      Ralf Baechle 
>> 2005-09-20  190      "    dsra32    %0, %0, 0    \n"
>> 66fd848cadaa6b arch/mips/include/asm/checksum.h Ralf Baechle 
>> 2017-01-26  191      "    addu    %0, $1        \n"
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  192  #endif
>> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer 
>> 2005-07-08  193      "    .set    pop"
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  194      : "=r" (sum)
>> 66218da212bf14 include/asm-mips/checksum.h      Atsushi Nemoto 
>> 2007-01-24 @195      : "0" ((__force unsigned long)daddr),
>> 66218da212bf14 include/asm-mips/checksum.h      Atsushi Nemoto 
>> 2007-01-24  196        "r" ((__force unsigned long)saddr),
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  197  #ifdef __MIPSEL__
>> 8e3d8433d8c22c include/asm-mips/checksum.h      Al Viro 2006-11-14  
>> 198        "r" ((proto + len) << 8),
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  199  #else
>> 8e3d8433d8c22c include/asm-mips/checksum.h      Al Viro 2006-11-14  
>> 200        "r" (proto + len),
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  201  #endif
>> 1d464c26b56252 include/asm-mips/checksum.h      Dave Johnson 
>> 2007-04-18  202        "r" ((__force unsigned long)sum));
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  203
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  204      return sum;
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  205  }
>> b4b5015a1c1450 arch/mips/include/asm/checksum.h Ralf Baechle 
>> 2014-12-17  206  #define csum_tcpudp_nofold csum_tcpudp_nofold
>> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds 
>> 2005-04-16  207
>>
>> :::::: The code at line 195 was first introduced by commit
>> :::::: 66218da212bf141532d678a699f5789c78145ab1 [MIPS] Fix wrong 
>> checksum calculation on 64-bit MIPS
>>
>> :::::: TO: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
> 
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
