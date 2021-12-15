Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9D2475B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhLOPDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLOPDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:03:04 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1EEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:03:03 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso25274555ota.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4LmpLmMQVYKC4yB/BA8hDER3dAOgirX22kQhvIxfc6k=;
        b=DeOyJJKMU55uXVXAS0+BuCIcPj0j26M6TG4y672SEPwqlgmp1UVx1zRbX2BqBX7JkO
         rkbKQ0b7GXklGShwNwpvEzY1Y7DXrAmZY/EUtVvQ6Q71NyWTdv77TbqYa9TJ3EATM6t0
         TlGyVtWPVpkyXDQ9ww2qMnLg5EfOIZHhTZimg2qTkerwlf25wHzEsWl2N5Klr3O/uK8N
         rxW0RExVHGZExcJd1mcp9tulB7nGgXXXr/03wt84yF/KqLUUxd2FIwWdA6vCQgcotAJg
         Lpc8yCUlDY2tquOM4md8re6GXHab2SfASS2u16DIkx0Iur+3WiwHyTbDY7f5Xh07gCFO
         y1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4LmpLmMQVYKC4yB/BA8hDER3dAOgirX22kQhvIxfc6k=;
        b=Hr/rq9JGXHB2CdETxUKdkedKG0UBjt9CDzLulIQFVQHBqirS1jSK1QZZ6+2+R2MIV/
         fsXdvst2LDGUc0zF3vED8ZOZc8zx5xsPt8Ouzj68AWXqOqdJdEIdYHSOrLd1jzNWb0eF
         0TVmwsMYTbuEeKS/ZuLEa9krWCONy34NzPs8pJg59x5fBUFqXgQHOaJ7q1HKCB80X9s5
         DLl2y35Yi+bkoOdyj8CA/YISzyY07GctI2haB2OStUx9Zn6VcbQmaDbIM1MU617XI8N8
         3mqJ7KHWs/HcuZ1Juf+nNgPCGIAPEgPZMdfX2Mq2+QEoXRrsiEXe3C3mCV1pmBCNTO2r
         cqRw==
X-Gm-Message-State: AOAM533anpCHnx06i9Xiv/jH6mAbJyWLBoRmXNhaIFeYtFECmXA5xw36
        75JWThXWE7Z1EqvWKfQzk1hrFtcYrbWTzEnRf8L50Q==
X-Google-Smtp-Source: ABdhPJyPeXxGFCtUrFhryeIE/cEECu0paw5oNL0wX3jX1W1iBxtrTpdCkDYUCr1opeCgLBoVOByK1UUQi8cSw6cCRkg=
X-Received: by 2002:a9d:2aa3:: with SMTP id e32mr8908943otb.6.1639580582790;
 Wed, 15 Dec 2021 07:03:02 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Dec 2021 09:03:01 -0600
