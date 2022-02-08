Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C474AD7A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357181AbiBHLgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357010AbiBHLQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:16:39 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54857C03FEC0;
        Tue,  8 Feb 2022 03:16:39 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id g14so48689794ybs.8;
        Tue, 08 Feb 2022 03:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nu7/YVH6EUneCQklBZ5MS41to049uINEDS/3iIPXoMM=;
        b=AVCxW/K+sd6X3H3McN/ORZimi27QyU+E4rTwL57qwrLaqRtOYtASwb9CTB+41zgtlB
         xsJ7e6yG/UHvktqGc/lV3qQxjDllvsSpw6DGTj7ot7BG8+AbgGh955xF73s5CHEhwAbB
         QjhuGYGXEOCir9YbXYCxEKtHmzgew0aUgfRGbcrjKgiz1+T387Qokq7ufwJm7ZnP45pE
         PWDSukRXZnBK/z5R1Eu2rJIf7Kq0NqI3J9gQuklL2fKz6hOQx2/4M9fG39iXb122NQMg
         ZgvMG9BjYz29MfLVgsNHI/CIWdvqf7QStFMajgKL9LBjixChFljGNn5I1s1AX4pe1Sz5
         IVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nu7/YVH6EUneCQklBZ5MS41to049uINEDS/3iIPXoMM=;
        b=3rvetcpUbeRg7+wQNoqEDV//+9jNp/RpATY1y9ZKNHGoyDllD05uXrTS4bR58Jg/6y
         S33k4YYxmUxzeST6a7PaSfoN33J9pMIv2kD/BaGup2DXHekV8+qd0rrWZvEEVEKncvvj
         zFfdbvU8I/ERbpW63gDHxMUDM3WTekhBPvEZARYec9dAj+2vPIYOjtjuK0hdo8dgV37C
         xTuFluiL6JlCSqnE5Z9gcBJSw6PoBN8vCHD1CoSXDDHyuKsx6nEAgIUH4zwqea1WKQva
         8aE6VnN9bCavGbgArBBoRU3z8qTXYmQnT/AIXDfddkOCvgNz8kq4GYEzcEoMml2UIyTT
         YPlQ==
X-Gm-Message-State: AOAM5317I5b9Gb5hRnMAIZY/lZtd2QOJT16ObZf3XhTHDcb2c7bbAxxn
        QNFUcrRgX7+fbm3jnKlw6NnyqcqHOhADwtZGYOI=
X-Google-Smtp-Source: ABdhPJz06wEjYiXp/Zki0OtcMPFFilsPoeZ54FGyMmqZbxwlJBCVPRQ+mK6VPpT2h7ZZnDVf/HoHKhSgfOq+O6jr5hg=
X-Received: by 2002:a81:ac09:: with SMTP id k9mr4332831ywh.356.1644318998417;
 Tue, 08 Feb 2022 03:16:38 -0800 (PST)
MIME-Version: 1.0
References: <1644213481-20321-1-git-send-email-hammerh0314@gmail.com>
 <1644213481-20321-3-git-send-email-hammerh0314@gmail.com> <7aa14a1e-2814-0014-a682-f40666f635ac@kernel.org>
In-Reply-To: <7aa14a1e-2814-0014-a682-f40666f635ac@kernel.org>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Tue, 8 Feb 2022 19:16:52 +0800
Message-ID: <CAOX-t569-0aTu73eGSY3k+btAuVgueRY91Jd5b9kbpjmxPp+Dw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
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

Jiri Slaby <jirislaby@kernel.org> =E6=96=BC 2022=E5=B9=B42=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 07. 02. 22, 6:58, Hammer Hsieh wrote:
> > +static void sunplus_shutdown(struct uart_port *port)
> > +{
> > +     unsigned long flags;
> > +     unsigned int isc;
> > +
> > +     spin_lock_irqsave(&port->lock, flags);
> > +
> > +     isc =3D readl(port->membase + SUP_UART_ISC);
> > +     isc &=3D ~(SUP_UART_ISC_RXM | SUP_UART_ISC_TXM);
>
> Is this correct? I mean: will the SUP_UART_ISC read contain the control
> bits, not only status bits?
>

I assume reviewers don't like writel(0,xxx).
So I use definition to let the code easy to read.
The purpose is to clear all interrupt.
Bit[3:0] status bit only for read, write 1 or 0 no effect.

> > +     writel(isc, port->membase + SUP_UART_ISC);
> > +
> > +     spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +     free_irq(port->irq, port);
>
> I am still waiting for explanation why this is safe with respect to
> posted writes.
>

Actually I'm not IC designer, not expert for bus design.
About data incoherence issue between memory bus and peripheral bus.
In case of AXI bus, use non-posted write can avoid data incoherence issue.
What if in case of posted write:
Send a specific command after last write command.
SDCTRL identify specific command, means previous write command done.
Then send interrupt signal to interrupt controller.
And then interrupt controller send done signal to Master.
Master receive done signal, means write command done.
Then issue a interrupt or proceed next write command.

IC designer told us no problem, and as a uart driver maintainer.
It is not my concern, but glad you ask.
Let me have chance to know it from IC designer.

> regards,
> --
> js
> suse labs
