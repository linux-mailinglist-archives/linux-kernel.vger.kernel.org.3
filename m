Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C21347ED9C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352163AbhLXJFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbhLXJFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:05:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD57C061401;
        Fri, 24 Dec 2021 01:05:08 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso11115920pji.0;
        Fri, 24 Dec 2021 01:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZtWviuM2svOL62XQib/u8jAcDfkmSHw5Joy4m/XUxEI=;
        b=aHCY8nl+RjZUpva5jE1019Zhse4y7dhTcpGyIiAtPPygnapyRpMKdBb2U1rz6f1l4S
         sTHaEPJ/wH1y2y+zQtGNTasVxZzJYO2DVJVZybp5AsJH928HNz1cTQdfZZF4l2Mf4/+6
         Ch8w9DN5CLGxYP/QszY+ZQwgj8jls55fj0SOrZG+r6Ml271089MvAKGiiRxew+hDZxTD
         pCxzgAUewHmEL34YNhcVd36gqYVf95csFsn/ElLNvtx9yM+3NBNCCBKl4voIVUtgVK/I
         2VFDx78BUmXPr81+oaMRtcVCRGM7IrPbjjvzojzNyotJL9s9aidwgycXE+9lfDrDL7lu
         ZpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZtWviuM2svOL62XQib/u8jAcDfkmSHw5Joy4m/XUxEI=;
        b=2xsKcKtz6sUnIRTYnPkY2uuArPISSSXCbsznf9eRBElX/XgmyCC+FAk5uVb9zI+1Ia
         UmDkhX0o1IQeBgL9zqz6iDGXNXbqp3Uq/f4kfgD7dXctZhu5ndRI/z/7pKgQ2/9DFU/M
         bAEfPsx9M3+kZyQtV1dI/h2EVDo8AbkT90BJPF87t9hY1sS5UA3qDzyuCjiu1WDyzhs8
         CoEOHCv0SY8s9ZkEeGXkZQf1zCiO+q6i5gVq+Zxw+w77uubypkRHuKk9+qY7OeADEykI
         QOn2uR+wNSIAWUH34CSA9MXyg8b6Le+8aJRrS9p1PBW6RkzrPKUHdpYw4LdwMFZU+oZv
         Aq9A==
X-Gm-Message-State: AOAM533jaHof0vVimcCGufaOBDeFW3GpLqiphgfkLmXQHItugze4CK8+
        /iHEJna36IW1goCo2YplXNbd/qgQKs7d8Ig7KhV+WaGp
X-Google-Smtp-Source: ABdhPJxB/jNk43HuUyfi+7/OXm4clt8nBJDBznVZdDuJ681+/Qo5ksgxXqCzLzZNWTfADBNB7DaO1t53OM1oZRtqKJU=
X-Received: by 2002:a17:902:e5c4:b0:149:5945:72e8 with SMTP id
 u4-20020a170902e5c400b00149594572e8mr3678663plf.142.1640336708230; Fri, 24
 Dec 2021 01:05:08 -0800 (PST)
MIME-Version: 1.0
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
 <YcCmaJkeKy+R0mhF@kroah.com> <CAOX-t54j9=7eLMAx4n-ngiNdM=Ab=YcK-zdxRW88e41cPS=46Q@mail.gmail.com>
 <YcGOmzKSHOoycZNC@kroah.com> <CAOX-t55fBM7u3qZm7ubLANDnWNFhCiBXB29v00racWd-gy3OgA@mail.gmail.com>
 <YcWL4c0e02mzETMp@kroah.com>
In-Reply-To: <YcWL4c0e02mzETMp@kroah.com>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Fri, 24 Dec 2021 17:05:14 +0800
Message-ID: <CAOX-t557bRfBk0+ixH_zXkxpt54cf96vNc1Fq7yNejVLOrc--g@mail.gmail.com>
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

Hi, Greg KH:

8250 driver means create driver in drivers/tty/8250/ ?
and current I create driver in drivers/tty/serial/ not correct ?

Regards,
Hammer Hsieh

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:59=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Fri, Dec 24, 2021 at 03:16:55PM +0800, hammer hsieh wrote:
> > Hi, Greg KH :
> >
> > In patch v1 coding quite mess, it is almost 2000 LOCs.
> > For down size code under 1000 LOCs, I decide to drop DMA function code
> > after patch v3.
> > I think that's the biggest difference compared with 8250.
> > Without DMA function, like you said it looks like 8250 variant.
> > I think I should put DMA function back in next submit.
>
> The 8250 driver handles DMA just fine today, why is your chip doing it
> differently?  Are you sure it is a different chip?  Who created a new
> uart chip these days?
>
> > Another question for why I need PORT_SLUNPLUS ?
> > I just check many other uart driver, almost all driver define their
> > own PORT number.
> > Actually, I didn't know about it.
> > Maybe some device like bluetooth(use uart port) need autoconfig.
> > Then it will call ioctl with TIOCSERCONFIG.
> > I don't have tool for calling type/config/request/release/verify.
>
> If you do not need it, and you can not test for it, please do not add
> it.
>
> thanks,
>
> greg k-h
