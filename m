Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D2C475B60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243656AbhLOPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLOPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:04:58 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38053C061574;
        Wed, 15 Dec 2021 07:04:58 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z8so33754535ljz.9;
        Wed, 15 Dec 2021 07:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SK2obCHb5ZGA4KhJ57yX8FGQ/4KglrxupbNqsVDZlaA=;
        b=BYLCbT8gYFALFqpbU6OMPW34q3cqou4DBJTb5cGnt3LrRUnr0WPPUsVNAIBEFqkqCp
         jS99Y7BW1C59sBXvttCsgmVbfdCY5sXgqFIxBs1Qjv+tRSpVcQGLaeL9S8+6DNl0FVu4
         AGAavkXp8wBAVrmNt/y8bSBWs+AYPobKFmCklfB52Qgdb/JK4VOehOl41pI9z8L6QUWk
         8FSPOAioTlYiQ2PiqoMQXLXxK8GFJt62VjOyKjZgmFCk/gSVw6bg6EA4sJQDMA3s9AM7
         7JEb4prZBcyOuyio213TnY94M0JnpfkWhU5613/553SUeadbQKQw7EF39JQ2bmuj9DN8
         XdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SK2obCHb5ZGA4KhJ57yX8FGQ/4KglrxupbNqsVDZlaA=;
        b=YUOGemlaY7RQMCbbhazWx1f2M9PQ7CSF/llsM6a7B9Ttn65tU712RB76Uf7EPf57yf
         Y/3ZzxO49nlf41lrDtIFUWQRNgorpofE3ZK+VLvlFnz3QjoYEIo1sf7zZGgrR6cz4Maf
         OySIMYqpIwai5bBn/2epLLoLBf7hkCWMzMKRjN8fB52b5+X+CG5OaC1UpISGr5dCtChU
         lhf9FvMzVNWADDVLuJvs99+wqmSSgFdrZ9Cf/1HdpuKsjfQQAOoAZqqLrP9mrCfrjIsA
         bjcOxjtLCEiG5SVHsbFuhOAB1Lx8tRCeZi0DBFha9TmDS6ICk7UCYnboeRm5x0sTs7nk
         qo7w==
X-Gm-Message-State: AOAM5311Smbotjsi4lEnxYOzj47IH/kUzVXogRXXVed8Kz13RPKCzSKl
        MOA5wcjoJNhc5Z5pnRg4c+x/Aujqq0A=
X-Google-Smtp-Source: ABdhPJyrkoYIFZIklEWbn/7U9QxIDN8R9tR4hIMA43eCE6YeQWs4azVahAS5uPKHDe2d+d8CRP8hkA==
X-Received: by 2002:a2e:151b:: with SMTP id s27mr10382983ljd.274.1639580696364;
        Wed, 15 Dec 2021 07:04:56 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id k15sm361906lfe.15.2021.12.15.07.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 07:04:55 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9cf23721-db53-830a-f634-d2215232f059@gmail.com>
Date:   Wed, 15 Dec 2021 18:04:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbnqP0XAcUYc4ePy@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.12.2021 16:14, Thierry Reding пишет:
> On Sun, Dec 12, 2021 at 12:13:59AM +0300, Dmitry Osipenko wrote:
>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>
>> If an USB port is an OTG port, then we should add the usb-role-switch
>> property. Otherwise XUSB setup fails and therefore padctl is unable to
>> set up the ports. This leads to broken USB and PCIe ports. Add the
>> usb-role-switch properties to Tegra124 device-trees to fix the problem.
>>
>> The error message shown without this patch is e.g:
>> usb2-0: usb-role-switch not found for otg mode
>>
>> [digetx@gmail.com: improved commit message]
>> Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
>> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 1 +
>>  arch/arm/boot/dts/tegra124-apalis.dtsi      | 1 +
>>  arch/arm/boot/dts/tegra124-nyan.dtsi        | 1 +
>>  arch/arm/boot/dts/tegra124-venice2.dts      | 2 +-
>>  4 files changed, 4 insertions(+), 1 deletion(-)
> 
> The device tree bindings for the XUSB pad controller say that when this
> property is set, then the "connector" subnode should also exist.
> 
> Any chance we can add that? I was planning on making that a dependency
> in the json-schema conversion of the binding, in which case it would be
> more of a "must" than a "should".

I guess it will be harmless if you'll add the connector subnodes. Will
you be able to create a separate patch that will add the subnodes on top
of this patch?

Thomas Graichen says that one USB port on Nyan Big doesn't work without
this patch. This is why this patch is needed essentially.
