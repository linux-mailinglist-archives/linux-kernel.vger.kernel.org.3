Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6E54A68AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242940AbiBAXm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbiBAXmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:42:24 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D53FC061714;
        Tue,  1 Feb 2022 15:42:24 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id b5so15903571qtq.11;
        Tue, 01 Feb 2022 15:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R+AbsoQ4j4lYYOMO5DjMuZRmgaKdMhuLSDQN4EirU1E=;
        b=CQDmX/wVWidrU0SI+kIZp5NG01KUi2mO1UKAR/3ooPHi/ftdqOdZBcJs4Dzdbw5gK6
         FZsRz3L6FDerkasEbxjpBeu8/7w/c4EVFu417dqVU5Pt15b+uYlIPRCapiWdtKzliMyF
         ER6mxp7sxvM1bBRBX63tCk1fJ2RuoCOCItnWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R+AbsoQ4j4lYYOMO5DjMuZRmgaKdMhuLSDQN4EirU1E=;
        b=hB7C0PqVY05dhx2z3+H9FBCx/mhn+fuh1qJqrA7zmoZsW89zGmR5yY5+6Q/+SekI8o
         qofz4JkmIaVmSipSwf2qd3LmwSEgroB3SqFeRGdyigG9r+Bq6Kd5x2YiGcb/BJLQuGvg
         ijbSCT1yAbZ7eYTFmSXTdgCpVP5dSGhqRblIQ1kx59XTuXpD8nDjNglj37YveMoJxwF8
         sdfFnlxDhx2F7pwD7sYJJpQCWDftIn2OYyqDk0x0aNWYXCNIuU/3G7dnbf/4pSCM8REW
         wQh4up97JEoIpy62/uo9EtN7cZrt5EqZRXf6Ogqrb4Mcmawrdu/znh6jkUSlcAuOlPGb
         KgSQ==
X-Gm-Message-State: AOAM531JYOGBZyCogajbOIr6Y/Um/hS8gUSKpLKsL3k6Flys+TBklYUi
        DOzcqz2wHx1TtppTF7vQ3E4Gn9rP5D3BzyMa5zc=
X-Google-Smtp-Source: ABdhPJx8iUhhai2hWqxLgNwvH8cXg4bRiRbQfnn9fM91zYV0zPPxT3jHTQy1SQOXTUUlxVBfwRKKK2OfxLQ5dG9iyzs=
X-Received: by 2002:ac8:7f06:: with SMTP id f6mr21096423qtk.625.1643758943437;
 Tue, 01 Feb 2022 15:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
 <CACRpkdYEigGHkoGfBg15tFXadgpXUAjDOnw7ePXhmvHJqPEJXw@mail.gmail.com> <YfZkis8M81Ejpagq@latitude>
In-Reply-To: <YfZkis8M81Ejpagq@latitude>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 1 Feb 2022 23:42:11 +0000
Message-ID: <CACPK8XdFXRQf3MpPh3z=EMAKtnQSHL+iwwMCVYc5dP9DfQEN+Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Nuvoton WPCM450 pinctrl and GPIO driver
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 at 13:05, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.ne=
t> wrote:
>
> On Sun, Jan 30, 2022 at 02:50:25AM +0100, Linus Walleij wrote:
> > On Sat, Jan 29, 2022 at 12:57 PM Jonathan Neusch=C3=A4fer
> > <j.neuschaefer@gmx.net> wrote:
> >
> > > This is version 5 of the WPCM450 pinctrl/GPIO driver patchset.

> > Which patches do you expect to be applied to the pin control tree?
>
> These two:
>
> [PATCH v5 4/9] dt-bindings: pinctrl: Add Nuvoton WPCM450
> [PATCH v5 5/9] pinctrl: nuvoton: Add driver for WPCM450
>
> and the rest can go through Joel Stanley's BMC tree, I think.

Seems reasonable. I assume you're sending a v6 to fix some of the warnings?

Cheers,

Joel
