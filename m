Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBEA5AC0D3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiICSk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiICSkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:40:20 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796EF1A802;
        Sat,  3 Sep 2022 11:40:17 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-344fc86d87cso27377477b3.3;
        Sat, 03 Sep 2022 11:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=T1/52acLzPH3fpYJ42n+mkhnZLrM5YDLaNq5+3CgHSI=;
        b=xQ//ZkXVI4Fz0UPYUDhhm6EwXb/+6VCMW4xQJRc8whheAzQmFFf3N6bev4hFj6Cnrt
         2J1KAXI/LfdH1Rz4LnSwfiNtp0HUjSdq3y801G2HHFV7Qrsof/R7AVyYX+oMrzjoSpOS
         TMeMszg1ZMFIkiez8ZfTGgJDXrTJs3lvG2wSgo+ON9/jYteIdyfY225TmN93AFJctngi
         B0r2pQHEG0WjsFSIjSa/xQktYleEDcDu0F3p1OxD6aXeZRJBB1dXH6cSU+xvABG9x0gS
         fpgwasmOoswPuC0liZo7FnG8Ok0XNLUGaclcsgYadMuFjZ/jjv4o99txB34d8VEAc+mA
         2jug==
X-Gm-Message-State: ACgBeo2VReVWeq6geeDSuNFGZTbmi1EGolEygyO7mEZQjOvBzu8seFAf
        zzbMmQ66Qyb1bFOgQXcV8WxbJ9Z5mRoh02pkC9w=
X-Google-Smtp-Source: AA6agR7CujmcoTp0MTGrl5SwCHLmkkm7/pH0C663H6K9zq5b+i3WV8/i04haCcENfbsLI2j61ox4Or9HrsZ8DVxvjeE=
X-Received: by 2002:a0d:c841:0:b0:33d:bf96:f823 with SMTP id
 k62-20020a0dc841000000b0033dbf96f823mr31304559ywd.326.1662230416723; Sat, 03
 Sep 2022 11:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220826151457.7c13a407@endymion.delvare> <CAHp75VdBv4EkDgTwHSxNhA91b8FMwaMvvoeWZOaxJVcvwRQ4vg@mail.gmail.com>
In-Reply-To: <CAHp75VdBv4EkDgTwHSxNhA91b8FMwaMvvoeWZOaxJVcvwRQ4vg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:40:04 +0200
Message-ID: <CAJZ5v0hhnaZ4WaduU1x8y3oCWLQt3UPFhuFSqZU14+K99bkAHg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: docs: enumeration: Fix a few typos and wording mistakes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jean Delvare <jdelvare@suse.de>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 5:31 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Aug 26, 2022 at 4:14 PM Jean Delvare <jdelvare@suse.de> wrote:
> >
> > "sturct" -> "struct"
> > "similar than with" -> "similar to"
> > Missing comma, "it" and "to"
>
> Makes sense to me, thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > ---
> >  Documentation/firmware-guide/acpi/enumeration.rst |   16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > --- linux-5.19.orig/Documentation/firmware-guide/acpi/enumeration.rst   2022-08-26 12:46:35.307949217 +0200
> > +++ linux-5.19/Documentation/firmware-guide/acpi/enumeration.rst        2022-08-26 15:02:50.245981296 +0200
> > @@ -21,7 +21,7 @@ In order to support this and re-use the
> >    - Devices behind real busses where there is a connector resource
> >      are represented as struct spi_device or struct i2c_device. Note
> >      that standard UARTs are not busses so there is no struct uart_device,
> > -    although some of them may be represented by sturct serdev_device.
> > +    although some of them may be represented by struct serdev_device.
> >
> >  As both ACPI and Device Tree represent a tree of devices (and their
> >  resources) this implementation follows the Device Tree way as much as
> > @@ -205,7 +205,7 @@ enumerated once spi_register_master() is
> >                 }
> >                 ...
> >
> > -The SPI device drivers only need to add ACPI IDs in a similar way than with
> > +The SPI device drivers only need to add ACPI IDs in a similar way to
> >  the platform device drivers. Below is an example where we add ACPI support
> >  to at25 SPI eeprom driver (this is meant for the above ACPI snippet)::
> >
> > @@ -362,7 +362,7 @@ These GPIO numbers are controller relati
> >  specifies the path to the controller. In order to use these GPIOs in Linux
> >  we need to translate them to the corresponding Linux GPIO descriptors.
> >
> > -There is a standard GPIO API for that and is documented in
> > +There is a standard GPIO API for that and it is documented in
> >  Documentation/admin-guide/gpio/.
> >
> >  In the above example we can get the corresponding two GPIO descriptors with
> > @@ -538,8 +538,8 @@ information.
> >  PCI hierarchy representation
> >  ============================
> >
> > -Sometimes could be useful to enumerate a PCI device, knowing its position on the
> > -PCI bus.
> > +Sometimes it could be useful to enumerate a PCI device, knowing its position on
> > +the PCI bus.
> >
> >  For example, some systems use PCI devices soldered directly on the mother board,
> >  in a fixed position (ethernet, Wi-Fi, serial ports, etc.). In this conditions it
> > @@ -550,7 +550,7 @@ To identify a PCI device, a complete hie
> >  the chipset root port to the final device, through all the intermediate
> >  bridges/switches of the board.
> >
> > -For example, let us assume to have a system with a PCIe serial port, an
> > +For example, let's assume we have a system with a PCIe serial port, an
> >  Exar XR17V3521, soldered on the main board. This UART chip also includes
> >  16 GPIOs and we want to add the property ``gpio-line-names`` [1] to these pins.
> >  In this case, the ``lspci`` output for this component is::
> > @@ -593,8 +593,8 @@ To describe this Exar device on the PCI
> >
> >         Bus: 0 - Device: 14 - Function: 1
> >
> > -To find this information is necessary disassemble the BIOS ACPI tables, in
> > -particular the DSDT (see also [2])::
> > +To find this information, it is necessary to disassemble the BIOS ACPI tables,
> > +in particular the DSDT (see also [2])::
> >
> >         mkdir ~/tables/
> >         cd ~/tables/
> >
> >
> > --

Applied as 6.1 material, thanks!
