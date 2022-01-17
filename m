Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEE2490FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbiAQRpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238566AbiAQRpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:45:12 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF7DC061574;
        Mon, 17 Jan 2022 09:45:12 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id s13-20020a4aa38d000000b002e28c5100cbso1170383ool.12;
        Mon, 17 Jan 2022 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d1XPYUu2DVsH+3Kz9XrYtlypSTvPCVH2n5Gq/9uSXNE=;
        b=RxPXDrkQTmR8hnlL8FuoL6/ulwyoibbX7KzYLtzc4RUIrfY9Yppl/lZPW+IWU7c8X+
         /89NEeXnEraRIV+zkVVF0IzzEHLc1WNRcsBSX6bxHYsFa83rBKJbn7X1orNrRxd+MuUs
         VFKVkmx0ez+ZuJLLe83XgmQf+h+3I7ozcIkU06HXnPNkZ8rhKV9vkKjUInd81CZDLjRP
         WNqsfERj87z7sAYhSLWDESzpT1PURJXUhrHNYylxxUBMhT3Pg88OEzyceRIK6jTGYgpD
         5rfTgxsTgOvAIleZPFgRKv6fDiI8fUu89z8ZIH9r+2NLEovhjDQx0bYmswXj4GxmGR8Z
         YYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d1XPYUu2DVsH+3Kz9XrYtlypSTvPCVH2n5Gq/9uSXNE=;
        b=AAwyylSOwgUF/pA0DchW5aYLJofRwzAPxafYhe9xs9w1/OiVbovyqjSa4vvvUzMQJG
         jxBIKCThz6l1jf3Ihot/db/8xpsOwXLk5LR/xZZNMuoieboAowiS2xQ6Shs4zrbK3e/C
         3Oq/eBjTIE/anhqsdjTQirH6EyEMopSAczIHl05W1rCPOlbqb7hK7Xp+FXj8r41U07Yt
         AaIGFsjPmzo8qeVRoE6+uRpnZ1obVN2Y8luKg+GgHTAQmQSa61WZsLocenaZiunFXYk+
         XGkBa+IaDTcWEE0v5T+iZ/iiHFPlOJLKwHwTGLTYq5z6ysAaeHeU77hR8av8nTQoY0Ax
         xyfQ==
X-Gm-Message-State: AOAM532BSrP7RgIdxMrBKZyW9YqQ7BXRAn5bHaSpRd9Et/HFcvk8m6FT
        WPTHjhD2FSdkr1JdvTe0f+mf0Az6pvE=
X-Google-Smtp-Source: ABdhPJwy3aRzKPc7tYpWvWtlYnrzSu/EnOn5hytDPFDvXNKo0DrjMhAnSImO6Pl+LrZpHnP7tdd4sw==
X-Received: by 2002:a4a:e87a:: with SMTP id m26mr15597252oom.41.1642441511427;
        Mon, 17 Jan 2022 09:45:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5sm7247321oiv.2.2022.01.17.09.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 09:45:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: watchdog: improve QCOM compatible parsing
 for modern chips
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     ~okias/devicetree@lists.sr.ht, Rob Herring <robh@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111212310.97566-1-david@ixit.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a24227a0-c0eb-be20-c545-906439edf3f1@roeck-us.net>
Date:   Mon, 17 Jan 2022 09:45:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111212310.97566-1-david@ixit.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/22 1:23 PM, David Heidelberg wrote:
> Parse compatible as expected for modern QCOMs.
> 
> Fixes warnings as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: watchdog@17980000: compatible: ['qcom,apss-wdt-sdm845', 'qcom,kpss-wdt'] is too long
>          From schema: Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: watchdog@17980000: compatible: Additional items are not allowed ('qcom,kpss-wdt' was unexpected)
>          From schema: Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
>   - updated compatible list as two compatibles has been added upstream
>   -> resolve merge conflict
> ---
>   .../bindings/watchdog/qcom-wdt.yaml           | 37 +++++++++++--------
>   1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 16c6f82a13ca..4ff8c59c59ab 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -14,22 +14,27 @@ allOf:
>   
>   properties:
>     compatible:
> -    enum:
> -      - qcom,apss-wdt-qcs404
> -      - qcom,apss-wdt-sc7180
> -      - qcom,apss-wdt-sc7280
> -      - qcom,apss-wdt-sdm845
> -      - qcom,apss-wdt-sdx55
> -      - qcom,apss-wdt-sm6350
> -      - qcom,apss-wdt-sm8150
> -      - qcom,apss-wdt-sm8250
> -      - qcom,kpss-timer
> -      - qcom,kpss-wdt
> -      - qcom,kpss-wdt-apq8064
> -      - qcom,kpss-wdt-ipq4019
> -      - qcom,kpss-wdt-ipq8064
> -      - qcom,kpss-wdt-msm8960
> -      - qcom,scss-timer
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,apss-wdt-qcs404
> +              - qcom,apss-wdt-sc7180
> +              - qcom,apss-wdt-sc7280
> +              - qcom,apss-wdt-sdm845
> +              - qcom,apss-wdt-sdx55
> +              - qcom,apss-wdt-sm6350
> +              - qcom,apss-wdt-sm8150
> +              - qcom,apss-wdt-sm8250
> +          - const: qcom,kpss-wdt
> +      - items:
> +          - enum:
> +              - qcom,kpss-wdt
> +              - qcom,kpss-timer
> +              - qcom,kpss-wdt-apq8064
> +              - qcom,kpss-wdt-ipq4019
> +              - qcom,kpss-wdt-ipq8064
> +              - qcom,kpss-wdt-msm8960
> +              - qcom,scss-timer
>   
>     reg:
>       maxItems: 1
> 

