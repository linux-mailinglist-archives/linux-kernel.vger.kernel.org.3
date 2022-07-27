Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631C358211D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiG0Hct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiG0Hcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:32:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4E9CE2B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658907166; x=1690443166;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3tUr9o4XtgqSSOj6k+rQU7NSjzLE5T5O5gATaSlQ9No=;
  b=UhDhouZM4PapK2r+qGlLmJQI5DpDx3/YyV8xDyyv674/el52zvSVS8Qz
   buMXK7m535bQX4f4hwUvAG+4jmxkJMT9dMx07wNSBE7xeGvNR44B8lAkT
   KPVk5LscG7ztXCUQw2nd4zmvF6VxTTbdNtJk8jFSHvNh+rDa5TLvpIxuU
   oTZLhkdRWQ4ns400wRK01CY53mvy8rgk8leQaX1P5MomoujwKohJLC9h3
   srPFtEJ82bJH1fWmQ7A10omu8G1iBKVsvj7t3fMOkUAEmikSD3iorsII+
   UXvfq9lvPh9PMRJy0fyiLLWBf3EX3EG0TrGq2VdpBSxkbvc3z5OovAgTI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289360402"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="289360402"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:32:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="659079451"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.171.125]) ([10.249.171.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:32:43 -0700
Subject: Re: [kbuild-all] Re: drivers/iio/adc/ti-tsc2046.c:242:62: warning:
 taking address of packed member 'data' of class or structure
 'tsc2046_adc_atom' may result in an unaligned pointer value
To:     Nathan Chancellor <nathan@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <202207251140.M7YAqoLC-lkp@intel.com>
 <CAHp75Vf0LjA8+JQNmKNYTe-1U58mSUsTiqQWbLAcrBXWs8NGjQ@mail.gmail.com>
 <YuAFeyKirrneGPSB@dev-arch.thelio-3990X>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <3b82019e-a913-1a5e-3118-1ed61d8bae87@intel.com>
Date:   Wed, 27 Jul 2022 15:32:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YuAFeyKirrneGPSB@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2022 11:17 PM, Nathan Chancellor wrote:
> On Tue, Jul 26, 2022 at 10:07:09AM +0200, Andy Shevchenko wrote:
>> Seems yet another false positive from Clang.
> 
> This warning should not show up because it is disabled in the main
> Makefile. Unfortunately, a recent change in clang made '-mtune' warn
> when it is not supported in the backend, which is the case for ARM:
> 
> https://github.com/ClangBuiltLinux/linux/issues/1674
> 
> As a result, all subsequent cc-option calls fail, which was the root
> cause of this warning last time, just with MIPS:
> 
> https://lore.kernel.org/YenXz+RznXBuJMSR@dev-arch.archlinux-ax161/
> 
> Intel folks, could you update your version of clang or add this
> particular warning to your blocklist? It should be resolved with
> https://github.com/llvm/llvm-project/commit/1d23f6c5a4f6ebb101c282f8f506588fe4d9e92f.

Hi Nathan,

Thanks for the advice, we have updated the clang in our environment.

Best Regards,
Rong Chen

