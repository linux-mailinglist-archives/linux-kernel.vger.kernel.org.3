Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28553464F5F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349722AbhLAOLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349658AbhLAOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:11:46 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55017C061574;
        Wed,  1 Dec 2021 06:08:25 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f18so63211429lfv.6;
        Wed, 01 Dec 2021 06:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uGn+eOZ98cIA1kOcjZIA0FuKSIGdQFXauoGMI0Uduls=;
        b=Bsr+yfx09KXSMkhr9Qy3IFcpveZSByruIoTYwTwTHR8QUC3rOKzwmHct2s5F5g12l7
         LeI8lrs98KaebzlSexCl0JHZJPxk/J5c8gB5pz/5vfwoWNWQ/JscG+Uxp1HTfNEUktwa
         uNMvDcz3Rx5iBOnRGC0vf7X2bsormkjg2lyZ9XLXdcUuKW5RnH/ox9uzLAdIL1OlNa0o
         KNGpuE3Qe50jXnooA2lr2PBTboT5ADiTOdZQyamHRRwmALQd89yko5mlr/RKvoOpZCJX
         JrXI7QP4LsC+ZFuwLhntK9HvDWNj+okgNDw00x9L3XY9Ps3Dn+pypR0mk7evqNQhWxdJ
         VyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uGn+eOZ98cIA1kOcjZIA0FuKSIGdQFXauoGMI0Uduls=;
        b=mxyVzawDbHiO8h5oOcn2BAY5RYb93VBJE+33vfXEqYbFeP8aSxgJqJKevTivGC2gaW
         /9ozIenro78Eyrj8BSpX4+x9Y/oWXxakdQABPnnbvUl9mxC9iWxHxxswY3VWpxr0v0d9
         HvjQ5DbqTp7tJ9nRssWOiYzqTVHjcTTLwdU4/Avq238zohDDI67NEoq8PYbJDsAhlSRG
         vf3+zFQbwsZKKJSVdT7oOYaiVPn7HpOlGBtTn0r0PPhCd3evvZJTCMFyGWh6N0qRkWP1
         8/fXzyO5Ps9k3PcLjwO/WuoNMldr6SkGf0fyjJqxJYeC25g+p6980SXzai0SGfD+qk64
         pLjA==
X-Gm-Message-State: AOAM530YEcPtrU/bhCSNJkiMbdtZ+sGWZjRez/Rhe5ItqmRPvGkMSWxJ
        WkJS4xn0Y3hPtoDu8QADAfEI8g3D6S4=
X-Google-Smtp-Source: ABdhPJyjFMo0icfLxX2wpTq6prbf40QDlw8s/GZfAsFxBG+ArS0a8pk0uvJKBdddvREpEzqPicVOQQ==
X-Received: by 2002:a19:431b:: with SMTP id q27mr5740825lfa.562.1638367703433;
        Wed, 01 Dec 2021 06:08:23 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id j20sm2128568lfu.84.2021.12.01.06.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 06:08:22 -0800 (PST)
Subject: Re: [PATCH v4 06/24] ARM: tegra: Add common device-tree base for
 Tegra30 ASUS Transformers
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211130223820.23609-1-digetx@gmail.com>
 <20211130223820.23609-7-digetx@gmail.com> <YadJSRww8we7tzjP@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <00ed819f-8bd8-7116-4f05-8b702a09dc78@gmail.com>
Date:   Wed, 1 Dec 2021 17:08:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YadJSRww8we7tzjP@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.12.2021 13:07, Michał Mirosław пишет:
> On Wed, Dec 01, 2021 at 01:38:02AM +0300, Dmitry Osipenko wrote:
>> From: Svyatoslav Ryhel <clamor95@gmail.com>
> [...]
>> +	i2c2: i2c@7000c400 {
>> +		status = "okay";
>> +		clock-frequency = <400000>;
>> +	};
> [...]
> 
> Nit: You could now use the new controller handles directly - that would
> avoid some indentation and duplication. Though I understand it is a lot
> of tedious reformatting.

I see that there are people who prefer to use labels everywhere.
Historically Tegra device-trees never used handles for nodes. I think
should be better to convert all DTs together to keep them consistent,
which I was asking to do before, but nobody wanted to put effort into
doing that.

There are already quite a lot of DT changes scheduled for 5.17, perhaps
better to defer the extra changes for 5.18. I will add it to my todo
list, but if you're going to type the patches, then please either send
them to me, or to ML, or create PR to grate kernel.

At some point in the past we had this common DTSI using labels for
handles, but I asked to keep the DTs consistent, so we don't have them now.
