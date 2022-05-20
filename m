Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB22052F58A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353844AbiETWQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiETWQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:16:16 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324066D4F7;
        Fri, 20 May 2022 15:16:15 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id w130so11538027oig.0;
        Fri, 20 May 2022 15:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHfepm0kjI4CxV3pGVRvLmHwIoaKzm9+kLAL1NzKoEE=;
        b=DNJluWvXP+W637XwY08HH8Jztkc1SxFW4swT9f/KbE6oHmj46/7Ob39EsDqXlYZOHM
         dI1Kmetpk2hNmU8y2uS95FGO/EewnolWK1SXCAFAjsfpZyAfCMOjGM92SVLW3S26pMQQ
         PHT4ohG8Mcqf0/ixzYHhUUiIzC+uOsUQU+SeNjFmqrCgzV9uShQVzgROiapTkpF1l+/M
         UzpSmtvYPjpjrjG/UFsrwwRG0hKGrKDPxwT+9zd2yy+s9FtlkrOhva42/9SxFo41lXRp
         rZyTJN1V7chJ7//C14tobyXFt8ylGQuD1q0SnTe1tQyJwPVlfYOLc85vB2l35aoWaMK1
         9VLA==
X-Gm-Message-State: AOAM531/Kv1c1SJSGtd9tLGNsthqlyDwv8GtoYPSDoxEJ4cvrAVWMfgD
        +2R+KroFrn99gYB/dzQcfg==
X-Google-Smtp-Source: ABdhPJzF+pUwG91SErE4WYmgGDsLR0PlckfITBqumsWo6qGQownaSro/mN/e5gro2pKA1LCEL1AeAA==
X-Received: by 2002:a05:6808:1496:b0:326:e2de:63ec with SMTP id e22-20020a056808149600b00326e2de63ecmr6737618oiw.271.1653084974326;
        Fri, 20 May 2022 15:16:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s22-20020a056870e6d600b000e686d13895sm1385387oak.47.2022.05.20.15.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:16:13 -0700 (PDT)
Received: (nullmailer pid 348614 invoked by uid 1000);
        Fri, 20 May 2022 22:16:12 -0000
Date:   Fri, 20 May 2022 17:16:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sboyd@kernel.org, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, wenst@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: mtk-clock: Remove unnecessary
 'items' and fix formatting
Message-ID: <20220520221612.GA346673-robh@kernel.org>
References: <20220518093631.25491-1-angelogioacchino.delregno@collabora.com>
 <20220518093631.25491-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518093631.25491-2-angelogioacchino.delregno@collabora.com>
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

On Wed, May 18, 2022 at 11:36:30AM +0200, AngeloGioacchino Del Regno wrote:
> There's no need for 'items' when there's only one item; while at it,
> also fix formatting by adding a blank line before specifying 'reg'.
> 
> Signed-off-by: AngeloGioacchino	Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../arm/mediatek/mediatek,mt8186-clock.yaml   | 28 ++++-----
>  .../arm/mediatek/mediatek,mt8192-clock.yaml   | 45 +++++++-------
>  .../arm/mediatek/mediatek,mt8195-clock.yaml   | 58 +++++++++----------
>  3 files changed, 65 insertions(+), 66 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
