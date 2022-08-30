Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46B5A6DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiH3TuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiH3TuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:50:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1117E37;
        Tue, 30 Aug 2022 12:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661889005;
        bh=SoWzx77IQCm3NDWi+NdoQddonnC0+ombRYsETbGGbLU=;
        h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
        b=VubDD+HTa7e6HFBRTcwKKzALpMDNB7Jfl+y6FEtpVRi6/EJSG9KNkJkSXDt360eKK
         ySbROWa7CR1fsU54Ny/X3oGdc36cTkUhzlhz3VwFI0QcRnSheaDw88v9hgKFCeFfT5
         Ak66GF60ahCX3g/0Pyn9AuTaek+t0mmyryGHIDbE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.49] ([5.147.48.133]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrQEx-1pEGMc1QHv-00oUdP; Tue, 30
 Aug 2022 21:50:05 +0200
Message-ID: <edd97137-74a1-ee0b-d475-7c5b36197155@gmx.com>
Date:   Tue, 30 Aug 2022 21:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   jflf_kernel@gmx.com
Subject: Re: [PATCH] usb: add quirks for Lenovo OneLink+ Dock
To:     Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220824160946.10128-1-jflf_kernel@gmx.com>
 <31aeee3c-f4f1-16a8-272b-96da5d4a565e@suse.com>
 <d1a5f149-50a1-49fc-9a6d-eceffa23311b@gmx.com>
 <4b92eee0-b020-9211-2039-18ac3ac72a7b@suse.com>
Content-Language: en-US
In-Reply-To: <4b92eee0-b020-9211-2039-18ac3ac72a7b@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rJwoaBzqNKLIqlf6plkcfk9ESYPxsTShlqR69Z1gRu9JL+BrOpd
 CydfW6bYhxNL7Z9jXIeLQpeTLZPsQIqAaI7VehhcjOz1AHtH5nR9me7ZXBzpPoO/OXAruag
 nTzGjoqtqU32tIL9sF1t6U4JDKfAedp25D6vrGCmRMnditDLhy3j8WuEypsYVQLLg1iLGmT
 /MLsmL9cUEmCcqjKNjYXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:whRwQSkybiY=:hFaBrrUl8VcqUDV6pdyz59
 G62jA9KuiGJsDvbbrAXu8waayQ6eyixSy+rANMDvG/OtEDGnWN2NyEKruUQPHCywcCu7KQ53I
 FPf54KwmYGIU2vnQDuaPveExuptmMskM9o7H5/r0xkI0HqgjNoAhjPnvx5pu4j2miRn/TofdD
 dfDmAIjCyWxuWY0az7V8RuQsWAinjWncmqtCMP2oaiXV7RqIbmPsezIfdCGere5YcBQ7W05In
 sNP4luBFHc+sRBHgnL9UKL9GeVP2oCK6aSjDZ2sNP6+GZG+VEh5uxhhxf35VB6eGMmNVPkovM
 wTExH9kjNpGfBTPm9/cZBy8tq6LW92aI9gfVFtSDPEi0x9jKhixGVdmitajeAvLpfug/eCMj/
 77abhK14fp6WOT16XOl3N2Wfpm/gmxxcWZAju+me55vuymm+tEGMTa80aD925nsBwfj9RNDoF
 oN7/gAYQrdRd5B34hcTVMNpcAx7TUBaMz9BS2r3IhVBzT0uztWmfLXP3NAOEbCAzV76LdnDVC
 IvvWSOZlKEdSa7bndfKa0YPSJYdmeqFLFq+GmPpDwN+Vzu1nggc6HYif7PXL8AQ4LNG+YloWS
 w0A8GxcBjo2k9N7V/2lD5fj+pmYQxwfCDUYQUPVtjABB23N6E2Mt7gzFlk1klKGRekbN03Kkh
 OY7hgJxsu53gTgCYwTgCMhgSjKhde8QhfbudSEnvX3TC/TvhDY0G1QozxT75jiKpOKnRY+z+p
 zRU2BsYjJM2G6eiB7MLzNlh+9SLCJRU1Px0QYHbVMxxOU6gu2nIOOSwoGyhDRrHpPh1dHGWbd
 zZEmyI8CKt//CGRij5FBC83C3sHdJyjWRkbqdxcVu/C/mrd6x0xG4FhNYke4EHBT+y9CAI+mb
 GFlhUltwoNR5egUL+jJQhAtPHkVwgHfHAFCTmW0rWkxFe8kqq3c1Gq9K/6XNGEysB3Vsy12N8
 YplBDFzYacmeiidd2f8elUyv5yEpFnTji/KMhX5QcoZH9KuY35xmLA6mOqPZk2sE5BSYaE/mE
 qRbS0lD7yagzx/VMHNlaHe5kZqbOXxMcel42qx1/AxW26BCYqr2EUvcCtFwh+04KP35Oe2pvW
 o1MpNfmWd7Ra36dwvQpP3Y4HBIaYP7wzFHa3657P0StuQJFIlqYbI0ixA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/08/2022 16.47, Oliver Neukum wrote:

> 1) force a reset after a resume and call reset_resume() instead of resum=
e()
> 2) block autosuspend if remote wakeup is required
>
> I suspect you are actually using the second effect. Have you
> tested with "usbcore.autosuspend=3D-1" on the kernel command line.

