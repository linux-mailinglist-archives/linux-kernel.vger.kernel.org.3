Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A1847BB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhLUIOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbhLUIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:14:11 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09012C06173F;
        Tue, 21 Dec 2021 00:14:11 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id v13so11047097pfi.3;
        Tue, 21 Dec 2021 00:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KfWp3EC1FzqgOl2C4TeIv3DanfwzS2Q8LVhv9Iqo4TE=;
        b=nc1katz4p2W9VXbj0pMPJd8OENjc4Hpl62crQFmbR8P4Cs7rEzHnvcw5IM/Pzav+oX
         grljk9embKuYCbngIdXGEqOneqd8mu+JGnefW3135Ofui5iMbcxfrpz8TKeBZFQg2Lel
         OQPVw9Ay1oAntv9YW02dQHnF1hdXi5a5W5vPNhRI9wPKLS/0Bve6gTcZZCMKZeF3S5de
         fyKvwZXQFHOxBtJ1tWuDP2taarbkWZKLUArIE38xFZMgZUu7WrA5Ms2tfaeZoRStqO1R
         vIi12wrK8LUzwGAX8DiLhABNBdj4pLb8l4+y2L1/e3W0eitcOupVIdKfeHbHSEUDKT/D
         F7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KfWp3EC1FzqgOl2C4TeIv3DanfwzS2Q8LVhv9Iqo4TE=;
        b=0SqSb19uEyEMaOGzgo/Bf+5uZb/kdduhi+MfFJoskhSRI/ZlfEq8QT60vFtYqoCRav
         Xoze6bqGbJVV4EiKb0SiljGoX3BHWM51rWCRflyS1dc6a4/YGRGM11Tyu8VlDdVRC6gv
         1tV26xPTZ3Jasgp9oTAcxAGh4J5adtixGiuMfZOK8dARyszq3o2ZRtYgxmCbKwuVj7rL
         LrWJwSF7jeP2pfMcnQf1PAEzcn8kdjc0P0HUEEFOwmL8JQuUlMWwyc7JXqQWObBH2JB9
         NecA+RCGbtoDNwSe1prZg46qYgXXegLp8NshjzEHGrJOBCuxvXqpTrFKNq8C7vRKAAOW
         +S8A==
X-Gm-Message-State: AOAM533NTMzBybddZmCAVO395QHxXXPJteB8WnFTL99i6kK8oKr7fdA4
        So5pn5le364sNuJB0ir2FQ7CTBHudrJihy4YjN0=
X-Google-Smtp-Source: ABdhPJyfjZs1i63+vVnbWIogeffAkybtFZr5MWXqBu8A8DgLYraxD4dYQq79sGPc8LpnZCTZIQbyf4kuj0AhNLeaLWk=
X-Received: by 2002:a63:1858:: with SMTP id 24mr1960142pgy.338.1640074450574;
 Tue, 21 Dec 2021 00:14:10 -0800 (PST)
MIME-Version: 1.0
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com> <YcCmaJkeKy+R0mhF@kroah.com>
In-Reply-To: <YcCmaJkeKy+R0mhF@kroah.com>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Tue, 21 Dec 2021 16:14:16 +0800
Message-ID: <CAOX-t54j9=7eLMAx4n-ngiNdM=Ab=YcK-zdxRW88e41cPS=46Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=8820=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:51=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Mon, Dec 13, 2021 at 03:10:07PM +0800, Hammer Hsieh wrote:
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
> > +#define SUP_UART_LSR_TXE             BIT(6) /* tx empty */
> > +#define SUP_UART_LSR_BC                      BIT(5) /* break condition=
 status */
> > +#define SUP_UART_LSR_FE                      BIT(4) /* frame error sta=
tus */
> > +#define SUP_UART_LSR_OE                      BIT(3) /* overrun error s=
tatus */
> > +#define SUP_UART_LSR_PE                      BIT(2) /* parity error st=
atus */
> > +#define SUP_UART_LSR_RX                      BIT(1) /* 1: receive fifo=
 not empty */
> > +#define SUP_UART_LSR_TX                      BIT(0) /* 1: transmit fif=
o is not full */
> > +#define SUP_UART_LSR_TX_NOT_FULL     1
> > +#define SUP_UART_LSR_BRK_ERROR_BITS  GENMASK(5, 2)
> > +
> > +/* Line Control Register bits */
> > +#define SUP_UART_LCR_BC                      BIT(5) /* break condition=
 select */
> > +#define SUP_UART_LCR_PR                      BIT(4) /* parity bit pola=
rity select */
> > +#define SUP_UART_LCR_PE                      BIT(3) /* parity bit enab=
le */
> > +#define SUP_UART_LCR_ST                      BIT(2) /* stop bits selec=
t */
> > +#define SUP_UART_LCR_WL5             0x00 /*  word length 5 */
> > +#define SUP_UART_LCR_WL6             0x01 /*  word length 6 */
> > +#define SUP_UART_LCR_WL7             0x02 /*  word length 7 */
> > +#define SUP_UART_LCR_WL8             0x03 /*  word length 8 (default) =
*/
> > +
> > +/* Modem Control Register bits */
> > +#define SUP_UART_MCR_LB                      BIT(4) /* Loopback mode *=
/
> > +#define SUP_UART_MCR_RI                      BIT(3) /* ring indicator =
*/
> > +#define SUP_UART_MCR_DCD             BIT(2) /* data carrier detect */
> > +#define SUP_UART_MCR_RTS             BIT(1) /* request to send */
> > +#define SUP_UART_MCR_DTS             BIT(0) /* data terminal ready */
> > +
> > +/* Interrupt Status/Control Register bits */
> > +#define SUP_UART_ISC_RXM             BIT(5) /* RX interrupt enable */
> > +#define SUP_UART_ISC_TXM             BIT(4) /* TX interrupt enable */
> > +#define SUP_UART_ISC_RX                      BIT(1) /* RX interrupt st=
atus */
> > +#define SUP_UART_ISC_TX                      BIT(0) /* TX interrupt st=
atus */
> > +
> > +#define SUP_DUMMY_READ                       BIT(16) /* drop bytes rec=
eived on a !CREAD port */
> > +#define SUP_UART_NR                  5
>
> Aren't most of these defines already in the kernel header files?  Why
> create them again?
>

If for reduce code.
I can add #include<linux/serial_reg.h>
And remove some overlap define name.

#define SUP_UART_LCR_PR -> UART_LCR_EPAR
#define SUP_UART_LCR_PE -> UART_LCR_PARITY
#define SUP_UART_LCR_ST -> UART_LCR_STOP
#define SUP_UART_LCR_WL5 -> UART_LCR_WLEN5
#define SUP_UART_LCR_WL6 -> UART_LCR_WLEN6
#define SUP_UART_LCR_WL7 -> UART_LCR_WLEN7
#define SUP_UART_LCR_WL8 -> UART_LCR_WLEN8

#define SUP_UART_MCR_LB -> UART_MCR_LOOP
#define SUP_UART_MCR_RI -> UART_MCR_OUT2 ?
#define SUP_UART_MCR_DCD -> UART_MCR_OUT1 ?
#define SUP_UART_MCR_RTS -> UART_MCR_RTS
#define SUP_UART_MCR_DTS -> UART_MCR_DTR

But the rest define didn't match internal #include<linux/serial_reg.h>
, those define still need to keep.
Some use SUP_xxxx specific define.
Some use internal #include<linux/serial_reg.h>, it is strange.
