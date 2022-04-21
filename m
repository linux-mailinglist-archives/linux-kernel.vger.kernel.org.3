Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E70509545
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 05:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383880AbiDUDSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiDUDSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:18:20 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885E612624
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:15:31 -0700 (PDT)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 55AF63F1CB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650510930;
        bh=+0+ClhRdXLW2hubvbQ5IqxsH3L1dNDpzr8HWzYvayno=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=AsaG12bQ+e6oRGEpgrY/SgqM209USc2Vb+tA3cJZGOtFJ/BHDFTqMzklcraSrUwD9
         Y9MAiesdL/DJPI3sDfuNDjlsJXOqqYIGBl38AQo6iO1qLAVmwOw6BHB1v5hncaWuiz
         EilKwoc1xgZ+FCl7jHgyvzOS80Ny6NHqoCFpcawt0a+FcMdcsTTyARejpDKiKCLIUq
         at5VUvTDpvBkLBfDRSyrAKx6ezrUDW/sJwvX+MGN0OjbpfThQh7rj01HaXuFjBbqn4
         DUtxqhGA6Mh1hdcnIXGi+b+edS4JgXwD8ftadGcJruCrezbAXOcBpYccOc/J0tRnVH
         hAoE56bXw7tjw==
Received: by mail-ot1-f69.google.com with SMTP id l7-20020a9d7087000000b006054ab271e0so1217784otj.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0+ClhRdXLW2hubvbQ5IqxsH3L1dNDpzr8HWzYvayno=;
        b=zXMjrMWMUUubdDtfT0KNl6gCYcZRzVV8dosgTqOhsYxqDI7wPevYbMCe1zXD5L3Y2O
         hNpL/5stJE6vDF+PqK9ZzEkLU6gEhiif+jasA3PsU7M2wDKNrxo6xjwGgtLvtsRlKi/0
         wHGLjro8CR8j5p653JT1sb1azVtWE3uUOp13uEe8M78O8O4Ublk0ZeIm4ggXUfWtTZ4/
         8ugK6s0ryiuIZacwotjzhW+rHAQqiT3E0sWAdkTs5Uk+50R9RVD1vIZ0cihJpikXvw3u
         RI9m22KtizvyYXgns6esTKFFT0M0tTcxPf0q3WRuBJ8BEbrOUKzcsFfpgY5eSyTLfNr2
         iKUA==
X-Gm-Message-State: AOAM5313M5KAEBTheXh5JQLPCSfZ/+ue3rwKAAq0GiwTpWZRtjlxVnRd
        /K2pgfNriDgRH9eDUNrfRFo7hWN8geQY4M0vAvOjtHWZ2VPFdASTWNcVG8KlxsOl9mfBm8/xOiK
        05otPN1CoBTKK92yiN0JBCIiMFMyM6IpO0JKbPLbIzjbGhcNJv4yMt2aRgw==
X-Received: by 2002:a05:6808:150f:b0:322:b58e:25df with SMTP id u15-20020a056808150f00b00322b58e25dfmr3077827oiw.198.1650510928632;
        Wed, 20 Apr 2022 20:15:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhg3+9T4s/rWh8JvLvAFuz/WcHkgn1DBqBbpYUDx/b04IET96QLHj9ebsB+xczCwrVG2jEeAd05jataomGc78=
X-Received: by 2002:a05:6808:150f:b0:322:b58e:25df with SMTP id
 u15-20020a056808150f00b00322b58e25dfmr3077818oiw.198.1650510928399; Wed, 20
 Apr 2022 20:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220420124053.853891-1-kai.heng.feng@canonical.com>
 <20220420124053.853891-3-kai.heng.feng@canonical.com> <YmAEDbJJU1hLNSY1@lunn.ch>
In-Reply-To: <YmAEDbJJU1hLNSY1@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 21 Apr 2022 11:15:16 +0800
Message-ID: <CAAd53p5XC1BF2Tp7C9-BKdHTz68S0ZcsMgR4bRTzaptGoO0T0Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] net: mdio: Add "use-firmware-led" firmware property
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 9:01 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Apr 20, 2022 at 08:40:49PM +0800, Kai-Heng Feng wrote:
> > Some system may prefer preset PHY LED setting instead of the one
> > hardcoded in the PHY driver, so adding a new firmware
> > property, "use-firmware-led", to cope with that.
> >
> > On ACPI based system the ASL looks like this:
> >
> >     Scope (_SB.PC00.OTN0)
> >     {
> >         Device (PHY0)
> >         {
> >             Name (_ADR, One)  // _ADR: Address
> >             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
> >             {
> >                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
> >                 Package (0x01)
> >                 {
> >                     Package (0x02)
> >                     {
> >                         "use-firmware-led",
> >                         One
> >                     }
> >                 }
> >             })
> >         }
> >
> >         Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
> >         {
> >             ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
> >             Package (0x01)
> >             {
> >                 Package (0x02)
> >                 {
> >                     "phy-handle",
> >                     PHY0
> >                 }
> >             }
> >         })
> >     }
> >
> > Basically use the "phy-handle" reference to read the "use-firmware-led"
> > boolean.
>
> Please update Documentation/firmware-guide/acpi/dsd/phy.rst
>
> Please also Cc: the ACPI list. I have no idea what the naming
> convention is for ACPI properties.
>
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/net/mdio/fwnode_mdio.c | 4 ++++
> >  include/linux/phy.h            | 1 +
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
> > index 1c1584fca6327..bfca67b42164b 100644
> > --- a/drivers/net/mdio/fwnode_mdio.c
> > +++ b/drivers/net/mdio/fwnode_mdio.c
> > @@ -144,6 +144,10 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
> >        */
> >       if (mii_ts)
> >               phy->mii_ts = mii_ts;
> > +
> > +     phy->use_firmware_led =
> > +             fwnode_property_read_bool(child, "use-firmware-led");
> > +
>
> This is an ACPI only property. It is not valid in DT. It does not
> fulfil the DT naming requirement etc. So please move this up inside
> the if (is_acpi_node(child)) clause.
>
> > diff --git a/include/linux/phy.h b/include/linux/phy.h
> > index 36ca2b5c22533..53e693b3430ec 100644
> > --- a/include/linux/phy.h
> > +++ b/include/linux/phy.h
> > @@ -656,6 +656,7 @@ struct phy_device {
> >       /* Energy efficient ethernet modes which should be prohibited */
> >       u32 eee_broken_modes;
> >
> > +     bool use_firmware_led;
>
> There is probably a two byte hole after mdix_ctrl. So please consider
> adding it there. Also, don't forget to update the documentation.

OK, will do once other concerns are ironed out.

Kai-Heng

>
>        Andrew
