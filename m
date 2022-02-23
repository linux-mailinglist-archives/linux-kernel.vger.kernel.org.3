Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D8E4C15F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbiBWO72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiBWO70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:59:26 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AB1AEF20;
        Wed, 23 Feb 2022 06:58:57 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z66so4528007qke.10;
        Wed, 23 Feb 2022 06:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KamL62rmNpUoJluBi1t6awmuPDYiXkVrI9LqoliPMeg=;
        b=mlNjO7/Z/LvgZPMs6EoFTnBT5iEjKQlUvZjrYll+IyBn+BxytuUTYbjT+T6lqjIIQ0
         9XVE6k6Tyo+ZptRQ67i1P26Tr7LVaTBxO7st/5obPNzzDybhkuvZdPQt3G5s0aKrsOu1
         Vhwg+7NUSNFZOY1JGdH5b0zEuqaUFgy17SeyMzU0qFXxNMpS506yQyqkUCpjjW/s8Hlr
         4Yko+1KcFwP35A3xbk0xHLqyqqq084R8SyMp1QGHeNr1qJPI/+ScfZb1WTLDWGXo5jXl
         B/r5yNr3nVU3e0mtrPHuI0tWoUR1cXGwhzW/ytOaUVz4zdZ2BngAUi+y1XRbKTWcpJdR
         DUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KamL62rmNpUoJluBi1t6awmuPDYiXkVrI9LqoliPMeg=;
        b=a+0QQaebtItB9myrLCGEicQDb3iD0YN5OLAR8y3mu5YY0kGX/MmNP7HeGpsNfNzc1G
         n1+5S6MS1a+WApQgDy/2FqW3/spgGNtpQK/kxHxbMUF5djzoYuz9LxtyKfuNoB4xyAME
         HeXKhS8Kt++5HUx5iGoRxtfwQcitl6ZneGZXzsv/9NX3lwHjKZtIiomb/3cwdI+Sm563
         mKD7v87d00Qf/p6MQ2zhmHm9jM7Wo1j058dXDGx41qK1wu2k/Bg/aVMXDfziCVF599TM
         8ZcrF+RVj49dNkW3d3VJvtncM9nMKqeN3mFj0A4YqJ90BXQaeH6XeWhiqWaFZfOWybzj
         q3/Q==
X-Gm-Message-State: AOAM533zh4c59bDONMaQ+jg/kODoOlOuFstEUbCrwCyVzICXBko4mVks
        9mIFMFojSiG0zggvhha93+QP1hlPL8nlAlfmSw8=
X-Google-Smtp-Source: ABdhPJy8Qq2N5FRSGJye8rknnB4GKZhbCumr/Ju+WX3LiB5FJrF84JnoTJ3gzfkZrarjNdfgV/G3o6UdWiL0gEAT/QE=
X-Received: by 2002:a37:a397:0:b0:508:1e24:e2e0 with SMTP id
 m145-20020a37a397000000b005081e24e2e0mr7006qke.168.1645628335467; Wed, 23 Feb
 2022 06:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20220221135424.GA7385@ubuntu> <YhQum4wL7WifQc8Z@ripper>
In-Reply-To: <YhQum4wL7WifQc8Z@ripper>
From:   Kestrel seventyfour <kestrelseventyfour@gmail.com>
Date:   Wed, 23 Feb 2022 15:58:44 +0100
Message-ID: <CAE9cyGRHePVpsdzW6eYkF_MYZV2Hm8D0=iUeSzFo__gM77iRWA@mail.gmail.com>
Subject: Re: [PATCH 3/3] remoteproc: Add AVM WASP driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Bjorn,

I have worked on most of your comments, for some comments I have
questions and answers, please see below.

