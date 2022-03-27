Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BECA4E85CE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 06:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiC0EmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 00:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiC0EmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 00:42:02 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0AE5675A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:40:24 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id j7so4959294uap.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1PE7W5N59fok9TePTrxZyNDXrOa+govQ9T/uek8IRts=;
        b=UnQ4yhEWlfZw23jP/wDSLGO8yVH7wM1XoWG+skILHdRMNkaPc8v7XK38Q+TSXny9GH
         HZ/dq4DQe/lvldjezeFartND63rJEgcWb7+cnS6CtjcmFhkECRl+6fmUiyD3a5X4nv4z
         AewVDKHdTtbxynpUQfWGXZ8O2OLSYHdoasS1LjWV4Ri5LM4Ll9F1UB+juUpaUrClKtq0
         62g3TjnyieBt9yDPOPD2StARibL1iB7je+jDDVoG6NCgj2st3EmY51dw6d/hTfl3HSLc
         Ic2qSbXhWNzBQ7V4e/3KsdNHa0wBnANKZLDUzugYFq4zozrmRZzVmjy0b4WtSKXqzNtp
         hW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=1PE7W5N59fok9TePTrxZyNDXrOa+govQ9T/uek8IRts=;
        b=wV3WwHYhgw8tsS00FNcOyrbhPO6sa7vmBAxS4zD49anifdNLHA8dEo8NaCI9l6KN4K
         zYPf59LakfcBVlWAUvdD8JbrjXeKE5BXzLEeUzzd5h9BEMkYviniWNGxkkTuQniRmcMH
         rNHC61JyVKrytjKhk27/3pu13MAcRGDNJNlPjeg3sR/bPXpFcj7yKmpeVvG8qh5apEcy
         Vt6Svdvl1a4zFVxXdBNcTsbLC74/HyHEVKwfESQKfrVprKDk8BGi3h2Hh0JJ+9mqdGWk
         8PkRhmJOayaplJgg2qlnCbQ0eerPdtqHBDFy9kXeccM5+h+AQErL+OvJdHJz0p0Pj8Au
         Wa4Q==
X-Gm-Message-State: AOAM532SkCa6yuu9l7VVIGHZdMe+fdMpIwAYRDrRZp65PSGKGJoO9AV1
        l+COpMMbDRbklrV5gN5iu60toXTjXiPSprbVHfeIZ6BPrAQ=
X-Google-Smtp-Source: ABdhPJyfRcaq0UVktyWrluCON0FgMl4Ow6NXGZGSw14wM8GFVcGYw+WpT4wmsBYOa2WeLEfHKn/YARoxAPHdaiDXOXk=
X-Received: by 2002:ab0:144b:0:b0:33c:76e0:9006 with SMTP id
 c11-20020ab0144b000000b0033c76e09006mr7754306uae.52.1648356023063; Sat, 26
 Mar 2022 21:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220327042459.141515-1-yusisamerican@gmail.com> <20220327042459.141515-4-yusisamerican@gmail.com>
In-Reply-To: <20220327042459.141515-4-yusisamerican@gmail.com>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Sat, 26 Mar 2022 21:40:12 -0700
Message-ID: <CAJoG2+9We3n89m2HG0twjtxGB-ZQnkxBMW3dvQ=bt7JHyfpsWA@mail.gmail.com>
Subject: Re: [PATCH v9] drivers: ddcci: upstream DDCCI driver
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Sorry for the incorrect titles, ill send another patch series shortly
with everything
sorted.

