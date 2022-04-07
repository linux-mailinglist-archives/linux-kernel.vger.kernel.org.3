Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57094F7775
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbiDGH3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbiDGH3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:29:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0D04990E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:27:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qh7so8898420ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sVKCjcyFursuGnNRsqDGWq1s5jhG02VXWdHL2aOfkHM=;
        b=xuliny82Z7i6PiVcYIJRHu6t+++DO8XGMUK9vsBg7UyErLpHv8jIzSQuZ+5NDKIzkW
         1whTtc6iCgTqJMa66wm+DnQy0jm+Wnx1JVxRBhKifJChaHH4JzEc0EEDXFrPvAggicpp
         G2QMxefL0zv3Qxsb4asmTXClYA127fYxy3yjTje/TCHs9dQQLQnqTZjPl60AOyCChAHO
         7jd35XlgaKfKJ8Xj/RY7llxhYXD4fAOet1XttuqAKpHaJkzzI8EboNBUFPFlW1w2wB0G
         ETHLeIIyBocAtZkDCGbnkYXv7FbPmaSzjYkOojFFG4+TFhT4Cd1AfYPSOAi1WWnjGWUO
         nnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sVKCjcyFursuGnNRsqDGWq1s5jhG02VXWdHL2aOfkHM=;
        b=6mjQhcIeclNZL7gTiCUDUVufhI/JfZ1vkeqDDL6861Mt/9sErQOJDAQL2H8bhQnxCD
         eWvo15lopE6F3FOOh5Xv8P60NdH6+G90FU6DguwDVmSjUgpYVephwamp4qr9Qus8Nhet
         si/GFnOdeOOXlC05isP0ThOyqntuRkCUI6MnMCT94Swu1fbVpjLKAZPnVtJoyvsne9lQ
         wNUEshi/i9GEYIsRNAOVXpmJSzW9oPH3CrIjwq5j+L4msvlLMAfEOIIHNi9QzYhGO5K+
         A9x1vHFWqJGJ50QGzeA1tFGYPTevJ6XIOx+myWI9NiDXyHASkeFprseP2HNhSG1HTo2S
         KkPA==
X-Gm-Message-State: AOAM533tnVC5dw4SSQ10Rboo1+tVJuuVDiOlxBGRXCm27pAR1LJRMrpu
        VTU2sJzIgdVBpwPcCd0jwc9BMA==
X-Google-Smtp-Source: ABdhPJxxkE3ET/sQ03551rEJpszWGXXoBdMpR35R5o6Dcc4iCbDQcrdlhEPf8pQpvtBqR84fxUR6AA==
X-Received: by 2002:a17:907:6d8f:b0:6e0:1512:913b with SMTP id sb15-20020a1709076d8f00b006e01512913bmr12318510ejc.491.1649316449674;
        Thu, 07 Apr 2022 00:27:29 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id q17-20020a170906b29100b006e7f3615efcsm4071855ejz.56.2022.04.07.00.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 00:27:29 -0700 (PDT)
Message-ID: <f8f7ec98-8e67-268b-5f08-06c9bee4b98e@linaro.org>
Date:   Thu, 7 Apr 2022 09:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 07/12] ARM: s3c24xx: remove support for ISA drivers on
 BAST PC/104
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
References: <20220405091750.3076973-1-arnd@kernel.org>
 <20220405091750.3076973-8-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220405091750.3076973-8-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 11:17, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> BAST is the one machine that theoretically supports unmodified ISA
> drivers for hardware on its PC/104 connector, using a custom version of
> the inb()/outb() and inw()/outw() macros.
> 
> This is incompatible with the generic version used in asm/io.h, and
> can't easily be used in a multiplatform kernel.
> 
> Removing the special case for 16-bit I/O port access on BAST gets us
> closer to multiplatform, at the expense of any PC/104 users with 16-bit
> cards having to either use an older kernel or modify their ISA drivers
> to manually ioremap() the area and use readw()/write() in place of
> inw()/outw(). Either way is probably ok, given that all of s3c24xx is
> already on the way out next year, and many traditional ISA drivers are
> already gone.
> 
> Machines other than BAST already have no support for ISA drivers, though a
> couple of them do map one of the external chip-selects into the ISA port
> range, using the same address for 8-bit and 16-bit I/O. It is unlikely
> that anything actually uses this mapping, but it's also easy to keep
> this working by mapping it to the normal platform-independent PCI I/O
> base that is otherwise unused on s3c24xx.
> 
> The mach/map-base.h file is no longer referenced in global headers and
> can be moved into the platform directory.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
