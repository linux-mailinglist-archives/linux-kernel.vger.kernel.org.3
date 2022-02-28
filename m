Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263EF4C64AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiB1IP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiB1IPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:15:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A596A07A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:14:27 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j22so13984190wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jUqKlQp+dFj1R0W1DR2xlSmvOw8kmJjyVaDiY3lJSbw=;
        b=RW4aGXcy0z71QmVtnZd1+4jaWAi4CNLxuUKwMLC5niaLsn1Ci0JUMQOrnpu8JDYiN2
         2IYtjaaKd0+WQidHd4zJF9CgxaDimV1n7MtH8Dez9927dQqRr0Ys5frn4HtRx655Tvr4
         bFi+7sS4yWz6vx8UEUdiEBlztl0SJQTuX2AgXx2imx9Z6zxYf0zaaXkgXM8KABJkhF5M
         Stl8Q4G5u30s4xv3yDb+68GY6A4vq3531aC8J1CL/8PIHmoYoWRMcGFUOt3nOjpjNMj2
         0aqCThBmNsMHJYL6Ld8WqtDe2TD89BC+Hnmay/CToQZRPdHzMFyh23dQlwDbAULeCPgo
         S9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jUqKlQp+dFj1R0W1DR2xlSmvOw8kmJjyVaDiY3lJSbw=;
        b=3nzeMvCuI2bk6OqgrLUs8k7psXBNhPMWTqmoLBFGxNV5FpVSoaLdXC2IfjixAIIt9v
         rKESZ6jiauxJvlHcVxkYSbcOv7dWuW4GBcKLPZ3n7rqrxNzR7Zxu8I26gDILBJIMfqQl
         lGUZonuOAyyiMVuTX0zuO1w/Ye9g37iBKch6GtjF7Ia4vr/WE1ZLyQvow/3kSk0/oYQd
         NZScu82uHCnmkTGcEw2Ur7Wgav+8fPeXbw+ucOx3krvPSocCcaRhYwlqprlnQAUfgGlF
         l+dEi/6QfGAcWXtOtUh3fL7SOkHthz+GbQ4dumwy0eyHHAGL8ZiD62BhH3C/zEGdm1j0
         hi3Q==
X-Gm-Message-State: AOAM532WD0SMyb3CLwp50Xyv1s4iOr8BeJiI51cB013XhfslIJrwC+d3
        T66ESkCE4KqSpMfGWY2W6Wi2sA==
X-Google-Smtp-Source: ABdhPJyG0nKFbjrv2/CDkv8rhu+3DCfoN8fGsZV/1a8a9E73ShWpm5gx+82WEtpcC+23G67PkN1bTQ==
X-Received: by 2002:a5d:4081:0:b0:1ea:96e5:156e with SMTP id o1-20020a5d4081000000b001ea96e5156emr15307264wrp.229.1646036053371;
        Mon, 28 Feb 2022 00:14:13 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm9612098wrm.82.2022.02.28.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 00:14:12 -0800 (PST)
Date:   Mon, 28 Feb 2022 08:14:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mfd: atmel-flexcom: fix compilation warning
Message-ID: <YhyEUiPJhtqGvtEE@google.com>
References: <20211207111515.814653-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211207111515.814653-1-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021, Claudiu Beznea wrote:

> Fix "unused variable 'atmel_flexcom_pm_ops' [-Wunused-const-variable]"
> compilation warning by using __maybe_unused on PM ops.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/mfd/atmel-flexcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
