Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2D4E8E72
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiC1Gx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbiC1GxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:53:21 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995E4527C7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 23:51:31 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220328065128epoutp04a3a92b444642000b472948061c33c64e~geM2jFHV71251912519epoutp04M
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:51:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220328065128epoutp04a3a92b444642000b472948061c33c64e~geM2jFHV71251912519epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648450288;
        bh=MEyFL6QFgLu6cPGYgezGjgpoPW1LK9PASALn89BW1LQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iURdj/GUYTqrEJDFH6oWnoRQRKuWwl8Kz3u8vULmdo/kZ6ZWsD6kyWy+EBQ8fcibY
         g0mr4Iw4neqmsGv9YBKCMRWLlF/BN+MzlVUjoA3zy5V7ZQeOWSVKtSCXCP6jDPUVbY
         R6muzaDMeaEiYPKPOHvurF6xDiCfE6ahy18ZUvyA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220328065127epcas2p254c6c41002b6dfdfa97c6cecbd27db0c~geM2HDwt61657316573epcas2p2P;
        Mon, 28 Mar 2022 06:51:27 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KRjyz5m8Cz4x9QT; Mon, 28 Mar
        2022 06:51:23 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.E0.16040.AEA51426; Mon, 28 Mar 2022 15:51:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220328065122epcas2p347901648650d90f67a503731fad04274~geMwxnJsS0290402904epcas2p3k;
        Mon, 28 Mar 2022 06:51:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220328065122epsmtrp2344ca167bd06d329c9b4034b57623be5~geMww7J9v0504805048epsmtrp2F;
        Mon, 28 Mar 2022 06:51:22 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-ef-62415aead703
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.8F.03370.9EA51426; Mon, 28 Mar 2022 15:51:21 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220328065121epsmtip1cfcda574d588766bd940767dc36d18d9~geMwmd9IQ2227622276epsmtip1M;
        Mon, 28 Mar 2022 06:51:21 +0000 (GMT)
Date:   Mon, 28 Mar 2022 15:49:56 +0900
From:   Oh Eomji <eomji.oh@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v1 3/3] sound: usb: Exynos usb audio offloading driver
Message-ID: <20220328064956.GA147461@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YjwutlpkvA6xubKy@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhe6rKMckg94FJhZXLh5ismhevJ7N
        YsqvpcwWl3fNYbM48Gcxm0Xnrn5Wiw3f1zI6sHts+NzE5rFz1l12j02rOtk89s9dw+6x7+0y
        No/1W66yeHzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr
        5OIToOuWmQN0kJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10v
        L7XEytDAwMgUqDAhO6Nv7muWgglnGSse3fNqYHw7n7GLkZNDQsBEouvpK7YuRi4OIYEdjBIf
        Pr1mgnA+MUo0zX4NlfnMKPFyx0W4lpZFx5ghErsYJa6+egPlPGGUmLj/PVALBweLgKrE9Vkc
        IA1sQOb0ZdvBmkUEjCX6z85iB6lnFrjBKLHv0zsWkISwgJfEguvbmEFsXgEdicWrdkLZghIn
        Zz4Bq+EU0JRY/OA0C8h8UQEViVcH60HmSAj0ckjs3tTDBnGdi8T6liusELawxKvjW9ghbCmJ
        z+/2QtUUSxxc8BzKrpF4e7AVqsZYYtazdrBDmQUyJPZO2MwKsktCQFniyC0WiDCfRMfhv+wQ
        YV6JjjYhiE4liUlNnUwQtoTEis9NULaHxPS5e8GmCwl8YZT4sohtAqP8LCSPzUKyDMLWkViw
        +xPbLKANzALSEsv/cUCYmhLrd+kvYGRdxSiWWlCcm55abFRgBI/s5PzcTYzgtKrltoNxytsP
        eocYmTgYDzFKcDArifDKnrVPEuJNSaysSi3Kjy8qzUktPsRoCoylicxSosn5wMSeVxJvaGJp
        YGJmZmhuZGpgriTO65WyIVFIID2xJDU7NbUgtQimj4mDU6qBqWbZK68z03zTm5UeRu16Pp/J
        RK69wim9ZUWE8Mo/Tls4LepmNzErKFU+n9tVsFZXbB/3xQmX59netPyUnbb1hmT/G5bM6g6W
        lLrQ/TfN9iZW7H+lNn2X//fNdtpd189v605hFeJsqGZ/ueB7nFqi6G/ttfd9w+LCrm7e8Muw
        fuPenHApgYh1+ikb05/bC4rkLZ/Ft/7Jeb5l6vGfGMTZV0wo3LFEZt7sjR7Kp/gnfDnfwnqS
        4fzFUp6dJTF6/+bG3y3ZU7aKcXslk+qkTUEJHHE2bomJOxkfM1R53BPWfLOPseWfuC6/ml/P
        5oTYpwkz793XWLf3wIcjBms85ga9+SfKZGR0Zuekjmk9J/SXK7EUZyQaajEXFScCABvZ2Ek0
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnO7LKMckg4avFhZXLh5ismhevJ7N
        YsqvpcwWl3fNYbM48Gcxm0Xnrn5Wiw3f1zI6sHts+NzE5rFz1l12j02rOtk89s9dw+6x7+0y
        No/1W66yeHzeJBfAHsVlk5Kak1mWWqRvl8CVceHZeraCC6cYK64s2MfWwHhsLmMXIyeHhICJ
        RMuiY8wgtpDADkaJVXfYIOISEgu6XjND2MIS91uOsHYxcgHVPGKUmNn6E6iZg4NFQFXi+iwO
        kBo2IHP6su1gM0UEjCX6z85iB6lnFrjFKLG2B2KZsICXxILr28CG8groSCxetZMZYugXRol5
        8w+xQyQEJU7OfMICYjMLaEnc+PeSCWQZs4C0xPJ/YMs4BTQlFj84zQISFhVQkXh1sH4Co+As
        JM2zkDTPQmhewMi8ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjODK0tHYw7ln1Qe8Q
        IxMH4yFGCQ5mJRFe2bP2SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1I
        LYLJMnFwSjUwnbjuLSJ5jS0m9CzjzLe7d8/+mXBlsmTELYOAN2wed8+7Po20zbb+ZxmZYfO0
        959p4/35JZZXrjsL1+T2+9guviq+9W/2Aq0G/lUeC/4zBn/NZ9jQeKDpq4foZ4N3Z+e9f8P9
        /WOqY5b30c9/Dz+5ohr9UkQs9pesemIUZ/qdkkfvjrfpzXl54HH31vT9VkdWWW51OPZG5JnI
        vO7Yj4wcx7L2cVfPmCFzoG5xi52rpWZ5zKce08dZ31eVTHbRMbViaKzdwsYmxX9uyr6bdoLa
        P7vW/g79wRrwXtJd3HZy1wMhk8+2LPud/3lWx10Smuj8J3Havsjnj994ch1p9JklfiXzwMIY
        s/8/3eX8o3d5KrEUZyQaajEXFScCAOzjkC77AgAA
