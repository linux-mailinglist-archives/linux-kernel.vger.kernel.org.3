Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC09597C31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbiHRDT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243087AbiHRDTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:19:22 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C8474F8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:19:18 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-32fd97c199fso8640457b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=BiYFqunK9O7/TlJUzZAQB9ZJLp/cE2IuaFTnRLRISWs=;
        b=esuEf/fxu4uMu25CRGKsrCc/zg82eolon2uic4JRTW6xeMpPNbejM4O6Zp9WSC5f3K
         ZZgJGtq0/m2e2TCm89SgluhBVi9OxkknhsKwvN3EnF5V7ycQywxJNTl9eNzYZnrvqq0K
         wAPiPJSeCPgLINXG++WtqF1qONG0ft/BGc5Cuqjrvjo+xoxK6grv1FR4wIhBRnbu7Muq
         XoOO3zKGsZjjSzMvcwwpa5kvI5DR5JYgwrUZVolsl7B5GkHiHdnLG0N93DTZfx5kS4aP
         tRyZjJ9Jzr5VNwShR60/X0SJo3f8yjwylHcFHQmKi/1QUcjz9PiJySQrS2xwVvbOuTg4
         CYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=BiYFqunK9O7/TlJUzZAQB9ZJLp/cE2IuaFTnRLRISWs=;
        b=auuX56rK5hW74HPw+oW9nTlDlIW1vIcvC1V0M/6U4eE1B1z+vdJMhK1ZVXoIGHTKDp
         Y+H3uGx2vt7aSb4fkgs2NzUwKJ32WDVsO/rbqTbLCYGkFB1Rrzz2Buc0YZKANtLBXQwS
         wPYQ1yGmgWaPBb8kbaE5hipTll8JKQuWpOLxdN8cSgldfeg9RhtBzFX741WEqjQsW662
         THBmqSKY2/gwCNmwlrk7Sk6O6lP0GwHPAIsb4BgGtLLjZ50fZwQi2Z+ClDFYxbqjnrPU
         rNkaMIG12/ghnG3bdyDuih7HZvNh2B8Qj9rQc5u8cnY/1L+R60GIJq+Ddqtdr6H5B1qd
         aMfw==
X-Gm-Message-State: ACgBeo13vxbIqK/Um+H+oHATQQnlw8fWcxB/Q1w5gKHMkkpJERxM3cwo
        ufBwrp8luWnMg4WCCnBBjFL//x9khiaBXYFAH3iHDw==
X-Google-Smtp-Source: AA6agR5nX3cIDtLsQqH5hgUm2GUyU7P8msHO5iW3xBD6uJtdPO4idng+UcH5yjd1sHGqpbPlzUJwx5PuXnsT4rKtH2w=
X-Received: by 2002:a25:4288:0:b0:692:8c1e:2e7e with SMTP id
 p130-20020a254288000000b006928c1e2e7emr1170829yba.479.1660792757464; Wed, 17
 Aug 2022 20:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220815093905.134164-1-hsinyi@chromium.org> <CAD=FV=XYNKF8q1mttru_J188pYMjSphQsEfQAO1Bt7GvjJRKXw@mail.gmail.com>
 <CAJMQK-gjg9evLY3oP5rgaGoRdQQTLqnK2-FChaabJTCxLTTmYA@mail.gmail.com>
In-Reply-To: <CAJMQK-gjg9evLY3oP5rgaGoRdQQTLqnK2-FChaabJTCxLTTmYA@mail.gmail.com>
From:   Rock Chiu <rock.chiu@paradetech.corp-partner.google.com>
Date:   Thu, 18 Aug 2022 11:19:06 +0800
Message-ID: <CAMuczyUH1tefU_4+dx495_5kdrxRdA3pmXS-eyjzMCcYFfjNXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Add double reset T4 and T5 to
 power-on sequence
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How does T4/T5  impact the real case? We talked previously the T4/T5
shouldn't cause user impact.
Do we have testing data from ODM?

Rock Chiu

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Thu, Aug 18, 2022 at 6:54 AM Doug Anderson <dianders@chromium.org> wro=
te:
> >
> > Hi,
> >
> > On Mon, Aug 15, 2022 at 2:39 AM Hsin-Yi Wang <hsinyi@chromium.org> wrot=
e:
> > >
> > > The double reset power-on sequence is a workaround for the hardware
> > > flaw in some chip that SPI Clock output glitch and cause internal MPU
> > > unable to read firmware correctly. The sequence is suggested in ps864=
0
> > > application note.
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> > >  drivers/gpu/drm/bridge/parade-ps8640.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm=
/bridge/parade-ps8640.c
> > > index 49107a6cdac18..d7483c13c569b 100644
> > > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > @@ -375,6 +375,11 @@ static int __maybe_unused ps8640_resume(struct d=
evice *dev)
> > >         gpiod_set_value(ps_bridge->gpio_reset, 1);
> > >         usleep_range(2000, 2500);
> > >         gpiod_set_value(ps_bridge->gpio_reset, 0);
> > > +       /* Double reset for T4 and T5 */
> > > +       msleep(50);
> > > +       gpiod_set_value(ps_bridge->gpio_reset, 1);
> > > +       msleep(50);
> > > +       gpiod_set_value(ps_bridge->gpio_reset, 0);
> >
> > We really need another 100 ms here? ps8640 is already quite slow at
> > powering itself up and that has a real user impact. Why was it only
> > 2.5 ms for the first reset and 50 ms for the second?
> >
>
> The T4 and T5 are required by Parade. I'm wondering if they can
> shorten the 200ms below:
>
> /*
> * Mystery 200 ms delay for the "MCU to be ready". It's unclear if
> * this is truly necessary since the MCU will already signal that
> * things are "good to go" by signaling HPD on "gpio 9". See
> * _ps8640_wait_hpd_asserted(). For now we'll keep this mystery delay
> * just in case.
> */
> msleep(200);
>
> Does this have to wait 200ms? Can it shorten to 100 due to the
> additional 100ms from T4 and T5?
>
> > -Doug
