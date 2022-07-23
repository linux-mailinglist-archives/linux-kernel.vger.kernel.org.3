Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BFB57F0E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 20:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiGWSKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 14:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbiGWSKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 14:10:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5BA10EE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 11:10:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p10so4748449lfd.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pNAUhjjDBroxympyUt6U8tDnLy00vPlBr4R4mbdJytw=;
        b=z2f2fpiIj0R1syFPRFKESCT6v9mZZ1WS4rZkcNn3DWsi086CY9WoBx1WVUjTgsLr0S
         7UmKzoZaJHtUbo67i9IMKISGWxvrxu2EN9IioYUQmt4ClR6+8Ptpu5M9FRW/qeKwQxru
         eMxfRrsL1MfB/AvletWTdPpVUS4ZZm4WnBXIqCbz2TUbPONxlAuBADFVTgA5Rflw4lno
         aLS2qdg+2VlgS7rqytERlJrKl7KzmWFPyNZJS2SOCIaFUM8ap9sPtvhx+yjm6r/3DIOa
         im1TftS9l2AB5aJIqLSiUnC8r96g3RaYTZL/kjAHZaut+2nKSC0vDHBF+QY9sMxC81jw
         NnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pNAUhjjDBroxympyUt6U8tDnLy00vPlBr4R4mbdJytw=;
        b=GBqcGshWhH5M3/AFtMcRF+S/QJkwv3D84CO6aUIMhQOmu2lrPijtzvHOZ2U8FvnbBx
         +6tfZTuUCnspNTLyzmhPuIOzvSwnuxBoNPrgiFJ7Vq/Esd+EzyzIgkPhQkZaoiPwK9UX
         SM2OpoFsu5WvCnkkCrqonXWB5FDsd4alN+A/7PmzBiCL6bwFcgWKT2uhJoCpmmfA1pDO
         GHM390MmOPvdeTSz6n6VDSWlFUx0AcVmz1+PBbRhmIDfp9ManKI1MDDziTYLpB9BfB+q
         DONBLzoFuWVlgAkyazL+NLEWSJXfct8rDWs/vj0ejMFc7RbWywzAaExqgsMURSUnD6Sb
         uqaw==
X-Gm-Message-State: AJIora97ZVBVwVrfR2oVVGfdDQX7fTW/9h0Uoo0W2xbh36fM9VeIH5yn
        7DUAxMtnnLJvzLk78eUPCe/Obg==
X-Google-Smtp-Source: AGRyM1uppMfY4czX8b7SEbjQ+hS9O1TE8PqpFelKIBXcz04UpXhgEujHzGnFx2Tn80DQX6Xml6yJlQ==
X-Received: by 2002:a05:6512:22c8:b0:488:e69b:9311 with SMTP id g8-20020a05651222c800b00488e69b9311mr1944284lfu.564.1658599807174;
        Sat, 23 Jul 2022 11:10:07 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id g1-20020a056512118100b004811bf4999csm1754790lfr.290.2022.07.23.11.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 11:10:06 -0700 (PDT)
Message-ID: <6a4c74fe-5558-5455-1f79-0289e10294b2@linaro.org>
Date:   Sat, 23 Jul 2022 20:10:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] spi/panel: dt-bindings: drop CPHA and CPOL from
 common properties
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Belisko <marek@goldelico.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20220722191539.90641-1-krzysztof.kozlowski@linaro.org>
 <20220722191539.90641-2-krzysztof.kozlowski@linaro.org>
 <Ytr+Q6kXr+f6dCfi@ravnborg.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Ytr+Q6kXr+f6dCfi@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 21:45, Sam Ravnborg wrote:
> Hi Krzysztof
> 
> On Fri, Jul 22, 2022 at 09:15:39PM +0200, Krzysztof Kozlowski wrote:
>> The spi-cpha and spi-cpol properties are device specific and should be
>> accepted only if device really needs them.  Drop them from common
>> spi-peripheral-props.yaml schema, mention in few panel drivers which use
>> themi
> 
>     "and include instead in the SPI controller bindings."
> 
> I cannot see you do this in the touched bindings.

Yep, because you always have two schemas being in play. One is SPI
controller and other is the device (SPI slave).

> So I cannot see how for example samsung,ld9040.yaml picks up
> spi-controller.yaml and thus it no longer knows the spi-cpha and spi-cpol
> properties.

ld9040 is not spi-controller, but a SPI slave device, AFAIU. It will be
therefore a child of some SPI controller, thus the SPI controller
schema, which includes spi-controller.yaml, will validate the type of
spi-cpha/cpol properties.


Best regards,
Krzysztof
