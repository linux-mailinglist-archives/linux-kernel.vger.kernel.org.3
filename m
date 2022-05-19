Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D088E52D3BA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbiESNP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiESNP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:15:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EC6646C;
        Thu, 19 May 2022 06:15:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n6so2888160wms.0;
        Thu, 19 May 2022 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pp2u8adaeiVjAOQPo7uviaRpGC989a2Z1dhW4/bgQQE=;
        b=ExHb+cFqw/V7KxYvQxunB9ssbGzkJEkN9HDCfEsGMGljtEJ4yZyNaZ2oqfJv9FjbaD
         lmTEhrgAVMmUv7tvcr8yF2RONlTPix//ON0GPv4iK/+ugRfJN3F4yTb3JjHEM6xjhvQt
         5Mw+SxC5kqJPvIqGtoQiAcxyQpD2PCX0VBwdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pp2u8adaeiVjAOQPo7uviaRpGC989a2Z1dhW4/bgQQE=;
        b=T8PrK0CRwMtOXj5ZfKmV00VjZffh/1nPZM/WQfXX/i/z1jKk7CsnwcETubZW8raBCH
         Cumzdyh9DQMuwoJ67iI7I/DIOInKc5gUkQjVlqIIcFOER/4b7l+xO7PIXuSkXjs7Wchi
         kFc6txuP36pAoIXuUH0UDNlBbXOLtXm6msPQFtPC5mq+j9yPG8/rTkIkzuDypufnClbb
         XrShfvjPcOrQNBprQaOXXnfXWn1R8XyX0JNmOIOpCj0/Egbil/grKzeJ6QNK9xeWvtbe
         a6+UEFrMS9vHsk8XL4to53dPFdkqdPhMaFD2Y6hHjQdhTAJUlJOng/FCs361Wd/hu8LL
         V4tA==
X-Gm-Message-State: AOAM53018QBV/MXrEO8go25s0b6/vleVJHeWE3xAZhKr2LMB/t4UyFoS
        aPd5G4IGdzjxTRx5RZSis7S/DtUQopR/xy3Mv4Y=
X-Google-Smtp-Source: ABdhPJyARNN9JGSBx0lw6/N1VuA9RmZVUqBJDIG99T/jhQsAgNiWljmPf8WtCPtRbG+p4MrHeMq+oKFUA4a7VGMnMkY=
X-Received: by 2002:a7b:cd82:0:b0:389:77ef:66d7 with SMTP id
 y2-20020a7bcd82000000b0038977ef66d7mr3658957wmj.171.1652966152666; Thu, 19
 May 2022 06:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <SG2PR06MB23155E8A6193118544A7DBF3E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB23155E8A6193118544A7DBF3E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 19 May 2022 13:15:41 +0000
Message-ID: <CACPK8Xev-AYtrWzZyMGj8eBkTP2YXjnX=M+4UUGgfRZYeGMPtA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ARM: dts: aspeed: ast2600-evb: Enable virtual hub
To:     Howard Chiu <howard_chiu@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Troy Lee <troy_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 at 03:24, Howard Chiu <howard_chiu@aspeedtech.com> wrote:
>
> Enable Aspeed VHub for HID emulation
>
> Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index 158b88f38d2c..b98cdad86e90 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -314,6 +314,11 @@ &sdhci1 {
>         clk-phase-sd-hs = <7>, <200>;
>  };
>
> +&vhub {
> +       status = "okay";
> +       pinctrl-names = "default";
> +};

When booting with this patch applied we see:

[    1.596377] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: pin A4
already requested by 1e6a1000.usb; cannot claim for 1e6a0000.usb-vhub
[    1.596678] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: pin-252
(1e6a0000.usb-vhub) status -22
[    1.596947] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: could not
request pin 252 (A4) from group USBA  on device aspeed-g6-pinctrl
[    1.597238] aspeed_vhub 1e6a0000.usb-vhub: Error applying setting,
reverse things back


> +
>  &video {
>         status = "okay";
>         memory-region = <&video_engine_memory>;
> --
> 2.25.1
>
