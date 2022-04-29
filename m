Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2526E514AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354938AbiD2NrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiD2NrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:47:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705E6CC503;
        Fri, 29 Apr 2022 06:43:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r11-20020a05600c35cb00b0039409c1111bso3832654wmq.3;
        Fri, 29 Apr 2022 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9SlylRvL62c7qQ0d0U09m8gj6wRuIZ4uikE6ZzCgN4s=;
        b=BwVtRPzCEpgLI6VmOgXz/NXKyEBrJx9Ro+lZVO+Mau+UOdV36jcm8vhmeyfNr9t+vg
         mYG4zfYRgfBP0L0x9m5YVeCd/PNwiwYJUKALD1HkikZi1RGbr3BY1rR7AOwMpvYkCOqn
         7DC75t3w+u83ocQ5qPFZpBqB7mGJppKkIy9qE3TiJc6MJN47fxBOipQk0mzOi5N9hPHx
         azauKMptEneUJagpdAfGPVPzVL3egBRmEAUy+LywOUMZMezOFkqv2gd5O10gjJwUouKX
         M7FHGEb4QkDJv/wdCWfyvw2+vhajUsnDV0i7srobR4NW2Z17+S9sHIqjtMRSk4Bjmebw
         3W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9SlylRvL62c7qQ0d0U09m8gj6wRuIZ4uikE6ZzCgN4s=;
        b=7SzLM5xFzv5ZtG+8RED2UgUA9qnv+3IqZoCIi2N/cK+vKgih8+y4iQryrVbhoyvvqA
         FtcrroZwZ5qC9kI7zDcTgtb57wZkXdZipEoa5SHWO/bnecElzYr3UsUScTg4hWMDOsvk
         lger0bdHKVNNusPh8Jp7smU96Uolt8N4nDhOBuZHMotEwC7TIhhbjDUk0eX+VE7Wf/+Q
         yQCh2Eo0Y0sHjotRufKP6Iq8RthQczrQFvR8TXl71tB1p+T3mu12CY1xFW6bSSwEbvB2
         Xr88ZqxbA1ri3x+QDdw8NZ8bMzBU3cSdqeDkncPFKIq/+rwvUGw3DGLhEo3FhVWNtLCa
         K0LA==
X-Gm-Message-State: AOAM531OchFT8aUSyx3X17ieaDr4QWUi23UaL7YbJyygoJphkdq5PLfe
        Sy3jHckJj1da3YeaAPD53ek=
X-Google-Smtp-Source: ABdhPJzHeQO20kA01fexo3yVJoC+v4x5EY+4oshVaGSoBUk3P1V+LEh6mKJWcgW7mdwV0uo3Hk3P5Q==
X-Received: by 2002:a05:600c:220e:b0:394:2695:ce9b with SMTP id z14-20020a05600c220e00b003942695ce9bmr193877wml.64.1651239835033;
        Fri, 29 Apr 2022 06:43:55 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm2600793wrd.32.2022.04.29.06.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 06:43:54 -0700 (PDT)
Message-ID: <36cddba0-ea3f-8993-7ffc-303a198043de@gmail.com>
Date:   Fri, 29 Apr 2022 15:43:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] dt-bindings: rtc: mediatek: add mt6358 and mt6366
 compatible
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yuchen Huang <yuchen.huang@mediatek.com>
References: <20220428092726.25814-1-allen-kh.cheng@mediatek.com>
 <20220428092726.25814-2-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220428092726.25814-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/04/2022 11:27, Allen-KH Cheng wrote:
> Add mt6358 and mt6366 compatible in devicetree-binding document for
> MediaTek PMIC based RTC. mt6358 and mt6366 use same compatible data
> to store RTC_WRTGR address offset.
> 
> mt6358-rts should be used as fallback for mt6366-rtc.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Yuchen Huang <yuchen.huang@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/rtc/rtc-mt6397.txt | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> index 55a0c8874c03..7212076a8f1b 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> @@ -14,6 +14,8 @@ For MediaTek PMIC wrapper bus bindings, see:
>   Required properties:
>   - compatible: Should be one of follows
>          "mediatek,mt6323-rtc": for MT6323 PMIC
> +       "mediatek,mt6358-rtc": for MT6358 PMIC
> +       "mediatek,mt6366-rtc", "mediatek,mt6358-rtc": for MT6366 PMIC
>          "mediatek,mt6397-rtc": for MT6397 PMIC
>   
>   Example:
