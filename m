Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2D512C83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbiD1HTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiD1HTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:19:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD939A98F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:16:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id p18so4446340edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qK/yNrchERZZb5WKsXnjQKVBWPRpxhxKirZegeYDkkY=;
        b=vJtMFaDNzaFtW99IRYyFTdk1Q8rYW6IgWzug6j118ma2yzmHBEoZiIvjA+nqqYpWTQ
         Jn8F9zn8piDuH+HVvvDNy9n1snQ3Zs+xiBydHljNiaIbnqk8kbFOE0jRdRmK/FE35t8E
         FwMLiIdpJsgd6pblclSuZNN8qA/zm0bLgh3FI8opcF/fbId2RbGSF/AZhU+Y01/1Kqkj
         8V7lXoleyRtSyGVds/TB01VyhRAALqiMR4zPJ06+KXwLXXWgClKJKlvHm/ahNu2qXB5t
         B4+IvMdt7au54atFCYPkxViu6/L/e/tVm+btfCw+jvW12VGe5M7Cz3wa/8D2RaJ5SqI9
         EYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qK/yNrchERZZb5WKsXnjQKVBWPRpxhxKirZegeYDkkY=;
        b=LcMIaamcomHlDSvd6SKfOzYbO9otU1lOiqI7zbwsgeuAmMYVPFsjmM8ESff1ZPum7Y
         Nkqhs+CaDM3pVXERkUta+R1kVhqsNob0mqkoQTVZBDJru/4PtqxCngyNKoIlcQkEmmH+
         mFrfkYzgluzR7USDOhr9FcUsS5xj38iXS/o0OFYA+YomsT4dVAIfegwtPmnzx5MTMgMX
         6zhsjNaogKQuKDdgiYHbBAH8x5fBF37ROUWGfmh92hXimxphWbazkYZl4zjhO1ghhJu7
         dn/26GFRecCqvm32WDA9XyE3Svlvx55Hgv1xaJ8/zkC7AyDpVfBjlWrb86XbDPdgjE4d
         b1cg==
X-Gm-Message-State: AOAM530dpnJ+kv8cBI2ahg0QpNuFhCtrXBtgnKwOMSQGHWv07/hqlm3X
        o1GIVFJAuo08G9uBL+Z40sdLGQ==
X-Google-Smtp-Source: ABdhPJwRIlMZ/N3CaLiouXW/V1Nu5fEPPg34JRXTySZPqf2rTLSJUyAHmbmbfn25DsZhtMrqpgtQAw==
X-Received: by 2002:a05:6402:2985:b0:425:d51f:ae4 with SMTP id eq5-20020a056402298500b00425d51f0ae4mr26454621edb.379.1651130189275;
        Thu, 28 Apr 2022 00:16:29 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z14-20020a170906944e00b006f38c33b6e3sm6086651ejx.68.2022.04.28.00.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:16:27 -0700 (PDT)
Message-ID: <b7bb228f-751c-e7ad-a695-3dc40d889a72@linaro.org>
Date:   Thu, 28 Apr 2022 09:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: arm: mediatek: mmsys: refine power and gce
 properties
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220428012715.2619-1-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220428012715.2619-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 03:27, jason-jh.lin wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> Power:
>   Refine description and add item number for power-domains property.
> 
> GCE:
>   Refine description and add item number for mboxes property and
>   mediatek,gce-client-reg property.
> 
> Fixes: 1da90b8a7bae ("dt-bindings: arm: mediatek: mmsys: add power and gce properties")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 29 +++++++++----------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 6ad023eec193..6722f1b724ef 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -43,28 +43,27 @@ properties:
>      maxItems: 1
>  
>    power-domains:
> +    maxItems: 1
>      description:
> -      A phandle and PM domain specifier as defined by bindings
> -      of the power controller specified by phandle. See
> -      Documentation/devicetree/bindings/power/power-domain.yaml for details.
> +      Each mmsys belongs to a power-domains. If mmsys wants to use PM
> +      interface to control the power controller of mmsys, it should have
> +      this property.
>  
>    mboxes:
> +    minItems: 1

maxItems, surely you cannot have infinite number of mailboxes to talk with?

>      description:
> -      Using mailbox to communicate with GCE, it should have this
> -      property and list of phandle, mailbox specifiers. See
> -      Documentation/devicetree/bindings/mailbox/mtk-gce.txt for details.
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> +      If using mailbox to communicate with GCE, it should have this
> +      property. GCE will help configure the hardware settings for the
> +      current mmsys data pipeline.
>  
>    mediatek,gce-client-reg:
> -    description:
> -      The register of client driver can be configured by gce with 4 arguments
> -      defined in this property, such as phandle of gce, subsys id,
> -      register offset and size.
> -      Each subsys id is mapping to a base address of display function blocks
> -      register which is defined in the gce header
> -      include/dt-bindings/gce/<chip>-gce.h.
> -    $ref: /schemas/types.yaml#/definitions/phandle-array

Why removing ref? Does your binding work after such change?

>      maxItems: 1
> +    items:
> +      - items:
> +          - description: phandle to GCE
> +          - description: subsys id
> +          - description: register offset
> +          - description: register size
>  
>    "#clock-cells":
>      const: 1


Best regards,
Krzysztof
