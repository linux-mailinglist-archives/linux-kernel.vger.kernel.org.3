Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41C6534EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbiEZMJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbiEZMJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:09:45 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE21D02BB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:09:44 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-300312ba5e2so13615507b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V+5NYjifJjaEFme5WSfgc2ZxDCMHPSnFq4GwSE5vrbk=;
        b=TEbDHnWUybKO42XRLvFS6qnfUnR8icXKuSfXryV0lcrntszBNaCAn1g2BXHpoa0tI+
         tOhO3rMBFoQ2CVK4J3e3h+ADLCCmWq5OzJKkFjqsWIkdaXVwagk8OhrODFr/u4Dja9Vr
         XXbiQalm5jCbkSioIF/P6CPYBzsjffwD8zclPVCqg0cwwO4u7Nb0DJa8lDUy2lXbnQmO
         FN3/jlozAYCjOBoCIrKGdNT4rLsleK1jzG1QUfzZJZrODIMBGF0UlL5m1EgBS0FhCYQ0
         qKAGB6463+J9e4/xdEwq/mmN4fNfnH5p3kvanYoRop9FUOfmZMwWS9ZBj5HJgRctpV2L
         6jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V+5NYjifJjaEFme5WSfgc2ZxDCMHPSnFq4GwSE5vrbk=;
        b=o4PMhJQR7EQDn9TUKT6LD5D7lPySw5cPGWd3Nehy2sMeJhd7WK+FzITDLpqJQgHWEm
         3EgcbhPxq0U7Ik0mU39zVGISnkFWtUpWt91+zGq9phydEplqQ2nm4DpWZh4ORiyFphgV
         OjqVZBBfkCKG5kpCy2ZOSt6HNSvTfcvRpJ3JmiKFCDPauW2mpxyOVSxgnQ2IceAMEIeP
         jN6gvSBXBNubnlKkdHikgp/QFBDBCe2HdVDNOSQz00fey0dqRRuvVS0sAvYzVqn/q2bJ
         yvNvhl6elHX15bVuOYDfI0GSg6O6d06VIrwqElrYG/J1bBpLBCG+q+u/dlzRKNz48b0S
         pSKw==
X-Gm-Message-State: AOAM533p2m7vdB8Dj72lvkYfT9ha4QTo0HmV94GyqTf8IrPkBS9C5JG1
        CoSU3qKtTvt6JuDv6SfUrjLp8rvXAcsPI6W3eepbBYDm8n020g==
X-Google-Smtp-Source: ABdhPJzURFlGArUyE/446JHCEHPwHvY/wQFjsIX55X3z0ggoijsYJTcYMWxllVrITPaNx/39MuTESSXatIWlEB3GRQk=
X-Received: by 2002:a81:1951:0:b0:300:4a0f:13be with SMTP id
 78-20020a811951000000b003004a0f13bemr8601677ywz.133.1653566983589; Thu, 26
 May 2022 05:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
 <35f95ba3-8a7b-7918-0f9d-e14274a5ffe9@arm.com> <CAJNi4rMbBbLP2Tsv-wnnJKt4Y0moOE5-sNaZN1fCty908pwAKw@mail.gmail.com>
 <87ee0gn5rq.wl-maz@kernel.org>
In-Reply-To: <87ee0gn5rq.wl-maz@kernel.org>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Thu, 26 May 2022 20:09:32 +0800
Message-ID: <CAJNi4rOHYqL8jN5Ju3ndANc-5Te4WEc-z5YGxCN-2ZtN8vf1cQ@mail.gmail.com>
Subject: Re: Question about SPIs' interrupt trigger type restrictions
To:     Marc Zyngier <maz@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        s32@nxp.com, leoyang.li@nxp.com, catalin-dan.udma@nxp.com,
        bogdan.hamciuc@nxp.com, bogdan.folea@nxp.com,
        ciprianmarian.costea@nxp.com, radu-nicolae.pirea@nxp.com,
        ghennadi.procopciuc@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing some nxp guys for the S32G274A SOC...

