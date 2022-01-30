Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3144A32D1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353573AbiA3AWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:22:30 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:33658 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353551AbiA3AWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:22:23 -0500
Received: by mail-oo1-f44.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso2335160oop.0;
        Sat, 29 Jan 2022 16:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=EfijCJEIDI95t04URhCJ7b9hoUPag07U2dCpls06Eik=;
        b=JhHE04OF2lliw5yGEpzyjqRnUgZoqiiZLd9cWnowQf5M2oxk40vHvBpj20Fq62/JrM
         ongtsV+8JLKqACT5/NOc8WNvv7pxF9HbaghV1e01uzm76cZCtvkS49Vcidl9/jISTQ2a
         +wgVan3CbxwO2aO1Az2zGhv4e8dl4wcJuL8n03jQswr6RXqKnPj3hS77uflmgymYi02W
         Y/IdD7S2AEtaO2KbBQr4udGlOd8TV223VP8nt7qn4/nbXuTprlMfGNLahkGIHVjg4Xy5
         lofzB2oW2+i3pc5qav9rLNOkwpSKF7R172qIFhlKj3q8IhQuRLMNy1P7VIcE/9fptN61
         M+lQ==
X-Gm-Message-State: AOAM533zpir0RVAPTG7DTfRGEUrQSg4chlimopsWqXC+/e7MbT7h1j2H
        JptL+F42BBv9Eu+93ipF9w==
X-Google-Smtp-Source: ABdhPJzW9TIDgKljbL7MzxDrITFkNShplHNt3Q47D8MGi0MWITbw0U9uYUJ/2JZjHJ8jPJ4oCclLUg==
X-Received: by 2002:a4a:1505:: with SMTP id 5mr7233951oon.10.1643502142610;
        Sat, 29 Jan 2022 16:22:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f17sm1443383ots.40.2022.01.29.16.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 16:22:21 -0800 (PST)
Received: (nullmailer pid 416954 invoked by uid 1000);
        Sun, 30 Jan 2022 00:22:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Lee Jones <lee.jones@linaro.org>
In-Reply-To: <20220129175332.298666-4-krzysztof.kozlowski@canonical.com>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com> <20220129175332.298666-4-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 4/5] dt-bindings: mfd: samsung,exynos5433-lpass: Convert to dtschema
Date:   Sat, 29 Jan 2022 18:22:17 -0600
Message-Id: <1643502137.259074.416953.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 18:53:31 +0100, Krzysztof Kozlowski wrote:
> Convert the Exynos5433 LPASS bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/mfd/samsung,exynos5433-lpass.txt |  72 -----------
>  .../mfd/samsung,exynos5433-lpass.yaml         | 119 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 72 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dt.yaml: audio-subsystem@11400000: serial@11460000:compatible:0: 'samsung,exynos5433-uart' is not one of ['apple,s5l-uart', 'samsung,s3c2410-uart', 'samsung,s3c2412-uart', 'samsung,s3c2440-uart', 'samsung,s3c6400-uart', 'samsung,s5pv210-uart', 'samsung,exynos4210-uart', 'samsung,exynos850-uart']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dt.yaml:0:0: /example-0/audio-subsystem@11400000/serial@11460000: failed to match any schema with compatible: ['samsung,exynos5433-uart']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1586234

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

