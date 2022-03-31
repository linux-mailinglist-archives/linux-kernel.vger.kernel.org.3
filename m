Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B564ED841
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiCaLLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiCaLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:11:54 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D9E33884;
        Thu, 31 Mar 2022 04:10:05 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id hu11so19433319qvb.7;
        Thu, 31 Mar 2022 04:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LZri1QmIwLg+DYDniyH354wuZz2jQq8wnmWC2f+UvNk=;
        b=CGA6tXQogr4P9WKRr+lZhqp9py7WDO3T3bGcSQVl7FIa5pnDzCYtWC4wHcwuV2hTV1
         +ZDKRpFgLDI9okt/43VRNMa5ebU4XgNYZ6jsAPb77ZpH3NPV/reG8xbY/OKpoeqtyiNK
         TYl69QUr2tU6KLvcA/9p5nU8OXC934lN9frhCpTckQkAJIPnLegbA2D85x/k+qJtdraJ
         gJyjzUrpbLdIdm1ykbgclDVuFm2dFAiBCHNlyDtKF0Sa6KNrUMk1YwSWIyiY9mk2EMgZ
         +6vEotV7tobYGVQULCJMTDbelNBDszml1TuvdqJvx7opxStcOyAMWjRijl4ousBWvBc1
         Dk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LZri1QmIwLg+DYDniyH354wuZz2jQq8wnmWC2f+UvNk=;
        b=JeKZdcCdv8jdWPMQv7Qx+CBPT1klhoz4fwCzmRfqS90jdYYPtv/E9/km2YHSv5cr5L
         ll4rRmsTip7DhJBW+T6qTPqpzWTvfLcXMVUDlcakupkGGCDw7/T5oE6oQ+PKJ8cpB891
         FaEkgzOgV62ttN6J73cg1RWhb84EwLcW8e9rk93FROFV6Uziv6XtdnwRzJTCz150z8sx
         3llfxMk+Em5tzYatCrWZOtJFSPZNnws4YrZrGW29mSgeEFupXPhX8ijrBX5/QfWyPi5q
         LPmjRbiWrtg8NCRK4gOGVrUsTruc7LpNThjYueW+zzLC+IMNnewynDAghDD7KFu91R4Z
         SbWg==
X-Gm-Message-State: AOAM530GrvSs+50N9wwxYFbClEYyBYPv3CU7S9kpmAZw5RXgHKD+WE6w
        Zj/nvJn0NXTMf47lOKYjjqo=
X-Google-Smtp-Source: ABdhPJwbMO7Mb+rcF4NaO4plvZQNRBr0+sy+UcxUK021eXZb5rKWyrXmPYZFiMSqbvKzXOVrKS/fcQ==
X-Received: by 2002:a05:6214:d4e:b0:441:18d8:8366 with SMTP id 14-20020a0562140d4e00b0044118d88366mr3464915qvr.46.1648725004854;
        Thu, 31 Mar 2022 04:10:04 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z203-20020a3765d4000000b0067b48d49c65sm12142999qkb.95.2022.03.31.04.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 04:10:03 -0700 (PDT)
Message-ID: <258d7152-326e-4f0a-859f-5864f01fd212@gmail.com>
Date:   Thu, 31 Mar 2022 13:09:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v16 2/8] dt-bindings: arm: mediatek: mmsys: add power and
 gce properties
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        hsinyi@chromium.org, fshao@chromium.org, moudy.ho@mediatek.com,
        roy-cw.yeh@mediatek.com, CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>, nancy.lin@mediatek.com,
        singo.chang@mediatek.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220307032859.3275-1-jason-jh.lin@mediatek.com>
 <20220307032859.3275-3-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220307032859.3275-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2022 04:28, jason-jh.lin wrote:
> Power:
> 1. Add description for power-domains property.
> 
> GCE:
> 1. Add description for mboxes property.
> 2. Add description for mediatek,gce-client-reg property.
> 

As you have to resend the series anyway, would you mind to make the commit 
message more sound with whole phrases? Other then that, the patch looks good.

Thanks,
Matthias

> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
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
