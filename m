Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADB54F050E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358465AbiDBQvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358459AbiDBQvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:51:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CF545796;
        Sat,  2 Apr 2022 09:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBC18B80ABB;
        Sat,  2 Apr 2022 16:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E783C340EC;
        Sat,  2 Apr 2022 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648918156;
        bh=YcbASg+GO+EkdDrt/yUxr7ywUjhesLogAnC+mnlYGEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gKROR9zwBALojn4E5hRgpjZiVJ2LkOrTof3zTzdkKeM+dMCXvdfUVxVywlfSBKTub
         83puUbTdqDcp1P251PGSzjxmW6syoAdNLuDeN+hRioLepDDj5fwjc72glUco9RLrH4
         fWDlobGbvY3Yr2yv9yK1iiTxbYaQcl6GYEncv7FG8sBblfN8DjdB+Tko1GJarJkjzl
         CqHukGU3+uetJTqBU35EufEhTJ/JQMLIQ232K9a2dqX0DRlpHNX2jj36iVIUYsK2D0
         nAQ1S/5yDqL3HFxoV+WVOCFYetv2xOeXNJlDs/vD4NBXaJTnZonch1EXHHEO+vsxl7
         3y6VKMwxlUUBA==
Received: by mail-pl1-f175.google.com with SMTP id p17so4908418plo.9;
        Sat, 02 Apr 2022 09:49:16 -0700 (PDT)
X-Gm-Message-State: AOAM532AaYOh8i8uq6HzCP4xJa5aDwobX7GZ3xW2sF8gPoc37PYqkRQU
        IbQek3ewghDsvLBbgMtsUgo81ilsrBrVzzQi0dw=
X-Google-Smtp-Source: ABdhPJwGqwbLcVcTdQ+vwsrSjziLqOHB1myjd4wlosyh0cpYONLfR6rrENWAFdTWWindJ8begLSg9eEzj+9HuQBuDVs=
X-Received: by 2002:a17:902:6ac7:b0:150:24d6:b2ee with SMTP id
 i7-20020a1709026ac700b0015024d6b2eemr15918616plt.168.1648918156115; Sat, 02
 Apr 2022 09:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200917185211.5483-1-krzk@kernel.org> <20201002161128.GB4542@kozik-lap>
 <2926877.yplJhP9KA3@diego>
In-Reply-To: <2926877.yplJhP9KA3@diego>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 2 Apr 2022 18:49:05 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeX8su0dzHWRWUZfOdZaB5CXU1GpUOXg+pS7CQdX3XWOg@mail.gmail.com>
Message-ID: <CAJKOXPeX8su0dzHWRWUZfOdZaB5CXU1GpUOXg+pS7CQdX3XWOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: rk3188: correct interrupt flags
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Alexis Ballier <aballier@gentoo.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Anand Moon <linux.amoon@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Oct 2020 at 14:08, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Freitag, 2. Oktober 2020, 18:11:28 CEST schrieb Krzysztof Kozlowski:
> > On Thu, Sep 17, 2020 at 08:52:10PM +0200, Krzysztof Kozlowski wrote:
> > > GPIO_ACTIVE_x flags are not correct in the context of interrupt flags=
.
> > > These are simple defines so they could be used in DTS but they will n=
ot
> > > have the same meaning:
> > > 1. GPIO_ACTIVE_HIGH =3D 0 =3D IRQ_TYPE_NONE
> > > 2. GPIO_ACTIVE_LOW  =3D 1 =3D IRQ_TYPE_EDGE_RISING
> > >
> > > Correct the interrupt flags without affecting the code:
> > >   ACTIVE_HIGH =3D> IRQ_TYPE_NONE
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >
> > > ---
> > >
> > > Not tested on HW.
> > >
> > > Changes since v1:
> > > 1. Correct title
> > > ---
> > >  arch/arm/boot/dts/rk3188-bqedison2qc.dts | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Hi,
> >
> > Any comments/review/testing from Heiko or other Rockchip folks? Shall I
> > cc here someone?
>
> I'm actually wondering about this ... I somehow remember writing a respon=
se,
> but don't see it in my history - so it might have gotten lost before I
> actually sent it.
>
> I think the biggest issue I have is that none of that is tested on any
> hardware and looking at other brcm wifi drivers in the kernel, the
> interrupt polarity seems to be all over the place, some set it high,
> some low and I even have seen edge triggers.
>
> As all changes are in regard to (copied) brcm wifi node, it would be
> really interesting to actually know what trigger is the right one.
>
> I've Cc'ed Jagan who I think has worked on an affected board,
> maybe he can check which trigger is correct.

Hi Heiko,

Nothing moved here since 2020 and the DTSes still have incorrect flags
for interrupts.

I can rebase and resend (although maybe it still applies cleanly), but
more important - is someone going to take this patch? or test it?

Best regards,
Krzysztof
