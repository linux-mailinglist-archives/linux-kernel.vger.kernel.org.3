Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE36E475E60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245220AbhLORQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbhLORQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:16:30 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F0CC061574;
        Wed, 15 Dec 2021 09:16:29 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 207so34320614ljf.10;
        Wed, 15 Dec 2021 09:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S/GCgkClGZXdYBwxnqR+wcGOMju+Fi9souJahX9EL1o=;
        b=bdz742/FA6JguWMFrH5HAwjzLU+Er3f7zvGI2WCXjujCx1Tu36hsFoDscuSBLLT6va
         doXzrONAa8Bk6t8ozt3KUsg5xLM+n0n8Kk8ZSGDUNCDjrknWVQHcVH7uQQdsKnrhF13u
         1IeApe/GhUr6VcnYl6VAK4BMaX5aSBrd84EGh3Gpdlpz4g/2QbQN4u9SGoQrvdVKcTpT
         hps2VRLrSAVhMokbff4Wjb7pRIXulbnFMsxWuHW0QK28D2PuiZY+XE4xg8RemvWkLeqw
         Ko3cEdYFRWdxGTaGNbuL3B5eKiPLwCDdTZJQk66f5WSvmVBLIINv/Y7+r5hM5TnXelw0
         8m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S/GCgkClGZXdYBwxnqR+wcGOMju+Fi9souJahX9EL1o=;
        b=em/HtBorzuu7WeKdyQ4Mk32Ov/gQdBUvVZ31IihvBvB055CTCIyTilmxr5g546OmK6
         7dnSif+Kjvvug2Fj9uTsGutrYaPE5TU61HsMlwOjzA5JjeL1gG9e2pnXXGiUutTOrxJZ
         fzobqIu7A/GoZOaesHDcHnzBcgGjbQTUF4yGvn8DgbgB7ZgYofublo/SnM/2e32VyyL8
         DhNa8BSz6Js5Ud+q1LGyvi5F8iWUNyPp+kQMCDzI6KrduG3c7hNES3sQWsMcPHeKuOTU
         rfIVDjLreUUb800oz/66lKZIOyFMe+iOntdsIl204/1qWqP9MCryjcQnKUmrrfRHES2M
         uPcg==
X-Gm-Message-State: AOAM532Q5rzwMJRHVFlPOySQXkkeItDyUwOM7pUZuQZXOcGZWGO4VoN1
        3oSmjGjnBlw8+u7bTC4YRtsFmgP4Fvc=
X-Google-Smtp-Source: ABdhPJxn/UaB361+M0BnXTfKtbhmBJ8Y1tjsXF6B2t1OKOvjul1jveuxsZ8pllI+zOhZUCA4bUmjdA==
X-Received: by 2002:a2e:8513:: with SMTP id j19mr10642091lji.361.1639588587621;
        Wed, 15 Dec 2021 09:16:27 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id j22sm408857lfu.155.2021.12.15.09.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 09:16:27 -0800 (PST)
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
 <8c0defff-3348-6f97-6bd4-ddfc6117e707@gmail.com> <YboPROE47E3QBzfl@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5407ca7f-0f48-bc4d-2e60-4ce760500a3a@gmail.com>
Date:   Wed, 15 Dec 2021 20:16:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YboPROE47E3QBzfl@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.12.2021 18:52, Thierry Reding пишет:
>>> On the other hand, at least Venice2 has a USB type A connector for this,
>>> so I'm not even sure how that would work. I vaguely recall that the
>>> Tegra20 Seaboard also had a USB type A and that it was possible to use
>>> it in device mode, but I don't how that would. Nor would it be correct
>>> to use the gpio-usb-b-connector compatible for that since, well, it's
>>> not USB type B.
>> I'm not sure whether it makes much sense to use OTG for USB type A
>> connectors, normally they should be fixed to host mode.
> My recollection is that those can be used in device mode as well. For
> example that USB type A port on Venice2 (same as for Seaboard) can be
> used for RCM, IIRC. It's possible that there's no way to detect what is
> connected, though, so this may not be proper OTG.

Sounds correct.

>>> I suspect that Apalis has a micro-B port, much like the Jetson TK1. My
>>> understanding is that OTG doesn't work on Jetson TK1 (which is why it's
>>> configured in "host" mode), so it'd be interesting to see if this can be
>>> made to work on Apalis.
>> Looks like the default Apalis carrier board has three type A connectors.
>>
>> https://www.toradex.com/products/carrier-board/ixora-carrier-board
> I'm wondering if the best thing would be to mark all of these as "host"
> for now and avoid making this look like something that it isn't. I don't
> think we've ever made OTG work on these boards, so perhaps we shouldn't
> assume that it works.

Marking them "host" should be correct, but that wasn't tested.

I assume that those "OTG" ports may default to the host mode.