After further testing, your suspicion is correct.

TL;DR: the two VL812 hubs don't behave well when suspended.

I'd like to prepare a better patch for that issue. What's the recommended =
strategy? The current patch works, even if only as a side effect and when =
there's a wakeup source downstream. It's currently in Greg KH's usb-linus =
branch, and will land in linux-next at some point. I'm tempted to let it b=
e and undo it later in the better patch. Is that acceptable? Or should I a=
sk Greg KH to pull it?


> The interesting test would be to see whether a keyboard, ethernet
> or mouse can wake your system from suspend. Have you tested WOL?

Right, a bit of background to understand what's going on with that dock.

There are actually three USB hubs in the dock: the two VL812, and a third =
Genesys Logic USB 2.0 only:

    $ lsusb -d 17ef:
    Bus 002 Device 005: ID 17ef:3054 Lenovo OneLink+ Giga
    Bus 002 Device 004: ID 17ef:1019 Lenovo USB3.0 Hub
    Bus 002 Device 002: ID 17ef:1018 Lenovo USB3.0 Hub
    Bus 001 Device 011: ID 17ef:3055 Lenovo ThinkPad OneLink Plus Dock Aud=
io
    Bus 001 Device 006: ID 17ef:1019 Lenovo USB2.0 Hub
    Bus 001 Device 004: ID 17ef:1018 Lenovo USB2.0 Hub

    $ lsusb -d 05e3:
    Bus 001 Device 007: ID 05e3:0608 Genesys Logic, Inc. Hub


    $ lsusb -tv | grep -B1 -e 17ef: -e 05e3:
        |__ Port 1: Dev 2, If 0, Class=3DHub, Driver=3Dhub/4p, 5000M
            ID 17ef:1018 Lenovo
            |__ Port 1: Dev 4, If 0, Class=3DHub, Driver=3Dhub/4p, 5000M
                ID 17ef:1019 Lenovo
                |__ Port 3: Dev 5, If 1, Class=3DCDC Data, Driver=3Dcdc_et=
her, 5000M
                    ID 17ef:3054 Lenovo
                |__ Port 3: Dev 5, If 0, Class=3DCommunications, Driver=3D=
cdc_ether, 5000M
                    ID 17ef:3054 Lenovo
    --
        |__ Port 6: Dev 4, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
            ID 17ef:1018 Lenovo
    --
            |__ Port 2: Dev 7, If 0, Class=3DHub, Driver=3Dhub/2p, 480M
                ID 05e3:0608 Genesys Logic, Inc. Hub
    --
            |__ Port 1: Dev 6, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
                ID 17ef:1019 Lenovo
                |__ Port 4: Dev 8, If 1, Class=3DAudio, Driver=3Dsnd-usb-a=
