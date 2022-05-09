Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD7C51F547
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbiEIH0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiEIHYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:24:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0910FDF36
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:20:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i27so24968242ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ZG0xzzK8vJiWqKJvgd5OTvarjy6BbuTFcq7zDOL5ksc=;
        b=XO7gafFFxQeFRdf8hllKGPtq//LSJWfx88pfqi+gKjVdl8w1ZlhuyTJWFKwU59FinG
         43NHj7SCwjWDg5Z88lFScLEsmUSjXHemy3Ox8Kk54V/WrDE6Jlsb0LPjXJeryJWMxQLe
         A/bRvvJh2Zokjl8Y5Fm9dEWIPTlydNjo4q4vJzfkDFnLQcp5TSJrPHP+gPXlItmFl2QU
         SLusmSc8FBUS4/87unS5K3OziQ5PmHSSNU7h/o2gf9sCnNwTswriXHGQagwtmkUrHx42
         HoMHJ7f2Bq7jGKNojfXHww4n56nW2ttCAya8c8Ay08ecdJ0g/afbYdP2CNfvZXn/xPvD
         +KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZG0xzzK8vJiWqKJvgd5OTvarjy6BbuTFcq7zDOL5ksc=;
        b=0p5W7fdc+6nTs2VFmdudwA/61eCQr+9dHB6Or/LnwoVA2VZvLNMAIOOlR1W78xKDEZ
         eQEtcAVN/JGE4psfxkwBI6Y9LqLm10lYcMNYZgYowcvBnTyJb7Qt8/DMKIhYVa3Oktk+
         JWfNH1jcQwjNeOyU953V7mGWbIMFHsY+nTo3accKN/rmzxphqg1jmQfKMrlv5ArrhujS
         7Ht3A06trb2jn1HqPke00kasIUYybtjzvuor9TT1MhGGYmCT4wf8di09sT0xFplfrJMe
         A1pDOqsSDVxU2jJfBGXHZHe0uiGSFxh8WS+F+TN5KWnQih+FqSYmPGB+6VFl5jaZ/Azx
         IHUw==
X-Gm-Message-State: AOAM5316xnN5NOQo8dALkmqMm4DCZSY3zUT4QjvbmiAcxqQa7yVriuX3
        RPL8HdSYVrLHYZSdYEIOgFxKOg==
X-Google-Smtp-Source: ABdhPJygnuXJ8e2NsWg900fCa87FqVybV4/82xORq2vMAtlsPtFIl+iRFaAack+Lm7mwGv+osi0NLw==
X-Received: by 2002:a17:907:2ce6:b0:6f4:7e8e:af40 with SMTP id hz6-20020a1709072ce600b006f47e8eaf40mr13039893ejc.211.1652080812595;
        Mon, 09 May 2022 00:20:12 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709064f8a00b006f3ef214e35sm4724033eju.155.2022.05.09.00.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 00:20:12 -0700 (PDT)
Message-ID: <ec05bb3d-220f-383c-9d56-8d9b5066a148@linaro.org>
Date:   Mon, 9 May 2022 09:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 07/11] dt-bindings: clocks: qcom,gcc-ipq8074: support
 power domains
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tdas@codeaurora.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220507202948.397271-1-robimarko@gmail.com>
 <20220507202948.397271-7-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220507202948.397271-7-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2022 22:29, Robert Marko wrote:
> GCC inside of IPQ8074 also provides power management via built-in GDSCs.
> In order to do so, '#power-domain-cells' must be set to 1.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  .../devicetree/bindings/clock/qcom,gcc-ipq8074.yaml          | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
> index 98572b4a9b60..e3e236e4ce7d 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
> @@ -27,6 +27,9 @@ properties:
>    '#reset-cells':
>      const: 1
>  
> +  '#power-domain-cells':

Put it in some order, e.g. before reset-cells.

> +    const: 1
> +
>    reg:
>      maxItems: 1
>  
> @@ -39,6 +42,7 @@ required:
>    - reg
>    - '#clock-cells'
>    - '#reset-cells'
> +  - '#power-domain-cells'

The same.

>  
>  additionalProperties: false
>  
> @@ -49,5 +53,6 @@ examples:
>        reg = <0x01800000 0x80000>;
>        #clock-cells = <1>;
>        #reset-cells = <1>;
> +      #power-domain-cells = <1>;

The same.

>      };
>  ...


Best regards,
Krzysztof
