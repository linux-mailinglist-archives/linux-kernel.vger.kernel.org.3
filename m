Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C072E485FA5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 05:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiAFE0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 23:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiAFE0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 23:26:48 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200ACC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 20:26:48 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y11so1674345iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 20:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkCvCqGdhWY7NdSYpEk/A05XaJytNQXaztYS1krQOuE=;
        b=ObjLd/A8t4iuUY9l0KNrYl5X/IFFH88dEa++rH3V0QyYfmcxFocM2EVfQAueLD7zgG
         x3nrlRmIkQ9WwjVzV7FWOm3Ttciuz4s22N6724nLb0LBpE7s4l6sBLOWu1FP9v4PyoCU
         4LONEfwapCVeSXPS5uKbGqH/FKg7+mTlfiF7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkCvCqGdhWY7NdSYpEk/A05XaJytNQXaztYS1krQOuE=;
        b=ofDusIZ57MisgeaXMxZrU60CI5/9+Ri5PEHLp72zOL8rxYK2uXGD7bdxT5iBhSZ1+Q
         mCGdcp9UbRsrzW7m0Go7xbSJ3H1rUs4Q7jzqNx3VG3e3F6QupFqqyMJ1LtdeI9JWp+Ge
         FkTXAwqjlMzjToAhYlAkufFDWYRmEc9egvEZGNe/rD5aKiQLBYom/i40tIwTuUi/EvPk
         MJsnW5AGnbDUPiAVuN0k0wOpw5rSSKRJu4IL0qZU3MjakcQf4MRgTeon2rkG3ViZICKW
         L2224aL1qH9KX9Xq/SpVvwbKsdAXwIZYcAdU0t33Cd5+4BttNxJfHfQ15OPrBdAeo/v0
         fqbQ==
X-Gm-Message-State: AOAM5323mW08qA7XLvHQzaiJ63RoSe7IlxuRUaB15g039RCwq5Za7sTE
        Ktm8vMdUiWhxaLD7ak26NDNYyc7goCWncIOMGQis+Q==
X-Google-Smtp-Source: ABdhPJz1mVdQAc4YRaaititEKV9+bI9Q7l4NcuceQfAEzQKAJXIv9KkRSHHVAB2rj+0uIwfwFW0g3ssfz0cnPxewjLI=
X-Received: by 2002:a05:6602:158f:: with SMTP id e15mr1795256iow.131.1641443207483;
 Wed, 05 Jan 2022 20:26:47 -0800 (PST)
MIME-Version: 1.0
References: <20220105220653.122451-1-gwendal@chromium.org> <CAE_wzQ_DTnrU9QbADZuNyt4fszAiTwa04D9muC-xE_S3MM9eGQ@mail.gmail.com>
In-Reply-To: <CAE_wzQ_DTnrU9QbADZuNyt4fszAiTwa04D9muC-xE_S3MM9eGQ@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 5 Jan 2022 20:26:36 -0800
Message-ID: <CAPUE2uu3FPvxHHGYGbckxR=QmWt3=KwFk3DYoqBSmaQd+AO0QA@mail.gmail.com>
Subject: Re: [PATCH 00/17] Add export symbol namespace PL_CHROMEOS
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        jic23@kernel.org, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
        lee.jones@linaro.org, pmalani@chromium.org, sre@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lgirdwood@gmail.com, a.zummo@towertech.it, cychiang@chromium.org,
        perex@perex.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 2:58 PM Dmitry Torokhov <dtor@chromium.org> wrote:
>
> Hi Gwendal,
>
> On Wed, Jan 5, 2022 at 2:07 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Add a symbol namespace for functions exported by the plaform chromeos
> > subsystem.
>
> It would be great to explain why this is needed/desirable. What are
> the benefits of introducing this namespace? What problem are you
> trying to solve?
The issue came when reviewing an iio sensor
(https://www.spinics.net/lists/linux-iio/msg66280.html). I wanted to
be ahead of the curve (for once).

>
> > Add depenencies for all drivers using these function.
> >
> > 'make nsdeps' is used to fix the dependencies.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> >
> > Gwendal Grignou (17):
> >   plaform: chrome: Add PL_CHROMEOS export symbol namespace
> >   iio:cros_ec_sensors: Add PL_CHROMEOS dependency
>
> I wonder if ordering patches this way breaks compilation (patches
> should be structured in such a way that one need not apply entire
> series to get to buildable kernel). Isn't putting symbols into new
> namespace makes them unavailable to modules unless they explicitly
> import it?
From https://www.kernel.org/doc/html/latest/core-api/symbol-namespaces.html#loading-modules-that-use-namespaced-symbols,
since MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is set by default, this
is just a warning at load time.

Gwendal.
>
> Thanks.
>
> --
> Dmitry
