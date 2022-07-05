Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624BC56677E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiGEKMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiGEKMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:12:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF5613FB0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:12:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id e12so19719349lfr.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mZWko2l3JM33AGERPGLEXqE2EWRggkWimZrxTdJnBrQ=;
        b=lVgc4eTYGqLD0IaHHe8PqmVRvpVMIHWLrYx692D3ISLZALd9+vHr5AzI/P5AvGC46F
         ovwkA24GeZhvo5gQc1mF+A+pB5Ougfktzld939IW7WlA+FjfLOgXuSuhJS1DoTV+NCwq
         bJxoAYLt2Mvd6E0m/2gDpvRjCV0S3/KL/b7eakXGbj/rDfdocwd1YYvJ73mRiosjPoug
         8HdNXa6oBxhYa+ss7Rc1c7HmT23Fqga1td1bKiD42Bvxa4/1oCt/QmGMnKiV7Z5ooQvZ
         qktsH3OgfX3Z0IW6Bhwe4oZza0jMPJm5cEcRWc83nII6vck3vTzyRmjS9P3zWusVHX3z
         r+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mZWko2l3JM33AGERPGLEXqE2EWRggkWimZrxTdJnBrQ=;
        b=yrk58Y6dh1Snya8PDXM08TMYDMVbthjPpB1gmcFKPkNfR3e3JzHeefIeRqSaHEPoZy
         HlZ4Z9gEWJrGDMhtjhyDuMChtJB4Cxbic6E5YEXRVx8dbSQVsgkYtboCXHdKxaRqr6Sm
         9bgjUJ/AFoJgMPmEZeN3k0L2Mcpyn5bR/lMn1jIFwVcQHvOzby+CPVy891IZP4aG12SK
         5cph/u0l5CQFyxcR2A6phfdYpjR+ad+cv75Wfehyh8TF4h7Q4yVOh965NBO925shljWN
         J3zZCU9OjBnnF5AAhUY/5BA4c1j+L1TQyh1UdKgFM7VnfE3lPvy1+6YNRoitIeumZ1eC
         OScw==
X-Gm-Message-State: AJIora8sIwLHr96yLYvydBTczxiTFWrt/p2LMvYZS5QOpI60Wahsi1NW
        GtfW8sr//73LLwPFDRcijHgnWQ==
X-Google-Smtp-Source: AGRyM1sTJIqHUj9k+zJkKMNhCH4MRxYX1aZCBKcFYO69Ra4u9QWn3nqtNVAorRS99L+Md9eq6+appg==
X-Received: by 2002:a05:6512:114e:b0:47f:5f76:22bb with SMTP id m14-20020a056512114e00b0047f5f7622bbmr22600890lfg.648.1657015947264;
        Tue, 05 Jul 2022 03:12:27 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24e69000000b0047f647414efsm5620858lfs.190.2022.07.05.03.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:12:26 -0700 (PDT)
Message-ID: <2a5fec43-352c-b304-e0c9-761e1d2b67ec@linaro.org>
Date:   Tue, 5 Jul 2022 12:12:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 11/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate
 reset names
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
 <20220705094239.17174-12-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-12-johan+linaro@kernel.org>
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
> Drop the unnecessary "lane" suffix from the PHY reset names and mark the
> old names as deprecated.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> index 7931b1fd1476..0bea8270b37e 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> @@ -94,11 +94,15 @@ patternProperties:
>            - description: PHY (lane) reset
>  
>        reset-names:
> -        items:
> -          - enum:
> -              - lane0
> -              - lane1
> -              - lane2
> +        oneOf:
> +          - items:
> +              - const: lane
> +          - items:
> +              - enum:
> +                  - lane0
> +                  - lane1
> +                  - lane2
> +            deprecated: true
>  

How about just dropping reset-names entirely? Marking entire field
deprecated and removing from DTS? The same in the previous patch.

Usually one-item xxx-names do not bring any useful information.

Best regards,
Krzysztof
