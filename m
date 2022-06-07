Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49476540375
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344877AbiFGQLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344862AbiFGQLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:11:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C7E100500;
        Tue,  7 Jun 2022 09:11:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z9so2804146wmf.3;
        Tue, 07 Jun 2022 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HudpD98f6GFJ5B/ZS9VSp+I100XFU0qZ9neTB4R0OMA=;
        b=qyER1BKCu5XFFcoaFm1MFRkKxiu9zEa3kZsdfZv1/6mmYCTzyMybulbXhrwXGq7kzt
         PCUoM5v2soN6LfMJ75DkcY+kh3Kz4W8/Ji46gkh5PQWbjsr4Dz7/c9ORGmlu8IvltBAO
         5yddMZ8lDQZa/5jKz2toQFdST6PTnojwKW5HocjKg7Ys9X2r9PKlBUhukc39BAvAkRe/
         84xISuv7mlDp1fuuxrqnVq64ZvDEvmWYEWhEbpbSJd7+KOgnT0OnkqIomRRo+2vK7dvr
         XuMFGfcZAR6uHZDPLCMOIuxCg4IFJEvPpY/TAiIiCUEd+uY4vnyN2qq6HwAomz0s4FdE
         6xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HudpD98f6GFJ5B/ZS9VSp+I100XFU0qZ9neTB4R0OMA=;
        b=ewFPrb82Si0hnD1OQ8/xCeIoQtuPCXEYDbYQ35QPseziQSmKHItR8FRUxspOHcZhcS
         ZiBQ94bl4fGRhsuMyOUu01nBZ/RI5/dYhmNtl6nOWvnmx75Ulb2NqMyc/blETGdrqQqf
         C8vSXpbj47/5lWt4NctLEweM7dR3x8aktXvM2Qa1oMrhDtpgI0VOHcEge5LY0qE2phdi
         /NEZzNGcSBblyGemfdVO1moeIRPOu6Z7k3WTn90l8e21Yrt24EJWZcR1IDGxWP/EhzOR
         YsNfLslXxDK1eDkfiyezzLs+HXuM1jxaDpWixEla5ggi154GiShKiGr24V4TfZ8zWJj4
         j+qw==
X-Gm-Message-State: AOAM532U183NZ+D3EX7uEjdW311i6irL8/oiP5qB9Bchtpttrh65sSPy
        IT+ulz7py3iYcy9S8jNP/fY=
X-Google-Smtp-Source: ABdhPJwyDmBTK3dce68p6NIVVz0SZn6aoAX+f6bCgJzS860gTJqa6XBrNDKM7ZVk+1RuQ6nEhVOqIw==
X-Received: by 2002:a05:600c:198e:b0:39c:2b73:60ab with SMTP id t14-20020a05600c198e00b0039c2b7360abmr28420635wmq.14.1654618263856;
        Tue, 07 Jun 2022 09:11:03 -0700 (PDT)
Received: from [192.168.0.36] ([37.223.143.134])
        by smtp.gmail.com with ESMTPSA id t22-20020a05600c41d600b00397550b387bsm24690689wmh.23.2022.06.07.09.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 09:11:02 -0700 (PDT)
Message-ID: <afd9ab8e-5bad-54ee-3f44-5e0cfdb22e75@gmail.com>
Date:   Tue, 7 Jun 2022 18:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: mediatek: Add CPUX System
 Timer and MT6795 compatible
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20220518112435.241116-1-angelogioacchino.delregno@collabora.com>
 <20220518112435.241116-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220518112435.241116-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/05/2022 13:24, AngeloGioacchino Del Regno wrote:
> Document the "CPUXGPT" CPU General Purpose Timer, used as ARM/ARM64
> System Timer on MediaTek platforms and add the MT6795 compatible for it.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../devicetree/bindings/timer/mediatek,mtk-timer.txt          | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> index 6f1f9dba6e88..49706cbef45d 100644
> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -2,6 +2,7 @@ MediaTek Timers
>   ---------------
>   
>   MediaTek SoCs have two different timers on different platforms,

Nit: There are now three different timers so maybe:
"MediaTek SoCs have different timers on different platforms,"

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> +- CPUX (ARM/ARM64 System Timer)
>   - GPT (General Purpose Timer)
>   - SYST (System Timer)
>   
> @@ -29,6 +30,9 @@ Required properties:
>   	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
>   	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
>   
> +	For those SoCs that use CPUX
> +	* "mediatek,mt6795-systimer" for MT6795 compatible timers (CPUX)
> +
>   - reg: Should contain location and length for timer register.
>   - clocks: Should contain system clock.
>   
