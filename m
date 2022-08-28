Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CEB5A3E4F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 17:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiH1PR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 11:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiH1PRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 11:17:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C8132BB6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:17:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d23so8055177lfl.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=BMuuUb/NaeWhjQcPAxYkzgwYaDlCaxqCOLQwvGkupzQ=;
        b=uA/eYj82exJMjuY9e7J6YvqzGs6YO2wd4Wsr7KaEG9xbmki2/uIeuU5S33fT3K9diB
         WgVTvWBBEAMfuqfPwfQ+81YHWlEDECkcf2J6Xa6Fel+3p3pCGqorCHJjUwtbyqMsFNQj
         jcRB9DEegyraelWmi47qRX/MJrsMOrLbAQwoqnUMgwW6jas1sIu9CC0ynj1GY5A5k75B
         +UHOU59nFHgongKrbt1SYOzq9mSd7aBfAep+U+axYK+Lhd8wXOpUQht2R1ab5E+TWaZ5
         ObU8XfENayynqBya3sIC3zPddyhd5LYxuNs1Sw6LoL2J0hccsru3X8bWXuInFvNIeBGP
         7u6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BMuuUb/NaeWhjQcPAxYkzgwYaDlCaxqCOLQwvGkupzQ=;
        b=LJTtM8x3+X2eOGTepczXs04+oImoD+Q/5+hHIbWYaIH23zdcIiLSpePQmoLIWSYg3+
         DM5Qoz6j+KcERNcOjB9/xK/s/BO4lt7bhtISYOcIKgw76mIdEEvykQe+r1XgBForQiSI
         q45PsCiN4FGSSZwM7S/P6gaXQW93Mx5SQdF6hFWnNW4tIizf1TbKEfTB5sZwqONznfnO
         hANYBu0Ekax//FFNLAykpSMfSM4EX1o3mgCGdI8MPnoBQijwK82NmbBjgCe3jg0yzk8U
         K+NL5vpidmbcrvsHZqjkUBiZk8E9Iruv8Tn3dQAP9r34ViwYai4XkuMH/e/Mwj5VhkaT
         4qvw==
X-Gm-Message-State: ACgBeo3nP5HIZDNXXPPAePKU8H/fuGPkzumtZERfObUBA8vVj69r19w6
        RT0m+MwTBf7wjLvbjBhwqso89g==
X-Google-Smtp-Source: AA6agR6tu+b4muuv2A0ZBoDeroPsUwu4gpumy7bfnEz+AL7GSsv6EMfNFci9UDZ+n1q+JzTVkBs05A==
X-Received: by 2002:a05:6512:31cc:b0:494:6815:a81b with SMTP id j12-20020a05651231cc00b004946815a81bmr1214134lfe.511.1661699870192;
        Sun, 28 Aug 2022 08:17:50 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c2-20020a056512324200b0048b0696d0b1sm121184lfr.90.2022.08.28.08.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 08:17:49 -0700 (PDT)
Message-ID: <53897584-f9a1-d305-4024-79a73d2837d8@linaro.org>
Date:   Sun, 28 Aug 2022 18:17:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 10/11] dt-bindings: PCI: qcom-ep: Add support for SM8450
 SoC
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
 <20220826181923.251564-11-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826181923.251564-11-manivannan.sadhasivam@linaro.org>
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

On 26/08/2022 21:19, Manivannan Sadhasivam wrote:
> Add devicetree bindings support for SM8450 SoC. Only the clocks are
> different on this platform, rest is same as SDX55.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 83a2cfc63bc1..9914d575ec41 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -12,6 +12,7 @@ maintainers:
>  properties:
>    compatible:
>      const: qcom,sdx55-pcie-ep
> +    const: qcom,sm8450-pcie-ep

You need to test the bindings with `make dt_binding_check`. This
requires an enum instead of two consts.


Best regards,
Krzysztof
