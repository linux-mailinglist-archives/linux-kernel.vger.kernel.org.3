Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2DE50CB8B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiDWPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiDWPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:13:01 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FE81BBF91
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:10:04 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id d12so315258ybc.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcEOj4EmRV2bT/d0f7+I1phF7xYEnU+HoITpUoil1Mw=;
        b=u/kUitkfNhZi0kJxhasNAWpadIX8okuT+xHKh/AncBUmqZhr5dcUqMZGoO8lFrxth6
         3edvzEpOuHdb6/JRsEZbN+oJeG6wBT52Kex7kih9ogV9o+RTFwO5+lyElLepmmpW49II
         RKi32p7JayVvs/AaCwophRvemsGk24kke3CwEWWq2YzjNlyTwfsWzxaC2Hw3L/RYLNxn
         SG1RTUdFWjhZcpV6c0XgeMg0vvv1w0pcUBgW2fixeB8AXBYhaC6I/UJh8XQIv8uxTWPz
         zvDFY+Tm8k+LpUbZDYpOn7D3W84FNURm4Am3ItNYQRsL9T67Yp2BVldKdfO2gDXtwj5e
         eLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcEOj4EmRV2bT/d0f7+I1phF7xYEnU+HoITpUoil1Mw=;
        b=f44FE5ywBaXVgJdWACz1zOAlW/kNSwpNyBHTpn25fcXNyr197OT1gEBCWY+6n5cCgr
         z/6po5pdQX3ysa2Zw0yzFFCE/BRL1FIWzI3nMLghnqFmzilANy0JEbmrFtSMHFzifacr
         j+SUKmlS6pfcKAnHSCYGSMXbj6H8lnS23mn4DAN8ShJ9cWGvshyJ/TrC/fSjKIGLMf3e
         5Ow0UUUb7EanhhIrpqwu4zaqjTFSPur9etheW/orGlJ2dBgAvSkqx1B/ps1mSvjHZXx5
         PEv34NJpdT0L4ww8sbzI9LoZ4Ejfk2e6QFUxISgqp43p3W0/mTF6Jokmhn1AKFg2cC9O
         BlEw==
X-Gm-Message-State: AOAM53105r4ClA2BleGrjeHk170tqHNI3Dm83DuiHF+wMDOXvkRDe80g
        xtwLdgAkJS8MKRfzC9+63/t40QPW9LvYaCuKophCog==
X-Google-Smtp-Source: ABdhPJyza1njnKyLN1yEv5H9aRd4Bo/zhtPtUsD4WN9dTedBBqyfjW7aGLR6pq3lbFrcY23bIvF1/otEzmacQP08lR4=
X-Received: by 2002:a5b:451:0:b0:648:2a28:973f with SMTP id
 s17-20020a5b0451000000b006482a28973fmr2538584ybp.291.1650726603099; Sat, 23
 Apr 2022 08:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220414214337.311880-1-linus.walleij@linaro.org>
 <f4deb182-ec18-6744-2c4c-adaed4ef7a33@collabora.com> <CACRpkdbZnWJgkS2a0xXs_WG40jz6+aTSPt743Zigd0KZ8R=yww@mail.gmail.com>
 <cdb243d7-af84-b647-ee29-e4d4ab04834b@collabora.com>
In-Reply-To: <cdb243d7-af84-b647-ee29-e4d4ab04834b@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 23 Apr 2022 17:09:49 +0200
Message-ID: <CACRpkda8pT-mzZXDAoGLnK2xZ9TtrvMqY49oHY6E1C4LSsQhcA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gnss: Add Broacom BCM4751 family bindings
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david.heidelberg@collabora.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 4:12 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> On 4/23/22 00:50, Linus Walleij wrote:
> > On Mon, Apr 18, 2022 at 1:19 PM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >
> >> What are the chances of seeing the kernel driver for BCM4751+?
> >
> > The kernel does not normally drive the GPS. The kernel has a small driver
> > dealing with hardware power on/off of the GPS and exposing
> > /dev/gnss0 to userspace.
> >
> > See Johans lecture at:
> > https://events19.linuxfoundation.org/wp-content/uploads/2017/12/The-GNSS-Subsystem-Johan-Hovold-Hovold-Consulting-AB.pdf
>
> IIUC, driver also should be needed for the firmware uploading, similarly
> to the BCM WiFi/BT chips, isn't it?

As far as I can tell from the filesystem on this phone there is no firmware
so it is flashed into the GPS chip.

> > gpsd is the most common userspace daemon for GPS.
> > gpsd will then talk to /dev/gnss0 as any other TTY IIUC.
> >
> > Replicant has a free implementation of the "MEIF" API for this GPS,
> > I think what is needed is really for someone to pick up, polish and
> > contribute that to gpsd
> > https://git.replicant.us/contrib/PaulK/bcm4751/
>
> My main curiosity is about whether you already have a working driver
> prototype, something you could share with us all, so we could start
> playing with it too :)

It's on my TODO whenever there is time, but I have small kids so not
so much time... I was hoping for the jolly people in postmarketOS to
chime in because they seem to have a bunch of people with lots of
time on their hands available :D

Yours,
Linus Walleij
