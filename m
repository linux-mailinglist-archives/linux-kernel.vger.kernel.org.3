Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9DA4E9690
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbiC1M31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiC1M3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:29:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05244D605;
        Mon, 28 Mar 2022 05:27:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j18so20132587wrd.6;
        Mon, 28 Mar 2022 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JbGAok762R8eBf1hqPVfuq1fu8O4b6lICrVhcAOXnnY=;
        b=eDh8olkgVMK3UTpO18awHgIc3Ed1jsfRMZAreLXkhBIlEA7DeVZ1QaLXRVgqazyhZG
         Y6kvkvxAUwxy8MKoK65O2iq8YCwLPmqQ+3l5aOa3tWqqdnxJMSxGg7IGW65JFrEycRlR
         es6W82+/BH70jMdcVTDB/o778CCgAQvrwY1jEFzkPry8R0yfOl0n9lgD717vx/XyluUB
         nNFbpYcQS01CHq0N5yK3ivzIodKMnvg1qxWeSt+865nFs/tES+bXuTGtT/fqcF42IXnV
         FZNgTEakz22bqP1JaQFIPFL4D+l/1CEZbON+UfbNprd1gMoMmdmJTtvPtfYc+Nli8a7u
         v39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JbGAok762R8eBf1hqPVfuq1fu8O4b6lICrVhcAOXnnY=;
        b=i3Acjqw0AC278lwSytd6C25cuzGgPfa5zlUP7lut1MLwLVeWoKmUmrQs5H+T0aOykv
         POnqH2TEhyw/znW8teWwKSe6W198/LS2sLCCY+g8YHzazx1NNrKOneWZygXpVNnD3Db4
         kcyJV43biR5Op5a1JRhBoa5VkexS0w4TgsEhOVMzPzVhy3ifGhDKcjfKGkHQjoWym7N3
         LCoshf1Q19lxoE/kWNnxQdVGetY6FzCPN8FFA9wv2eemxrUG4OM59MBdpnqF3cqGWE1M
         pvERvyk1eS/UFHYh1aWvRX91W/5Qks+6O9zy5GMpy5WidC1ikc37Bp+XRWdFXLV+cn5p
         /kqw==
X-Gm-Message-State: AOAM533+D/1kQverk5XPDpjRhR4FGb0ewgPu3uAL7v1oCzsE2GaS645h
        Va9C1P7WYMiq8Nri62lrHKc=
X-Google-Smtp-Source: ABdhPJyJhWj9ZIEO6fsrHVxsB2RCiBoanzZrq0bKdtFkggensDubXGrxlX1xOnXys9deFbRpSsu4Rw==
X-Received: by 2002:adf:eec1:0:b0:1e3:1e0a:72f0 with SMTP id a1-20020adfeec1000000b001e31e0a72f0mr23809347wrp.524.1648470463325;
        Mon, 28 Mar 2022 05:27:43 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b0038cda9f92fasm10725613wms.0.2022.03.28.05.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 05:27:42 -0700 (PDT)
Message-ID: <a48706db-cdc9-2a1d-0abb-08dd961c17e9@gmail.com>
Date:   Mon, 28 Mar 2022 14:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 1/3] dt-bindings: arm: mediatek: Add mt8195 pericfg
 compatible
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
References: <20220216113131.13145-1-tinghan.shen@mediatek.com>
 <20220216113131.13145-2-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220216113131.13145-2-tinghan.shen@mediatek.com>
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



On 16/02/2022 12:31, Tinghan Shen wrote:
> Add mt8195 pericfg compatible to binding document.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml       | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
> index 8723dfe34bab..611f666f359d 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
> @@ -26,6 +26,7 @@ properties:
>                 - mediatek,mt8135-pericfg
>                 - mediatek,mt8173-pericfg
>                 - mediatek,mt8183-pericfg
> +              - mediatek,mt8195-pericfg
>                 - mediatek,mt8516-pericfg
>             - const: syscon
>         - items:
