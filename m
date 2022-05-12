Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEA45243CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbiELEC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345623AbiELECN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:02:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084C15DA62
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ResXbnpcW2KRBtsxMsZIEyQjIsTuDtJ8NLFBKnhdMcg=; b=jxqB8ZSs3Vy+z6KgA0XdfMWxN/
        x+wXhKhMEHBZ7Ag/B0DRWhqiXX+MuuvRGsM0+6VH/YwdjV8yPWsE4Tl8pqwMPb9d+5fptged4cxmu
        R7N73N9yxo0Lp4ifdX+24dMEY3yNfVpbkX5jwuWWaXp5o+LG9IFhVzWCXmysT5pkzaEex9QC9f0c6
        b0rWUgA/aUck0WQGTnchdoPnmfqhbTMu5g7vApwPvWjwgJ8EYasSg5lGPvvyEZO5TstnSfj4gLPLN
        dMBzIuyfxHjbYFYCgF1Fcq3TpfW7/CjfaRDfH4h/Cm/yer0CSDXXmH1ilmH6NFdPQL48kzY8JCdWy
        yU6O9HWQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1np01U-00DOFL-FZ; Thu, 12 May 2022 04:01:57 +0000
Message-ID: <73e60194-5841-9d46-0ebe-c129348125e5@infradead.org>
Date:   Wed, 11 May 2022 21:01:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: time.c:undefined reference to `mach_get_rtc_pll'
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Daniel Palmer <daniel@0x0f.com>
References: <202205041720.i8wJ8uXq-lkp@intel.com>
 <CAK8P3a3F3Z1NyhVcK6wN+b6Es3gqiYGee8a+pAPsaer4hhHDbQ@mail.gmail.com>
 <CAMuHMdVHUvbembVU92CZ+SXhfb8i8F_==d9rcH18pc=O-F8WOQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdVHUvbembVU92CZ+SXhfb8i8F_==d9rcH18pc=O-F8WOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/22 06:33, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Wed, May 4, 2022 at 2:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, May 4, 2022 at 11:14 AM kernel test robot <lkp@intel.com> wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   107c948d1d3e61d10aee9d0f7c3d81bbee9842af
>>> commit: 8b22820efb35f93d98638563b0a8f4094e8ee399 m68k: m68328: remove duplicate code
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
>>>>> time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
>>>    m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
>>>    m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
>>>
>>
>> I think this is just another build failure that was hidden before my patch,
>> not caused by my patch.
> 
> That's an m68knommu kernel build with CONFIG_RTC_DRV_GENERIC=y,
> I guess?

CONFIG_RTC_DRV_GENERIC=m


-- 
~Randy
