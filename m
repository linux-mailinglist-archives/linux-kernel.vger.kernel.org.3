Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE253B88D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiFBMBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiFBMBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:01:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E6822BEB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:01:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q21so9555533ejm.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 05:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pwtV0vYkvqvfBqWdmXfwwejWIfpVfeuunmf98xXbmyU=;
        b=gWXO/XK595YoZXsr8bhzhM47kJo060ua3lX/frEPFWv7ADuTiUeRp24QXOHNct8H+J
         OdKLwDprmlrvJjesW80hT1lru8X9WO2Hq7n3miOU83y4wznelD5whP8m8KOyV+tJHS/f
         YcAM2ve6eE+rpRl7wkptoh8BdJJbJTyHWo0F82n2t/hK1hn6ueQr2YjRe2cI6NBX4KZK
         bxrEb+O9YeXYIXD95QX6g61EP7k2umyoGvnuywuwHtBgCl54TsitbEIGmUL2KDo2NFhk
         /0w3EsXre5cNGLJlVu5NblXJbDU7POFAWtATF1mhe8/mNVLXA31f6Z/Xv98zV0uOxtuu
         WnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pwtV0vYkvqvfBqWdmXfwwejWIfpVfeuunmf98xXbmyU=;
        b=pMOB9jmW8Q9ktQY9GpwTOAp90BjKacUlJeJq40oXcWR9lqZwHw7NPEEe6B77zOuhvO
         gwNdeIl0pjzwQraA9iS1MTA3b9CwjWBV7RvezQ6x3UfsIWfyyPqEQD5t61quTwyu1ADA
         H4tC5qO04K7p/uIZ0i8iDwMdL4PmeYe9lpceA7rZ60MjA3PWrHc95iZ4jfEZAR6F+3G9
         w7JlXEWA4c9kGWyGvgVtN8Um/tiRIIPaq3bLWK58v8e/ooYgIZAOCMeayfCRHk0fRoQe
         fnNEl8fzt5FdN43NqvXF/JxzYyCnbtXvglZEDNOCYhtOuOD+nW0go24rl7+y8rkHtBbe
         d1Pw==
X-Gm-Message-State: AOAM533TkKGUq3HmZq2eoXs+iCn5laKrylotjWmE994CRSgAGcwV0qwK
        g1n6Si072vU/yNuQBh6+vTVOZg==
X-Google-Smtp-Source: ABdhPJzt9uGRB+v5ckn9uT7jUQ+esGDunDDnGdKSW7Gh2BXXH7tqbIa0yj4NJgrOEZFNMd8A20lmwg==
X-Received: by 2002:a17:907:778a:b0:70c:d67:578e with SMTP id ky10-20020a170907778a00b0070c0d67578emr1174845ejc.696.1654171287097;
        Thu, 02 Jun 2022 05:01:27 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m25-20020a509999000000b0042bd25ca29asm2367308edb.59.2022.06.02.05.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 05:01:26 -0700 (PDT)
Message-ID: <b3681990-e358-8e1d-93fe-b72c099902e3@linaro.org>
Date:   Thu, 2 Jun 2022 14:01:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/5] arm64: dts: exynos: Add internal eMMC support to
 jackpotlte
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     phone-devel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220601233743.56317-1-virag.david003@gmail.com>
 <20220601233743.56317-6-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601233743.56317-6-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 01:37, David Virag wrote:
> Add the nodes relevant to provide clocks for Exynos7885 eMMC and to
> support eMMC. eMMC is the internal storage used in the Samsung Galaxy A8
> (2018) (jackpotlte), and all other known devices using the Exynos7885
> SoC.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
>  .../boot/dts/exynos/exynos7885-jackpotlte.dts | 20 ++++++++++++
>  arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 32 +++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> index 4cf9aa25f618..5db9a81ac7bb 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> @@ -60,6 +60,26 @@ power-key {
>  	};
>  };
>  
> +&mmc_0 {
> +	status = "okay";
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	cap-mmc-highspeed;
> +	non-removable;
> +	mmc-hs400-enhanced-strobe;
> +	card-detect-delay = <200>;
> +	clock-frequency = <800000000>;

Is this real property for MMC? Neither mmc nor DW MSHC bindings mention it.

Best regards,
Krzysztof
