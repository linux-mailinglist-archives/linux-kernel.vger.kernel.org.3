Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F01646692F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376433AbhLBRfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376411AbhLBRem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:34:42 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B3C06175F;
        Thu,  2 Dec 2021 09:31:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r25so979940edq.7;
        Thu, 02 Dec 2021 09:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QJn3S6sN6c/cil6HRGGB5x3rsfR1f8MZlKYmc0BRmI=;
        b=DT1c+DWTwNNvKQKMY6LJfGn6xQXJr09V44GrMl6l0z6nVrQ4tP8pZmotaUrWwyjFvD
         48LjoFvZoaU2jxKMVZZjJxSvLHO6D5qvxL6WMA8Xz6UQ4XB04qyHDnw2dm7v8Fwvhvig
         0px7m9fL6yukarZMx3wubaT7QgvSxWsLbR5Kiw4BpBcutpqfnfkTQ0OfUnVOJxOUCnQ7
         P6qCqs6NTGrlDEtm37s8GM77JJjZIXXjXrtndpbQYoCfSqsbSHZ8kl1SkFNZ8bSiWSk1
         N91bU1+ygY8rEm7jR6UCdCKeugEPN2WsDvdq/nNquMmwP5Et0WQ6/sb/6a8bLfi8trVY
         VUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QJn3S6sN6c/cil6HRGGB5x3rsfR1f8MZlKYmc0BRmI=;
        b=h3eLvfk44KYO0bk43GKNU6HhUfObs1BM6RID7pYqvwFMRNQZEudzsG+FNCjbcDSl5E
         j1Rg4whTGXa5MXClQjg4S8dBOX6eAsd6br1P/FBUjwauMLk92V1HeBErSF+eGBrQ5HJt
         6Qr0j5KNmye0im9VmeYz/o91unWKzpAlOl/9koI/wSM6+oZDcZw6ga8BE0hnoJrakRyM
         VhCmnpgHv0q16bxkDq5V7blsBIicXFNssDpaPMscpr2cEps3w7oMJklensKzl4R/DPvj
         9K2O0S3jE1b6H4iZ1i+wzQpH5rrWWD3QoVIQbaCF9qWqjtVjCiYVCwvx6KSJWqbSAvJc
         NtbQ==
X-Gm-Message-State: AOAM531BKoPHUZMX8tGeKKykFOyuggR5aFwBH/EHom9LKZKcNUBoT3L9
        hh8lNEKnBBV/rrLDZ4uz/Mx8TPWkM5S9eW+LygQ=
X-Google-Smtp-Source: ABdhPJzAUdOSE8L9NFI0Sln5qChLssjomZBhhOMS8os/94PUedL4UUS0SUuMvqT2izDngMnTUGG+HilDJG2Y1+NLVHo=
X-Received: by 2002:a17:907:961e:: with SMTP id gb30mr16644694ejc.436.1638466274398;
 Thu, 02 Dec 2021 09:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20211109150158.164778-1-christian.gmeiner@gmail.com> <22db4807-7772-abe6-50c6-5812d9692ccc@ti.com>
In-Reply-To: <22db4807-7772-abe6-50c6-5812d9692ccc@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Thu, 2 Dec 2021 18:31:02 +0100
Message-ID: <CAH9NwWfQf7BxrrCSNy1DjOJyjOMXGTTjnNPEAoYmeQdi3JV5Sw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: add timesync router node
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>
> On 11/9/21 8:31 PM, Christian Gmeiner wrote:
> > The Time Sync Event Router (TIMESYNC_INTRTR0) implements a set of
> > multiplexers to provide selection of active CPTS time sync events for
> > routing to CPTS capable modules.
> >
> > This patch adds DT node TIMESYNC_INTRTR0 using "pinctrl-single" bindings.
> >
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> > index 42d1d219a3fd..c9321a80353a 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> > @@ -564,6 +564,14 @@ cpts@39000000 {
> >               ti,cpts-ext-ts-inputs = <8>;
> >       };
> >
> > +     timesync_router: timesync-router@a40000 {
>
> Node with "pinctrl-single" would need to be named pinctrl@reg.
> Else this would probably fail dtbs_check once pinctrl-single bindings is
> converted to YAML format.
>

Okay.. will send a v2.

> > +             compatible = "pinctrl-single";
> > +             reg = <0x0 0xa40000 0x0 0x800>;
> > +             #pinctrl-cells = <1>;
> > +             pinctrl-single,register-width = <32>;
> > +             pinctrl-single,function-mask = <0x000107ff>;
> > +     };
> > +
> >       usbss0: cdns-usb@f900000{
> >               compatible = "ti,am64-usb";
> >               reg = <0x00 0xf900000 0x00 0x100>;
> >
>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
