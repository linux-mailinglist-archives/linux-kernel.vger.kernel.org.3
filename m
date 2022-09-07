Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27185B0E44
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIGUkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGUkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:40:00 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB1D75FC4;
        Wed,  7 Sep 2022 13:39:59 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so11030734otq.11;
        Wed, 07 Sep 2022 13:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=B2IFflJH99H+OmtJdbEsZW5tBYdpJ1o3T6IM/Tw43fg=;
        b=37drJSRKiZgjAD05iFcGhRIsQCSFu16p0DSJNzhF2yRlDC5FYxC24YyVCijwBnbDtP
         +BieZVeVxbGmhvRCgFBhUVRVQJwQ1u4xl5dNYf/ywIQcr951AulSpXs+UQlMjV0smjy1
         LOmN18NK50aNfsSRl+o7U/emR80zdCveyKtNDgnuTm8amN7bZ7366awPXreryYup4uQ5
         +2G9xr2AoHWlquKpBw+XVvEZoLIw4hGEDLCQ1PEJ9FovBfeHtgm4zODCAKFJsavubyQO
         cKRiYwtgeN+ZaLLxQAqkMSptpLMYWo05VNBCbYtOzHYQ1SvnoGaGqZxSaZDC9W2QS1sh
         6fAg==
X-Gm-Message-State: ACgBeo3e35t9QhsfeEI9ynumV34ClD6fyu1OgZmPg3OxsA4kDMSqieEU
        gvRq+l3UBirJWIQNKUWOvo7VErX5Rg==
X-Google-Smtp-Source: AA6agR7Zwv+cfNRWF8LPCK6tEJYQ/3fgZgDC1mz5CxKX026LM4pO4X/fCpUoU4sFmJeQ961ACcczcw==
X-Received: by 2002:a9d:6c50:0:b0:638:9f91:9d8e with SMTP id g16-20020a9d6c50000000b006389f919d8emr2101339otq.217.1662583195614;
        Wed, 07 Sep 2022 13:39:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cv3-20020a056870c68300b0010efb044e37sm8477078oab.27.2022.09.07.13.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:39:55 -0700 (PDT)
Received: (nullmailer pid 301983 invoked by uid 1000);
        Wed, 07 Sep 2022 20:39:54 -0000
Date:   Wed, 7 Sep 2022 15:39:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     amitk@kernel.org, Fabien Parent <fparent@baylibre.com>,
        rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, rui.zhang@intel.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com
Subject: Re: [PATCH v3 1/4] dt-bindings: thermal: mediatek: add binding
 documentation for MT8365 SoC
Message-ID: <20220907203954.GA301949-robh@kernel.org>
References: <20220901133950.115122-1-aouledameur@baylibre.com>
 <20220901133950.115122-2-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901133950.115122-2-aouledameur@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Sep 2022 15:39:47 +0200, Amjad Ouled-Ameur wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add the binding documentation for the thermal support on MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