udio, 12M
                    ID 17ef:3055 Lenovo
                |__ Port 4: Dev 8, If 2, Class=3DAudio, Driver=3Dsnd-usb-a=
udio, 12M
                    ID 17ef:3055 Lenovo
                |__ Port 4: Dev 8, If 0, Class=3DAudio, Driver=3Dsnd-usb-a=
udio, 12M
                    ID 17ef:3055 Lenovo
                |__ Port 4: Dev 8, If 3, Class=3DHuman Interface Device, D=
river=3Dusbhid, 12M
                    ID 17ef:3055 Lenovo


The user-friendly port view (front and back refer to the locations of USB-=
A ports):

    1018  [p1] -->  1019  [p1] -->  USB3 back 4
       |               |  [p2] -->  USB3 back 3
       |               |  [p3] -->  USB3 RTL8153 ethernet
       |               |  [p4] -->  USB2 CM6533 audio
       |
       |  [p2] -->  GL850S  [p1] --> USB2 back 2
       |                 |  [p2] --> USB2 back 1 "keyboard/mouse"
       |
       |  [p3] -->  USB3 front 1 "power"
       |  [p4] -->  USB3 front 2


I have always kept keyboard and mouse on the USB2 ports connected to the G=
enesys Logic hub. They work there without any problem.

With WoL enabled in the BIOS, there are only two wakeup sources:

    $ grep . /sys/bus/usb/devices/*/power/wakeup | grep enabled
    /sys/bus/usb/devices/1-6.2.2/power/wakeup:enabled       # keyboard on =
GL850S
    /sys/bus/usb/devices/2-1.1.3/power/wakeup:enabled       # net

While suspended I can wake up the laptop with the keyboard and everything =
works.

Moving the keyboard to one of the VL812 ports moves the wakeup source::

    $ grep . /sys/bus/usb/devices/*/power/wakeup | grep enabled
    /sys/bus/usb/devices/1-6.1.1/power/wakeup:enabled       # keyboard on =
the :1019 VL812 (USB2)
    /sys/bus/usb/devices/2-1.1.3/power/wakeup:enabled       # net


Now here's the interesting bit. Without "usbcore.autosuspend=3D-1" I can s=
till wakeup the laptop from suspend, but after waking up the keyboard is g=
one:

    kernel: hub 1-6.1:1.0: hub_ext_port_status failed (err =3D -71)
    kernel: hub 1-6:1.0: hub_ext_port_status failed (err =3D -71)
    kernel: hub 1-6.1:1.0: hub_ext_port_status failed (err =3D -71)
    kernel: hub 1-6.1:1.0: hub_ext_port_status failed (err =3D -71)
    kernel: usb 1-6.1-port4: cannot disable (err =3D -71)
    kernel: usb 1-6.1-port1: cannot disable (err =3D -71)

After that the port to which the keyboard is connected is essentially dead=
. Replugging doesn't help, I need to shutdown the laptop (powered via the =
dock) and cut all power to the dock to get that port back to operational s=
tatus.

With "usbcore.autosuspend=3D-1", everything behaves as it should.

I met the exact same behaviour ("dead" port) with USB 3.0 devices too, alt=
hough in my experience so far only with bus-powered devices. Sample kernel=
 output:

    kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device =
command
    kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device =
command
    kernel: usb 2-1.4: device not accepting address 6, error -62
    kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device =
command
    kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device =
command
    kernel: usb 2-1.4: device not accepting address 7, error -62
    kernel: usb 2-1-port4: attempt power cycle
    kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device =
command
    kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device =
command
    kernel: usb 2-1.4: device not accepting address 8, error -62
    kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device =
command
    kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device =
command
    kernel: usb 2-1.4: device not accepting address 9, error -62
    kernel: usb 2-1-port4: unable to enumerate USB device


I'll run some more tests out of curiosity to see how things behave in corn=
er cases.

Thanks!
JF