On Thu, May 26, 2022 at 2:54 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 26 May 2022 04:44:41 +0100,
> richard clark <richard.xnu.clark@gmail.com> wrote:
> >
> > On Thu, May 26, 2022 at 3:14 AM Robin Murphy <robin.murphy@arm.com> wro=
te:
> > >
> > > On 2022-05-25 11:01, richard clark wrote:
> > > > Hi Marc,
> > > >
> > > > For below code snippet about SPI interrupt trigger type:
> > > >
> > > > static int gic_set_type(struct irq_data *d, unsigned int type)
> > > > {
> > > >          ...
> > > >          /* SPIs have restrictions on the supported types */
> > > >          if ((range =3D=3D SPI_RANGE || range =3D=3D ESPI_RANGE) &&
> > > >              type !=3D IRQ_TYPE_LEVEL_HIGH && type !=3D IRQ_TYPE_ED=
GE_RISING)
> > > >                  return -EINVAL;
> > > >          ...
> > > > }
> > > >
> > > > We have a device at hand whose interrupt type is SPI, Falling edge
> > > > will trigger the interrupt. But the request_irq(50, handler,
> > > > IRQ_TYPE_EDGE_FALLING, ...) will return -EINVAL.
> > > >
> > > > The question is, why must the SPI interrupt use IRQ_TYPE_EDGE_RISIN=
G
> > > > instead of IRQ_TYPE_EDGE_FALLING?
> > >
> > > Because that's what the GIC architecture[1] says. From section 1.2.1
> > > "Interrupt Types":
> > >
> > > "An interrupt that is edge-triggered has the following property:
> > >         =E2=80=A2 It is asserted on detection of a rising edge of an =
interrupt signal
> >
> > This rising edge detection is not true, it's also asserted by
> > falling edge, just like the GICD_ICFGR register says: Changing the
> > interrupt configuration between level-sensitive and *edge-triggered
> > (in either direction)* at a time when there is a pending interrupt
> > ...,
>
> Let me finish the sentence for you:
>
> <quote>
> ... will leave the interrupt in an UNKNOWN pending state.
> </quote>

Context sensitive(register-update leaves UNKNOWN pending) and

>
> and the direction here is about the configuration bit, not the edge
> direction.

with this(configuration bit: either level-sensitive or
edge-triggered), but it doesn't matter.

>
> > which has been confirmed by GIC-500 on my platform.
>
> From the GIC500 r1p1 TRM, page 2-8:
>
> <quote>
> SPIs are generated either by wire inputs or by writes to the AXI4
> slave programming interface.  The GIC-500 can support up to 960 SPIs
> corresponding to the external spi[991:32] signal. The number of SPIs
> available depends on the implemented configuration. The permitted
> values are 32-960, in steps of 32. The first SPI has an ID number of
> 32. You can configure whether each SPI is triggered on a rising edge
> or is active-HIGH level-sensitive.
> </quote>
>
> So I have no idea what you are talking about, but you definitely have
> the wrong end of the stick. Both the architecture and the
> implementations are aligned with what the GIC drivers do.

What I am talking about is - The SPI is triggered on a rising edge
only, while the falling edge is not as the document says. But I've
observed the falling edge does trigger the SPI interrupt on my
platform (the SOC is NXP S32G274A, an external wakeup signal with high
to low transition to wake up the SOC - 'Wakeup/Interrupt Rising-Edge
Event Enable Register (WIREER)' and 'Wakeup/Interrupt Falling-Edge
Event Enable Register (WIFEER)', WIFEER set 1 and WIREER  set 0
works).

I don't know why the GIC has such a behavior and what the subtle
rationale is behind this, so just mark this as a record...

Thanks

>
> If your system behaves differently, this is because something is
> inverting the signal, which is extremely common. Just describe this in
> your device tree, or lie to the kernel, whichever way you want.
>
> >
> > > and then, regardless of the state of the signal, remains asserted unt=
il
> > > the interrupt is acknowledged by software."
> > >
> > > External signals with the wrong polarity may need external logic to
> >
> > IMO, it's not wrong polarity for a device to interrupt the processor
> > with a falling edge, it's normal. Actually, the GIC supports
> > edge-trigger type:
> > '0b10 Corresponding interrupt is edge-triggered', the
> > IRQ_TYPE_EDGE_RISING check in gic_set_type(...) is just a sanity check
> > from this point of view.
>
> No, this is an architectural requirement, and the driver caters for
> the architecture (and only that).
>
> > I would more like to have below changes applied:
> >
> > --- a/linux/drivers/irqchip/irq-gic-v3.c
> > +++ b/linux/drivers/irqchip/irq-gic-v3.c
> >
> > @@ -560,8 +560,7 @@ static int gic_set_type(struct irq_data *d,
> > unsigned int type)
> >                 return type !=3D IRQ_TYPE_EDGE_RISING ? -EINVAL : 0;
> >         /* SPIs have restrictions on the supported types */
> > -       if ((range =3D=3D SPI_RANGE || range =3D=3D ESPI_RANGE) &&
> > -           type !=3D IRQ_TYPE_LEVEL_HIGH && type !=3D IRQ_TYPE_EDGE_RI=
SING)
> > +       if ((range =3D=3D SPI_RANGE || range =3D=3D ESPI_RANGE) && !(ty=
pe & 0xf))
> >                 return -EINVAL;
> >
>
> Not under my watch.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
