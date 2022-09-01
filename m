Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5CB5A9CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiIAQLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiIAQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:11:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B26D7B7B2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:11:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m7so16231518lfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZT0UUgL98furUMTTllJ+IvKDmlJK1HsHd+roqciqR7g=;
        b=XmjqaXzcNHK1fQAUkelNc1TLbofd+c3HoDH/xwjX0atcCtDwNCfThcM2oD1jrv6mD0
         HUr4r+fomvVC7Ul6Iac4NE1Tr5yPTwFWGkETeoZJsaETaH2SHh+T9dXPx5r5F1mEl4Qz
         4a822TemsMhKG3+p8mYh/6k9vvg2YWdYsQkK5lUCaxqW/hJbZqQlf8JoshSr6abUlpOj
         fXvbFN1zzHUDVcnXxe++nT7/B9Z0y+8TLmQ1BpseEqZFjpc5X34gfHjEgS5hIZskNuGH
         jPV9bFxm6+IRHr98dw8dDx6zTFwZNQSVpfy6Mp+miAStK1ZDk9PADZQHX4/mdIUkGDYz
         T6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZT0UUgL98furUMTTllJ+IvKDmlJK1HsHd+roqciqR7g=;
        b=wOTLlwwtCAYM4VLWgEpI2snN/UD/b+jr4CxoMyGDlBIp4Hdpc7SRlU2br4/o4+FpIm
         4tAxSm0wHh9Qzk+l8UhXLkpm3pMMpV44i6bJYZptFQDdzEMEwOmTfArI64FDsJ2yWp2Q
         DOkWDgN8Nz5MSj6jBxRkFBGUUO5OxvdiCj6nrzYaw7Q3eh5yFJk99ibqZaL6QDOKyHq7
         0R2FOaTH9HqHR3cJ+zhvJAcqYNXm5ajDHj6Mum4R8DFYOX5cAb0IfficpKqzi5Asu9Fo
         FU73YRFbUw/+sXmrd7q0iDJSI6Zdfxr+O6LUZqLnwXf6hzdYGQvSnNPXNn+KJQlg3eKW
         emvg==
X-Gm-Message-State: ACgBeo3xGg2+OedzVaeOL5174coMlLKKhilaeeP5/yNB0cTfstwWR/YB
        ecUkBc995sl2QxhDC055Q65ibg==
X-Google-Smtp-Source: AA6agR7fa2cffMYhl6EVvGJvlvaohMBq/6GEuVCGGl4FC8t88eKtvkuzfo4WFJl3V4F8xXTCVl/DRA==
X-Received: by 2002:a05:6512:260d:b0:492:df5a:e4f9 with SMTP id bt13-20020a056512260d00b00492df5ae4f9mr10306759lfb.90.1662048702494;
        Thu, 01 Sep 2022 09:11:42 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id bd8-20020a05651c168800b002687e283bf1sm754869ljb.134.2022.09.01.09.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:11:41 -0700 (PDT)
Message-ID: <7804ffbe-4e27-d8bd-dbe2-75d1323da064@linaro.org>
Date:   Thu, 1 Sep 2022 19:11:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 08/14] dt-bindings: ufs: qcom: Add sm6115 binding
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-9-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901072414.1923075-9-iskren.chernev@gmail.com>
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

On 01/09/2022 10:24, Iskren Chernev wrote:
> Add SM6115 UFS to DT schema.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index f2d6298d926c..7c5f6e2e6d4c 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -28,6 +28,7 @@ properties:
>            - qcom,msm8998-ufshc
>            - qcom,sc8280xp-ufshc
>            - qcom,sdm845-ufshc
> +          - qcom,sm6115-ufshc
>            - qcom,sm6350-ufshc
>            - qcom,sm8150-ufshc
>            - qcom,sm8250-ufshc
> @@ -178,6 +179,31 @@ allOf:
>            minItems: 1
>            maxItems: 1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm6115-ufshc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 8
> +          maxItems: 8
> +        clock-names:
> +          items:
> +            - const: core_clk
> +            - const: bus_aggr_clk
> +            - const: iface_clk
> +            - const: core_clk_unipro
> +            - const: core_clk_ice

Use existing name and put it in the same place as existing variant - sdm845:
ice_core_clk


Best regards,
Krzysztof
