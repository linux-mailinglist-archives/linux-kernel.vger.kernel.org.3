Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F764F071E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 05:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiDCDgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 23:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiDCDgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 23:36:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02742666
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 20:34:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so8532715pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 20:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnom-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Hm8FVs0arooTLE6Eh8VfS7KDK4shmmaWHj7NOB+YH4g=;
        b=6FysXIslUF2GxJRwuINFG8hVfhGI+2AOhTh0xAZY2m46Q+GCRN4JTQPHWo0ERHHkxY
         vMoqDWWVAYpz+22ZF3HdTXSLCnlYl/f9IqqCHHzymjPsNqHXGx3S4D/ljmKOvgXzNUdG
         oSkDKbZubyLnIT0jd1wbAirKPNW/oMtD2NaD6Dyh3tw7tABCe8Fu4CseH8W7KnZL23wA
         SKc2rvggNPhzks0jSFXP0mgVJTP6++fTheFwm4YQz2xv33MB6SxjT85KlFp/f/woEbiQ
         6PDhZhqt3c1IEhmy4Xk5BBG5ZQ/4efPYbpRRRwK+TD73+XnbbRqfZ5QRaCesOtRAAHYH
         JPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hm8FVs0arooTLE6Eh8VfS7KDK4shmmaWHj7NOB+YH4g=;
        b=rQtU0AXIyvBMugPIhyWRH8PJTm16SNtdPcB4F4rNJmKGRHjecUZ/iH5Or4scr9Nt7P
         652ygrpzccc/QHpmcBIGOE5iZtaSfe711OLK12jkgJXjGLbBay8twg122zjneQKfPMYd
         7wJGqBfVsksVIC2VBhbAkKTnNXScxuyrIvrWfCB/MeIslEQ9MiGOxmzypMQQv/wzbzfB
         MEDRmPP5r6Y3mFigk6xvvPdXvprcKUj2TRpn4sgvVASXbDuK2Kk1oAHhTqf+1MfKN7Lh
         VyALltVixbbEfwD1YF87pcEa2Yqw8XrGIcutRQfHVQKlzQPPml8f+jX98tiFFMMDTTXK
         7kiA==
X-Gm-Message-State: AOAM533fubyoPu6WbJ+3+e6/gTPUsJdqvWPAE5vx7N9QCVP44qUhNhHH
        AVpJjt2rXd0C57+YPi5BQJZO/g==
X-Google-Smtp-Source: ABdhPJyBndYDPMUL8FwjhIdVYnlUSLu+PuR/IDxAGHKoNn93rw4x4NKjfj4p6ygV7yjiQMKhYh71qw==
X-Received: by 2002:a17:90b:38c7:b0:1c7:6afb:fac6 with SMTP id nn7-20020a17090b38c700b001c76afbfac6mr19539766pjb.198.1648956854227;
        Sat, 02 Apr 2022 20:34:14 -0700 (PDT)
Received: from [172.21.10.80] (119-18-16-128.771210.mel.static.aussiebb.net. [119.18.16.128])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a668f00b001ca8984eeabsm362142pjj.4.2022.04.02.20.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 20:34:13 -0700 (PDT)
Message-ID: <9cc88b1c-8a8c-95ea-2cf7-31be3b771495@omnom.net>
Date:   Sun, 3 Apr 2022 13:34:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] MIPS: pgalloc: fix memory leak caused by pgd_free()
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>, yaliang.wang@windriver.com
Cc:     rppt@kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        huangpei@loongson.cn, Andrew Morton <akpm@linux-foundation.org>,
        kumba@gentoo.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        anshuman.khandual@arm.com, penberg@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
References: <20220310113116.2068859-1-yaliang.wang@windriver.com>
 <alpine.DEB.2.21.2204021446370.47162@angie.orcam.me.uk>
From:   Andrew Holmes <aholmes@omnom.net>
In-Reply-To: <alpine.DEB.2.21.2204021446370.47162@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/2022 12:48 am, Maciej W. Rozycki wrote:
> On Thu, 10 Mar 2022, yaliang.wang@windriver.com wrote:
> 
>> pgd page is freed by generic implementation pgd_free() since commit
>> f9cb654cb550 ("asm-generic: pgalloc: provide generic pgd_free()"),
>> however, there are scenarios that the system uses more than one page as
>> the pgd table, in such cases the generic implementation pgd_free() won't
>> be applicable anymore. For example, when PAGE_SIZE_4KB is enabled and
>> MIPS_VA_BITS_48 is not enabled in a 64bit system, the macro "PGD_ORDER"
>> will be set as "1", which will cause allocating two pages as the pgd
>> table. Well, at the same time, the generic implementation pgd_free()
>> just free one pgd page, which will result in the memory leak.
>>
>> The memory leak can be easily detected by executing shell command:
>> "while true; do ls > /dev/null; grep MemFree /proc/meminfo; done"
>>
>> Fixes: f9cb654cb550 ("asm-generic: pgalloc: provide generic pgd_free()")
>> Signed-off-by: Yaliang Wang <Yaliang.Wang@windriver.com>
> 
>   As a critical regression shouldn't this have been marked for backporting
> to stable branches?

Very yes please - this bug has been driving several of us at OpenWrt
crazy for quite[1] some[2] time now, mostly on Octeon devices. We'd
(wrongly) suspected the octeon-ethernet driver, but this morning finally
bisected it down to f9cb654cb550 and can confirm this patch fixes the
regression.

MIPS64 has essentially been broken/unusable for 8 kernel releases,
including two LTS kernels, since the original commit landed. Should
there not have been CI/tests that caught this? It's pretty major!

- Andrew

[1] 
https://forum.openwrt.org/t/oom-killer-dnsmasq-when-physical-free-ram-remains/109351
[2] 
https://forum.openwrt.org/t/upstream-kernel-memleak-5-10-octeon-ethernet-ko/111827