> 
> Cheers,
> Nathan
> 
>> On Mon, Jul 25, 2022 at 5:55 AM kernel test robot <lkp@intel.com> wrote:
>>>
>>> Hi Oleksij,
>>>
>>> FYI, the error/warning still remains.
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   e0dccc3b76fb35bb257b4118367a883073d7390e
>>> commit: 9374e8f5a38defe90bc65b2decf317c1c62d91dd iio: adc: add ADC driver for the TI TSC2046 controller
>>> date:   1 year, 2 months ago
>>> config: arm-randconfig-r025-20220724 (https://download.01.org/0day-ci/archive/20220725/202207251140.M7YAqoLC-lkp@intel.com/config)
>>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9e88cbcc403bdf82f29259ad60ff60a8fc4434a1)
>>> reproduce (this is a W=1 build):
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # install arm cross compiling tool for clang build
>>>          # apt-get install binutils-arm-linux-gnueabi
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9374e8f5a38defe90bc65b2decf317c1c62d91dd
>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>          git fetch --no-tags linus master
>>>          git checkout 9374e8f5a38defe90bc65b2decf317c1c62d91dd
>>>          # save the config file
>>>          mkdir build_dir && cp config build_dir/.config
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/iio/adc/ drivers/staging/ fs/
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> drivers/iio/adc/ti-tsc2046.c:242:62: warning: taking address of packed member 'data' of class or structure 'tsc2046_adc_atom' may result in an unaligned pointer value [-Waddress-of-packed-member]
>>
>> What the heck? The get_unaligned_*() is exactly to get unaligned data.
>>
>>>             return FIELD_GET(TI_TSC2046_DATA_12BIT, get_unaligned_be16(&buf->data));
>>>                                                                         ^~~~~~~~~
>>>     include/linux/bitfield.h:108:27: note: expanded from macro 'FIELD_GET'
>>>                     __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
>>>                                             ^~~~
>>>     include/linux/bitfield.h:52:38: note: expanded from macro '__BF_FIELD_CHECK'
>>>                     BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,         \
>>>                                                        ^~~~
>>>     include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>>>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>>                                                              ^~~~
>>>     note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>>>     include/linux/compiler_types.h:308:9: note: expanded from macro '__compiletime_assert'
>>>                     if (!(condition))                                       \
>>>                           ^~~~~~~~~
>>>     include/linux/compiler.h:56:47: note: expanded from macro 'if'
>>>     #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>>>                                                   ^~~~
>>>     include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
>>>     #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>>>                                                        ^~~~
>>>>> drivers/iio/adc/ti-tsc2046.c:242:62: warning: taking address of packed member 'data' of class or structure 'tsc2046_adc_atom' may result in an unaligned pointer value [-Waddress-of-packed-member]
>>>             return FIELD_GET(TI_TSC2046_DATA_12BIT, get_unaligned_be16(&buf->data));
>>>                                                                         ^~~~~~~~~
>>>     include/linux/bitfield.h:108:27: note: expanded from macro 'FIELD_GET'
>>>                     __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
>>>                                             ^~~~
>>>     include/linux/bitfield.h:52:38: note: expanded from macro '__BF_FIELD_CHECK'
>>>                     BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,         \
>>>                                                        ^~~~
>>>     include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>>>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>>                                                              ^~~~
>>>     note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>>>     include/linux/compiler_types.h:308:9: note: expanded from macro '__compiletime_assert'
>>>                     if (!(condition))                                       \
>>>                           ^~~~~~~~~
>>>     include/linux/compiler.h:56:47: note: expanded from macro 'if'
>>>     #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>>>                                                   ^~~~
>>>     include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
>>>     #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>>>                                                                 ^~~~
>>>>> drivers/iio/adc/ti-tsc2046.c:242:62: warning: taking address of packed member 'data' of class or structure 'tsc2046_adc_atom' may result in an unaligned pointer value [-Waddress-of-packed-member]
>>>             return FIELD_GET(TI_TSC2046_DATA_12BIT, get_unaligned_be16(&buf->data));
>>>                                                                         ^~~~~~~~~
>>>     include/linux/bitfield.h:108:27: note: expanded from macro 'FIELD_GET'
>>>                     __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
>>>                                             ^~~~
>>>     include/linux/bitfield.h:52:38: note: expanded from macro '__BF_FIELD_CHECK'
>>>                     BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,         \
>>>                                                        ^~~~
>>>     include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>>>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>>                                                              ^~~~
>>>     note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>>>     include/linux/compiler.h:56:47: note: expanded from macro 'if'
>>>     #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>>>                                                   ^~~~
>>>     include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
>>>     #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>>>                                                                                          ^~~~
>>>     include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
>>>             (cond) ?                                        \
>>>              ^~~~
>>>     3 warnings generated.
>>>
>>>
>>> vim +242 drivers/iio/adc/ti-tsc2046.c
>>>
>>>     239
>>>     240  static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
>>>     241  {
>>>   > 242          return FIELD_GET(TI_TSC2046_DATA_12BIT, get_unaligned_be16(&buf->data));
>>>     243  }
>>
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
