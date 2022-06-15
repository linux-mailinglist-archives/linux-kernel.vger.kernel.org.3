Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4854D3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348444AbiFOVst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349199AbiFOVsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:48:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D36E377C4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:48:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f65so12568194pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FZSDdV6mNRQiDJWSYS9igOAu0wbjoocy2kuoW1xZJug=;
        b=ZpEJrFA438ZSkfTtEVYExa6cnAWhsvmUfpjsXYhT3+RglSUp+BETn8FrcoVEUH1Xf3
         w89oj7m1+dvWYEBxZTzq8TOIK8k7osRT9F74IS6tONgVl/5eeyTXRDi4TNMcOvgrgGyK
         vtqC3QS4kuPYkPGwcJ41fbjaNm+v47aPMQA70fUDHFmvVcvy3Fq8Id2wO6YPLQhbfk+m
         ObQQZHAfWJStEW2KMHfeluBeHBzPldcOqfOXoL4LybCKsNNGImxL7J0tQj3XW1OJ/Cs7
         RYDFS/eBia5pw8WTh0ft13K/OGlBMrdMbKZ1B0ZXhfp2CZOsjSsA4O/eFJ6WV9w/PsIp
         2IyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FZSDdV6mNRQiDJWSYS9igOAu0wbjoocy2kuoW1xZJug=;
        b=aGK/b6DVUOtfFGpHPlMIwWikjYiFTB18BWpF7o2OeG91KmgTZaedg/S+LrO0xIDVwR
         YupWRGuq1DWmLGxnbggd+EvQx39a1U3YARx91aL7GRyhCI+DF7uUqMJNxl9/g/ooo4Tj
         lIoRfo5pcd+ibU3jb/vjDLaMqbxvXRmP1hJvAobUExGFlp5TLj+v5JY59AFvLrADU/Zq
         UvH+LkTGr0hkPtjFdwmKtFCPt0ddnSCn0ru/zLDLUDpCsCgeKJkv1gWPd4HpZC799dn6
         XSwREDoaW5qjaZKcvHm4g3LyTadHsjH63y0w6HU6weyotF5BdplwXNMTgEKTZ9lh9eMo
         klNA==
X-Gm-Message-State: AJIora8zneynAFjmFYzmGV0iwd0Q8eumdO7AFsZ4EPovF77my5uMb7tz
        kNQZuHbwI+HC3AyOwDZaT4ARwA==
X-Google-Smtp-Source: AGRyM1vkhWHhrlIjk/HHd51WfK5Or24gmvhP0SqUbOiKWv1kc7ZmeBlxTK44Ul6iywlD0zO883LPZg==
X-Received: by 2002:aa7:94a6:0:b0:51b:ddb8:1fcf with SMTP id a6-20020aa794a6000000b0051bddb81fcfmr1411308pfl.23.1655329714602;
        Wed, 15 Jun 2022 14:48:34 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903124100b00163f8ddf160sm97347plh.161.2022.06.15.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:48:34 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:48:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        hsin-hsiung.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: mt6397: Add compatibles for MT6331
 RTC and keys
Message-ID: <YqpTrwlXmXMYuDd0@google.com>
References: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
 <20220520124617.228808-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520124617.228808-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022, AngeloGioacchino Del Regno wrote:

> MT6331 is a multifunction device, providing RTC, keys and more: add

No such thing as an MFD.  What does the data-sheet call it?

What "more"?

> the necessary compatibles to start implementing the basics.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index d59063503b0d..2a9533c47365 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -30,6 +30,7 @@ Optional subnodes:
>  - rtc
>  	Required properties: Should be one of follows
>  		- compatible: "mediatek,mt6323-rtc"
> +		- compatible: "mediatek,mt6331-rtc"
>  		- compatible: "mediatek,mt6358-rtc"
>  		- compatible: "mediatek,mt6397-rtc"
>  	For details, see ../rtc/rtc-mt6397.txt
> @@ -55,6 +56,7 @@ Optional subnodes:
>  - keys
>  	Required properties:
>  		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
> +			      or "mediatek,mt6331-keys"

Please place these in a vertical list.

>  	see ../input/mtk-pmic-keys.txt
>  
>  - power-controller

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
