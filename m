Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1644048BD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348538AbiALC0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:26:46 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35443 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiALC0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:26:45 -0500
Received: by mail-ot1-f50.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so996429otu.2;
        Tue, 11 Jan 2022 18:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ds6wRCFPL40BKi4K6LyOPbKU8cjTciwH+ZBrh/+ERu0=;
        b=WwEvTBcyMbj8/cYOhqblr+4kegsSKEo8TGuFdhDTV61Fhgh4bFl29mNVcaZ6hHkAAb
         5/pl/cv/D2POrKnhHCFgDlqjoP+Ce+kYbiDe2g89DAvDcKnGW/FlkxrZjjBAvfRgaah1
         JIfqOtbppz57Jl6NZtRkxK5SUlw0hZietJ0WsZpudJZSeazCRK4fUAiKCNFkyQc/0Uh5
         PtXsL7WaKKK9/H4U1aLi1brdYo4AxRr926WuIQ5YJpYnfFbo0KD38WcdMSya9XdoyKms
         4lGKjgrnSvW4sJ32U2vTHvpjDQapJyHRjuq22IBoKUIymXxN5dtWAGxuLWAHfijzqB05
         njCg==
X-Gm-Message-State: AOAM531oEcPheeCIHSF6guIsQYetJ61i/AyU9KktwPdpyu0tWCXk8aPc
        qzuFJU1J0oqy/n0Er5LiTA==
X-Google-Smtp-Source: ABdhPJz3e+MTn+AZbhQ6ZuGywkRVoXtlT796gDLOpKPvLwU3O/AtddJ8fnESqn/3CjbiOCtjZGIjHg==
X-Received: by 2002:a9d:f04:: with SMTP id 4mr5270642ott.326.1641954404451;
        Tue, 11 Jan 2022 18:26:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d21sm671239oti.5.2022.01.11.18.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:26:43 -0800 (PST)
Received: (nullmailer pid 3951745 invoked by uid 1000);
        Wed, 12 Jan 2022 02:26:42 -0000
Date:   Tue, 11 Jan 2022 20:26:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/28] dt-bindings: pinctrl: samsung: describe
 Exynos850 and ExynosAutov9 wake-ups
Message-ID: <Yd48YtTFYez0yx9N@robh.at.kernel.org>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
 <20220111201722.327219-19-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111201722.327219-19-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 21:17:19 +0100, Krzysztof Kozlowski wrote:
> Older Samsung Exynos SoC pin controller nodes (Exynos3250, Exynos4,
> Exynos5, Exynos5433) with external wake-up interrupts, expected to have
> one interrupt for multiplexing these wake-up interrupts.  Also they
> expected to have exactly one pin controller capable of external wake-up
> interrupts.
> 
> It seems however that newer ARMv8 Exynos SoC like Exynos850 and
> ExynosAutov9 have differences of their pin controller node capable of
> external wake-up interrupts:
> 1. No multiplexed external wake-up interrupt, only direct,
> 2. More than one pin controller capable of external wake-up interrupts.
> 
> Add dedicated Exynos850 and ExynosAutov9 compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../samsung,pinctrl-wakeup-interrupt.yaml     | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
