Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48015530CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiEWJ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiEWJ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:27:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF55248E73
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:26:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id v8so22582728lfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Rall/J8MbFkSCpGGCaytH6f+MPOlebnjwNlb4WkgynY=;
        b=PaQ05G23J+igp19tyJ0HeXIV2fAILu8L3PMe0F59HpAyJqM3VmyUa+wVPNg3qMMUnv
         sWAb+WepiWB1EAqlKOT2fDXu131odcFLpJhGd+tVaRzKX0qsrlKUrayRSpvsjRcnUJV3
         MwSz9l5zWe2sfiwKOqzJqCZiC8Kb9dxQPkbaBVU+ecXvI99qBrpLNu/zNzrufzgMWTQg
         ueAQIA1QN+jEA4WJK5upxYV7g2InSbnEqtpyIixS6PLOitd8zzBMjSmC1nePJUAXTbSq
         vww1m3PEvShdykhfB1XL2C+fz8FxDa3zYJuOBF3AlrRtu05Obcfv4NTL2tUaIxdIKc1o
         QdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rall/J8MbFkSCpGGCaytH6f+MPOlebnjwNlb4WkgynY=;
        b=bX+HWCfBh5Mwa7FaDpc+/sYLB94yBJpG1PbSyo2RsENIEo8WXXGGcYnigriW6v4ExN
         /vIIE17N4Wnqw3s+AR3UZEjTwFH8kFdoOovi0DeeCQOAAniZLyuH1p4kqRzzu6BP9ldy
         62C28GqwgADajVGNue7keG2cjVs3qwymdUC4Gh2DBKOYYt9Qb3GfdmO4Y8lIWBtepRL/
         4TvXYO78ZiS0iMqHrlJ5hBFyeoAXt5v/VEFhMeZ+TkwwglGZvZct80tj5yufH96M5jVK
         jw4EGNVuDIcSXSAR9Xu3C1IVMhGMjFymit6ys1FA9hXyjcgcrHjU4nlrjD5foOAUoL23
         RuhQ==
X-Gm-Message-State: AOAM532legasD2+HBMYljdF27JnwXI2dpkg0o+ZNMo6niHMkSNmJW7vD
        dodBN3ObIB0mZEjCeWcMteB4eA==
X-Google-Smtp-Source: ABdhPJzJFQjxkp3Wd+qVBwevcO6f0Rflfc4HMB1wNhOBEHg8kVAZSPqPiDDcL3E2aJC2mKHs8fBatQ==
X-Received: by 2002:a05:6512:2307:b0:478:6ab0:c22f with SMTP id o7-20020a056512230700b004786ab0c22fmr4557286lfu.232.1653297989927;
        Mon, 23 May 2022 02:26:29 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p1-20020ac246c1000000b0047255d211fasm1870435lfo.297.2022.05.23.02.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 02:26:29 -0700 (PDT)
Message-ID: <25aae69e-fed8-bf69-a110-8e134db1eda1@linaro.org>
Date:   Mon, 23 May 2022 11:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 18/19] arm64: dts: nuvoton: Add initial NPCM845 EVB
 device tree
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-19-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522155046.260146-19-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2022 17:50, Tomer Maimon wrote:
> Add initial Nuvoton NPCM845 evaluation board device tree.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  arch/arm64/boot/dts/nuvoton/Makefile          |  2 +
>  .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  | 50 +++++++++++++++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
>  create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> 
> diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
> new file mode 100644
> index 000000000000..a99dab90472a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_NPCM) += nuvoton-npcm845-evb.dtb
> diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> new file mode 100644
> index 000000000000..d7a9a85f8075
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2021 Nuvoton Technology tomer.maimon@nuvoton.com
> +
> +/dts-v1/;
> +#include "nuvoton-npcm845.dtsi"
> +
> +/ {
> +	model = "Nuvoton npcm845 Development Board (Device Tree)";

s/ (Device Tree)//

> +	compatible = "nuvoton,npcm845";

This does not match your bindings. Please test your DTS with `make
dtbs_check`.

> +
> +	aliases {
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +		serial2 = &serial2;
> +		serial3 = &serial3;
> +	};
> +
> +	chosen {
> +		stdout-path = &serial0;
> +	};
> +
> +	memory {
> +		reg = <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +	ahb {
> +

No need for blank line.

> +		apb {
> +			serial0: serial@0 {
> +				status = "okay";

No, override by labels. Here and in places below.

> +			};
> +
> +			serial1: serial@1000 {
> +				status = "disabled";
> +			};
> +
> +			serial2: serial@2000 {
> +				status = "disabled";
> +			};
> +
> +			serial3: serial@3000 {
> +				status = "disabled";
> +			};
> +
> +			watchdog1: watchdog@901c {
> +				status = "okay";
> +			};
> +		};
> +	};
> +};


Best regards,
Krzysztof
