Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89C252E9F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348179AbiETKeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348157AbiETKdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:33:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A658190CF6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:33:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v8so11646978lfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LVuXV2CFkZpxeowkVLO5pGMYN265kJ7DW3lBIgIDU24=;
        b=InUnde+pllALKVumjbiMlajeXmkUXICnixbwvCZrM07LAT6bLxW2RoJIoKVpAIqEBP
         SQ454Q8b4hJzKlVazi/dNpk4cl2AuL2k8V5V+nOHwbnU50c+GaysxSlep6oIuwFtqQWv
         DvmNc7Qcg85PjEvJlfbMNfT1/FFRsRdi+Lwk7R8Bgi0azdLVrnumkgnJQyIQB9DeDXje
         j1y6gASuRwcFkP4PtezD0X9dqQgplOIID9/Yy73lmjbEUTQB1EgCnIRXtEL3VRW80Jwk
         5QFy0Vy9jgDdT8kK+4uCTMpiUAfw4i5iAVCVuSXtU1wXtkHIQQqfKl+oYGH0xfaiNsRv
         G2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LVuXV2CFkZpxeowkVLO5pGMYN265kJ7DW3lBIgIDU24=;
        b=OMh/Gh2GFELp+5C7/PIeLib8q5gsqYL/oFUdSKqIybXDoWjipzhrBvKXMBR5aWpihS
         4vqplX2xTuJwUFJqMx8Cm5/1ygg+xMdwJ/mmxcRyGnYsPoWQCGv4cV8hwsNvZ3o/5Vcp
         PMZFbfXW/NauATbyRjQzjGG0sT/F8bBcIeQKcPQW0KvKWTIcF5OWF+MWwYE+Txteg4H2
         haFO9Cb5i9iFtM1yyzh/S0wlBPSMxxsej1JpCP8rcnsVjS+T/LvUcZYvFRICtNmOE9mO
         b/N5Umv9J6+o3yh50/7zitvoJjgcaSmZ3qxZATR0YYILtiwzX0fnFUrCJDAWl9inPemY
         kwsA==
X-Gm-Message-State: AOAM531Tup8sDxjjrUq74XbvITeSDiX9tlfyCdGwYOXlQ13pwnKReaQf
        zMD/clr8ZGC1KrUC5BnOaXcyhQ==
X-Google-Smtp-Source: ABdhPJxV/WhaALYTuCSJnI35g5RQjc0IJIDrx2kW3apuDK+PAwurIeIvcZtE3yzf68WdR3a92Q9bmQ==
X-Received: by 2002:a05:6512:1108:b0:477:93a5:328e with SMTP id l8-20020a056512110800b0047793a5328emr6571383lfg.546.1653042830064;
        Fri, 20 May 2022 03:33:50 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u2-20020a2ea162000000b0024f3d1daef5sm262248ljl.125.2022.05.20.03.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 03:33:49 -0700 (PDT)
Message-ID: <d1072c55-9e1c-83df-0184-7405448bbade@linaro.org>
Date:   Fri, 20 May 2022 12:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/5] dt-bindings: interconnect: qcom: Reuse new
 rpmh-common bindings
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220520070318.48521-1-luca.weiss@fairphone.com>
 <20220520070318.48521-4-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520070318.48521-4-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 09:03, Luca Weiss wrote:
> Stop defining the properties twice and use the ones provided in the new
> qcom,rpmh-common.yaml.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes since v1:
> * New patch
> 
>  .../bindings/interconnect/qcom,rpmh.yaml      | 22 +++++--------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index fae3363fed02..e822dc099339 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -18,6 +18,9 @@ description: |
>     least one RPMh device child node pertaining to their RSC and each provider
>     can map to multiple RPMh resources.
>  
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +
>  properties:
>    reg:
>      maxItems: 1
> @@ -131,28 +134,13 @@ properties:
>        - qcom,sm8450-pcie-anoc
>        - qcom,sm8450-system-noc
>  
> -  '#interconnect-cells':
> -    enum: [ 1, 2 ]
> -
> -  qcom,bcm-voters:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> -    items:
> -      maxItems: 1
> -    description: |
> -      List of phandles to qcom,bcm-voter nodes that are required by
> -      this interconnect to send RPMh commands.
> -
> -  qcom,bcm-voter-names:
> -    description: |
> -      Names for each of the qcom,bcm-voters specified.
> +  '#interconnect-cells': true
>  

So this explains why your previous patch had such values... The order is
messed up - first you move common parts to common file, then you add
SM6350 support.


Best regards,
Krzysztof
