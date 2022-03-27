Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8174E85D2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 06:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiC0ExP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 00:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiC0ExN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 00:53:13 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E562AC4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:51:34 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id y198so12437629vsy.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jwn10RmHdLb+685I0oJl3mm8AgDlpt3BJWqex3XbpWU=;
        b=L/Yuk8skFSkmpmhFlOG0qI7LGnYfzdLu98ZsJiA129zR7io2UJK2rQtKk3VaNaZUCD
         2d207TBoj+gnrBegbH5PPKyHS/4dS6MBekVr2IWs33LsoyVHgUvLWjyJXjNT4r0GNEnp
         RQRQo0OaILgu7NGKVRkdZ+FwXZfHxFjb0mxk3gfkkDesKmsqguxWgQknCmCD/c3/QC+F
         0pnHlq5la2FQQtr4/97W1Q1WDTKPEigZfbZxb0E6jqdeyIfx9G13wAZNXDbaSMUocQ9N
         gLVHnDgdXd7MNJXngsYX3CV3+tovAQIa+XzFdJ7QY7PE8iRDxYp6HeeIt5U1LOBomQJL
         WVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jwn10RmHdLb+685I0oJl3mm8AgDlpt3BJWqex3XbpWU=;
        b=45/nU1CNtMDbIhYLODj4Rum/IkkBxUMRdq12hjkn+CneMZcHrwVnFcbwCg8kqH5FBx
         r5yKlMwUwhllCrpNtBeZxii09ZiF8Ga6lL9TWv+zjG4cG79xbbWipG789vX3obYTgGBs
         Gm+RxIFJd6AveG9UA2RHEsGjSXpei067YGAf6j1Ky/MbLwgfTjT12K1iq2pvGCLzWKqO
         5Omem9kZoC/iI1jCYFNRxXE3GE3+EtXXSv/FNmq6bK4ZKYMmLLUjg6YQILUx/GrBmRvH
         jR+ZaSkOrZZ50oR6N7POjzy9M3SZEZKjczTmVUW5Y8elKLO7ynrOacKAA+eTMebQZLz4
         /3mQ==
X-Gm-Message-State: AOAM532cf/cke3rInab0JxMmve/lP6NYk6JuN/duquSRrKc1JrpIt9/N
        Sk0r3UGOqzK/oJaj9YETHzccyadKJgKH1oxlQpAx6F1UDno=
X-Google-Smtp-Source: ABdhPJzEpKcKYI9VXiLepvF3s1jHylPfM2IoNCaAP1vi4lPKInC03llMhFSP0pT572oN4CDPnuR8yu0wc9JTfkUTPuU=
X-Received: by 2002:a67:f504:0:b0:325:5d17:8b14 with SMTP id
 u4-20020a67f504000000b003255d178b14mr6845487vsn.60.1648356693455; Sat, 26 Mar
 2022 21:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220327044656.142958-1-yusisamerican@gmail.com> <20220327044656.142958-4-yusisamerican@gmail.com>
In-Reply-To: <20220327044656.142958-4-yusisamerican@gmail.com>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Sat, 26 Mar 2022 21:51:22 -0700
Message-ID: <CAJoG2+9_5s1EUBkHCvR8Sz=2dRo2gZ+fTNZ++LB_ZW2QT2RCJA@mail.gmail.com>
Subject: Re: [PATCH v9] drivers: ddcci: upstream DDCCI driver
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        gregkh <gregkh@linuxfoundation.org>, javier@javigon.com,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>,
        kernel test robot <lkp@intel.com>
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

Ignore this as well(wrong titles).

On Sat, Mar 26, 2022 at 9:48 PM Yusuf Khan <yusisamerican@gmail.com> wrote:
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
