Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF97529AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbiEQH0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241102AbiEQH0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:26:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFF91055D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:26:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ks9so32922087ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=mkv+AFLKZ6z0pAWxiMD1eopJToeMN6aA5f5FUcc/dXc=;
        b=djzgp8BTUZLH3FFMHVMXHi+RtKuPZCyyi+WeIn35v+xQ0YLN/eVBWWr0O7nSEe5XRE
         RSXkIbxBerlskygCynbFApJ5+f6ctyT9lXsQP64L4fkhhJfXFlPAUFKqg6KoWz+dnumx
         ZSB68iDT0kCh0exTS0PUZ0Dg/PswM5X53OaD5UUpuJJkFIzSANPssYzujL7MMcXd90y4
         mJ2x2Losq1/2oz42FgJ1HauyUdcxTAf397rPzQ43R1oi2+AudM987DF+q4Y6EfHoz8j5
         k3NDeu80iCyecY7fmIqvzpaNO4JLDWdJyDbgbnbd2qk+YPcE9a54qZ/v5WvGeaSZP8Ld
         46aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mkv+AFLKZ6z0pAWxiMD1eopJToeMN6aA5f5FUcc/dXc=;
        b=1TEJ7W2I8zVCyX2TbRo+zdcT2OFZdMCcBLv86nsIqKXZ7DGWEuvTr5sm7nJ39RwBkc
         yBcWj6ZaDjtG3crBqQQfR4UvfiWtceE2ZorXA7EpySqGPoo2lznu+9b4p0q2Ai4XCmMz
         xcFV7Q+VCHj+Yt0G/BmI4jHUewhzxDIolwMm7wj7hvCbxjIIel9RakXDBLkVYUYEvBuC
         KXev2gxbdj951h+9i3SdOYidLefbWtezvw6/7x5rJpSLu6MwMhq3WwshU/HedCmsn0j7
         A/nbaAawPCk+yvn7cJC549pB4ICdlUnlg/pDKXAxCXjGy/3lf0xtNur9oIOWD1UdjbhP
         5Gag==
X-Gm-Message-State: AOAM532ZuEnWZN3qn3cPnmil59zf+w4c9T+lSqXq8Oc20vGCX1B7rO3Z
        hPnYVooCPKMDFyzH87byvXU6v8G8dMVSsmvM
X-Google-Smtp-Source: ABdhPJwgO/s2grWZe3PZvtpp+Q5Pvo1W2bpG+p15ZvVLJiQz2sQvGpgkchxCLLh4NmCrawcJmR9+JQ==
X-Received: by 2002:a17:906:9748:b0:6fa:8c68:af0e with SMTP id o8-20020a170906974800b006fa8c68af0emr19080152ejy.153.1652772375886;
        Tue, 17 May 2022 00:26:15 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id hv6-20020a17090760c600b006f3ef214d9esm711213ejc.4.2022.05.17.00.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 00:26:15 -0700 (PDT)
Message-ID: <fa11d71b-d53e-1eb3-22db-e7237c523cd4@linaro.org>
Date:   Tue, 17 May 2022 09:26:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/6] dt-bindings: regulator: qcom,spmi-regulator: Convert
 to dtschema
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220515203118.474684-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515203118.474684-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2022 22:31, Robert Marko wrote:
> Convert the bindings of Qualcomm SPMI regulators to DT schema.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> I am aware that syscon alone is not really acceptable, its converted
> directly from the old text bindings.
> 
> There is also the issue of some MSM8994, MSM8996 and APQ8096 devices using
> '#address-cells', '#size-cells', some even defining reg property for
> regulators.
> 
> Any advice on how to solve these issues is appreciated.
> ---
>  .../regulator/qcom,spmi-regulator.yaml        | 176 ++++++++++++++++++

You miss here the actual conversion... where is the removal of old file?

>  1 file changed, 176 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> new file mode 100644
> index 000000000000..f7da310f1845
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> @@ -0,0 +1,176 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/qcom,spmi-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SPMI Regulators
> +
> +maintainers:
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm660-regulators
> +      - qcom,pm660l-regulators
> +      - qcom,pm8004-regulators
> +      - qcom,pm8005-regulators
> +      - qcom,pm8226-regulators
> +      - qcom,pm8841-regulators
> +      - qcom,pm8916-regulators
> +      - qcom,pm8941-regulators
> +      - qcom,pm8950-regulators
> +      - qcom,pm8994-regulators
> +      - qcom,pmi8994-regulators
> +      - qcom,pms405-regulators
> +
> +  qcom,saw-reg:
> +    description: Reference to syscon node defining the SAW registers
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pm8941-regulators
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: Over-current protection interrupt for 5V S1
> +            - description: Over-current protection interrupt for 5V S2
> +        interrupt-names:
> +          items:
> +            - const: ocp-5vs1
> +            - const: ocp-5vs2
> +
> +patternProperties:

This goes just after "properties:"

> +  ".*-supply$":
> +    description: Input supply phandle(s) for this node
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +

Best regards,
Krzysztof
