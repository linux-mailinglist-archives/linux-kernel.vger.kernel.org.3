Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6585A490AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbiAQOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiAQOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:39:03 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BB3C061574;
        Mon, 17 Jan 2022 06:39:03 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g81so46359468ybg.10;
        Mon, 17 Jan 2022 06:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kHhCRgvF9Wf+R6yEgWiaK5gOZflCu4gFexOOmAZwK3A=;
        b=YsHtL+blfxwmFULnGvT3ULZ4xkuIYMK/Pd/Zg8NTRgLF6XqOZdWNT0SzetQ/F01GQo
         6Dld83r6NDOqox7MsT8O765x4oqVXIZD6EuiS7gZ0tJU+IlRB/C3veG4LcHqIwTrOUrO
         6HZA5rNpF4+dyXvRhpV6GxtZ6uRY/afq/4vyRWf4Wos3kZ5SEwwXgruJD2VBqTyRsmDi
         kEkd/HDGq3rYUHneKgp9Ik3B3yA+1EniOwtbuJ6yEdgckNeRbaEvJhGHXLdoEOUYihAs
         9XXDzpdCuxTxtSsjzAOmpMo6T5Qiqo8MDQfHpp56eqBtzDgrYiFzC5t4nVd+p7p99C2d
         9nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kHhCRgvF9Wf+R6yEgWiaK5gOZflCu4gFexOOmAZwK3A=;
        b=uJy4XWwpqLWeCZ+AmnjzaLl1Tva5HtkyYMjT8SgapMiHuO4ORKMTXLPSSXjFds+jdC
         oSkXtg17rUc+0JwQWE4g4pFES0A4wj77lDDkFzth3ZqHiuyhOp4sytrr5a/Xqs2mgm6V
         8DlCmPsf629GKzokC6+s7VLjSLfQoQT+pOGKSMAsD/BsBVtfdQIBEDL7xQUwYjYHmAqI
         QIdgm7ss/BJWp4OcZIZmwRNrdutq0OdWHmW1NrPPoF6voaQK70wUreZws4qqi+tAv+Fa
         WhJo96CaKLmTxOdZAfcxPx+k+t+IgmmYZfBHc6uTLP8pAOhuNNTGUt5y8nWE7N6hYjHd
         3OAw==
X-Gm-Message-State: AOAM5305CNU+yizbswBZkeZGxftnTu+4eXIJPhNmImkagrXKsuZfbsRA
        u005aCA4NOv9HsjRI+USduohlpVaxYBvlLfajZc=
X-Google-Smtp-Source: ABdhPJyJ+PolclN9RQf6xwmgvGfwBqjnkvt5u/uY1RWTKSTVwNniNgVw5KppymYp82qhh17PSy5Z9SnKj28hDizciBY=
X-Received: by 2002:a25:6d06:: with SMTP id i6mr26656526ybc.216.1642430342223;
 Mon, 17 Jan 2022 06:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20210728135534.703028-1-pgwipeout@gmail.com> <20210728135534.703028-6-pgwipeout@gmail.com>
 <C3AE0A81-A829-4241-A65E-EB28825E3C33@gmail.com> <CAMdYzYo2gkNvNYjU9_kc4cTwNBFU+kg3bRwaS3yCCAsMdo-Tow@mail.gmail.com>
 <E3AA167E-1E40-45CD-8CBB-3EB280856604@gmail.com>
In-Reply-To: <E3AA167E-1E40-45CD-8CBB-3EB280856604@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 17 Jan 2022 09:38:50 -0500
Message-ID: <CAMdYzYqsPgAbLBt+xwDL2s7ViLDJw5mnzDnupimRVESt0xFksQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] arm64: dts: rockchip: add rk3568 tsadc nodes
To:     Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 9:13 AM Piotr Oniszczuk
<piotr.oniszczuk@gmail.com> wrote:
>
>
>
> > Wiadomo=C5=9B=C4=87 napisana przez Peter Geis <pgwipeout@gmail.com> w d=
niu 17.01.2022, o godz. 14:49:
> >
> >>
> >> Peter,
> >>
> >> I'm trying to use this series to get thermal on rk3566 based tvbox (x9=
6-x6).
> >> Driver loads but i'm getting following error:
> >>
> >> [  132.873979] rockchip-thermal fe710000.tsadc: failed to register sen=
sor 0: -517
> >> [  132.874650] rockchip-thermal fe710000.tsadc: failed to register sen=
sor[0] : error =3D -517
> >>
> >> Maybe you have some hints here?
> >
> > Error -517 means -EPROBE_DEFER, a device it relies on hasn't probed.
> > TSADC doesn't directly rely on anything that shouldn't already be
> > enabled. (Pinctrl, clocks, and grf all break a lot more than tsadc if
> > disabled)
> > Does your kernel config have all of the rockchip elements enabled?
> >
>
> Peter,
> For sure I can't say 'yes' with 100% confidence.
> I'm trying do my best for rk3566 (currently have working: SD/Eth/HDMI/Sou=
nd/USB2port0/BT).
>
> Maybe you may point me pls for good reference of rk356x defconfig?
>
> btw: a bit of  context:
> In my application (https://github.com/warpme/minimyth2) i have target to =
have single OS binary for all supported Allwinner/Amlogic/Rockchip/Broadcom=
 devices.
> By this kernel config i'm using is painfully assembled to have minimal wo=
rking kernel for all targets.
> It's a painful road....but still want to go this route for: minimal image=
 size; shortest build time & one-for-all binary.
> my current config: https://github.com/warpme/minimyth2/blob/master/script=
/kernel/linux-5.16/files/linux-5.16-arm64-armv8.config

I recommend you use `make savedefconfig`.
It produces a simplified defconfig based on your .config.

Your issue is in your dts.
You have retained the quartz64-a &cpu_thermal active thermal node
without tying in an active thermal control device (a fan).
By default the rk356x dtsi passive thermal trips are hooked up and
will throttle the device in case of overtemp.
If your device has no active thermal control, you don't need to add
the &cpu_thermal node at all to your dts.

>
> btw2: for rk3566 i'm using majority of your patches!
> Great work of you!
>
>
>
>
>
>
>
