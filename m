Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6BB49F1E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbiA1DgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbiA1Df7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:35:59 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054FC061714;
        Thu, 27 Jan 2022 19:35:59 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id k17so14704278ybk.6;
        Thu, 27 Jan 2022 19:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+/kTnhBKtQ4o1xU7csKjZQb7FX9UZE3p6kbMBAjh3Wk=;
        b=q8HRTGri4vkoWtkJFLbHs8ttvag2rveoJCuratu/swm4Zcj91Ls95siFkpHsin2rfM
         m4or96fvnCLRAwoERvupN0taFx8Yww/YcDLdrOEACf0HMjddQA03W1sWjijLW+k5fxqP
         uzURCDZmFAYOHUIpu5naivflJt4Eq1ZeTLsDSL29XzuEFGxPNkutMUVmP8OE/zEzcabm
         NbVR8BbuTaJivFn/J990vVKqXBs1wAFh73y2HufyntxvX4EnreUwWaZvVfPU+gXsA2zy
         KoswOrND7SNcaEWhZzslnywyz2J/GzU2a2+CgoptFx9Lm412DAj5/IyCNS6OtviKZEGY
         Yafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+/kTnhBKtQ4o1xU7csKjZQb7FX9UZE3p6kbMBAjh3Wk=;
        b=XoR+iUOuNS3icskQdzt5O1LJ7U/LLahoEl+en6JlQFH5fkpo6shBKhvzGcyCxKNqVe
         iUEeBdHpMfvyHeDmcSFQNL7yxAk+VylrDMpj7ZIYD4NZNMfdsE7M1CU1l4yRSTiBcIyy
         ABDPuCga6vOXJ91UUKv9igIAX6LXCXSKvIV6S2vNnXyvUEnnT99WK+1A7iP/mmXv5v5Q
         qeWcO8r2mWr9RsZdBiPgmjFnzEnbicZTkFvx0N2tkrKBjrdlc70DViJQjjroj1kIE8kC
         2tA9eEe9uS0ZjasoPVg2cXc+gs5RiANGAcyLJcm2tIIfSM51mx1YV9pC5V8dd7T2ArjB
         jbcQ==
X-Gm-Message-State: AOAM531Mt4Iodrxngre+RJqp2FD0UwRbeyatHJHBhzgwnAocQu8PjONO
        hmJ3rG2V9/TjJkcnkKcom44DlEY/7t4L9fKN3CpK8y2jYoc=
X-Google-Smtp-Source: ABdhPJxn1B/pmprpk4xW1dtRGM2DfPjyfNF6kOlXx77LtURWiamxAX/bHf9jB7Pu4Aa4cusykGUESCOeq9jIaIJNAfc=
X-Received: by 2002:a05:6902:1205:: with SMTP id s5mr11602929ybu.676.1643340958221;
 Thu, 27 Jan 2022 19:35:58 -0800 (PST)
MIME-Version: 1.0
References: <1641979444-11661-1-git-send-email-hammerh0314@gmail.com>
 <1641979444-11661-3-git-send-email-hammerh0314@gmail.com> <fcd43c65-6201-9e44-061c-f04e39cef726@kernel.org>
 <CAOX-t54oA9V94d3901w2xKSagSzmXc9r=TDTtbgaSLfL1DxNbw@mail.gmail.com>
 <d6d3aa07-7bf1-2b6d-356f-ae13c7b9d6cd@kernel.org> <CAOX-t57KZb0hNDuhPsabkmkf_qOOLqyH3yuvkHP6UNwhLodWDg@mail.gmail.com>
 <2cde3ff0-5180-7c1e-82fd-7b58e41d462a@kernel.org> <CAOX-t573QkixRC7xa1KUOYXfL12Q+Ltxph9rX7V8tm2BMoqxgA@mail.gmail.com>
 <YfFQ7v4dXPMV7ypw@kroah.com>
In-Reply-To: <YfFQ7v4dXPMV7ypw@kroah.com>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Fri, 28 Jan 2022 11:36:10 +0800
Message-ID: <CAOX-t54bRS0_kgg2DVoF3p8fx9VJh7xbyoTFcnAHnimLv40WbQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        wells.lu@sunplus.com, "hammer.hsieh" <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg KH:

I review all driver again.
I think only startup and shutdown not good.
I will modify like below.
If you are ok, I will submit next patch.

static int sunplus_startup(struct uart_port *port)
{
        unsigned long flags;
        unsigned int isc;
        int ret;

        ret =3D request_irq(port->irq, sunplus_uart_irq, 0, "sunplus_uart",=
 port);
        if (ret)
                return ret;

        spin_lock_irqsave(&port->lock, flags);

        isc =3D readl(port->membase + SUP_UART_ISC); //add this line
        isc |=3D SUP_UART_ISC_RXM;
        writel(isc, port->membase + SUP_UART_ISC);

        spin_unlock_irqrestore(&port->lock, flags);

        return 0;
}

static void sunplus_shutdown(struct uart_port *port)
{
        unsigned long flags;
        unsigned int isc;

        spin_lock_irqsave(&port->lock, flags);

        isc =3D readl(port->membase + SUP_UART_ISC); //add this line
        isc &=3D ~(SUP_UART_ISC_RXM | SUP_UART_ISC_TXM); //add this line
        writel(isc, port->membase + SUP_UART_ISC); //modify this line

        spin_unlock_irqrestore(&port->lock, flags);

        free_irq(port->irq, port);
}

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2022=E5=B9=B41=E6=9C=8826=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:47=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Jan 14, 2022 at 10:22:56AM +0800, hammer hsieh wrote:
> > Jiri Slaby <jirislaby@kernel.org> =E6=96=BC 2022=E5=B9=B41=E6=9C=8813=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:12=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On 13. 01. 22, 11:56, hammer hsieh wrote:
> > > >> Could you explain me what posted write is and how does it not matt=
er in
> > > >> this case?
> > > >>
> > > >
> > > > Each UART ISC register contains
> > >
> > > No, you still don't follow what I write. Use your favorite web search
> > > for "posted write" and/or consult with your HW team.
> > >
> >
> > Maybe this time, we are on the same page.
> > Our SP7021 chipset is designed on ARM Cortex-A7 Quad core.
> > Register Access through AMBA(AXI bus), and it is non-cached.
> >
> > Did you mean
> > case1 have concern about "posted write", and you want to know why it no=
t matter?
> > case2 will be safer?
> >
> > Case1 :
> > spin_lock_irq_save()
> > writel(0, target register)
> > spin_unlock_irqrestore()
>
> A lock does not mean that your write made it to the device.  Please talk
> to the hardware designers to properly determine how to correctly write
> to the hardware and "know" that the write succeeded or not.  This driver
> does not seem to take that into consideration at all.
>
> thanks,
>
> greg k-h
