Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD5050713F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbiDSPBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347431AbiDSPBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:01:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6C53B291;
        Tue, 19 Apr 2022 07:58:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so1756755wml.2;
        Tue, 19 Apr 2022 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7ghNXW0NodixkgL8T98CLlpDZH/0jSgrfBNvM5ej23s=;
        b=hlZSGMyqcDPTQx6RmtGj1koskcBFnvovRkA/NkQQc1kdKfUCK/xvxNwK2/QMga//vt
         gvgPCxHQlSAHj+yHIujC+BRmhj1gLP7ekLjV7ZD7NrecJ3BdrZHOw6YBvn/B6cItuKKf
         MdBYEq0rFmbIYogIZIjdsOO2THvp40Dfj3qsPVPkMBNI2i35smPdCI7UEoXt/JwhcW9Q
         gx7Jeu3EnBQWxS746ict9bmJuk74OzwMEBkyzbwQJSY3huu8lXCtxwI5vk9YhVDeGMl8
         YXCw7i4742XSHTgAlzm+90dybKw5PvgRAAqbic2G3krhErrfckVz+/ESYOyynHb2tL31
         7WQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7ghNXW0NodixkgL8T98CLlpDZH/0jSgrfBNvM5ej23s=;
        b=VMjp19DdLLqWSND5jusfj1xKB28lSmOkBMtoOHWHMAjhX+T7wtHDvR5GQCpl47E4P9
         jgpctFIcg/aKH1Jq0U9LbyPgrtUqcAi4hJOKggFmYBMFAQv51zrCWrcYqTjN6ymxIp7g
         kuFjMyZaL8nhYtcpf6ZZuAX3/LMxOCNXAOpiyHSK20/60jO0FNL96r4TRqoIXtUyKImT
         EHaK1n2jARLpUqdnc3+Ebrh7Sq422xngOuf0GQk+AWlugZMSQLhQfjMmtqj/kBk/tJIv
         EogauValPMCPmopqdcSPDj2WndmPgrwdRpZQbS7LoACeIpIapLnhTBDeZwnzsfVH2Bws
         xA4g==
X-Gm-Message-State: AOAM532ezfeRFVbqrmPjnOvcjJ4tKXGRJl7MVQCRw71WXWJ3ZTjZ1dNu
        lOUQZReqIk1iRYxRAWFXKIg=
X-Google-Smtp-Source: ABdhPJybiVLTSTP7L0aETG6uMJhUECVA5p62Vy3/QCjle5pk3JlVskw99zgtPeLU158U++lWgJMu7w==
X-Received: by 2002:a05:600c:3785:b0:38e:bca8:f0c1 with SMTP id o5-20020a05600c378500b0038ebca8f0c1mr19958744wmr.56.1650380314825;
        Tue, 19 Apr 2022 07:58:34 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d59a3000000b0020a9132d1fbsm6605119wrr.37.2022.04.19.07.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 07:58:34 -0700 (PDT)
Message-ID: <83a7f222-f62c-fa47-9370-f9b709c3110e@gmail.com>
Date:   Tue, 19 Apr 2022 16:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/5] dt-bindings: arm: mediatek: mmsys: add power and gce
 properties
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de
Cc:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, nancy.lin@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220419033237.23405-1-rex-bc.chen@mediatek.com>
 <20220419033237.23405-2-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220419033237.23405-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2022 05:32, Rex-BC Chen wrote:
> From: "jason-jh.lin" <jason-jh.lin@mediatek.com>
> 
> Power:
> 1. Add description for power-domains property.
> 
> GCE:
> 1. Add description for mboxes property.
> 2. Add description for mediatek,gce-client-reg property.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Applied, thanks.

Matthias

> ---
>   .../bindings/arm/mediatek/mediatek,mmsys.yaml | 31 +++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index b31d90dc9eb4..6c2c3edcd443 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -41,6 +41,30 @@ properties:
>     reg:
>       maxItems: 1
>   
> +  power-domains:
> +    description:
> +      A phandle and PM domain specifier as defined by bindings
> +      of the power controller specified by phandle. See
> +      Documentation/devicetree/bindings/power/power-domain.yaml for details.
> +
> +  mboxes:
> +    description:
> +      Using mailbox to communicate with GCE, it should have this
> +      property and list of phandle, mailbox specifiers. See
> +      Documentation/devicetree/bindings/mailbox/mtk-gce.txt for details.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  mediatek,gce-client-reg:
> +    description:
> +      The register of client driver can be configured by gce with 4 arguments
> +      defined in this property, such as phandle of gce, subsys id,
> +      register offset and size.
> +      Each subsys id is mapping to a base address of display function blocks
> +      register which is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1
> +
>     "#clock-cells":
>       const: 1
>   
> @@ -56,9 +80,16 @@ additionalProperties: false
>   
>   examples:
>     - |
> +    #include <dt-bindings/power/mt8173-power.h>
> +    #include <dt-bindings/gce/mt8173-gce.h>
> +
>       mmsys: syscon@14000000 {
>           compatible = "mediatek,mt8173-mmsys", "syscon";
>           reg = <0x14000000 0x1000>;
> +        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
>           #clock-cells = <1>;
>           #reset-cells = <1>;
> +        mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> +                 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
> +        mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>       };
