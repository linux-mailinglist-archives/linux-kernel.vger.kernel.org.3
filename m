Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BAB59E42C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbiHWNVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbiHWNUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:20:30 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D2140E95
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:19:13 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l19so9904904ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=zsQrjzLlz1WwvkGgnIx2yqhoGVJPRWQAAvm1kJ/arH8=;
        b=MRoulzA5Ch+EYpnMY32xtg51q2QEePLjf7GlsZywJBP/elkNXCYvcfv12YpmeDtSds
         KeitN1Vw7Gs1cDEt0kGdoO9Pv1tIcFJUqTvFi8Xh8uizPJjhxUta7GRN/RAEoCDmak7y
         PCYivdELVk56Br/VRL8MY0Kn6uND09aTzuV966cpxiiMOUh7MujafwoJHplLe2FiuTRu
         PEd3fIkOd7DAE2g2z1OslDd7vO6MPXm+ggQi+WZQOccZgeEBjlGnPSKjbNeA1+FoEU/P
         aFHjmsDNNTYmm4XuaLOxs4dYx7WGseTaFxDcZuheVhKGv0nIm40wHlfgn87GAPGitiWt
         YXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=zsQrjzLlz1WwvkGgnIx2yqhoGVJPRWQAAvm1kJ/arH8=;
        b=0oKtM+oLrzCBT0VNkcdqHLMoGGHNDh9Su6rrUK4LiuWgrm7IE0MIz+Q18nV+Fgj+Zr
         ahjRfrGDJILtxzrhpTR90MaF7oMZOcPDdZGTg1fcmyHo7IY/N+BFa8gfCf7/emIi81sC
         PSKu3m/y0u/CKd3Yd0Xq/P9ZjwkbbTzjkYtPbgIQHPl9/xpDO/JCjhtcHkIey/AGYwyO
         Dx2Hoia48Zr/EZjywpcFmKC7AMurYj5eO/TIjiUGZrs8jC1aXzvdhbw1/wjKQuENgbwc
         +OAxl4xgYxkuytsWZ9GMCWGuajwQwETzaI1hNBgY/3UxiaRGB6BOxiA6BIWjXGjfHR1N
         Vyfw==
X-Gm-Message-State: ACgBeo0N4sy5jg8Zzoi+am4an7bRi9+KtXCiRkTDs5GLjwPPuaB+Gkgh
        h2yLgQ4YwioifRpWSyL0oKm5Ow==
X-Google-Smtp-Source: AA6agR6SStRV2Ym4CUUkrm3BT0NdS/bPaP1Ahl8puqMOULGHvQu0QkmzZ4yCqOreQsizM6DvzYFD0w==
X-Received: by 2002:a2e:7309:0:b0:261:d14e:7af2 with SMTP id o9-20020a2e7309000000b00261d14e7af2mr2016553ljc.45.1661249897669;
        Tue, 23 Aug 2022 03:18:17 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id g8-20020a2eb5c8000000b00261c6c80b38sm1503878ljn.75.2022.08.23.03.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 03:18:17 -0700 (PDT)
Message-ID: <b572cfa0-a051-ee7f-c720-5f0ccbea8950@linaro.org>
Date:   Tue, 23 Aug 2022 13:18:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/4] arm64: dts: ti: Add initial support for J784s4 SoC
Content-Language: en-US
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Hari Nagalla <hnagalla@ti.com>
References: <20220819190054.31348-1-a-nandan@ti.com>
 <20220819190054.31348-4-a-nandan@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220819190054.31348-4-a-nandan@ti.com>
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

On 19/08/2022 22:00, Apurva Nandan wrote:
> The J784S4 SoC belongs to the K3 Multicore SoC architecture platform,
> providing advanced system integration in automotive ADAS applications
> and industrial applications requiring AI at the network edge. This SoC
> extends the Jacinto 7 family of SoCs with focus on high performance
> providing significant levels of processing power, graphics capability,
> video and imaging processing, virtualization and coherent memory
> support.
> 
> Some highlights of this SoC are:

Thank you for your patch. There is something to discuss/improve.


> +
> +	main_gpio_intr: interrupt-controller@a00000 {
> +		compatible = "ti,sci-intr";
> +		reg = <0x00 0x00a00000 0x00 0x800>;

0x0, not 0x00. Here and all other places.

> +		ti,intr-trigger-type = <1>;
> +		interrupt-controller;
> +		interrupt-parent = <&gic500>;
> +		#interrupt-cells = <1>;
> +		ti,sci = <&sms>;
> +		ti,sci-dev-id = <10>;
> +		ti,interrupt-ranges = <8 360 56>;
> +	};
> +
> +	main_pmx0: pinctrl@11c000 {
> +		compatible = "pinctrl-single";
> +		/* Proxy 0 addressing */
> +		reg = <0x0 0x11c000 0x0 0x120>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +	};
> +


(...)

> +
> +		main_udmass_inta: msi-controller@33d00000 {
> +			compatible = "ti,sci-inta";
> +			reg = <0x00 0x33d00000 0x00 0x100000>;
> +			interrupt-controller;
> +			#interrupt-cells = <0>;
> +			interrupt-parent = <&main_navss_intr>;
> +			msi-controller;
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <321>;
> +			ti,interrupt-ranges = <0 0 256>;
> +		};
> +
> +		secure_proxy_main: mailbox@32c00000 {
> +			compatible = "ti,am654-secure-proxy";
> +			#mbox-cells = <1>;
> +			reg-names = "target_data", "rt", "scfg";
> +			reg = <0x00 0x32c00000 0x00 0x100000>,
> +			      <0x00 0x32400000 0x00 0x100000>,
> +			      <0x00 0x32800000 0x00 0x100000>;
> +			interrupt-names = "rx_011";
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		hwspinlock: spinlock@30e00000 {

Node name: hwlock
(spinlock is Linux specific)

> +			compatible = "ti,am654-hwspinlock";
> +			reg = <0x00 0x30e00000 0x00 0x1000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		mailbox0_cluster0: mailbox@31f80000 {
> +			compatible = "ti,am654-mailbox";
> +			reg = <0x00 0x31f80000 0x00 0x200>;
> +			#mbox-cells = <1>;
> +			ti,mbox-num-users = <4>;
> +			ti,mbox-num-fifos = <16>;
> +			interrupt-parent = <&main_navss_intr>;
> +		};


(...)


> +
> +	wkup_pmx0: pinctrl@4301c000 {
> +		compatible = "pinctrl-single";
> +		/* Proxy 0 addressing */
> +		reg = <0x00 0x4301c000 0x00 0x178>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +	};
> +
> +	wkup_gpio_intr: interrupt-controller@42200000 {
> +		compatible = "ti,sci-intr";
> +		reg = <0x00 0x42200000 0x00 0x400>;
> +		ti,intr-trigger-type = <1>;
> +		interrupt-controller;
> +		interrupt-parent = <&gic500>;
> +		#interrupt-cells = <1>;
> +		ti,sci = <&sms>;
> +		ti,sci-dev-id = <177>;
> +		ti,interrupt-ranges = <16 928 16>;
> +	};
> +
> +	mcu_conf: syscon@40f00000 {
> +		compatible = "syscon", "simple-mfd";

You need device specific compatible. Alone this is not allowed.



Best regards,
Krzysztof
