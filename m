Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D054D481
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350141AbiFOWYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243581AbiFOWY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:24:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA6D2F027
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:24:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o17so11574443pla.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uLEDL+G7aX3Y4fRU26LLhNvvGtvMvsrcMGTR1rtP7yw=;
        b=DTJF3smWA3fB95jgkWeMgAeL3z2fFHk8fPHUNEallNDdQff3BPuIcBZS65ZbGBPUXE
         K6BOf3/c2HA+EFOtIuA+4DajkWGkAzMQmZeFz2jKNsM4hfaGAPiXCWlPadUXuzDTRnoI
         5Jt7riLi+7en25sCaSe8ZlYJ4cSXRdC1Vyxf7RUHS8uGg2SzfkxnsOr9+1jAnQEIk7TL
         1pkdH0HOOKTr1NWiSFW3u7QG+uol9RhSdTluUF1Cj6vP5+yL/pDTlqwaBjjoyWk5zd8u
         evUfILLDx8rbTd29hitOx5f87S0CYWd3ZPpYWIVzsTuXC34ir4vWVGv0pfGro8jz7KmU
         XOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uLEDL+G7aX3Y4fRU26LLhNvvGtvMvsrcMGTR1rtP7yw=;
        b=nF7IoZkNPe581LbqZGaJOR0V9Mh/Fc46hCmKtFFYISFfckrhFGTcxJVy9Z3fd2r9vs
         vQ4KLcszqpcUGsDCT8cBiQ0p7brJVO9PXg0OxwWqeaJb8/M9MUNBiAHMVAAjyx4HZ0KH
         /QONlrS0mOXfZpirUVqsek4eR0p6tQt9yieYfQjcwOB7cXz7q9VKBKNX6AjLxQU2Z+y3
         wGo5pE6gNHNtN03+6znIYPdXqVBkCtChKM/nEHjniwmC8tlDwAFM8VGn4RNP/TzasIIy
         GC1+khBQmnLW6Henay+3sfxJ9KE/uUgQJqBtI67zBLJynWxfDQQulov+m51ydVSs8rwv
         yTaA==
X-Gm-Message-State: AJIora8+kz4GvspAspIE3giYyhtUllCL+d5uFN1y651Sn7TlJqL8r8Il
        TRQODL1fOmKe9Z1799e0L6UD4w==
X-Google-Smtp-Source: AGRyM1twcw/WY5Xe4Nnxhw4M0Mco1frKQyTuE637zz53WB/TZIzLMkuT2IwpfthyharuE1mZ8MJLtg==
X-Received: by 2002:a17:90b:11c5:b0:1ea:9747:28ba with SMTP id gv5-20020a17090b11c500b001ea974728bamr12696060pjb.22.1655331867581;
        Wed, 15 Jun 2022 15:24:27 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p9-20020a62b809000000b0051c79bd5047sm128311pfe.139.2022.06.15.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:24:27 -0700 (PDT)
Date:   Wed, 15 Jun 2022 23:24:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: mfd: mt6397: add binding for MT6357
Message-ID: <YqpcGLIhD2FsPLdi@google.com>
References: <20220531124959.202787-1-fparent@baylibre.com>
 <20220531124959.202787-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220531124959.202787-2-fparent@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022, Fabien Parent wrote:

> Add binding documentation for the MT6357 PMIC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
>  1 file changed, 1 insertion(+)

Doesn't seem to apply.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