On Sat, Mar 26, 2022 at 9:25 PM Yusuf Khan <yusisamerican@gmail.com> wrote:
>
> This patch adds Documentation for the DDCCI driver.
>
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> Signed-off-by: Christoph Grenz <christophg+lkml@grenz-bonn.de>
> ---
>  Documentation/ABI/testing/sysfs-driver-ddcci |  57 +++++++++
>  Documentation/driver-api/ddcci.rst           | 122 +++++++++++++++++++
>  2 files changed, 179 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-ddcci
>  create mode 100644 Documentation/driver-api/ddcci.rst
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-ddcci b/Documentation=
/ABI/testing/sysfs-driver-ddcci
> new file mode 100644
> index 000000000000..19f77ccf3ed0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-ddcci
> @@ -0,0 +1,57 @@
> +What:          /sys/bus/ddcci/ddcci<I=C2=B2C bus number>i<hex address>
> +Date:          March 2022
> +KernelVersion: 5.18
> +Contact:       Christoph Grenz <christophg+lkml@grenz-bonn.de>
> +Description:   This file is a user interface for an internal
> +               dependent device on the I2C bus, it exports the same
> +               information as the master device(/sys/bus/ddcci/
> +               ddcci<I=C2=B2C bus number>) that is referenced in this
> +               document.
> +
> +What:          /sys/bus/ddcci/ddcci<I=C2=B2C bus number>e<hex address>
> +Date:          March 2022
> +KernelVersion: 5.18
> +Contact:       Christoph Grenz <christophg+lkml@grenz-bonn.de>
> +Description:   This file is a user interface for an external
> +               dependent device on the I2C bus, it exports the same
> +               information as the master device(/sys/bus/ddcci/
> +               ddcci<I=C2=B2C bus number>) that is referenced in this
> +               document.
> +
> +What:          /sys/bus/ddcci/ddcci<I=C2=B2C bus number>
> +Date:          March 2022
> +KernelVersion: 5.18
> +Contact:       Christoph Grenz <christophg+lkml@grenz-bonn.de>
> +Description:   This file provides the user interface for the
> +               master device on the I2C bus. It exports the following
> +               peices of information:
> +               - idProt
> +               ACCESS.bus protocol supported by the device. Usually
> +               "monitor".
> +
> +               - idType
> +               ACCESS.bus device subtype. Usually "LCD" or "CRT".
> +
> +               - idModel
> +               ACCESS.bus device model identifier. Usually a
> +               shortened form of the device model name.
> +
> +               - idVendor
> +               ACCESS.bus device vendor identifier. Empty if the
> +               Identification command is not supported.
> +
> +               - idModule
> +               ACCESS.bus device module identifier. Empty if the
> +               Identification command is not supported.
> +
> +               - idSerial
> +               32 bit device number. A fixed serial number if it's
> +               positive, a temporary serial number if negative and zero
> +               if the Identification command is not supported.
> +
> +               - modalias
> +               A combined identifier for driver selection. It has the fo=
rm:
> +               ddcci:<idProt>-<idType>-<idModel>-<idVendor>-<idModule>.
> +               All non-alphanumeric characters (including whitespace)
> +               in the model, vendor or module parts are replaced by
> +               underscores to prevent issues with software like systemd-=
udevd.
> diff --git a/Documentation/driver-api/ddcci.rst b/Documentation/driver-ap=
i/ddcci.rst
> new file mode 100644
> index 000000000000..2b7de1ac2656
> --- /dev/null
> +++ b/Documentation/driver-api/ddcci.rst
> @@ -0,0 +1,122 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +DDC/CI
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +1. Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +DDC/CI is a control protocol for monitor settings supported by most
> +monitors since about 2005. It is based on ACCESS.bus (an early USB prede=
cessor).
> +This could be used to create drivers that communicate with the DDCCI com=
ponent,
> +see ddcci-backlight for an example.
> +
> +2. sysfs interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Each detected DDC/CI device gets a directory in /sys/bus/ddcci/devices.
> +The main device on a bus is named ddcci[I=C2=B2C bus number].
> +Internal dependent devices are named ddcci[I=C2=B2C bus number]i[hex add=
ress]
> +External dependent devices are named ddcci[I=C2=B2C bus number]e[hex add=
ress]
> +There the following files export information about the device:
> +
> +capabilities
> +The full ACCESS.bus capabilities string. It contains the protocol,
> +type and model of the device, a list of all supported command
> +codes, etc. See the ACCESS.bus spec for more information.
> +
> +- idProt
> +ACCESS.bus protocol supported by the device. Usually "monitor".
> +
> +- idType
> +ACCESS.bus device subtype. Usually "LCD" or "CRT".
> +
> +- idModel
> +ACCESS.bus device model identifier. Usually a shortened form of the
> +device model name.
> +
> +- idVendor
> +ACCESS.bus device vendor identifier. Empty if the Identification command
> +is not supported.
> +
> +- idModule
> +ACCESS.bus device module identifier. Empty if the Identification command
> +is not supported.
> +
> +- idSerial
> +32 bit device number. A fixed serial number if it's positive, a temporar=
y
> +serial number if negative and zero if the
> +Identification command is not supported.
> +
> +- modalias
> +A combined identifier for driver selection. It has the form:
> +ddcci:<idProt>-<idType>-<idModel>-<idVendor>-<idModule>.
> +All non-alphanumeric characters (including whitespace) in the model,
> +vendor or module parts are replaced by underscores to prevent issues
> +with software like systemd-udevd.
> +
> +3. Character device interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +For each DDC/CI device a character device in
> +/dev/bus/ddcci/[I=C2=B2C bus number]/ is created,
> +127 devices are assigned in total.
> +
> +The main device on the bus is named display.
> +
> +Internal dependent devices are named i[hex address]
> +
> +External dependent devices are named e[hex address]
> +
> +These character devices can be used to issue commands to a DDC/CI device
> +more easily than over i2c-dev devices. They should be opened unbuffered.
> +To send a command just write the command byte and the arguments with a
> +single write() operation. The length byte and checksum are automatically
> +calculated.
> +
> +To read a response use read() with a buffer big enough for the expected =
answer.
> +
> +NOTE: The maximum length of a DDC/CI message is 32 bytes.
> +
> +4. ddcci-backlight (monitor backlight driver)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +[This is not specific to the DDC/CI backlight driver, if you already dea=
lt with
> +backlight drivers, skip over this.]
> +
> +For each monitor that supports accessing the Backlight Level White
> +or the Luminance property, a backlight device of type "raw" named like t=
he
> +corresponding ddcci device is created. You can find them in /sys/class/b=
acklight/.
> +For convenience a symlink "ddcci_backlight" on the device associated wit=
h the
> +display connector in /sys/class/drm/ to the backlight device is created,=
 as
