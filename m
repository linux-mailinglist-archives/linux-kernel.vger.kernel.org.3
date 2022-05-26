Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB7534F23
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347242AbiEZMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbiEZMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:30:48 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3212B56F8F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:30:47 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z7so2610084ybf.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wSzupgGbJymN2DRtVZW8VXb2xMt74vbuMkhbmlvnxwU=;
        b=cQEQjyfS+5li+iYHCcdK85KAscyRoN36MOD15H2bHVH2UZpeAFlK94cuNfoyVUxgmZ
         URaLl3BKICPQco7EVZKrLP2PwEpBSgrA6JBvpn14tm5nMM4H4JAXwAxLj9qx0LRenBuA
         06Lhx4bCfxkV7m6ghOZyi3NllR/BpXac1vtzeWiVAL6MNuphUcMHhgjBcak2EiSLMoAh
         JKF5ejnHjFoXWCfHHFDE3m8g2Lr0jC53AW32OS5oUYZp2WDtfLuU6HgOThiebiDGgzEq
         SJ+EuZeVvTIVcaIpckQNJfli0fsmOtrMumPnuqcUgfGRFSFyVDWpIS8dd4WHLJDdXnlP
         CHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wSzupgGbJymN2DRtVZW8VXb2xMt74vbuMkhbmlvnxwU=;
        b=YZaMnkU0MQOWVnv6oNUgEb1nBp9df+uzkOiF2q2Bl9pc0URgVGuHKwMGmqHtAlulTW
         ghj0WoDHr+wuZINXsDu5i5YHDXqvyljYhIm5h+sNlbOzMeQp0y2Ro7mdIWf+s3yuBYoL
         RN12sc0WmApGBlDe2iptlXPHVJfAPGdZ/EUfKT/cmUeF9NWnZurr/uNxiDDpofQkG3nF
         8sXXGnZPf7HTymmSV6SLaJ2NINiLffFcfrDnawzbwGabYJBX/dmltmP4XllzqopTSX5Z
         EWwgIL0WS08EGo0LwM0o9/gSFnVudazo1ZqmIPZdau7X2TmjzAVe0hdvyFgZlJKO8Tib
         NOVw==
X-Gm-Message-State: AOAM531hr8ZxvM7F26Cgse0XCEv7OsupvObIGZeltZCnPJ7KXnpGRrkq
        iTkGlwW+mlcsKlRYUANUBLjjrlp73hBOTD7gxfDoGzIIWUny1A==
X-Google-Smtp-Source: ABdhPJxmSbICLaRV9EjgyV7YxNhxLYWsXZvLW3/s+Tyn/9Ap//fmHX1MoLbww3qsFfWpQXZpNwwU3LdlxoWpJyTF+2k=
X-Received: by 2002:a25:d917:0:b0:651:e15e:f334 with SMTP id
 q23-20020a25d917000000b00651e15ef334mr12670099ybg.510.1653568246386; Thu, 26
 May 2022 05:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
 <35f95ba3-8a7b-7918-0f9d-e14274a5ffe9@arm.com> <CAJNi4rMbBbLP2Tsv-wnnJKt4Y0moOE5-sNaZN1fCty908pwAKw@mail.gmail.com>
 <87ee0gn5rq.wl-maz@kernel.org> <5a8d5c51-ae02-a335-6768-2bedf809ab63@arm.com>
