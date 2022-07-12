Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE85716D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiGLKKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiGLKKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:10:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62F0AC05D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:09:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id e28so9517267lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uZ6PBg0k+LNPWSahV/wsPmCFTFziNXNqJA+X92tR5lQ=;
        b=UZrkexqe1KGcx9tnd0D+7tFUi+wtQiLe/TNBgXWXfjPGLfg4I7N9pJ/RGRzi116K6v
         UKQ0tcnDgaKSykVeXiPij9NY4YpLftWsujncRv+jB8/9IkGvMQX8jL2CDb5eWC4gR4ub
         +o/RnygqEVN+B8RhvTEDTe8XHx/oZzaPrA3vxPoCeC1SL82egNRsbAewlsVKMwCjE5bQ
         CAAeA97lPuaI9Oq/G8nacQ6DtFIgEKQJICeBHR/lymHt2CXiI7UrX5M/5ReEZliZASrX
         7924c5RalRb3ZHBnkJCp+1HVK616mUo/ceMPsA4p/69OpuhFM5W1ddfjUt5H3p7fcBkb
         q1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uZ6PBg0k+LNPWSahV/wsPmCFTFziNXNqJA+X92tR5lQ=;
        b=4XMDy93F5g8VRD+vF5ctL5ly3HmK+clUOdHwOazvbsxP8ruGjnGpCfpR+zaPOeVU9l
         1MGDvujnZz5K/QYjjgEmfolWmiSMSuulXWknhBWINoxVllM4NfooDDGfJipfvhAsegsb
         NZofjqSC1ZkDTpVj/0fQKiZPp8E9pLwIxpJUTGNfEtpQ8vaZvK1TmB7TY2YLKYaCAePa
         Rd10Jt6fOCxSS5nnopHnViUDkxzIPJEAUcYpOiwsZrJahj1bBbPHJ8w9FRQ2QtFpf5jg
         2HuQnEpl3nPZnxJivyY85Gy/1PR+PH5xk1cQ01/kF87bWgBZk7NGdclQpiZvVSextf0M
         g8lw==
X-Gm-Message-State: AJIora9XZA66c7ReDxztvPpMXwT3Mio5mzuOwkR3RkZ4c80grlXWccGT
        Fqrfw5bummwxi/qku3FRiEY4UA==
X-Google-Smtp-Source: AGRyM1spzIn1kXom2zh22zmT5Aqy5fffNoevGip0xPBZELGAE86f4I3+XEfcAKDHmEN9HsrJ303VvQ==
X-Received: by 2002:a05:6512:3c86:b0:489:cef9:18bd with SMTP id h6-20020a0565123c8600b00489cef918bdmr9827225lfv.386.1657620583031;
        Tue, 12 Jul 2022 03:09:43 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512358400b00489cfd58ef6sm1885307lfr.88.2022.07.12.03.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 03:09:42 -0700 (PDT)
Message-ID: <a6534fdc-a21c-5784-8eb7-ee892275fc0a@linaro.org>
Date:   Tue, 12 Jul 2022 12:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/7] pwm: dwc: add snps,pwm-number to limit pwm count
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-8-ben.dooks@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712100113.569042-8-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 12:01, Ben Dooks wrote:
> Add snps,pwm-number property to indicate if the block does not have
> all 8 of the PWM blocks.
> 
> Not sure if this should be a general PWM property consider optional
> for all PWM types, so have added a specific one here (there is only
> one other controller with a property for PWM count at the moment)
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-synposys.yaml | 5 +++++

No. Please do not hide bindings patches in the code. They must be
separate and checkpatch complains about it, so please be sure you run
checkpatch.


Best regards,
Krzysztof
