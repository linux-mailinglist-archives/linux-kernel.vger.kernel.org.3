Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31495554F93
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358948AbiFVPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357795AbiFVPko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:40:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144D92EA1D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:40:43 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id n15so8225756ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NafZMYQCxpTzzA44HRDjWFQLpFRFEgWuFrU/vn1P5ls=;
        b=bIFbveGmaARo6DLnm9N7A7esU0afWho8khAtI5lMDMqriteCF6mqPo9ORENl9XeWai
         hMmWwyZP6Sr2xnhY54rB+3dbauG3bYiGw1evjrRgG5o4T/wrPvOb9l1/O9kV7fkyAjSl
         6iMdqlb2FRGMB1SfL8bR5ZH55d8rAbJMFZsC6ysVtiJ0s5xCxw6u/dynBJC6SFtxe4K3
         soEqNoDY4eVhkpzFdW4W8wWLCcU2OvlXJjr84F6FLZc74VmXVhsCbKG4LUFxqjjybclN
         E2M1kYnyZxh/NNZPpBX+8rqs9ZYUKuuCW6mXyk5g7gQExoCMM9RwIZGOua8cebxFB9pq
         B+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NafZMYQCxpTzzA44HRDjWFQLpFRFEgWuFrU/vn1P5ls=;
        b=TOxHlWs8ax0/8bn8ymoDzOJUtOStYsSrCQda98yihplda9UBVl3VYwfP172yRSXgTh
         I+geuYeEMRzMQYI8iev18Pt0RHrvi+BQ8gxSNOBIqaN4f68vYwKLZarmK1CypHqxuIJt
         Ycaiw0Z/knmIKe1RuUweVkA+thqhveX6M7HAP+4fFrTedarm2Y0T1CG576F1O07YXSzj
         EmHgVkxWBUFsUNBfTYafU994TVzwHv/I3qjIakyt6bKSOKhQnuxGBFUWuwB3Sk2Flie/
         gNgPsfFNstRD8AyWud70bfITO2QDjwRaxlUES+MI57GN85erE9b8Vmvd4FhlUjYqGwG4
         OobA==
X-Gm-Message-State: AJIora+FrTkHT9f3mx0D5+cIeCf8ryHFJDrKD30RUmsPjg6H5zwZsB/u
        sGxQykDk/ZesgAH4HTR0dpCK4VKvOW57blDhC76ipg==
X-Google-Smtp-Source: AGRyM1sPC6AtPgAR9cfWXxYUkXfDlY7ikTcaR+WHRUCnvAtzUFnpmLIjZAWSxITLcS0xEfeFJH1gMeKxmqmuLnceAaQ=
X-Received: by 2002:a2e:9581:0:b0:24f:2dc9:6275 with SMTP id
 w1-20020a2e9581000000b0024f2dc96275mr2236784ljh.486.1655912441217; Wed, 22
 Jun 2022 08:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <YrC0oKdDSjQTgUtM@lunn.ch>
 <YrC3ZKsMQK3PYKkR@smile.fi.intel.com> <YrDAMcGg1uF9m/L+@lunn.ch> <CAPv3WKeeZwNAs06thrYvgXaTPA9KP-9dQZNZsYWx3UXS8LStAQ@mail.gmail.com>
In-Reply-To: <CAPv3WKeeZwNAs06thrYvgXaTPA9KP-9dQZNZsYWx3UXS8LStAQ@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 22 Jun 2022 17:40:29 +0200
Message-ID: <CAPv3WKeYBE=ybXQw_3Hn2NoLVzO0da1ecged73=frzQKhGh6OQ@mail.gmail.com>
Subject: Re: [net-next: PATCH 00/12] ACPI support for DSA
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        upstream@semihalf.com, Jon Nettleton <jon@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

wt., 21 cze 2022 o 12:46 Marcin Wojtas <mw@semihalf.com> napisa=C5=82(a):
>
> pon., 20 cze 2022 o 20:45 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
> >
> > > You beat me up to this. I also was about to mention that the problem =
with such
> > > conversions (like this series does) is not in the code. It's simplest=
 part. The
> > > problem is bindings and how you get them to be a standard (at least d=
e facto).
> >
> > De facto is easy. Get it merged. After that, i will simply refuse
> > anything else, the same way i and other Maintainers would refuse a
> > different DT binding.
> >
> > If the ACPI committee approve and publish a binding, we will naturally
> > accept that as well. So in the end we might have two bindings. But so
> > far in this whole ACPI for networking story, i've not heard anybody
> > say they are going to submit anything for standardisation. So this
> > might be a mute point.
> >
>
> I understand your concern and of course it's better to be on a safe
> side from the beginning. Based on the hitherto discussion under this
> patchset, I would split the question about standardization to 2
> orthogonal topics:
>
> 1. Relation to the bus and enumeration:
>   * As pointed out in another patch some switches can be attached to
>     SPI or I2C. In such a case this is simple - SPISerialBus /
> I2CSerialBus structures
>     in _CRS are included in the ACPI Spec. They allow to comprise more
> bus specific
>     information and the code in acpi/scan.c marks those child devices
> as to be enumerated
>     by parent bus.
>   * MDIO bus doesn't have its own _CRS macro in the Spec, on the other
> hand the _ADR
>     seems to be the only object required for proper operation - this
> was my base for
>     proposed solution in patch 06/12.
>
> 2. The device description (unrelated to which bus it is attached)
>   * In Linux and other OS's there is a great amount of devices
> conforming the guidelines
>     and using only the standard device identification/configuration
> objects as per [1].
>   * Above do not contain custom items and entire information can be obtai=
ned by
>     existing, generic ACPI accessors - those devices (e.g. NICs,
> SD/MMC controllers and
>     many others) are not explicitly mentioned in official standards.
>   * The question, also related to this DSA case - is the ACPI device()
> hierarchical
>     structure of this kind a subject for standardization for including
> in official ACPI specification?
>   * In case not, where to document it? Is Linux' Documentation enough?
>     I agree that in the moment of merge it becomes de facto standard ABI =
and
>     it's worth to sort it out.
>
> Rafael, Len, any other ACPI expert - I would appreciate your inputs
> and clarification
> of the above. Your recommendation would be extremely helpful.
>

Thank you all for vivid discussions. As it may take some time for the
MDIOSerialBus _CRS macro review and approval, for now I plan to submit
v2 of_ -> fwnode_/device_ migration (patches 1-7,11/12) and skip
ACPI-specific additions until it is unblocked by spec extension.

Best regards,
Marcin
