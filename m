Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0069587ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiHBKgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiHBKgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:36:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9A419C1D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:36:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m22so9506287lfl.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LRt+SjAyC9qbDB8S6bMljUQSocRTmz6oHCyciG3qGMQ=;
        b=L9C3SB/fYH7KycVfrziTcpU1//xQ+h7CNo5XrmyPE+KSOvrEvGaolG4HKKk9jP4aEz
         KucI5V5/bC5WuFhK7O67WQ7GYQA/uzUuSaqMBmjwc+VCORpiWoPSGEoa0FZqBykSVinA
         TI8MqnRF2j0mppCAaNgzhRwnsYejN735cWx/AzY/FjFFzNFUKjvIG3N1HyRZxy1LZ5Rg
         pXJYNV292GOUSzwr5JN1/7KGzBAyO8rzNxXEUOaHHBr2s5C4LrPfnMIZDNTfesBfFgbV
         m7nSxEsy6fs25YbhmP7Pul1KX961MmztspiVWOdL6yldC0okM1R9tLGTV2ne1cUeWL5P
         fkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LRt+SjAyC9qbDB8S6bMljUQSocRTmz6oHCyciG3qGMQ=;
        b=ng/dWUsFAjKbds/KM6NbY+Ja9G8/zofE2ehBCfrSE4WXkW2bqDlH6pIvMg/WVMwANX
         jGPiGgdkhPWsycbwKahuc2NO6flRpI0OmeJ/xSXXqDjxvhBEUPG6nN9Oafam9pFhk7MV
         VtYxOfA97Vpw7Xro+wADHZRrvEO67ynDW01YdfA2T78+TdScSCSQdRTnogwE0yEfa8Lm
         DmTNULQIv1CxfcmV+4i7bL00NdMPUXVocPJrTq21q73+mezQprMLYIZQTdJzw732qzUR
         wzS7HLP4p3aerDTxgz5nk9JzDbPcvgQeKrENbEihHeH2BUfa6NkdXN1f6ZccCWObAARB
         agpw==
X-Gm-Message-State: ACgBeo0kWBmfDSBtJrRSma9EjWcGu+mti4GisjQCL5c+YZxeNOlxsUit
        IVth38QAXVR2isQHMHW00Oa+Kw==
X-Google-Smtp-Source: AGRyM1tntjbC8i6y5Lc/K+qc/mJu/8KPKfg0l6J8sYfJWkgn4feGpzN9DmYZ3KlHJyqnO4odqkLFWg==
X-Received: by 2002:a19:8c04:0:b0:48a:7683:3845 with SMTP id o4-20020a198c04000000b0048a76833845mr8272230lfd.297.1659436606859;
        Tue, 02 Aug 2022 03:36:46 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id t12-20020a19dc0c000000b0047f84ecae2esm2050815lfg.236.2022.08.02.03.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 03:36:46 -0700 (PDT)
Message-ID: <f50cf7e0-3a48-c8ef-f210-3ef1b447548b@linaro.org>
Date:   Tue, 2 Aug 2022 12:36:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] dt-bindings: iio: mlx90632 Add supply regulator
 documentation
Content-Language: en-US
To:     Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20220802103054.423372-1-cmo@melexis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220802103054.423372-1-cmo@melexis.com>
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

On 02/08/2022 12:30, Crt Mori wrote:
> Document the newly added vdd supply option.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  .../devicetree/bindings/iio/temperature/melexis,mlx90632.yaml | 4 ++++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
