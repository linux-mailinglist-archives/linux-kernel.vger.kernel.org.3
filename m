Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6538153DB5E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 14:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245662AbiFEMDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 08:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiFEMDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 08:03:16 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7988830554
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 05:03:14 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-30fdbe7467cso84916477b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 05:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSwdtV/PVH07JigHSg97mnOtznNXZtjZyW/IYbxLV/0=;
        b=BhnMcK50biuVGP9bh6TQK14ZLbsMBFOTlgkmqqrYgBRV7bfy1aweI9b4VWfU8RRTc1
         u7hqO1dYLSg3vBzhGcQfad7HkcUR/Y/foupxT3ePcHDQ683fkvykk7U7WU0b6QGRhfmh
         ORMEhYUVbKnh6B6sSQ9JIxHrC9mqX7VLPIOZ/qr3IvpnnHlNyO5Fofn1WdCGE+rMjR3/
         wNKxynAgANtqvMeCpo+Cn4sG+YI8p+m+hUEv7pwLiINwUE3IFU3r3AgRJ78BFXAt/jnV
         OI/JgtlBHKMlgGhrntrC5Aml2hHoXCQlUsBE5vnaB6HY9Gns5U2iuy6vs/SlH4TVJ9XF
         zO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSwdtV/PVH07JigHSg97mnOtznNXZtjZyW/IYbxLV/0=;
        b=qaLzZ+NHyir88pvrtZ8V/ZOVtIr6AJR3vt89VIr/zjcKO7f1L3nhkTo637z/n3uQOc
         jnesiDBbaJFAQ7JPGWaT6wMs3XTJOOe+qK2SiNUvweWYw9qr0tkurx7EkmGLXSJBnaRY
         aoE7je03dERF3toYBPpX6kcSwHPqQEQgRbds4SbwHTJYgxxcCRuwAsDYFr30EOmL52FZ
         JakCMcI3tEt/VsFubjt8UpxqxcvqfmDjuuCmos2tHYnLpgxlkoY2RKjWR9vukNGrkclx
         XaudTpaOlTpfNLeLTUdfxexhPAcTY4TPAUQV3CinN9q/Qzhmwvq3/HxNBUAv8V/Rmq8g
         AQsA==
X-Gm-Message-State: AOAM53368+zPzU9ATXkzNkIAxNRjlwJ22sZQ0fpmbsNMmssrDMBIOdra
        KWjSasAOqtU7pKRPEu6n2YaHyrurn83DmojSrIo=
X-Google-Smtp-Source: ABdhPJzk4N+tcOYt2Qn8AmuL6gNI13b/Up1oX67mt4EPmMBEO8WC3pvNUyjQwFzg3Zv+yIISm+piqEjSm2fyIi/x4UM=
X-Received: by 2002:a0d:d689:0:b0:30c:21df:a2e7 with SMTP id
 y131-20020a0dd689000000b0030c21dfa2e7mr20498015ywd.421.1654430593704; Sun, 05
 Jun 2022 05:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
 <35f95ba3-8a7b-7918-0f9d-e14274a5ffe9@arm.com> <CAJNi4rMbBbLP2Tsv-wnnJKt4Y0moOE5-sNaZN1fCty908pwAKw@mail.gmail.com>
 <87ee0gn5rq.wl-maz@kernel.org> <CAJNi4rOHYqL8jN5Ju3ndANc-5Te4WEc-z5YGxCN-2ZtN8vf1cQ@mail.gmail.com>
 <20220530084039.7rjjbm4gkplg5747@maple.lan>
In-Reply-To: <20220530084039.7rjjbm4gkplg5747@maple.lan>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Sun, 5 Jun 2022 20:03:02 +0800
Message-ID: <CAJNi4rNBXs4mwv2dsR+DrV9Of6_eb3Wm3FAJxZsWv5LHnVmVxQ@mail.gmail.com>
Subject: Re: Question about SPIs' interrupt trigger type restrictions
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        s32@nxp.com, leoyang.li@nxp.com, catalin-dan.udma@nxp.com,
        bogdan.hamciuc@nxp.com, bogdan.folea@nxp.com,
        ciprianmarian.costea@nxp.com, radu-nicolae.pirea@nxp.com,
        ghennadi.procopciuc@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 4:40 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, May 26, 2022 at 08:09:32PM +0800, richard clark wrote:
> > CC'ing some nxp guys for the S32G274A SOC...
> >
> > On Thu, May 26, 2022 at 2:54 PM Marc Zyngier <maz@kernel.org> wrote:
> > > richard clark <richard.xnu.clark@gmail.com> wrote:
> > > > On Thu, May 26, 2022 at 3:14 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > > > On 2022-05-25 11:01, richard clark wrote:
> > > From the GIC500 r1p1 TRM, page 2-8:
> > >
> > > <quote>
> > > SPIs are generated either by wire inputs or by writes to the AXI4
> > > slave programming interface.  The GIC-500 can support up to 960 SPIs
> > > corresponding to the external spi[991:32] signal. The number of SPIs
> > > available depends on the implemented configuration. The permitted
> > > values are 32-960, in steps of 32. The first SPI has an ID number of
> > > 32. You can configure whether each SPI is triggered on a rising edge
> > > or is active-HIGH level-sensitive.
> > > </quote>
> > >
> > > So I have no idea what you are talking about, but you definitely have
> > > the wrong end of the stick. Both the architecture and the
> > > implementations are aligned with what the GIC drivers do.
> >
> > What I am talking about is - The SPI is triggered on a rising edge
> > only, while the falling edge is not as the document says. But I've
> > observed the falling edge does trigger the SPI interrupt on my
> > platform (the SOC is NXP S32G274A, an external wakeup signal with high
> > to low transition to wake up the SOC - 'Wakeup/Interrupt Rising-Edge
> > Event Enable Register (WIREER)' and 'Wakeup/Interrupt Falling-Edge
> > Event Enable Register (WIFEER)', WIFEER set 1 and WIREER  set 0
> > works).
> >
> > I don't know why the GIC has such a behavior and what the subtle
> > rationale is behind this, so just mark this as a record...
>
> Are you really describing the GIC behaviour here? It sounds like you are
> describing the behaviour of the Wakeup Unit.

Definitely it's behavior of GIC, not WKPU's

>
> The SPI that goes to the GIC is the *output* of the WKPU. However the
> registers you mention above all control edge detection at the input to
> the WKPU. If so, the kernel would need an WKPU irqchip driver in order
> to manage the trigger mode registers above (and to clear them).
>
external wakeup signal has a transition from High to Low to the SOC,
then output of
WIREER (rising detect) or WIFEER(falling detect) to generate INTID to
the GIC, you have to enable WIFEER to generate the IRQ signal to the
GIC which is also an evidence that the external wakup is falling edge.
With this clear *falling edge*, I have to write the below irq_request
code as:
request_irq(50, wkup12_interrupt, IRQ_TYPE_EDGE_RISING...)
IMO, this is very weird because the wakeup signal is falling edge from
the point of SOC/GIC side, but I have to name it as
*IRQ_TYPE_EDGE_RISING*, but it works just to pass the sanity
check(although I think which is not necessary as the fact shows)

>
> Daniel.
>
>
> PS I can't find any sign of a WKPU driver in the mainline kernel and
>    AFAICT this would make wake up sources unusable. What kernel have
>    you been running your experiments on?

5.10.44- BSP code from NXP:
https://source.codeaurora.org/external/autobsps32/linux
