Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCBA518207
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiECKJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiECKJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:09:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431902FE6E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:05:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z19so19252576edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=xBm27WNRG7qXn6Wemc0SzmAK3GGWDaOoIDSTOYNtRvQ=;
        b=cDis/mWVq9wXMRihX6BUHgWW2hmN4uovemvEQkw3zQnDA6WnPEdb2Bwhx+/NOmQFVo
         d9weYenfTPCuQ9LOR1yhU0wOr1aHiVcf9zECteUQ3fFzBBMKYqPkV1E0RvNgUuzkE0Zv
         1hR3k20xehn+VWfG9oqwb53EahxwrmjgXGf1EmO9jVAYBezwyQ4ZKnM1n9hjZuMJW6Gx
         d7/crf1sKmFtWlEuaQvwOeWyZg2wKp9ndZbTgqBEEU6yXhaA+0CY8DPIgk9Dmfd4bE7x
         2DIBmqSXdh8RBTCYMrdYB5dZz/tNnjzTaUxlWt3PVQLQgKIv1xmLzEdazD0r6InYyFr3
         ngJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xBm27WNRG7qXn6Wemc0SzmAK3GGWDaOoIDSTOYNtRvQ=;
        b=JvDSp90FwrD/LNupKk6tyfgQMspJOTImFbHF/7rJSOlM/b3NbxolzwMlP8XmvX4S02
         Nn4L8UeRA97oKKe6TCcWm3b7F3lDJJXNe1WpX3x66splhCrV5PvnCXbwgEibjiFY5Dsp
         BjVu+pCG3GANPHDTq+Yx31rOj/l342UnQ3fFcFs92+YO534sCqGex6AIhZDLyngsUKES
         xUTr56JZUU5Ld4HQK/qU+HSlMBOMefs0z1Y/5rCuckfQy1YDDOKQkaL07/L/T9ktSQgg
         0ZZCQD3reNQhzgw87oWuFyn9k/9GH/NjL4MqXDSMhLCziB13ZDBm74qVTIUd8v34YqYU
         ZzgA==
X-Gm-Message-State: AOAM530SW40POpIPlqD62hq1xmxLOZ8NooVXW+hVNTiAmzAWpVP1+p0c
        /gJLG0fajktEzB4ivs14H/mXWg==
X-Google-Smtp-Source: ABdhPJxgV9H76vOFuzYLHxqR42w2tEOkC8lLtVuyDV49egfrOYhofZkFfwcx16g13NO32jjXjmFktw==
X-Received: by 2002:a05:6402:2714:b0:427:b9bb:a179 with SMTP id y20-20020a056402271400b00427b9bba179mr11879079edd.102.1651572331605;
        Tue, 03 May 2022 03:05:31 -0700 (PDT)
Received: from [192.168.0.202] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jy5-20020a170907762500b006f3ef214df5sm4446820ejc.91.2022.05.03.03.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 03:05:31 -0700 (PDT)
Message-ID: <d4294886-9414-f1c7-a3ce-18108d009cb5@linaro.org>
Date:   Tue, 3 May 2022 12:05:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 8/8] MAINTAINERS: Introduce HPE GXP Architecture
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, nick@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-8-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220502204050.88316-8-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 22:40, nick.hawkins@hpe.com wrote:
>  
> +ARM/HPE GXP ARCHITECTURE
> +M:	Jean-Marie Verdun <verdun@hpe.com>
> +M:	Nick Hawkins <nick.hawkins@hpe.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
> +F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> +F:	arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> +F:	arch/arm/boot/dts/hpe-gxp.dtsi

Instead:
F:	arch/arm/boot/dts/hpe-bmc*
F:	arch/arm/boot/dts/hpe-gxp*

> +F:	arch/arm/mach-hpe/gxp.c

Instead:
F:	arch/arm/mach-hpe/

> +F:	drivers/clocksource/timer-gxp.c
> +F:	drivers/watchdog/gxp-wdt.c
> +
>  ARM/IGEP MACHINE SUPPORT
>  M:	Enric Balletbo i Serra <eballetbo@gmail.com>
>  M:	Javier Martinez Canillas <javier@dowhile0.org>


Best regards,
Krzysztof
