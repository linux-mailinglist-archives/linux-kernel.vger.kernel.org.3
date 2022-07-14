Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4951574B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbiGNKsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiGNKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:48:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2EEC49
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:48:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n18so2159580lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lYPK+FR9QlQunQ5e2bb17sOGkUvqMrLrMpRak426OwE=;
        b=jRD3RuUpo82q4zCGAhh3KQlLVH9CbUbBfajTaXnK2vjMw++HD8q8iYQKFK+uqTa6xK
         n+XUagc7df0qu4ybKOUEa/zsM3mwsd1yvH7yQd4E+waRWeZCwVp62WqjuprWO/sok5Nq
         jt6gwb8EvbdAy+cCoruNaeziwAkPGEWBkDBgBFxPI+qgnLqyE/M/fh97VesRdFETBr9d
         WA2p4bHB0/ofKyOTGv06wTxPHhxdPNxSzA+LvlVoDvl9RfXH3Bjn4bKsq+3ylS7s47wn
         zsQttORNt0wjWxMWRyJQ5jkcU29cmc4/KbaPCJQYrAuAxfh6WH41UQP00GkEzdvrsgQx
         oANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lYPK+FR9QlQunQ5e2bb17sOGkUvqMrLrMpRak426OwE=;
        b=B0aZobPOc5Q6AYdebPkbSqN/z10Elz5Q7OUdHdkMH6aDQf9NXR6reKtq8v0mOWe4FG
         mHHoAnDUKGq0lStAfynUZJ/64nobmz6+McmbZ/O0qTEVIJGZvJas7DnJDPpIcvGbbSOE
         wjiQJQu4SprCfCpgwrxAPX819OMlyw2h+7EduSFNHN1iyzZEL70TdJ5MpIKaEfvpumS2
         QZgxqhl9wllUblZxaaSzo/Pgtv8jIcT3EyGv50B52WeEE1r2mngBwcZJOoWE9oD2qNtf
         nAexyCjSxzA2ZVkrF0kVwJfNQzkPe4NeMR89WavFVeUSWfwh9CT4gxk7+ha07TF3OlbC
         PVNg==
X-Gm-Message-State: AJIora+EsfVUjnfaGHJ2qIYMBKxeEcOJqxr3DgZeVuOOnK1tYpdgQ2lT
        QGl7KHFoQenhMF1fCq3npPylr9rCu2dYLg==
X-Google-Smtp-Source: AGRyM1sCf/dPPYqI2QP9x8yF61VI9SF6qyNmP6+0x8yMr5iY4jmYX3UEitGS++GI8qgtLn6+wfX0hQ==
X-Received: by 2002:a05:6512:ea2:b0:486:1dbb:653b with SMTP id bi34-20020a0565120ea200b004861dbb653bmr5068577lfb.328.1657795713566;
        Thu, 14 Jul 2022 03:48:33 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id t14-20020a05651c204e00b0025d6838b10asm217358ljo.117.2022.07.14.03.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 03:48:32 -0700 (PDT)
Message-ID: <53c2f480-cd27-4e93-0d97-d0bf07314025@linaro.org>
Date:   Thu, 14 Jul 2022 12:48:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/7] dt-bindings: usb: qcom,dwc3: add SC8280XP binding
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220713131340.29401-1-johan+linaro@kernel.org>
 <20220713131340.29401-2-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713131340.29401-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 15:13, Johan Hovold wrote:
> Add SC8280XP to the DT schema.
> 
> Note that the SC8280XP controllers use the common set of five clocks and
> an additional set of four interconnect clocks whose purpose is not
> entirely clear at this point.

Thank you for your patch. There is something to discuss/improve.

>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq4019-dwc3
> +              - qcom,ipq6018-dwc3
> +              - qcom,ipq8064-dwc3
> +              - qcom,ipq8074-dwc3
> +              - qcom,msm8953-dwc3
> +              - qcom,msm8994-dwc3
> +              - qcom,msm8996-dwc3
> +              - qcom,msm8998-dwc3
> +              - qcom,qcs404-dwc3
> +              - qcom,sc7180-dwc3
> +              - qcom,sc7280-dwc3
> +              - qcom,sdm660-dwc3
> +              - qcom,sdm845-dwc3
> +              - qcom,sdx55-dwc3
> +              - qcom,sdx65-dwc3
> +              - qcom,sm4250-dwc3
> +              - qcom,sm6115-dwc3
> +              - qcom,sm6125-dwc3
> +              - qcom,sm6350-dwc3
> +              - qcom,sm8150-dwc3
> +              - qcom,sm8250-dwc3
> +              - qcom,sm8350-dwc3
> +              - qcom,sm8450-dwc3
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: The interrupt that is asserted
> +                when a wakeup event is received on USB2 bus.
> +            - description: The interrupt that is asserted
> +                when a wakeup event is received on USB3 bus.
> +            - description: Wakeup event on DM line.
> +            - description: Wakeup event on DP line.
> +        interrupt-names:
> +          items:
> +            - const: hs_phy_irq
> +            - const: ss_phy_irq
> +            - const: dm_hs_phy_irq
> +            - const: dp_hs_phy_irq
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc8280xp-dwc3
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 4
> +        interrupt-names:
> +          items:
> +            - const: pwr_event
> +            - const: dp_hs_phy_irq
> +            - const: dm_hs_phy_irq
> +            - const: ss_phy_irq

Could you keep the closest order to exiting ones? In that case first
entry will differ, but rest at least will be the same.

>  
>  additionalProperties: false
>  


Best regards,
Krzysztof
