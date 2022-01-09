Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8748892F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 13:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiAIMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 07:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiAIMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 07:01:12 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA89C06173F;
        Sun,  9 Jan 2022 04:01:12 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id w22so3359555iov.3;
        Sun, 09 Jan 2022 04:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=spkLu4uIr0v4idqd3BcQfFaA/zlQoV1DfA8cSo6CIKU=;
        b=m8va4gCSJncMYbF5p4Ng95n4ZpMoZfJL1ws1RWZZA0DiCT6LWFpaLTpXCWSbNTpQkV
         ds/2kKAb2sB0sE9YSIZ8fliTk5xvsd3NaXnFpocQVSIZY/rfV5XdX+jygk8DnbAqzxQC
         eKTdQa8wJdIG1E3IUZuKa5o4EhSpmEKwYEVrL67uWmv3XssokJO9CCR0GMlKKZ6ATo3W
         oTkOsfTpSvwJwTaq4QChHt+1vFlvUIcJqefnPW2sH4eV2uCcQYZUyDML98j4Ki0f7dzO
         pi6owWZ+c2anwpYnahcp/T8xSTtJjmYTmZsEHH/EmSbQZjsty21UIiFuCX9TbOeVwmIh
         sInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=spkLu4uIr0v4idqd3BcQfFaA/zlQoV1DfA8cSo6CIKU=;
        b=O3H3zgd5FOjqShKDfwXJ7qnSKWGCD2AKHFmoZNJXmOw8aaEBL/RHihb9OqS0BxW4WE
         DWyUQfBcx3CXE1kfoT6CUZytJQ51Q2UcTypdqDA0AGzp+92rnXyzQcKOHzeO91Nn3hCK
         7lsWU19FMm2wti5Surtcrn01ovuLdIEXNCPYyoJ9cPHh7IS7nPf2fq5NJsOimD2b1E24
         cTtaO23hJClPogmOw6nmCGFPlizQQVpQA6aAWjs4aMwx+B3kgtBVQl+E/CJ2sgHnp9SB
         SW+1aoASCIaww6/dzN1iO4JeyTjj+2MPsBSR54tg9SRW3LI9XCSZHMkXaGztyPV5+c7L
         uR9A==
X-Gm-Message-State: AOAM531wX9F0DV0BF/KmrNm/xnaiP4xduIUzFOvE6rAIYNwHCzu2xRNW
        Es5Chv4dhJevv/dAwzud3qMuHDx2qJME2w37eeo=
X-Google-Smtp-Source: ABdhPJy0DMSC8QDWbRPi8FsckA21vkZbQHA/1KkLQojh2VCkH7A6aNmT1QdcnBw+wmVV81jq64FSCwx2wxNozNHc1mo=
X-Received: by 2002:a05:6638:204c:: with SMTP id t12mr32094554jaj.169.1641729671949;
 Sun, 09 Jan 2022 04:01:11 -0800 (PST)
MIME-Version: 1.0
References: <20211222124603.326920-1-alistair@alistair23.me> <37291fe7-7028-cd9e-7fde-01d13f85f0d9@sholland.org>
In-Reply-To: <37291fe7-7028-cd9e-7fde-01d13f85f0d9@sholland.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sun, 9 Jan 2022 22:00:45 +1000
Message-ID: <CAKmqyKOpO-PemwbQN-PL+miZjV1aq2zzipwMqwVXMJvH=10=Tw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add support for the Cypress cyttsp5
To:     Samuel Holland <samuel@sholland.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 3:49 PM Samuel Holland <samuel@sholland.org> wrote:
>
> Hello!
>
> On 12/22/21 6:45 AM, Alistair Francis wrote:
> > This patch series builds on top of [1] and adds support for the cyttsp5
> > touchscreen controller for the reMarkable 2.
> >
> > I first tried to add an I2C HID device. Although the cyttsp5 has some H=
ID
> > looking aspects it is not HID compatible. Just in trying to probe the d=
evice
> > I found:
> >  - The HID descriptor has extra padding
> >  - The HID descriptor sets the high bytes of the descriptor length
> >  - The HID descriptor has extra unrecognised tags
> >  - The HID reset command doesn't appear to work
> >
> > I don't think there is a way to use the I2C HID framework with the cytt=
sp5.
> > For anyone interested you can see the work here [2]. In that branch tho=
ugh I
> > can only obtain a HID descriptor, nothing else works without more core
> > changes.
> >
> > So instead I rebased the series from [1]. Converted to the new yaml DTS
> > documentation, added regulator support and fixed a x/y miscalculation b=
ug.
>
> I am working on the PineNote, which also uses a cyttsp5 touchscreen. I at=
tempted

