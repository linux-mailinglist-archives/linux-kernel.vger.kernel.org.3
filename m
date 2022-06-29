Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0611B56078E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiF2RoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiF2RoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:44:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEC72A426
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:44:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c65so23241669edf.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tVekIMrtplwlYMH10GYN3NLEVF7rPzw2Ll0nVajDUj0=;
        b=w9vxn/UmjXGR/AxVPDa1AWAET4ZJSi/d7RKxJWbXb7NdzNnJmBooZ3j04DTGg2aRmv
         tLPrXK0sXmcc+VPM9SnLizG97ehS7Wgm5m2GgA5Y/E4F+mSUJXnfqgUkhNW1qbd9Vbuk
         3Ku48VOLtWJW7RyymLVXW+QViJ949T9Cpv5uNHg8Ii5/eClbUPoeb/EK4c4PddVjOiOc
         lmCz+tWzOphiK7etLDCgy2KJd1B0za2hnkJ1Uis67labgAnMFEuqxFukByyYRGGnZeI/
         EZx8HDGnCJdPxUiYOf3z4h9gyfvL/maNLCyHKmpGAIbAO0fCEmF0pKDKQjKy6BtB7Hlb
         aNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tVekIMrtplwlYMH10GYN3NLEVF7rPzw2Ll0nVajDUj0=;
        b=JxGASxi5TiSBFcfZV0uBU2DXGxUUl3KfUzz4qP9e186WGVQIYSIqtZ+174esda81cl
         RlaHyHrBj8NDPEssXPITWPU40daCdTPzBg1u2NP3Kq2D723I1rg8gT+XSjpsoAVt42dA
         2DfqHnWABKrviQGY4Pbst63LFzCbBzxbLWeqVLYheiq41Hkzf7qA8YomSDUeziMwfywi
         HzOTsCPxHJk01vfEt2ic75Sijgo5OfLqemFpm8tOER0Lfibi4vVVf+hPlq3lX4o0cVOi
         DxpesE6KJtqGU4Hmi+ar9mXx2JHuqmcvNQpVvEd5VQvyc0HWr36/JJweR4+ErK71D7pd
         LzHw==
X-Gm-Message-State: AJIora83ISo4hoceu+l7ioXs3rnkqHVbmHa0arGxPi4p1QP/LpmqCOey
        ZkwOmvWvGIhevMw8Kf5GA6+1yw==
X-Google-Smtp-Source: AGRyM1ua6BwpBragxQEeeAoYqEOJa4FdY4s48iFIdywyOYpjX3jiRhNVEbP0A5P0HdINP+n6ybuMGw==
X-Received: by 2002:a05:6402:847:b0:437:62bd:bbc0 with SMTP id b7-20020a056402084700b0043762bdbbc0mr5713257edz.285.1656524653206;
        Wed, 29 Jun 2022 10:44:13 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j12-20020a1709062a0c00b00722e1bca239sm8074199eje.204.2022.06.29.10.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:44:12 -0700 (PDT)
Message-ID: <c65d6a94-b5c2-e2e4-6fdb-b7982d291e01@linaro.org>
Date:   Wed, 29 Jun 2022 19:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/7] memory: renesas-rpc-if: Move resource acquisition to
 .probe()
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1656341824.git.geert+renesas@glider.be>
 <2fd9b9e3f60fe555d9dcad499c90e3ec869aa96e.1656341824.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2fd9b9e3f60fe555d9dcad499c90e3ec869aa96e.1656341824.git.geert+renesas@glider.be>
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

On 27/06/2022 17:31, Geert Uytterhoeven wrote:
> While the acquired resources are tied to the lifetime of the RPC-IF core
> device (through the use of managed resource functions), the actual
> resource acquisition is triggered from the HyperBus and SPI child
> drivers.  Due to this mismatch, unbinding and rebinding the child
> drivers manually fails with -EBUSY:
> 
>     # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/unbind
>     # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/bind
>     rpc-if ee200000.spi: can't request region for resource [mem 0xee200000-0xee2001ff]
>     rpc-if-hyperflash: probe of rpc-if-hyperflash failed with error -16
> 
> Fix this by moving all resource acquisition to the core driver's probe
> routine.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This looks like a fix, so how about putting it as first in the series,
so backporting is easy/automatic? Plus a fixes tag?

Best regards,
Krzysztof
