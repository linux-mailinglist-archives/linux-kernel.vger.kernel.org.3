Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074315A0E90
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbiHYK4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbiHYK4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:56:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B6FA6AEB;
        Thu, 25 Aug 2022 03:56:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k9so24115478wri.0;
        Thu, 25 Aug 2022 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fPrr5vkd2rYgejIwUMWJzS+nqPWI3EpvuWuHwQVmmTM=;
        b=cXvaY2qOO7GXdF10qORYtkwnYW/U2uYVCxUsFydUQpKoF1XHBGmwRiTjT0ABAr9JvD
         ARlzpiLEEjjZZgHgFlMzAfwlZKviBb+dpad26IDYFmdSCzUP6orxKYXZVVxmYg/8L1E0
         qUUtRg3cdFEpsFePagPneRBkPo0aM0w0shRPLbBTyP3W19kCefJCL18Dd3u0SzaxryWT
         uEWDBVlzTsE+iExuFOZNAx43Z47EDSYLpVJO29qtiy3c0jAs2ap5KTMnaT3aujKmppso
         s9YgGUHm6R6ZukXqqZPKh3w7nfUieGQKnjyJeWmb2JeMF3pXpp86if9SGFPHpnDnOIpe
         HbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fPrr5vkd2rYgejIwUMWJzS+nqPWI3EpvuWuHwQVmmTM=;
        b=Q+TbAdOQSadHb6ZDNBPRrFLzIwz9VnRXsAHwOCIl+u6QyuaQYrANdrG8lSLE2FGkil
         5WPgyQ3Td8M5JyCkyBUR3QQmXX0lt2jrA1CLS9f9mJoC6RrLWMhllK5GFSSpxBNZ9AXS
         MzTxgqPD1oipkdCR1S5Vi3Uqfv+cM+Y9wtaSStRvpg7ygkCmOeKUuCsxvuyuFIhG5r0s
         7N6mLCBOqIEIQRUSoEKSgWCzijBE1pkwUpNUBCwmY3gmf/CNQlBrapOxpkS3tLKp6ynG
         wZ68/afgf3dHjcFt9luSKXAgchzyf1KMlNwLoZagzdosa1fMsVL8yIXzeExsJjodq/lC
         sMlg==
X-Gm-Message-State: ACgBeo3ZCLEa+T8+nW2Rw+CfxGfd6piZ7zlulz6JTv9/KUqXouYQCjZM
        ZtFW5vWBFj87l7uMUdV6nfE=
X-Google-Smtp-Source: AA6agR48AFG+EbCXcMuPyresO0qOUX5PNhKvhn8fo+4y7J2rjEHtEWHDtMQGSB9W7NgWp4ncKMpC/g==
X-Received: by 2002:a05:6000:a0d:b0:225:4bf3:95bd with SMTP id co13-20020a0560000a0d00b002254bf395bdmr1942368wrb.289.1661424994934;
        Thu, 25 Aug 2022 03:56:34 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id w4-20020a05600018c400b0021e5adb92desm19445731wrq.60.2022.08.25.03.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 03:56:33 -0700 (PDT)
Message-ID: <9ba586d6-bc1b-05b6-1018-d8f774e2c952@gmail.com>
Date:   Thu, 25 Aug 2022 12:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] dt-bindings: arm: mediatek: mmsys: change compatible for
 MT8195
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     jason-jh.lin@mediatek.com, nancy.lin@mediatek.com,
        ck.hu@mediatek.com, chunkuang.hu@kernel.org,
        angelogioacchino.delregno@collabora.com, hsinyi@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220825055658.12429-1-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220825055658.12429-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/08/2022 07:56, Bo-Chen Chen wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> pipelines binding to 1 mmsys with the same power domain, the same
> clock driver and the same mediatek-drm driver.
> 
> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
> 2 different power domains, different clock drivers and different
> mediatek-drm drivers.
> 
> Therefore, we need to separate these two different mmsys hardwares to
> 2 different compatibles for MT8195.
> 
> Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add mt8195 SoC binding")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>   .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml       | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 6ad023eec193..bfbdd30d2092 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -31,7 +31,8 @@ properties:
>                 - mediatek,mt8183-mmsys
>                 - mediatek,mt8186-mmsys
>                 - mediatek,mt8192-mmsys
> -              - mediatek,mt8195-mmsys
> +              - mediatek,mt8195-vdosys0
> +              - mediatek,mt8195-vdosys1

If I understand correctly support for vdosys0 is merged with the old compatible. 
We should therefore keep mediatek,mt8195-mmsys as a fallback for 
mediatek,mt8195-vdosys0.

Regards,
Matthias


>                 - mediatek,mt8365-mmsys
>             - const: syscon
>         - items:
