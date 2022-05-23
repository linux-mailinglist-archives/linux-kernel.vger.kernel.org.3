Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF22530B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiEWIy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiEWIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:54:52 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEF83DDF7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:54:50 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a23so16348217ljd.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CfF5/pWdcRI2Sg4Sp9q18Ut3NdSMP2mrbNrUOH4tHpQ=;
        b=H04E3Qh+zTkrhDtqT1Pf+lm+z90Q1IJDUjrpShL1b6RHtN5BCmOhFU45XgaLzruEAQ
         A5fMl9wwVZqcALIuVrSlMDFOms32cB0Kh8A9Dra7P1u/TWSRNmJvGaaa9r+W1KiP59QN
         6Kv4z77ZaR1HOWXOpL9Yy1bVRhACpLfGfO1/ICZdQ8NRjyTunjfH0E3IMxe+YquB8YFL
         +rblqL3SZACB4oYbDVhmJJ7xeZ5Gcmmw4LsDMfKpzy8RxbLDszX4lGi0PN7CJqeV0wPZ
         9bDoBwCrs+sFL1Nr/ZQ/kconVYs8bt0QHOyInH/VY0r+0UHAAKzY5Nv10bvgkCO/NOgC
         gaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CfF5/pWdcRI2Sg4Sp9q18Ut3NdSMP2mrbNrUOH4tHpQ=;
        b=52IeG6z/Unk5xP/858Se8e7O07AxF1FnQJz2kkQYkX2tBKcQwuPyR+kPNldXlVMoij
         56336pOIWvZTklkRu9c6rib9+EPyrsGQ8J2MxNbA/3B+ZHdLpTCX7TvhEfY0QiMjpnvw
         zOirlhhFtcwJ+6aSpmfGGFolfgfc6TSLD0xXxjYQUDOAczkC72Hi9c5fMsuW7c9jnuNR
         SBi6EamAxzxnUpw8k2TAJJunvIp6OBoW46Ohhf+01Yti2AFcdSXCT8wdpPkHxdbqTUSE
         IbOb8nGcp8PZlKH/kMuwP6zoXdAjtroHQysqPBfIFrcoMWkk6I5INOkmfKYCFLp4JTpi
         0iOw==
X-Gm-Message-State: AOAM533Kn8byq19Ce+WOnBzgoRw0xkzGaJ/cJHXo+BOBFaSVRI2ovIdA
        YhGfGL9TJI6xORHnFauJ+/twdQ==
X-Google-Smtp-Source: ABdhPJz8ech4AXIZ3Td603lBQrNaXVjP05GbdjiHzoi9KYn0N5iOo6J7vHouIJSze1sRkg0E6MIyRw==
X-Received: by 2002:a2e:9797:0:b0:253:ccb1:5868 with SMTP id y23-20020a2e9797000000b00253ccb15868mr12838410lji.162.1653296088444;
        Mon, 23 May 2022 01:54:48 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y11-20020a2e7d0b000000b00253d95eebe4sm1692364ljc.21.2022.05.23.01.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 01:54:48 -0700 (PDT)
Message-ID: <973d75b8-0eb6-ff5b-6cd2-9b7d7c5cbcaa@linaro.org>
Date:   Mon, 23 May 2022 10:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 10/19] reset: npcm: using syscon instead of device data
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
 <20220522155046.260146-11-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522155046.260146-11-tmaimon77@gmail.com>
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
> Using syscon device tree property instead of
> device data to handle the NPCM GCR registers.

https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/reset/reset-npcm.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
> index 2ea4d3136e15..0c963b21eddc 100644
> --- a/drivers/reset/reset-npcm.c
> +++ b/drivers/reset/reset-npcm.c
> @@ -138,8 +138,7 @@ static int npcm_reset_xlate(struct reset_controller_dev *rcdev,
>  }
>  
>  static const struct of_device_id npcm_rc_match[] = {
> -	{ .compatible = "nuvoton,npcm750-reset",
> -		.data = (void *)"nuvoton,npcm750-gcr" },
> +	{ .compatible = "nuvoton,npcm750-reset"},
>  	{ }
>  };
>  
> @@ -155,14 +154,10 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
>  	u32 ipsrst1_bits = 0;
>  	u32 ipsrst2_bits = NPCM_IPSRST2_USB_HOST;
>  	u32 ipsrst3_bits = 0;
> -	const char *gcr_dt;
>  
> -	gcr_dt = (const char *)
> -	of_match_device(dev->driver->of_match_table, dev)->data;
> -
> -	gcr_regmap = syscon_regmap_lookup_by_compatible(gcr_dt);
> +	gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");

I think this just broke all existing boards...

Best regards,
Krzysztof
