Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E42C48D97B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiAMOIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiAMOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:08:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8FCC06173F;
        Thu, 13 Jan 2022 06:08:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADB00B82244;
        Thu, 13 Jan 2022 14:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CE6C36AE9;
        Thu, 13 Jan 2022 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642082896;
        bh=AGXrB6RyRlJGlxXBTGJ56tVcl5sCtnIbd+sOvFKcyCs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JacG3I6VacRn9ssc1DqBNDh/6vt2laJIPLsgwmfG+tz5afXRM5WWshvos8zBoShl1
         nCBUJVi5AqhbRox0EAJN5UKOlRPptcJVL/hD0rOW1U3Qrjfem6qu/aFpy9SsB9exK6
         OfQ11o89t5mB9ZeZihirdKjIikuC9GwFt0cEOLd5y8mGVt27pN8XyX1tNxgBblmnXQ
         XpKzTNVgF34QoCzwoaw11xD3kv3RXe/1CNh7of3vy99PexXY1SsW6BkW7j5CbOjBZf
         8nGABQIeFJUGyIRHULR/AM4PaqHlqWtUX605+Pv5LJZlf/m/S8KzGdfa7TT8qg8N+a
         QODIDMMi48Uvg==
Received: by mail-ed1-f44.google.com with SMTP id 30so23543712edv.3;
        Thu, 13 Jan 2022 06:08:16 -0800 (PST)
X-Gm-Message-State: AOAM5328Ndem5EHAsstTKa8lVRXzkpMGKN0rwEgQ6Ev/AriVjaCFBsIq
        x/Rg/YAfwVFjebLK7kMDfq+YXoZBhjvG9khO8g==
X-Google-Smtp-Source: ABdhPJz+GHMwRV43sdBzHOeq12c86XZ9NFpJ+TiS7boAD3AIss0eauOXeqU8D6mHwfFBb9xoSuThXxy1UPREBNztaR4=
X-Received: by 2002:a50:cf4e:: with SMTP id d14mr4349160edk.2.1642082894743;
 Thu, 13 Jan 2022 06:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20220110214456.67087-1-sander@svanheule.net> <Yd46ayLnvT/3ch9e@robh.at.kernel.org>
 <71fffde0704d240f5ec8773fe0e738b6e069a6b8.camel@svanheule.net>
In-Reply-To: <71fffde0704d240f5ec8773fe0e738b6e069a6b8.camel@svanheule.net>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 13 Jan 2022 08:08:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ--59aMz1YaWTP=ZJDw9=uxRNDG-ZJ1wTCL5gZAKsRSA@mail.gmail.com>
Message-ID: <CAL_JsqJ--59aMz1YaWTP=ZJDw9=uxRNDG-ZJ1wTCL5gZAKsRSA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: reset: gpio-restart: Correct default priority
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 2:49 PM Sander Vanheule <sander@svanheule.net> wrote:
>
> Hi Rob,
>
> On Tue, 2022-01-11 at 20:18 -0600, Rob Herring wrote:
> > On Mon, 10 Jan 2022 22:44:56 +0100, Sander Vanheule wrote:
> > > Commit bcd56fe1aa97 ("power: reset: gpio-restart: increase priority
> > > slightly") changed the default restart priority 129, but did not update
> > > the documentation. Correct this, so the driver and documentation have
> > > the same default value.
> > >
> > > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > > ---
> > > This is a resubmission of RFC:
> > > https://lore.kernel.org/all/cfcd00257daba5aa30b8d20a62ba542be1a6914c.1640887456.git.sander@svanheule.net/
> > >
> > > The commit message for bcd56fe1aa97 mentions that it is a workaround for
> > > rk3288-veryon boards. However, commit e28ea9dbc52d3 ("ARM: dts:
> > > rockchip: add shared rk3288-veyron files") later adds a gpio-restart
> > > node with a priority value of <200> for those boards, effectively
> > > rendering bcd56fe1aa97 obsolete (for their use case).
> > >
> > > Perhaps bcd56fe1aa97 could just be reverted instead of updating the
> > > documentation.
> > >
> > > An argument against reverting (a 6 year old patch) is that other boards
> > > may have come to depend on the default value of 129. I don't know about
> > > out-of-tree user of gpio-restart, but there are a few in-tree users of
> > > gpio-restart /without/ an explicit priority:
> > >
> > > arch/arm/boot/dts/imx53-ppd.dts (commit 2952d67637716)
> > >   DTS submitted after changed default, but DTS copyright predates the
> > >   changed default.
> > >
> > > arch/microblaze/boot/dts/system.dts (commit 7cca9b8b7c5bc)
> > >   The original DTS commit predates the changed default, but didn't use
> > >   gpio-restart. The commit adding gpio-restart appears to indicate no
> > >   other restart handlers are present on this platform, although it could
> > >   be these were just being shadowed by the custom restart code.
> > >
> > > arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts (commit 0a91330b2af9f)
> > >   Recently added board; couldn't find any obvious alternative restart
> > >   handlers.
> > >
> > > Best,
> > > Sander
> > >
> > >  .../devicetree/bindings/power/reset/gpio-restart.yaml         | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Thanks for the review!
>
> I've noticed the devicetree patchwork has this patch marked as "Not  applicable", but
> linux-pm patchwork has it marked "Handled elsewhere". Since you merged the gpio-restart
> conversion patch, can you also take this one, Rob?

Yes, I'll pick it up.

Rob
