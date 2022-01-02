Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5BD482C9A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 20:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiABThC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 14:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiABThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 14:37:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451A9C061761;
        Sun,  2 Jan 2022 11:37:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w16so128568771edc.11;
        Sun, 02 Jan 2022 11:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uzAERIEZYtJsAijaT2QvW435vVYwBNMjvEfhVhmIpoI=;
        b=X7Tjc25U+hYXI+B2D5vMKce//4kBPegHGMfpeAX+uP9GFV3PoKrqHYVuFNG2GW2za6
         9bbVpiOalULkX0stLnVxCVgHTuh/3VhBKz7vV3G1ons/CYAZ60t9IDV8hr8/cMb/AZZ1
         Mv3GqGICQnAvGYel7hC3i0LbZbr5UXX9ek0wFd3pNbWlT0IZ0bzRula1AKIiyZFobwuY
         xUxl8KOCMSwapwquwv0+K9wWJfqJ0qbRLgANTpGkpXppwS7HtO/f663A6NP34jn6GJnQ
         /MrcCQBSQi2AvXyFM0M76oHSwtEBb1VSuEPtyRDzT73KgRV1wWDV2XDRsnY5XUQ/M8ep
         /Vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uzAERIEZYtJsAijaT2QvW435vVYwBNMjvEfhVhmIpoI=;
        b=nyVdphMTJir3LYLPmhaTxW9x4mzOaRCgZJXZBZCqTZX8+c/yfhcIep8kNxhilrsUVu
         G5p4thgBCFYoIpVZXmjeLq+hHNBrsOEChm8JrfBKz79AxyzSJg/Eur/tgjhzSkKhdBwh
         CJStjhGhqrGoV8iW4ZGDm/0mjhwEfmscSzheNPvBhEpYnXlIXHFCjNKqExmkrzpw3tIZ
         ZjThlo2s4ipZzZIMptwfDc3qnEPSC4oxUO6l37NfvT+0+sXadFBWquHiutijOzQ0ijBJ
         uLBZ7Ph9qJe3328lJqCw30kvECWoqO4gllF2EtIMy+SL7Uy+7ajfUycpdV/TboFoKlXI
         R5RQ==
X-Gm-Message-State: AOAM530ISfF+vHBzMHqvn5pst974rsDMMoPLmvmOYKkzkLr12sTkvZzW
        a1V/PPUn0k3eP9851bbHjGbR/ewqe3jH0mC7ppI=
X-Google-Smtp-Source: ABdhPJyA5JDjOj3D7kdnhw3GydVhkJJ79iI3UrO51EvXQ4tl9sz/KzZ3LjetLzazLYQ9J2BpMXjF0rDNtrnThAkP+14=
X-Received: by 2002:a05:6402:1b9c:: with SMTP id cc28mr41250867edb.219.1641152219124;
 Sun, 02 Jan 2022 11:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20211230102110.3861-1-yu.tu@amlogic.com> <20211230102110.3861-5-yu.tu@amlogic.com>
 <CAFBinCCL-QaeSRCLzfyNXcRQZ7YC1D85rP2y4OGkAjCmQEqGgQ@mail.gmail.com>
 <3e1e40aa-7865-0f7a-5772-e2ad96c8141d@amlogic.com> <CAFBinCB2nF0TwRE1uJ4UTB_avcqRBfOHR1CDSe29dB1o-YjEHQ@mail.gmail.com>
 <7278bace-a2b9-0cfc-55b3-c19311e3352e@amlogic.com>
In-Reply-To: <7278bace-a2b9-0cfc-55b3-c19311e3352e@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 2 Jan 2022 20:36:48 +0100
Message-ID: <CAFBinCCwE1DbP+Y49o3WxNdeE11ZK=HcGbXa0Sq52tch+eNhrQ@mail.gmail.com>
Subject: Re: [PATCH V3 4/6] tty: serial: meson: The UART baud rate calculation
 is described using the common clock code. Also added S4 chip uart Compatible.
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 1, 2022 at 2:30 PM Yu Tu <yu.tu@amlogic.com> wrote:
[...]
> > Interesting, thanks for sharing that u-boot turns these clocks on.
> > Let's say someone wanted to make u-boot save power and turn off all
> > UART clocks except the one for uart_AO (where we typically connect the
> > serial console).
> > In that case the pclk of uart_C (just to choose an example here) is
> > turned off. Would there be a problem then accessing the registers of
> > uart_C before clk_prepare_enable is called?
> The way you describe it, it does hang. This would not be recommended on
> actual projects.
>
> At present, AmLogic chips are older than S4 Soc, and we have no way to
> deal with this problem. We have to tell customers not to use it in this
> way=E3=80=82Customers rarely use it in real projects.On the S4 SOC we wil=
l use
> a clock like the UART pclk to control the shutdown using two registers,
> one safe (need to operate in EL3) and one normal (EL1). It will only be
> closed if both registers are closed. This mainly prevents misoperation.
oh, interesting that there's some updates specifically with the S4 SoCs :-)

> With your experience, I'd like to know how you deal with this kind of
> problem.
Before this patch the driver simply turns on the clock from within
meson_uart_probe() (specifically it does so in
meson_uart_probe_clock()).
I think there's advanced power-saving techniques. Maybe for now we
keep it simple and just enable the clock(s) at probe time and disable
them at driver remove time. What do you think?


Best regards,
Martin
