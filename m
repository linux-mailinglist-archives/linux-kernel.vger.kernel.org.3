Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BE7487B74
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348585AbiAGRcD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jan 2022 12:32:03 -0500
Received: from aposti.net ([89.234.176.197]:46346 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237699AbiAGRcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:32:02 -0500
Date:   Fri, 07 Jan 2022 17:31:52 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: decompress.c:(.text.FSE_buildDTable_internal+0x2cc): undefined
 reference to `__clzdi2'
To:     Nick Terrell <terrelln@fb.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BROADCOM NVRAM DRIVER <linux-mips@vger.kernel.org>
Message-Id: <4POC5R.OFCAH4UODPNE2@crapouillou.net>
In-Reply-To: <AAD37797-0EC4-47FC-939E-F855F2E9954C@fb.com>
References: <202201060233.mO6P39bM-lkp@intel.com>
        <AAD37797-0EC4-47FC-939E-F855F2E9954C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Le mer., janv. 5 2022 at 20:18:27 +0000, Nick Terrell <terrelln@fb.com> 
a écrit :
> 
> 
>>  On Jan 5, 2022, at 11:02 AM, kernel test robot <lkp@intel.com> 
>> wrote:
>> 
>>  tree:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>> master
>>  head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
>>  commit: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade 
>> to latest upstream zstd version 1.4.10
>>  date:   8 weeks ago
>>  config: mips-randconfig-r025-20220105 
>> (https://download.01.org/0day-ci/archive/20220106/202201060233.mO6P39bM-lkp@intel.com/config 
>> )
>>  compiler: mips64el-linux-gcc (GCC) 11.2.0
>>  reproduce (this is a W=1 build):
>>         wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>>  -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0c1b49f5b674cca7b10549c53b3791d0bbc90a8
>>         git remote add linus 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout e0c1b49f5b674cca7b10549c53b3791d0bbc90a8
>>         # save the config file to linux build tree
>>         mkdir build_dir
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 
>> make.cross O=build_dir ARCH=mips SHELL=/bin/bash
>> 
>>  If you fix the issue, kindly add following tag as appropriate
>>  Reported-by: kernel test robot <lkp@intel.com>
>> 
>>  All errors (new ones prefixed by >>):
>> 
>>    mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in 
>> function `FSE_buildDTable_internal':
>>>>  decompress.c:(.text.FSE_buildDTable_internal+0x2cc): undefined 
>>>> reference to `__clzdi2'
>>    mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in 
>> function `BIT_initDStream':
>>    decompress.c:(.text.BIT_initDStream+0x7c): undefined reference to 
>> `__clzdi2'
>>    mips64el-linux-ld: decompress.c:(.text.BIT_initDStream+0x158): 
>> undefined reference to `__clzdi2'
>>    mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in 
>> function `ZSTD_buildFSETable_body_default.constprop.0':
>>>>  
>>>> decompress.c:(.text.ZSTD_buildFSETable_body_default.constprop.0+0x2a8): 
>>>> undefined reference to `__clzdi2'
>>    mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in 
>> function `FSE_readNCount_body_default':
>>>>  decompress.c:(.text.FSE_readNCount_body_default+0x130): undefined 
>>>> reference to `__ctzdi2'
>>>>  mips64el-linux-ld: 
>>>> decompress.c:(.text.FSE_readNCount_body_default+0x1a4): undefined 
>>>> reference to `__ctzdi2'
>>>>  mips64el-linux-ld: 
>>>> decompress.c:(.text.FSE_readNCount_body_default+0x2e4): undefined 
>>>> reference to `__clzdi2'
>>    mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in 
>> function `HUF_readStats_body_default':
>>>>  decompress.c:(.text.HUF_readStats_body_default+0x184): undefined 
>>>> reference to `__clzdi2'
>>>>  mips64el-linux-ld: 
>>>> decompress.c:(.text.HUF_readStats_body_default+0x1b4): undefined 
>>>> reference to `__clzdi2'
>>    mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in 
>> function `ZSTD_DCtx_getParameter':
>>>>  decompress.c:(.text.ZSTD_DCtx_getParameter+0x60): undefined 
>>>> reference to `__clzdi2'
> 
> These are complaining about usage of __builtin_c{l,t}z(). The code 
> before this change also used
> __builtin_clz(), so this isn't new. E.g. the call in 
> BIT_initDStream() is present before the change,
> it just moved locations. So these errors aren't new.
> 
> This is breaking the MIPS boot code when zstd compressed kernels are 
> enabled, and was
> Introduced in commit a510b61613 [0][1]. The fix is to include the 
> definitions from `lib/clz_ctz.c` [2].
> The same problem was fixed for s390 in this patch [3].
> 
> CC: Paul Cercueil

Thanks, I'll send a patch.

Cheers,
-Paul


