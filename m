Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89346F1FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbhLIRgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243006AbhLIRgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:36:15 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C604C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:32:41 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o13so10916889wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MnZ8XxoV/JNSKycvbGgmmnjtRwN6D7AwRUUOOMU+Mdw=;
        b=OXy7hbkQO4VBUZfxujencxRfCDtrWn8l6ADXaQvtZONpuVXUqGlbnDZjZ6MYuMK1kz
         Ib3+YPOGQf+l6YXBcy77E5yJhWCLMJLfnSc+oILTWxWFa2l4sODvgwlLmizQlFSkQVGZ
         Q8wvY/71JnyrCRlesbrXOThx1t+k9w6VSJrDRdVAeAIeHjlHKYQIJAdHfu8s8j0CgF8C
         8WD6l2kzyF4IYzuoSIiIJSf4FZPrv0C525Yge9d8DrcLl3zkupxnFmoq75rR/0xMCHZf
         4cKv2Of8mh0o1luLsCFTPJsObWh1beMOJpmmJm8RUsJNaRoEKNqCrjcM+26S9S2rBzr1
         TZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MnZ8XxoV/JNSKycvbGgmmnjtRwN6D7AwRUUOOMU+Mdw=;
        b=nDEPZRVRauHIqmDDuhQjs6WJ/AWcdtoWmPqBUYLTnw2VgwtnbXQJDCv5xoSFHmKIKY
         Prg3RwMosZ6HGwYrSzmNIwdsXkDpYaj56BUETp2D5hSsdh14d1fKYH83LQ2QkL5DVGeE
         k6uxGDwOrEAyVrND546yXRPmfOeFvORPQORMEXeaD/z3+nclYrWDXkJu+Jt/U1XBMs2z
         /xZV0LypjNTB0/6xCOZj6B3TXgcYqw3MzRcg1LzxDkP8NjpDtbHlC0WUZIDl5Bo3MtMG
         AXmAllq4TDpA71o8rax7BWkt/QaKOOUkdjoXv92+YngFgQ0lEktXSY74UV40KnfQiVui
         1D3A==
X-Gm-Message-State: AOAM533JLgstGz9ovNyvnNixIQ9umUXESX6uSLCRGYGZK68end2P06rM
        DQ0+sejlUtPySD2/5TkZq1ACnN9Yp/uJEw==
X-Google-Smtp-Source: ABdhPJwEZnAMTP1IrzgOOydDuBQdzc5f1/tqdbw72jT2SJXr29DrudN2m4jy01eVW1SRHN131+SAhQ==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr8053459wrs.435.1639071159488;
        Thu, 09 Dec 2021 09:32:39 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id d188sm9692560wmd.3.2021.12.09.09.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 09:32:39 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: nvmem: Add missing 'reg' property
To:     Rob Herring <robh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211206174133.2296265-1-robh@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c676e23c-3c44-c28c-d572-499fe8d4ee8f@linaro.org>
Date:   Thu, 9 Dec 2021 17:32:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206174133.2296265-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2021 17:41, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the following warnings
> are generated in the nvmem examples:
> 
> Documentation/devicetree/bindings/nvmem/st,stm32-romem.example.dt.yaml: efuse@1fff7800: Unevaluated properties are not allowed ('reg' was unexpected)
> Documentation/devicetree/bindings/nvmem/rmem.example.dt.yaml: nvram@10000000: Unevaluated properties are not allowed ('reg' was unexpected)
> Documentation/devicetree/bindings/nvmem/brcm,nvram.example.dt.yaml: nvram@1eff0000: Unevaluated properties are not allowed ('reg' was unexpected)
> 
> Add the missing 'reg' property definition.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Rafał Miłecki <rafal@milecki.pl>
> Cc: Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied thanks,

--srini
> ---
>   Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml     | 3 +++
>   Documentation/devicetree/bindings/nvmem/rmem.yaml           | 3 +++
>   Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 3 +++
>   3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> index 58ff6b0bdb1a..8c3f0cd22821 100644
> --- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> @@ -24,6 +24,9 @@ properties:
>     compatible:
>       const: brcm,nvram
>   
> +  reg:
> +    maxItems: 1
> +
>   unevaluatedProperties: false
>   
>   examples:
> diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
> index 1d85a0a30846..a4a755dcfc43 100644
> --- a/Documentation/devicetree/bindings/nvmem/rmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
> @@ -19,6 +19,9 @@ properties:
>             - raspberrypi,bootloader-config
>         - const: nvmem-rmem
>   
> +  reg:
> +    maxItems: 1
> +
>     no-map:
>       $ref: /schemas/types.yaml#/definitions/flag
>       description:
> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> index a48c8fa56bce..448a2678dc62 100644
> --- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> @@ -24,6 +24,9 @@ properties:
>         - st,stm32f4-otp
>         - st,stm32mp15-bsec
>   
> +  reg:
> +    maxItems: 1
> +
>   patternProperties:
>     "^.*@[0-9a-f]+$":
>       type: object
> 
