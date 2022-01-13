Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976BB48D3EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiAMIyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiAMIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:54:08 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97387C06173F;
        Thu, 13 Jan 2022 00:54:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n11so6681080plf.4;
        Thu, 13 Jan 2022 00:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uAZ68Y2XfdAKorZiV700UePRC99qa3lTlzuq+2AtBAg=;
        b=TKbcO0jr+l53jtGwqRstAcbmZXRP6RcmN9hGG2GaWHmS6Ee9Fo2C7FLf3gd+2+wF4z
         EOD8avQxSQm1GCXBD8+vHiYyHAB2+95EbPAksAe7NxIQZ0LIhA71QrdjiVnxcRJizvLj
         1hN3ejxPoVzVXRGGocdlf4LAL5AQq8nMk5qm7rnSFQ9KU69+98M/xiQIvH2zeP5QrM0s
         +EXfQ1EtX38GtKUMGK572NK2RSFq92n8NA+ilISglODA5cfbrUnX2DvzvIloYO3bW2UC
         kCGpgV3iBWXJTj2xkO8QKUoxYt5ecuEkZ5A3nvOXk0RITS5StqAMQcWkOS1jnjHELpCt
         v9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uAZ68Y2XfdAKorZiV700UePRC99qa3lTlzuq+2AtBAg=;
        b=QxM5YoFyFjuK0Io5gtUIG0UAoJGQZwPyEbSNkQAv35oSrNXgAJjRjR5YAQu6RRabOM
         Q2LQwtsIqzdqPPnH9zff/txH8epd4rDMHi3C84PiUcyMlrqGgozA7g9A7HXcEPelxQwj
         5TeviYC5ftdYa4ruVoiQ29mt40mmxG5Qxdxr12RzaCEq+wSSKRye16TDWhp+1Kx70NJY
         iA9BcYndP/xb6s6f5TRW6BN64n1l/c1nMhOiRIyOn7cscwu8swXDkUWUJaZbi2NfahR7
         tiyKjIpljg8vEIXHQHaM66pOSyTbxcuVbVTO0FE4Rmxf5SvgJpvl7L78JwGHV0UtT4ek
         GE6w==
X-Gm-Message-State: AOAM530nAl5RPQ+NpU9aGK8UTfe9t0guISQTd79qFNpkGMW3YjXefMap
        QXOKrNOcZs1S0a+toEuzzlIbEcpZXbgGEwA/KG4=
X-Google-Smtp-Source: ABdhPJzCHzJ6G8FR10V5FLG8CU7iOrWbVN7PznzQHudPnABW40Gu6lA9xZF2IRvT+vjDPErvUXT6in+NZIwjD795A4M=
X-Received: by 2002:a17:902:a501:b0:14a:4ed2:2a01 with SMTP id
 s1-20020a170902a50100b0014a4ed22a01mr3332335plq.49.1642064048054; Thu, 13 Jan
 2022 00:54:08 -0800 (PST)
MIME-Version: 1.0
References: <1641979444-11661-1-git-send-email-hammerh0314@gmail.com>
 <1641979444-11661-3-git-send-email-hammerh0314@gmail.com> <fcd43c65-6201-9e44-061c-f04e39cef726@kernel.org>
In-Reply-To: <fcd43c65-6201-9e44-061c-f04e39cef726@kernel.org>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Thu, 13 Jan 2022 16:54:17 +0800
Message-ID: <CAOX-t54oA9V94d3901w2xKSagSzmXc9r=TDTtbgaSLfL1DxNbw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        wells.lu@sunplus.com, "hammer.hsieh" <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@kernel.org> =E6=96=BC 2022=E5=B9=B41=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 12. 01. 22, 10:24, Hammer Hsieh wrote:
> > Add Sunplus SoC UART Driver
> ...
> > --- /dev/null
> > +++ b/drivers/tty/serial/sunplus-uart.c
> > @@ -0,0 +1,756 @@
> ...
> > +/* Register offsets */
> > +#define SUP_UART_DATA                        0x00
> > +#define SUP_UART_LSR                 0x04
> > +#define SUP_UART_MSR                 0x08
> > +#define SUP_UART_LCR                 0x0C
> > +#define SUP_UART_MCR                 0x10
> > +#define SUP_UART_DIV_L                       0x14
> > +#define SUP_UART_DIV_H                       0x18
> > +#define SUP_UART_ISC                 0x1C
> > +#define SUP_UART_TX_RESIDUE          0x20
> > +#define SUP_UART_RX_RESIDUE          0x24
> > +
> > +/* Line Status Register bits */
> > +#define SUP_UART_LSR_BC                      BIT(5) /* break condition=
 status */
> > +#define SUP_UART_LSR_FE                      BIT(4) /* frame error sta=
tus */
> > +#define SUP_UART_LSR_OE                      BIT(3) /* overrun error s=
tatus */
> > +#define SUP_UART_LSR_PE                      BIT(2) /* parity error st=
atus */
>
> I just wonder why do the HW creators feel so creative to redefine the
> world...
>

Our IC designer create it, I just try to make it work.
Indeed, before Greg KH mentioned 8250-like, I didn't realize our uart
so much like 8250.
Thanks for your review.

> > +static void sunplus_shutdown(struct uart_port *port)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&port->lock, flags);
> > +     writel(0, port->membase + SUP_UART_ISC);
> > +     spin_unlock_irqrestore(&port->lock, flags);
>
> I asked last time:
> * What bus is this -- posting?
>
> You replied:
> * Here just clear interrupt.
> * Not really understand your comment?
>
> So I am asking again:
> What bus is this? Isn't a posted write a problem here? I mean, shouldn't
> you read from the register so that the write hits the device? That
> depends on the bus this sits on, so just asking.
>

Each UART has its own ISC register.
Ex.
dev/ttySUP0 base_adr =3D 0x9C00-0000 , isc_addr =3D 0x9C00-001C
dev/ttySUP1 base_adr =3D 0x9C00-0080 , isc_addr =3D 0x9C00-009C
dev/ttySUP2 base_adr =3D 0x9C00-0100 , isc_addr =3D 0x9C00-011C
dev/ttySUP3 base_adr =3D 0x9C00-0180 , isc_addr =3D 0x9C00-019C
dev/ttySUP4 base_adr =3D 0x9C00-0200 , isc_addr =3D 0x9C00-021C
So sunplus_shutdown() just simply turn off its own device isc only.
That's why I didn't read register value, just write 0 for it.

> Other than that the driver looks much better now, i.e. LGTM.
>
> thanks,
> --
> js
> suse labs