> +long as the graphics driver allows to make this association.
> +
> +5. Limitations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +-Dependent devices (sub devices using DDC/CI directly wired to the monit=
or,
> +like  Calibration devices, IR remotes, etc.) aren't automatically detect=
ed.
> +You can force detection of external dependent devices by writing
> +"ddcci-dependent [address]" into /sys/bus/i2c/i2c-?/new_device.
> +
> +There is no direct synchronization if you manually change the luminance
> +with the buttons on your monitor, as this can only be realized through p=
olling
> +and some monitors close their OSD every time a DDC/CI command is receive=
d.
> +
> +Monitor hotplugging is not detected. You need to detach/reattach the I=
=C2=B2C driver
> +or reload the module.
> +
> +6. Debugging
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Both drivers use the dynamic debugging feature of the Linux kernel.
> +To get detailed debugging messages, set the dyndbg module parameter.
> +If you want to enable debugging permanently across reboots, create a fil=
e
> +/etc/modprobe.d/ddcci.conf containing lines like the following before lo=
ading the modules:
> +
> +options ddcci dyndbg
> +options ddcci-backlight dyndbg
> +
> +7. Origin
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This driver originally came from Christoph Grenz in DKMS form here:
> +https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux
> +with multiple backups available on the wayback machine. It also
> +inlcudes a example program for the usage of this driver in
> +userland.
> --
> 2.25.1
>
