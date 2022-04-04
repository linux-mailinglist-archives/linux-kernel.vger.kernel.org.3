Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924194F1E78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382089AbiDDWNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387299AbiDDVnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:43:01 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28DDE3C;
        Mon,  4 Apr 2022 14:36:38 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id v75so11471603oie.1;
        Mon, 04 Apr 2022 14:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=frSzmln4u9VqIvYnkcnuMEse8X080wHxUqx+SfDQZfk=;
        b=KLZ6QvWQgUZZF6dlpLVSgOjCYBQgASwLEV21LzIcr1SyaHmxA2sPlDWwACyL/LRmRf
         rZQf3INUpVhs/0FUsfkAkooXFmS3DHeCrgfwArbybGKg9QC8yZs/IAG+40jEWfsf8FEN
         Fb4Hv4iUdlXVdsUAnoYIdUE4YeTQpBePyvt5s35ZI1mdzlwyH9BRhXr7O4ZlOf0WclTu
         iDIEc6OKt8w+o01GKGOGGXDVBz5ayRCkkDb/T37EFmJ5NlseGDdAQAE0uNxxOBGVfapp
         B/YsUs5/zdNwXGQRPbZoPLQRaJcaFvBgPPO97O56dAPS0fPquPVV9pLysadPhugbFPfu
         sGEw==
X-Gm-Message-State: AOAM533zdD0NnpPf6cdqyvGGkQYLTaV1wXnx8tmVQIFOaCCfHxoDQD+A
        r+KQF0lzZYlcUk5u9ZJ6XXA+xRo3KQ==
X-Google-Smtp-Source: ABdhPJyh2mm62UbATxLFlvIzKT5/fWFiqw7k2slBLagLuTd8NtJs9y8Y1Ml6A43/DoZL3MmQc7tIhQ==
X-Received: by 2002:a05:6808:13c9:b0:2f9:2cf0:932a with SMTP id d9-20020a05680813c900b002f92cf0932amr101361oiw.39.1649108198241;
        Mon, 04 Apr 2022 14:36:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id hg14-20020a056870790e00b000e1c070a73asm4049890oab.55.2022.04.04.14.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:36:37 -0700 (PDT)
Received: (nullmailer pid 2028738 invoked by uid 1000);
        Mon, 04 Apr 2022 21:36:37 -0000
Date:   Mon, 4 Apr 2022 16:36:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2] regulator: dt-bindings: richtek,rt4801: minor
 comments adjustments
Message-ID: <Yktk5TcDPqUeRPgj@robh.at.kernel.org>
References: <20220401153711.1057853-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401153711.1057853-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 01 Apr 2022 17:37:11 +0200, Krzysztof Kozlowski wrote:
> Correct grammar in 'enable-gpios' description and remove useless comment
> about regulator nodes, because these are obvious from patternProperties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct also "spefied"
> ---
>  .../bindings/regulator/richtek,rt4801-regulator.yaml       | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
