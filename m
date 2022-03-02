Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85794CAC9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiCBR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiCBR4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:56:23 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5750D006F;
        Wed,  2 Mar 2022 09:55:39 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id i5so2450219oih.1;
        Wed, 02 Mar 2022 09:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XtJINkeAad4PNXHAMxkuIw7gJuFm8puZCGopniDrMH4=;
        b=FtBL0tEspiXcV1L2ZrgyIzdM9/wpHsAdN2aZb9GwXctZoU7xDc1F56BPxyEVp0W137
         +5/4QDwqVR0j22/caOZLeba7IjTz3lWLNrvKvR9ibkhKh57TzcA4183wlSx9kzruDcj2
         +Op4EO2tpmfUpxXNx+CVZw2H2Wo2hi/JIc2qtmxVWWZCThS22okuwr4fa9TDEFFPQR+P
         QnThHy/h0qiO9DqEkLUpe45kWYB7pr3VCprDJe24a+882FqC3rSIsAnzjl4CMq0MudEg
         1TA3WbK99kqdApogJ6Jb4mMbH32+qJkTWIIDPH6w64x31r4k0MdOO+yZjqQ42aZ84k5T
         c7dg==
X-Gm-Message-State: AOAM530a5OFgEPhAk93+us883GQBXBIz8zHqcPGqF+3rBiultmY7LTaf
        2fo/odrl99oS2+g7ysg1WcZDet2fGQ==
X-Google-Smtp-Source: ABdhPJxnos+rNy9BWd5srACedG+sKc7rc70EyhHRxtLepxttbdeiiWMGnm0ENW65df34irN3dANC5g==
X-Received: by 2002:a05:6808:9b8:b0:2d4:cc01:6cad with SMTP id e24-20020a05680809b800b002d4cc016cadmr899444oig.35.1646243739084;
        Wed, 02 Mar 2022 09:55:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f188-20020a4a58c5000000b0031ccb8272f1sm8189414oob.33.2022.03.02.09.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:55:38 -0800 (PST)
Received: (nullmailer pid 3961427 invoked by uid 1000);
        Wed, 02 Mar 2022 17:55:37 -0000
Date:   Wed, 2 Mar 2022 11:55:37 -0600
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
Subject: Re: [PATCH v3,6/6] dt-bindings: pwm: Add compatible for MediaTek
 MT8186
Message-ID: <Yh+vmZy8H0CClVEZ@robh.at.kernel.org>
References: <1646199106-26879-1-git-send-email-xinlei.lee@mediatek.com>
 <1646199106-26879-7-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646199106-26879-7-git-send-email-xinlei.lee@mediatek.com>
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

On Wed, Mar 02, 2022 at 01:31:46PM +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8186 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index 3a5d1cfed94d..053805846cfe 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -21,6 +21,9 @@ properties:
>            - mediatek,mt6595-disp-pwm
>            - mediatek,mt8173-disp-pwm
>            - mediatek,mt8183-disp-pwm
> +      - items:
> +          - const: mediatek,mt8186-disp-pwm
> +          - const: mediatek,mt8183-disp-pwm

Combine to 1 entry:

>        - items:
>            - const: mediatek,mt8192-disp-pwm

enum:
  - mediatek,mt8186-disp-pwm
  - mediatek,mt8192-disp-pwm

>            - const: mediatek,mt8183-disp-pwm
> -- 
> 2.18.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
