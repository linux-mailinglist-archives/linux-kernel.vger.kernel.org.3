Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8C657D023
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiGUPq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiGUPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:46:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBA58E4CC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:42:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t1so3393846lft.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DbAlny0t1Z1mEp76q3Ok9AdQU6F9gRBoHTbQLXF/2lk=;
        b=hvMY/wKgqNkLwMGAA1veSwXkHAGy+A6V3WOkfUKYAdhYB8ptxzUPD7n35rsO9Jcvr7
         6UDVHo0V37fnqX2S0c15nIq3n4z6ArkAWtF+lGEg9BC5qQf+mEDT2UuywuO/+AFrwg6P
         jFuYVRrXQ21UhwdbV388q5sUMCQU465XKUyiSp0BPn/vBPSJN9lK2KzWUZE7tRuBCkcF
         ewxg0NMWAaa3d+T2QRhzgxExRIc5ACCOcQ3/ppkPQ5wo0swP5SjDLy8L+XwpArxrJ0Q/
         eeAmdqXFlUazj++UKjdRTrln8X4SOrsW3BodSCOU0+mbJsZrrBRXQKEnIdrhHN8un0RW
         grAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DbAlny0t1Z1mEp76q3Ok9AdQU6F9gRBoHTbQLXF/2lk=;
        b=rX0k42RJIsyALEz3Z7+I2ve2RFFeI7Su580dET5dkoBCJbeJEvXMFCdRgeGryKMDsD
         m89GVkHsrnwxGh5c7VQOnd0gjBeAV9YN+ZblO2N3YqGU2rk52ird3ru7foB9J4Ffiob7
         F6D+HXtyUfuDQLEX0gct5w1xpX/WACexsU2ILfDHWvv6j4PMunG0HPTU/3YtPa9SVFTN
         +STFfGN42YG5SOr3RXbfQ4uZHxnKU0WzaQgRw4+/+VI0ZqHhlAmKW2bLlUXUMYbWUOa7
         FfaoeNVVeZW+kzie3RqgovyL/Qxp7quoYHPfg5jIlduJtbl4NDp5hjGoetmPXC4zOoTe
         p+AQ==
X-Gm-Message-State: AJIora/ZlzBGp7xjanaRh+ZIjn03PMFKVWTPzBjghD7nEeV/vvgcoR1G
        d6mFPzxDRbId60/7246MRvobcQ==
X-Google-Smtp-Source: AGRyM1uH+KevGsKWyG8Df61xvPgqfo29eVC+LR/aED9QzOXzzbztIiUFTSzFYEZjDIchb6h/N4lCSg==
X-Received: by 2002:a05:6512:3409:b0:489:c549:4693 with SMTP id i9-20020a056512340900b00489c5494693mr21503245lfr.26.1658418131160;
        Thu, 21 Jul 2022 08:42:11 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id s4-20020a056512314400b00488333b6515sm499662lfi.305.2022.07.21.08.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 08:42:10 -0700 (PDT)
Message-ID: <e83c98f9-f32a-6bfd-71b6-9aba22aa7abb@linaro.org>
Date:   Thu, 21 Jul 2022 17:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/6] ARM: defconfig: address renamed CONFIG_DEBUG_INFO=y
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
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
 <20220721141325.2413920-5-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721141325.2413920-5-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 16:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_DEBUG_INFO is now implicitly selected if one picks one of the
> explicit options that could be DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT,
> DEBUG_INFO_DWARF4, DEBUG_INFO_DWARF5.
> 
> This was actually not what I had in mind when I suggested making
> it a 'choice' statement, but it's too late to change again now,
> and the Kconfig logic is more sensible in the new form.
> 
> Change any defconfig file that had CONFIG_DEBUG_INFO enabled
> but did not pick DWARF4 or DWARF5 explicitly to now pick the toolchain
> default.

I think this should be split - into remove DEBUG_INFO (noop) and into
selecting CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT (a fix).

Best regards,
Krzysztof
