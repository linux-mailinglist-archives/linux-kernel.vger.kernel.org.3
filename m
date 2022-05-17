Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6BD52A4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348913AbiEQOaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbiEQOaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:30:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69842A3C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:30:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h29so31709515lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MwRo3rFibChV4O65q8eXjp101W+2zLrCGSrd/xmpC7M=;
        b=SvO/C1fUqmnr64ihkaFXtCYLUItLInkrgOLwfRO07OyNF+am/v6RV4hFMu8TUxKgsD
         es3SI5z1pxH665t48wNjeSMnHzYktwzjuYr3UdxNOwJuaPQt+SIXkxZhR8hocfZ9o3J/
         leWLxo0HSkdHYNq681L6EqQ4uwW5SmJqkW7gMTgYVICD4yoreUDwp/Lw8LD8mqZRqGM3
         Pixb7e6u9UL1qxI+ci7ku8qbSwO49JHBV72fRgzX3pdEARBHnXNw+eihCU/D9Rd6HwDE
         Oa6ll7OPAegL7sIki8QrvBV9TvBDA9Wy7FmtfrPcUbOikiHfo9fpHilxO0SnoCC2Ygu0
         kQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MwRo3rFibChV4O65q8eXjp101W+2zLrCGSrd/xmpC7M=;
        b=5B/klr4yY4fFKCL9xsQ0gWL9Nf1yDASenU6y6Cbzqnc8fH5cCVXT7AaSAxdHBhY6fE
         8rTARZ+m06VJCKY4efSreGeXeBZNVMih2gU1NSetx1yWPGrgUPzULrJ6h1OjQXGwh86d
         TUdSbQfNDHX5wtyz8NyoW88RBmLtUMrGV2tH8CROkDEFUPvrBgqBU06YgOlnSImjwXUE
         ACA1EORPa26O4ozJVqLnd6ZrObBPOA+Zt+ZArYIbTTJp0Y1hnc0A6yZPxu/Wtqi7txfa
         m0tGdir1DmgG96tV3b/Xwb+OD4oZUL//slMoRp5qM3gRUFWA0Kdd1MKqcacmtCGtaZxp
         mc0w==
X-Gm-Message-State: AOAM532DrEuUdXlJzFwLB9kZUbXR0arN2t5qiEe6lBIZuQXJa08IFRJ3
        zTRzqvhv9QVNq9mAJcPTRtN+9w==
X-Google-Smtp-Source: ABdhPJzzI1cy4wLl0DIOkPpDOw7qoQ8fui0WGqjeuo2pp5rjDj30k+XU38Y64hEoyl+kbNEnkf+CVA==
X-Received: by 2002:a05:6512:10d0:b0:477:8ce3:ccd5 with SMTP id k16-20020a05651210d000b004778ce3ccd5mr10560371lfg.203.1652797811545;
        Tue, 17 May 2022 07:30:11 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u12-20020ac2518c000000b00477a97cb50bsm142157lfi.32.2022.05.17.07.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:30:11 -0700 (PDT)
Message-ID: <b3c835fc-3b9a-8207-a99c-4c289a6ee7ed@linaro.org>
Date:   Tue, 17 May 2022 16:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/6] dt-bindings: arm: mt8186-clock: Remove unnecessary
 'items' and fix formatting
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sboyd@kernel.org, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, wenst@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
 <20220517101514.21639-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517101514.21639-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 12:15, AngeloGioacchino Del Regno wrote:
> There's no need for 'items' when there's only one item; while at it,
> also fix formatting by adding a blank line before specifying 'reg'.
> 
> Fixes: f113a51aa2cf ("dt-bindings: ARM: MediaTek: Add new document bindings of MT8186 clock")

The original code was not buggy, so it is not a fix. There is no single
reason to backport this patch (which you will cause with Fixes tag).

For the rest:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> Signed-off-by: AngeloGioacchino	Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../arm/mediatek/mediatek,mt8186-clock.yaml   | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Best regards,
Krzysztof
