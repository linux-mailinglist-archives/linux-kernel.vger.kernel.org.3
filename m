Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1238347D0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244628AbhLVLWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:22:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230007AbhLVLWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640172142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WyeSnwuE9oDZ0nvfKHg4dkrAZqN47nEkp3E+HseND8=;
        b=eI26bajddVmxXnQBoKDyWbENP+/Ah/IL5ywEtOJ89Ap7D63tEF0XTJT12anNE1gJi3JNR6
        RQamYehQwaU1gbpQ11lheh68sVWBVVN25CbcFlJGMDegAEivAfp1HkV1c8zhtmY60A4+WF
        Pkwqr6mLp07ol4WBlfZY30FVgER/yXo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-gXKcycV0NPSo1QkNaSqSdw-1; Wed, 22 Dec 2021 06:22:21 -0500
X-MC-Unique: gXKcycV0NPSo1QkNaSqSdw-1
Received: by mail-ed1-f70.google.com with SMTP id w10-20020a50d78a000000b003f82342a95aso1576198edi.22
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WyeSnwuE9oDZ0nvfKHg4dkrAZqN47nEkp3E+HseND8=;
        b=unw8Ue9Dx8ByxtORk6viL5Fe5Kxo0EYr+8WWVxn23AtH734DNZBm6+t8PUXLkfr0ak
         yvEf9Rs4Fce6y666pF7ZZFwoJAR3JTABtgJ4GC5sHpeqGi1pSjYkmeia+pfaIYzsrUyq
         vt0aH6XEwLspvmhkivPQtIQq4pWa03fS3VLKsQ+G84JTlKIc72FB5r2kIFMFU4GjNYRj
         vKOvQFvzp0WChRVy8a8XAEUrn6nJtd05G02lMw7O1T6hazU8uio+mWHO8scBl37HqRY0
         pFtN01TyfSPRPqCiJ+7bAwjY6qUGUApDrvkI6roi2SWbj7airpZPJpV2vkZphz6Ph9j7
         2aRQ==
X-Gm-Message-State: AOAM533HxxQ1sxDPCioqH/mFtHn8abbiP4ZIG/JAtLzmu6KnwiLT4sGA
        HfzsqyVvTFABqVcwhNIT5Jrls+EYdkK51PuXrkuJZjMfEHRXU4pb/L9VdNvo6cvsSfWLV0ypZfm
        OkJRxHXB/vhAhN+mgh6a3NjSwgEc5CvTiw+CLH4Hm
X-Received: by 2002:a17:906:c156:: with SMTP id dp22mr2191870ejc.36.1640172139331;
        Wed, 22 Dec 2021 03:22:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySmSesxTzWAQlMVsXQ/NwKpzgT0R0ziEgP90PTbYsnJJPbTby1Be2I81ZZ3ip4rzfOCo2yJ6sdz21keAIEGAU=
X-Received: by 2002:a17:906:c156:: with SMTP id dp22mr2191855ejc.36.1640172139035;
 Wed, 22 Dec 2021 03:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20211104171734.137707-1-wander@redhat.com> <YcClBlhwp4arGWtw@kroah.com>
 <CAAq0SUmVmyALNYUbM5dy3D0=Bp=ukNoNdodc1yxYQjm1SnBgAQ@mail.gmail.com> <YcGMXf7sxb/ESvFS@kroah.com>
