Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617AE554692
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353711AbiFVLF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiFVLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:05:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC853BBD2;
        Wed, 22 Jun 2022 04:05:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ej4so19413036edb.7;
        Wed, 22 Jun 2022 04:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BsWeZKTMRUjS4UGWGKXKi/F6OhLV9oNlEr0sqKPjdhY=;
        b=goSSVIS2xMmIt8+zQ+4MnTruyoXO+gM/WRoEM6Cuo0Prstx1aOOwxieSEas175GI/Y
         pR2Ri8ptjhMZM/G7BHcC7rgqDl7INoPAriq7bsCHGZaWu/qkjeRlUw4V0ROTlGdz8Jsz
         ZGNVA9rlMFvvpoELJv0Gr/0V7oP28iDObt/v/9fSfFXohainHuDFWRfYpz0WhcPFSn5v
         TZkEbd++U+4Lt5ORaWDswJ87h+OTBxqy3lfL3eFCaJcKfpk3IXE4l8eYzXXW4G6vNZaq
         /7L3bJjNz22oFeOw74YdcXFiGlAiK/Hpa+Ha3pZuSu6M0TMMTi0rSX0YXOE9lEsDAZtb
         l3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BsWeZKTMRUjS4UGWGKXKi/F6OhLV9oNlEr0sqKPjdhY=;
        b=gwWPpagxg2tym0yF/TD0jGE4LAX/u3gka7dvKYdEcUELY1WEyBLs5jwSpzqWAKNLCn
         Zo9mifafSVtbchn3n84YYOVA6b2Pnta+Bzi7vMXgLBKT3b8em40/EdNGpT3qH7JhEkuI
         ESho1wW8uHmjzpv2TgHb4ZBZRxS2MieNcRbiH6rod8nJqDjeiPNgcPKmC7dVdrVwX5IS
         2ztDEIAzfqhy/9DNBPrPlbmbx8yPWTNit6XRmtcQ8NDd96OvL8lpposXfThD0h2AzAAW
         XZqGNh9kmUBTTU6DezDODB9D0o4LYf1MN9fFJbHEAyPqmnMr1fPWFDlnJN/nCxJjdXEU
         rbqA==
X-Gm-Message-State: AJIora9OBXkgtVf4P9PEZVqYcYxPG4LxyTOq4xBg4aviCMJhaUwYoEl6
        uI/TKVwPq8utOiG02mjjLGM=
X-Google-Smtp-Source: AGRyM1s9nDUowq9+/oNlBIcMXsoZizGRGfHc6q9TiQd5vkG3V7Wuhzig5PXTkxlYtZVA2ciTT6f/JA==
X-Received: by 2002:a05:6402:4385:b0:435:9104:955b with SMTP id o5-20020a056402438500b004359104955bmr3470937edc.45.1655895915755;
        Wed, 22 Jun 2022 04:05:15 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id b12-20020a17090630cc00b00722edb5fb53sm1007705ejb.116.2022.06.22.04.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 04:05:14 -0700 (PDT)
Message-ID: <6b4f108c-b4bc-72cf-5972-222fbb2f3fca@gmail.com>
Date:   Wed, 22 Jun 2022 13:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 15/16] arm64: dts: mediatek: Add infra #reset-cells
 property for MT8192
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220503093856.22250-1-rex-bc.chen@mediatek.com>
 <20220503093856.22250-16-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220503093856.22250-16-rex-bc.chen@mediatek.com>
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



On 03/05/2022 11:38, Rex-BC Chen wrote:
> To support reset of infra, we add property of #reset-cells.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 411feb294613..79803420d8ef 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -269,6 +269,7 @@
>   			compatible = "mediatek,mt8192-infracfg", "syscon";
>   			reg = <0 0x10001000 0 0x1000>;
>   			#clock-cells = <1>;
> +			#reset-cells = <1>;
>   		};
>   
>   		pericfg: syscon@10003000 {
