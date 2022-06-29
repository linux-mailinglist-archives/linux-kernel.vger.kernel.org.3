Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D106E55FDC6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiF2KtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiF2KtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:49:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1B71A38F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:49:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fw3so4088103ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=baA9UVReBlJ4gVnrDyz4dAqxk2LXffGXuw2131Io+Xs=;
        b=Xbs715B9STAbNQ0EwSFISsyIdQQ4LuTgVzpCuaPuzRZ4m129IjIXf3DRAPdaKEjYsm
         JIDFhlVnAbe1RyL7xEGFf2fItbxHRPeukYBYU4T+tuhdZLbATg7v8I2CUi+0O/Am7saX
         XhNmxqPoqylhbQXtRiAuTcwCT1Ko3vKEDfZEDmSYJxOozzEZXjKJnk89SV2ybwzFvPgq
         lJknVRn4ZcMadGp5TOdSX8xfdhP1eLe6psqov8T/avJbEqdHGsNsEMkI1C4Qj2yF6quf
         dqeyvpks+jdVhLSMPh7rL3I8KGA5fTDRhqCnCvfLKpt/synchRPUtJFNRQBF8WJLrxaW
         k3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=baA9UVReBlJ4gVnrDyz4dAqxk2LXffGXuw2131Io+Xs=;
        b=tpmiyMC/l5vCYF2xRyye7QwKIO3hlRDGvAEI2yxMYSXAPpqPlx9vt3l0eggDs+F4+T
         EWVukYFdCutUuRFTg/A69hE4IE0hlhPFfSLo9ITdfTRgGpwGBWtczcsDdt7t9SpN5xPb
         3JRg4SSetwec4rknI5RrgHcMWZW3IGUDeUpndhvl73HB6NZ9cf+gX1SJiwBQ7wDbMGjy
         mPEG4voyyZQKEq3QfMWg/synYsvvoYKyxw2uKK6kkzp8Sg3R3PHLIn2pLZ915j2PqXTL
         CXm8s4AF+1SttkVvGP2nBM+g6B2y3lkiip1cRU2BBbijfz1H7WSMAxbfIVRlrPHy0dxP
         oGWw==
X-Gm-Message-State: AJIora+X8ttoopMWqAGtWuWmRYBd4yVvp6i6LtAYccYnnatT6ajO+n3w
        TgBi/IL6OHIPY0+KEBodQtYrfw==
X-Google-Smtp-Source: AGRyM1sBR1woO9PSRLRDGfi43ztmS22+sCcHwwD1BkKikBN/g7jU5/KGldrmQEy3hRirXoLPpmSyag==
X-Received: by 2002:a17:907:2814:b0:72a:3758:e948 with SMTP id eb20-20020a170907281400b0072a3758e948mr1713964ejc.8.1656499760309;
        Wed, 29 Jun 2022 03:49:20 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090609b200b006feaa22e367sm7527140eje.165.2022.06.29.03.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:49:19 -0700 (PDT)
Message-ID: <51748cbc-e895-13cc-6b8e-8c62b211aa4e@linaro.org>
Date:   Wed, 29 Jun 2022 12:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 3/7] dt-bindings: reset: Add bindings for MT6795 Helio
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
References: <20220627085632.23797-1-angelogioacchino.delregno@collabora.com>
 <20220627085632.23797-4-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627085632.23797-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 10:56, AngeloGioacchino Del Regno wrote:
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

You still need vendor prefix.


Best regards,
Krzysztof
