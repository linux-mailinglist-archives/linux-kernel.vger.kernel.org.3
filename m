Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E26648093F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 13:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhL1MyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 07:54:07 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]:34529 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhL1MyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 07:54:05 -0500
Received: by mail-qv1-f49.google.com with SMTP id ke6so16331205qvb.1;
        Tue, 28 Dec 2021 04:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZJRShB4R17XUyA+Lmky9Eq7KbI1a01Ayw4czD8PmLMk=;
        b=x/OLxIKeT5ykWdAefUBcJfl7l9cr9FWRu7ZE92sBwrejQbUMjpebLtJrrO5yKO/NNA
         0J+bRqEfDSAGzihN14uzSexE4MOinYTOHB4imWZD4rXFSnxL2XXiXryBaU1DcrEEPOmT
         G5cT5FwJTWBxtLjvdjuoE2AhF8DQa6fatDGjjyNUqWQ09tu28lTZHP6LqbSvzuDo8FZy
         lB7xtuvbe6hklYmh7xE/DYjS87kvZvDi4HhLcT1POW+Sg9uPz5QKhlaF3PBsVlEI0W7K
         noYpxIxQ731D4dDvGL7yHfIUWX4qNkjdzFW4q3Oncbo/qvVUJQqq4JuRN9XyGcmhu4Qi
         0b1g==
X-Gm-Message-State: AOAM531RWV6x4RyDVBkiu98KRy7xeV16OPJfCEXNDDHuBzQ4Ems+HsPN
        WfH6z3LrmoCLsNGpLGaCLQ==
X-Google-Smtp-Source: ABdhPJy/fzYGUO6kMogbqR18MjovZaSQSfYizR9m/aisbNPZJViok+Nkn+4LdRkBGt95ydX9TJxItg==
X-Received: by 2002:a05:6214:500a:: with SMTP id jo10mr18668993qvb.17.1640696044298;
        Tue, 28 Dec 2021 04:54:04 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id j16sm15759721qtx.92.2021.12.28.04.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 04:54:03 -0800 (PST)
Received: (nullmailer pid 685117 invoked by uid 1000);
        Tue, 28 Dec 2021 12:54:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nishanth Menon <nm@ti.com>,
        Patrick Venture <venture@google.com>, openbmc@lists.ozlabs.org,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-crypto@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tali Perry <tali.perry1@gmail.com>, devicetree@vger.kernel.org,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nancy Yuen <yuenn@google.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
In-Reply-To: <20211227183251.132525-2-krzysztof.kozlowski@canonical.com>
References: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com> <20211227183251.132525-2-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 2/8] dt-bindings: rng: atmel,at91-trng: convert Atmel TRNG to dtschema
Date:   Tue, 28 Dec 2021 08:54:00 -0400
Message-Id: <1640696040.235226.685116.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 19:32:45 +0100, Krzysztof Kozlowski wrote:
> Convert the Atmel TRNG bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/rng/atmel,at91-trng.yaml         | 46 +++++++++++++++++++
>  .../devicetree/bindings/rng/atmel-trng.txt    | 16 -------
>  2 files changed, 46 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
>  delete mode 100644 Documentation/devicetree/bindings/rng/atmel-trng.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1573492


rng@e2010000: compatible:0: 'microchip,sama7g5-trng' is not one of ['atmel,at91sam9g45-trng', 'microchip,sam9x60-trng']
	arch/arm/boot/dts/at91-sama7g5ek.dt.yaml

rng@e2010000: compatible: Additional items are not allowed ('atmel,at91sam9g45-trng' was unexpected)
	arch/arm/boot/dts/at91-sama7g5ek.dt.yaml

rng@e2010000: compatible: ['microchip,sama7g5-trng', 'atmel,at91sam9g45-trng'] is too long
	arch/arm/boot/dts/at91-sama7g5ek.dt.yaml

