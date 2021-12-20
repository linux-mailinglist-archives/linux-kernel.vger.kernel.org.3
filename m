Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD72047B1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhLTRH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhLTRHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:07:24 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED42C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:07:24 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id f9so30745001ybq.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/vGg57+Lx01rJOL0ZhVsf4BrYu1RDSpnZdQ9lgCWOVk=;
        b=Q8tWcGZEA2RwU8ph7C8XH17hY5haCfVSblfA1IOWIbH8QAu9bSscvDUXUBu9D/QnF/
         f9brp6m2rRS2E+U8AleTh8YdO1krRwtV9uKRejX+nonXaKWPTr5bY1fUS8z12E8FBlCR
         v3N2cDchfkImjqS/6jSk5FTJqHGEd6K2+3puFNkJA6mwSB2Cfngo4SK7eQ7nU55IQY9P
         G73dsBqnE8/uBTed1Nq814/CitTuk9GoPKlwr2y1Qlyd6KAiubvGHsAx1r8xaz2Q2cDh
         sueV9ITQnlW650TCH/J9/10Y4Cz/dc2IXdbpzujXaCUpv2SQ6bMn+22/71OyhhSbnjQK
         Abhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/vGg57+Lx01rJOL0ZhVsf4BrYu1RDSpnZdQ9lgCWOVk=;
        b=NM6CsAOhRLNhUreVArpKuy29uKtX4gWDefNi48tigzFO5Ohzru04CtXF0emchd6JRV
         WEIQ90rlYubE6oafNVO0oSM5GVXIngAEAOUWA1yvsRAdLrqm6Ev/0+2ssSm6H0BXIjp8
         RnoRZGhUIGnTo2rbq1r7YW/jzJQL5pKge2Zpp8VJUzL6AsilQzA5R6dIwUUXFfJKO6Wh
         cdUyU3dakPg0hei3j/7EB9Ja8Zfxusi1fBZozBbQKvCVwvbockE+kwNqsPx8sEhC/6am
         DJNcHNB9bX4Pjg03XGEkoW+OPkabDcjMJd5bk7MhJhcgTWxHuSvrYKWvR6Zd5gsF3W1O
         b+Qw==
X-Gm-Message-State: AOAM530dChXlS6+vNlVWPISR+CXPJ7u5qgmiX1z6UM1mQOy1y1Jc2QZ7
        keE0bUIwU9gX3sWz9sGIVamD8cxNKmLZitdkuBA=
X-Google-Smtp-Source: ABdhPJzqi3Y0rFLMOjNnGpRCeJK8EYzvGtbOVCEEW+XrAligjHV5vfUmYxuvatKdOlVN51nPEk0MMvHxJVVj2lIpCZk=
X-Received: by 2002:a25:84c1:: with SMTP id x1mr23994389ybm.690.1640020043245;
 Mon, 20 Dec 2021 09:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20211220144654.926112-1-pgwipeout@gmail.com> <trinity-c54ecce4-7a39-4143-b136-f53c9b40ffd1-1640018026851@3c-app-gmx-bap45>
 <b0d0e2ff-4282-f104-b8f5-554b059200c9@gmail.com>
In-Reply-To: <b0d0e2ff-4282-f104-b8f5-554b059200c9@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 20 Dec 2021 12:07:12 -0500
Message-ID: <CAMdYzYoYU-Avi1RK_-gHBWqiWdnxH9Pwa5nnJkU1ZewHm-1OHw@mail.gmail.com>
Subject: Re: Aw: [PATCH v3] mfd: rk808: add reboot support to rk808.c
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Lee Jones <lee.jones@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:36 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 20.12.2021 19:33, Frank Wunderlich =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hi
> >
> >> Gesendet: Montag, 20. Dezember 2021 um 15:46 Uhr
> >> Von: "Peter Geis" <pgwipeout@gmail.com>
> >> @@ -749,6 +791,9 @@ static int rk808_remove(struct i2c_client *client)
> >>      if (pm_power_off =3D=3D rk808_pm_power_off)
> >>              pm_power_off =3D NULL;
> >>
> >> +    if (of_property_read_bool(np, "rockchip,system-power-controller")=
)
> >> +            unregister_restart_handler(&rk808_restart_handler);
> >> +
> >>      return 0;
> >>  }
> >
> > this change misses a declaration
> >
> > struct device_node *np =3D client->dev.of_node;
>
> Good catch, technically the whole of_property_read_bool() could be
> dropped from rk808_remove() since unregister_restart_handler() survives
> if handler wasn't registered.

Thank you all!
