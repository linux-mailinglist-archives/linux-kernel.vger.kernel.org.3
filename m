Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA46A49EEDA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiA0Xcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiA0Xct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:32:49 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010D6C061714;
        Thu, 27 Jan 2022 15:32:49 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id p5so13291575ybd.13;
        Thu, 27 Jan 2022 15:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=45b55r8UrP19JXUlLW74FhqYl/0CdywuMW59aCYj888=;
        b=flncRfSPwRoAgqDR9OXU6u8IxKFDE5sMsLuqOng6ONrSAhCQEKo08oV6HPk8FYDthr
         9f0pU1HM9KHv1Il3dWqN1RCpfqD2WF/WEWC86K+0NuHgXbl2CKuCJ32D74Yr/w4luSmz
         +Kth0fcvEoCCWqcXYhCK1dLCN7T9y5aOnoHGYjEtTPTM+xD70/VvawKq/rPOO7bR57My
         ZNLsF9/l4SlDHgoVA38O5E2i5n0KK8+QEGfK8UtLaLpjtEbqmn9i3sJrpZImASTWmBBh
         lICci5Ql846yLCpsLrZz1mH0GqPaG3rmpRFNyDWV9WE7c3Ft2sUBl1+YxXDbZH0TGKIb
         t6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=45b55r8UrP19JXUlLW74FhqYl/0CdywuMW59aCYj888=;
        b=urQ2J62rIug3BOn6nCR10IBdXryQI873XBhG343AB/awjni+9XfpnFc6sEE4i6twUm
         k7PkTwxZureRSJxFZJoGFA/yl8d6e9eK8vBKPi7R/C6Rgki4jN/ZqI0K7gKKXqfDCV9y
         coiJmYESh8QMt+dmP+5f5SRdmnyitgU3JyrL58+H+XtJqOEXw4miaggmCqzMoEKC0gn5
         8EbO5OKj2XL0TA3KDwJKG6LTL130C1jSkSxN48Hen/cY9ueLWMf4tSjMhz16eBEFkPeE
         49jNjPjFafrvf7jXeMwGpXwkMiVn2Ou0HuYkZbTzsN4AVrJsB+LJkf8P7vRSBfhvZkT1
         UdHA==
X-Gm-Message-State: AOAM530k3LsPmd6m3mjAZXv+xEdkkMxt9uxqeBbpepyDWbKlZtpdVyso
        fGDHBPex//Rxl85qWInms89FZRPZn+jj5p4n1Fg=
X-Google-Smtp-Source: ABdhPJzw0vXppBjuNB3RMkeTHKdzaHn5o9WVCpp9aGE46D/kj99Jzrn/fB+HFG2Bllds+UXD7Yz1rLkpDvPrYyyERTc=
X-Received: by 2002:a25:d0cb:: with SMTP id h194mr9514813ybg.680.1643326368214;
 Thu, 27 Jan 2022 15:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20220127010023.3169415-1-pgwipeout@gmail.com> <07281029-0efd-0a74-0d96-92e3dcf5bbb7@gmail.com>
 <CAMdYzYrKq==Bs0aonrJBC+W2c4nQ8cUn2dn_Se4WDaRCkT6SYg@mail.gmail.com> <3859424.JUeRptVaKW@diego>
In-Reply-To: <3859424.JUeRptVaKW@diego>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 27 Jan 2022 18:32:36 -0500
Message-ID: <CAMdYzYoQkR805xCyPstf2nrnzymVB3Ff4_cQAz_qsbokz8DG2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add Quartz64-A sdmmc1 node
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 5:15 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 27. Januar 2022, 10:55:13 CET schrieb Peter Geis:
> > On Thu, Jan 27, 2022 at 1:18 AM Johan Jonker <jbx6244@gmail.com> wrote:
> > >
> > >
> > >
> > > On 1/27/22 02:00, Peter Geis wrote:
> > > > The sdmmc1 node on Quartz64-A supports the optional wifi module fro=
m
> > > > Pine64.
> > > > Add the sdmmc1 node and requisite sdio_pwrseq to enable wifi suppor=
t on
> > > > the Quartz64-A.
> > > >
> > > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > > ---
> > > >  .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 45 +++++++++++++++=
++++
> > > >  1 file changed, 45 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/a=
rch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > > > index 33c2c18caaa9..1d73ac6557c5 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > > > @@ -91,6 +91,18 @@ simple-audio-card,codec {
> > > >               };
> > > >       };
> > > >
> > > > +     sdio_pwrseq: sdio-pwrseq {
> > >
> > > > +             status =3D "okay";
> > >
> > > When a node is not previously disabled, then there's no need for "oka=
y".
> >
> > Thanks, this is here in case an end user wants to easily hack the
> > board to use this for other purposes.
>
> but please drop it here as well.
>
> A user "hacking" a devicetree should be able to also just _add_
> a status "disabled" :-) .

Understood, will do.
Thanks!

>
>
