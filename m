Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E99A4AF03B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiBILzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiBILzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:55:21 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08FDE00F7CA;
        Wed,  9 Feb 2022 02:52:49 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id m6so4625592ybc.9;
        Wed, 09 Feb 2022 02:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t9EOjDsFOoIpRxTzANo3FHWi1tKOlZeMj74re1dNnPQ=;
        b=nol7K09L15nrTX8SbqhMA+n0uZ+Yv4qdgTEbQlIwvG7Pfmwj+9HWeqJLBSiMOkhi+6
         exJdUcqqguQ9yQ27PdHc7yGPCVQ/2NovbX3RY0jCctPxdRbBwZ73gPci7bDwkh6MgbDR
         NAp+wZOXbneBp/fyy80J6WJ3XPS6A27E8k2TpUpCnmlzvee9I/Yq+fsDNxmXPW9LYJHi
         RT+nvRQE0EiUed3kBmTlNUAfsggE4fq6QRL8rXruXQnmphPwMxMUhdfQHShsEVqWFghj
         K2ihaP+3K+nH6FePNUm346AGKRehV63ydLAibn3zs+J+TEorkSzztJ16Qjx9Vqt7/pVx
         zh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t9EOjDsFOoIpRxTzANo3FHWi1tKOlZeMj74re1dNnPQ=;
        b=uQP7/pE9+g4z9gAUdu/SAPV1wDqvaCq+gii8ncT/7N+3zd1ud7p9TCgPoWUQToJWr9
         X76DcGBHCKGJQ4Lqki1koVDWvbY8hWM20NuNkTJ4doP0LXXZ/P2R0F1d5XgI3lHEStjp
         cCpWlY68Z3YpAKkKJoZFvdPZf5Vn5qBZsKo7P0LtsyEeha/1++XVlw42Cl5g/65VF9NC
         Z+9rmqP85bsXxKVSmFds1f3uDFMzYw1FA+HdZYkGd8PxH0mSPZcf4jSHcqYh1oU2b1Y5
         NwhibK7Zi5DX6Is2GDjCjbiYuKXkawgjJztKPBeMJ4bDkXcvf2/GMeRWcPdrg45320QI
         BTeg==
X-Gm-Message-State: AOAM53123z0M19Oki8hVHBFmUTYAQwapY0JbKJ7sWfu8QXdHfm/kZJbf
        oKLjrwGhTEC3nG38bGHl7mzKn7wC14wFtdEsBTk=
X-Google-Smtp-Source: ABdhPJzYXzffFdYHs1OiBDSctVnmzVRTGomr66e7l7mljK4dP+oSHHewJhdr9uxcryg9p/0WcDqyTRDd/hFJxzUDL7k=
X-Received: by 2002:a81:cf07:: with SMTP id u7mr1431288ywi.221.1644403968911;
 Wed, 09 Feb 2022 02:52:48 -0800 (PST)
MIME-Version: 1.0
References: <1644213481-20321-1-git-send-email-hammerh0314@gmail.com>
 <1644213481-20321-3-git-send-email-hammerh0314@gmail.com> <7aa14a1e-2814-0014-a682-f40666f635ac@kernel.org>
 <CAOX-t569-0aTu73eGSY3k+btAuVgueRY91Jd5b9kbpjmxPp+Dw@mail.gmail.com> <YgJUiegS2Cc9MyHc@kroah.com>
In-Reply-To: <YgJUiegS2Cc9MyHc@kroah.com>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Wed, 9 Feb 2022 18:53:03 +0800
Message-ID: <CAOX-t54HXyty96UYYDHVLc4TieQsY3wEq-JT66amXgHb=SB0wg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
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

Ok, thanks for your explaination, I got it now.
I will document "posted write" info in the top of the file or top of
startup/shutdown function.

And kernel test robot report me build error and warning with gcc
11.2.0 ia64 / powerpc.
I will fix it and send next patch.

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2022=E5=B9=B42=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Feb 08, 2022 at 07:16:52PM +0800, hammer hsieh wrote:
> > Jiri Slaby <jirislaby@kernel.org> =E6=96=BC 2022=E5=B9=B42=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:27=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > Hi,
> > >
> > > On 07. 02. 22, 6:58, Hammer Hsieh wrote:
> > > > +static void sunplus_shutdown(struct uart_port *port)
> > > > +{
> > > > +     unsigned long flags;
> > > > +     unsigned int isc;
> > > > +
> > > > +     spin_lock_irqsave(&port->lock, flags);
> > > > +
> > > > +     isc =3D readl(port->membase + SUP_UART_ISC);
> > > > +     isc &=3D ~(SUP_UART_ISC_RXM | SUP_UART_ISC_TXM);
> > >
> > > Is this correct? I mean: will the SUP_UART_ISC read contain the contr=
ol
> > > bits, not only status bits?
> > >
> >
> > I assume reviewers don't like writel(0,xxx).
> > So I use definition to let the code easy to read.
> > The purpose is to clear all interrupt.
> > Bit[3:0] status bit only for read, write 1 or 0 no effect.
> >
> > > > +     writel(isc, port->membase + SUP_UART_ISC);
> > > > +
> > > > +     spin_unlock_irqrestore(&port->lock, flags);
> > > > +
> > > > +     free_irq(port->irq, port);
> > >
> > > I am still waiting for explanation why this is safe with respect to
> > > posted writes.
> > >
> >
> > Actually I'm not IC designer, not expert for bus design.
> > About data incoherence issue between memory bus and peripheral bus.
> > In case of AXI bus, use non-posted write can avoid data incoherence iss=
ue.
> > What if in case of posted write:
> > Send a specific command after last write command.
> > SDCTRL identify specific command, means previous write command done.
> > Then send interrupt signal to interrupt controller.
> > And then interrupt controller send done signal to Master.
> > Master receive done signal, means write command done.
> > Then issue a interrupt or proceed next write command.
>
> But how does the kernel know when the write is completed?  The kernel
> seems to ignore that here entirely, so the write could actually complete
> seconds later, which would not be a good thing, right?
>
> Traditionally, we want to ensure that a write() completes, so on some
> busses, we have to do a read to ensure that the write made it to the
> hardware before we can continue on.  That is not happening here which is
> why Jiri keeps bringing it up.  It looks broken to us, and you need to
> document it somewhere (in the changelog?  In the top of the file?) as to
> why this is not needed.
>
> thanks,
>
> greg k-h