Am Di., 22. Feb. 2022 um 01:28 Uhr schrieb Bjorn Andersson
<bjorn.andersson@linaro.org>:
>
> On Mon 21 Feb 05:54 PST 2022, Daniel Kestrel wrote:
>
> > Some AVM Fritzbox router boards (3390, 3490, 5490, 5491, 7490),
> > that are Lantiq XRX200 based, have a memory only ATH79 based
> > WASP (Wireless Assistant Support Processor) SoC that has wifi
> > cards connected to it. It does not share anything with the
> > Lantiq host and has no persistent storage. It has an mdio based
> > connection for bringing up a small network boot firmware and is
> > connected to the Lantiq GSWIP switch via gigabit ethernet. This
> > is used to load an initramfs linux image to it, after the
> > network boot firmware was started.
> >
> > In order to initialize this remote processor we need to:
> > - power on the SoC using startup gpio
> > - reset the SoC using the reset gpio
> > - send the network boot firmware using mdio
> > - send the linux image using raw ethernet frames
> >
> > This driver allows to start and stop the WASP SoC.
> >
>
> That's different, but seems to be a reasonable fit with the remoteproc
> framework.
>
> > Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> > ---
> >  drivers/remoteproc/Kconfig    |   10 +
> >  drivers/remoteproc/Makefile   |    1 +
> >  drivers/remoteproc/avm_wasp.c | 1251 +++++++++++++++++++++++++++++++++
> >  drivers/remoteproc/avm_wasp.h |   95 +++
> >  4 files changed, 1357 insertions(+)
> >  create mode 100644 drivers/remoteproc/avm_wasp.c
> >  create mode 100644 drivers/remoteproc/avm_wasp.h
> >
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index 166019786653..a761186c5171 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -23,6 +23,16 @@ config REMOTEPROC_CDEV
> >
> >         It's safe to say N if you don't want to use this interface.
> >
> > +config AVM_WASP_REMOTEPROC
> > +     tristate "AVM WASP remoteproc support"
> > +     depends on NET_DSA_LANTIQ_GSWIP
> > +     help
> > +       Say y here to support booting the secondary SoC ATH79 target
> > +       called Wireless Assistant Support Processor (WASP) that some
> > +       AVM Fritzbox devices (3390, 3490, 5490, 5491, 7490) have built =
in.
> > +
> > +       It's safe to say N here.
> > +
> >  config IMX_REMOTEPROC
> >       tristate "i.MX remoteproc support"
> >       depends on ARCH_MXC
> > diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> > index 5478c7cb9e07..0ae175c6722f 100644
> > --- a/drivers/remoteproc/Makefile
> > +++ b/drivers/remoteproc/Makefile
> > @@ -11,6 +11,7 @@ remoteproc-y                                +=3D remo=
teproc_sysfs.o
> >  remoteproc-y                         +=3D remoteproc_virtio.o
> >  remoteproc-y                         +=3D remoteproc_elf_loader.o
> >  obj-$(CONFIG_REMOTEPROC_CDEV)                +=3D remoteproc_cdev.o
> > +obj-$(CONFIG_AVM_WASP_REMOTEPROC)    +=3D avm_wasp.o
> >  obj-$(CONFIG_IMX_REMOTEPROC)         +=3D imx_rproc.o
> >  obj-$(CONFIG_IMX_DSP_REMOTEPROC)     +=3D imx_dsp_rproc.o
> >  obj-$(CONFIG_INGENIC_VPU_RPROC)              +=3D ingenic_rproc.o
> > diff --git a/drivers/remoteproc/avm_wasp.c b/drivers/remoteproc/avm_was=
p.c
> > new file mode 100644
> > index 000000000000..04b7c9005028
> > --- /dev/null
> > +++ b/drivers/remoteproc/avm_wasp.c
> > @@ -0,0 +1,1251 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * AVM WASP Remote Processor driver
> > + *
> > + * Copyright (c) 2019-2020 Andreas B=C3=B6hler
> > + * Copyright (c) 2021-2022 Daniel Kestrel
> > + *
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_mdio.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/remoteproc.h>
> > +#include <linux/timekeeping.h>
> > +#include <net/sock.h>
> > +#include <asm-generic/gpio.h>
> > +
> > +#include "remoteproc_internal.h"
> > +#include "avm_wasp.h"
> > +
> > +/**
> > + * struct avm_wasp_rproc - avmwasp remote processor priv
> > + * @rproc: rproc handle
> > + * @pdev: pointer to platform device
> > + * @eeprom_blob: pointer to load and save any firmware
> > + * @linux_blob: pointer to access initramfs image
> > + * @complete: structure for asynchronous firmware load
> > + * @mdio_bus: pointer to mii_bus of gswip device for gpio
> > + * @startup_gpio: store WASP startup gpio number
> > + * @reset_gpio: store WASP reset gpio number
> > + * @s_gpio_flg: store WASP startup gpio flags active high/low
> > + * @r_gpio_flg: store WASP reset gpio flags active high/low
> > + * @netboot_firmware: store name of the network boot firmware
> > + * @loader_port: store name of the port wasp is connected to
> > + * @sendbuf: send buffer for uploading WASP initramfs firmware
> > + * @recvbuf: recv buffer for feedback from WASP
> > + * @s_packet: structure for sending packets to WASP
> > + * @send_socket: pointer to socket for sending to WASP
> > + * @recv_socket: pointer to socket for receiving from WASP
> > + * @ifindex: interface index used for WASP communication
> > + */
> > +struct avm_wasp_rproc {
> > +     struct rproc *rproc;
> > +     struct platform_device *pdev;
> > +     const struct firmware *eeprom_blob, *linux_blob;
> > +     struct completion complete;
> > +     char *mdio_bus_id;
> > +     struct mii_bus *mdio_bus;
> > +     int startup_gpio, reset_gpio;
> > +     enum of_gpio_flags s_gpio_flg, r_gpio_flg;
> > +     char *netboot_firmware;
> > +     char *loader_port;
> > +     char sendbuf[BUF_SIZE];
> > +     char recvbuf[BUF_SIZE];
>
> Why aren't these just struct wasp_packet? Instead of having a char
> buffer that happens to be sized, slightly bigger than a wasp_packet?
>
> > +     struct wasp_packet s_packet;
> > +     struct socket *send_socket;
> > +     struct socket *recv_socket;
> > +     int ifindex;
> > +};
> > +
> > +/**
> > + * avm_wasp_firmware_request_cb() - callback handler for firmware load
> > + * @eeprom_blob: pointer to struct firmware
> > + * @ctx: context passed
> > + *
> > + * This handler is called after completing the request_firmware_nowait
> > + * function by passing the avm_wasp_rproc struct
> > + * It saves the firmware in the context and calls complete
> > + */
> > +static void avm_wasp_firmware_request_cb(const struct firmware *eeprom=
_blob,
> > +                                      void *ctx)
> > +{
> > +     struct avm_wasp_rproc *avmwasp =3D ctx;
> > +
> > +     if (eeprom_blob)
> > +             avmwasp->eeprom_blob =3D eeprom_blob;
> > +
> > +     complete(&avmwasp->complete);
> > +}
> > +
> > +/**
> > + * avm_wasp_firmware_request() - asynchronous load of passed firmware
> > + * @avmwasp: pointer to drivers private avm_wasp_rproc structure
> > + * @name: char pointer to filename (relative to /lib/firmware)
> > + *
> > + * Handles setup and execution of the asynchronous firmware request
> > + * Used to trigger the load of the ath10k caldata and ath9k eeprom
> > + * firmware from the tffs partition of the devices
> > + *
> > + * Return: 0 on success, -2 if file not found or error from function
>
> Write out ENOENT instead of -2.
>
> > + * request_firmware_nowait
> > + */
> > +static int avm_wasp_firmware_request(struct avm_wasp_rproc *avmwasp,
> > +                                  const char *name)
> > +{
> > +     int err;
> > +
> > +     init_completion(&avmwasp->complete);
> > +
> > +     err =3D request_firmware_nowait(THIS_MODULE, 1, name,
> > +                                   &avmwasp->pdev->dev,
> > +                                   GFP_KERNEL, avmwasp,
> > +                                   avm_wasp_firmware_request_cb);
> > +     if (err < 0) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Load request for %s failed\n", name);
> > +             return err;
> > +     }
> > +
> > +     wait_for_completion(&avmwasp->complete);
>
> Why do you use nowait and then wait? This seems very similar to
> request_firmware()...
>
> > +
> > +     if (!avmwasp->eeprom_blob) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Unable to load %s\n", name);
> > +             return -ENOENT;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * avm_wasp_firmware_release() - clean up after firmware load
> > + * @avmwasp: pointer to drivers private avm_wasp_rproc structure
> > + *
> > + * Releases the firmware that is in the eeprom_blob firmware
> > + * pointer of the private avm_wasp_rproc structure
> > + */
> > +static void avm_wasp_firmware_release(struct avm_wasp_rproc *avmwasp)
> > +{
> > +     release_firmware(avmwasp->eeprom_blob);
> > +     avmwasp->eeprom_blob =3D NULL;
> > +}
> > +
> > +/**
> > + * avm_wasp_netboot_mdio_read() - read with gswip mdio bus
> > + * @avmwasp: pointer to drivers private avm_wasp_rproc structure
> > + * @location: register number of the m_regs_wasp register array
> > + *
> > + * Reads a value from the specified register for the mdio address
> > + * that is used for the connection to the WASP SoC
> > + * Mutex on mdio_lock is required to serialize access on bus
> > + *
> > + * Return: Value that was read from the specified register
> > + */
> > +int avm_wasp_netboot_mdio_read(struct avm_wasp_rproc *avmwasp,
> > +                            int location)
> > +{
> > +     int value;
> > +
> > +     if (location > M_REGS_WASP_INDEX_MAX || location < 0)
> > +             return 0;
> > +     mutex_lock(&avmwasp->mdio_bus->mdio_lock);
>
> If your mdio_bus requires a lock to handle concurrent IO operations,
> then that lock should be pushed into the read/write.
>
> If for some reason you need to serialize a sequence of read/writes, then
> it makes sense to have it here.
>
> But it's quite common for this to actually be an "atomic" operation and
> that there's no lock needed in the first place.
>

I will use the mdiobus_read and mdiobus_write functions and they
implement the mutex, if thats ok? Thats how the phys are doing it,
e.g. at803x.c, that share the mdio_bus with the lantiq_gswip.c driver.
I will just be another user of the mdio_bus in addition to the phys and
the lantiq gswip driver.

> > +     value =3D avmwasp->mdio_bus->read(avmwasp->mdio_bus,
> > +                     WASP_ADDR, m_regs_wasp[location]);
> > +     mutex_unlock(&avmwasp->mdio_bus->mdio_lock);
> > +     return value;
> > +}
> > +
> > +/**
> > + * avm_wasp_netboot_mdio_write() - write with gswip mdio bus
> > + * @avmwasp: pointer to drivers private avm_wasp_rproc structure
> > + * @location: register number of the m_regs_wasp register array
> > + * @value: value to be written to the register
> > + *
> > + * Writes a value to the specified register for the mdio address
> > + * that is used for the connection to the WASP SoC
> > + * Mutex on mdio_lock is required to serialize access on bus
> > + * Makes sure not to write to invalid registers as this can have
> > + * unpredictable results
> > + */
> > +void avm_wasp_netboot_mdio_write(struct avm_wasp_rproc *avmwasp,
> > +                              int location, int value)
> > +{
> > +     if (location > M_REGS_WASP_INDEX_MAX || location < 0)
> > +             return;
> > +     mutex_lock(&avmwasp->mdio_bus->mdio_lock);
> > +     avmwasp->mdio_bus->write(avmwasp->mdio_bus, WASP_ADDR,
> > +                     m_regs_wasp[location], value);
> > +     mutex_unlock(&avmwasp->mdio_bus->mdio_lock);
> > +}
> > +
> > +/**
> > + * avm_wasp_netboot_mdio_write_u32_split() - write 32bit value
> > + * @avmwasp: pointer to drivers private avm_wasp_rproc structure
> > + * @location: register number of the m_regs_wasp register array
> > + * @value: value to be written to the register
> > + *
> > + * As the mdio registers are 16bit, this function writes a 32bit value
> > + * to two subsequent registers starting with the specified register
> > + * for the mdio address that is used for the connection to the WASP So=
C
> > + */
> > +void avm_wasp_netboot_mdio_write_u32_split(struct avm_wasp_rproc *avmw=
asp,
> > +                                        int location, const u32 value)
> > +{
> > +     avm_wasp_netboot_mdio_write(avmwasp, location,
> > +                                 ((value & 0xffff0000) >> 16));
> > +     avm_wasp_netboot_mdio_write(avmwasp, location + 1,
> > +                                 (value & 0x0000ffff));
>
> Here you perform two separate writes, this might be wort locking
> around if there's a possibility that two threads races and a mix of
> their two "value" end up in the registers.
>
> > +}
> > +
> > +/**
> > + * avm_wasp_netboot_write_header() - write header to WASP
> > + * @avmwasp: pointer to drivers private avm_wasp_rproc structure
> > + * @start_address: address where to load the firmware to on WASP
> > + * @len: length of the network boot firmware
> > + * @exec_address: address where to start execution on WASP
> > + *
> > + * Writes the header to WASP using mdio to initiate the start of
> > + * transferring the network boot firmware to WASP
> > + *
> > + * Return: 0 on Success or -14 if writing header failed based on retur=
n
>
> -EFAULT instead of -14
>
> > + * code from WASP
> > + */
> > +static int avm_wasp_netboot_write_header(struct avm_wasp_rproc *avmwas=
p,
> > +                                      const u32 start_addr, const u32 =
len,
> > +                                      const u32 exec_addr)
> > +{
> > +     int regval;
> > +     int timeout =3D WASP_TIMEOUT_COUNT;
> > +
> > +     avm_wasp_netboot_mdio_write_u32_split(avmwasp, 1, start_addr);
> > +     avm_wasp_netboot_mdio_write_u32_split(avmwasp, 3, len);
> > +     avm_wasp_netboot_mdio_write_u32_split(avmwasp, 5, exec_addr);
> > +     avm_wasp_netboot_mdio_write(avmwasp, 0, WASP_CMD_SET_PARAMS);
> > +
> > +     do {
> > +             udelay(WASP_POLL_SLEEP_US);
> > +             regval =3D avm_wasp_netboot_mdio_read(avmwasp, 0);
> > +             timeout--;
> > +     } while ((regval !=3D WASP_RESP_OK) && (timeout > 0));
>
> I wonder if this could be implemented using read_poll_timeout() instead.
>

It worked. However it added about half a kB size to the kernel module per
invokation so I created a separate function to get rid of 6k load module si=
ze.

> > +
> > +     if (regval !=3D WASP_RESP_OK) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error writing header to WASP! Status =3D %d\n", =
regval);
> > +             return -EFAULT;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/**
> > + * avm_wasp_netboot_write_checksum() - write checksum to WASP
> > + * @avmwasp: pointer to drivers private avm_wasp_rproc structure
> > + * @checksum: calculated checksum value to be sent to WASP
> > + *
> > + * Writes the calculated checksum for the given network boot firmware
> > + * to WASP using mdio as the second step
> > + *
> > + * Return: 0 on Success or -14 if writing checksum failed based on ret=
urn
>
> -EFAULT instead of -14
>
> > + * code from WASP
> > + */
> > +static int avm_wasp_netboot_write_checksum(struct avm_wasp_rproc *avmw=
asp,
> > +                                        const uint32_t checksum)
> > +{
> > +     int regval;
> > +     int timeout =3D WASP_TIMEOUT_COUNT;
> > +
> > +     avm_wasp_netboot_mdio_write_u32_split(avmwasp, 1, checksum);
> > +     if (m_model =3D=3D MODEL_3390) {
> > +             avm_wasp_netboot_mdio_write_u32_split(avmwasp, 3, 0x0000)=
;
> > +             avm_wasp_netboot_mdio_write(avmwasp, 0,
> > +                                         WASP_CMD_SET_CHECKSUM_3390);
> > +     } else if (m_model =3D=3D MODEL_X490)
> > +             avm_wasp_netboot_mdio_write(avmwasp, 0,
> > +                                         WASP_CMD_SET_CHECKSUM_X490);
>
> If one of your blocks is wrapped in {}, then please wrap them all in {}.
>
> Btw, no need to wrap this line, it's fairly close to 80 chars anyways.
>
> > +
> > +     do {
> > +             udelay(WASP_POLL_SLEEP_US);
> > +             regval =3D avm_wasp_netboot_mdio_read(avmwasp, 0);
> > +             timeout--;
> > +     } while ((regval !=3D WASP_RESP_OK) && (timeout > 0));
>
> As above. And if read_poll_timeout() doesn't work out, this is repeated
> multiple times, seems reasonable to break out to a helper function.
>
> > +
> > +     if (regval !=3D WASP_RESP_OK) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error writing checksum to WASP! Status =3D %d\n"=
,
> > +                     regval);
> > +             return -EFAULT;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/**
> > + * avm_wasp_netboot_write_chunk() - write chunk of data to WASP
> > + * @avmwasp: pointer to drivers private avm_wasp_rproc structure
> > + * @data: pointer to data
> > + * @len: length of data (should not exceed 14 bytes)
> > + *
> > + * Writes up to 14 bytes of data into the 7 16bit mdio registers
> > + * to WASP using mdio
> > + *
> > + * Return: 0 on Success, -14 if data length is mor than 14 bytes or
> > + * -2 if writing the data failed based on return code from WASP
>
> EFAULT, ENOENT
>
> > + */
> > +static int avm_wasp_netboot_write_chunk(struct avm_wasp_rproc *avmwasp=
,
> > +                                     const char *data, const int len)
>
> @len sounds like a size_t to me.
>
> > +{
> > +     int regval, i, j;
> > +     int timeout =3D WASP_TIMEOUT_COUNT;
> > +
> > +     if (len > WASP_CHUNK_SIZE || len < 0 || !data)
> > +             return -EFAULT;
>
> Blank line here would be nice.
>
> > +     for (i =3D 0, j =3D 1; i < len; i +=3D 4, j +=3D 2)
> > +             avm_wasp_netboot_mdio_write_u32_split(avmwasp, j,
> > +                                                   *((uint32_t *)
> > +                                                   (data + i)));
>
> 14 isn't evenly divided in 4 byte chunks, so this doesn't seem to work
> as described.
>
> > +
> > +     avm_wasp_netboot_mdio_write(avmwasp, 0, WASP_CMD_SET_DATA);
> > +
> > +     do {
> > +             udelay(WASP_POLL_SLEEP_US);
> > +             regval =3D avm_wasp_netboot_mdio_read(avmwasp, 0);
> > +             timeout--;
> > +     } while ((regval !=3D WASP_RESP_OK) && (timeout > 0));
>
> As above.
>
> > +
> > +     if (regval !=3D WASP_RESP_OK && regval !=3D WASP_RESP_WAIT &&
> > +         regval !=3D WASP_RESP_COMPLETED) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error writing chunk to WASP: m_reg_status =3D 0x=
%x!\n",
> > +                     regval);
> > +             return -EFAULT;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/**
> > + * avm_wasp_netboot_calc_checksum() - calculate netboot firmware check=
sum
> > + * @avmwasp: pointer to drivers private avm_wasp_rproc structure
> > + *
> > + * Calculates the checksum by using the eeprom_blob from the private
> > + * avm_wasp_rproc structure
> > + *
> > + * Return: Calculated checksum or -14 on Error
>
> EFAULT
>
> > + */
> > +static uint32_t avm_wasp_netboot_calc_checksum(struct avm_wasp_rproc *=
avmwasp)
>
> Use u32 instead of uint32_t in the kernel.
>
> > +{
> > +     u32 checksum =3D 0xffffffff;
> > +     u32 cs;
> > +     int count =3D -1;
>
> Should this be signed, or is it just as signed as "checksum"?
>
> > +     size_t size;
> > +     const u8 *firmware;
> > +     const u8 *firmware_end;
> > +
> > +     if (!avmwasp->eeprom_blob)
> > +             return -EFAULT;
>
> -EFAULT isn't an awesome uint32_t and you're blindly writing it to the
> socket below.
>
> That said, it would be much better if you ensured that you didn't end up
> in avm_wasp_netboot_load_firmware() in the first place with eeprom_blob
> of NULL.
>
> But if nothing else, right before calling this function you check
> this...
>
> > +     size =3D avmwasp->eeprom_blob->size;
> > +     firmware =3D avmwasp->eeprom_blob->data;
> > +     firmware_end =3D firmware + size;
> > +
> > +     if (!firmware || size <=3D 0)
>
> Can firmware be NULL?
>
> size was checked right before calling the function.
>
> > +             return -EFAULT;
> > +
> > +     while (firmware < firmware_end) {
> > +             cs =3D (firmware[0] << 24 | firmware[1] << 16 |
> > +                     firmware[2] << 8 | firmware[3]);
>
> So cs is the big endian representation of the data?
>
> I don't see any checks to ensure size is a multiple of 4, so this might
> read off the end of the array?
>
> > +             checksum =3D checksum - cs;
> > +             count++;
> > +             firmware +=3D 4;
> > +     }
> > +
> > +     checksum =3D checksum - count;
> > +     return checksum;
> > +}
> > +
> > +/**
> > + * avm_wasp_netboot_load_firmware() - load netboot firmware to WASP
> > + * @avmwasp: pointer to drivers private avm_wasp_rproc structure
> > + *
> > + * Implements the process to send header, checksum and the firmware
> > + * blob in 14 byte chunks to the WASP processor using mdio
> > + * Includes checks between the steps and sending commands to start
> > + * the network boot firmware
> > + *
> > + * Return: 0 on Success, -2 if no firmware is present, -19 if no
> > + * firmware or -14 if other errors have occurred
>
> ENOENT, ENODEV and EFAULT
>
> > + */
> > +int avm_wasp_netboot_load_firmware(struct avm_wasp_rproc *avmwasp)
> > +{
> > +     const u8 *firmware;
> > +     const u8 *firmware_end;
> > +     int ret, regval, regval2, count, cont =3D 1;
> > +
> > +     count =3D WASP_WAIT_TIMEOUT_COUNT;
> > +
> > +     while (count > 0 && (avm_wasp_netboot_mdio_read(avmwasp, 0)
> > +                                             !=3D WASP_RESP_OK)) {
> > +             count -=3D 1;
> > +             mdelay(WASP_WAIT_SLEEP);
> > +     }
> > +
> > +     if (avm_wasp_netboot_mdio_read(avmwasp, 0)
> > +                                             !=3D WASP_RESP_OK) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error: WASP processor not ready\n");
> > +
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret =3D request_firmware_direct((const struct firmware **)
> > +                                     &avmwasp->eeprom_blob,
> > +             avmwasp->netboot_firmware, &avmwasp->pdev->dev);
> > +     if (ret) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Could not find network boot firmware\n");
> > +             return -ENOENT;
> > +     }
> > +
> > +     firmware =3D avmwasp->eeprom_blob->data;
> > +     firmware_end =3D firmware + avmwasp->eeprom_blob->size;
> > +
> > +     if (!firmware || avmwasp->eeprom_blob->size <=3D 0)
> > +             return -EFAULT;
>
> EINVAL?
>
> > +
> > +     if (avm_wasp_netboot_write_header(avmwasp, start_addr,
> > +                                       avmwasp->eeprom_blob->size,
> > +                                       exec_addr) < 0)
> > +             return -EFAULT;
> > +
> > +     if (avm_wasp_netboot_write_checksum(avmwasp,
> > +                                         avm_wasp_netboot_calc_checksu=
m
>
> Funny, this looks like a variable with the same name as the function,
> then I realized that you have the parameters on the next line.
>
> That's not helping anyone read this...
>
> > +                                         (avmwasp)) < 0)
> > +             return -EFAULT;
> > +
> > +     while (firmware < firmware_end) {
> > +             if ((firmware_end - firmware) >=3D WASP_CHUNK_SIZE) {
> > +                     if (avm_wasp_netboot_write_chunk(avmwasp, firmwar=
e,
> > +                                                      WASP_CHUNK_SIZE)=
 < 0)
> > +                             return -EFAULT;
> > +             } else {
> > +                     if (avm_wasp_netboot_write_chunk(avmwasp, firmwar=
e,
> > +                                                      (firmware_end -
> > +                                                      firmware)) < 0)
> > +                             return -EFAULT;
> > +             }
> > +             firmware +=3D WASP_CHUNK_SIZE;
> > +     }
>
> while (firmware < firmware_end) {
>         left =3D firmware_end - firmware;
>         if (left > WASP_CHUNK_SIZE)
>                 left =3D WASP_CHUNK_SIZE;
>
>         ret =3D avm_wasp_netboot_write_chunk(avmwasp, firmware, left);
>         if (ret < 0)
>                 return -EFAULT;
>
>         firmware +=3D left;
> }
>
>
> But not EFAULT...
>
> > +
> > +     mdelay(WASP_WAIT_SLEEP);
> > +
> > +     if (m_model =3D=3D MODEL_3390)
> > +             avm_wasp_netboot_mdio_write(avmwasp, 0,
> > +                                         WASP_CMD_START_FIRMWARE_3390)=
;
> > +     else if (m_model =3D=3D MODEL_X490)
> > +             avm_wasp_netboot_mdio_write(avmwasp, 0,
> > +                                         WASP_CMD_START_FIRMWARE_X490)=
;
> > +
> > +     avm_wasp_firmware_release(avmwasp);
> > +
> > +     mdelay(WASP_WAIT_SLEEP);
> > +     count =3D 0;
> > +
> > +     while ((avm_wasp_netboot_mdio_read(avmwasp, 0)
> > +                     !=3D WASP_RESP_READY_TO_START) &&
> > +                     (count < WASP_WAIT_TIMEOUT_COUNT)) {
> > +             mdelay(WASP_WAIT_SLEEP);
> > +             count++;
> > +     }
> > +     if (count >=3D WASP_WAIT_TIMEOUT_COUNT) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Timed out waiting for WASP ready to start.\n");
> > +             return -EFAULT;
> > +     }
> > +
> > +     if (m_model =3D=3D MODEL_3390)
> > +             avm_wasp_netboot_mdio_write(avmwasp, 0,
> > +                                         WASP_CMD_START_FIRMWARE_3390)=
;
> > +     else if (m_model =3D=3D MODEL_X490)
> > +             avm_wasp_netboot_mdio_write(avmwasp, 0,
> > +                                         WASP_CMD_SET_CHECKSUM_X490);
> > +
> > +     mdelay(WASP_WAIT_SLEEP);
> > +
> > +     if (m_model =3D=3D MODEL_3390) {
> > +             count =3D 0;
> > +             while ((avm_wasp_netboot_mdio_read(avmwasp, 0) !=3D
> > +                    WASP_RESP_OK) &&
> > +                    (count < WASP_WAIT_TIMEOUT_COUNT)) {
> > +                     mdelay(WASP_WAIT_SLEEP);
> > +                     count++;
> > +             }
> > +             if (count >=3D WASP_WAIT_TIMEOUT_COUNT) {
> > +                     dev_err(&avmwasp->pdev->dev,
> > +                             "Timed out waiting for WASP OK.\n");
> > +                     return -EFAULT;
> > +             }
> > +             if (avm_wasp_netboot_write_chunk(avmwasp, mac_data,
> > +                                              WASP_CHUNK_SIZE) < 0) {
>
> ARRAY_SIZE(mac_data) seems more appropriate to denote help the reader
> understand that the right amount is actually referred to.
>
> > +                     dev_err(&avmwasp->pdev->dev,
> > +                             "Error sending MAC address!\n");
> > +                     return -EFAULT;
> > +             }
> > +     } else if (m_model =3D=3D MODEL_X490) {
> > +             cont =3D 1;
> > +             while (cont) {
> > +                     count =3D 0;
> > +                     while ((avm_wasp_netboot_mdio_read(avmwasp, 0)
> > +                                     !=3D WASP_RESP_OK) &&
> > +                                     (count < WASP_WAIT_TIMEOUT_COUNT)=
) {
> > +                             mdelay(WASP_WAIT_SLEEP);
> > +                             count++;
> > +                     }
> > +                     if (count >=3D WASP_WAIT_TIMEOUT_COUNT) {
> > +                             dev_err(&avmwasp->pdev->dev,
> > +                                     "Timed out waiting for WASP OK.\n=
");
> > +                             return -EFAULT;
>
> Timed out sounds like a ETIMEDOUT, not EFAULT.
>
> > +                     }
> > +                     regval =3D avm_wasp_netboot_mdio_read(avmwasp, 1)=
;
> > +                     regval2 =3D avm_wasp_netboot_mdio_read(avmwasp, 2=
);
> > +                     avm_wasp_netboot_mdio_write(avmwasp, 0,
> > +                                                 WASP_CMD_SET_CHECKSUM=
_X490
> > +                                                 );
> > +                     if (regval =3D=3D 0 && regval2 !=3D 0)
> > +                             cont =3D regval2;
> > +                     else
> > +                             cont--;
> > +             }
> > +
> > +             count =3D 0;
> > +             while ((avm_wasp_netboot_mdio_read(avmwasp, 0) !=3D
> > +                     WASP_RESP_OK) &&
> > +                     (count < WASP_TIMEOUT_COUNT)) {
> > +                     udelay(WASP_BOOT_SLEEP_US);
> > +                     count++;
> > +             }
>
> Another read_poll_timeout() like construct. Or perhaps the same?
>
> > +             if (count >=3D WASP_TIMEOUT_COUNT) {
> > +                     dev_err(&avmwasp->pdev->dev,
> > +                             "Error waiting for checksum OK response.\=
n");
> > +                     return -EFAULT;
> > +             }
> > +
> > +             avm_wasp_netboot_mdio_write(avmwasp, 1, 0x00);
> > +             avm_wasp_netboot_mdio_write(avmwasp, 0,
> > +                                         WASP_CMD_START_FIRMWARE2_X490=
);
> > +
> > +             regval =3D avm_wasp_netboot_mdio_read(avmwasp, 0);
> > +             if (regval !=3D WASP_RESP_OK) {
> > +                     dev_err(&avmwasp->pdev->dev,
> > +                             "Error starting WASP network boot: 0x%x\n=
",
> > +                             regval);
> > +                     return -EFAULT;
>
> EFAULT doesn't seem appropriate here either...
>
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * avm_wasp_load_initramfs_image() - load initramfs image to WASP
> > + * @avmwasp: pointer to drivers private avm_wasp_rproc structure
> > + *
> > + * Uses the lan port specified from DT to load the initramfs to
> > + * WASP after the network boot firmware was successfully started.
> > + * Communication is done by using raw sockets.
> > + * The port of the lantiq gswip device will be started if not
> > + * already up and running.
> > + * There are several commands and status values which are checked.
> > + * First a discovery packet is received and then each data packet
> > + * is acknowledged by the WASP network boot firmware.
> > + * First packet needs to prepend the load address and last packet
> > + * needs to append the execution address.
> > + *
> > + * Return: 0 on Success, -14 if errors with the WASP send protocol
> > + * have occurred or the error returned from the failed operating
> > + * system function or service
> > + */
> > +int avm_wasp_load_initramfs_image(struct avm_wasp_rproc *avmwasp)
> > +{
> > +     int done =3D 0;
>
> bool is a better type for booleans.
>
> > +     int reuse =3D 1;
> > +     int num_chunks =3D 0;
> > +     int chunk_counter =3D 1;
>
> These seems unsigned
>
> > +     int ret, packet_counter, data_offset;
>
> packet_counter sounds unsigned and data_offset sounds size_t.
>
> > +     int send_len =3D 0;
>
> size_t and first access is an assignment, so no need to initialize it
> here.
>
> > +     short interface_flags;
> > +     ssize_t numbytes;
> > +     ssize_t read;
>
> "read" isn't the best name for a variable to denote the chunk size to be
> sent.
>
> > +     const u8 *firmware;
> > +     const u8 *firmware_end;
> > +     struct wasp_packet *packet =3D (struct wasp_packet *)
> > +                     (avmwasp->recvbuf + sizeof(struct ethhdr));
> > +     struct ethhdr *recv_eh =3D (struct ethhdr *)avmwasp->recvbuf;
> > +     struct msghdr recv_socket_hdr;
> > +     struct kvec recv_vec;
> > +     struct ethhdr *send_eh =3D (struct ethhdr *)avmwasp->sendbuf;
> > +     struct sockaddr_ll send_socket_address;
> > +     struct msghdr send_socket_hdr;
> > +     struct kvec send_vec;
> > +     struct net_device *send_netdev;
> > +     struct sockaddr send_sock_addr;
> > +     struct timeval {
> > +             __kernel_old_time_t     tv_sec;
> > +             __kernel_suseconds_t    tv_usec;
> > +     } timeout;
>
> Don't we have one of these in the kernel headers somewhere?
>
> > +     time64_t start_time, current_time;
> > +
> > +     if (!avmwasp->linux_blob) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error accessing initramfs image");
> > +             goto err;
> > +     }
> > +
> > +     ret =3D sock_create_kern(&init_net, PF_PACKET, SOCK_RAW,
> > +                            htons(ETHER_TYPE_ATH_ECPS_FRAME),
> > +                            &avmwasp->recv_socket);
> > +     if (ret < 0) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error opening recv socket: %d", ret);
> > +             goto err;
> > +     }
> > +
> > +     ret =3D sock_setsockopt(avmwasp->recv_socket, SOL_SOCKET, SO_REUS=
EADDR,
> > +                           KERNEL_SOCKPTR(&reuse), sizeof(reuse));
> > +     if (ret < 0) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error SO_REUSEADDR recv socket: %d", ret);
> > +             goto err_recv;
> > +     }
> > +
> > +     ret =3D sock_setsockopt(avmwasp->recv_socket, SOL_SOCKET,
> > +                           SO_BINDTODEVICE,
> > +                           KERNEL_SOCKPTR(avmwasp->loader_port),
> > +                           IFNAMSIZ - 1);
> > +     if (ret < 0) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error SO_BINDTODEVICE recv socket: %d", ret);
> > +             goto err_recv;
> > +     }
> > +
> > +     timeout.tv_sec =3D 10;
> > +     timeout.tv_usec =3D 0;
> > +     ret =3D sock_setsockopt(avmwasp->recv_socket, SOL_SOCKET,
> > +                           SO_RCVTIMEO_OLD,
> > +                     KERNEL_SOCKPTR(&timeout), sizeof(timeout));
> > +     if (ret < 0) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error SO_RCVTIMEO recv socket: %d", ret);
> > +             goto err_recv;
> > +     }
> > +
> > +     ret =3D sock_create_kern(&init_net, AF_PACKET, SOCK_RAW, IPPROTO_=
RAW,
> > +                            &avmwasp->send_socket);
>
> Why do you need two sockets to do rx and tx?
>