In-Reply-To: <YcGMXf7sxb/ESvFS@kroah.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 22 Dec 2021 08:22:07 -0300
Message-ID: <CAAq0SUmw7CpY8Mmi9sZPp1b9=jZMm6+5+yAMjMHnBZxfMhsByQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: Use fifo in 8250 console driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 5:12 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 20, 2021 at 02:02:11PM -0300, Wander Costa wrote:
> > On Mon, Dec 20, 2021 at 12:45 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Nov 04, 2021 at 02:17:31PM -0300, wander@redhat.com wrote:
> > > > From: Wander Lairson Costa <wander@redhat.com>
> > > >
> > > > Note: I am using a small test app + driver located at [0] for the
> > > > problem description. serco is a driver whose write function dispatches
> > > > to the serial controller. sertest is a user-mode app that writes n bytes
> > > > to the serial console using the serco driver.
> > > >
> > > > Recently I got a report of a soft lockup while loading a bunch a
> > > > scsi_debug devices (> 500).
> > > >
> > > > While investigating it, I noticed that the serial console throughput
> > > > (called by the printk code) is way below the configured speed of 115200
> > > > bps in a HP Proliant DL380 Gen9 server. I was expecting something above
> > > > 10KB/s, but I got 2.5KB/s. I then built a simple driver [0] to isolate
> > > > the console from the printk code. Here it is:
> > > >
> > > > $ time ./sertest -n 2500 /tmp/serco
> > > >
> > > > real    0m0.997s
> > > > user    0m0.000s
> > > > sys     0m0.997s
> > > >
> > > > With the help of the function tracer, I then noticed the serial
> > > > controller was taking around 410us seconds to dispatch one single byte:
> > > >
> > > > $ trace-cmd record -p function_graph -g serial8250_console_write \
> > > >    ./sertest -n 1 /tmp/serco
> > > >
> > > > $ trace-cmd report
> > > >
> > > >             |  serial8250_console_write() {
> > > >  0.384 us   |    _raw_spin_lock_irqsave();
> > > >  1.836 us   |    io_serial_in();
> > > >  1.667 us   |    io_serial_out();
> > > >             |    uart_console_write() {
> > > >             |      serial8250_console_putchar() {
> > > >             |        wait_for_xmitr() {
> > > >  1.870 us   |          io_serial_in();
> > > >  2.238 us   |        }
> > > >  1.737 us   |        io_serial_out();
> > > >  4.318 us   |      }
> > > >  4.675 us   |    }
> > > >             |    wait_for_xmitr() {
> > > >  1.635 us   |      io_serial_in();
> > > >             |      __const_udelay() {
> > > >  1.125 us   |        delay_tsc();
> > > >  1.429 us   |      }
> > > > ...
> > > > ...
> > > > ...
> > > >  1.683 us   |      io_serial_in();
> > > >             |      __const_udelay() {
> > > >  1.248 us   |        delay_tsc();
> > > >  1.486 us   |      }
> > > >  1.671 us   |      io_serial_in();
> > > >  411.342 us |    }
> > > >
> > > > In another machine, I measured a throughput of 11.5KB/s, with the serial
> > > > controller taking between 80-90us to send each byte. That matches the
> > > > expected throughput for a configuration of 115200 bps.
> > > >
> > > > This patch changes the serial8250_console_write to use the 16550 fifo
> > > > if available. In my artificial benchmark I could get a throughput
> > > > increase up to 100% in some cases, but in the real case described at the
> > > > beginning the gain was of about 25%.
> > > >
> > > > [0] https://github.com/walac/serial-console-test
> > > >
> > > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250.h      |  3 ++
> > > >  drivers/tty/serial/8250/8250_port.c | 63 +++++++++++++++++++++++++----
> > > >  2 files changed, 59 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> > > > index 6473361525d1..c711bf118cc1 100644
> > > > --- a/drivers/tty/serial/8250/8250.h
> > > > +++ b/drivers/tty/serial/8250/8250.h
> > > > @@ -83,6 +83,9 @@ struct serial8250_config {
> > > >  #define UART_CAP_MINI        BIT(17) /* Mini UART on BCM283X family lacks:
> > > >                                        * STOP PARITY EPAR SPAR WLEN5 WLEN6
> > > >                                        */
> > > > +#define UART_CAP_CWFIFO BIT(18) /* Use the UART Fifo in
> > > > +                              * serial8250_console_write
> > > > +                              */
> > >
> > > Why do you need a new bit?  Why can't you just do this change for all
> > > devices that have a fifo?  Why would you _not_ want to do this for all
> > > devices that have a fifo?
> > >
> > The v1 patch [1] didn't have this extra bit. Andy suggested [2] to add
> > it so we only enabled this new code on tested controllers as a
> > precaution.
> > If it doesn't make sense to you, feel free to consider the v1 patch [1].
> >
> > [1] https://lore.kernel.org/all/20211029201402.428284-1-wander@redhat.com/
> > [2] https://lore.kernel.org/all/CAHp75Vf6DjNcPWpE4Dh3SuzUMJbFQjq1UNCkrCa60uw35SpqKg@mail.gmail.com/
>
> I do like [1] better, but can you fix up the checkpatch issues and
> resend it:
>
Sure. No problem.

> CHECK: Alignment should match open parenthesis
> #116: FILE: drivers/tty/serial/8250/8250_port.c:3342:
> +static void serial8250_console_fifo_write(struct uart_8250_port *up,
> +               const char *s, unsigned int count)
>
> CHECK: Logical continuations should be on the previous line
> #156: FILE: drivers/tty/serial/8250/8250_port.c:3412:
> +       use_fifo = (up->capabilities & UART_CAP_FIFO)
> +               && port->fifosize > 1
>
> CHECK: Logical continuations should be on the previous line
> #157: FILE: drivers/tty/serial/8250/8250_port.c:3413:
> +               && port->fifosize > 1
> +               && (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO)
>
> CHECK: Logical continuations should be on the previous line
> #163: FILE: drivers/tty/serial/8250/8250_port.c:3419:
> +                */
> +               && !(up->port.flags & UPF_CONS_FLOW);
>
>
>
> thanks,
>
> greg k-h
>

