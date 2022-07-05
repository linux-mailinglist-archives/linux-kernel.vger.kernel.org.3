Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562BF567708
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiGES7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiGES7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:59:22 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B453EBC85;
        Tue,  5 Jul 2022 11:59:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j7so17129419ybj.10;
        Tue, 05 Jul 2022 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RITSevX0Bl1HRItBqtnJRzcRK+rj+yxE1EZ6hSp76IU=;
        b=XhdHon2qRC/c5f6jgtCgzJnI2hlfBgJP2hBCoEHomuDywL/HBEq7apevBQcEIwJg+z
         A4sdUYVYWEXnEhbDnRbRdAQ03lnH0BYN5jBKG/AhExMPKwb+OULIBuHrZ4Dvf5Mq+lEB
         g1CvvdTSqkgQIenPPCPnA42s//fWplTgBmNaSSw0QSh6fp5+Ek+Q8SmVVzzUXa9trjAh
         bIzhRhDWidlcGh3tAm++WPT7ooWg8RaOGoXUMz2MmYZ/nGSJcJUVsqhLAFTDn0u4wG9C
         DKlPLTwt9pFxK6gozpZaAUmtN9pj5pehhR9h0Fn/52MP8n2BN/crlZsltLVoO9mXzcHX
         dLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RITSevX0Bl1HRItBqtnJRzcRK+rj+yxE1EZ6hSp76IU=;
        b=TGtZR7rvwEaXY6yHO912Kegt2f0Bmu4bJxCaxqeve1gBlSZU2Lvt5LRBsqU95snYbX
         OoZAjYQ5AGCBTgQTCWmqHFDnOtjPQejZ5kwZ/skSazn3kUnr6OgoQrpc/0Rop8aDf2cs
         wJyidsurYmaBWW6TZrOtSvNhYIZHKhMtNYBaECaRgDCWrOt55jy+i0Z9KLCvSt+LVwsc
         rigaY8PCdxpqllOrlfiFCu4SDcpKoMilubOVhvCBhfRUE0szNfJZbvgsTvb+HUUgrfcc
         VgOPAQc6RZQWn4Z31IwC+uhAk9qdYIyhaBWlkDKjMzeI/YcMxXbbK3ES3jVaIoz6x/Ig
         E3kQ==
X-Gm-Message-State: AJIora9DLwqNliTZvmvnpqyp4dAaya7tHDQbghnbnUsJTQixk7U9fqUC
        o0qAFNun44zwaS4OwqMGpueUk0OKNam5GJLTvH8=
X-Google-Smtp-Source: AGRyM1vGjTGKNuv0mRJYt5nbZOeQnv46n1pmwR10zlDmlZN0BRfEwrsjkXlrA9sEdj1c0J5n/IITc23L104Z8Gaob8U=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr2780234ybg.460.1657047560898; Tue, 05
 Jul 2022 11:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220705000448.14337-1-pali@kernel.org> <20220705155929.25565-1-pali@kernel.org>
 <20220705155929.25565-2-pali@kernel.org> <CAHp75Vcr6o2rm+T6Tr8sS4VXCLVHtmLPWy-njOKAvO4AcZoW=A@mail.gmail.com>
 <20220705184657.us53ciamy2oygakt@pali>
In-Reply-To: <20220705184657.us53ciamy2oygakt@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 20:58:44 +0200
Message-ID: <CAHp75VfrN5VeMwHGeiBLe_YOWNxhHN7g8QKD5SNAnsEUc826Rw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] leds: Add support for Turris 1.x LEDs
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jul 5, 2022 at 8:47 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Tuesday 05 July 2022 20:40:26 Andy Shevchenko wrote:
> > On Tue, Jul 5, 2022 at 6:11 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >
> > > This adds support for the RGB LEDs found on the front panel of the
> > > Turris 1.x routers. There are 8 RGB LEDs that are controlled by
> > > CZ.NIC CPLD firmware running on Lattice FPGA.
> > >
> > > CPLD firmware provides HW triggering mode for all LEDs except WiFi LE=
D
> > > which is automatically enabled after power on reset. LAN LEDs share H=
W
> > > registers for RGB colors settings, so it is not possible to set diffe=
rent
> > > colors for individual LAN LEDs.
> > >
> > > CZ.NIC CPLD firmware is open source and available at:
> > > https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Rout=
er_CPLD.v
> > >
> > > This driver uses the multicolor LED framework and HW led triggers.
> >
> > Pardon me, but this driver seems like 3 years old by the APIs it's
> > using... I have to say this, because I was surprised a lot to see some
> > calls.
>
> I wrote it just recently according to other omnia multicolor driver.

I see. I hope you will find my review useful then.

--=20
With Best Regards,
Andy Shevchenko
