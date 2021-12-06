Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D18C469099
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbhLFHEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbhLFHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:04:36 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A4AC0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 23:01:07 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id k23so19154337lje.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 23:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1AQZh20vUe2bSZJWmTpLBbNp+/mZ/BldyWwrnGU/0bU=;
        b=omNa/UiM9qjdGQw2QCtKBJVYMZm2mFyMZc/UJIh1TqueY4LlnIaw9c6zFHkjdpDllh
         adbEpad8WzbPXFJZHJxyAqkopdbTHOeIqrPK/IURVv0nqqj9wNqZj7YAocUYkzkHvTAd
         DnJX3zKEHV/9R31lr3APO869Cf215nYiozGyVLM9za3BpTyGknhEHMIjUppnxQ8t2vYS
         yGUd/0SHQC9HaerR5YFLXcW3caBVqGCuo2sI8KksCLEcxFAvPIKpj6QS92KUC6gr6qgE
         vnJU0lMPtU7un2Cfb1NfTQb8dp62agsYeqoT2V9n8kCj5IBRN9QKXvfvJZTIkhpGVfYX
         qDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1AQZh20vUe2bSZJWmTpLBbNp+/mZ/BldyWwrnGU/0bU=;
        b=W6b1SImGHfSGIfIbX7V+ke0etpseoC5wsD2/J17YmvvLF3rK98Qe9/E3BfLTev9nCk
         ZcBuft/AmknhjMuH+7c4LnJ89re9hLiZ5nL5+dCuKHNAShFDwmE1UQ2XJDp+YhR0sVUe
         iLMXMaITCxwoywhQNcBHfYqh6r/WI4yTiNL5a2kAULxU6hql74H6moq+KUgC1qpk7f5J
         hruxlF50obFctEreAzTYyow/KOPBFMypVtr3ZlO01iX84q/KwZlF/HeTULr2Xmimd5V5
         BwUsRfA2N7F59l3++mErcWlUi+AT50qns+PLIgJjmCtP3S1CcH0fIpzI53bgVaN5V4GW
         69hA==
X-Gm-Message-State: AOAM5339bMtjWT5AZdChCcnKU9fM49/t357EVS6UmFbnDAuA6648KRrw
        +6tLIOR0oxuYUjHBykJxuedKsrczpK2ZGQAuTrI=
X-Google-Smtp-Source: ABdhPJyP9RR3mraXbWpRPK423lfP7+d+aguJ6Sg79paUS37Sy2Z0wzlpMUDUdJXbGWvKSR5yHqaSv4exFD+qQb9e7tg=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr34500657ljg.325.1638774066059;
 Sun, 05 Dec 2021 23:01:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+jpmksehY4BSH9jJPYuY+jykSHtx9TNiG-gAkq10zaXSQ@mail.gmail.com>
 <fe9dbf81-e060-36ab-b769-215af3d65ba7@linaro.org> <CAHhAz+iEQTtfxXB8sNEL4WxFjUZo5LYTo4EVyH0mT2=NH3VaUA@mail.gmail.com>
 <a5192a80-0401-78fd-6fb3-e58a3b5a3923@linaro.org>
In-Reply-To: <a5192a80-0401-78fd-6fb3-e58a3b5a3923@linaro.org>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Mon, 6 Dec 2021 12:30:54 +0530
Message-ID: <CAHhAz+izC=8ZbkxpbveS1u3Va1kwdCC4j4cEgMmRFojY-it+Rw@mail.gmail.com>
Subject: Re: Time: new clocksource
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 11:59 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 06/12/2021 07:00, Muni Sekhar wrote:
> > On Sat, Dec 4, 2021 at 3:18 AM Daniel Lezcano <daniel.lezcano@linaro.or=
g> wrote:
> >>
> >> Hi Sekhar,
> >>
> >> On 03/12/2021 17:50, Muni Sekhar wrote:
> >>> Hi All,
> >>>
> >>> We have a Digital PLL with 64 bit timer counter hardware and the
> >>> counter is accessible from the CPU over the PCIe bus.
> >>>
> >>> Is it possible to add this timer counter hardware as new clocksource
> >>> driver? To do this, can someone please point me to the existing
> >>> reference source code(or patch) for this task.
> >>
> >> You can refer to the drivers located in drivers/clocksource
> > I don't see the option in menuconfig to build the clocksource driver
> > as a loadable kernel module, for example CONFIG_X86_PM_TIMER=3Dm instea=
d
> > of CONFIG_X86_PM_TIMER=3Dy.
> > So a clocksource driver should always be part of the kernel built-in
> > module?
>
> Yes, that is the case today.
>
> > If so, what's the reason for that?
>
> The timer is a component needed at boot time, so a module version does
> really not make sense.
>
> So I would return back the question : what is the reason for a module?
For built-in module we need to compile the whole kernel, but we are
currently using the kernel via linux-image-4.15.0-54-generic.deb file
installation.
>
>
> >> git annotate on one of the driver can give you the initial commit wher=
e
> >> recent submissions explain the timer internals.
> >>
> >>> Suppose if it is possible to add a new clocksource driver for this
> >>> hardware then does any userspace get_timestamp* API would get the tim=
e
> >>> from this new hardware?
> >>
> >> It should if the timer is selected as the clocksource
> >>
> >>
> >> --
> >> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >
> >
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog



--=20
Thanks,
Sekhar
