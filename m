Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2F4C7E91
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiB1XoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiB1XoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:44:09 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6CC3FBE1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:28 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id g6so23801497ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qv0zsMcKFZS0uEN+5UZdpCCNfqy5Tylio2s1vY2ryso=;
        b=ap5urwZneNBvZkhWi+/alykrLvq+JYqyG5CVt8WwKGtLHNLfvdGlkCi9jb2IB8Dbev
         MBDfUFmIVhBVZZbas/oLB3vPRnZPejc3kafHFSDs/G7H4Yj4XWQedGscnKmawKj9QX55
         /X7Jk+kO+yQYrIH8mst8QcYrJcns7dbxoluyOJQm/6lXSz5ROZU4Dwir6Q9PMF09VRsF
         v1D9R1V2FGi1y5W50xxGS/sHAgitGOSEZSB9bfZXn373UY+vy0mS5V4ixrPsaMulrpKB
         bOTyoKOAoaw/HBLLkgDMiWzc9WtHQfgGlK8LMXxnRpkt3c0D9CcIoifuZS1dZHhWFt52
         jv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qv0zsMcKFZS0uEN+5UZdpCCNfqy5Tylio2s1vY2ryso=;
        b=Jwkw400AmK+eEd0a6SI2Nn+wyh6mrf60/6D7eYJUsDorndeJnFLde2T2cQ87ChDJxP
         8sWd+r0Y5mlSVv2HcyQscF9BmaXbaYOuQQkZB4muevIG5IhUHUXU9UhZJxUPuw+3pQS5
         x4spkWO9b96PgMhSv3dzpEKq7fHF8pCYtzPiM7g0b0KQxAXzhOZW2xKRcJWjtsS6FRpR
         ABljGLfCRr+MuJGE8Yl5NUwJZ17A7QgavfSWH/gI3Dbv9l6N929BvaDbNkvutVrTPlEQ
         QmtKPpq9xOzZnoNJwCBvzyraXvC5gN0TjtrPp8YzMuszAezPdY2XgN22ncQKjtqqwByg
         co3Q==
X-Gm-Message-State: AOAM5303+zPcsTKSjKjFMvM1UzX3FJgQVki/2IaqTr8FivzRv4lso4nt
        0Y8FNC4WVOxuCvls8yih8mUYczINBciwp8klkkKq3g==
X-Google-Smtp-Source: ABdhPJy1LX+l2Mo/igXclj6eX4Kw6KzE1vcvAQRdRbdEaIC9clnEKE1E4s62KfDnNCE8OdnKYLa2bNj2oAdbjzW0rhA=
X-Received: by 2002:a25:9108:0:b0:61e:329:700 with SMTP id v8-20020a259108000000b0061e03290700mr21280699ybl.369.1646091807701;
 Mon, 28 Feb 2022 15:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20220215163926.894-1-paweldembicki@gmail.com>
In-Reply-To: <20220215163926.894-1-paweldembicki@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Mar 2022 00:43:16 +0100
Message-ID: <CACRpkda=ky29PiTjWimnNihLDHSTfYWk68qg5GcLqZTD76ba=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: kirkwood: Add Ctera C-200 V1 board
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 5:40 PM Pawel Dembicki <paweldembicki@gmail.com> wrote:

> +&i2c0 {
> +       status = "okay";
> +
> +       rtc@30 {
> +               compatible = "s35390a";
> +               reg = <0x30>;
> +       };
> +
> +       lm63@4c {
> +               compatible = "national,lm63";
> +               reg = <0x4c>;
> +       };

Think about adding chassis thermal zone for this sensor,

I suppose you don't have any active control of cooling (fan)?
This often sits on GPIO...

In that case just add a critical temperature so it can't burn
down the house.

See:
arch/arm/boot/dts/gemini-dlink-dns-313.dts
node thermal-zones {} for an example of how to do this
quick and easy. You need CONFIG_THERMAL and
CONFIG_THERMAL_HWMON for this to work.

Yours,
Linus Walleij
