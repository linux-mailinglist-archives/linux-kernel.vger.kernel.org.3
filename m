Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39B147B908
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 04:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhLUDfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:35:41 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50324
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhLUDfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:35:40 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 46BC640036
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640057739;
        bh=OhRGiPQOMJbG5fFSyNm9dS9XBpdJVqMxhPKeM2l5YPg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=s8c3kMpCfXHZ5ZndIWzkQd8/yhJCGuYA9djtCRyeKSvOkVdvuwzhr1Xx4ZlGk2X5s
         6cMkTTwx2V1O8SWDAuRaypCYF5Q8UI6/VsEjhP+S/YwocgzRIOPjPcT3orZ88z85ux
         x10b/CozPgVpR9IouaoeM05NPNYCapKYLbOewICNKmPtroub6KzrKyfj0XjfhduBNE
         OKhYosZUhccl4iCUAc03pQOeNVTNSl/53K3vVBkPbXxqDnH2u30Fa0VF4HfQST5HL4
         TaubW4GczAKQQOzGgFcWbgp6kR1qNIwGmyM5NIBsPGoCk8NNxwrJw2Ft0yN/7qrabz
         4XsItslSMOieg==
Received: by mail-oi1-f198.google.com with SMTP id r65-20020aca4444000000b002bce52a8122so7540618oia.14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 19:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OhRGiPQOMJbG5fFSyNm9dS9XBpdJVqMxhPKeM2l5YPg=;
        b=mW88MygF8PhIsIprD92MBFjVONujhQbGnEaE4tRKIEx9fHR9u+pdqLUlmj1LWGJNXi
         BufhsPO+DxVyaTIZTAtAItD1m8+3ewE5cwrvA1k523wAw5LPRXxeA0QGB38takNmqUqD
         GrCCOzZKrfEru5aSNFZ9pzPaEy1eyfwB7yoDwVG510qh5WR0WCaXFTAuWF63JGKkvvGp
         5dIhlgBP5ZG5QUNXYdRKDB3ByS01bUlI4JfY5L5x3Af0HBe0f/AMl747wyn9uhBDvkhQ
         DnazPUNQW+bgLWy8yAOsWk+Un/4xCCQSMAM2eZyAhvG8B8dBZ7SFMGu/4zMcABl8+RrI
         b/6g==
X-Gm-Message-State: AOAM531Ci5pMnXRYaxeYDxLx4DqszptQRN9Xr98y9S6+z8SMshkgSm1O
        NOsxVOET2MMbLNykQAd0kwXf51WwBdLehr9TtYa8iZnpBn4L7qci7Gif+jd/FfMolqNNWgzW2bS
        CLiVWQ7v0oMpw3y0ZokcWic22yGEeHSts+pEaYWExsxJyIT5MUdR8rERKaw==
X-Received: by 2002:a4a:dec8:: with SMTP id w8mr762607oou.24.1640057736434;
        Mon, 20 Dec 2021 19:35:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1tp9FwPvBJwlrRCg6ODYiDS0mnnnYGCLICz6LJ7EyCBxCUxqXgi5TJ2lJAQGfWSn/SDrGr04wVaqQdKdMT/c=
X-Received: by 2002:a4a:dec8:: with SMTP id w8mr762596oou.24.1640057736111;
 Mon, 20 Dec 2021 19:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20211126115652.1134230-1-kai.heng.feng@canonical.com> <YaD9oubkHPzHtSY4@rowland.harvard.edu>
