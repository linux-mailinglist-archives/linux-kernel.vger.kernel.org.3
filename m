Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF63465C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355082AbhLBDOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:14:21 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41248
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355085AbhLBDOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:14:18 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CE2FA3F1BA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638414653;
        bh=zHxKgqsz/W5zhDsi0NKZRT7Kt274OKmQEBVDN7k/WW0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Zyk1hC7tBaw+cieMiMquna2rP2Z7fBLovc7usdfftJiTWfGmUpJRuex4vBR+tYhCE
         EJLrK++spiYYlQJBPy2bzOWeEobg2qkdOCd+7FA+mDRV3fM/j0RWsbNWqQvkREcNam
         AFKETIq4OVpANigBP/ngBaFcbruFiIZqnEoY1Ael67OS19Hwa7hiwmLcFiqXg2sCfE
         QDuf/7bY7VJWmXjRNkzgpq8fiBU1JVFFAhWN8tKEDo3Se1TwCDaIOhh+nHJ0W1bL+a
         cg9vxO74EMmVwAFmzK3InwMYeAy61IY77rzVMmw/vHwuXLDfs19wbXTZdKWYk4H/nH
         MZfPiB2Tre5Dw==
Received: by mail-ed1-f72.google.com with SMTP id t9-20020aa7d709000000b003e83403a5cbso22246265edq.19
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 19:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zHxKgqsz/W5zhDsi0NKZRT7Kt274OKmQEBVDN7k/WW0=;
        b=n0qjImZWIk6ube7VVD7upXDeq/xHbE/GMFaOJYRQKqc6uiWxLEm4sDfCewWSIf1IXZ
         pl65uu2QVfVk4fcQll2HfeeGj3wHnGrgqOymtWsowwwxyOpVsShQZSlKZC/rhKg5422g
         txrGD3FxA1i20rGJ70V+jsgvgPXdhGQge/kWfh9ZVvXd5GbX64prpDPnKmIseoaEP8Sd
         Z1qp6HtsC2ppwrRpG6BrIPJ46YHiu8MbWIKYmb+xBMbpux68Ou/BlQfkEV29gL3xYTy2
         BGWDRb1ekFJl/KFK4dYbPAO0GUnT9XsiP2F0M2S2BKLv8OYFVcBYvR6YLzABjra9wyqj
         JB/Q==
X-Gm-Message-State: AOAM532qu5G8VDAndSnGZDSBsr6Tnskh/aXI6kxvUPyfCswi1+UVbaCw
        fQLFK71X9dVRc1NzDCIWlYfTl3Sg/ygtwRzEU13YKAlepJtGhZx2CJ7UUVM9qDyIFYO+IeZXz95
        69JDK1jriTYE1KcMvl7SkOdR2aHH1brb5d/nKkAhWC7eMf6EfTmZG6Eq2pQ==
X-Received: by 2002:a17:906:9bf9:: with SMTP id de57mr12238012ejc.439.1638414653463;
        Wed, 01 Dec 2021 19:10:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyOBFTMsbG8fXTiDxAUAJ13kta9MR0+K86pko0yW0AJ1x1UHkxH81Aad14LiPdOn7WGbXApQ5c5x1b7CAdKRQ=
X-Received: by 2002:a17:906:9bf9:: with SMTP id de57mr12237982ejc.439.1638414653175;
 Wed, 01 Dec 2021 19:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20211126115652.1134230-1-kai.heng.feng@canonical.com>
 <745bd358-c34c-9deb-42e6-6f6a54fd3e2e@linux.intel.com> <CAAd53p7ta292yNKYBn3mtav-kPHwtd1GANy9bdCMXL=SPZK+kg@mail.gmail.com>
