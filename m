Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700245181CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiECKBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiECKBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:01:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998BB35DE2
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:58:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n10so15017230ejk.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z6vn8RV+oPJamH1qeu3cvsWts9bI2+OweL8gu7X/8vA=;
        b=W5JJnAcNeGAKsYC8o/kXmqVrceo6nc9cLrogb7rhvZowJ++q8nOgznj84QF0gXE7Mc
         yXmO4c/FMcATY9A4k85VMp7syj0DQr3gsBahcDzOQXnY2MYEIq0t+vijqxtiPm96qITE
         BIkDpJOzuk2KlC8GCAHNKuyePjcaztOEFoWQBKIfSRK4e2lRZhaHcScIwyb9hHh2ulce
         JSfWqc5W8mRzDUFe4XPug9NC0BGjhCDNBFaqstW9W7/zN6bUAL7yD8SSQ/op15J3U7GZ
         027Nlw6egZcFlnhvTqIQANwxyt6GZhTKWMz5wL7nwnoDnW1vjkSiQ6477jQCsRPfG8Xc
         HeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z6vn8RV+oPJamH1qeu3cvsWts9bI2+OweL8gu7X/8vA=;
        b=zz/zdHlJEySjii3wqfTY00QEEVoplP3NG6XA2eBu1SwcVKNxpCJtgvwJHhjvZJ+AOx
         Eye0YLp6KX0RqQ9+xV1dubmPAbEamjwl1k0CiYygT4q/lhbqgAevmGRMu/yx77MoIHAl
         w3Sg9elK9nUq6VQId5YlMNQZyDDqRyNsMuF27mgUeqM59g/AsUHC2719PaYEqxagQ7V6
         wcHBULNSMbuhNbtP8rJsRHbhGTa6iyX3jDSkVRVdkKWmPYCW2mRAQ/VRVtJq/D/6OCtf
         GR8v3x42EVRtB2Pzfl8j0IJGLwcL5pg1YPJVezrEOaSQE5dDZNQGeUleEVHC1ikHNkky
         eLyw==
X-Gm-Message-State: AOAM532RyxjYQ1X1Lx4OJBUPB1qHaWpMkiI381JqbylDQ4k5k1zgj3hJ
        MH7q6uG0yNZ9AGuoFhqd2nk3oA==
X-Google-Smtp-Source: ABdhPJwg5UlqU1Tyo9LaWEKwvdRYNzgjscMYLGM93oxn2dLEJvVzs39lGK1JLxztUdkGt39ON9n8tQ==
X-Received: by 2002:a17:907:62a1:b0:6da:7952:d4d2 with SMTP id nd33-20020a17090762a100b006da7952d4d2mr14759958ejc.260.1651571888174;
        Tue, 03 May 2022 02:58:08 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jl22-20020a17090775d600b006f3ef214d9esm4452253ejc.4.2022.05.03.02.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 02:58:07 -0700 (PDT)
Message-ID: <dc005fa0-fee7-1ca8-11ea-b984b1ab3365@linaro.org>
Date:   Tue, 3 May 2022 11:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 5/8] dt-bindings: timer: hpe,gxp-timer: Creation
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, nick@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-5-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220502204050.88316-5-nick.hawkins@hpe.com>
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
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add support for the HPE GXP Timer and Watchdog. There are multiple
> timers on the SoC but only one is enabled at this time.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> v6:
> * Removed simple-mfd compatible, timer will create watchdog without
>   watchdog node.
> * Removed timer0 label
> * Changed title from HPE GXP TIMER to HPE GXP Timer
> * Changed clock name iopclk to iop
> * Set additionalProperties to false
> * Added space after ',' in the compatible list
> * Changed subject to match the log better

The subject after prefixes does not match it better. What is "creation"?
"Add HPE GXP Timer and Watchdog"

Rest is okay, so this could be fixed while applying (if you are going to
resend, don't loose that comment and don't loose the tag):

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