In-Reply-To: <YaD9oubkHPzHtSY4@rowland.harvard.edu>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 21 Dec 2021 11:35:25 +0800
Message-ID: <CAAd53p6uXBa2zms1M0aqvRhVWq-kNtw2LvgE5ai94NWMDi5rYQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: core: Avoid doing warm reset on disconnect event
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>, Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(


On Fri, Nov 26, 2021 at 11:30 PM Alan Stern <stern@rowland.harvard.edu> wro=
te:
>
> On Fri, Nov 26, 2021 at 07:56:51PM +0800, Kai-Heng Feng wrote:
> > Unplugging USB device may cause an incorrect warm reset loop:
> > [  143.039019] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, po=
rtsc: 0x4202c0
> > [  143.039025] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2=
 port polling.
> > [  143.039051] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0008
> > [  143.039058] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x4202c=
0, return 0x4102c0
> > [  143.039092] xhci_hcd 0000:00:14.0: clear port3 connect change, ports=
c: 0x4002c0
> > [  143.039096] usb usb2-port3: link state change
> > [  143.039099] xhci_hcd 0000:00:14.0: clear port3 link state change, po=
rtsc: 0x2c0
> > [  143.039101] usb usb2-port3: do warm reset
> > [  143.096736] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, =
return 0x2b0
> > [  143.096751] usb usb2-port3: not warm reset yet, waiting 50ms
> > [  143.131500] xhci_hcd 0000:00:14.0: Can't queue urb, port error, link=
 inactive
> > [  143.138260] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, po=
rtsc: 0x2802a0
> > [  143.138263] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2=
 port polling.
> > [  143.160756] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2802a=
0, return 0x3002a0
> > [  143.160798] usb usb2-port3: not warm reset yet, waiting 200ms
> >
> > The warm reset is due to its PLS is in eSS.Inactive state. However, USB
> > 3.2 spec table 10-13 mentions "Ports can be disabled by either a fault
> > condition (disconnect event or other fault condition)", xHCI 1.2 spec
> > table 5-27 also states that "This flag shall automatically be cleared t=
o
> > =E2=80=980=E2=80=99 by a disconnect event or other fault condition." on=
 PED.
> >
> > So use CSC =3D 0 and PED =3D 0 as indication that device is disconnecti=
ng to
> > avoid doing warm reset.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >  - Change the variable type to bool.
> >
> >  drivers/usb/core/hub.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index a9a04ea967019..4f081df70ecf2 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -5564,6 +5564,7 @@ static void port_event(struct usb_hub *hub, int p=
ort1)
> >               __must_hold(&port_dev->status_lock)
> >  {
> >       int connect_change;
> > +     bool disconnect =3D false;
> >       struct usb_port *port_dev =3D hub->ports[port1 - 1];
> >       struct usb_device *udev =3D port_dev->child;
> >       struct usb_device *hdev =3D hub->hdev;
> > @@ -5579,6 +5580,9 @@ static void port_event(struct usb_hub *hub, int p=
ort1)
> >       if (portchange & USB_PORT_STAT_C_CONNECTION) {
> >               usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_C_CONNE=
CTION);
> >               connect_change =3D 1;
> > +             if (!(portstatus & USB_PORT_STAT_CONNECTION) &&
> > +                 !(portstatus & USB_PORT_STAT_ENABLE))
> > +                     disconnect =3D true;
> >       }
>
> This looks a little strange.  Can there ever be a situation where
> PORT_STAT_CONNECTION is off and PORT_STAT_ENABLE is on?  (It's not allowe=
d in
> USB-2.)

Right, the spec only states PORT_STAT_ENABLE =3D 0. Will change that in
next revision.

>
> >       if (portchange & USB_PORT_STAT_C_ENABLE) {
> > @@ -5647,7 +5651,7 @@ static void port_event(struct usb_hub *hub, int p=
ort1)
> >        * Warm reset a USB3 protocol port if it's in
> >        * SS.Inactive state.
> >        */
> > -     if (hub_port_warm_reset_required(hub, port1, portstatus)) {
> > +     if (hub_port_warm_reset_required(hub, port1, portstatus) && !disc=
onnect) {
> >               dev_dbg(&port_dev->dev, "do warm reset\n");
> >               if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
> >                               || udev->state =3D=3D USB_STATE_NOTATTACH=
ED) {
>
> Why is it correct to skip doing a warm reset on a disconnected port here,=
 but not
> correct to skip doing a warm reset on a disconnected port in all the othe=
r places
> where hub_port_warm_reset_required() gets called?

Can a disconnect event happens to other places other than port_event()?

Kai-Heng

>
> Alan Stern