Hey! That's great! PineNote support would be awesome

> to use the driver from this series, but I could not get it to work. I fou=
nd that
> the cyttsp5_sensing_conf_data was filled with all zeroes, so every touch =
failed
> the max_tch check. I noticed that cmd_done was being completed by empty
> responses (which explains why the response buffer was zeroes), but I got =
stuck
> after that.

Hmm... That's annoying. This series now works with the rM2 and a kobo
device, so I don't understand why it wouldn't work on the PineNote.

I just sent a v5 (sorry, I forgot to CC you) that has some code
cleanups, but I don't expect it to fix the issues you are seeing.

>
> So I looked back at the thread you linked below, and tried to implement t=
he
> workarounds described there, and those above, plus some others, and I was=
 able
> to get the touchscreen working with i2c_hid. Here are the changes I made =
to i2c_hid:
> https://github.com/smaeul/linux/commit/a1e07425a6c4
>
> In summary:
>  - Perform a 2-byte dummy read before reading the HID descriptor.
>    This is required to clear the two-byte empty message.
>  - Split command/response into multiple I2C transactions.
>    This is probably some sort of timing issue.
>    Without these first two, HID descriptor reads return "02 00".
>  - Chop 2 bytes out of the HID descriptor, as per the thread below.
>  - Similarly, chop 3 bytes out of the report descriptor.
>  - Skip the reset command, as above. Otherwise, the touchscreen
>    sends a different, short, unusable (partial?) report descriptor.

Cool! I'm impressed you got this working!

>
> I reused the the existing i2c_hid_of_goodix driver to handle toggling the=
 reset
> line, which is required. That existing binding is almost identical to the=
 one in
> this series. Here's the glue I added:
> https://github.com/smaeul/linux/commit/65d9250d3899
>
> And here is the result, from dmesg and debugfs:
> https://gist.github.com/smaeul/60b4b0f784bfff8bb8ce3ee3b4483be9
>
> So far, the quirks only appear to affect probing the device. The touchscr=
een
> works normally after that.

If the PineNote and eInk setups are different (they probably are if
this series isn't working for you) then there might be other changes
as well.

>
> What do you think of this approach? It certainly seems cleaner than parsi=
ng the
> HID reports/responses by hand. But I don't know if all of the quirks are
> acceptable for i2c_hid.

I'll leave that for an I2C HID maintainer to answer.

>
> One additional quirk that I haven't handled yet is the missing min/max fo=
r ABS_*
> axes in the report descriptor. This prevents libinput from working, but o=
ther
> evdev users appear to work fine. The driver in this series appears to get=
 that
> information from some vendor-specific command, and I am not sure where to=
 hook
> that up.

We will need that won't we? So then i2c_hid would have to implement
that as well?

Alistair

>
> Regards,
> Samuel
>
> > 1: https://lwn.net/ml/linux-kernel/20180703094309.18514-1-mylene.josser=
and@bootlin.com/
> > 2: https://github.com/alistair23/linux/commits/rM2-mainline-cyttsp5-hid
> >
> > Alistair Francis (2):
> >   ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
> >   ARM: dts: imx7d-remarkable2: Enable the cyttsp5
> >
> > Myl=C3=A8ne Josserand (2):
> >   Input: Add driver for Cypress Generation 5 touchscreen
> >   dt-bindings: input: Add Cypress TT2100 touchscreen controller
> >
> >  .../input/touchscreen/cypress,tt21000.yaml    |  92 ++
> >  arch/arm/boot/dts/imx7d-remarkable2.dts       |  89 ++
> >  arch/arm/configs/imx_v6_v7_defconfig          |   1 +
> >  drivers/input/touchscreen/Kconfig             |  14 +
> >  drivers/input/touchscreen/Makefile            |   1 +
> >  drivers/input/touchscreen/cyttsp5.c           | 922 ++++++++++++++++++
> >  6 files changed, 1119 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/cypress,tt21000.yaml
> >  create mode 100644 drivers/input/touchscreen/cyttsp5.c
> >
>
