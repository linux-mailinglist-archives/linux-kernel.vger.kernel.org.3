Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A686F58F9C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiHKJIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiHKJIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:08:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1409C8E9B4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:08:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w15so18699734ljw.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8aSxfgZmzS7jY0Wm/91weUN86D1g6cOcN/ECGe85/Mw=;
        b=VJi6eQu2X/Hg0BkM8imHTSLscImoh2e6jRLRcfHyZx8Ws7DKUpfQWbcjDsaYVkxBwZ
         DEhyAI27+iFIF2Y48nNZJryt+F335Ec2ANB9KJJ3ciqTDJv6vhDfktuGXPQ2piZOjZEP
         ezsMy3XHN5iSIyDfrY4XjZGyycovioa8mdhHum7VnUvDcdvAOdqJxfUooZlZh7/ZLKbV
         pk/TBXSfqUya963g/la+KLxWg1ngdoBcFQtC35RHfokFBr+NL3vmXkcHvI4pi8TAKZFN
         dOw+LqpH/r7bjq5PuiwBS5Ymeyvm9ed98Z0Lv3+GdX/ZA6Qd5B9Z7sZYpZ09Jjm70aKh
         8QOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8aSxfgZmzS7jY0Wm/91weUN86D1g6cOcN/ECGe85/Mw=;
        b=0FK/YTyTzYdjdnUSfPTRLluVHDMfil6Q9+pLVSv4RRlc3h2S8X1od+t/UrgOHmyfik
         du5/6iw+4NhRv1VPeGTpmIjt4HEffwDO4zq4/qYcxQ8H0Ivrlh451KxnFj2Z4h7VcpWs
         RbnMHgKZQWSgMcTaIjA2WAlKLq6PChnNGomI5SeLLkJW5V/5s6q7Wgz8iHjn42x/s2y9
         eHrdE0h6EjHp+6+VVvIo4m6bT2DjZD1c9FJOAxaoDzVHeWgakFCowN7TyqqNSVNLsSEh
         XsyKi8OkmRlwc/hoZ/2g6aG/kyDu03glTbucuoQv/0f3FN4ao6JqXsMYfIIGtGoHCYAT
         3Srw==
X-Gm-Message-State: ACgBeo0PziNptQbG2gZHKObG9eA56MvuB6oGdmQfYxZBXCdORPLPeYGR
        iGak9YUnslPKZMuVCWiIYRywQQ==
X-Google-Smtp-Source: AA6agR63X2/DgUWMlPAH/IH8NaEBpjkuL0URYpm8GnHi1XArMqSkvElKF31N5dtQhFvHz3JN7oLraQ==
X-Received: by 2002:a2e:a593:0:b0:25f:e6ac:c28e with SMTP id m19-20020a2ea593000000b0025fe6acc28emr5496200ljp.485.1660208925348;
        Thu, 11 Aug 2022 02:08:45 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u5-20020ac25185000000b0048b3768d2ecsm634751lfi.174.2022.08.11.02.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 02:08:44 -0700 (PDT)
Message-ID: <38ef15b3-382c-12b2-0a34-900208ac3638@linaro.org>
Date:   Thu, 11 Aug 2022 12:08:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add Qualcomm SC8280XP display
 clock bindings
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220811041211.3825786-1-bjorn.andersson@linaro.org>
 <20220811041211.3825786-2-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220811041211.3825786-2-bjorn.andersson@linaro.org>
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

On 11/08/2022 07:12, Bjorn Andersson wrote:
> The Qualcomm SC8280XP platform has two display clock controllers, add a
> binding for these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/clock/qcom,dispcc-sc8280xp.yaml  |  98 +++++++++++++++++
>  .../dt-bindings/clock/qcom,dispcc-sc8280xp.h  | 100 ++++++++++++++++++
>  2 files changed, 198 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc8280xp.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
> new file mode 100644
> index 000000000000..98e5dfd53f76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,dispcc-sc8280xp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display Clock & Reset Controller Binding for SC8280XP
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description: |
> +  Qualcomm display clock control module which supports the clocks, resets and
> +  power domains for the two MDSS instances on SC8280XP.
> +
> +  See also:
> +    include/dt-bindings/clock/qcom,dispcc-sc8280xp.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sc8280x-dispcc0
> +      - qcom,sc8280x-dispcc1

These are two independent and different devices, right? Driver seems to
confirm this which would justify using indexes in compatible.

> +
> +  clocks:
> +    items:
> +      - description: AHB interface clock,
> +      - description: SoC CXO clock
> +      - description: SoC sleep clock
> +      - description: DisplayPort 0 link clock
> +      - description: DisplayPort 0 VCO div clock
> +      - description: DisplayPort 1 link clock
> +      - description: DisplayPort 1 VCO div clock
> +      - description: DisplayPort 2 link clock
> +      - description: DisplayPort 2 VCO div clock
> +      - description: DisplayPort 3 link clock
> +      - description: DisplayPort 3 VCO div clock
> +      - description: DSI 0 PLL byte clock
> +      - description: DSI 0 PLL DSI clock
> +      - description: DSI 1 PLL byte clock
> +      - description: DSI 1 PLL DSI clock
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    description:
> +      A phandle and PM domain specifier for the MMCX power domain.
> +    maxItems: 1

Three lines can be shorter:

items:
 - description: MMCX power domain

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
