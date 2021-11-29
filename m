Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B35461595
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhK2M7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhK2M5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:57:01 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6E8C08EB19;
        Mon, 29 Nov 2021 03:42:14 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id c3so21024818iob.6;
        Mon, 29 Nov 2021 03:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DiEIPxwmtabywojLIKrpLmvgw45b4iTNiO5soeMU6o=;
        b=RlrcsJqmeIn1gVO9rhY2FMWwJ6HFT9bGSa6QJMg3W1zfgG3X6N29gUWBNoiRhMzR0H
         OhxEEURqen1meCgpx2+/tCguWIy4qmdt6nLdr3k1jZ5KEgH9MuW3/WcQ9kUDWjL0Z5Vb
         LZTRTNWJ+vw20DB/YX/DRkdCIctfmF+FBK19dKA4OOPAby5NuHOYnx3M2bPHMOxOoy8l
         zeiPZPJelHREyqMNKB3VaUxahunobi9K/DleK4ipxolWqBpmCqDq1KgDE+CnhUnDjnrT
         0Jq2Si7jcZBqaDE6WJ2P0wdTy4+Q/SQ3I2PP0MlrLorcL+mdD+MSAYdfTwx5jxcJJ+lY
         O4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DiEIPxwmtabywojLIKrpLmvgw45b4iTNiO5soeMU6o=;
        b=sl07i1fD/WILNa7wDek/oTz7/tLb/vGptzxtwWlmsp69ruAiYbnrfCKPx03IpMhVnd
         vuRHeYteMiQdFRc/hmMMlSWEVfSrodjXEQTQkycjHjnuK8PvnhfRY5sOopZScqIRP33n
         cCCawonJyJVfqC9NBx+oDP+QKhysxeInyHsN24wPHyEQhBeRUm8eXLS4WdtyNc1xVE51
         uU0OI5vgFH5ZrNOhyMSseMzFh2Rt4kWLtT3SCq28pRd89y7SrGTsD0Ha5iA6MJOa8Qzs
         oZK1VJTzO2lwUtxpKKiqgNbuMWD8ZHda5FT7Sif522zX+ghGU7laZarR5+PltFkQlALN
         WOtw==
X-Gm-Message-State: AOAM532mbBopolcuKUPgEMtEZDi6GNpctUgrp3M8twf7NHYtP7Pahfw/
        LiSmCk4Z1ifMQxixnBtYV4QrI856NkpMy/FXHwY=
X-Google-Smtp-Source: ABdhPJxUPnrzd1fIgp0bQ0VcnIBdfu3Q8Kiyx+t/gkTv/ZX6M6t1J/JoW5a+5GXuOUyQJxaAnegpzFE5xO9ojxakKpk=
X-Received: by 2002:a05:6638:32a2:: with SMTP id f34mr62596399jav.63.1638186134216;
 Mon, 29 Nov 2021 03:42:14 -0800 (PST)
MIME-Version: 1.0
References: <20211110122948.188683-1-alistair@alistair23.me>
 <20211110122948.188683-2-alistair@alistair23.me> <20211117223950.3a7eaf7a@aktux>
 <CAKmqyKP_gQ1qSADMPwmyf-V0TqGOYf2GitzpDXsmBUO6_iqK7Q@mail.gmail.com> <20211125235935.5a1b7d33@aktux>
In-Reply-To: <20211125235935.5a1b7d33@aktux>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 29 Nov 2021 21:41:48 +1000
Message-ID: <CAKmqyKO-KUhfeeOTFtMzLrZ5MUiL2-5qov-g+VYZxC_8du=ksA@mail.gmail.com>
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

On Fri, Nov 26, 2021 at 8:59 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> On Tue, 23 Nov 2021 23:29:26 +1000
> Alistair Francis <alistair23@gmail.com> wrote:
>
> > On Thu, Nov 18, 2021 at 7:40 AM Andreas Kemnade <andreas@kemnade.info> wrote:
> > >
> > > On Wed, 10 Nov 2021 22:29:41 +1000
> > > Alistair Francis <alistair@alistair23.me> wrote:
> > >
> > > > Initial support for the Silergy SY7636A Power Management chip
> > > > and regulator.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  .../bindings/mfd/silergy,sy7636a.yaml         | 79 +++++++++++++++++++
> > > >  1 file changed, 79 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> > > > new file mode 100644
> > > > index 000000000000..0566f9498e2f
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> > > [...]
> > > > +  regulators:
> > > > +    type: object
> > > > +
> > > > +    properties:
> > > > +      compatible:
> > > > +        const: silergy,sy7636a-regulator
> > > > +
> > > > +      vcom:
> > > > +        type: object
> > > > +        $ref: /schemas/regulator/regulator.yaml#
> > > > +        properties:
> > > > +          regulator-name:
> > > > +            const: vcom
> > > > +
> > > hmm, this is what? If I understand it correctly, vcom means some
> > > voltage for compensation. On other comparable pmics (e.g. TPS65185
> > > which has also a sane public datasheet, MAX17135) I have seen some
> > > methods to measure a voltage while the display is doing something
> > > defined and then program this voltage non-volatile for compensation
> > > during manufacturing.
> > >
> > > If I understand the code correctly all the bunch of voltages are
> > > powered up if this one is enabled.
> > > So at least a description should be suitable.
> > >
> > > The other comparable PMICs have at least regulators named VCOM, DISPLAY
> > > (controls several regulators, started with delays configured via
> > > registers) and V3P3. MAX17135 source can be found in NXP kernels,
> > > TPS65185 in Kobo vendor kernels.
> > >
> > > So I would expect to see something similar here and a description or at
> > > least not such a misleading name as vcom if it is for some reason not
> > > feasible to separate the regulators.
> >
> > This is a vcom in the sense of voltage for compensation. We just
> > currently don't support setting the vcom.
> >
> > I had a look at the Kobo code and this is similar to
> > https://github.com/akemnade/linux/blob/kobo/epdc-pmic-5.15/drivers/regulator/sy7636-regulator.c#L614
> >
> > So I think that vcom is still the appropriate name for this.
> >
> seems that you did not get me. If I understand the code behind it
> correctly, it turns on all power rails (the +-15V stuff, VEE and so on)
> with the defined delays, not just vcom because it sets
> SY7636A_OPERATION_MODE_CRL_ONOFF. Controlling VCOM separately is possible
> by using SY7636A_OPERATION_MODE_CRL_VCOMCTL in combintion with a
> vcom_en gpio.
>
> I do not see a reason to turn on vcom only without the other higher
> voltage rails, so the behaviour is not necessarily wrong but if I read
> the binding documentation I would expect that just vcom is turned on.
> That is the mismatch I am talking about.

Ah! Ok I understand. I'll rename it to vdd then.

Alistair

>
> If we agree on this idea that one regulator is enabling everything, I
> would adapt my EPDC drm driver and tps65185 driver (which are both in
> my clean up to be upstreamable-queue).
>
> Just another thing to compare with:
> https://github.com/Freescale/linux-fslc/blob/4.1-2.0.x-imx/drivers/regulator/max17135-regulator.c
> that seems to be the starting point for kobo vendor kernel epd pmics.
> They seem to have taken the source and modified things. There we have
> regulators with empty ops for that step-up converted stuff, a separate
> vcom and a display regulator which really controls all of these step-up
> things.
>
> Regards,
> Andreas