MIME-Version: 1.0
In-Reply-To: <20211213165422.54n3oh72tjcb3a67@houat>
References: <20211110130623.20553-1-granquet@baylibre.com> <20211110130623.20553-8-granquet@baylibre.com>
 <20211115101129.lyxxmb6i7paaonwi@gilmour> <CABnWg9tNPGZSi1RLqF5+Qs1GHtynyVoOzAyw+i9mPRYEoByk8g@mail.gmail.com>
 <20211116145112.xyoxzfll6exysnvt@gilmour> <CABnWg9uhuchdWyBeTacR6Cy0A9OHziUi051BQ5wsZVU0ajYjyA@mail.gmail.com>
 <20211125143034.tzikvlxxl6fdhsif@gilmour> <CABnWg9tcWdfPQwNtFhqVZxCriT848fy42VHoQZs3X2UmL4LYSA@mail.gmail.com>
 <20211213165422.54n3oh72tjcb3a67@houat>
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: alot/0.10
Date:   Wed, 15 Dec 2021 09:03:01 -0600
Message-ID: <CABnWg9uyoK0TkRZRJXstmtB4u2-UUCi-x_frosKhhQerNmFT=A@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] drm/mediatek: Add mt8195 DisplayPort driver
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Quoting Maxime Ripard (2021-12-13 17:54:22)
> On Thu, Dec 02, 2021 at 06:48:12AM -0800, Guillaume Ranquet wrote:
> > Hi,
> >
> > Quoting Maxime Ripard (2021-11-25 15:30:34)
> > > On Wed, Nov 24, 2021 at 01:45:21PM +0000, Guillaume Ranquet wrote:
> > > > Hi,
> > > > Thanks for all your input, really appreciated.
> > > >
> > > > Quoting Maxime Ripard (2021-11-16 15:51:12)
> > > > > Hi,
> > > > >
> > > > > On Mon, Nov 15, 2021 at 09:33:52AM -0500, Guillaume Ranquet wrote:
> > > > > > Quoting Maxime Ripard (2021-11-15 11:11:29)
> > > > > > > > The driver creates a child device for the phy. The child device will
> > > > > > > > never exist without the parent being active. As they are sharing a
> > > > > > > > register range, the parent passes a regmap pointer to the child so that
> > > > > > > > both can work with the same register range. The phy driver sets device
> > > > > > > > data that is read by the parent to get the phy device that can be used
> > > > > > > > to control the phy properties.
> > > > > > >
> > > > > > > If the PHY is in the same register space than the DP controller, why do
> > > > > > > you need a separate PHY driver in the first place?
> > > > > >
> > > > > > This has been asked by Chun-Kuang Hu in a previous revision of the series:
> > > > > >
> > > > > > https://lore.kernel.org/linux-mediatek/CAAOTY_-+T-wRCH2yw2XSm=ZbaBbqBQ4EqpU2P0TF90gAWQeRsg@mail.gmail.com/
> > > > >
> > > > > It's a bit of a circular argument though :)
> > > > >
> > > > > It's a separate phy driver because it needs to go through another
> > > > > maintainer's tree, but it needs to go through another maintainer's tree
> > > > > because it's a separate phy driver.
> > > > >
> > > > > It doesn't explain why it needs to be a separate phy driver? Why can't
> > > > > the phy setup be done directly in the DP driver, if it's essentially a
> > > > > single device?
> > > > >
> > > > > That being said, usually what those kind of questions mean is that
> > > > > you're missing a comment or something in the commit log to provide that
> > > > > context in the first place, so it would be great to add that context
> > > > > here.
> > > > >
> > > > > And it will avoid the situation we're now in where multiple reviewers
> > > > > ask the same questions over and over again :)
> > > > >
> > > > At first I didn't understand your reply, then I realized I gave you
> > > > the wrong link...
> > > > my bad! I'm struggling a bit with mail reviews, but I'll get there eventually.
> > > >
> > > > The driver and phy were a single driver until v2 of this patch series
> > > > and the phy setup
> > > > was done directly in the driver (single driver, single C file).
> > > > Here's the relevant link to the discussion between Chun-Kuang and Markus
> > > >
> > > > https://lore.kernel.org/linux-mediatek/CAAOTY__cJMqcAieEraJ2sz4gi0Zs-aiNXz38_x7dPQea6HvYEg@mail.gmail.com/#t
> > > >
> > > > I'll try to find a way to make it clearer for v7.
> > >
> > > OK, it makes sense then :)
> > >
> > > There's something weird though: the devices definitely look like they're
> > > in a separate register range, yet you mention a regmap to handle the
> > > shared register range. That range doesn't seem described anywhere in the
> > > device tree though? What is it for?
> >
> > My understanding is that 0x1000 to 0x1fff controls the phy
> > functionalities and 0x2000 to 0x4fff controls "non-phy"
> > functionalities. And you are right, there's no description of that in
> > the device tree whatsoever. The ranges are in the same actual device
> > and thus it has been decided to not have dt-bindings for the phy
> > device.
>
> Sure, that last part makes sense, but then I'm not sure why you don't
> have the full register range in the device node you have in the DT?
>
> > The phy driver is a child of the DP driver that we register using
> > platform_device_register_data() and we pass along the same regmap as
> > the DP driver in its platform data.
>
> Especially if it's used by something, it should be described in the DT
> somewhere.
>
> Maxime


So, to make things crystal clear to a newbie (like me).
Would you describe it like this:
compatible = "mediatek,mt8195-dp-tx";
reg = <0 0x1c501000 0 0x0fff>,
	<0 0x1c502000 0 0x2fff>;

instead of the current description:
compatible = "mediatek,mt8195-dp-tx";
reg = <0 0x1c500000 0 0x8000>;

I haven't checked what the rest of the 0x8000 range is used for though...

Thx,
Guillaume.
