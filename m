Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1256D5A60D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiH3Kef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiH3Ked (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:34:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F548A99D6;
        Tue, 30 Aug 2022 03:34:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b26so3958411ljk.12;
        Tue, 30 Aug 2022 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=UCod0/HFGUKrf2p2FZSzQ0kgTIqag5Zo13Nui3Avcqk=;
        b=noyZtazLMxDeLMfMDx3LzywqrsR+b2bysTT2q3oiIa9pxwlngpzxZTDp13jqqd6dCX
         +iruMKgnQOuteRSP16gDFsiPCoF8X2cOaqV47Oqp+djtXyA+CjsWoKiOvMqp2+zFk3h9
         Edg/HiO1bLa3dtSePz0K6bXpcgaMOAAVybubczCy4zESHU8A6j4Hqk2cDHQlQPn1rgs4
         XjWKTmSKEr8NywzyeQvckAGZEvmrOO/3MjkfonVyUZXCRpxVZqkGHyc5QCbVn8ZWo7EK
         VLBl0XbKPSzOeoGKkV+mILUlAr43vEefx0LUkmTabu1Zku3CQcOxCE6s+FqLHeEIgwQW
         3wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=UCod0/HFGUKrf2p2FZSzQ0kgTIqag5Zo13Nui3Avcqk=;
        b=akbcr7J/hs3f9yKI9ZwKw4kcOB6TT3Ga3ButDNw5RsN/frY80u6Vel14nQVNIR24O9
         jXmvikorCv+gVKpPX1qyqhK4qI0BMgLlLoLA5UzESB6PvDypgsA2zD4qbq+HpsqAhIHy
         0JrEqj6lIcrIvWEbQVJ1JxnbhOYqHptny3N40TBYgBioeLwwUteyTgwODXlFxVPRlVKn
         qBQAn+kIgTRxrEkYNDXq5cpyZXqWH0o9z5miAZazR8PqXEJ/wm7bsjqjuCrvtHBssRYZ
         aJujxTm+bBn/85HFwrFU+2wJvpVO+MI1OOQOYm/y1NHtR7zJ1waE+8G4EGuFu4nBYLIL
         eZ1Q==
X-Gm-Message-State: ACgBeo0M/GH2Cz8AjURxCoMCFvtmRcvG0MGhjWGO4lKKVUvjkYelCbwW
        NOKAiIJsJM7s8eJh3fZjpMA=
X-Google-Smtp-Source: AA6agR42HvKOpgztKSbICMioabWyivzr6d0K3E8tGVuitdTRPJulyJHicb40e5bgT5czhA+yR45EiQ==
X-Received: by 2002:a05:651c:1993:b0:263:a41d:3d7b with SMTP id bx19-20020a05651c199300b00263a41d3d7bmr3523730ljb.63.1661855670682;
        Tue, 30 Aug 2022 03:34:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id e20-20020a196914000000b0048b17852938sm1099036lfc.162.2022.08.30.03.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 03:34:30 -0700 (PDT)
Message-ID: <8f501644-9793-214f-8a19-45ee8af3c907@gmail.com>
Date:   Tue, 30 Aug 2022 13:34:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, jic23@kernel.org,
        lars@metafoo.de, deller@gmx.de, broonie@kernel.org,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, szunichen@gmail.com,
        andy.shevchenko@gmail.com
References: <20220830034042.9354-2-peterwu.pub@gmail.com>
 <20220830034042.9354-8-peterwu.pub@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v9 07/10] power: supply: mt6370: Add MediaTek MT6370
 charger driver
In-Reply-To: <20220830034042.9354-8-peterwu.pub@gmail.com>
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

On 8/30/22 06:40, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> driver, display bias voltage supply, one general purpose LDO, and the
> USB Type-C & PD controller complies with the latest USB Type-C and PD
> standards.
> 
> Add support for the MediaTek MT6370 Charger driver. The charger module
> of MT6370 supports High-Accuracy Voltage/Current Regulation,
> Average Input Current Regulation, Battery Temperature Sensing,
> Over-Temperature Protection, DPDM Detection for BC1.2.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> 
> +
> +static const struct linear_range mt6370_chg_ranges[MT6370_RANGE_F_MAX] = {
> +	LINEAR_RANGE_IDX(MT6370_RANGE_F_IAICR, 100000, 0x0, 0x3F, 50000),
> +	LINEAR_RANGE_IDX(MT6370_RANGE_F_VOREG, 3900000, 0x0, 0x51, 10000),
> +	LINEAR_RANGE_IDX(MT6370_RANGE_F_VMIVR, 3900000, 0x0, 0x5F, 100000),
> +	LINEAR_RANGE_IDX(MT6370_RANGE_F_ICHG, 900000, 0x08, 0x31, 100000),
> +	LINEAR_RANGE_IDX(MT6370_RANGE_F_IPREC, 100000, 0x0, 0x0F, 50000),
> +	LINEAR_RANGE_IDX(MT6370_RANGE_F_IEOC, 100000, 0x0, 0x0F, 50000),
> +};

This looks good to me now :) Thanks for the linear-range improvement!

> +	INIT_DELAYED_WORK(&priv->mivr_dwork, mt6370_chg_mivr_dwork_func);
> +	ret = devm_add_action_or_reset(dev, mt6370_chg_cancel_mivr_dwork,
> +				       &priv->mivr_dwork);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init mivr dwork\n");

I just noticed this. Maybe this could be done using 
devm_delayed_work_autocancel() ?

Yours
-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
