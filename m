Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE2F55472B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353741AbiFVLIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiFVLIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:08:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69C235DF3;
        Wed, 22 Jun 2022 04:08:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o10so23373592edi.1;
        Wed, 22 Jun 2022 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vlJPaWZrBAzG9zVsTlPDKOfBvLxqfXex9tzVExVOy6w=;
        b=l2D9wYP1r3RQtj7l6aaHLf2JXJZmHzq2H8bmoRYlR8YceEn2ApY30wqlSsH+ylJt3v
         aqxCRoD9MW+spCqGJUBmuQpRG3SMxRI2EtH0YHLlYeQm6HySHBGoEEsX4GrvimNBpPDp
         BMFdlqX7E5RleJMd2O1pKxntnwRzVnc3eoNmhcVe1GQeMkxZPcfcTniul2+fjAZBp9+n
         q5JWib1nloudfIx/EShgbGI45Qmb4v6ceOSaD3OCtmJi1fh8vKPJy61T7xxAgxdXs+GW
         wDDPiGpEKHqyne9YWzTjfnKj5X1syOEsP5jvhDFgxkO6tz1B6grNEHuy1uU0hXKo3H9V
         EC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vlJPaWZrBAzG9zVsTlPDKOfBvLxqfXex9tzVExVOy6w=;
        b=4adcFzoxUPi4fnSzdX2ltajMEq3ja/QI4WCMQWONr9LcfP5AmChR/bA0S9zv/QNn1S
         xXh0W422es27260cYtlWvYHbAPBxfQQje9ZrpCfPayvid0ImD8Nd8eyHSaEJGU1k5eIv
         7Lf87s/YfNtB7PmhGuLBOU62aG3XSYXjLRnij2Xh5kNrAnpMRHV/e34GU/zx8FDp73aS
         4MTxQS1H7wB4YRGQFTHwNUW8gf3JqrfJV24AyGu1dxrpcHvhVSYXuon50E8Ws2P4BPMA
         QdwvLocVu/RpN9xEBbZKSN2a0wcBY84cBAUjVlWzkrTQa3WouH7dgL+MXf4fmsOV+hg/
         Ui/w==
X-Gm-Message-State: AJIora9c6vN8Ze2B7oYNl8hovniQfkwZfBjcjp+TF+iwd67wcLf6UQey
        /hlaYCJe73CeK7AY2BxH5C0=
X-Google-Smtp-Source: AGRyM1tPvqoJyTRlLUMrUILBK6wwNicXk74DfsMpdEzAjQEzwlAMJ5hbcjGcUi16hzG9hv0/UbZNMQ==
X-Received: by 2002:a05:6402:520a:b0:435:965f:e266 with SMTP id s10-20020a056402520a00b00435965fe266mr3371871edd.409.1655896089167;
        Wed, 22 Jun 2022 04:08:09 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906329500b006fe8a4ec62fsm9104708ejw.4.2022.06.22.04.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 04:08:08 -0700 (PDT)
Message-ID: <3a587e20-f991-adf8-fe4e-a09caa1e14c7@gmail.com>
Date:   Wed, 22 Jun 2022 13:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 16/16] arm64: dts: mediatek: Add infra #reset-cells
 property for MT8195
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
 <20220503093856.22250-17-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220503093856.22250-17-rex-bc.chen@mediatek.com>
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
> We will use mediatek clock reset as infracfg_ao reset instead of
> ti-syscon. To support this, remove property of ti reset and add
> property of #reset-cells for mediatek clock reset.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

My understanding is that using the old DTS with a newer kernel wouldn't 
introduce a regression, correct?

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index b57e620c2c72..8e5ac11b19f1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -10,7 +10,6 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> -#include <dt-bindings/reset/ti-syscon.h>
>   
>   / {
>   	compatible = "mediatek,mt8195";
> @@ -295,17 +294,7 @@
>   			compatible = "mediatek,mt8195-infracfg_ao", "syscon", "simple-mfd";
>   			reg = <0 0x10001000 0 0x1000>;
>   			#clock-cells = <1>;
> -
> -			infracfg_rst: reset-controller {
> -				compatible = "ti,syscon-reset";
> -				#reset-cells = <1>;
> -				ti,reset-bits = <
> -					0x140 18 0x144 18 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* pcie */
> -					0x120 0  0x124 0  0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* thermal */
> -					0x730 10 0x734 10 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* thermal */
> -					0x150 5  0x154 5  0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* svs gpu */
> -				>;
> -			};
> +			#reset-cells = <1>;
>   		};
>   
>   		pericfg: syscon@10003000 {
