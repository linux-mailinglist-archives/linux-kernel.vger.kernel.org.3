Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D99554885
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357182AbiFVJKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357155AbiFVJJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:09:48 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316693982A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:08:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a11so9765717ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zwKGgI8hUtI5va3wPSJUOFhw3ATUoJSW/f2ATiDG5G8=;
        b=rC3FBYLiX6fFBi3tbH92J9KqPuX18ZzM5T8F13vXIgHu3hsGX37Z03/fxQylAI6yfA
         MQTCWxqUpfSIRR4FO6BjxmvHCrYalH60w96MIwV4KvKGe/+B6pUczm0B7GMoU/NWAi4x
         yvqBf0JNCu8CwmKXRFFKsUPymQw7O4YY+aZAOuZuIZECeZUUIv4CJ8kKMA88SresY7nM
         7yuw2v97f29OQR42dKHO8Sdd9aAOjbZr/Rpc+CqiOgyue3Tc3evAH+U5aeFCEiVZX4m/
         umuY20P2RQDQN3eClcw8KSZm9HIWxAYN0lrZHjZOxUGVjxOEcYMJTJxiOIeRA1K+eI8L
         PGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zwKGgI8hUtI5va3wPSJUOFhw3ATUoJSW/f2ATiDG5G8=;
        b=2e4DNlsJ4sHEu/EuTwnfMXIThY0197aX83C8G0w0AVoJHWVEsMPYTTuiL3JAVPCiJo
         jh5eegr2mYVcLdZT+u7Ld4BuTYmYmLrqMWITTcH9oWW4MFerX+cJxH9KXxgXkprbr2UU
         m4gfUzB+IYg0qxPyOZ1ortbzUNAcNDt/SQtQTrJYDgHVjBzIp0D+raHt2yMp72AaYJFS
         wd4Z6Eo7ygMzRBLew3JuPHzFEcBpEBNsi+FYJqKSFHFOAOtPe5k5Sy7wQoGrBXor3RXu
         ajXCh+mJH94aZOi8+cT1qYRCqEXP1vFi6q3yFgXGaOZs3+SlygZ3KPUjkWaVhRNNZBFM
         94pA==
X-Gm-Message-State: AJIora8fEXw8anMPDaqXq2GPKfkMo7bBjOtFaLwJ7CYeM8WOC2UiRZN3
        T8nwvbzW1hEf4ojHD+7QcjEVF7atYgUN1NaaU6Re7A==
X-Google-Smtp-Source: AGRyM1uLAehIaM0118d07ZGVTcBN+8vUVlSuyEVYaYw4d4OUB3fyoJlWcBYQgw73vlkC4qLxOnnh+IXMEGFbdQtYokw=
X-Received: by 2002:a2e:bf05:0:b0:247:b233:cfba with SMTP id
 c5-20020a2ebf05000000b00247b233cfbamr1255843ljr.131.1655888905245; Wed, 22
 Jun 2022 02:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-10-mw@semihalf.com>
 <YrDO05TMK8SVgnBP@lunn.ch> <YrGm2jmR7ijHyQjJ@smile.fi.intel.com>
 <YrGpDgtm4rPkMwnl@lunn.ch> <YrGukfw4uiQz0NpW@smile.fi.intel.com>
In-Reply-To: <YrGukfw4uiQz0NpW@smile.fi.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 22 Jun 2022 11:08:13 +0200
Message-ID: <CAPv3WKf_2QYh0F2LEr1DeErvnMeQqT0M5t40ROP2G6HSUwKpQQ@mail.gmail.com>
Subject: Re: [net-next: PATCH 09/12] Documentation: ACPI: DSD: introduce DSA description
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, vivien.didelot@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 21 cze 2022 o 13:42 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Tue, Jun 21, 2022 at 01:18:38PM +0200, Andrew Lunn wrote:
> > On Tue, Jun 21, 2022 at 02:09:14PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jun 20, 2022 at 09:47:31PM +0200, Andrew Lunn wrote:
>
> ...
>
> > > > > +        Name (_CRS, ResourceTemplate ()
> > > > > +        {
> > > > > +            Memory32Fixed (ReadWrite,
> > > > > +                0xf212a200,
> > > > > +                0x00000010,
> > > >
> > > > What do these magic numbers mean?
> > >
> > > Address + Length, it's all described in the ACPI specification.
> >
> > The address+plus length of what? This device is on an MDIO bus. As
> > such, there is no memory! It probably makes sense to somebody who
> > knows ACPI, but to me i have no idea what it means.
>
> I see what you mean. Honestly I dunno what the device this description is=
 for.
> For the DSA that's behind MDIO bus? Then it's definitely makes no sense a=
nd
> MDIOSerialBus() resources type is what would be good to have in ACPI
> specification.
>

It's not device on MDIO bus, but the MDIO controller's register itself
(this _CSR belongs to the parent, subnodes do not refer to it in any
way). The child device requires only _ADR (or whatever else is needed
for the case the DSA device is attached to SPI/I2C controllers).

Best regards,
Marcin
