Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF594ADED3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383641AbiBHRCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352528AbiBHRCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:02:03 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C81CC06157A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:02:01 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C483D3F22B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644339713;
        bh=mRv1uTKJZ7l44YD+F21PTzrlDlgL7MkwqQ36W1mxcE4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Vd+V75+yEQMM+pGqyqm9XnMivQxI5whe791sOg+pWnDDEEbbyRHy9HLOXh69Ncff4
         0bQaKUqYm9eopM0UZZEs8Gf7X4aC829Gp3f5MlysmkEEhkPA7GOKgPg5JOmQKUZT1L
         l4p196NQVqao8oVSxqKeULINJNTlA8QWHMuTKzTYj5LNX+jCuBtZGN7JpDVWetQN8I
         WLh8YGDffX3yr0M7d6UaBV9COgXsO6YwYD2lmDc+TGUdTbjyc6/vtrGDzmTkpDy0M3
         jmUfEOf1yiYPSzx26gVgBogL7lpsSNQtOTHZPwr20PrcX7fqaTCKmoaSDm6UryTUSB
         wLEOVKkR+SmZA==
Received: by mail-ej1-f69.google.com with SMTP id q3-20020a17090676c300b006a9453c33b0so5965624ejn.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mRv1uTKJZ7l44YD+F21PTzrlDlgL7MkwqQ36W1mxcE4=;
        b=EjU2HcwdequlUTuKDSdT74FUFGpoeWjichPgn2Qt2HLROFAuvN3ovgZ6Z1Mb9lHgg7
         SO5od14KyWPTpx1NkVDq8PFH6elXJMDBKtstYOby8LTTNZL4NkHfl5ifztFuYez1g24o
         9raLBoJhAWIdHzSaPD7FD5IzpeQYOe/XjefzO2b0cYyNHZwa9gNNf9WGjcVk3UxqH2RP
         nCB9VsNPvmOUkMj1L3K41I+AiMRglqBxGWy5dPI1AwHBraq1QvpMf7GdMMoFdm9Yf/1I
         mBQiwsOM1BD2sDljLjSgjpqPegF0Lq8fQnJisvuYEwjw9VJsu0CXPPc3P+XkFeWVLren
         X2uQ==
X-Gm-Message-State: AOAM533eqcEGKtrt+r1U/ffCIbhq8xOKu2GWKjGLqIt+oeyry6Nv+Gyj
        GMrFtlrt4fUlrZMSdyqE6RoZvXHmbt/J372p2yZHaW3j75jCj9/mJPhke/vVlBSu1w+0wIFqNpB
        A9oFdU0R/CJRsbhL1aQp0pzFiXHjBal2wzKIxatbofw==
X-Received: by 2002:a05:6402:f1e:: with SMTP id i30mr5522982eda.432.1644339713028;
        Tue, 08 Feb 2022 09:01:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwm7vjReH1gIdZ2YkTpMgZZBbTH9BEIZYVEVPELLxB8Ecgr7pWwq4jgDyb/1xl7UOwuFBlDUg==
X-Received: by 2002:a05:6402:f1e:: with SMTP id i30mr5522956eda.432.1644339712812;
        Tue, 08 Feb 2022 09:01:52 -0800 (PST)
Received: from [192.168.0.94] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id yk13sm2740971ejb.200.2022.02.08.09.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 09:01:52 -0800 (PST)
Message-ID: <9303ca0e-2a83-3c3e-0892-c74a820562a9@canonical.com>
Date:   Tue, 8 Feb 2022 18:01:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] dt-bindings: arm: ti: Add bindings for AM625 SoC
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-3-vigneshr@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220208131827.1430086-3-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 14:18, Vignesh Raghavendra wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> The AM62 SoC family is the follow on AM335x built on K3 Multicore SoC
> architecture platform, providing ultra-low-power modes, dual display,
> multi-sensor edge compute, security and other BOM-saving integration.
> The AM62 SoC targets broad market to enable applications such as
> Industrial HMI, PLC/CNC/Robot control, Medical Equipment, Building
> Automation, Appliances and more.
> 
> Some highlights of this SoC are:
> 
> * Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
>   Pin-to-pin compatible options for single and quad core are available.
> * Cortex-M4F for general-purpose or safety usage.
> * Dual display support, providing 24-bit RBG parallel interface and
>   OLDI/LVDS-4 Lane x2, up to 200MHz pixel clock support for 2K display
>   resolution.
> * Selectable GPUsupport, up to 8GFLOPS, providing better user experience
>   in 3D graphic display case and Android.
> * PRU(Programmable Realtime Unit) support for customized programmable
>   interfaces/IOs.
> * Integrated Giga-bit Ethernet switch supporting up to a total of two
>   external ports (TSN capable).
> * 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, GPMC for
>   NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
>   1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
> * Dedicated Centralized System Controller for Security, Power, and
>   Resource Management.
> * Multiple low power modes support, ex: Deep sleep,Standby, MCU-only,
>   enabling battery powered system design.
> 
> AM625 is the first device of the family. Add DT bindings for the same.

Don't paste the same huge commit description in several commits.

> 
> More details can be found in the Technical Reference Manual:
> https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index b03c10fa2e7a..64f3db3ea9dd 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -53,6 +53,12 @@ properties:
>                - ti,am642-sk
>            - const: ti,am642
>  
> +      - description: K3 AM625 SoC
> +        items:
> +          - enum:
> +              - ti,am625-sk
> +          - const: ti,am625

Why keeping it not alphabetically sorted? What sorting did you choose?

> +
>        - description: K3 J721s2 SoC
>          items:
>            - enum:


Best regards,
Krzysztof
