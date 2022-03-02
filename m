Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8AB4CACA5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244310AbiCBR5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiCBR5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:57:37 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B539ED4C8D;
        Wed,  2 Mar 2022 09:56:53 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id q5so2432876oij.6;
        Wed, 02 Mar 2022 09:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cdY4Cd9XsSSd3wJ+B7rrT4fkTVqTOk4fX8CSvyN80Ec=;
        b=ptNBLrHlOyBKbVBUl3lseCsNXmXwKQ/IEzd5zFWiJIy5csa0Z23zEfap/LA3/i50lr
         OtXAzd4tstcRM0kwK6HFTpfI+18RNZZ934EyzV5mZJL28TL5S47D4nD6ZFKHT1JX8RUM
         aj9P/g2Gyeyr4TOvqveDTNMrsEGxNVEvwBlLNiZwKzi1hblAU9mfq2hizpTeOyUJ3XeS
         1BmQpHJvej59I5IYsdcDb6J1CvMH+QED1UA8EMQdnI7+lk34csFvmBlfH89dHYWvRnaS
         7SktAQbSeagaVhjnRas2AS+dgQ91B889hcZf/+RYjOsakZgjRuYW6aoxMIA/h17lHNu5
         BsTQ==
X-Gm-Message-State: AOAM533atkyUS/UIKRkeDsyBP9UfJVbWte9neqm3Yx8z/dp/a1r5Beez
        cSqUVJvjEHdsl2DaVCr/IA==
X-Google-Smtp-Source: ABdhPJw61vl7JL/KvfMW0GeVw15bGRkHEZiAkLusBAmUPvayWC5wFnJhXujY6TtZynik2FRR/Gz32g==
X-Received: by 2002:a05:6808:d49:b0:2d7:2725:90f with SMTP id w9-20020a0568080d4900b002d72725090fmr921573oik.162.1646243813104;
        Wed, 02 Mar 2022 09:56:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e7-20020a9d2a87000000b005af548abe73sm8250840otb.4.2022.03.02.09.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:56:51 -0800 (PST)
Received: (nullmailer pid 3963012 invoked by uid 1000);
        Wed, 02 Mar 2022 17:56:50 -0000
Date:   Wed, 2 Mar 2022 11:56:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     xinlei.lee@mediatek.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, matthias.bgg@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com, allen-kh.cheng@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: Re: [PATCH v3, 2/6] dt-bindings: pwm: Remove compatible for MediaTek
 MT8167
Message-ID: <Yh+v4vjevi4/cwHY@robh.at.kernel.org>
References: <1646199106-26879-1-git-send-email-xinlei.lee@mediatek.com>
 <1646199106-26879-3-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646199106-26879-3-git-send-email-xinlei.lee@mediatek.com>
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

On Wed, Mar 02, 2022 at 01:31:42PM +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Remove dt-binding documentation of pwm for MediaTek MT8167 SoC.

Why?

> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index f844695d605a..f18e8bbd13d2 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -20,9 +20,6 @@ properties:
>            - mediatek,mt2701-disp-pwm
>            - mediatek,mt6595-disp-pwm
>            - mediatek,mt8173-disp-pwm
> -      - items:
> -          - const: mediatek,mt8167-disp-pwm
> -          - const: mediatek,mt8173-disp-pwm
>  
>    reg:
>      maxItems: 1
> -- 
> 2.18.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
