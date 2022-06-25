Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBC855AC97
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiFYUa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiFYUaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:30:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FB4DF54
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:30:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eq6so7861363edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VLrefeAKt/Dq3outV5iV9u0MgIc7/N/yAidOvpVDbJc=;
        b=KZc5XUfSTB6d18qR5A6cE7D0tWCGwMhGBMo1UKJN3/LXHkcy4U4HMmrIYkoGCUKSvn
         ezA6v3kzloZnpdhm942xQb9LfpJKG+Oa2CMf9t7VNHTPZdzCAMPaAvs4N6+u0r0aZyjZ
         10VdRnOie5ay0w9fyvYizWAVz7CCeGEFVhlLNHFXhY/NdduAL8M6Rqw7pEztmPaxn//m
         RIB86JHvKpjEVPXOCmL9gxXJYptwhU0KNouN6/1aNTAZf2Y83lkLUTIFAiRgQjkI83Jf
         J3kOGpraHqgfI16zYOgB50cc1t0HBLZ2iFU0FzlDDtPIftaYfsBzzoT7a0jeey7wm07E
         kiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VLrefeAKt/Dq3outV5iV9u0MgIc7/N/yAidOvpVDbJc=;
        b=aYfpvkvaciYUSYwXALEZYXsG8VKbv3aoXlg1NBKNg4QLHGwg7iWkxHdW0XRamFrXg8
         AztXmcylWhuAfnTke5fcc/PKdS3yai1aXfHCjuDVeor0MIQ9Z3yorTgtMcoaxApCmZ/b
         GyqNRauIFA1L+Dzc3rou4VQyUpkpYfmRRy6o7K2pMceUIJs7ViCe0Mn/oaDN+FKRxN7i
         +5uW/vaxb4sFiML7Ue51CcHx/JusRBrHr4G1sMPcyGJSEjVaw2G0ivk/YJnwosDOsUIj
         9Nw9Xt0oCexQ6yGp9SFvXFyiWxUZZo1XKs+oX6qpu4fjqMSPkmvZLKM9+A4ZPJpe69VN
         SvOA==
X-Gm-Message-State: AJIora86XQF7NHDtxPu4BqmK8Sk4EYePT4Wyasluea2DOdIQ6HCAQu2b
        x5EhmSmXZPH1yt+cIBg3LeTpZA==
X-Google-Smtp-Source: AGRyM1uVxpf9B5TTl1Z7wyKfg1MYoKCGhLn+4rU1ejsUCnvE/XzJ6gdXqNQmFz45WmrjdZukZZqU9Q==
X-Received: by 2002:aa7:d353:0:b0:435:6a15:139f with SMTP id m19-20020aa7d353000000b004356a15139fmr7110700edr.19.1656189052795;
        Sat, 25 Jun 2022 13:30:52 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090660c900b007262a5e2204sm2971200ejk.153.2022.06.25.13.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:30:52 -0700 (PDT)
Message-ID: <de5a0e6f-411f-0c7b-ae1e-1117a4126d2d@linaro.org>
Date:   Sat, 25 Jun 2022 22:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/7] dt-bindings: clock: Add MediaTek Helio X10 MT6795
 clock bindings
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com, Rob Herring <robh@kernel.org>
References: <20220624093525.243077-1-angelogioacchino.delregno@collabora.com>
 <20220624093525.243077-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624093525.243077-3-angelogioacchino.delregno@collabora.com>
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

On 24/06/2022 11:35, AngeloGioacchino Del Regno wrote:
> Add the bindings for MT6795's clock controller.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  include/dt-bindings/clock/mt6795-clk.h | 275 +++++++++++++++++++++++++
>  1 file changed, 275 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt6795-clk.h
> 
> diff --git a/include/dt-bindings/clock/mt6795-clk.h b/include/dt-bindings/clock/mt6795-clk.h
> new file mode 100644
> index 000000000000..9902906ac902
> --- /dev/null
> +++ b/include/dt-bindings/clock/mt6795-clk.h

Vendor prefix.

Best regards,
Krzysztof
