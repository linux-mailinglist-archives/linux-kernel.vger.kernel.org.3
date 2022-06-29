Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4055F922
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiF2Hga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiF2Hg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:36:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D635DF8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:36:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id n8so6995880eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bPXiVn6Pb7F2l4c7bgqIfqtL2gpKtRVep1Vk1dOzNLs=;
        b=YRIAwZtnksko0gShIVaLFi1lVENHUCkhB42FPcIPtwStjQsfP6CeB+v0fWeZOUdmhc
         teecEw6g3oHTuLKa02sAl0gVjuvFOvSxRZXqbKBdKsGRdrYXdYGODVNSLkETedcCusM3
         OVvtcRnZ4HpLBe7v8oH7S9n/Fp5P0a9HNNTXrS2sxGQf1mqkW/2zwYeRGYi6tLi7bVer
         sXlmD/4/XgEpa13fPTBB6Y/87lqBMg1NXLZut3TGZ97S8ALTyalurRMZl5i2y89smqdF
         MWTXEq2U5vyJXxusOhR7p72c71jRSxee2lhI5yUxzx7RjXSpXw40DtHTS0AEclLStudZ
         Hv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bPXiVn6Pb7F2l4c7bgqIfqtL2gpKtRVep1Vk1dOzNLs=;
        b=pbDjm64ojvPxIEdpJTCzFTT5LLF0oxDhzbojBHye8ejjx6IMx72ppvABO9KeDLyR47
         SZlMXgbDdFIomdno88naiUUipg/H48aB2YAvRNFYgmeGvO5qoyZHqhrgejjSWVYatyD3
         AdsJ5nqs3U7I+GoxuzreqgUcTzHpWksO9UCSnxMt2IVqDx5a4Rwth/2a2HASns9qOLA3
         jH/sElUGguSIL7WahQEE9uKlk5zFHz7wnKZYCbhMLw/aFMkzbFZQTOXETAaoPhilxXPb
         wOF4S1fqIWCXyewiUr3d5VLffKAK1iaADRfwx262SzcmGGAXl0QXbu4KNXm6d+cgcAWo
         Ft2A==
X-Gm-Message-State: AJIora+4n4ZWGQDrMuYDUw3zA73E3yWyAfhQY0tUVKc7qGy0zPQ9395G
        920dRlxX65x+xePn9lZzek/TmA==
X-Google-Smtp-Source: AGRyM1vyeNBDBCLxl77d0cqo0XxUzuKi0mn8I9fSWYSyOYZDqlIxnY91+SWQ3NHzLnxUw1aVK0m9Dw==
X-Received: by 2002:a05:6402:94e:b0:437:8d58:4ece with SMTP id h14-20020a056402094e00b004378d584ecemr2361899edz.396.1656488185428;
        Wed, 29 Jun 2022 00:36:25 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640204d200b00435a08a3557sm10950502edw.27.2022.06.29.00.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 00:36:24 -0700 (PDT)
Message-ID: <b98cd4e9-28d8-53b8-2514-d6c63bacc12c@linaro.org>
Date:   Wed, 29 Jun 2022 09:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/8] watchdog: s3c2410_wdt: Remove #ifdef guards for PM
 related functions
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220628193449.160585-1-paul@crapouillou.net>
 <20220628193449.160585-5-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628193449.160585-5-paul@crapouillou.net>
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

On 28/06/2022 21:34, Paul Cercueil wrote:
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to
> handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards. Not using #ifdef guards means that the code is
> always compiled independently of any Kconfig option, and thanks to that
> bugs and regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