X-CMS-MailID: 20220328065122epcas2p347901648650d90f67a503731fad04274
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----FxW1adctUC2Ba58hBscSmKlxeMgdXQkzmfCwtO.kn3Xz82SJ=_1e465_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324081350epcas2p227458cb1b530f04a9990bcfc8c3b5703
References: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
        <CGME20220324081350epcas2p227458cb1b530f04a9990bcfc8c3b5703@epcas2p2.samsung.com>
        <1648109444-196321-4-git-send-email-eomji.oh@samsung.com>
        <YjwutlpkvA6xubKy@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------FxW1adctUC2Ba58hBscSmKlxeMgdXQkzmfCwtO.kn3Xz82SJ=_1e465_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Mar 24, 2022 at 09:41:26AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 24, 2022 at 05:10:44PM +0900, Oh Eomji wrote:
> > This is for usb audio offloading. usb audio offloading processes usb
> > audio stream data directly from the audio box even if ap usb enters
> > suspend, there is no problem in stream data transmission. This obtains
> > power saving effect while using usb audio device.
> > 
> > AP usb and audio usb f/w communicate via AUDIO IPC. By performing AUDIO
> > IPC in the vendor operations, abox can access and control the xhci to
> > transmit the data directly.
> > 
> > The types of commands and data delivered through AUDIO IPC include the
> > following (AP USB <-> AUDIO USB f/w) :
> > 1. usb audio connection/disconnection status
> > 2. xhci memory information
> > 3. full descriptor for usb audio device
> > 4. UAC(usb audio class) control command
> > 
> > Signed-off-by: Oh Eomji <eomji.oh@samsung.com>
> > ---
> >  sound/usb/Kconfig            |   9 +
> >  sound/usb/Makefile           |   2 +
> >  sound/usb/exynos_usb_audio.c | 560 +++++++++++++++++++++++++++++++++++++++++++
> >  sound/usb/exynos_usb_audio.h | 150 ++++++++++++
> >  4 files changed, 721 insertions(+)
> >  create mode 100644 sound/usb/exynos_usb_audio.c
> >  create mode 100644 sound/usb/exynos_usb_audio.h
> > 
> > diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
> > index 059242f..70252a3 100644
> > --- a/sound/usb/Kconfig
> > +++ b/sound/usb/Kconfig
> > @@ -27,6 +27,15 @@ config SND_USB_AUDIO
> >  config SND_USB_AUDIO_USE_MEDIA_CONTROLLER
> >  	bool
> >  
> > +config SND_EXYNOS_USB_AUDIO
> > +	tristate "EXYNOS USB Audio offloading module"
> > +	depends on SND_USB_AUDIO
> > +	help
> > +	 Say Y here to include support for Exynos USB Audio ABOX offloading.
> > +
> > +	 To compile this driver as a module, choose M here: the module
> > +	 will be called exynos-usb-audio-offloading.
> > +
> >  config SND_USB_UA101
> >  	tristate "Edirol UA-101/UA-1000 driver"
> >  	select SND_PCM
> > diff --git a/sound/usb/Makefile b/sound/usb/Makefile
> > index 9ccb21a..bf019c7 100644
> > --- a/sound/usb/Makefile
> > +++ b/sound/usb/Makefile
> > @@ -28,6 +28,8 @@ snd-usbmidi-lib-objs := midi.o
> >  
> >  # Toplevel Module Dependency
> >  obj-$(CONFIG_SND_USB_AUDIO) += snd-usb-audio.o snd-usbmidi-lib.o
> > +obj-$(CONFIG_SND_EXYNOS_USB_AUDIO) += exynos-usb-audio-offloading.o
> > +exynos-usb-audio-offloading-y += exynos_usb_audio.o
> >  
> >  obj-$(CONFIG_SND_USB_UA101) += snd-usbmidi-lib.o
> >  obj-$(CONFIG_SND_USB_USX2Y) += snd-usbmidi-lib.o
> > diff --git a/sound/usb/exynos_usb_audio.c b/sound/usb/exynos_usb_audio.c
> > new file mode 100644
> > index 0000000..456cc78
> > --- /dev/null
> > +++ b/sound/usb/exynos_usb_audio.c
> > @@ -0,0 +1,560 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> 
> Are you sure about this license?  I have to ask, sorry.
> 
It's my mistake. I will fix it.

