Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3FD4FF608
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiDMLuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiDMLuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:50:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FAA5AEE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:47:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t11so3332032eju.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jjQ3FZFjqfTD+VcguZaZmmSb5AFyfO4JHpKuzAYkDRc=;
        b=smonsKckFHLLyesrgqtRISOQeUkyq2vvw0W0wHsj/jkZq2wR1tvbAV1CYBZ8SJf8SX
         NQe3XfBwwuOFEYEhZGVJ48KSOul2kQp65pwzHWIqlMA1CD9BeNwbXgUxXqiuXJTZHQgi
         svPuKVbgKc4aOGxjdL/wcDYZoVsGlQzAkkPoeG/VOyY6ElHTXlmBI9mGw6I++l2cEKnl
         OnhJUX3GZW2zSwPsjzgUbK7u6K1t1Yajvtv0uA8mmaU27klXr0+/I2yuda2bqyIU6kVe
         4k4HFn0MsibdAhRU3mXTDy2IcB4CaOKyKhu+umRJoTX7gMDRW0izhATV/Yu0o5xJg/ID
         jP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jjQ3FZFjqfTD+VcguZaZmmSb5AFyfO4JHpKuzAYkDRc=;
        b=xehqmbHnJQV9641prV8TUhZ0dPKRtwAgWMDeUOOe9r2xpNEqXNA/E203MOm5rk+r66
         KJuume9OCJNO/MgflDe7MaP5z3koElNKMhDhUZ2Pf7xq6QBZdLsJFL77Xjz0PxaRj76t
         viLEOaDLBc9tc0SoZQgbo6WHvKUdaL2qffc4VXEktf/2nS4p9tLnC2U94yCmYkdg11Bn
         8U5zdGL8TAPgXbfoJ/j5oV3mOBx1yEAQUTgurPNT1Ut4EU9Y2Z7pVuInaAGR3onNP+0c
         kfuC0dumhrIU8GQjgl1Dgab2MvMr9fHQQ5yTVtbdHYUvDM1zBWRgyL+bRV4Z36BuM74O
         THbg==
X-Gm-Message-State: AOAM532oII3BNptDxR5/5TtIjJiQPlmby1F2qV89//YulzjtOnugr6ec
        yC6ZJePFr9T7PP4KL3T/ingbHg==
X-Google-Smtp-Source: ABdhPJyApblQcAcJdPCK6ZBEj71QO5kAJT3zJbnR77XyGsP/tSZCqTKzzQ1fYTsK4ZIiUXyX/TyyXw==
X-Received: by 2002:a17:906:a005:b0:6e8:947b:7530 with SMTP id p5-20020a170906a00500b006e8947b7530mr12643170ejy.320.1649850476500;
        Wed, 13 Apr 2022 04:47:56 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ay17-20020a170906d29100b006e88f246fdbsm3595139ejb.152.2022.04.13.04.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 04:47:56 -0700 (PDT)
Message-ID: <f2b7b48f-906e-3445-3861-dcdd4f6551e3@linaro.org>
Date:   Wed, 13 Apr 2022 13:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-omap@vger.kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com
References: <20220411095516.24754-1-rogerq@kernel.org>
 <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
 <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
 <ed2167af-fc9f-1f52-e8e2-c0881f5d53c6@linaro.org>
 <7b38a717-ffce-0f06-1a77-6d2a114c7e11@kernel.org>
 <68d16fbb-4250-73bd-b55e-a14db91abe8f@linaro.org>
 <fdafb49b-9349-087b-f483-4da888193683@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fdafb49b-9349-087b-f483-4da888193683@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 13:33, Roger Quadros wrote:
>> Previously it was building with COMPILE_TEST on sparc, so what else changed?
>>
> Previously it was like so
> 
> 	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
> 	depends on OF_ADDRESS
> 
> Means it won't build if OF_ADDRESS is not set even if COMPILE_TEST is set.
> 
> And OF_ADDRESS is not set for sparc
> 

Ah, yes, so dropping COMPILE_TEST seems the solution. There are no other
"depends" here.


Best regards,
Krzysztof
