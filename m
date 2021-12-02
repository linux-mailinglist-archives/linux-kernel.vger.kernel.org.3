Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536864662AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346409AbhLBLtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbhLBLt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:49:28 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F2BC061757;
        Thu,  2 Dec 2021 03:46:06 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id r2so28489765ilb.10;
        Thu, 02 Dec 2021 03:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEdHF4KJKTYSiwvgeGVXr086G6djyECpBx5i6YHw3iU=;
        b=bnT2/ZSmZW4ilIAK9tc30TRKHsqopibryksSIfL58i1q6j7jg5K2lEh8EajMfKlGrY
         n49x+n17HRAWV0UCN6xrh8+gnyq2SVyTtifUqnEKyS2sUyQ+jR4J6QG0QqS4x3m9fPTb
         mHTwcBDkyahHcsMKXPX0Agtp/YYav2HTEr1iPctm2nbqn2aG8bbrv/1yZrVDTyxhkDnz
         ikhRgEIUN/YisSQmsXoX13Que4nTZH74vE3oDpUvtbmJmq0fzSPhpFmvFENz2a4BT/Wd
         IDhAWEmnFyEI1Uq7nTAcb6//56+2kHQ8iTFb8Fg8z5BHYdUr0PoLLgPsTSU1ZMpZM8LZ
         RPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEdHF4KJKTYSiwvgeGVXr086G6djyECpBx5i6YHw3iU=;
        b=AXk3UAnnto7mZWFQnBoo5/35wUk/KtVmZ3lMv2DyCO/9Rc4A1vUbyTd8FSje2isWRU
         mHua7Th7xdhp+cEldvfKO2VEJn83tOmb95vvboa43xe+c1pNUHpsTtAkkC/o5EQ8bOOE
         Rh/gzTn8aaLRFCYeb6vJ3zQ+Oy9hhxbiShbbIQFEpdFSbHV36VoHJubS75r6X58BILJC
         1CtVuh52Wntz0R3XR6P0m3D5WLkdJvI1ilOqrjqQJ4qLDJP6/ukycMYSRfPvrKv2YVlt
         +ZVA2Vbr7IZ8DM8poRdawgH2oIZulto4YwM5PmawBh+dRMy7vF3OTzAzMCO8Y22xP5EA
         uwQQ==
X-Gm-Message-State: AOAM531sG2kDNxdqaZak5D2xO5dN12hFS1emkvbY1J5MMn5Fp3dZPZyy
        Mkkp0EbES/0IfBfOFyzzTmLenbbk1YLeDGOa0U26W3fo1qfMHUZe
X-Google-Smtp-Source: ABdhPJyjmQQXr53Xjn9D+X20ISm4gu9JuXeic+JsXYnsuTloveVBDokNAuS6xg4KI8O+bXQzniqvhZUEySfuJ1cHoII=
X-Received: by 2002:a05:6e02:1b08:: with SMTP id i8mr11594764ilv.74.1638445565683;
 Thu, 02 Dec 2021 03:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20211110122948.188683-1-alistair@alistair23.me>
 <20211110122948.188683-2-alistair@alistair23.me> <20211117223950.3a7eaf7a@aktux>
 <CAKmqyKP_gQ1qSADMPwmyf-V0TqGOYf2GitzpDXsmBUO6_iqK7Q@mail.gmail.com>
 <20211125235935.5a1b7d33@aktux> <CAKmqyKO-KUhfeeOTFtMzLrZ5MUiL2-5qov-g+VYZxC_8du=ksA@mail.gmail.com>
 <20211201233559.3bc64f8b@aktux>
In-Reply-To: <20211201233559.3bc64f8b@aktux>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 2 Dec 2021 21:45:39 +1000
Message-ID: <CAKmqyKNvt=wPAKH7d1why=i43+QXpfWYbvL6qBy88NpAOmVJCA@mail.gmail.com>
Subject: Re: [PATCH v15 1/8] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>, lgirdwood@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-hwmon@vger.kernel.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 8:36 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> Hi,
>
> [...]
> > > > This is a vcom in the sense of voltage for compensation. We just
> > > > currently don't support setting the vcom.
> > > >
> > > > I had a look at the Kobo code and this is similar to
> > > > https://github.com/akemnade/linux/blob/kobo/epdc-pmic-5.15/drivers/regulator/sy7636-regulator.c#L614
> > > >
> > > > So I think that vcom is still the appropriate name for this.
> > > >
> > > seems that you did not get me. If I understand the code behind it
> > > correctly, it turns on all power rails (the +-15V stuff, VEE and so on)
> > > with the defined delays, not just vcom because it sets
> > > SY7636A_OPERATION_MODE_CRL_ONOFF. Controlling VCOM separately is possible
> > > by using SY7636A_OPERATION_MODE_CRL_VCOMCTL in combintion with a
> > > vcom_en gpio.
> > >
> > > I do not see a reason to turn on vcom only without the other higher
> > > voltage rails, so the behaviour is not necessarily wrong but if I read
> > > the binding documentation I would expect that just vcom is turned on.
> > > That is the mismatch I am talking about.
> >
> > Ah! Ok I understand. I'll rename it to vdd then.
> >
> Most important is IMHO some human-readable description in the bindings
> document.

That is what I ended up going with instead.

Alistair

>
> I am also just wondering whether this kind of logical
> regulator which turns on several other regulators is actually accepted
> or just slipped through review. I have no strong opinion here. I just
> want to be able to clean up the tps65185 driver in the same way and not
> having two similar pmics with different bindings and then a mess at the
> consumer side.
>
> Regards,
> Andreas
