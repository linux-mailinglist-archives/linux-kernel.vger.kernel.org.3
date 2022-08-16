Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC6A595C37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiHPMrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiHPMqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:46:50 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9BF96755;
        Tue, 16 Aug 2022 05:45:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id n21so7974823qkk.3;
        Tue, 16 Aug 2022 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=njAgXoeN0q74J/t5k+W3cZytsvg61wczGG4TqtpRL6Y=;
        b=ivQsqAixASfGTTKVqpfwwPTx0IdAp2EKUY9VklxJCSR2w/HSeYVJeVGfpuwvkkCAP4
         0WLHtdGLi7ARZs1Jm0JkLD+JY+alxbMXCNUDbrYGfpGlPVX2N50jb9LyZ+iE0pTdkyvn
         a7+ktKxW7QR4VIe8GW1dYSUyDD1xnQJGFWO32UfI7lZILvZfPLiPK0NbqFzYKbcXl1ib
         dLvge1zTFApDxQ/dhz3pnwXh9NXoH8zhNdruSdKzy0Jxha5SeE66gsFAyZLYW5YSTERO
         grFcP5v/j4iwBNKI0ERF1z3tuFlTWmu/TybZNPtHrl5avz/NN8PoNYAlLq2F3+a2rbjv
         j0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=njAgXoeN0q74J/t5k+W3cZytsvg61wczGG4TqtpRL6Y=;
        b=nLXJmDLnDtWgYF8qbWqz6Qd/v13G4UUCMp3Ypy7cNq5MSE9M5QNQP6z19mZQOEbrxz
         33ijUv6PC9Qp/Qm5U2fRFr1gchc3NG2zKFhXNpOu8LdfEpNOdDc/8nT21gCGGn3BlFvc
         7FkXkKYyWX79frbqw3t571IzY+6BKvd/mSI41qL5gGrCoAhlgo1jnXV0ssvVfB1p5h7j
         fpgEmD1J/5QtWS/A08Jh9+IddUEla8oUxVkAGZDabEzOKF7cMXPjaHAtMFNAwyhTk2VU
         hrIao4ltuYIDRbwmKo+bvG6Gzz/d9HTW6b5Ogj6MhY61K8tApxkdNQcQyq4m+BfLlwiX
         ovZA==
X-Gm-Message-State: ACgBeo0R+gth52Y5u+WwAhGE89zNmwgOIWY8JjewSDUIaODF4SxyP+fu
        aS/4jIv7FlWZlgYGLE+U45kIaj7sR3hP1l7SdCw=
X-Google-Smtp-Source: AA6agR4TYBgQ15J+DOcaVsDz/M4pT2ebGDHkXb6zul3WJjesJGQMsC1/NKvJf5zU/8gjSE/t9NQAVz6vogt/akuLBAI=
X-Received: by 2002:a05:620a:2901:b0:6bb:692b:1991 with SMTP id
 m1-20020a05620a290100b006bb692b1991mr1243555qkp.522.1660653918387; Tue, 16
 Aug 2022 05:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220624195112.894916-1-robimarko@gmail.com> <87edyq1ujr.wl-maz@kernel.org>
 <20220712124445.GC21746@workstation> <87czea1i2f.wl-maz@kernel.org>
 <CAOX2RU5RX+H=omuKGye2fBy9dOFmfC9HC_3pekeGMxDJuReCUw@mail.gmail.com>
 <d8912a0d811b5eb924b8c4136b099f72@kernel.org> <CAOX2RU4MpyEQ0RtcrZ07VXRbB+SWWU=1zWfYUXhQFtvh=MCiDw@mail.gmail.com>
 <20220719074751.GA25065@thinkpad>