In-Reply-To: <5a8d5c51-ae02-a335-6768-2bedf809ab63@arm.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Thu, 26 May 2022 20:30:35 +0800
Message-ID: <CAJNi4rOtsfzJWsgx7CABczbf3DqqsigErf1YFw6hKOhWnACnHQ@mail.gmail.com>
Subject: Re: Question about SPIs' interrupt trigger type restrictions
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, May 26, 2022 at 4:41 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-05-26 07:54, Marc Zyngier wrote:
> > On Thu, 26 May 2022 04:44:41 +0100,
> > richard clark <richard.xnu.clark@gmail.com> wrote:
> >>
> >> On Thu, May 26, 2022 at 3:14 AM Robin Murphy <robin.murphy@arm.com> wr=
ote:
> >>>
> >>> On 2022-05-25 11:01, richard clark wrote:
> >>>> Hi Marc,
> >>>>
> >>>> For below code snippet about SPI interrupt trigger type:
> >>>>
> >>>> static int gic_set_type(struct irq_data *d, unsigned int type)
> >>>> {
> >>>>           ...
> >>>>           /* SPIs have restrictions on the supported types */
> >>>>           if ((range =3D=3D SPI_RANGE || range =3D=3D ESPI_RANGE) &&
> >>>>               type !=3D IRQ_TYPE_LEVEL_HIGH && type !=3D IRQ_TYPE_ED=
GE_RISING)
> >>>>                   return -EINVAL;
> >>>>           ...
> >>>> }
> >>>>
> >>>> We have a device at hand whose interrupt type is SPI, Falling edge
> >>>> will trigger the interrupt. But the request_irq(50, handler,
> >>>> IRQ_TYPE_EDGE_FALLING, ...) will return -EINVAL.
> >>>>
> >>>> The question is, why must the SPI interrupt use IRQ_TYPE_EDGE_RISING
> >>>> instead of IRQ_TYPE_EDGE_FALLING?
> >>>
> >>> Because that's what the GIC architecture[1] says. From section 1.2.1
> >>> "Interrupt Types":
> >>>
> >>> "An interrupt that is edge-triggered has the following property:
> >>>          =E2=80=A2 It is asserted on detection of a rising edge of an=
 interrupt signal
> >>
> >> This rising edge detection is not true, it's also asserted by
> >> falling edge, just like the GICD_ICFGR register says: Changing the
> >> interrupt configuration between level-sensitive and *edge-triggered
> >> (in either direction)* at a time when there is a pending interrupt
> >> ...,
> >
> > Let me finish the sentence for you:
> >
> > <quote>
> > ... will leave the interrupt in an UNKNOWN pending state.
> > </quote>
> >
> > and the direction here is about the configuration bit, not the edge
> > direction.
>
> Indeed it's clearly referring to either direction of *the change*, i.e.
> from edge to level and from level to edge.
>
> >> which has been confirmed by GIC-500 on my platform.
> >
> >  From the GIC500 r1p1 TRM, page 2-8:
> >
> > <quote>
> > SPIs are generated either by wire inputs or by writes to the AXI4
> > slave programming interface.  The GIC-500 can support up to 960 SPIs
> > corresponding to the external spi[991:32] signal. The number of SPIs
> > available depends on the implemented configuration. The permitted
> > values are 32-960, in steps of 32. The first SPI has an ID number of
> > 32. You can configure whether each SPI is triggered on a rising edge
> > or is active-HIGH level-sensitive.
> > </quote>
> >
> > So I have no idea what you are talking about, but you definitely have
> > the wrong end of the stick. Both the architecture and the
> > implementations are aligned with what the GIC drivers do.
> >
> > If your system behaves differently, this is because something is
> > inverting the signal, which is extremely common. Just describe this in
> > your device tree, or lie to the kernel, whichever way you want.
>
> I think the important concept to grasp here is that what we describe in
> DT is not properties of the device in isolation, but properties of its
> integration into the system as a whole. Consider the "reg" property,
> which in 99% of cases has nothing to do with the actual device it
> belongs to, but is instead describing a property of the interconnect,
> namely how its address map decodes to a particular interface, to which
> the given device happens to be attached.

I don't care about the DT at all... The essential is- does the GIC
only support rising edge detection really just as the document says,
I'm doubtful about that ;-)

>
> At the HDL level, the device block may very well have an output signal
> which idles at logic-high, and pulses low to indicate an event, however
> it only becomes an *interrupt* if it is wired up to an interrupt
> controller; on its own it's just some output signal. What the DT
> interrupt specifier describes is that wiring, *from the interrupt
> controller's point of view*. If a pulsed signal is fed into an Arm GIC
> SPI input then as an interrupt it *is* IRQ_TYPE_EDGE_RISING, because
> that's how the GIC hardware will treat it. The integration as a whole

EDGE_RISING can leave its mark in the GIC, that's the *how*, but why
EDGE_FALLING can't, any reasons to justify this behavior?
I believe that the drivers still work if the trigger type sanity check
in the GIC driver is removed.

Thanks

> takes care of the details and makes that happen, so what the logic
> levels at some arbitrary HDL boundary in the middle might be is simply
> not meaningful.
>
> Thanks,
> Robin.