In-Reply-To: <CAAd53p7ta292yNKYBn3mtav-kPHwtd1GANy9bdCMXL=SPZK+kg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 2 Dec 2021 11:10:41 +0800
Message-ID: <CAAd53p7uifYjFL02fh9m97i89BucdHAwAf4SjgOJkw1XiZ5ezw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: core: Avoid doing warm reset on disconnect event
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>, Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:36 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Mon, Nov 29, 2021 at 6:18 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
> >
> > On 26.11.2021 13.56, Kai-Heng Feng wrote:
> > > Unplugging USB device may cause an incorrect warm reset loop:
> > > [  143.039019] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, =
portsc: 0x4202c0
> > > [  143.039025] xhci_hcd 0000:00:14.0: handle_port_status: starting us=
b2 port polling.
> > > [  143.039051] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0008
> > > [  143.039058] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x420=
2c0, return 0x4102c0
> > > [  143.039092] xhci_hcd 0000:00:14.0: clear port3 connect change, por=
tsc: 0x4002c0
> > > [  143.039096] usb usb2-port3: link state change
> > > [  143.039099] xhci_hcd 0000:00:14.0: clear port3 link state change, =
portsc: 0x2c0
> > > [  143.039101] usb usb2-port3: do warm reset
> > > [  143.096736] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0=
, return 0x2b0
> > > [  143.096751] usb usb2-port3: not warm reset yet, waiting 50ms
> > > [  143.131500] xhci_hcd 0000:00:14.0: Can't queue urb, port error, li=
nk inactive
> > > [  143.138260] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, =
portsc: 0x2802a0
> > > [  143.138263] xhci_hcd 0000:00:14.0: handle_port_status: starting us=
b2 port polling.
> > > [  143.160756] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x280=
2a0, return 0x3002a0
> > > [  143.160798] usb usb2-port3: not warm reset yet, waiting 200ms
> > >
> > > The warm reset is due to its PLS is in eSS.Inactive state. However, U=
SB
> > > 3.2 spec table 10-13 mentions "Ports can be disabled by either a faul=
t
> > > condition (disconnect event or other fault condition)", xHCI 1.2 spec
> > > table 5-27 also states that "This flag shall automatically be cleared=
 to
> > > =E2=80=980=E2=80=99 by a disconnect event or other fault condition." =
on PED.
> > >
> > > So use CSC =3D 0 and PED =3D 0 as indication that device is disconnec=
ting to
> > > avoid doing warm reset.
> >
> > My understanding is that PED =3D 0 in case of disconnect, error (PLS=3D=
Inactive), or
> > during active reset signalling. See xHCI Figure 4-27: USB3 Root Hub Por=
t State Machine.
> > signal states (0,0,0,0) are PP,CCS,PED,PR.
>
> I think it's 1,0,0,0? So for my case, the port is in Error state (PLS
> =3D Inactive, 1,0,0,0).
>
> >
> > I'm looking at a similar case where Inactive link is reported at discon=
nect for a while
> > before missing terminations are detected and link finally goes to RxDet=
ect.
>
> So the PLS goes from Inactive to RxDetect after a while?
> Is the case you are working on also EHL?
>
> >
> > If the port was reset immediately when Inactive link state was reported=
 the port stays stuck
> > in port reset.
> > This might have been related to the address0 locking issues recently fi=
xed.
> >
> > Anyway, to avoid the extra reset of a removed USB3 device I started pol=
ling the link state of
> > the Inactive link for some time before resetting it. This gives the lin=
k time to detect
> > missing terminations and go to RxDetect, and driver can skip the reset.
> >
> > Planning on upstreaming it, patch is here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/=
?h=3Dfix_avoid_disconnect_reset&id=3D72d20c026b7812d096c6b5184a3888894401c8=
29
>
> Thanks, let me test this out.