In-Reply-To: <20220719074751.GA25065@thinkpad>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 16 Aug 2022 14:45:07 +0200
Message-ID: <CAOX2RU525OYLBb+Nek==84KA4a42ZTz89tgdMcgBCu=K8VzL9Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: make the irqchip immutable
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, 19 Jul 2022 at 09:47, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Jul 13, 2022 at 02:33:32PM +0200, Robert Marko wrote:
> > On Wed, 13 Jul 2022 at 13:47, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On 2022-07-13 12:08, Robert Marko wrote:
> > > > On Tue, 12 Jul 2022 at 17:12, Marc Zyngier <maz@kernel.org> wrote:
> > > >>
> > > >> On Tue, 12 Jul 2022 13:44:45 +0100,
> > > >> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > > >> >
> > > >> > On Tue, Jul 12, 2022 at 11:42:32AM +0100, Marc Zyngier wrote:
> > > >> > > On Fri, 24 Jun 2022 20:51:12 +0100,
> > > >> > > Robert Marko <robimarko@gmail.com> wrote:
> > > >> > > >
> > > >> > > > Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marke=
d as
> > > >> > > > immutable") added a warning to indicate if the gpiolib is al=
tering the
> > > >> > > > internals of irqchips.
> > > >> > > >
> > > >> > > > Following this change the following warning is now observed =
for the SPMI
> > > >> > > > PMIC pinctrl driver:
> > > >> > > > gpio gpiochip1: (200f000.spmi:pmic@0:gpio@c000): not an immu=
table chip, please consider fixing it!
> > > >> > > >
> > > >> > > > Fix this by making the irqchip in the SPMI PMIC pinctrl driv=
er immutable.
> > > >> > > >
> > > >> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > >> > > > ---
> > > >> > > >  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 22 ++++++++++++-=
---------
> > > >> > > >  1 file changed, 12 insertions(+), 10 deletions(-)
> > > >> > > >
> > > >> > > > diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/driv=
ers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > > >> > > > index c3255b0bece4..406ee0933d0b 100644
> > > >> > > > --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > > >> > > > +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > > >> > > > @@ -171,7 +171,6 @@ struct pmic_gpio_state {
> > > >> > > >   struct regmap   *map;
> > > >> > > >   struct pinctrl_dev *ctrl;
> > > >> > > >   struct gpio_chip chip;
> > > >> > > > - struct irq_chip irq;
> > > >> > > >   u8 usid;
> > > >> > > >   u8 pid_base;
> > > >> > > >  };
> > > >> > > > @@ -988,6 +987,17 @@ static void *pmic_gpio_populate_parent_=
fwspec(struct gpio_chip *chip,
> > > >> > > >   return fwspec;
> > > >> > > >  }
> > > >> > > >
> > > >> > > > +static const struct irq_chip spmi_gpio_irq_chip =3D {
> > > >> > > > + .name           =3D "spmi-gpio",
> > > >> > > > + .irq_ack        =3D irq_chip_ack_parent,
> > > >> > > > + .irq_mask       =3D irq_chip_mask_parent,
> > > >> > > > + .irq_unmask     =3D irq_chip_unmask_parent,
> > > >> > >
> > > >> > > No, this is wrong. Please look at the documentation to see how=
 you
> > > >> > > must now directly call into the gpiolib helpers for these two
> > > >> > > callbacks.
> > > >> > >
> > > >> >
> > > >> > IIUC, you are referring to gpiochip_disable_irq() and
> > > >> > gpiochip_enable_irq() APIs.
> > > >>
> > > >> I am indeed.
> > > >>
> > > >> > These APIs are supposed to let the gpiolib know about that the I=
RQ
> > > >> > usage of these GPIOs. But for the case of hierarchial IRQ domain=
,
> > > >> > isn't the parent is going to do that?
> > > >>
> > > >> Why would it? The parent has no clue about what sits above it. In =
a
> > > >> hierarchical configuration, each level is responsible for its own
> > > >> level, and the GPIO layer should be responsible for its own
> > > >> management.
> > > >>
> > > >> > Please correct me if I'm wrong.
> > > >>
> > > >> I'm afraid you are, and this patch is a fairly obvious change in
> > > >> behaviour, as the callbacks you mention above are not called anymo=
re,
> > > >> while they were before.
> > > >>
> > > >> If they are not necessary (for reasons I can't fathom), then this
> > > >> should be clearly explained.
> > > >
> > > > Hi Marc,
> > > > I will look at IRQ GPIO docs, but in this case, then we have more
> > > > conversions that
> > > > are not correct.
> > >
> > > Then please point them out.
> >
> > Oh, now I get the issue, I was misunderstanding it completely.
> > gpiochip_enable_irq and gpiochip_disable_irq are not being called
> > at all.
> >
> > However, I dont see them being called before the conversion as well.
> > I am not really familiar with the PMIC IRQ-s, looked like an easy conve=
rsion
> > to get rid of the warning.
> >
> > Manivannan can you shed some light on this?
> >
>
> I hope you got the answer by now. When I looked into the conversion I saw=
 that
> there were missing calls to gpiochip_{enable/disable}_irq APIs. But at th=
at
> time I blindly assumed (yeah very bad of myself) that the parent irqchip =
will
> handle that :(
>
> Anyway, you should call these helpers from the mask/unmask callbacks as a=
 part
> of the conversion patch. Let me know if you are onto it or not!

Hi, I completely missed your reply.
Currently, I am pretty swamped with other work so I dont know when
will I be able
to look into this again.

Regards,
Robert
>
> Thanks,
> Mani
>
> > Regards,
> > Robert
> >
> >
> >
> >
> >
> > >
> > >          M.
> > > --
> > > Jazz is not dead. It just smells funny...
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
