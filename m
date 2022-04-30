Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB0515E50
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbiD3Oqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242461AbiD3Oqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:46:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78896621A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:43:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t5so1431708edw.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Ae7sNcHPWMn0vQt8ktazZVFlpIwIv2WIixfHk4+kCCs=;
        b=R03VAAwVTDiVdVvlB4UrMenl7xp/UpjZLcoRbp4/jp5vDn6wjTFrjllooWfuKDUy4C
         mNrMBFMThe2AtywO46d5WROs0dtF4F6lMQm6Hvp1jC4xDt4EViOJ5quaGM2kSY1C16gy
         9r8ojzX34iXZKf1bql7rTKVqClqgIvmFa8JfGZRyZZR2nR/8eumAWVKR6P7PPwnz9lZu
         MdBjsLya7QzRlZmWxmf9TWxTXZsIDmmIA3G6lMhapcvM/479Kg+UBhtoxzJ4WZymeqkP
         4fesp6bFshwwuUpjHQvYyUj3LLLG4Sjsa64FPNPrgw/RBjnFI1Oirhl8n3eCs8Y251BU
         11fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ae7sNcHPWMn0vQt8ktazZVFlpIwIv2WIixfHk4+kCCs=;
        b=mv3Ic/MEoSxDxVnY4P8E+IiSg04gRIua4bYSyrT4cmmznJpYi+pTCr4nkJX7T0lXzN
         QxQicdsY4aOvPNH1OvHOH3RDoUp6HQ/uftd9rDPIACUOjOQYGnQyx5M5l5i5NUY9VUKN
         ErFdrEC7/bGgxFRJGwpmdh0Qkha6L1iexKh4f/P8HnCQZhIwb6NPqaHJf/l+sfQJpkVR
         mPtChARsa/JYvzvkvfOnMT3I6uD/UyMIhuTtE4tkS1NFtJ9d5i0u1DiD1OmBJSYPbVVu
         4jxM0nU0S6NfB8YaSeIVJGEve+BytqqU9aRL9gmMoNeKrm7UKOPsrqdXLl9tLCDx2XsS
         /clA==
X-Gm-Message-State: AOAM533fx1qScxQebiai2CTYsmS3D3OxXRbZHhptV6336OJcxvOpbKRx
        xzHWMrlyuMG8j44vhLI0qhkG3g==
X-Google-Smtp-Source: ABdhPJw/sjjJ325eTLjgrvQ2SuNf9g5yd69OBocxHWeT36O4SGf1AKPyCMPkC1ksmQ5yoT6VPZtWwQ==
X-Received: by 2002:aa7:cb4d:0:b0:425:e24f:96ba with SMTP id w13-20020aa7cb4d000000b00425e24f96bamr4755602edt.214.1651329802286;
        Sat, 30 Apr 2022 07:43:22 -0700 (PDT)
Received: from [192.168.0.180] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ck13-20020a0564021c0d00b00427afbbf5e8sm527102edb.11.2022.04.30.07.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 07:43:21 -0700 (PDT)
Message-ID: <62709b53-392f-2463-8124-e109f2d810dd@linaro.org>
Date:   Sat, 30 Apr 2022 16:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] dt-bindings: mtd: qcom_nandc: document
 qcom,boot_pages binding
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220429211630.7812-1-ansuelsmth@gmail.com>
 <20220429211630.7812-3-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220429211630.7812-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 23:16, Ansuel Smith wrote:
> Document new qcom,boot_pages binding used to apply special
> read/write configuration to boot pages.
> 
> QCOM apply a special configuration where spare data is not protected
> by ECC for some special pages (used for boot partition). Add
> Documentation on how to declare these special pages.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mtd/qcom,nandc.yaml         | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> index 84ad7ff30121..ef243109689d 100644
> --- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> +++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> @@ -78,6 +78,17 @@ allOf:
>              Must contain the ADM data type CRCI block instance number
>              specified for the NAND controller on the given platform
>  
> +        qcom,boot_pages:

No underscores in property names.

> +          $ref: /schemas/types.yaml#/definitions/uint32-array
> +          description:
> +            Some special page used by boot partition have spare data
> +            not protected by ECC. Use this to declare these special page
> +            by defining first the offset and then the size.
> +
> +            It's in the form of <offset1 size1 offset2 size2 offset3 ...>

Then it look like uint32-matrix.

> +
> +            Refer to the ipq8064 example on how to use this special binding.

Property does not look valid for other variants, so it should be made
false for them (in allOf:if:then).

> +
>    - if:
>        properties:
>          compatible:
> @@ -135,6 +146,8 @@ examples:
>          nand-ecc-strength = <4>;
>          nand-bus-width = <8>;
>  
> +        qcom,boot_pages = <0x0 0x58a0000>;
> +
>          partitions {
>            compatible = "fixed-partitions";
>            #address-cells = <1>;


Best regards,
Krzysztof
