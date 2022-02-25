Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A094C4663
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbiBYNbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241369AbiBYNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:31:15 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA72275A5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:30:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y5so1682225wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iCYug2uN0yJ0h5qzrzM0t/ZXG7y0pW69zdo3//wJ5Mc=;
        b=Iz/C4kfIg+QU3WpdVAdERt4dHyjlNNmL0wic5dOiAa2/KqYsxtSwe/Xosjkk2QmiZU
         8ryyBpvt8iNhB254uJeBq90QEsX8cWGXS8YcWBMjUH2iWu/2UItIYU0qDGVKCdEObZo4
         426WHxKm1HRvHqkWld/rVUJ4k43SvcEkPjifb6JeKZUzRmifV18ZJYgQTfQGC59Ewh/f
         5kQQWOMynPpZOME2jygah+5n4SJ8rRBuRMf96P3q4s38/eob6pzdWzH4I1pbPxun86su
         PylozFcPJ87NWL7Stzbx/8tmSSJCD2qL49xvM7G77NOhRLt4UQEq8HqsPW0LUKlFLn/a
         v8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iCYug2uN0yJ0h5qzrzM0t/ZXG7y0pW69zdo3//wJ5Mc=;
        b=uWVapzcE+i70nB18WtWcbc8BMtQW5mvmK++WYVzb8g1s4pzOPloitewinFBI5QOCf5
         S/EZHsSb+DG337+TEK8xFf/VLwgYIz3zfz1yvFnpMIEK6d0RxjaVdKHRJz4m2c/lQi6Q
         R1pnqt5hCBIEXE8ag45sC8/yF4nLVKnGhh5E4cuyFzTA1O4VFp8mI8Mah8sFySm0DjN4
         Ttnu9UWj/hLmuFrhMpNITBezxCiL0kuzVV5koToK9uBj3364FRUNJiFED6O+bc+pjkch
         nsBZ/wEW3GQXSfESsxzVsUHScoSSSSpCCBI3b8H88tIYxx6DdLPA4yQv5UnF061OT+IJ
         GzmA==
X-Gm-Message-State: AOAM532BKACe4TO/ZCfL9eUTEiISj38w+mfxZiYeJEXo23h3G0K6ed+2
        bdhmqDcZZp3AEGM8cGo0gG0z9w==
X-Google-Smtp-Source: ABdhPJxNOwK0M2yG7dyNvpA4W4t769Dz57u4tDUZ5Yawlwr+ZqoHjyWnaBVu9T+EYcXrNna7M8ECuA==
X-Received: by 2002:a05:600c:211a:b0:380:d7b5:6e3a with SMTP id u26-20020a05600c211a00b00380d7b56e3amr2732823wml.125.1645795839794;
        Fri, 25 Feb 2022 05:30:39 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id a8-20020a056000100800b001e30ef6f9basm3305843wrx.18.2022.02.25.05.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:30:39 -0800 (PST)
Message-ID: <852e35f6-ec8b-ddc6-f81f-f666e899b543@linaro.org>
Date:   Fri, 25 Feb 2022 13:30:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 2/3] dt-bindings: nvmem: brcm,nvram: add basic NVMEM
 cells
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220218070729.3256-1-zajec5@gmail.com>
 <20220218070729.3256-3-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220218070729.3256-3-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/02/2022 07:07, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> NVRAM doesn't have cells at hardcoded addresses. They are stored in
> internal struct (custom & dynamic format). It's still important to
> define relevant cells in DT so NVMEM consumers can reference them.
> 
> Update binding to allow including basic cells as NVMEM device subnodes.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Applied thanks,

--srini

> ---
> V2: Add children nodes description per Rob's request
> V3: Document NVMEM cells as properties
> ---
>   .../devicetree/bindings/nvmem/brcm,nvram.yaml | 25 +++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> index 8c3f0cd22821..25033de3ef6b 100644
> --- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> @@ -14,6 +14,8 @@ description: |
>     NVRAM can be accessed on Broadcom BCM47xx MIPS and Northstar ARM Cortex-A9
>     devices usiong I/O mapped memory.
>   
> +  NVRAM variables can be defined as NVMEM device subnodes.
> +
>   maintainers:
>     - Rafał Miłecki <rafal@milecki.pl>
>   
> @@ -27,11 +29,30 @@ properties:
>     reg:
>       maxItems: 1
>   
> +  board_id:
> +    type: object
> +    description: Board identification name
> +
> +  et0macaddr:
> +    type: object
> +    description: First Ethernet interface's MAC address
> +
> +  et1macaddr:
> +    type: object
> +    description: Second Ethernet interface's MAC address
> +
> +  et2macaddr:
> +    type: object
> +    description: Third Ethernet interface's MAC address
> +
>   unevaluatedProperties: false
>   
>   examples:
>     - |
>       nvram@1eff0000 {
> -            compatible = "brcm,nvram";
> -            reg = <0x1eff0000 0x10000>;
> +        compatible = "brcm,nvram";
> +        reg = <0x1eff0000 0x10000>;
> +
> +        mac: et0macaddr {
> +        };
>       };
