Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0388A5667B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiGEKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiGEKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:19:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0313E1400E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:19:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y16so19710594lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7ltLTaBEV4Dndg/PZxmASrNkQw7/tHT8uBCcJkojjNo=;
        b=sshcdqW44eA9XhkENF4BsPVKcelBUpolYOWfgzC458pv/AsvxQSgJYyMapsgffJtas
         VutA2/jow5ZMwCG/WJX22xI+iaJOamCPkthvcHYRzzFxS7w3OVnLGSu4BJ7adk9QHIpO
         YYWiUI85XJyCdpwE7ytHyXrLT6DrS4+IkG8/0czlhbyy98KlZVSKMkoTbT2IsErFfnrW
         lDfF6ks7GaIQGmmb+/O5C/fqHBTZd2iDq/pUGJ+I04zgRpnV1czETUBhbleR0nJjkvky
         m13j2Zw+glqkyLvmuYtBni7C52LLIfBzG8o7gISUjCagIKzWRRjO7cPgYM/cGbaA5ULh
         rq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7ltLTaBEV4Dndg/PZxmASrNkQw7/tHT8uBCcJkojjNo=;
        b=do3o7vydGLdduwU0S1tf4qpJnjWeeOa69+leA1TqNJ4PnO82qNVwScKEpm8RARw7uD
         d2MjQaNrDJ08GQBQzkT6HNSMNrHb7UdJvAWjRY7A2gpG42cr/xsIHhYopMV3AwxehPQW
         QGmjWN933BmNDNENcIgh9RQypE1eKTgJZLLp4RNjo4dGy7L95Z29XMQkHMY0vt4zOWRW
         SWoXzVp7ybPhVD0OXVA3GjsC0ruN5npS56h/IE0EGY8A/6wOPw5syHOtLI8PABbWXi0v
         OSyZ/3bNdr5KU8E8r2WPwXA8+Xs5zJIqrEEM29Ige8mulUT0ho99MTZI3jPSyUM0uYLh
         ZKnw==
X-Gm-Message-State: AJIora9/B/YVtZ7fb7WkGJo56XXg9VduIGQdekVJI0xcEhHrY7VQQDUf
        Bpq86tyLe3RFIvuE5fyo6eBapA==
X-Google-Smtp-Source: AGRyM1ubhhSgV3Tz/xKqrayJWFA5svm/yrJxl4CpDllXR/27n6qEPxHLci9PU+ox5DFVjkhsy7Jycw==
X-Received: by 2002:a05:6512:2207:b0:47f:70b3:52d with SMTP id h7-20020a056512220700b0047f70b3052dmr21424409lfu.174.1657016375352;
        Tue, 05 Jul 2022 03:19:35 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id 17-20020a2eb951000000b00253bc47c202sm5528776ljs.59.2022.07.05.03.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:19:34 -0700 (PDT)
Message-ID: <f6e9bba4-6ffc-7df9-152d-caae0c90f1b2@linaro.org>
Date:   Tue, 5 Jul 2022 12:19:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 20/43] dt-bindings: phy: qcom,qmp: split out UFS PHY
 binding
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-21-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-21-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 11:42, Johan Hovold wrote:
> The QMP PHY DT schema is getting unwieldy. Break out the UFS PHY
> binding in a separate file.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  65 --------
>  .../bindings/phy/qcom,qmp-ufs-phy.yaml        | 149 ++++++++++++++++++
>  2 files changed, 149 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index f416a1a53a3f..04c24f8e4526 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -19,32 +19,21 @@ properties:
>      enum:
>        - qcom,ipq6018-qmp-usb3-phy
>        - qcom,ipq8074-qmp-usb3-phy
> -      - qcom,msm8996-qmp-ufs-phy
>        - qcom,msm8996-qmp-usb3-phy
> -      - qcom,msm8998-qmp-ufs-phy
>        - qcom,msm8998-qmp-usb3-phy
>        - qcom,qcm2290-qmp-usb3-phy
>        - qcom,sc7180-qmp-usb3-phy
> -      - qcom,sc8180x-qmp-ufs-phy
>        - qcom,sc8180x-qmp-usb3-phy
> -      - qcom,sc8280xp-qmp-ufs-phy
> -      - qcom,sdm845-qmp-ufs-phy
>        - qcom,sdm845-qmp-usb3-phy
>        - qcom,sdm845-qmp-usb3-uni-phy
>        - qcom,sdx55-qmp-usb3-uni-phy
>        - qcom,sdx65-qmp-usb3-uni-phy
> -      - qcom,sm6115-qmp-ufs-phy
> -      - qcom,sm6350-qmp-ufs-phy
> -      - qcom,sm8150-qmp-ufs-phy
>        - qcom,sm8150-qmp-usb3-phy
>        - qcom,sm8150-qmp-usb3-uni-phy
> -      - qcom,sm8250-qmp-ufs-phy
>        - qcom,sm8250-qmp-usb3-phy
>        - qcom,sm8250-qmp-usb3-uni-phy
> -      - qcom,sm8350-qmp-ufs-phy
>        - qcom,sm8350-qmp-usb3-phy
>        - qcom,sm8350-qmp-usb3-uni-phy
> -      - qcom,sm8450-qmp-ufs-phy
>        - qcom,sm8450-qmp-usb3-phy
>  
>    reg:
> @@ -202,60 +191,6 @@ allOf:
>        required:
>          - vdda-phy-supply
>          - vdda-pll-supply
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - qcom,msm8996-qmp-ufs-phy
> -    then:
> -      properties:
> -        clocks:
> -          items:
> -            - description: 19.2 MHz ref clock.
> -        clock-names:
> -          items:
> -            - const: ref
> -        resets:
> -          items:
> -            - description: PHY reset in the UFS controller.
> -        reset-names:
> -          items:
> -            - const: ufsphy
> -      required:
> -        - vdda-phy-supply
> -        - vdda-pll-supply
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - qcom,msm8998-qmp-ufs-phy
> -              - qcom,sc8180x-qmp-ufs-phy
> -              - qcom,sc8280xp-qmp-ufs-phy
> -              - qcom,sdm845-qmp-ufs-phy
> -              - qcom,sm6350-qmp-ufs-phy
> -              - qcom,sm8150-qmp-ufs-phy
> -              - qcom,sm8250-qmp-ufs-phy
> -    then:
> -      properties:
> -        clocks:
> -          items:
> -            - description: 19.2 MHz ref clock.
> -            - description: PHY reference aux clock.
> -        clock-names:
> -          items:
> -            - const: ref
> -            - const: ref_aux
> -        resets:
> -          items:
> -            - description: PHY reset in the UFS controller.
> -        reset-names:
> -          items:
> -            - const: ufsphy
> -      required:
> -        - vdda-phy-supply
> -        - vdda-pll-supply
>    - if:
>        properties:
>          compatible:
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
> new file mode 100644
> index 000000000000..4471f1b4fb7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/qcom,qmp-ufs-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +

All previous comments apply.


Best regards,
Krzysztof
