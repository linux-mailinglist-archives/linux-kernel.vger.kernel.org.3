Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A833484955
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiADUbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiADUbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:31:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF0C061761;
        Tue,  4 Jan 2022 12:31:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 626DB6157D;
        Tue,  4 Jan 2022 20:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACCCC36AED;
        Tue,  4 Jan 2022 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641328304;
        bh=iAG8B3ZpKh/tvy6iG5URP7IbImgaSPzk9TUk4eHefQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yi7zREne0VxnunBWcxx0IIhDo5zqKfxFv+Py2S+vGhxGTw/FYpPEbLQvZX3ziBhn8
         Y65C5kuG0ZlxpPSA13cdcZRq4biW4S2KTPIqAPo5irHXzwQbhBk1cI8gN5zAqdtZ3a
         mtpACCr6qjIHHQFcvrmlTlA7bx1KLDMK2VzI7wgfwNwZsyl9dmgk2/fIBtbyiXgRff
         gplJGIzB1zvAXGH3KIqD6zXM8ZKbSFan8iRA5LBlc01fW1M2hTOMh9rbSeXLv4x83i
         34A8yhmfRoJFRkjOHN86ajJXeY3BA4hVtSXpOUIw/hXa36Tkay9abdm04J0uSZHZMf
         XwupkN9zxsmww==
Received: by mail-ed1-f44.google.com with SMTP id j6so152991504edw.12;
        Tue, 04 Jan 2022 12:31:44 -0800 (PST)
X-Gm-Message-State: AOAM532HRPEY85LE+KWZnHSBM57JpWQ4yiUnE1ReeP9kRd5nluL3LmGI
        gEr/Su55CXeoLtdUn0p4bmHo8i+n2VLguEWg+g==
X-Google-Smtp-Source: ABdhPJwPtVu84Gbmxpg5haak5g6wrYjBHdIwwCb7MqqLp2qJ0r9HYDUdg3yiXzkAioz1RVciVqWCihfQlPWZviDmnPA=
X-Received: by 2002:a17:906:eb04:: with SMTP id mb4mr39454430ejb.27.1641328303114;
 Tue, 04 Jan 2022 12:31:43 -0800 (PST)
MIME-Version: 1.0
References: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
 <1636444705-17883-1-git-send-email-lh.kuo@sunplus.com> <1636444705-17883-3-git-send-email-lh.kuo@sunplus.com>
 <YaQu3dCQD4FG7ete@robh.at.kernel.org> <f5607fa7ad9c49a7bfcce02eac834838@sphcmbx02.sunplus.com.tw>
 <CAL_JsqK=7ma_LwMMoW7yfVoBfPN0hBJsPbp4ojtk0kt3k=+O1w@mail.gmail.com> <1eb97e1aca9c4c8d8f1e17c51f2792ac@sphcmbx02.sunplus.com.tw>
In-Reply-To: <1eb97e1aca9c4c8d8f1e17c51f2792ac@sphcmbx02.sunplus.com.tw>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Jan 2022 14:31:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKJJutPpc-xRK0y+t8s=jpqkBmHMgaFK1mnEcxPT98vjQ@mail.gmail.com>
Message-ID: <CAL_JsqKJJutPpc-xRK0y+t8s=jpqkBmHMgaFK1mnEcxPT98vjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] devicetree bindings mmc Add bindings doc for
 Sunplus SP7021
To:     =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Cc:     "LH.Kuo" <lhjeff911@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 7:59 PM Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=AA <lh.Kuo@=
sunplus.com> wrote:
>
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - sunplus,sp7021-card1
> > > > > +      - sunplus,sp7021-sdio
> > > >
> > > > What's the difference between these 2 blocks?
> > > >
> > >
> > > One for SD card One for SDIO
> >
> > If the programming model is the same, then it should be the same compat=
ible string. We have various
> > properties to handle differences like bus width, card detect or not, et=
c.
> >
>
> SDIO and SDCARD still need to set the date and CMD decoding differences.

I still don't understand. A host controller should be able to
initialize a card enough to tell what kind it is. And we have things
defined in DT like 'no-sd' and 'no-mmc'.

Looking at the driver, the difference appears to be just setting a
register to the mode (eMMC/SD/SDIO). That's not a difference in the
h/w block which is when different compatibles would be appropriate. A
property, if anything, is the right thing to do here.

Rob
