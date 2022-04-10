Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE64FACFD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiDJJBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 05:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiDJJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 05:00:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8617F5C640
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:58:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z99so6149476ede.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JFX533NuQqTvrQqJuffC8j9JQ1wOAyBQkOCJGQOKmfY=;
        b=ZUrgrIc/hCeQ93qMHjV9hA4zGWWEXT9nCNU3N/y0myeeik0/CNUUdx2MbAj6X+S8J3
         X7281RVJj3qk7wY/JwCPK7rjYGGJy1TwE4SL8iVomkuW+CLdVcCvw7vxUJBWEGwmeXY7
         hNVz5tW6f0xbdoPft7B74cgvDmCMFGdZYXmJW5l8VB090bVXGsfIyu+c1uMz4Xaybfc5
         x4YUsSrd2veAI1oFDsuFQZdoJDkBWE/FZ1b6/RgxC0+vU6j7v3ds55di+Sv4h6ka+H5E
         7fSjdqTNap2NafdcfTeaEv12LR3dtyLOKv1ezzCEDpyLNQTpeG7Af57jpuSWwbNgdDaT
         FT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JFX533NuQqTvrQqJuffC8j9JQ1wOAyBQkOCJGQOKmfY=;
        b=tkSgOGwacWBbWo4HKcPUrfXZnpBiSa5CC4h+0pcevtHyT/dtKkqMzk3cxA66t+mdiz
         Dsl78Gl9aBVhIxy6t7Jls7n6Le5u0yxJzovgid8CLkN+QUSEoXn8kPS2pg8OJ/irsNVM
         LQitCW6DGq4Tpl4Zofzxk14lrcZL7+QG4v7rvmEm2AItWftFmqKKBXJ6TQWlNAl48jOQ
         hTNzE6yR8tWlpxovqepAs/FdHEdGvbIdpU3N2mIWhf+Qm0Bd3thtE/KJOhmkWswWV7lh
         sgnkLWTSKARhhA88CGf5mZKw8SOzVWp+7aCe9Zs5hboNzU+ZabKDnYotKr+Dgah6cIWm
         T5Kg==
X-Gm-Message-State: AOAM533XZ900VIeqZlmfKfOHpZTUr0/6Ob3rT7FStvOievKbX8qwHEXu
        gH6Ni12E5VyEVbBFR5LxIRbcgA==
X-Google-Smtp-Source: ABdhPJxKJRbTErQIz0J6+3cst4WNTzb+Ci+4ig6b0DTTHr1CXk0jvrivdMzRNRBK2zeOuxj/JQCHOA==
X-Received: by 2002:a05:6402:d4c:b0:410:a415:fd95 with SMTP id ec12-20020a0564020d4c00b00410a415fd95mr27872574edb.288.1649581128102;
        Sun, 10 Apr 2022 01:58:48 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id y17-20020a056402359100b0041926ea1e12sm13543144edc.53.2022.04.10.01.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 01:58:47 -0700 (PDT)
Message-ID: <7659ba7c-1db8-1cdf-d969-d100785f20aa@linaro.org>
Date:   Sun, 10 Apr 2022 10:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: firmware: convert Qualcomm SCM binding to
 the yaml
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211218194038.26913-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20211218194038.26913-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2021 20:40, David Heidelberg wrote:
> Convert Qualcomm SCM firmware binding to the yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> This patch comes with followup question -> since not all definitions
> follow `"qcom,scm-*chipset*", "qcom,scm"`, should I change them or adjust this
> binding to cover all cases?
> 

Thank you for your patch. I hope you will continue to work on this and
send a v2. :)

There is something to discuss/improve.

>  .../devicetree/bindings/firmware/qcom,scm.txt |  54 ---------
>  .../bindings/firmware/qcom,scm.yaml           | 112 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> 

(...)

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,scm-apq8064
> +          - qcom,scm-apq8084
> +          - qcom,scm-ipq4019
> +          - qcom,scm-ipq806x
> +          - qcom,scm-ipq8074
> +          - qcom,scm-mdm9607
> +          - qcom,scm-msm8226
> +          - qcom,scm-msm8660
> +          - qcom,scm-msm8916
> +          - qcom,scm-msm8953
> +          - qcom,scm-msm8960
> +          - qcom,scm-msm8974
> +          - qcom,scm-msm8994
> +          - qcom,scm-msm8996
> +          - qcom,scm-msm8998
> +          - qcom,scm-sc7180
> +          - qcom,scm-sc7280
> +          - qcom,scm-sdm845
> +          - qcom,scm-sdx55
> +          - qcom,scm-sm8150
> +          - qcom,scm-sm8250
> +          - qcom,scm-sm8350
> +      - const: qcom,scm
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names: true
> +
> +  qcom,dload-mode:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: >

No need for >

> +      TCSR hardware block and offset of the download mode control register

Could you define the items (and I think it has to be phandle-array in
such case) like here for samsung,sysreg:
https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42

This helps to validate the actual phandle.

The DTSes have also few other properties (like reset-cells). They can be
added in this commit, just please mention it in the commit msg.

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,scm-apq8064
> +              - qcom,scm-msm8660
> +              - qcom,scm-msm8960
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: core
> +
> +      required:
> +        - clocks
> +        - clock-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,scm-apq8084

Based on the driver you also need (this can be in separate commit or
just mention in commit msg):
qcom,scm-mdm9607


Best regards,
Krzysztof
