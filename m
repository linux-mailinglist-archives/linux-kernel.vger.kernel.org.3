Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73E754CFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357642AbiFORbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356209AbiFORa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:30:59 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D03517D8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:30:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y196so12050237pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B7cbRCNg26UF8ivWTlzn2A7fgILQXWbzOIRhYJWq/FA=;
        b=supFxk6DUuphqiJojFl2H/H6UyNMffk7/gM9r72T4tQJooyDKuCJsbpMCf2eQPJBBi
         v5iY9l6cmhbAPuVM00qdGipMMDv1s3kJKf8Eimwj4CYElenmWpCzyUupdZac+rPTy6u/
         mXlk6dy2Kn/NVOvdBFZmLDhJW+Y6xnvsfExrXtX1qZIQQ5S6krDEMeKqGSW44w4YaIRS
         U85ylBHqi5abPMOLD0rhNIfcm0vydLlag3hWi4t3oEFTgH4/eg8LhI5x5o/x7N4sADiy
         jBE3Gyb7ZcWMvKebE6J2veK3U+hWIOXyyyz/gixScaVNvDi6oEhVKNknjc6biEJSDm2D
         Qehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B7cbRCNg26UF8ivWTlzn2A7fgILQXWbzOIRhYJWq/FA=;
        b=SrtXPKvjRYy5S7WUVeuVE4+lKM2ZTLahCxpbY0JYW6e/T38FWGPU/g18y92VWj1/uD
         jKtXuxLCD4EC7ZhYVPNqPd+zchB8dazsoJqTsQF27OiTneZ1Khpfosj1wVok6zDRtfl4
         x+eHYvGeDPLZwI4CUV2hreDCROtlprFWw34d4AG8fzkmBVhp8/Wq8jOJ0FywQ3U8+lbB
         6PcP0FSI6OiA4D0H0IcQG8TkiQ8YRd1v7wp5LpJHCox/KhY/QiheFU20YVOU8gdhbYYN
         r60av/D6WaFkJVUY4eMealhO7g/WVTTmzP4JGPXk9B0sxiB3mp3MKxBoI08mvKZqmnAo
         LxJw==
X-Gm-Message-State: AJIora/yhJ1fagSN7qFvziqrR+7Fw0rcHq09AP5NQt5rVG/xj62erD7Y
        R2/K69Koctokp1vwLokPGBkDcA==
X-Google-Smtp-Source: AGRyM1vF1fpZCiYd10o5djR4cMTz3jxdy9U8gdmikmzDuQcqp0xKZtHSrVJLo09rh1zFFSO0GO4H/A==
X-Received: by 2002:a63:3fcc:0:b0:408:c856:dd6d with SMTP id m195-20020a633fcc000000b00408c856dd6dmr770211pga.354.1655314241467;
        Wed, 15 Jun 2022 10:30:41 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id t8-20020a1709028c8800b001677d4a9665sm9501331plo.267.2022.06.15.10.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:30:41 -0700 (PDT)
Message-ID: <cb89dd3d-18d8-38ef-bb0f-00b6688bd54e@linaro.org>
Date:   Wed, 15 Jun 2022 10:30:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] dt-bindings: dsp: mediatek: Use meaningful names
 for mbox
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220609083101.24195-1-tinghan.shen@mediatek.com>
 <20220609083101.24195-2-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609083101.24195-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 01:30, Tinghan Shen wrote:
> Rename mbox according to action instead of 'mbox0' and 'mbox1'.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml        | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> index b7e68b0dfa13..6cedd6868cc5 100644
> --- a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> @@ -55,8 +55,8 @@ properties:
>  
>    mbox-names:
>      items:
> -      - const: mbox0
> -      - const: mbox1
> +      - const: rep
> +      - const: req
>  

More common is rx/tx, which I proposed last time.


Best regards,
Krzysztof
