Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D2557CF58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiGUPgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiGUPgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:36:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A8638BF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:36:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n18so3412432lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hfKsdhQQt9tQ595I9ds8b/DPqZVDcCzjVcrK9iWT3ts=;
        b=GCw16KpafXB+y2e+gFPayJKLMhyZMkVvIg00xSfR0J6zmap4XUiw74QYrBPZojxqnG
         nlMigEvmPTJqX2BUwSdZ4mJxx8kFZTXQJaOIndmhXWmnsZmilUJXncDHi2uKE8pGuWVL
         znA3Smzdfbdkc8qVWjZ7RHlZu4leucipgnhrY3cduU0fYTHFS3staPx9+XFkY/ZjtM2h
         117KpUbzALp8IYmM0wdGGHbqPzb9abAasZ2Y4vFeXAUqeWHw9qTJ0dR/mA5YE4OC5PTw
         ZVK2616IlVs5qLNNTIINaLS39Wgp/5PWsi2sSjQEOqP4IsbdopLcNcEJfX1/nxCnsqxR
         Lwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hfKsdhQQt9tQ595I9ds8b/DPqZVDcCzjVcrK9iWT3ts=;
        b=ymUdWV8ZEUo01CB3dlRVLxtprflGfc/eSaipjRvvgMErJsBPsECEQnLkQnH+LBuWZJ
         NBcAV0QiFCvKCAlQbl25aupbGm5DAquiuZv78Ny4/oB/8gmdPiarNyO7WivaucC8smmq
         /SN0u5FHu33Mwp4C/Rg/b8HkfRwdicjtpcbhutbrqjshDnbH8kcvURj3DnGFxDNDENkK
         GFiPJ4iCsVgX6YizK6do0FRlm5fXfHqaBcv8vLa8pg7lBC3SJTPCLDlK/S7SjEyHN0Cf
         pMQP1oMoMH7aEaBlWrSxDkDL3iv9xWU2/7M9QaUYJ8q8T7Q0IVORHWI4LI2Dj6CurC7R
         Rgtw==
X-Gm-Message-State: AJIora/GVbPkB3ifXMGiV5oejF9Nf3RXO6tcVwI4CBDL9qGhUErNy9dD
        W5BYMNAOlV9Wagzaak4vEiaUjQ==
X-Google-Smtp-Source: AGRyM1uYyhdhJ+K6lLI/9qjAZeU/e9ueK5AuTfFuX6OK/DbxDxlvM3z4hS4HgQhwQusCJCfVoUBo3A==
X-Received: by 2002:a05:6512:1506:b0:47f:79c6:eb36 with SMTP id bq6-20020a056512150600b0047f79c6eb36mr24308198lfb.168.1658417780731;
        Thu, 21 Jul 2022 08:36:20 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id w17-20020a05651234d100b00478f1e04655sm511718lfr.14.2022.07.21.08.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 08:36:20 -0700 (PDT)
Message-ID: <9e872a00-966a-aaf8-7bb9-6627fcb0cf83@linaro.org>
Date:   Thu, 21 Jul 2022 17:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/6] ARM: refresh defconfig files
Content-Language: en-US
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-oxnas@groups.io, linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-sh@vger.kernel.org
References: <20220721141325.2413920-1-arnd@kernel.org>
 <20220721141325.2413920-2-arnd@kernel.org>
 <9321ce6c-7565-a7eb-2bfe-dac144ab7733@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9321ce6c-7565-a7eb-2bfe-dac144ab7733@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 17:33, Scott Branden wrote:
> Hi Arnd,
> 
> On 2022-07-21 07:13, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> A lot of Kconfig options have changed over the years, and we tend
>> to not do a blind 'make defconfig' to refresh the files, to ensure
>> we catch options that should not have gone away.
>>
>> I used some a bit of scripting to only rework the bits where an
>> option moved around in any of the defconfig files, without also
>> dropping any of the other lines, to make it clearer which options
>> we no longer have.
> Resync is fine.  But, it would be great if the defconfig files were kept 
> in sync. Almost every kernel version kconfig options change which affect 
> these files. Could we put in place a defconfig refresh per kernel 
> version to keep them all in sync going forward?
>

Not entirely, because some Kconfig changes are causing symbols to
disappear. Also defconfig is expected to include user-visible options,
even if savedefconfig would drop them.

This is why blind savedefconfig is not acceptable.

Best regards,
Krzysztof
