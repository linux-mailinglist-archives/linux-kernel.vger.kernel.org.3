Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81183484BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiAEAkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiAEAkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:40:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A57C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 16:40:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso75432pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 16:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+QqjubRXMhaOO4Im1+kXv4s6y4fFwhi8A1rks4WSNk=;
        b=OAk4wXvl42AsV0OgVKihUBANkadpnqLzbM5lLR7TYgqaZJmPb117e1b+cj4mf5i99U
         LHlz8PLnNYadlPYRwsUcw+tTQHZpRQlD7UWIH1mzV+RmB1Tg36eEjZ7nzl0VJNiPiP7+
         EiE6woRb9XV+jFoRU1HIots89H6g8RjObfHt4aWvhMenhpOZJk1svUfLaLAhRSpVXGGf
         rE9E/cvBgRqg1RdSGCGSuWFq5O4kWZHkasR1JeojUZ7V/RlwPXwpWDLhKghCpLS1/j/Z
         afLcLZWBNbVfK5a1dg+mHfUvmbpCw5y3XfkX/QAsIp7V68n9aKuoUQPPi6xB+QcOgIbW
         B58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+QqjubRXMhaOO4Im1+kXv4s6y4fFwhi8A1rks4WSNk=;
        b=b8yfY0ZFiFW3Ja2ZriJ/mxT9HVFJqwLj5ikU7Z4gzCo8l2pY2c3Pjn9rNn+t73o0d3
         9JUq4aWzLIix3NaB+l+Y37/bj2kDteK7IVVsWocQfwI4WK7U5kI/xjZ5NXt0KmHNBPWg
         JM5GSH3l4ETQzJcy7rnAuRAJmvEui+hC2v2rLyBBG/Iyw84PlocRCPr3yOHQnh8/1gnf
         hyv0D9Z+yyJWGXdgNnGCyqdfuMkfnMClcDU99GOll5JH+DroC6HpgPOhV3sYzLqNVDLW
         TOCTrj9TJbqtvSByccM1FnMqW42cQQR7gGzo2NF+ELlNGbWKBBJxUQTgvFvUKaOEVdb/
         6m4A==
X-Gm-Message-State: AOAM532fBJRzN2It5Gust0vgahHSFu0mylmuCDtEtDQ0LNW8PWPKDk3D
        usfmztho88WeldmfzKSLh/qIQCpSBTMGPJE4mzIbgw==
X-Google-Smtp-Source: ABdhPJzAR8BXRI9t45W3S6Ga+iKqottCy1N8a/hjba/fckLGAl6sxvFZkGRjZwL6qdQfmKZpByykP1PNdJ7IIngCHHk=
X-Received: by 2002:a17:90b:3143:: with SMTP id ip3mr1168992pjb.34.1641343245158;
 Tue, 04 Jan 2022 16:40:45 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0RDZpLtWjMEU1QVWSjOoqRAH6QxQ+ZQnJc8LwaV7m+JQ@mail.gmail.com>
 <7e480da8-0d54-2d62-0a8e-184901c974b6@gmail.com> <ee2c92da-030c-b92f-0f41-1fdbbeed47c7@gmail.com>
In-Reply-To: <ee2c92da-030c-b92f-0f41-1fdbbeed47c7@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 4 Jan 2022 16:40:34 -0800
Message-ID: <CAOesGMgx99GJ3gQmdgauSs3aF8xr4FgcgsELRz4HSVXmujHJnQ@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] SoC changes for 5.17
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, Jan 4, 2022 at 1:58 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 12/24/21 9:11 AM, Florian Fainelli wrote:
> > Hi Arnd, Olof,
> >
> > On 12/23/2021 13:31, Arnd Bergmann wrote:
> >> I'm sending out the pull requests for 5.17 early, as I won't have
> >> access to
> >> my workstation for the next two weeks. With only 760 non-merge commits,
> >> this again feels quieter than the massive previous merge window, but the
> >> number of changed lines was actually slightly higher.
> >>
> >> There are very few changes aside from devicetree patches, most of
> >> which are for the i.MX, Tegra, Qualcomm, Apple, K3 and Aspeed
> >> platforms.
> >>
> >> We have a couple of new SoCs in existing families:
> >>
> >>   - Qualcomm Snapdragon 8 Gen1
> >>   - Qualcomm Snapdragon SDX65
> >>   - NXP i.MX8ULP
> >>   - Texas Instruments j721s2
> >>   - Renesas R-Car S4-8
> >>
> >> The time between product announcement and kernel support is fairly short
> >> for all of these, which is nice. In particular the two Snapdragons
> >> were only
> >> announced this month and are the current high end of Qualcomm's products.
> >> On the other end of the spectrum, we also add support for ST SPEAr320s,
> >> which was launched 10 years ago.
> >>
> >> Aside from the Arm chips, there is also a pull request for a new
> >> RISC-V SoC,
> >> the Starfive JH7100, including some of the basic drivers to make it boot.
> >
> > There seems to half of the submitted Broadcom SoCs pull request missing
> > in this one, was there issues with those below:
> >
> > defconfigs:
> >
> > https://lore.kernel.org/linux-arm-kernel/20211221220642.2862218-1-f.fainelli@gmail.com/
> >
> > https://lore.kernel.org/linux-arm-kernel/20211221220642.2862218-2-f.fainelli@gmail.com/
> >
> >
> > drivers:
> >
> > https://lore.kernel.org/linux-arm-kernel/20211221220642.2862218-5-f.fainelli@gmail.com/
> >
> >
> > Should I resend or fix something in those? Thanks!
>
>
> Arnd, Olof, do I need to resend the 3 pull requests mentioned above?
> Thanks and happy new year.

I'm about to make a pass of merges, likely tomorrow -- I had to get my
Honeycomb working again since it hosts all the trees and mailboxes for
me.

No need to resend at this time.


-Olof
