Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A75A2B51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbiHZPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244831AbiHZPbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:31:46 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93E39B91;
        Fri, 26 Aug 2022 08:31:43 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a4so1483356qto.10;
        Fri, 26 Aug 2022 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pFkaR9I3kc1y1ODYdxyZc39/5L+yX/CiBnUnNaHIGxA=;
        b=E06wNRHG/V5HYt3py9iTsew/F0bF806mMjb+zUmhPmLhZEKrBsuFiwaTnPeXx9INC5
         4RgvKQ1j8f2rBBK0ym8jIQyKRgZW1IMGi90LlIiOpM4QkG9C8olExh9FIwjX6Eja8FPv
         E5HX/z3ZYWVnh+i6aufxxbYQzy42v5nOq1xzXCF34H5TqAHBgVeUqczRtCI8nZ1oBl+n
         KI9ayJTiyJUDQLrt9aET5R16v/3p8fMNLx4CgH/rO/bx5a4a8J9SVVmj3mIDLruJyQXL
         OW5z+0zUe7iCnWaNn6m72cO4TMtYN7L0C6A4A6mo3BHYVBo5O/GYokX0W0gwfARJvvs/
         9sSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pFkaR9I3kc1y1ODYdxyZc39/5L+yX/CiBnUnNaHIGxA=;
        b=cwVsUG4M8V6XtmD1tB6EH6MVCruRZGzxUGYjn9VgvyoWNROD578El1xkGxa3Pi67T+
         DGWRLe4NEbxCxUHAdXWgMRD9xjgv+NQZgDE/q0GoWUFUHpKoGGOFWANsGTF1HHpEra7G
         J7AmSCKc6bVOb8P8pnMBAzvHJT0SWiSRubZEo+PXM2+lHjZVBM70PqQgUYGSMkjpKt8K
         2KBuDUeYgeNz0DhEfR/T1IGGeFNg5CTZcBDu8nATZOs9jzljyNObyj4XQ7BchXOpqXln
         XDEPoNCsJppzKX/2YGiL0j3X+IuRzuzFxNOwP4fG9muZ3bDRkJcJUBsPV/etJDO1P5v3
         2azA==
X-Gm-Message-State: ACgBeo3GcPojPgvXJwV1UL7G88p1Je/I1vfA5Q4H5tWBOlyy6g9KaifM
        eIwAlqa+5MtAWWGZHwNENnGdRl9zkfS0LajoH+DvpWWdX4k=
X-Google-Smtp-Source: AA6agR7QlJJpFisCs/GBGZ58GfS6Kgl3mDrGkbdQBQdcc3JcJ4DN+vhWzw+WVEeEqruyjPzu+8VH9ATzPRUOR9DDK6g=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr190070qta.429.1661527902551; Fri, 26 Aug
 2022 08:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220826151457.7c13a407@endymion.delvare>
In-Reply-To: <20220826151457.7c13a407@endymion.delvare>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Aug 2022 18:31:06 +0300
Message-ID: <CAHp75VdBv4EkDgTwHSxNhA91b8FMwaMvvoeWZOaxJVcvwRQ4vg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: docs: enumeration: Fix a few typos and wording mistakes
To:     Jean Delvare <jdelvare@suse.de>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Aug 26, 2022 at 4:14 PM Jean Delvare <jdelvare@suse.de> wrote:
>
> "sturct" -> "struct"
> "similar than with" -> "similar to"
> Missing comma, "it" and "to"

Makes sense to me, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  Documentation/firmware-guide/acpi/enumeration.rst |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> --- linux-5.19.orig/Documentation/firmware-guide/acpi/enumeration.rst   2022-08-26 12:46:35.307949217 +0200
> +++ linux-5.19/Documentation/firmware-guide/acpi/enumeration.rst        2022-08-26 15:02:50.245981296 +0200
> @@ -21,7 +21,7 @@ In order to support this and re-use the
>    - Devices behind real busses where there is a connector resource
>      are represented as struct spi_device or struct i2c_device. Note
>      that standard UARTs are not busses so there is no struct uart_device,
> -    although some of them may be represented by sturct serdev_device.
> +    although some of them may be represented by struct serdev_device.
>
>  As both ACPI and Device Tree represent a tree of devices (and their
>  resources) this implementation follows the Device Tree way as much as
> @@ -205,7 +205,7 @@ enumerated once spi_register_master() is
>                 }
>                 ...
>
> -The SPI device drivers only need to add ACPI IDs in a similar way than with
> +The SPI device drivers only need to add ACPI IDs in a similar way to
>  the platform device drivers. Below is an example where we add ACPI support
>  to at25 SPI eeprom driver (this is meant for the above ACPI snippet)::
>
> @@ -362,7 +362,7 @@ These GPIO numbers are controller relati
>  specifies the path to the controller. In order to use these GPIOs in Linux
>  we need to translate them to the corresponding Linux GPIO descriptors.
>
> -There is a standard GPIO API for that and is documented in
> +There is a standard GPIO API for that and it is documented in
>  Documentation/admin-guide/gpio/.
>
>  In the above example we can get the corresponding two GPIO descriptors with
> @@ -538,8 +538,8 @@ information.
>  PCI hierarchy representation
>  ============================
>
> -Sometimes could be useful to enumerate a PCI device, knowing its position on the
> -PCI bus.
> +Sometimes it could be useful to enumerate a PCI device, knowing its position on
> +the PCI bus.
>
>  For example, some systems use PCI devices soldered directly on the mother board,
>  in a fixed position (ethernet, Wi-Fi, serial ports, etc.). In this conditions it
> @@ -550,7 +550,7 @@ To identify a PCI device, a complete hie
>  the chipset root port to the final device, through all the intermediate
>  bridges/switches of the board.
>
> -For example, let us assume to have a system with a PCIe serial port, an
> +For example, let's assume we have a system with a PCIe serial port, an
>  Exar XR17V3521, soldered on the main board. This UART chip also includes
>  16 GPIOs and we want to add the property ``gpio-line-names`` [1] to these pins.
>  In this case, the ``lspci`` output for this component is::
> @@ -593,8 +593,8 @@ To describe this Exar device on the PCI
>
>         Bus: 0 - Device: 14 - Function: 1
>
> -To find this information is necessary disassemble the BIOS ACPI tables, in
> -particular the DSDT (see also [2])::
> +To find this information, it is necessary to disassemble the BIOS ACPI tables,
> +in particular the DSDT (see also [2])::
>
>         mkdir ~/tables/
>         cd ~/tables/
>
>
> --
> Jean Delvare
> SUSE L3 Support



-- 
With Best Regards,
Andy Shevchenko
