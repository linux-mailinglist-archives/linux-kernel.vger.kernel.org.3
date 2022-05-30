Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B742453758C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiE3Hhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiE3Hh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:37:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247E91276A
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:37:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e2so13448865wrc.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nUCeNrlCxSw9uMUiAzjXL467HYJr9B+OzTQ7H3Yk3Cg=;
        b=Who/+JNYbudXenChiXobKR5VodLsrJQ1DRvcOD3IeXxKAOJ7rgTSDLqTMs12k4DcXx
         Tdeu55CeVrOrxX7mLNBZgSqsm2CIVje3nEgDa3mVEWDz9Mspd29lMgjlHTAD3iF8hWgw
         06b4I9Zp8q2OEmfytjQpxaY3NktMoq/TP6n5Sw0nihwnoUE3XTdPWb9XcEAuz+Rr3jnK
         bytsnn/JbGaRkKOJrd3+b9E/Y6cd3R02kv700XJVseZQpw0WPW1XCANFZL1Qyww1J5/m
         WmfEKdKZGMyVEnbmefHVpY3hJnOKjQZnK1Ux+WjYOi4zLDAJNhXBBBfzd/KJkaz/PInC
         9UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nUCeNrlCxSw9uMUiAzjXL467HYJr9B+OzTQ7H3Yk3Cg=;
        b=5CzFbeWtS0CsqSufZeQexiK+aqqZgWqyzOccF7kHSA433rhiBc1qPb6jOyFCa6kggF
         /nrUpQw0ukOs2wyfwNjBYJ/MD1pLIMxxcG3G2to0pjTvF4zVGJbMiIMP7BZ09MFhXpPl
         KLB7L5NuPPutCT7nqMipZeZu4W+jKU11Nhbgi+b0y10J7QdtFM698OGyG7hdz8wPkICW
         MxQ6fprDrEi/Rg31svq8CUAOcIzuIw7TAMvoY/f5mzPqN784gGQ0y+utUXlyexPkvbES
         1hpJzdOmpZI/ehFjTZd8EpB86o1XfJ+uqkjDZoT1ET9T4AMzM1BOuK8heBXTJxjOj2Tj
         kcmg==
X-Gm-Message-State: AOAM531i8qfY0gZOR2A9+KYotT/N4AsUcnQbIcXClZiwcLE3zZD/EaFa
        xmQLMVx90M5+pbLADJuMn5ip5g==
X-Google-Smtp-Source: ABdhPJxILpNe/ZRRBVDJ8C8RJouI8WbtUTtW//ambOyntu5ZBKk9QCkDy73ATfXhntOCidY6JNdB6A==
X-Received: by 2002:a05:6000:1569:b0:20f:e429:d6d8 with SMTP id 9-20020a056000156900b0020fe429d6d8mr28684610wrz.663.1653896235732;
        Mon, 30 May 2022 00:37:15 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d62c2000000b00210335f7aaesm2358423wrv.35.2022.05.30.00.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 00:37:15 -0700 (PDT)
Message-ID: <6c14aa95-00c4-960b-d71a-3967096f19cb@linaro.org>
Date:   Mon, 30 May 2022 09:37:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: ti,j721e-system-controller: Add
 clock property
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, robh+dt@kernel.org, nm@ti.com,
        vigneshr@ti.com, kishon@ti.com, krzysztof.kozlowski+dt@linaro.org
Cc:     lee.jones@linaro.org, rogerq@kernel.org,
        devicetree@vger.kernel.org, kristo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        s-anna@ti.com
References: <20220530073429.17514-1-r-ravikumar@ti.com>
 <20220530073429.17514-2-r-ravikumar@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220530073429.17514-2-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 09:34, Rahul T R wrote:
> Add a pattern property for clock, also update the example with
> a clock node
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  .../bindings/mfd/ti,j721e-system-controller.yaml       | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index fa86691ebf16..290b22cab52f 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -48,6 +48,10 @@ patternProperties:
>      description:
>        This is the SERDES lane control mux.
>  
> +  "^clock@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
> +

Thanks for the changes, but the question what is this remains. Clock
consumers use "clocks" property. Is this a clock controller (provider)
instead?

Best regards,
Krzysztof