The result is negative, here's the relevant log:
[  128.219129] xhci_hcd 0000:00:14.0: Port change event, 2-2, id 18,
portsc: 0x4202c0
[  128.219143] xhci_hcd 0000:00:14.0: handle_port_status: starting port pol=
ling.
[  128.219201] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0004
[  128.219217] xhci_hcd 0000:00:14.0: Get port status 2-2 read:
0x4202c0, return 0x4102c0
[  128.219244] xhci_hcd 0000:00:14.0: clear port2 connect change,
portsc: 0x4002c0
[  128.219256] usb usb2-port2: link state change
[  128.219264] xhci_hcd 0000:00:14.0: clear port2 link state change,
portsc: 0x2c0
[  128.232326] xhci_hcd 0000:00:14.0: xhci_hub_status_data: stopping
port polling.
[  128.244356] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2c0,
return 0x2c0
[  128.244383] usb usb2-port2: Wait for inactive link disconnect detect
[  128.272342] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2c0,
return 0x2c0
[  128.272370] usb usb2-port2: Wait for inactive link disconnect detect
[  128.300348] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2c0,
return 0x2c0
[  128.300375] usb usb2-port2: Wait for inactive link disconnect detect
[  128.328342] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2c0,
return 0x2c0
[  128.328369] usb usb2-port2: Wait for inactive link disconnect detect
[  128.356343] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2c0,
return 0x2c0
[  128.356370] usb usb2-port2: Wait for inactive link disconnect detect
[  128.356374] usb usb2-port2: do warm reset, port only
[  128.377500] xhci_hcd 0000:00:14.0: Port change event, 1-2, id 2,
portsc: 0x206e1
[  128.377515] xhci_hcd 0000:00:14.0: handle_port_status: starting port pol=
ling.
[  128.377570] hub 1-0:1.0: state 7 ports 16 chg 0000 evt 0004
[  128.377586] xhci_hcd 0000:00:14.0: Get port status 1-2 read:
0x206e1, return 0x10101
[  128.377614] xhci_hcd 0000:00:14.0: clear port2 connect change, portsc: 0=
x6e1
[  128.377626] usb usb1-port2: status 0101, change 0001, 12 Mb/s
[  128.377636] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x6e1,
return 0x101
[  128.398304] xhci_hcd 0000:00:14.0: Port change event, 1-2, id 2,
portsc: 0x202a0
[  128.398319] xhci_hcd 0000:00:14.0: handle_port_status: starting port pol=
ling.
[  128.412343] xhci_hcd 0000:00:14.0: Get port status 1-2 read:
0x202a0, return 0x10100
[  128.412376] xhci_hcd 0000:00:14.0: clear port2 connect change, portsc: 0=
x2a0
[  128.416337] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2b0,
return 0x2b0
[  128.416368] usb usb2-port2: not warm reset yet, waiting 50ms
[  128.448341] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x2a0,
return 0x100
[  128.476335] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2f0,
return 0x2f0
[  128.476366] usb usb2-port2: not warm reset yet, waiting 200ms
[  128.480332] xhci_hcd 0000:00:14.0: xhci_hub_status_data: stopping
port polling.
[  128.484343] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x2a0,
return 0x100
[  128.520323] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x2a0,
return 0x100
[  128.556325] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x2a0,
return 0x100
[  128.556353] usb usb1-port2: debounce total 125ms stable 100ms status 0x1=
00
[  128.556366] hub 1-0:1.0: state 7 ports 16 chg 0000 evt 0004
[  128.556376] xhci_hcd 0000:00:14.0: Get port status 1-2 read: 0x2a0,
return 0x100
[  128.684329] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2f0,
return 0x2f0
[  128.684360] usb usb2-port2: not warm reset yet, waiting 200ms
[  128.892325] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2f0,
return 0x2f0
[  128.892357] usb usb2-port2: not warm reset yet, waiting 200ms
[  129.100317] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0x2f0,
return 0x2f0
[  129.100348] usb usb2-port2: not warm reset yet, waiting 200ms
[  129.100354] hub 2-0:1.0: port_wait_reset: err =3D -16
[  129.100358] usb usb2-port2: not enabled, trying warm reset again...


>
> Kai-Heng
>
> >
> > -Mathias
