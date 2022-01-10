Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8ACB4893DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbiAJInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:43:23 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38554 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbiAJIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:41:28 -0500
Received: by mail-ed1-f54.google.com with SMTP id u21so27909844edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=octVJ0pssmy99DE7X4+pfHU8MHVH/s7bmvq4/iF5viY=;
        b=eq0Rwc1t6CLFL1jkHvHPfUG9ZvKm4H0c2OiLBfXJO4agAwnfAF0PddoF340G6ZIMD0
         64ntfIQGQr7mtBEtphLcU/qmhLntSDXUYMHVhul1h50FQp6nWY+qRupFp7R9cBFeyg6t
         23itI+WAvXYSCCaAVIk2jtaG9le/2VtIsva3ELo48UefY0ZwhUQDOiqNv8iOIi12plRR
         aNmlm5jVA2YOL26gND1/qORhfTysfCV4LwaPmyJgGSP32n/2k2WonRo0ftEBkqmi3SSg
         7rTMWq62oB89fVSa55x3sRlLLO60sZFqvYFcZJf07CdwJKvSJ/K312w7DD3HENxl4u9Q
         gcQg==
X-Gm-Message-State: AOAM530VD1uaZAOVQtyb1IAFB4CQEkxxV98jbxYgimWYaG6MEV+NdxqC
        jBNJC6ApB+hyswgAz9gBhXs=
X-Google-Smtp-Source: ABdhPJxzIcQI6Y42frVfr5VdpEkr62hLsmfmvRrDIJ6HRBdgvwLMFmI9R33cdBfHz8rnYuF+UMYgpA==
X-Received: by 2002:a17:906:3acc:: with SMTP id z12mr56442861ejd.10.1641804087132;
        Mon, 10 Jan 2022 00:41:27 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id g16sm2144561ejt.202.2022.01.10.00.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:41:26 -0800 (PST)
Message-ID: <e6575bd5-ba9f-546f-ce82-162f19c14cad@kernel.org>
Date:   Mon, 10 Jan 2022 09:41:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v1 08/14] arm64: defconfig: build lm75 temperature sensor
 driver as a module
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220107180314.1816515-1-marcel@ziswiler.com>
 <20220107180314.1816515-9-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220107180314.1816515-9-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 19:03, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Build Maxim Integrated LM75 temperature sensor driver as a module.

Why?

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 


Best regards,
Krzysztof
