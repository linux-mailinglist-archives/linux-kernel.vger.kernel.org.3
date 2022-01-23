Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2B5497337
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 17:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiAWQux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 11:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiAWQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 11:50:52 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9743CC06173B;
        Sun, 23 Jan 2022 08:50:52 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id m6so43666171ybc.9;
        Sun, 23 Jan 2022 08:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yvJHbE2HNxARartPgZEnI7KYUuo7OOg2+KzBkUFctc=;
        b=TRdQfaW2Z7xnVudanl7EA+d7B2tn85qLJ5/aXAqkqaOiQq4Hpi1o8AGHlamyUp0yxg
         JSKT6wwEIeXFzAeRM2Rk0EY4UTEAhHT40Xp2mwND6wvwILkTXP4ImMmnAJZVk+gGZ5Ey
         4sOceV/4pPbztkoYGz6WaCEikMbUcNJj5UC5yP3vEkT3kSy2rFqM3IdZWk6krdLse5rB
         14RPQvRPVdZmEdRnEbxu2iZlEYsEt+knqWwN/3bvE5Pu28kOeQy1BetLpsKwfh+GyDLK
         ZGg+r2d1vMGNwASJLzj1BH1wYtXT+mr5xjb0mF+OzxhoU9LoVwNP9u2VP8kEn+aTz4AF
         jPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yvJHbE2HNxARartPgZEnI7KYUuo7OOg2+KzBkUFctc=;
        b=uXcbC4zAR75D3zq3ivtXrKcNs8NQjzsIJZZpBGJmMXOpOa1CVSbkX9wcXg3OfXIFdA
         yqPjTY0GjMQuWVB0PTv9Ne6tpIOkHzQw/0Lw7lJ9GMpqjJtkP8PfnYX/vr2qvVMg27zo
         jd1mhUCb41ZkIVTC4v/UOgsGonofNWsYIK2jra5feCTCgwHlBlHWgFZFVj8m88A2SSa6
         gnx4zYVh0jwutxjF82/6mAC33aa8JMSKwK3/F7+7LegPsAYTGcYgLEc5/Lfgs34p5GkV
         w9N4pep+ChNGkonthDu18B6fHiTV8KI+Wi5C1jZOJylde40HzKGvumKp7bD7rwUMehvO
         t1wg==
X-Gm-Message-State: AOAM532RAhBRfUQUUI3VAk7em4i2Lu7G+DBeV4fgjpCm16ijTIH9tRde
        4C4sr2szwNymzuHw6U85tu1u2VYtmeORzfnAarkA6gIC
X-Google-Smtp-Source: ABdhPJwP4FgFRN4pOx7j4L3eY61ISzlzIn/vKBLTzNodrzsTgBeqRru9rQ0A1+4jIr5FMupyrd7C71w3rxvg4m/Ww9U=
X-Received: by 2002:a25:8d10:: with SMTP id n16mr18024350ybl.696.1642956651654;
 Sun, 23 Jan 2022 08:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20220107051335.3812535-1-pgwipeout@gmail.com> <20220107051335.3812535-5-pgwipeout@gmail.com>
 <5747938.922zgog0jt@phil>
In-Reply-To: <5747938.922zgog0jt@phil>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 23 Jan 2022 11:50:39 -0500
Message-ID: <CAMdYzYrByfe6s3oKvJDN3skGXh7x=YSxQ4BKwySKhPzyEUEGQA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: enable the pine64 touch screen
 on rockpro64
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:30 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Peter,
>
> Am Freitag, 7. Januar 2022, 06:13:35 CET schrieb Peter Geis:
> > Enable the touch screen, backlight, and dsi nodes for the Pine64 touch panel
> > attached to the rockpro64.
>
> can you please also include me in the other patches of the series?
> I.e. they introduce a new property for the display, so it's nice to know
> when they get applied.

Apologies, I use get-maintainers.pl automatically and it seems to need
some help with tagging you in some Rockchip elements.
I'll be sure to always manually include you and the rockchip mailing
list on all patches in future series of this sort.

>
> While I do agree with patch 3/4, I'm hesistant about this one.
> The display/touchscreen will probably not be connected on every rockpro64
> so what happens if it doesn't?

This was supposed to be tagged as Do-Not-Merge, but it seems I failed
to do so on the actual patch.
It's here for purely completeness and testing purposes.

>
> I.e are there alternative uses for the affected pins, that may get fried
> when this is always enabled?
>
> So part of me would think that an dt-overlay enabling this might be the
> nicer way to go?

Absolutely.

>
>
> Heiko

Thanks,
Peter

>
>
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> > index 158befb9a48c..f6c36fcd6db3 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> > @@ -26,7 +26,7 @@ backlight: backlight {
> >               pwms = <&pwm0 0 1000000 0>;
> >               brightness-levels = <0 4 8 16 32 64 128 255>;
> >               default-brightness-level = <5>;
> > -             status = "disabled";
> > +             status = "okay";
> >       };
> >
> >       clkin_gmac: external-gmac-clock {
> > @@ -594,7 +594,7 @@ touch: touchscreen@5d {
> >               interrupts = <RK_PD5 IRQ_TYPE_EDGE_FALLING>;
> >               irq-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
> >               reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
> > -             status = "disabled";
> > +             status = "okay";
> >       };
> >  };
> >
> > @@ -633,7 +633,7 @@ &io_domains {
> >
> >  /* enable for pine64 panel display support */
> >  &mipi_dsi {
> > -     status = "disabled";
> > +     status = "okay";
> >       clock-master;
> >
> >       ports {
> >
>
>
>
>