> > +/*
> > + *   USB Audio offloading Driver for Exynos
> > + *
> > + *   Copyright (c) 2017 by Kyounghye Yun <k-hye.yun@samsung.com>
> > + *
> > + */
> > +
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/ctype.h>
> > +#include <linux/usb.h>
> > +#include <linux/usb/audio.h>
> > +#include <linux/usb/audio-v2.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/io.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/completion.h>
> > +
> > +#include <sound/pcm.h>
> > +#include "../../../sound/usb/exynos_usb_audio.h"
> 
> Did this patch just break the build?  It should not need this type of
> .../../../ mess.
> 
Build succedded. But yes it's mess. I will fix it.

> > +#include "usbaudio.h"
> > +#include "helper.h"
> > +#include "card.h"
> > +#include "quirks.h"
> > +
> > +static struct exynos_usb_audio *usb_audio;
> > +static struct snd_usb_audio_vendor_ops exynos_usb_audio_ops;
> > +
> > +struct hcd_hw_info *g_hwinfo;
> > +EXPORT_SYMBOL_GPL(g_hwinfo);
> > +int otg_connection;
> > +EXPORT_SYMBOL_GPL(otg_connection);
> > +int usb_audio_connection;
> > +EXPORT_SYMBOL_GPL(usb_audio_connection);
> 
> Why are these exported?  Who uses them?  And why generic names for a
> driver-specific variable?  And what do they do and how are they
> accessed?
> 
> No one in this patch series needs these exports, so why are they
> exported?
> 
Right. I'll fix it.

