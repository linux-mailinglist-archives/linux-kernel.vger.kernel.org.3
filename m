Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADABA5933F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiHORPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHORPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:15:35 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E04625C;
        Mon, 15 Aug 2022 10:15:34 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id mz1so869881qvb.4;
        Mon, 15 Aug 2022 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZAIpJGaAcgZBuThdmHbUgJwhrjw7i/vP1zGSP4C8pwU=;
        b=cWOdmvLvWdn5UA8D6jI6XiaCVIDeX5Ic9l5h2PVG1Mm7uAjuhkGY7qXqBLXcDhocYI
         VIIHxlt1hpzc1geAxiReOG2IU8fbSU4asqqjQoxjf+G4ZWBs99wtzgj0rWf4iSX4VxA7
         lSjN/faS8Jh0U8VaORwW+xQK5hMIZymcEl4aGF6ESCfYUs6XtqLcrVgReig7KWj+Hb4E
         E70UqYEiDX2YktqQwLIuh40D7Id2P5kwr5xe7JDzBTVObxkVITpiDYTyuj6O477sciyW
         7axmPDFmUHP0hwpjm3pV59uMFyzznyVg4VCE5Y1Vx2PFtj5kJzAKZUwZCNRLOEvHbLG7
         G34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZAIpJGaAcgZBuThdmHbUgJwhrjw7i/vP1zGSP4C8pwU=;
        b=n99zcBBEUM4S+9wJMVrbYofK7Q+E+Txx1VKsfuMxuM6+Y2aSijDpv355pSlY7S1mQM
         nrc1FUCTDM/n7m7RQtkbXWNYBHw4+4jHb3Nr86mERBYNmpNlYUwX1idZgtld1iZRnOmc
         gZRVXpv+oIeN3NBNNXv8kmYYT5po4oOuHEKI7w79GXswjb9AhdThix0uKlmWuUj8C0wt
         fihdtqqBVWf4TfEHUbAtNM6rA0N0IUvTRvHSZ62T5jqX8d19+zCJ7xlbkoPLx1UhPZsW
         ssH2OddH22fJgDfTAc2PlHEAro7g3xVxUDqmsoTn7JwOR0Ol9mnuqHINxqGdfZQhr3NO
         FmKg==
X-Gm-Message-State: ACgBeo1kWkfdbrISuKnJULX9UOtMs4kIFlFvT04/4QYth3nHW+QJadQ4
        OoZMenLIATu4FQ2RUnIvwwo=
X-Google-Smtp-Source: AA6agR4Ho70bxYlD1APx42mouIxRovBk6U/YlOwbkul6473hIFc7ujtuT0HgEc0rbkiVYwk4DaoAVQ==
X-Received: by 2002:a05:6214:d04:b0:47b:33c1:ba4f with SMTP id 4-20020a0562140d0400b0047b33c1ba4fmr14469223qvh.118.1660583733124;
        Mon, 15 Aug 2022 10:15:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b32-20020a05620a272000b006bb296e3298sm3571764qkp.20.2022.08.15.10.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 10:15:32 -0700 (PDT)
Message-ID: <f4adf05b-d3da-a692-3bd8-0b4d705e0dc2@gmail.com>
Date:   Mon, 15 Aug 2022 10:15:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: Kconfig.platforms: Re-organized Broadcom menu
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
 <fb4f4444-20c2-0e35-bb83-79a419ec87a7@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <fb4f4444-20c2-0e35-bb83-79a419ec87a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 15:05, Florian Fainelli wrote:
> On 7/13/22 02:17, Geert Uytterhoeven wrote:
>> Hi Krzysztof,
>>
>> On Wed, Jul 13, 2022 at 10:40 AM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>> On 13/07/2022 10:25, Arnd Bergmann wrote:
>>>> On Tue, Jul 12, 2022 at 6:42 PM Florian Fainelli 
>>>> <f.fainelli@gmail.com> wrote:
>>>>> There are now multiple Broadcom SoCs supported so group them under 
>>>>> their
>>>>> own menu such that the selection is visually more appealing and we can
>>>>> easily add new platforms there in the future. This allows us to move
>>>>> ARCH_BRCMSTB back to its siblings.
>>>>>
>>>>> No functional changes introduced.
>>>>>
>>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>> ---
>>>>>
>>>>> Note this is based on "arm64: bcmbca: add arch bcmbca machine entry"
>>>>
>>>> Hi Florian,
>>>>
>>>> So far, we have tried to keep the Kconfig.platforms file rather 
>>>> coarse-grained,
>>>> mainly limiting it to company names and high-level families, but 
>>>> avoiding
>>>> sub-menus or adding too many sub-families.
>>>>
>>>> If we add per-vendor submenus, we should probably first decide how we
>>>> want to structure this across vendors. I've added maintainers and 
>>>> lists to
>>>> Cc for a couple of the ones that are in a similar situation.
>>>>
>>>> I can see a couple of ways we can do this:
>>>>
>>>> a) keep the list of platforms as short as possible, combining related
>>>>    SoC families from a single vendor wherever possible, but no 
>>>> sub-menus
>>>>    (same as today)
>>>>
>>>> b) Always use sub-menus when there is more than one family, but
>>>>     keep relatively coarse platform selection.
>>>>
>>>> c) Use sub-menus and also move to a more fine-grained SoC
>>>>      selection, similar to what we have on 32-bit arm.
>>>>
>>>> I would not really want to go to c), but a) and b) both make sense to
>>>> me as long as do it consistently across all platforms.
>>>>
>>>> Any other ideas or opinions?
>>>
>>> Whatever we decide here, the SoC can override in drivers/soc, just like
>>> Renesas did. I think Renesas chose option c), but made it in
>>> drivers/soc. I would vote to have consistent policy, so if arch/arm64 is
>>> a) or b), sub-archs should not redefine it in drivers/soc.
>>
>> We did so because of the "only a single symbol in
>> arch/arm64/Kconfig.platforms"-policy.
> 
> I was not aware of that rule.
> 
> It is a bit of a mixed situation with Broadcom SoCs but in essence, each 
> Kconfig entry denotes a deeply different SoC architecture at the memory 
> subsystem, bus, security or product space that you might not want to 
> enable in your kernel. There is definitively sharing of drivers between 
> all of the platforms and a lot of cross pollination too but usually 
> these are deeply different that different kernel images do make sense.
> 
> The itch that I wanted to calm was that ARCH_BRCMSTB was after the other 
> Broadcom platforms separated by ARCH_BERLIN. if you prefer a pair of 
> KConfig comments to delineate them and flatten the platform selection, 
> that works for me, too.

There are 2 Marvell-based platforms (Berlin and mvebu) as well as two 
NXP-based platforms (MXC and S32), would it be better to also group them 
under an ARCH_MARVELL and ARCH_NXP menuconfig symbol the same way this 
patch does it for Broadcom-based SoCs?
-- 
Florian
