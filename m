Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE20146D831
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbhLHQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhLHQdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:33:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C2C061746;
        Wed,  8 Dec 2021 08:29:51 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x6so10299474edr.5;
        Wed, 08 Dec 2021 08:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=77xApK0PHdTV1F76e7Le2sd7puLp348NtZrFf7gc73Q=;
        b=n8L9XakdpVCVKNYN7imWk8v5MPHkY2TxxMCX7i+OH0xDgi0XvapCBMKdYqblsNYjZo
         HFizMTMs5jDsbKYjHD4zSkiVyJJOEggUmOsrHRn5VHmd0TEXUqxK4K/B7c+iE3RNiEo1
         XFe4dedc0zzNo8J6G54Ah9dX4SGmbMvTfIevd042Cq0uO8GJ1onXb27fAftzuV6fUkRy
         spntV2QmoofI6KKUREGAGuivNtkLna0p8QXZalvHucp5xR54U4ccyoX6h9AvxJAZ7dQO
         /cDSR/CpDPrJ1HA0pWYQaDnMHPhu7u8dMIHG4G1miTx/EVzcv/ewQFsqhsXi3JGjLhvX
         mhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=77xApK0PHdTV1F76e7Le2sd7puLp348NtZrFf7gc73Q=;
        b=iiydE1b51rkvZC2Fx7zSd0fBuh6FDeSGMF2R2oJwm98QpwR9dYy19m7yEOCFx83SFS
         QxTlaqNRJMBT1ROl5op3NoL2rL2y61BzgBxh77Uj4H29+RvpkGR3DuD2wINAfgbb3GE5
         +ZkFcPh0aON0iTh/b4KJOelKf8qQ9rJSrD6DMEZ3iykmenL2HTXBJ6fe9Ll7ELXTSje9
         /qhoVaCjjHI2mXzk8O1CYUF87dKCkmUx3GYeyS8Z5uXLhl/TRpcLjPBPpxqisvarJTOw
         t9DJKpn3oU2UofXWiBmDcpcOs9UGZonfKygjhLWZxC2O3Q1k4Sfw2nUoXzy78UY1P9mc
         7gRg==
X-Gm-Message-State: AOAM53335UzifFVylOCE2gm4630e5lq0VfF0KP7G6XqTscNBBoCmnnMr
        rkI7MY98LrDfkbnyKvPVEjWoLP2wf+2v55Z1gko=
X-Google-Smtp-Source: ABdhPJwxkXRRG6q5aIPp1FmxJluxUOk7ghMnKYrLD4LBO+tEkKec/M0VngS7XPOoAsArDaXt4R6IHfRMPZ5PImh6u+s=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr8422743ejb.69.1638980989776;
 Wed, 08 Dec 2021 08:29:49 -0800 (PST)
MIME-Version: 1.0
References: <4d17866a-d9a4-a3d7-189a-781d18dbea00@axentia.se> <YbCmFac6/nU949/Z@ada-deb-carambola.ifak-system.com>
In-Reply-To: <YbCmFac6/nU949/Z@ada-deb-carambola.ifak-system.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Dec 2021 18:28:17 +0200
Message-ID: <CAHp75Vfop8MpzkFRzQKt78UZc6DiEZTm2SYqJDtwm1KcsjC=+w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: at91: allow use of of gpio-line-names property
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 4:51 PM Alexander Dahl <ada@thorsis.com> wrote:
> Am Tue, Dec 07, 2021 at 12:32:03AM +0100 schrieb Peter Rosin:
> > If no line name is given (by not having a gpio-line-names property,
> > or by having empty "" strings for some lines), fall back to the
> > existing pioC12-style line name scheme.
> >
> > It is useful to be able to explicitly name lines from the schematics
> > or its function, rather than having the MCU names forced upon every
> > user.
>
> +1 from me.
>
> I asked about this some months ago, but I saw no clear
> direction in the discussion. So for reference:
>
> https://lore.kernel.org/linux-gpio/946021874.11132.1615900079722@seven.thorsis.com/

Thanks for the reminder. AFAICS from that discussion we kinda agreed
on the names being excluded from the ABI path. Hence there is good and
bad news.

Bad one: NAK to this patch.
Good one: Please, fix this in the gpiolib respective functions to make
it once for all.

Disclaimer, I'm not a maintainer of this subsystem, I might be
perfectly wrong in my understanding of the state of affairs, let's
hear what Linus and Bart can tell us about the subject. Above are just
my wishes as a contributor to and consumer of this subsystem on how
things should be done.

-- 
With Best Regards,
Andy Shevchenko