> > +
> > +static void exynos_usb_audio_set_device(struct usb_device *udev)
> > +{
> > +	usb_audio->udev = udev;
> > +	usb_audio->is_audio = 1;
> 
> boolean?
> 
> How do you know?  Did you check?
> 
> And why a single static variable?
> 
1 : connection / 0 : disconnection
Should I change this type to boolean?

> > +}
> > +
> > +static int exynos_usb_audio_unmap_all(void)
> > +{
> > +	/*
> > +	 * TODO: unmapping pcm buffer, usb descriptor, Device Context,
> > +	 * Input Context, ERST, URAM.
> > +	 */
> 
> If this is not completed, just don't have the function at all.
> 
> Why isn't this done?
>
Unmapping is performed using the AUDIO_IPC of the exynos audio module.
As mentioned in commit msg, AUDIO_IPC is a function for ap usb and audio
usb f/w communication, which is defined in exynos audio module.
So the contents performed through AUDIO_IPC were written in TODO.

> > +
> > +	return 0;
> > +}
> > +
> > +static int exynos_usb_audio_pcmbuf(struct usb_device *udev, int iface)
> > +{
> > +	if (!usb_audio->is_audio || !otg_connection)
> > +		return -1;
> 
> Do not make up error values.  Use correct ones.
> 
>
Okay, I will fix it.

> > +
> > +	/*
> > +	 * TODO: Transmit the DRAM address that contains the xhci device
> > +	 * information,and the DMA address required for operation to the abox
> > +	 * usb f/w.
> > +	 */
> 
> So this function does nothing?
> 
> Does this driver even work properly?  Where is the  missing logic?
> 
This is also performed using the AUDIO_IPC of the exynos audio module.
As mentioned above, the contents performed through AUDIO_IPC were
written in TODO.

> > +
> > +	return 0;
> > +}
> > +
> > +static int exynos_usb_audio_setrate(int iface, int rate, int alt)
> > +{
> > +	if (!usb_audio->is_audio || !otg_connection)
> > +		return -1;
> > +
> > +	/*
> > +	 * TODO: Notify the abox usb f/w the audio sample rate supported by
> > +	 * the interface of the connected audio device.
> > +	 */
> 
> Same as above.
> 
> Does this driver actually work on real hardware?  Or is this just a
> "fake" driver that is never intended for anyone to use just to allow the
> hooks to be added to the kernel tree?
> 
> What hardware has this driver worked on?  Can I take the pixel6 device
> today and replace their out-of-tree driver with this one and will it
> work properly?  If not, what is missing?
> 
This is also performed using the AUDIO_IPC of the exynos audio module.
As mentioned above, the contents performed through AUDIO_IPC were
written in TODO.
> > +
> > +	return 0;
> > +}
> > +
> > +static int exynos_usb_audio_setintf(struct usb_device *udev, int iface, int alt, int direction)
> > +{
> > +	struct hcd_hw_info *hwinfo = g_hwinfo;
> > +	u64 in_offset, out_offset;
> > +
> > +	if (!usb_audio->pcm_open_done)
> > +		return -EPERM;
> 
> How is that a permission error?
>
This means that the operation was not allowed because the pcm open was
not finished, so would it be better to change it to EBUSY or EIO?
> > +
> > +	if (!usb_audio->is_audio || !otg_connection)
> > +		return -1;
> 
> Again, no fake error numbers.
> 
Okay, I'll fix it.

> > +	if (direction) {
> > +		/* IN EP */
> > +		if (!usb_audio->indeq_map_done ||
> > +			(hwinfo->in_deq != hwinfo->old_in_deq)) {
> > +			/* TODO: Transmit pcm interface number, alt setting
> > +			 * number to abox usb f/w
> > +			 */
> 
> Fix all TODO please before resubmitting.
> 
This is also performed using the AUDIO_IPC of the exynos audio module.
As mentioned above, the contents performed through AUDIO_IPC were
written in TODO.
> > +			usb_audio->indeq_map_done = 1;
> > +			in_offset = hwinfo->in_deq % PAGE_SIZE;
> 
> Why does PAGE_SIZE matter?
> 
This is for page align. Audio maps memory for usb ipc. From the base
address, each memory is mapped in 4KB(page size) units.
When allocated through dma alloc, address is fiteed in page align, but
when allocated through trb buffer and kmalloc, address may not be fitted
in page align. So, the offset value (PA % PAGE_SIZE) is transmitted for
page align.
> > +		}
> > +
> > +		if (hwinfo->fb_out_deq) {
> > +			if (!usb_audio->fb_outdeq_map_done ||
> > +					(hwinfo->fb_out_deq != hwinfo->fb_old_out_deq)) {
> > +				/* TODO: Transmit pcm interface number,
> > +				 * alt setting number to abox usb f/w
> > +				 */
> > +				usb_audio->fb_outdeq_map_done = 1;
> > +				out_offset = hwinfo->fb_out_deq % PAGE_SIZE;
> > +			}
> > +		}
> > +	} else {
> > +		/* OUT EP */
> > +		if (!usb_audio->outdeq_map_done ||
> > +			(hwinfo->out_deq != hwinfo->old_out_deq)) {
> > +			/* TODO: Transmit pcm interface number, alt setting
> > +			 * number to abox usb f/w
> > +			 */
> > +			usb_audio->outdeq_map_done = 1;
> > +			out_offset = hwinfo->out_deq % PAGE_SIZE;
> > +		}
> > +
> > +		if (hwinfo->fb_in_deq) {
> > +			if (!usb_audio->fb_indeq_map_done ||
> > +					(hwinfo->fb_in_deq != hwinfo->fb_old_in_deq)) {
> > +				/* TODO: Transmit pcm interface number,
> > +				 * alt setting number to abox usb f/w
> > +				 */
> > +				usb_audio->fb_indeq_map_done = 1;
> > +				in_offset = hwinfo->fb_in_deq % PAGE_SIZE;
> > +			}
> > +		}
> > +	}
> > +
> > +	/* one more check connection to prevent kernel panic */
> > +	if (!usb_audio->is_audio || !otg_connection)
> > +		return -1;
> > +
> > +	/* TODO: Notify abox usb f/w a dequeue pointer */
> > +
> > +	return 0;
> > +}
> > +
> > +static int exynos_usb_audio_hcd(struct usb_device *udev)
> > +{
> > +	struct hcd_hw_info *hwinfo = g_hwinfo;
> > +
> > +	/* back up each address for unmap */
> > +	usb_audio->dcbaa_dma = hwinfo->dcbaa_dma;
> > +	usb_audio->save_dma = hwinfo->save_dma;
> > +	usb_audio->in_ctx = hwinfo->in_ctx;
> > +	usb_audio->out_ctx = hwinfo->out_ctx;
> > +	usb_audio->erst_addr = hwinfo->erst_addr;
> > +	usb_audio->speed = hwinfo->speed;
> > +	usb_audio->use_uram = hwinfo->use_uram;
> > +
> > +	/*
> > +	 * TODO: DCBAA, Device Context, Input Context, URAM, ERST mapping
> > +	 * and notify abox usb f/w the address about xhci h/w resource to
> > +	 * directly control the xhci in abox.
> > +	 */
> > +
> > +	return 0;
> > +}
> > +
> > +static int exynos_usb_audio_desc(struct usb_device *udev)
> > +{
> > +	int configuration, cfgno, i;
> > +	unsigned char *buffer;
> > +	u64 desc_addr;
> > +	u64 offset;
> > +
> > +	configuration = usb_choose_configuration(udev);
> > +
> > +	cfgno = -1;
> > +	for (i = 0; i < udev->descriptor.bNumConfigurations; i++) {
> > +		if (udev->config[i].desc.bConfigurationValue ==
> > +				configuration) {
> > +			cfgno = i;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (cfgno == -1)
> > +		cfgno = 0;
> > +
> > +	/* need to memory mapping for usb descriptor */
> > +	buffer = udev->rawdescriptors[cfgno];
> > +	desc_addr = virt_to_phys(buffer);
> > +	offset = desc_addr % PAGE_SIZE;
> > +
> > +	/* store address information */
> > +	usb_audio->desc_addr = desc_addr;
> > +	usb_audio->offset = offset;
> > +
> > +	desc_addr -= offset;
> > +
> > +	/*
> > +	 * TODO: Notify the abox usb f/w that all descriptors have been recived
> > +	 * from the connected usb audio device, and that copy and memory mapping
> > +	 * have beed completed so that it can be used in abox usb f/w
> > +	 */
> > +
> > +	return 0;
> > +}
> > +
> > +static int exynos_usb_audio_conn(struct usb_device *udev, int is_conn)
> > +{
> > +
> > +	/* TODO: Notify abox usb f/w whether usb device is connected or not */
> > +	if (!is_conn) {
> > +		if (usb_audio->is_audio) {
> > +			usb_audio->is_audio = 0;
> > +			usb_audio->usb_audio_state = USB_AUDIO_REMOVING;
> > +		}
> > +	} else {
> > +		cancel_work_sync(&usb_audio->usb_work);
> > +		usb_audio->indeq_map_done = 0;
> > +		usb_audio->outdeq_map_done = 0;
> > +		usb_audio->fb_indeq_map_done = 0;
> > +		usb_audio->fb_outdeq_map_done = 0;
> > +		usb_audio->pcm_open_done = 0;
> > +		reinit_completion(&usb_audio->discon_done);
> > +		usb_audio->usb_audio_state = USB_AUDIO_CONNECT;
> > +		usb_audio_connection = 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int exynos_usb_audio_pcm(bool is_open, bool direction)
> > +{
> > +	if (!usb_audio->is_audio || !otg_connection)
> > +		return -1;
> > +
> > +	if (is_open)
> > +		usb_audio->pcm_open_done = 1;
> > +
> > +	/* TODO: Notify the abox usb f/w the pcm open/close status */
> > +
> > +	return 0;
> > +}
> > +
> > +static void exynos_usb_audio_work(struct work_struct *w)
> > +{
> > +	/* Don't unmap in USB_AUDIO_TIMEOUT_PROBE state */
> > +	if (usb_audio->usb_audio_state != USB_AUDIO_REMOVING)
> > +		return;
> > +
> > +	exynos_usb_audio_unmap_all();
> > +	usb_audio->usb_audio_state = USB_AUDIO_DISCONNECT;
> > +	usb_audio_connection = 0;
> > +	complete(&usb_audio->discon_done);
> > +}
> > +
> > +static int exynos_usb_scenario_ctl_info(struct snd_kcontrol *kcontrol,
> > +			      struct snd_ctl_elem_info *uinfo)
> > +{
> > +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> > +	uinfo->count = 1;
> > +	uinfo->value.integer.min = AUDIO_MODE_NORMAL;
> > +	uinfo->value.integer.max = AUDIO_MODE_CALL_SCREEN;
> > +	return 0;
> > +}
> > +
> > +static int exynos_usb_scenario_ctl_get(struct snd_kcontrol *kcontrol,
> > +			 struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct exynos_usb_audio *usb = snd_kcontrol_chip(kcontrol);
> > +
> > +	ucontrol->value.integer.value[0] = usb->user_scenario;
> > +	return 0;
> > +}
> > +
> > +static int exynos_usb_scenario_ctl_put(struct snd_kcontrol *kcontrol,
> > +			 struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct exynos_usb_audio *usb = snd_kcontrol_chip(kcontrol);
> > +	int changed = 0;
> > +
> > +	if (usb->user_scenario !=
> > +	     ucontrol->value.integer.value[0]) {
> > +		usb->user_scenario = ucontrol->value.integer.value[0];
> > +		changed = 1;
> > +	}
> > +
> > +	return changed;
> > +}
> > +
> > +static int exynos_usb_add_ctls(struct snd_usb_audio *chip,
> > +				unsigned long private_value)
> > +{
> > +	struct snd_kcontrol_new knew = {
> > +		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
> > +		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> > +		.name = "USB Audio Mode",
> > +		.info = exynos_usb_scenario_ctl_info,
> > +		.get = exynos_usb_scenario_ctl_get,
> > +		.put = exynos_usb_scenario_ctl_put,
> > +	};
> > +
> > +	int err;
> > +
> > +	if (!chip)
> > +		return -ENODEV;
> > +
> > +	knew.private_value = private_value;
> > +	usb_audio->kctl = snd_ctl_new1(&knew, usb_audio);
> > +	if (!usb_audio->kctl)
> > +		return -ENOMEM;
> > +
> > +	err = snd_ctl_add(chip->card, usb_audio->kctl);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	return 0;
> > +}
> > +
> > +int exynos_usb_audio_init(struct device *dev, struct platform_device *pdev)
> > +{
> > +	struct device_node *np = dev->of_node;
> > +	struct device_node *np_abox;
> > +	struct platform_device *pdev_abox;
> > +	int ret = 0;
> > +
> > +	if (!usb_audio) {
> > +		usb_audio = kmalloc(sizeof(struct exynos_usb_audio), GFP_KERNEL);
> > +		if (!usb_audio)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	np_abox = of_parse_phandle(np, "abox", 0);
> > +	if (!np_abox)
> > +		return -EPROBE_DEFER;
> > +
> > +	pdev_abox = of_find_device_by_node(np_abox);
> > +	if (!pdev_abox)
> > +		return -EPROBE_DEFER;
> > +
> > +	init_completion(&usb_audio->in_conn_stop);
> > +	init_completion(&usb_audio->out_conn_stop);
> > +	init_completion(&usb_audio->discon_done);
> > +	usb_audio->abox = pdev_abox;
> > +	usb_audio->hcd_pdev = pdev;
> > +	usb_audio->udev = NULL;
> > +	usb_audio->is_audio = 0;
> > +	usb_audio->is_first_probe = 1;
> > +	usb_audio->user_scenario = AUDIO_MODE_NORMAL;
> > +	usb_audio->usb_audio_state = USB_AUDIO_DISCONNECT;
> > +	usb_audio_connection = 0;
> > +
> > +	INIT_WORK(&usb_audio->usb_work, exynos_usb_audio_work);
> > +
> > +	/* interface function mapping */
> > +	ret = snd_vendor_set_ops(&exynos_usb_audio_ops);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(exynos_usb_audio_init);
> 
> Why are you exporting functions that are never called?
> 
>
This function can be called exynos usb module driver.
> > +
> > +/* card */
> > +static int exynos_usb_audio_connect(struct usb_interface *intf)
> > +{
> > +	struct usb_interface_descriptor *altsd;
> > +	struct usb_host_interface *alts;
> > +	struct usb_device *udev = interface_to_usbdev(intf);
> > +	int timeout = 0;
> > +
> > +	alts = &intf->altsetting[0];
> > +	altsd = get_iface_desc(alts);
> > +
> > +	if ((altsd->bInterfaceClass == USB_CLASS_AUDIO ||
> > +		altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC) &&
> > +		altsd->bInterfaceSubClass == USB_SUBCLASS_MIDISTREAMING) {
> > +	} else {
> > +		if (usb_audio->usb_audio_state == USB_AUDIO_REMOVING) {
> > +			timeout = wait_for_completion_timeout(
> > +				&usb_audio->discon_done,
> > +				msecs_to_jiffies(DISCONNECT_TIMEOUT));
> > +
> > +			if ((usb_audio->usb_audio_state == USB_AUDIO_REMOVING)
> > +					&& !timeout) {
> > +				usb_audio->usb_audio_state =
> > +					USB_AUDIO_TIMEOUT_PROBE;
> > +			}
> > +		}
> > +
> > +		if ((usb_audio->usb_audio_state == USB_AUDIO_DISCONNECT)
> > +			|| (usb_audio->usb_audio_state == USB_AUDIO_TIMEOUT_PROBE)) {
> > +			exynos_usb_audio_set_device(udev);
> > +			exynos_usb_audio_hcd(udev);
> > +			exynos_usb_audio_conn(udev, 1);
> > +			exynos_usb_audio_desc(udev);
> > +		} else {
> > +			return -EPERM;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void exynos_usb_audio_disconn(struct usb_interface *intf)
> > +{
> > +	struct usb_device *udev = interface_to_usbdev(intf);
> > +
> > +	exynos_usb_audio_conn(udev, 0);
> > +}
> > +
> > +/* clock */
> > +static int exynos_usb_audio_set_interface(struct usb_device *udev,
> > +		struct usb_host_interface *alts, int iface, int alt)
> > +{
> > +	unsigned char ep;
> > +	unsigned char numEndpoints;
> > +	int direction;
> > +	int i;
> > +	int ret = 0;
> > +
> > +	if (alts != NULL) {
> > +		numEndpoints = get_iface_desc(alts)->bNumEndpoints;
> > +		if (numEndpoints < 1)
> > +			return -22;
> > +		if (numEndpoints == 1)
> > +			ep = get_endpoint(alts, 0)->bEndpointAddress;
> > +		else {
> > +			for (i = 0; i < numEndpoints; i++) {
> > +				ep = get_endpoint(alts, i)->bmAttributes;
> > +				if (!(ep & 0x30)) {
> > +					ep = get_endpoint(alts, i)->bEndpointAddress;
> > +					break;
> > +				}
> > +			}
> > +		}
> > +		if (ep & USB_DIR_IN)
> > +			direction = SNDRV_PCM_STREAM_CAPTURE;
> > +		else
> > +			direction = SNDRV_PCM_STREAM_PLAYBACK;
> > +
> > +		ret = exynos_usb_audio_setintf(udev, iface, alt, direction);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/* pcm */
> > +static int exynos_usb_audio_set_rate(int iface, int rate, int alt)
> > +{
> > +	int ret;
> > +
> > +	ret = exynos_usb_audio_setrate(iface, rate, alt);
> > +
> > +	return ret;
> > +}
> > +
> > +static int exynos_usb_audio_set_pcmbuf(struct usb_device *dev, int iface)
> > +{
> > +	int ret;
> > +
> > +	ret = exynos_usb_audio_pcmbuf(dev, iface);
> > +
> > +	return ret;
> > +}
> > +
> > +static int exynos_usb_audio_set_pcm_intf(struct usb_interface *intf,
> > +					int iface, int alt, int direction)
> > +{
> > +	struct usb_device *udev = interface_to_usbdev(intf);
> > +	int ret;
> > +
> > +	ret = exynos_usb_audio_setintf(udev, iface, alt, direction);
> > +
> > +	return ret;
> > +}
> > +
> > +static int exynos_usb_audio_pcm_control(struct usb_device *udev,
> > +			enum snd_vendor_pcm_open_close onoff, int direction)
> > +{
> > +	int ret = 0;
> > +
> > +	if (onoff == 1) {
> > +		ret = exynos_usb_audio_pcm(1, direction);
> > +	} else if (onoff == 0) {
> > +		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
> > +			reinit_completion(&usb_audio->out_conn_stop);
> > +		else if (direction == SNDRV_PCM_STREAM_CAPTURE)
> > +			reinit_completion(&usb_audio->in_conn_stop);
> > +
> > +		if (!usb_audio->pcm_open_done)
> > +			return 0;
> > +
> > +		ret = exynos_usb_audio_pcm(0, direction);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int exynos_usb_audio_add_control(struct snd_usb_audio *chip)
> > +{
> > +	int ret;
> > +
> > +	if (chip != NULL)
> > +		ret = exynos_usb_add_ctls(chip, 0);
> > +	else
> > +		ret = usb_audio->user_scenario;
> > +
> > +	return ret;
> > +}
> > +
> > +static int exynos_usb_audio_set_pcm_binterval(const struct audioformat *fp,
> > +				 const struct audioformat *found,
> > +				 int *cur_attr, int *attr)
> > +{
> > +	if (usb_audio->user_scenario >= AUDIO_MODE_IN_CALL) {
> > +		if (fp->datainterval < found->datainterval) {
> > +			found = fp;
> > +			cur_attr = attr;
> > +		}
> > +	} else {
> > +		if (fp->datainterval > found->datainterval) {
> > +			found = fp;
> > +			cur_attr = attr;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* Set interface function */
> > +static struct snd_usb_audio_vendor_ops exynos_usb_audio_ops = {
> > +	/* card */
> > +	.connect = exynos_usb_audio_connect,
> > +	.disconnect = exynos_usb_audio_disconn,
> > +	/* clock */
> > +	.set_interface = exynos_usb_audio_set_interface,
> > +	/* pcm */
> > +	.set_rate = exynos_usb_audio_set_rate,
> > +	.set_pcm_buf = exynos_usb_audio_set_pcmbuf,
> > +	.set_pcm_intf = exynos_usb_audio_set_pcm_intf,
> > +	.set_pcm_connection = exynos_usb_audio_pcm_control,
> > +	.set_pcm_binterval = exynos_usb_audio_set_pcm_binterval,
> > +	.usb_add_ctls = exynos_usb_audio_add_control,
> > +};
> > +
> > +int exynos_usb_audio_exit(void)
> > +{
> > +	/* future use */
> 
> What needs to be done here?
> 
It needs kfree. I wil ladd it to the next patch.
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(exynos_usb_audio_exit);
> 
> Why did you export a function that does nothing?
> 
I'll fix it.
> > +
> > +MODULE_AUTHOR("Jaehun Jung <jh0801.jung@samsung.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Exynos USB Audio offloading driver");
> > +
> > diff --git a/sound/usb/exynos_usb_audio.h b/sound/usb/exynos_usb_audio.h
> > new file mode 100644
> > index 0000000..13707744
> > --- /dev/null
> > +++ b/sound/usb/exynos_usb_audio.h
> > @@ -0,0 +1,150 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*   USB Audio Driver for Exynos
> > + *
> > + *   Copyright (c) 2017 by Kyounghye Yun <k-hye.yun@samsung.com>
> > + *
> > + */
> > +
> > +#ifndef __LINUX_USB_EXYNOS_AUDIO_H
> > +#define __LINUX_USB_EXYNOS_AUDIO_H
> > +
> > +#include "../../../sound/usb/usbaudio.h"
> > +
> > +/* for KM */
> > +
> > +#define USB_AUDIO_MEM_BASE	0xC0000000
> > +
> > +#define USB_AUDIO_SAVE_RESTORE	(USB_AUDIO_MEM_BASE)
> > +#define USB_AUDIO_DEV_CTX	(USB_AUDIO_SAVE_RESTORE+PAGE_SIZE)
> > +#define USB_AUDIO_INPUT_CTX	(USB_AUDIO_DEV_CTX+PAGE_SIZE)
> > +#define USB_AUDIO_OUT_DEQ	(USB_AUDIO_INPUT_CTX+PAGE_SIZE)
> > +#define USB_AUDIO_IN_DEQ	(USB_AUDIO_OUT_DEQ+PAGE_SIZE)
> > +#define USB_AUDIO_FBOUT_DEQ	(USB_AUDIO_IN_DEQ+PAGE_SIZE)
> > +#define USB_AUDIO_FBIN_DEQ	(USB_AUDIO_FBOUT_DEQ+PAGE_SIZE)
> > +#define USB_AUDIO_ERST		(USB_AUDIO_FBIN_DEQ+PAGE_SIZE)
> > +#define USB_AUDIO_DESC		(USB_AUDIO_ERST+PAGE_SIZE)
> > +#define USB_AUDIO_PCM_OUTBUF	(USB_AUDIO_MEM_BASE+0x100000)
> > +#define USB_AUDIO_PCM_INBUF	(USB_AUDIO_MEM_BASE+0x800000)
> > +
> > +#if defined(CONFIG_SOC_S5E9815)
> > +#define USB_AUDIO_XHCI_BASE	0x12210000
> > +#define USB_URAM_BASE		0x122a0000
> > +#define USB_URAM_SIZE		(SZ_1K * 24)
> > +#elif defined(CONFIG_SOC_S5E9935)
> > +#define USB_AUDIO_XHCI_BASE	0x10B00000
> > +#define USB_URAM_BASE		0x02a00000
> > +#define USB_URAM_SIZE		(SZ_1K * 24)
> 
> Shouldn't this information come from a DT file?
> 
>
Okay, I'll fix it.
> > +#else
> > +#error
> 
> Error what?
> 
I'll fix it
> > +#endif
> > +
> > +#define USB_AUDIO_CONNECT		(1 << 0)
> > +#define USB_AUDIO_REMOVING		(1 << 1)
> > +#define USB_AUDIO_DISCONNECT		(1 << 2)
> > +#define USB_AUDIO_TIMEOUT_PROBE	(1 << 3)
> 
> BIT()?
> 
Okay, I'll fix it.
> > +
> > +#define DISCONNECT_TIMEOUT	(500)
> > +
> > +#define AUDIO_MODE_NORMAL		0
> > +#define AUDIO_MODE_RINGTONE		1
> > +#define AUDIO_MODE_IN_CALL		2
> > +#define AUDIO_MODE_IN_COMMUNICATION	3
> > +#define AUDIO_MODE_CALL_SCREEN		4
> > +
> > +#define	CALL_INTERVAL_THRESHOLD		3
> > +
> > +#define USB_AUDIO_CONNECT		(1 << 0)
> > +#define USB_AUDIO_REMOVING		(1 << 1)
> > +#define USB_AUDIO_DISCONNECT		(1 << 2)
> > +#define USB_AUDIO_TIMEOUT_PROBE	(1 << 3)
> > +
> > +#define DISCONNECT_TIMEOUT	(500)
> 
> What units is this in?
> 
I'll fix it.
> > +
> > +struct host_data {
> > +	dma_addr_t out_data_dma;
> > +	dma_addr_t in_data_dma;
> > +	void *out_data_addr;
> > +	void *in_data_addr;
> 
> Why void pointers?  io pointers?
> 
I'll fix it.
> Again, does this code even work?
> 
> confused,
> 
> greg k-h
> 
This file shows the user functions using the audio vendor hooking interface.
Each function uses the AUDIO_IPC defined in the exynos audio module.
Since the exynos audio module is not in the mainline, the contents
performed in each function are writeen in TODO.

------FxW1adctUC2Ba58hBscSmKlxeMgdXQkzmfCwtO.kn3Xz82SJ=_1e465_
Content-Type: text/plain; charset="utf-8"


------FxW1adctUC2Ba58hBscSmKlxeMgdXQkzmfCwtO.kn3Xz82SJ=_1e465_--
