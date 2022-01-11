Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9712048B5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345258AbiAKSey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242309AbiAKSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:34:53 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA93C06173F;
        Tue, 11 Jan 2022 10:34:53 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i82so58722ioa.8;
        Tue, 11 Jan 2022 10:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1B++ptGdknwRzhnTn04GeoJQVrlb8tb2vjVRjIkM6yc=;
        b=J2T33pibJC/uxDyYnfN1MTZTjFu5phmVoe3EHfvcxvQKZ5SBAlpXZTFBiWYweguDUk
         s20sW0iR8DOjBXV4YihCbmjCMp/MqgP1xtC2YgzGEvzNIRUXQTyee8RWFIb2cqEQRW9f
         pHO7MnawHeE9Pom7k/5eav8A5pML9zXfQxwvWvhRdX1NWo8CJEhC57wetpetK653QZII
         sM3bIOsHp4ZqBzG8clrdoYLaYsYYbTZjG2M+NGtoivrF5uUt4Rxl1s4itDPlEBIhNJjn
         xakQqOgsP+91V01kKXVAS5AR/wCgUx12lWagElqV/e9zkBrs6w6zNgQ8coVL7Og/q2y7
         Op1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1B++ptGdknwRzhnTn04GeoJQVrlb8tb2vjVRjIkM6yc=;
        b=SodgzzsQWN6AHZ1g0xffoxILiGjrhntV3+QE4RL+0uSMaLkZceEd6jHJsWg/UkoBVo
         b2JJZtDZIjYIlUlO1TEIT6j3Yl0iudwbVafuBPNkyBUYML1bAwTQBKIIZGQ96ZrZHoBH
         Kd2ku/wqCj/HgJb7qt54yQudfuQcuDdEENI6iwX8AsQ1Gq+4OQ/lvplYBDNS2CqR4sRO
         /ICDwYfxzetw4yqADzwBuz01CC6ZMbNDHqBY6bl7y5kRQHV4+KmvV9oOfwQjTPO92dl+
         HHYCHROQ9uykDs6mPikmSMFQ+ybIibVtYb3Y/ltSQdA6h3vUmtgdjftMJCnlyKQCBUqL
         YZ0Q==
X-Gm-Message-State: AOAM5304iUVnh3Bv3WAMqOuqJreavnB0pdBg6BdDYUp2ODJifYLGD+t8
        IIokqDvzwhY4Ki2684wE4CafFgKJGBKjOKNrHl0=
X-Google-Smtp-Source: ABdhPJwlRaY5cJw6+DPJSMl9a7gTOgZ2MF6nLF/OAaw21iVWhPrXjRNRb6xEMYegKPxEZO6XD2PBO9uhNbPfGhIhpBk=
X-Received: by 2002:a02:c734:: with SMTP id h20mr3034797jao.256.1641926092747;
 Tue, 11 Jan 2022 10:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20220111180347.1245774-1-eugene.shalygin@gmail.com> <0uakBuv1oBXoq7hUQxghKrFabqWebbG437WBNMuBVpYRL4vCE-IxwsbH16I82L-hq4xLtuSvBM1UaPfUy1HxmoFJYFHkDuJPxh3dZ_P8LuM=@protonmail.com>
In-Reply-To: <0uakBuv1oBXoq7hUQxghKrFabqWebbG437WBNMuBVpYRL4vCE-IxwsbH16I82L-hq4xLtuSvBM1UaPfUy1HxmoFJYFHkDuJPxh3dZ_P8LuM=@protonmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Tue, 11 Jan 2022 19:34:41 +0100
Message-ID: <CAB95QARvshfae_wwECr-5wEHxgyoc-2QWHUsK6N7LLE1n_DbZQ@mail.gmail.com>
Subject: Re: PATCH v4 ASUS EC Sensors
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yes, my mistake, and thank you for the hint!

Regards,
Eugene

On Tue, 11 Jan 2022 at 19:17, Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.co=
m> wrote:
>
> 2022. janu=C3=A1r 11., kedd 19:03 keltez=C3=A9ssel, Eugene Shalygin =C3=
=ADrta:
>
> > This patchset replaces the HWMON asus_wmi_ec_sensors driver with
> > an implementation that does not use WMI but queries the embedded
> > controller directly.
> >
> > That provides two enhancements: sensor reading became quicker (on some
> > systems or kernel configuration it took almost a full second to read
> > all the sensors, that transfers less than 15 bytes of data), the driver
> > became more fexible. The driver now relies on ACPI mutex to lock access
> > to the EC, in the same way as the WMI DSDT code does.
> >
> > Chenges in v5:
> >  - Place the sensors bitset directly into the driver_data field of the
> >        dmi_system_id struct.
> >  - Replace doc comments with regular ones.
> >
> > Changes in v4:
> >  - Deprecate the wmi driver rather than removing it.
> >
> > Changes in v3:
> >  - Remove BIOS version checks and BIOS version dependent mutex path.
> >
> > Changes in v2:
> >  - Replace sensor flags enum with bitset
> >  - Replace module init/probe functions with module_platform_driver_prob=
e
> >    and ask the platform drivers framework to load the driver when ACPI
> >    EC is found (ACPI ID "PNP0C09").
> >  - Extend board data with BIOS version attribute for the mutex path to =
be
> >    BIOS version dependent.
> >  - Add module parameter to override the mutex path.
> >
>
> Hi
>
>
> I believe the subject should say "v5" and not "v4". In any case, FYI, `gi=
t format-patch`
> has the `--cover-letter` option, which will generate a cover letter templ=
ate
> with the right patch version, etc.
>
>
> Regards,
> Barnab=C3=A1s P=C5=91cze
