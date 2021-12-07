Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA846BFCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbhLGPwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhLGPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:52:40 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A47FC061574;
        Tue,  7 Dec 2021 07:49:10 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z8so28178590ljz.9;
        Tue, 07 Dec 2021 07:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4uDjcpsKd8NPDhx91UKVlEBzzyIKS/ryAwk42PqDp8Q=;
        b=UEtfTTDOqrQoj6+s5QaG/0SmRDQVDZqi7GfjXEpeYM+4+dZ1hpuhoT3tEqYqLdL4Er
         YN3rhY47CyteMJQt6gr6ilhV7vpXTBTGzX1+Mllw1UXspZOoyajN2s3Q8yyhy84oSK4n
         +65yyy1vm7c+sO7FQBTv2BXYdVMDv2G58lJ0cRtctGDhwLezgZukKtRv41HGl9pmkYGo
         5Xc9McTM9QjwOUFuntzzjQDamTn18ar9L8/773vFi4XoCT76nc6uA0yK2iZOMyuTti1C
         8pLRkfboinSm2Hr06AD0U1RYvlJp+Ur5FyI7EcZSFdDgyqRVUQ4LQ1R1WOPt4bSFkiQa
         FMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4uDjcpsKd8NPDhx91UKVlEBzzyIKS/ryAwk42PqDp8Q=;
        b=7mxopVFf5F4wHhRjf+k40G36hygYbe+OuP5ykmeaexYLoluygx9QfIJkFuQt7K130J
         5+O+AKE0BhrvIMyU1AzsrEqDM/3TmfENs5tQ7XiovrSwiTCG17oHoIUJLgqEfgXK96VR
         vCl4t4BTkVH+wk1ujtbg+8ZKAXjtuJGwAIQDQEYycPWhYfvtsptHKvIkH/oi1MiNh2Dt
         jb/Oeh11zhB+yVpPQxCmry1U9AA+Z7n80GyeO74LyM1K0FE37qPXZzwaNG4joeGPDYzN
         zXAAIafELiuV7zyfOwG55qUvPHc6Y8obn66XC/XEK0yE7oDk8vHKh9hOyGp5RwRE9/hU
         0Jzw==
X-Gm-Message-State: AOAM533agj089wyTsac2XSgR10wQSNrhDcmqcaerstGVHkLQkmixcGVL
        3yLKXh12imJdgRRtBtRTeeM6dqxxNTg=
X-Google-Smtp-Source: ABdhPJyd5F+rdKY9vKX8srKhW4YKSmy3giHf4T98i3vJ99HbMF5SdEvvtOVUbD9AMCdDqwmIwmt+qw==
X-Received: by 2002:a05:651c:2c1:: with SMTP id f1mr44175758ljo.345.1638892148238;
        Tue, 07 Dec 2021 07:49:08 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id d16sm1712471ljj.87.2021.12.07.07.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 07:49:07 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: regulators: Document Tegra regulator
 coupling in json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211206154032.227938-1-thierry.reding@gmail.com>
 <Ya51Ndf+VdRRdM9h@robh.at.kernel.org>
 <dfb6b42c-16ed-ab17-b585-6b07d3d6874f@gmail.com>
 <CAL_JsqKJFk76nXwRZoe-A_C8r+1jBWMDg7BvrxFBRHR62Ls9yw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3b67b2b5-104d-ebc7-426d-266086698a68@gmail.com>
Date:   Tue, 7 Dec 2021 18:49:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKJFk76nXwRZoe-A_C8r+1jBWMDg7BvrxFBRHR62Ls9yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2021 18:25, Rob Herring пишет:
> On Mon, Dec 6, 2021 at 3:55 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 06.12.2021 23:40, Rob Herring пишет:
>>> On Mon, Dec 06, 2021 at 04:40:32PM +0100, Thierry Reding wrote:
>>>> From: Thierry Reding <treding@nvidia.com>
>>>>
>>>> Move the NVIDIA Tegra regulator coupling bindings from the free-form
>>>> text format into the existing json-schema file for regulators.
>>>
>>> Do we need these properties for every single regulator? This should be
>>> its own schema file and then referenced where it is needed.
>>
>> These properties are SoC-specific, they describe how regulators are
>> integrated into SoC's power subsystem. Regulators themselves are
>> SoC-independent, i.e. PMIC's vendor and model don't matter for SoC.
> 
> Yes, but in reality the PMIC and SoC are typically somewhat coupled.
> How many PMICs do you need these properties for?

Three PMICs. Realistically we shouldn't have more such PMICs in upstream
in foreseeable future.
