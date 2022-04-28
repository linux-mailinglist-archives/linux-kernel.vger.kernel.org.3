Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3FD512D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245586AbiD1Hzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiD1Hzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:55:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB895D9F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:52:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so7890273ejd.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GDe4fbXhNYRyQLVQcRqvZFo+IyJ/gzKdBJXzfm/RHKQ=;
        b=DoC2Ul7QZteiwyq2vlY+yfBneqtGpD5/xJbSGVmb43FoVRYGkrBiA12rQkZmQ8OGHR
         oTHssGul06VTMM1zZEE/2/a4UIQK5k5ltPSAPMW2XeNoySn8kR0A5JQ4stqivqJ9f51u
         OUYq7uo2KWTAuPAPt2DaivMKd4eDXiL4jppcoI5FIJXZg78TFwySQByuKJnA5VTru3tr
         RiuyZQJ9H2ZR3yztpSy4e5ZXI692JDh1cW/aWmKsKYDQHDO+bgO8hfoVd7M1AxLC7T+H
         pJsStYnsMXIrzochMq3sNC6Lm+xbllkj9RsQpcDK77D6Bi/a3V+vuEI/ujJGAfgbxIZi
         xOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GDe4fbXhNYRyQLVQcRqvZFo+IyJ/gzKdBJXzfm/RHKQ=;
        b=pLwDF0ng60pprtPGxKLjGkcs0Kp0MHEF6zd/px8T34ZGMjK/kzXKhu+37lv2zb4N3k
         Ubh6NJIlFIReMm5bftl0HalPW+f/has8nvlkwRqgBchHGVMXOtTepgaFhq2JUAzG/pnk
         j0+KO+mSMmr831omIG4WqcGx77+nLn8tqzUXADjLHEYOVtLoJgKmPM8v+V2IUa8SvUZB
         FCzQnbSrjtT2OoSgDzHMAvG7LmgcVXQlGJLMZqFnk5RQUmkiFNVrajPs/eN0MQ/r4KPJ
         0zVrVKI3/plz+60mLWJ8TMrlKFgm7ECU+EQQ+pDR6v72DBYf+jS42FLLBKP7J0iACNzT
         ev/A==
X-Gm-Message-State: AOAM533VVTKsKCT+uNJDzCzXhK31fj9swnQY6hNPwBpUGuuF4IMiIrZP
        x3QPHuakxn6+ZV0iTKcrRxjIKg==
X-Google-Smtp-Source: ABdhPJxcOk/BGrp7s0YFnwX2EGmsFKG7/CsaS03hRPpVL096TfZAnbCxF2kUpprXac9SaGSvjWccoA==
X-Received: by 2002:a17:906:c146:b0:6f3:e1b1:70ec with SMTP id dp6-20020a170906c14600b006f3e1b170ecmr1603870ejc.75.1651132345431;
        Thu, 28 Apr 2022 00:52:25 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lb18-20020a170907785200b006efe7bb40b0sm7955449ejc.74.2022.04.28.00.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:52:24 -0700 (PDT)
Message-ID: <b23817dc-ee8d-11eb-99d0-2e8ee75b067a@linaro.org>
Date:   Thu, 28 Apr 2022 09:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: stm32: Add compatible strings
 for Protonic T1L boards
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20220426073511.1160119-1-o.rempel@pengutronix.de>
 <20220426073511.1160119-2-o.rempel@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426073511.1160119-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 09:35, Oleksij Rempel wrote:
> This boards are based on STM32MP151AAD3 and use 10BaseT1L for
> communication.
> 
> - PRTT1C - 10BaseT1L switch
> - PRTT1S - 10BaseT1L CO2 sensor board
> - PRTT1A - 10BaseT1L multi functional controller
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
