Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685565877E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiHBHep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiHBHeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:34:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CEC15FD1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:34:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f20so13516086lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=368JpS/36rpWybO7f4ScB1zDTWLXtrfKA8qyBV5OuNo=;
        b=PAW48wAwiZTpeP12dW/05hHrrHyEYFI0im9DNNF9Q1icROFPCIEb6M269XeZJ/MbV9
         5t2YxR+fMq4jgvEjANIcqMivgGJF29PZCnSzboOrNW+MBMK/EPhmD6KywOWoIpLszoRP
         2MCSDWoEriFDPYGELrXkSoaskNDFPu2DRWKIwXJqdxt0ZPPQiel/waz1N1RgyFPEc8Yb
         jlqJY/UTJ7/RQbPi9DQDvTyje7I/eb2hboyuTCyytIo/c58JUOEARUmiVwcVt3KSK1vT
         fin8GBGpmk2oD8H+CYqA8ukdX9l03o89vJAgdLCMn7uUYsAqnRRV1s+uQJX33SQeZD8b
         g06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=368JpS/36rpWybO7f4ScB1zDTWLXtrfKA8qyBV5OuNo=;
        b=aL7o1b4YJBWF+WSNn65RXJ1hDvQmneX5LLUKxWRv9z5g+XlQY6sPA7PyalsMCFCVCB
         MJstdNvIbtbAyg57ipUb4O1D+mhcHNf+nCiNUrq6iGEkpUiEJv3mGfAEfSrf55Il+CpC
         mmXa9LgzcDBWIuGKrtux+T+TmF/ZG2BOa02GB3khs1fJUXTMDCIIOQVV7YlkDdPpfAik
         ZRIlFFaooDdbQ7LocY5Qn4EupYOBRbZpG77r3Qt63sWJXgp+0AjYAk8Yx9sb86etSlUJ
         vPn020ucMdgSBpfwrZ3NuggJSFG27zjU00MhNoOcKaMYO5nTyeE92OrIVzFcY00zfiqP
         7wYw==
X-Gm-Message-State: AJIora/lymcW4PUSAZCmT4eE5yzku35HdyU+fCVqndK60P1Clvum3MPw
        bhP01OM5x4mFBqAJOg9D4pDrQw==
X-Google-Smtp-Source: AGRyM1uGrAhHXhNa8GumMf2zq7PU+wfp79kPHZ7PJ8Y8ijdAWAR4/sCz3QReeNWyA2joc0ixSYZ0KQ==
X-Received: by 2002:ac2:4f03:0:b0:481:50f7:ac07 with SMTP id k3-20020ac24f03000000b0048150f7ac07mr6416124lfr.422.1659425674316;
        Tue, 02 Aug 2022 00:34:34 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id l8-20020a194948000000b0048a9603399fsm2009441lfj.267.2022.08.02.00.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:34:33 -0700 (PDT)
Message-ID: <f6d7607f-dabf-9339-8d2d-7694a58e8427@linaro.org>
Date:   Tue, 2 Aug 2022 09:34:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/8] dt-bindings: dma: mediatek,uart-dma: Add binding for
 MT6795 SoC
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        fparent@baylibre.com, sam.shih@mediatek.com,
        sean.wang@mediatek.com, long.cheng@mediatek.com,
        wenbin.mei@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
 <20220729104441.39177-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220729104441.39177-2-angelogioacchino.delregno@collabora.com>
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

On 29/07/2022 12:44, AngeloGioacchino Del Regno wrote:
> Add mediatek,mt6795-uart-dma to the compatibles list to support
> the MT6795 Helio X10 SoC's UART APDMA.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
