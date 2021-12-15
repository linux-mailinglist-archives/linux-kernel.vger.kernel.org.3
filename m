Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA2475C15
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244065AbhLOPph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhLOPpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:45:36 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D5AC06173E;
        Wed, 15 Dec 2021 07:45:36 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m27so43871929lfj.12;
        Wed, 15 Dec 2021 07:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7QFG/KOWEFOwNZzyUYyvdsxhN49Z5B+4BTkc8nzo7cY=;
        b=fd0gB6Frk76cNohLpnNCVZtFbegOUIt/yxoMih73T220owEYYccwVmB8j+Rpw6I9EV
         CLtMM6GjlBulIe1iZm4tsIWcDxfLjEoENhEIOrRiDfus6ASqeNIs5Rw6cHeyb+kgGB/P
         ReksY3a8PbH0dWPKlJ3qiRJjeBpfkaa6bAQhfcmt5Zwi/3/i4ctoNt9lBJ7hVfTIzj3i
         cPWwqNf2hOJvRLjHs+bdGrVrPo0SGfmNXIYSjuKAODRz9SHB/0JFgj2YjIdxx+gRuMb3
         QCwA/9OwWfa/NJIFuDl/81w565mx3g2/GETS95pc41TfAQgJKFR9uvlu2EqLZxPbXaW/
         GVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7QFG/KOWEFOwNZzyUYyvdsxhN49Z5B+4BTkc8nzo7cY=;
        b=3fYQx9j+g4Ol0+4AfQ30C9wKN13QaRiSkOG//MnmJXxIh2dXs1ME5p/FnCdnCRN3UI
         lMYcqlyNXNP5nlv9nokX8SFtBTAUMlT7pfhFXU9lFX898HnWW9f00rj5NJeeF4wGdt5R
         WM0C5zzpFFsNmfiHq3Ngo2jC4sRNaw/GywY2JtfQ3VOtYidGSCjgbPgoKrcfoWv+T/mf
         jc5gM7XiJeRzDoIIrrGg5cAXZczO4r3DOsP2Xx7zjRPb9qPH2pRpkg/08oXkVWn6tDs1
         PCcNe02D1MtfTRPfC74jf5c9nOfGit3qZVBpTXzlLS5QZBlpAKT8MmuTWYSlcRIt3hpl
         8Slw==
X-Gm-Message-State: AOAM533RnWa66ZBPsSFJrkRWRisbx3Y7eukO28h74eTbCpDObaedAytK
        XoaYegD28DS1Krr5/Yl8/bQdw6gEdXY=
X-Google-Smtp-Source: ABdhPJxHk+nWjcGuwrJ4RgA+qOLt0595mJAMj3fWGxXVqm99WvoDSjWH8gQK2DvhjMGXpbovPDQ5sA==
X-Received: by 2002:ac2:5f73:: with SMTP id c19mr10536004lfc.158.1639583134145;
        Wed, 15 Dec 2021 07:45:34 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id bn30sm506051ljb.29.2021.12.15.07.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 07:45:33 -0800 (PST)
Subject: Re: [PATCH v6 15/28] ARM: tegra: Add usb-role-switch property to USB
 OTG ports
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211211211412.10791-1-digetx@gmail.com>
 <20211211211412.10791-16-digetx@gmail.com> <YbnqP0XAcUYc4ePy@orome>
 <9cf23721-db53-830a-f634-d2215232f059@gmail.com> <YboGxZSi13OGByUQ@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8c0defff-3348-6f97-6bd4-ddfc6117e707@gmail.com>
Date:   Wed, 15 Dec 2021 18:45:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YboGxZSi13OGByUQ@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.12.2021 18:16, Thierry Reding пишет:
> On Wed, Dec 15, 2021 at 06:04:54PM +0300, Dmitry Osipenko wrote:
>> 15.12.2021 16:14, Thierry Reding пишет:
>>> On Sun, Dec 12, 2021 at 12:13:59AM +0300, Dmitry Osipenko wrote:
>>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>>
>>>> If an USB port is an OTG port, then we should add the usb-role-switch
>>>> property. Otherwise XUSB setup fails and therefore padctl is unable to
>>>> set up the ports. This leads to broken USB and PCIe ports. Add the
>>>> usb-role-switch properties to Tegra124 device-trees to fix the problem.
>>>>
>>>> The error message shown without this patch is e.g:
>>>> usb2-0: usb-role-switch not found for otg mode
>>>>
>>>> [digetx@gmail.com: improved commit message]
>>>> Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
>>>> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 1 +
>>>>  arch/arm/boot/dts/tegra124-apalis.dtsi      | 1 +
>>>>  arch/arm/boot/dts/tegra124-nyan.dtsi        | 1 +
>>>>  arch/arm/boot/dts/tegra124-venice2.dts      | 2 +-
>>>>  4 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> The device tree bindings for the XUSB pad controller say that when this
>>> property is set, then the "connector" subnode should also exist.
>>>
>>> Any chance we can add that? I was planning on making that a dependency
>>> in the json-schema conversion of the binding, in which case it would be
>>> more of a "must" than a "should".
>>
>> I guess it will be harmless if you'll add the connector subnodes. Will
>> you be able to create a separate patch that will add the subnodes on top
>> of this patch?
>>
>> Thomas Graichen says that one USB port on Nyan Big doesn't work without
>> this patch. This is why this patch is needed essentially.
> 
> Okay, I can add "dummy" connector nodes for now. I don't see how we can
> properly set this up because as far as I can tell there's USB ID GPIO on
> Tegra124 (seems like it's a fixed function pin) and the VBUS GPIO is
> already used to enable the VBUS supply. The gpio-usb-b-connector binding
> required at least one of the ID and VBUS GPIOs to be specified.

The ID and VBUS hardware configurations are very board-specific. There
are multiple ways of how it could implemented on Tegra.

> On the other hand, at least Venice2 has a USB type A connector for this,
> so I'm not even sure how that would work. I vaguely recall that the
> Tegra20 Seaboard also had a USB type A and that it was possible to use
> it in device mode, but I don't how that would. Nor would it be correct
> to use the gpio-usb-b-connector compatible for that since, well, it's
> not USB type B.

I'm not sure whether it makes much sense to use OTG for USB type A
connectors, normally they should be fixed to host mode.

> I suspect that Apalis has a micro-B port, much like the Jetson TK1. My
> understanding is that OTG doesn't work on Jetson TK1 (which is why it's
> configured in "host" mode), so it'd be interesting to see if this can be
> made to work on Apalis.

Looks like the default Apalis carrier board has three type A connectors.

https://www.toradex.com/products/carrier-board/ixora-carrier-board