I inherited the code and never questioned it, indeed, one socket is enough.

> > +     if (ret < 0) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error opening send socket: %d", ret);
> > +             goto err_recv;
> > +     }
> > +
> > +     timeout.tv_sec =3D 10;
> > +     timeout.tv_usec =3D 0;
> > +     ret =3D sock_setsockopt(avmwasp->send_socket, SOL_SOCKET,
> > +                           SO_SNDTIMEO_OLD,
> > +                     KERNEL_SOCKPTR(&timeout), sizeof(timeout));
> > +     if (ret < 0) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error SO_SNDTIMEO send socket: %d", ret);
> > +             goto err_send;
> > +     }
> > +
> > +     rcu_read_lock();
> > +     send_netdev =3D dev_get_by_name_rcu(sock_net(avmwasp->send_socket=
->sk),
> > +                                       avmwasp->loader_port);
> > +     if (send_netdev)
> > +             interface_flags =3D (short)dev_get_flags(send_netdev);
> > +     rcu_read_unlock();
> > +
> > +     if (IS_ERR_OR_NULL(send_netdev)) {
> > +             dev_err(&avmwasp->pdev->dev, "Error accessing net device.=
\n");
> > +             ret =3D -ENODEV;
> > +             goto err_send;
> > +     }
> > +
> > +     interface_flags |=3D IFF_PROMISC | IFF_UP | IFF_RUNNING;
>
> If !send_netdev interface_flags is uninitialized.
>

If !send_netdev I thought I will break out 3 lines above?

> > +     rtnl_lock();
> > +     ret =3D dev_change_flags(send_netdev, interface_flags, NULL);
>
> I'm not entirely familiar with the netdev API, but doesn't this up the
> interface? From your remoteproc start function?!
>

Yes it does, the receive fails with -11 after about 13 seconds when
only IFF_PROMISC and/or IFF_RUNNING is set.
Depending on if the switch/port is active at the time wasp is booted,
its only required if network is still down.
I thought if I reset the flags, I might bring it down while the boot
process brought it up in the mean time?!

Its the port/interface hard wired to the WASP. I hope that is ok,
because otherwise I don't know how to boot it.

> > +     rtnl_unlock();
> > +
> > +     if (ret) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error changing interface flags: %d\n", ret);
> > +             goto err_send;
> > +     }
> > +
> > +     avmwasp->ifindex =3D send_netdev->ifindex;
> > +     ret =3D dev_get_mac_address(&send_sock_addr,
> > +                               sock_net(avmwasp->send_socket->sk),
> > +                     avmwasp->loader_port);
> > +     if (ret < 0) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "Error getting mac address: %d\n", ret);
> > +             goto err_send;
> > +     }
> > +
> > +     memset(avmwasp->sendbuf, 0, BUF_SIZE);
> > +
> > +     memcpy(send_eh->h_dest, wasp_mac, sizeof(send_eh->h_dest));
> > +     send_eh->h_proto =3D ETHER_TYPE_ATH_ECPS_FRAME;
> > +     memcpy(send_eh->h_source, send_sock_addr.sa_data,
> > +            sizeof(send_eh->h_source));
> > +
> > +     start_time =3D ktime_get_seconds();
> > +
> > +     while (!done) {
> > +             current_time =3D ktime_get_seconds();
> > +             if ((current_time - start_time) > SEND_LOOP_TIMEOUT_SECON=
DS) {
>
> Isn't the socket io operations in this loop blocking? What prevents you
> from being stuck in one of those forever?
>

I have set send and receive timeout to 10 seconds. This works. I
tested it by not
copying the local interface mac, so the packets from WASP never arrive. In
combination with the check above, the loop breakout will always work after =
the
60 seconds I set for SEND_LOOP_TIMEOUT_SECONDS.

> > +                     dev_err(&avmwasp->pdev->dev,
>
> A local copy of dev would be nice to shorten these expressions.
>
> > +                             "Waiting for packet from WASP timed out.\=
n");
> > +                     ret =3D -EFAULT;
> > +                     goto err_send;
> > +             }
> > +
> > +             memset(&recv_vec, 0, sizeof(recv_vec));
> > +             memset(&recv_socket_hdr, 0, sizeof(recv_socket_hdr));
> > +             recv_vec.iov_base =3D avmwasp->recvbuf;
> > +             recv_vec.iov_len =3D BUF_SIZE;
> > +             numbytes =3D kernel_recvmsg(avmwasp->recv_socket,
> > +                                       &recv_socket_hdr, &recv_vec, 1,
> > +                                       BUF_SIZE, 0);
>
> Can you please help me understand how you know that the read message is
> from the correct sender and that it's a firmware load message?
>

There is one interface of the switch which is not externalized (fixed port)
and where the wasp is attached to. The socket is bound to that interface
using setsockopt.

I have used the receive socket as the only socket now. When it is created,
it uses htons(ETHER_TYPE_ATH_ECPS_FRAME), this is the ethernet
frame type that WASP netboot firmware sends and expects. So this is the
filter and the reason, that I never received any other packet type in the l=
oop
during my tests, even when attaching the device to my local network when
using the rmmod and modprobe commands for testing.

> > +
> > +             if (numbytes < 0) {
> > +                     dev_err(&avmwasp->pdev->dev,
> > +                             "Error receiving any packet or timeout: %=
d\n",
> > +                             numbytes);
> > +                     ret =3D -EFAULT;
> > +                     goto err_send;
> > +             }
> > +
> > +             if (numbytes < (sizeof(struct ethhdr) + WASP_HEADER_LEN))=
 {
> > +                     dev_err(&avmwasp->pdev->dev,
> > +                             "Packet too small, discard and continue.\=
n");
> > +                     continue;
> > +             }
> > +
> > +             if (recv_eh->h_proto !=3D ETHER_TYPE_ATH_ECPS_FRAME)
> > +                     continue;
> > +
> > +             memcpy(wasp_mac, recv_eh->h_source, sizeof(wasp_mac));
> > +             memset(&avmwasp->s_packet, 0, sizeof(avmwasp->s_packet));
> > +
> > +             if (packet->packet_start =3D=3D PACKET_START) {
>
> And if the received message doesn't start with PACKET_START you simply
> discard it?
>

Yes, the default for the switch is continue, so it goes back to the
top of the loop,
but it will exit the loop after 60 seconds as mentioned above. This
actually never
occurred so far.

> > +                     switch (packet->response) {
> > +                     case RESP_DISCOVER:
> > +                             packet_counter =3D 0;
> > +                             firmware =3D avmwasp->linux_blob->data;
> > +                             firmware_end =3D firmware
> > +                                             + avmwasp->linux_blob->si=
ze;
> > +
> > +                             chunk_counter =3D 1;
> > +                             num_chunks =3D
> > +                                     avmwasp->linux_blob->size / CHUNK=
_SIZE;
> > +                             if (avmwasp->linux_blob->size % CHUNK_SIZ=
E !=3D 0)
> > +                                     num_chunks++;
>
> DIV_ROUND_UP()
>
> > +                     break;
>
> Please indent the break to match the code block.
>
> > +                     case RESP_OK:
> > +                             /* got reply send next packet */
>
> So when you receive RESP_DISCOVER or RESP_OK you will do the second half
> of this function and send out a chunk of data?
>

Yes. Earlier I have put the second half into RESP_OK, but that did not work=
.

> Seems like this would be better represented by falling through from the
> RESP_DISCOVER and put the send logic in RESP_OK.
>

I see, so doing RESP_DISCOVER without break; and then start with RESP_OK
and the logic there?

> > +                     break;
> > +                     case RESP_ERROR:
> > +                             dev_err(&avmwasp->pdev->dev,
> > +                                     "Received an WASP error packet!\n=
");
> > +                             ret =3D -EFAULT;
> > +                             goto err_send;
> > +                     break;
> > +                     case RESP_STARTING:
> > +                             done =3D 1;
> > +                             ret =3D 0;
> > +                             continue;
> > +                     break;
> > +                     default:
> > +                             dev_err(&avmwasp->pdev->dev,
> > +                                     "Unknown packet! Continue.\n");
> > +                             continue;
> > +                     break;
> > +                     }
> > +
> > +                     if (packet_counter =3D=3D 0) {
> > +                             memcpy(avmwasp->s_packet.payload, &m_load=
_addr,
> > +                                    sizeof(m_load_addr));
> > +                             data_offset =3D sizeof(m_load_addr);
> > +                     } else {
> > +                             data_offset =3D 0;
> > +                     }
> > +
> > +                     if (firmware < firmware_end) {
>
> firmware and firmware_end are uninitialized if you get here without
> first reveiving a RESP_DISCOVER.
>
> > +                             if ((firmware_end - firmware) >=3D CHUNK_=
SIZE)
> > +                                     read =3D CHUNK_SIZE;
> > +                             else
> > +                                     read =3D firmware_end - firmware;
> > +                             memcpy(&avmwasp->s_packet.payload[data_of=
fset],
>
> s_packet isn't used outside this loop, so why is i statically part of
> the avmwasp struct? Why aren't these various properties just local
> variables?
>
> > +                                    firmware, read);
> > +                             firmware =3D firmware + CHUNK_SIZE;
> > +
> > +                             avmwasp->s_packet.packet_start =3D PACKET=
_START;
> > +                             if (chunk_counter =3D=3D num_chunks) {
> > +                                     avmwasp->s_packet.response =3D
> > +                                                     CMD_START_FIRMWAR=
E;
> > +                                     memcpy(&avmwasp->s_packet.payload
> > +                                            [data_offset + read],
> > +                                            &m_load_addr, sizeof(m_loa=
d_addr));
>
> So m_load_addr goes in the first 4 bytes and the last 4 bytes of the
> message?
>

Yes, its the kernel start address, whereas the addresses used for mdio
are unmapped addresses.

> > +                                     data_offset +=3D sizeof(m_load_ad=
dr);
> > +                             } else {
> > +                                     avmwasp->s_packet.command =3D
> > +                                                     CMD_FIRMWARE_DATA=
;
> > +                             }
> > +                             avmwasp->s_packet.counter =3D packet_coun=
ter;
> > +
> > +                             memcpy(avmwasp->sendbuf + sizeof(struct e=
thhdr),
> > +                                    avmwasp->s_packet.data,
> > +                                    WASP_HEADER_LEN + read + data_offs=
et);
> > +                             send_len =3D sizeof(struct ethhdr)
> > +                                     + WASP_HEADER_LEN + read + data_o=
ffset;
> > +                             send_socket_address.sll_halen =3D ETH_ALE=
N;
> > +                             send_socket_address.sll_ifindex =3D
> > +                                                     avmwasp->ifindex;
>
> This doesn't seem to change within the loop, can't this be prepared
> outside the loop?
>

I have tried that, then the send did not work, but I have not checked why.
I will do a hexdump before and after and see what has changed, maybe
just a field needs to be reset.

> > +
> > +                             memset(&send_vec, 0, sizeof(send_vec));
> > +                             send_vec.iov_len =3D send_len;
> > +                             send_vec.iov_base =3D avmwasp->sendbuf;
> > +
> > +                             memset(&send_socket_hdr, 0,
> > +                                    sizeof(send_socket_hdr));
> > +                             send_socket_hdr.msg_name =3D (struct sock=
addr *)
> > +                                                     &send_socket_addr=
ess;
> > +                             send_socket_hdr.msg_namelen =3D
> > +                                     sizeof(struct sockaddr_ll);
>
> Same as send_socket_address.
>
> > +
> > +                             ret =3D kernel_sendmsg(avmwasp->send_sock=
et,
> > +                                                  &send_socket_hdr,
> > +                                                  &send_vec,
> > +                                                  1, send_len);
> > +                             if (ret < 0) {
> > +                                     dev_err(&avmwasp->pdev->dev,
> > +                                             "Error sending to WASP %d=
\n",
> > +                                             ret);
> > +                                     goto err_send;
> > +                             }
> > +
> > +                             packet_counter +=3D COUNTER_INCR;
>
> Isn't packet_counter always 4 * (chunk_counter - 1)? Why the factor 4?
> Can the two counters be consolidated?
>
> > +                             chunk_counter++;
> > +                     }
> > +             }
> > +     }
> > +
> > +err_send:
> > +     avmwasp->send_socket->ops->release(avmwasp->send_socket);
> > +err_recv:
> > +     avmwasp->recv_socket->ops->release(avmwasp->recv_socket);
> > +err:
> > +     return ret;
> > +}
> > +
> > +/**
> > + * avm_wasp_rproc_start() - start the remote processor
> > + * @rproc: pointer to the rproc structure
> > + *
> > + * Starts the remote processor by turning it on using the startup
> > + * gpio and initiating the reset process using the reset_gpio.
> > + * After that the status is checked if poweron and reset were
> > + * successful.
> > + * As the first step, the network boot firmware is tried to be loaded
> > + * and started.
> > + * As a second step, the initramfs image is tried to be loaded
> > + * and started.
> > + *
> > + * Return: 0 on Success, -19 or return code from the called function
> > + * if any other error occurred in the process of starting and loading
> > + * the firmware files to the WASP processor
> > + */
> > +static int avm_wasp_rproc_start(struct rproc *rproc)
> > +{
> > +     struct avm_wasp_rproc *avmwasp =3D rproc->priv;
> > +     int ret;
> > +
> > +     gpio_set_value(avmwasp->startup_gpio,
> > +                    (avmwasp->s_gpio_flg & OF_GPIO_ACTIVE_LOW) ?
> > +                    0 : 1);
>
> As I say below, gpiod_get() will grab you a reference to the gpio and
> based on the DT flags it will handle "active high" vs "active low" for
> you, all you need to pass here is "is it high or low" (1 or 0).
>
> > +     mdelay(WASP_WAIT_SLEEP);
> > +     gpio_set_value(avmwasp->reset_gpio,
> > +                    (avmwasp->r_gpio_flg & OF_GPIO_ACTIVE_LOW) ?
> > +                    1 : 0);
> > +     mdelay(WASP_WAIT_SLEEP);
> > +     gpio_set_value(avmwasp->reset_gpio,
> > +                    (avmwasp->r_gpio_flg & OF_GPIO_ACTIVE_LOW) ?
> > +                    0 : 1);
> > +     mdelay(WASP_WAIT_SLEEP);
> > +
> > +     avmwasp->mdio_bus =3D mdio_find_bus(avmwasp->mdio_bus_id);
> > +     if (!avmwasp->mdio_bus) {
> > +             dev_err(&avmwasp->pdev->dev,
> > +                     "wasp-netboot-mdio bus not found\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret =3D avm_wasp_netboot_load_firmware(avmwasp);
> > +     if (ret) {
> > +             put_device(&avmwasp->mdio_bus->dev);
> > +             return ret;
>
> How about putting the chip back in reset here?
>
> > +     }
> > +
> > +     put_device(&avmwasp->mdio_bus->dev);
> > +
> > +     ret =3D avm_wasp_load_initramfs_image(avmwasp);
> > +     if (ret)
>
> And here?
>
> > +             return ret;
> > +
> > +     return 0;
>
> if (ret)
>         return ret;
> return 0;
>
> Can succinctly be written "return ret;"
>
> > +}
> > +
> > +/**
> > + * avm_wasp_rproc_stop() - stop the remote processor
> > + * @rproc: pointer to the rproc structure
> > + *
> > + * To stop the remote processor just the startup gpio is set to 0
> > + * and the WASP processor is powered off
> > + *
> > + * Return: 0 on Success
> > + */
> > +static int avm_wasp_rproc_stop(struct rproc *rproc)
> > +{
> > +     struct avm_wasp_rproc *avmwasp =3D rproc->priv;
> > +
> > +     gpio_set_value(avmwasp->startup_gpio,
> > +                    (avmwasp->s_gpio_flg & OF_GPIO_ACTIVE_LOW) ?
> > +                    1 : 0);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * avm_wasp_rproc_load() - noop to avoid the ELF binary defaults
> > + * @rproc: pointer to the rproc structure
> > + * @fw: pointer to firmware struct
> > + *
> > + * If a load function is not defined in the rproc_ops, then all the se=
ttings
> > + * like checking the firmware binary will default to ELF checks, which=
 fail
> > + * in case of the bootable and compressed initramfs image for WASP.
> > + * Furthermore during boot its just required to send the firmware to t=
he WASP
> > + * processor, its not required to keep it in local memory, as the WASP=
 SoC
> > + * has its own memory.
> > + *
> > + * Return: Always 0
> > + */
> > +static int avm_wasp_rproc_load(struct rproc *rproc, const struct firmw=
are *fw)
>
> If you have to load all your firmware in start() we should come up with
> a different way to signal that the default ELF loader should be used, so
> that you can skip specifying load().
>

I have moved the set of the firmware to the priv to this method and removed
the avm_wasp_rproc_boot_addr and this works.
I also removed the netboot firmware load from probe and put it into the
netboot method which also eliminated some of the checks.

> > +{
> > +     return 0;
> > +}
> > +
> > +/**
> > + * avm_wasp_rproc_boot_addr() - store fw from framework in priv
> > + * @rproc: pointer to the rproc structure
> > + * @fw: pointer to firmware struct
> > + *
> > + * Even though firmware files can be loaded without the remote process=
or
> > + * framework, it expects at least one firmware file.
> > + * This function stores the initramfs image that is loaded by the remo=
te
> > + * processor framework during boot process into the priv for access by
> > + * the initramfs load function avm_wasp_load_initramfs_image().
> > + *
> > + * Return: Address of initramfs image
> > + */
> > +static u64 avm_wasp_rproc_boot_addr(struct rproc *rproc,
> > +                                 const struct firmware *fw)
> > +{
> > +     struct avm_wasp_rproc *avmwasp =3D rproc->priv;
> > +
> > +     avmwasp->linux_blob =3D fw;
> > +
> > +     return (u64)((u32)fw->data);
>
> No, the boot_addr should denote that address where the remote processor
> is supposed to start executing code from. This is the lower 32 bits of a
> virtual address on the Linux side, and shortly after returning from this
> function fw->data will be released - making this a dangling "pointer".
>
> > +}
> > +
> > +static const struct rproc_ops avm_wasp_rproc_ops =3D {
> > +     .start          =3D avm_wasp_rproc_start,
> > +     .stop           =3D avm_wasp_rproc_stop,
> > +     .load           =3D avm_wasp_rproc_load,
> > +     .get_boot_addr  =3D avm_wasp_rproc_boot_addr,
> > +};
> > +
> > +static int avm_wasp_rproc_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct avm_wasp_rproc *avmwasp;
> > +     const char *fw_name;
> > +     struct rproc *rproc;
> > +     struct device_node *root_node;
> > +     int ret;
> > +     u32 phandle;
> > +     char *model;
> > +
> > +     root_node =3D of_find_node_by_path("/");
> > +     if (!root_node) {
> > +             dev_err(dev, "No root node in device tree.\n");
> > +             ret =3D -EFAULT;
> > +             goto err;
> > +     }
> > +
> > +     ret =3D of_property_read_string_index(root_node, "compatible",
> > +                                         0, (const char **)&model);
> > +     of_node_put(root_node);
> > +     if (ret) {
> > +             dev_err(dev, "No model in device tree.\n");
> > +             goto err;
> > +     }
> > +
> > +     /* check model of host device to determine WASP SoC type */
> > +     if (strstr(model, "3390")) {
> > +             m_model =3D MODEL_3390;
>
> Don't look at the top-level compatible, give your remoteproc node a
> specific compatible and use .data in the of_device_id and
> device_get_match_data() to get the right MODEL_*.
>
> > +     } else if (strstr(model, "490")) {
> > +             m_model =3D MODEL_X490;
> > +     } else {
> > +             dev_err(dev, "No WASP on device.\n");
> > +             ret =3D -EPERM;
> > +             goto err;
> > +     }
> > +
> > +     ret =3D of_property_read_string(dev->of_node, "wasp-initramfs-ima=
ge",
> > +                                   &fw_name);
> > +     if (ret) {
> > +             dev_err(dev, "No initramfs image for WASP filename given\=
n");
> > +             goto err;
> > +     }
> > +
> > +     rproc =3D devm_rproc_alloc(dev, "avm,wasp", &avm_wasp_rproc_ops,
> > +                              fw_name, sizeof(*avmwasp));
> > +     if (!rproc) {
> > +             ret =3D -ENOMEM;
> > +             goto err;
> > +     }
> > +
> > +     rproc->auto_boot =3D true;
> > +
> > +     avmwasp =3D rproc->priv;
> > +     avmwasp->rproc =3D rproc;
> > +     avmwasp->pdev =3D pdev;
> > +
> > +     ret =3D of_property_read_string(dev->of_node, "ath9k-firmware",
> > +                                   &fw_name);
> > +     if (ret) {
> > +             dev_err(dev, "No ath9k firmware filename given\n");
> > +             goto err;
> > +     }
> > +
> > +     ret =3D avm_wasp_firmware_request(avmwasp, fw_name);
> > +     if (ret) {
> > +             dev_err(dev, "Could not load ath9k firmware\n");
> > +             goto err;
> > +     }
> > +     avm_wasp_firmware_release(avmwasp);
>
> You shouldn't attempt to load the firmware from your probe, the idea is
> that remoteproc will load "the firmware" and call load() for you to copy
> it in place and then call start() to make your core execute the loaded
> firmware.
>
> It seems like you have a bunch of firmware to load at start() time, but
> I don't think it's correct to try-load the firmware here and fail
> probe() if it's not in place.
>

After the load of caldata and ath9k eeprom, they are in the file system.
If they are not there, similar to other wifi drivers like the ath10k, a loa=
d
script is triggered, which will extract those files from the hardware's
bootloader partition.
But I wonder if I need to wait for initramfs here, but remoteproc seems
to be pretty late loaded.
Its only needed once, that was the reason for putting it into probe.
But I have removed failing when they are not there. Should the failing
then just be a dev_warn?
Should the loads still be put somewhere else than probe?

> > +     if (m_model =3D=3D MODEL_X490) {
> > +             ret =3D of_property_read_string(dev->of_node, "ath10k-cal=
data",
> > +                                           &fw_name);
> > +             if (ret) {
> > +                     dev_err(dev, "No ath10k caldata filename given\n"=
);
> > +                     goto err;
> > +             }
> > +
> > +             ret =3D avm_wasp_firmware_request(avmwasp, fw_name);
> > +             if (ret) {
> > +                     dev_err(dev, "Could not load ath10k caldata\n");
> > +                     goto err;
> > +             }
> > +             avm_wasp_firmware_release(avmwasp);
> > +     }
> > +
> > +     ret =3D of_property_read_u32(dev->of_node, "wasp-initramfs-port",
> > +                                &phandle);
> > +     if (ret) {
> > +             dev_err(dev, "No wasp-initramfs-port given\n");
> > +             goto err;
> > +     } else {
>
> There's no need for else here, as your if-case returns a failure.
>
> > +             struct device_node *child =3D of_find_node_by_phandle(pha=
ndle);
> > +
> > +             if (!child) {
> > +                     dev_err(dev, "Get wasp-initramfs-port child faile=
d\n");
> > +                     ret =3D -ENODEV;
> > +                     goto err;
> > +             } else {
> > +                     ret =3D of_property_read_string(child, "label",
> > +                                                   (const char **)
> > +                                                   &avmwasp->loader_po=
rt);
> > +                     of_node_put(child);
> > +                     if (ret) {
> > +                             dev_err(dev,
> > +                                     "Get wasp-port-label failed\n");
> > +                             goto err;
> > +                     }
> > +             }
> > +     }
> > +
> > +     ret =3D of_property_read_u32(dev->of_node, "wasp-netboot-mdio",
> > +                                &phandle);
> > +     if (ret) {
> > +             dev_err(dev, "No wasp-netboot-mdio given\n");
> > +             goto err;
> > +     } else {
> > +             struct device_node *mdio_node =3D
> > +                                     of_find_node_by_phandle(phandle);
> > +
> > +             if (!mdio_node) {
> > +                     dev_err(dev, "Get wasp-netboot-mdio failed\n");
> > +                     ret =3D -ENODEV;
> > +                     goto err;
> > +             } else {
> > +                     avmwasp->mdio_bus =3D of_mdio_find_bus(mdio_node)=
;
> > +                     of_node_put(mdio_node);
> > +                     if (!avmwasp->mdio_bus) {
> > +                             dev_err(dev, "mdio bus not found\n");
> > +                             ret =3D -ENODEV;
> > +                             goto err;
> > +                     }
> > +                     avmwasp->mdio_bus_id =3D avmwasp->mdio_bus->id;
> > +                     put_device(&avmwasp->mdio_bus->dev);
>
> Why are you releasing the refcount of the device that you just found?
> Shouldn't this be held until you're no longer referencing it?
>

i thought I just save the mdio bus id to not having to do the of_... lookup
somewhere else and free it. Only reference it, when its needed and not
through the lifetime of the driver. After the WASP is started, the mdio
bus is not required anymore. Not even to stop it.
Should I move the lookup into the rproc_start method or do it otherwise?

> > +             }
> > +     }
> > +
> > +     avmwasp->startup_gpio =3D of_get_named_gpio_flags(dev->of_node,
> > +                                                     "startup-gpio",
> > +                                                     0,
> > +                                                     &avmwasp->s_gpio_=
flg);
> > +     if (!gpio_is_valid(avmwasp->startup_gpio)) {
> > +             dev_err(dev, "Request wasp-startup gpio failed\n");
> > +             ret =3D -ENODEV;
> > +             goto err;
> > +     } else {
> > +             ret =3D devm_gpio_request_one(dev, avmwasp->startup_gpio,
> > +                                         (avmwasp->s_gpio_flg &
> > +                                         OF_GPIO_ACTIVE_LOW) ?
> > +                                         GPIOF_OUT_INIT_LOW :
> > +                                         GPIOF_OUT_INIT_HIGH,
> > +                                         "wasp-startup");
> > +
> > +             if (ret) {
> > +                     dev_err(dev, "get wasp-startup gpio failed\n");
> > +                     goto err;
> > +             }
> > +     }
>
> avmwasp->startup_gpio =3D devm_gpio_get(dev, "startup", GPIOD_OUT_LOW);
> if (IS_ERR(avmwasp->startup_gpio)) {
>         ret =3D dev_err_probe(dev, PTR_ERR(avmwasp->startup_gpio), "faile=
d to get startup gpio\n");
>         goto err;
> }
>
> Would do all this, then depending on the gpio being specified
> GPIO_ACTIVE_HIGH or LOW gpio_set_value() will "flip" the value to make
> sure that 1 is active and 0 is inactive.
>
> I.e. you don't need s_gpio_flg or r_gpio_flg or the conditional in all
> of your gpio_set_value().
>
> > +
> > +     avmwasp->reset_gpio =3D of_get_named_gpio_flags(dev->of_node,
> > +                                                   "reset-gpio",
> > +                                                   0,
> > +                                                   &avmwasp->r_gpio_fl=
g);
> > +     if (!gpio_is_valid(avmwasp->reset_gpio)) {
> > +             dev_err(dev, "Request wasp-reset gpio failed\n");
> > +             ret =3D -ENODEV;
> > +             goto err_free_startup_gpio;
> > +     } else {
> > +             ret =3D devm_gpio_request_one(dev, avmwasp->reset_gpio,
> > +                                         (avmwasp->r_gpio_flg &
> > +                                         OF_GPIO_ACTIVE_LOW) ?
> > +                                         GPIOF_OUT_INIT_LOW :
> > +                                         GPIOF_OUT_INIT_HIGH,
> > +                                         "wasp-reset");
> > +
> > +             if (ret) {
> > +                     dev_err(dev, "get wasp-reset gpio failed\n");
> > +                     goto err_free_startup_gpio;
> > +             }
> > +     }
> > +
> > +     ret =3D of_property_read_string(dev->of_node, "wasp-netboot-firmw=
are",
> > +                                   (const char **)
> > +                                   &avmwasp->netboot_firmware);
> > +     if (ret) {
> > +             dev_err(dev, "No WASP network boot firmware filename give=
n\n");
> > +             goto err_free_reset_gpio;
> > +     }
> > +
> > +     ret =3D request_firmware_direct((const struct firmware **)
> > +                     &avmwasp->eeprom_blob, avmwasp->netboot_firmware,=
 dev);
>
> As above, I don't think you should request firmware here.
>

I have moved it to the rproc start method.

> > +     if (ret) {
> > +             dev_err(dev, "Could not load WASP network boot firmware\n=
");
> > +             goto err_free_reset_gpio;
> > +     }
> > +
> > +     if (avmwasp->eeprom_blob->size > 0xffff) {
> > +             dev_err(dev, "WASP network boot firmware too big\n");
> > +             ret =3D -EINVAL;
> > +             goto err_free_reset_gpio;
> > +     }
> > +
> > +     avm_wasp_firmware_release(avmwasp);
> > +
> > +     dev_set_drvdata(dev, rproc);
>
> platform_set_drvdata()
>
> > +
> > +     ret =3D devm_rproc_add(dev, rproc);
> > +     if (ret) {
> > +             dev_err(dev, "rproc_add failed\n");
> > +             goto err_free_reset_gpio;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_free_reset_gpio:
> > +     devm_gpio_free(&avmwasp->pdev->dev, avmwasp->reset_gpio);
> > +     gpio_set_value(avmwasp->startup_gpio,
> > +                    (avmwasp->s_gpio_flg & OF_GPIO_ACTIVE_LOW) ?
> > +                    1 : 0);
> > +err_free_startup_gpio:
> > +     devm_gpio_free(&avmwasp->pdev->dev, avmwasp->startup_gpio);
>
> The purpose of using devres allocations is that they will be
> automatically freed.
>
> > +err:
> > +     return ret;
> > +}
> > +
> > +static int avm_wasp_rproc_remove(struct platform_device *pdev)
> > +{
> > +     struct rproc *rproc =3D platform_get_drvdata(pdev);
> > +     struct avm_wasp_rproc *avmwasp =3D rproc->priv;
> > +
> > +     gpio_set_value(avmwasp->startup_gpio,
> > +                    (avmwasp->s_gpio_flg & OF_GPIO_ACTIVE_LOW) ?
> > +                    1 : 0);
> > +     mdelay(WASP_WAIT_SLEEP);
> > +     devm_gpio_free(&avmwasp->pdev->dev, avmwasp->startup_gpio);
> > +     devm_gpio_free(&avmwasp->pdev->dev, avmwasp->reset_gpio);
>
> As soon as you return from this function any devm allocated resources
> will be released. So there's no need for doing that here.
>
> > +
> > +     return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int avm_wasp_rpm_suspend(struct device *dev)
>
> Unused.
>
> > +{
> > +     return -EBUSY;
> > +}
> > +
> > +static int avm_wasp_rpm_resume(struct device *dev)
>
> Unused.
>
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +
> > +static const struct of_device_id avm_wasp_rproc_of_match[] =3D {
> > +     { .compatible =3D "avm,wasp", },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, avm_wasp_rproc_of_match);
> > +
> > +static struct platform_driver avm_wasp_rproc_driver =3D {
> > +     .probe =3D avm_wasp_rproc_probe,
> > +     .remove =3D avm_wasp_rproc_remove,
> > +     .driver =3D {
> > +             .name =3D "avm_wasp_rproc",
> > +             .of_match_table =3D avm_wasp_rproc_of_match,
> > +     },
> > +};
> > +
> > +module_platform_driver(avm_wasp_rproc_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("AVM WASP remote processor boot driver");
> > +MODULE_AUTHOR("Daniel Kestrel <kestrelseventyfour@gmail.com>");
> > diff --git a/drivers/remoteproc/avm_wasp.h b/drivers/remoteproc/avm_was=
p.h
>
> Are any of these definitions going to be used outside avm_wasp.c?
> If not they would be better to have at top of the c-file.
>
> Regards,
> Bjorn
>
> > new file mode 100644
> > index 000000000000..d0a4542b3420
> > --- /dev/null
> > +++ b/drivers/remoteproc/avm_wasp.h
> > @@ -0,0 +1,95 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2019-2020 Andreas B=C3=B6hler
> > + * Copyright (c) 2021-2022 Daniel Kestrel
> > + */
> > +
> > +#ifndef __AVM_WASP_H
> > +#define __AVM_WASP_H
> > +
> > +#define WASP_CHUNK_SIZE                      14
> > +#define M_REGS_WASP_INDEX_MAX                7
> > +
> > +#define WASP_ADDR                    0x07
> > +#define WASP_TIMEOUT_COUNT           1000
> > +#define WASP_WAIT_TIMEOUT_COUNT              20
> > +
> > +#define WASP_WRITE_SLEEP_US          20000
> > +#define WASP_WAIT_SLEEP                      100
> > +#define WASP_POLL_SLEEP_US           200
> > +#define WASP_BOOT_SLEEP_US           20000
> > +
> > +#define WASP_RESP_RETRY                      0x0102
> > +#define WASP_RESP_OK                 0x0002
> > +#define WASP_RESP_WAIT                       0x0401
> > +#define WASP_RESP_COMPLETED          0x0000
> > +#define WASP_RESP_READY_TO_START     0x0202
> > +#define WASP_RESP_STARTING           0x00c9
> > +
> > +#define WASP_CMD_SET_PARAMS          0x0c01
> > +#define WASP_CMD_SET_CHECKSUM_3390   0x0801
> > +#define WASP_CMD_SET_CHECKSUM_X490   0x0401
> > +#define WASP_CMD_SET_DATA            0x0e01
> > +#define WASP_CMD_START_FIRMWARE_3390 0x0201
> > +#define WASP_CMD_START_FIRMWARE_X490 0x0001
> > +#define WASP_CMD_START_FIRMWARE2_X490        0x0101
> > +
> > +static const u32 start_addr =3D 0xbd003000;
> > +static const u32 exec_addr =3D 0xbd003000;
> > +
> > +static u16 m_regs_wasp[] =3D {0x0, 0x2, 0x4, 0x6, 0x8, 0xA, 0xC, 0xE};
> > +
> > +static const char mac_data[WASP_CHUNK_SIZE] =3D {0xaa, 0xaa, 0xaa, 0xa=
a, 0xaa,
> > +             0xaa, 0x04, 0x20, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00};
> > +
> > +enum {
> > +     MODEL_3390,
> > +     MODEL_X490,
> > +     MODEL_UNKNOWN
> > +} m_model =3D MODEL_UNKNOWN;
> > +
> > +#define ETHER_TYPE_ATH_ECPS_FRAME    0x88bd
> > +#define BUF_SIZE                     1056
> > +#define COUNTER_INCR                 4
> > +#define SEND_LOOP_TIMEOUT_SECONDS    60
> > +
> > +#define MAX_PAYLOAD_SIZE             1028
> > +#define CHUNK_SIZE                   1024
> > +#define WASP_HEADER_LEN                      14
> > +
> > +#define PACKET_START                 0x1200
> > +#define CMD_FIRMWARE_DATA            0x0104
> > +#define CMD_START_FIRMWARE           0xd400
> > +
> > +#define RESP_DISCOVER                        0x0000
> > +#define RESP_CONFIG                  0x1000
> > +#define RESP_OK                              0x0100
> > +#define RESP_STARTING                        0x0200
> > +#define RESP_ERROR                   0x0300
> > +
> > +enum {
> > +     DOWNLOAD_TYPE_UNKNOWN =3D 0,
> > +     DOWNLOAD_TYPE_FIRMWARE,
> > +     DOWNLOAD_TYPE_CONFIG
> > +} m_download_type =3D DOWNLOAD_TYPE_UNKNOWN;
> > +
> > +static const u32 m_load_addr =3D 0x81a00000;
> > +
> > +static char wasp_mac[] =3D {0x00, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa};
> > +
> > +struct wasp_packet {
> > +     union {
> > +             u8 data[MAX_PAYLOAD_SIZE + WASP_HEADER_LEN];
> > +             struct __packed {
> > +                     u16     packet_start;
> > +                     u8      pad_one[5];
> > +                     u16     command;
> > +                     u16     response;
> > +                     u16     counter;
> > +                     u8      pad_two;
> > +                     u8      payload[MAX_PAYLOAD_SIZE];
> > +             };
> > +     };
> > +} __packed;
> > +
> > +#endif /* __AVM_WASP_H */
> > --
> > 2.17.1
> >
