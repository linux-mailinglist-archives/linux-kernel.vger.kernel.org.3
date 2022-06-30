Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0945626E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiF3XRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiF3XRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:17:07 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6401E3DC;
        Thu, 30 Jun 2022 16:16:46 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id h5so380073ili.3;
        Thu, 30 Jun 2022 16:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d62Av7F3BWv71Z/lOKF3fB8kkhXhdc30IXRm0NnALFM=;
        b=rUX5+lB+JwK32edSsz3/376DwXIGjBuM89m3nI7yAtze2fDoNfp3iCEHpq7mXbOLu6
         XCGCZFFGZ1gbeFYJ7EvdVinfxM2M+eGzO7jQ+lKNrfO+0E/aTqhwtpUjpIRQTo+iywPD
         7cu5pTArR7igbenIGUvUB4CqsjHl406Ch27VCjTV/KXp7pRZjrOs2tfjluHx8pbIFHIS
         F7r63bUHbdDndV0CgHzIB2LhUBWAd6kHMoXms9nWyoVdFQmOBPLHHgwe1a1Ox8wwIZft
         apLXLaF7MeHy5hxEWwkr2fq7gn6os2zJ+gwm2UIzxIvwjRrM1OtdKHYm+8UPonDomGQV
         3O8g==
X-Gm-Message-State: AJIora88aGYwDPnPp95Vy1naEZEvEmnOXiDzQ7MvgDmzvvCGIC3bCaAH
        /Up33Q2s5SFipfxIURtKJQ==
X-Google-Smtp-Source: AGRyM1smMxjMKzfPYe8QALeF3NEaDxnRWfvDQvGqBx+28UPnBM/jcLkAOxQA0slVAHdw7MlO/XHugg==
X-Received: by 2002:a05:6e02:10c7:b0:2d9:202e:78fe with SMTP id s7-20020a056e0210c700b002d9202e78femr6824458ilj.124.1656631005342;
        Thu, 30 Jun 2022 16:16:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p10-20020a92c10a000000b002d958b56258sm8569182ile.62.2022.06.30.16.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:16:45 -0700 (PDT)
Received: (nullmailer pid 3514016 invoked by uid 1000);
        Thu, 30 Jun 2022 23:16:43 -0000
Date:   Thu, 30 Jun 2022 17:16:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Inki Dae <inki.dae@samsung.com>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: media: samsung,exynos5250-gsc: convert
 to dtschema
Message-ID: <20220630231643.GA3513958-robh@kernel.org>
References: <20220626163300.6271-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626163300.6271-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2022 18:33:00 +0200, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos SoC G-Scaler bindings to DT schema.
> 
> Changes done during conversion:
> 1. A typical (already used) properties like clocks, iommus and
>    power-domains.
> 2. Require clocks, because they are essential for the block to operate.
> 3. Describe the differences in clocks between the Exynos5250/5420 and
>    the Exynos5433 G-Scalers.  This includes the fifth Exynos5433 clock
>    "gsd" (GSCL Smart Deck) which was added to the DTS, but not to the
>    bindings and Linux driver.  Similarly to Exynos5433 DECON change [1],
>    the clock should be used.
> 
> [1] https://lore.kernel.org/all/6270db2d-667d-8d6f-9289-be92da486c25@samsung.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Remove Joonyoung Shim from maintainers (emails bounce).
> ---
>  .../devicetree/bindings/media/exynos5-gsc.txt |  38 ------
>  .../media/samsung,exynos5250-gsc.yaml         | 109 ++++++++++++++++++
>  2 files changed, 109 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/exynos5-gsc.txt
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
