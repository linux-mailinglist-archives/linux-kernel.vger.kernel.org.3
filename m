Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9BB55AC95
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiFYUaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiFYUaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:30:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4887C13F30
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:30:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eq6so7860259edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PHG9vYe2+hEIeP66IB+CeZnBwWHvaVXCoSe7QCvQNhU=;
        b=xSpJ6XbSd0A7dLt1FY+JUOG/cm/CKtjXEIFSby2R4jI0UjMkpOlGppnN29cACTsGaw
         sz19dgQdZqYcm6kexLNZDhBNGKeuw4IHI/mdiCemWqY8omrh/akAvMFtoPlmlzMrNmKT
         97cxcHtvQ4E6UKwbkCZ1K47JD+i3agmvrw125GPneZ74GXXGpbPMP7EYqX5Oxunrdm8U
         tluliXhTH7TD0ISez1OaWMau5YiJPZkqmV/4p1aTDn6VuxtNhIi9rmdTAqRxEhI72+sC
         EK4fB9yl74Cv04yEn+jkwAv7k77qr4IxDosmiV4Jv13kSaoK58EafOZNH2XqKcleWkks
         09hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PHG9vYe2+hEIeP66IB+CeZnBwWHvaVXCoSe7QCvQNhU=;
        b=FEcvgLHcU2zCLalS+AG8qPYGQ1nC04NAK2M8xZKyvpuOjTK0kDP2/GYNcoNywxudzv
         2oNMlFdzQqn04Ia+a/OydhgSD9Na85qEmaftsbKTMPtnURLe7EFUJBZMhQfyBwHHlkq4
         vqsboUxdDCzqhNSrHEph/QZ1dM2b89P/2QgsIyaPWh7+Jk7N8vExi2YeWN1lpH6txMdT
         OROnf8NolgIig7UTYlwMhaolGPhpOLsRJN6dBJltMnndectW/HKqiWR/W4oi9Ft0FR0Z
         pC5hDFt9J/BCODfn4jNkTj2MxYv8wVBzXh+jM6/NQKf5O7NwGmA3S64ACstWKUx7Cz4y
         jigg==
X-Gm-Message-State: AJIora+v9MhoysY1SpV7cdhzuPrFMEqnIfwyUS21a026BAu6MTY7hX+y
        O4Ho8aqGtT3G5rEJTXObspifYg==
X-Google-Smtp-Source: AGRyM1u2IoPVRmbzjGQPCytqxD5DC+9n1JnhWsNu7nFxeSHqqkgpsfArHMNCP7TFUZFu4aG1BuusKA==
X-Received: by 2002:a50:fc15:0:b0:435:7897:e8ab with SMTP id i21-20020a50fc15000000b004357897e8abmr6969427edr.17.1656189016908;
        Sat, 25 Jun 2022 13:30:16 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006f3ef214dc7sm2960987ejb.45.2022.06.25.13.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:30:16 -0700 (PDT)
Message-ID: <1c3d3e0a-5598-be8d-fc48-04529e7fecb0@linaro.org>
Date:   Sat, 25 Jun 2022 22:30:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/7] dt-bindings: reset: Add bindings for MT6795 Helio
 X10 reset controllers
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
 <20220624093525.243077-4-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624093525.243077-4-angelogioacchino.delregno@collabora.com>
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
> Add the reset controller bindings for MT6795.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  include/dt-bindings/reset/mt6795-resets.h | 50 +++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mt6795-resets.h
> 
> diff --git a/include/dt-bindings/reset/mt6795-resets.h b/include/dt-bindings/reset/mt6795-resets.h
> new file mode 100644
> index 000000000000..0a6514884eae
> --- /dev/null
> +++ b/include/dt-bindings/reset/mt6795-resets.h

Like bindings, so vendor prefix is needed.

Best regards,
Krzysztof
