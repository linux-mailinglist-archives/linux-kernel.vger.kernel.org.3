Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3106C573F60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbiGMWFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiGMWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:05:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37F845049;
        Wed, 13 Jul 2022 15:05:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f11so10779507pgj.7;
        Wed, 13 Jul 2022 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uOBKq9yzkPX8ihcF5QdXtzsKbLEa/eP+OCHtDKfv5N0=;
        b=hk176+zLssVNRft8dirHFUQSzDMI0whOu6+6yXw9L8L7d0wLw7U16maq1hJRXPZTq/
         Gz/tk/9k5ncT0FkQbbwWFHn+Pbt8O7O5TawARP5Ey5PdgOfYEEgoTvfNvjwaKlC2Fp+u
         /yc6TfI2wpFGrTa7ELUtOTilQC8x/WO/N5T2D8R57dpFGws1xuiH5hYBGa0wwi3eo4hN
         f5S77L0OFyouEIHVUdo1qtgyMETHSDVdDO9i7srid340U9uCEKObdUPpsjKnJGrtF46J
         gnb7/zaBOGh40U273oDZM0oA/ohc98tEWGZ+o/mSmHyWI2/5r6+mUVZip7FZc9yew0w6
         weVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uOBKq9yzkPX8ihcF5QdXtzsKbLEa/eP+OCHtDKfv5N0=;
        b=lIIJth0Ot2coM+RxAyU0K5xL6fAmHxVkdgzZleB7HvdEJCV4ZV+xRf6j9lw3E37tFa
         qlkeJNmledY5FEPCuTgBwMkx0XmWFEk0EH2OrIdzCyqUj/m6jHBlSsWWecsnVEwWFkVB
         zIQ7FUygsq4mGLcm8j8Hnb/1Dmc8QU4IF+hOE+8QB/qLgyNXxE3DaPr9rm+FTb4gXz7a
         UdRUADvTxLpQ07JG2+nqVJO6laZyB3CLhJPzjFGPU2hg0z2P5dzkmymGSC/O11tI+nJF
         vhiBot9yAJSK+sB9wgHPe9LURPq4z9/f4cfeO5iks7VWyoCrg24aSZVCNrDllPqofgos
         QxXA==
X-Gm-Message-State: AJIora+P3UwtVRVK3V2hP2EHIEl2FEiWBHS3OKiADIba1tBZ8HTStdkE
        0wa4m3yOsyr6uVn7wWBtjMY=
X-Google-Smtp-Source: AGRyM1uFY5sq0uRq7vOEVCZc6Mt9dWUHaZVFaEt9VTaYlh+WdsLMFRrjoUXRSVp/xtwuLE8Bc1hpsw==
X-Received: by 2002:a65:4501:0:b0:3fc:4895:283b with SMTP id n1-20020a654501000000b003fc4895283bmr4726104pgq.231.1657749927276;
        Wed, 13 Jul 2022 15:05:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x7-20020a634847000000b0040c97f0057dsm7946127pgk.17.2022.07.13.15.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 15:05:26 -0700 (PDT)
Message-ID: <fb4f4444-20c2-0e35-bb83-79a419ec87a7@gmail.com>
Date:   Wed, 13 Jul 2022 15:05:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: Kconfig.platforms: Re-organized Broadcom menu
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        william.zhang@broadcom.com, anand.gore@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Wei Xu <xuwei5@hisilicon.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
References: <20220712164235.40293-1-f.fainelli@gmail.com>
 <CAK8P3a2QrYbWOqV+CG-W0ZkzW6ORgw8R6Dv-L3o2ZAtJs-B3Kw@mail.gmail.com>
 <0131e1d6-09c0-31a4-5b9d-0e2fc49d61ac@linaro.org>
 <CAMuHMdWDDY_72y3WYt401hG122xg1s7_VRCG9Vyhhkzco-nBYw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAMuHMdWDDY_72y3WYt401hG122xg1s7_VRCG9Vyhhkzco-nBYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 02:17, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Wed, Jul 13, 2022 at 10:40 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 13/07/2022 10:25, Arnd Bergmann wrote:
>>> On Tue, Jul 12, 2022 at 6:42 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>> There are now multiple Broadcom SoCs supported so group them under their
>>>> own menu such that the selection is visually more appealing and we can
>>>> easily add new platforms there in the future. This allows us to move
>>>> ARCH_BRCMSTB back to its siblings.
>>>>
>>>> No functional changes introduced.
>>>>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> ---
>>>>
>>>> Note this is based on "arm64: bcmbca: add arch bcmbca machine entry"
>>>
>>> Hi Florian,
>>>
>>> So far, we have tried to keep the Kconfig.platforms file rather coarse-grained,
>>> mainly limiting it to company names and high-level families, but avoiding
>>> sub-menus or adding too many sub-families.
>>>
>>> If we add per-vendor submenus, we should probably first decide how we
>>> want to structure this across vendors. I've added maintainers and lists to
>>> Cc for a couple of the ones that are in a similar situation.
>>>
>>> I can see a couple of ways we can do this:
>>>
>>> a) keep the list of platforms as short as possible, combining related
>>>    SoC families from a single vendor wherever possible, but no sub-menus
>>>    (same as today)
>>>
>>> b) Always use sub-menus when there is more than one family, but
>>>     keep relatively coarse platform selection.
>>>
>>> c) Use sub-menus and also move to a more fine-grained SoC
>>>      selection, similar to what we have on 32-bit arm.
>>>
>>> I would not really want to go to c), but a) and b) both make sense to
>>> me as long as do it consistently across all platforms.
>>>
>>> Any other ideas or opinions?
>>
>> Whatever we decide here, the SoC can override in drivers/soc, just like
>> Renesas did. I think Renesas chose option c), but made it in
>> drivers/soc. I would vote to have consistent policy, so if arch/arm64 is
>> a) or b), sub-archs should not redefine it in drivers/soc.
> 
> We did so because of the "only a single symbol in
> arch/arm64/Kconfig.platforms"-policy.

I was not aware of that rule.

It is a bit of a mixed situation with Broadcom SoCs but in essence, each 
Kconfig entry denotes a deeply different SoC architecture at the memory 
subsystem, bus, security or product space that you might not want to 
enable in your kernel. There is definitively sharing of drivers between 
all of the platforms and a lot of cross pollination too but usually 
these are deeply different that different kernel images do make sense.

The itch that I wanted to calm was that ARCH_BRCMSTB was after the other 
Broadcom platforms separated by ARCH_BERLIN. if you prefer a pair of 
KConfig comments to delineate them and flatten the platform selection, 
that works for me, too.
-- 
Florian
