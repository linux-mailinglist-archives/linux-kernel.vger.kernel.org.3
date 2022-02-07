Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B284ABE20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390993AbiBGL6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384694AbiBGL3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:29:36 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02D7C03FEDE;
        Mon,  7 Feb 2022 03:28:00 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 192so12698434ybd.10;
        Mon, 07 Feb 2022 03:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WxR2Iy/hInfRurGC4IqSW6zQNPBVhusP7UDER7Bropk=;
        b=dM/Tj7tr2LUBDshsrOWdnnxklmal1W15fzaCMCTQao60SujrYlghFjzCZqhB+TbXPg
         SNiOS8RZv7OSiyaTF5lQUgyXXzQ5qk7uzVO0FRedzzIzg+4TH7RbSMTNxlmZp6P+uWVL
         VDLP7pEQ/S1P4B0O2raEMVLXjsaZlYgyDr81GJ6N8sozwIJEoB4X10TS5RwIxV2N1AiR
         U98git0f+YOsHGF/WZ+ZG+fh6OCtO2xL+/n+aw8SCpvayTQ2NxZY+26jLKGL5ZnuTABM
         wuCGy+k17X1+6muAZPANzXCoA+E661hCCnVsugwiE4H5KXJW2l8u+l5N9zRLo+EVUc9T
         QhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WxR2Iy/hInfRurGC4IqSW6zQNPBVhusP7UDER7Bropk=;
        b=vZq03RefnM94OAbM4Q446MKPqNP3ZvecgHlXCpOfCe5x+Qft1iP6r4jU6AnIdox7hv
         Zddo/KTQS3YxCQb7BfetCcHUtyualrug92fqd+5JxkbsA4PVG6pOxOEW9dfHbbEBytCM
         YS4FZoHqphSfDqqmlowT/AqXwZ5dnn3mz8E9OTRiviGLuUP/0CfYw1/4EshKzwmLGr4J
         Kz4H15U1DRoC8nlGYbh5+EaeqzfpGydkF4XOXqaDtFSY86BGmzfeTKFCIL9ug1KIj4TK
         sZuyvAogU2oMdhpnF/fmDPBsSb5YlP+xWtG9EEe68HmhfWeWbvTn5YSkq4Q7k6EY9G7g
         ggBw==
X-Gm-Message-State: AOAM532SzYU2zleXDECEFrGak6OCZS6vfu+1Mza7nDORlYom3qgGqYw4
        3MivUOVjfSdNtw1PSp9YeeV1rKeCHIJBZ2kP4hoqoC9qhFcYUg==
X-Google-Smtp-Source: ABdhPJxrPoHymoNp9oAgOQoocWDdgId4VRyqnJQ7fnjIlGyC/SUXMPUZyDHFDRdUTKXD9oDRLRxiKidiAB5GKIuYBc4=
X-Received: by 2002:a81:6f56:: with SMTP id k83mr10773035ywc.58.1644233279890;
 Mon, 07 Feb 2022 03:27:59 -0800 (PST)
MIME-Version: 1.0
References: <1644213481-20321-1-git-send-email-hammerh0314@gmail.com>
 <1644213481-20321-3-git-send-email-hammerh0314@gmail.com> <YgDHwgg0s6U3bFxF@kroah.com>
In-Reply-To: <YgDHwgg0s6U3bFxF@kroah.com>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Mon, 7 Feb 2022 19:28:13 +0800
Message-ID: <CAOX-t55sbxd6rvkafnw-m1nYMuEZTsKOkBBftqSoKxocxSZbJQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>, p.zabel@pengutronix.de,
        wells.lu@sunplus.com, "hammer.hsieh" <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2022=E5=B9=B42=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Feb 07, 2022 at 01:58:01PM +0800, Hammer Hsieh wrote:
> > Add Sunplus SoC UART Driver
> >
>
> We need more of a changelog comment here please.  Describe the hardware,
> what the new tty name you are using, and other stuff.  Be descriptive.
>

I will describe as below.
Add Sunplus SoC UART Driver.
SP7021 UART block contains 5 UARTs.
There are UART0~4 that supported in SP7021, the features list as below.
Support Full-duplex communication.
Support data packet length configurable.
Support stop bit number configurable.
Support force break condition.
Support baud rate configurable.
Support error detection and report.
Support RXD Noise Rejection Vote configurable.

UART0 pinout only support TX/RX two pins.
UART1 to UART4 pinout support TX/RX/CTS/RTS four pins.
Normally UART0 used for kernel console, also can be used for normal uart.
Command line set "console=3DttySUP0,115200", SUP means Sunplus Uart Port.
UART driver probe will create path named "/dev/ttySUPx".

https://sunplus.atlassian.net/wiki/spaces/doc/pages/1873412290/13.+Universa=
l+Asynchronous+Receiver+Transmitter+UART

> > --- a/include/uapi/linux/serial_core.h
> > +++ b/include/uapi/linux/serial_core.h
> > @@ -274,4 +274,7 @@
> >  /* Freescale LINFlexD UART */
> >  #define PORT_LINFLEXUART     122
> >
> > +/* Sunplus UART */
> > +#define PORT_SUNPLUS 123
>
> Why is this needed?  Are you going to require this in some userspace
> code?  If not, please do not add it.
>

In serial_core.c (line 3014) uart_add_one_port( )
It will call uart_configure_port( ).
In my uart driver probe set port->flags=3DUPF_BOOT_AUTOCONF.
I try to remove port define and remove  sunplus_config_port( )
 and just add a "sunplus_uart" for in sunplus_type( ).
And my uart console not work with PuTTY tool.

I try to do another test as below.
static const char *sunplus_type(struct uart_port *port)
{
        return "sunplus_uart";
}
static void sunplus_config_port(struct uart_port *port, int type)
{
        if (type & UART_CONFIG_TYPE)
                port->type =3D "sunplus_uart"; //type define is unsigned in=
t
}
Uart console works, but port->type should be unsigned int , not string.
So compile will warning " assignment makes integer from pointer
without a cast [-Wint-conversion]".

I think I should keep the current submit code.

> thanks,
>
> greg k-h
