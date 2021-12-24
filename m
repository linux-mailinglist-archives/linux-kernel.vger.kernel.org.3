Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C5447EDB5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352210AbhLXJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352184AbhLXJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:21:22 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF156C061401;
        Fri, 24 Dec 2021 01:21:21 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r138so7179075pgr.13;
        Fri, 24 Dec 2021 01:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jPTx7nBzf3LGvXSQtblaPA6rluMMl4EIwS4QSTaWNdQ=;
        b=S/G2s7v9BwstG5jCKU8gxj0HYm4JOcx8yewb+48mW6QSQyTq3Rh92pqutu4azFNwBJ
         7XTkFCnna2RIbPUXHDEkE0OqzmPRr5Ybgd2Iceg0pRORmM2cLEOveHQSaj0i2L6VBiex
         P8HobsWgdlfjBZAqJa/nWOcZqx3B0rvkGguJ75Vq5UWipG0t7gwzrs5d3GN2wo6JLaip
         XqdbgTVunkrxgtVu8XiOzXOH3ClTsPpfsw2J8bNmSIGCoCEzwtifpTpwpyZp38ORut/Z
         9yi0zQbqllyVJvcFNrArEFykcUZcUMDr63+izcagTYusBFQD+iSaWcvcGNB1ix4Pr0p+
         i/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jPTx7nBzf3LGvXSQtblaPA6rluMMl4EIwS4QSTaWNdQ=;
        b=xz3qCi2NqXIjCxkkB+9fcJSJEU36AcufEgA9CDncQi2D/UyHtEDx9SHu1CNQT7nIt9
         eSB+L7j1DOBMw0AwjTqu0/xDwJNEMkMs2+Sg5hhi8SBYsvi52XKUwsmRhBbsJRDhZP+1
         MUvVkfgj/B1dgMyDpv+xt42M8Se6tYGnyatME5qyn3qw/GI4JfrGyp9kEPUJczm5hAXq
         vZly1xaF4XhW143dHqW7JMJsb0yUtKMp6ldKFbZ2MRTnrekX4YaR9Z7wYdxmVCYPe8ae
         dj+yxJo5TIoZssnmQR/FVQWuYDNrIaccVLXYqFsJCEOKuIEUaYI5hgn+SjQXwvAkNJs7
         zEDg==
X-Gm-Message-State: AOAM532Hv6sWd2H+CjCIN2klMJJQZrCZ2Ob5+tbasuHL6prldS9gwhMt
        B+AVOrK0VsIDmdlO9dNjC8/Yp3gC+oIG3xqt6QuHPpLIdWH8cQ==
X-Google-Smtp-Source: ABdhPJz83YQbB1p+N/DrriVlSCxR13zuFw4QgI5rHqcDrrdrRy6QSkXzM16JVop4Dp8A8hg+yfZbRCWAn1A0ubnKKQs=
X-Received: by 2002:a05:6a00:16d3:b0:4ba:4aee:2e34 with SMTP id
 l19-20020a056a0016d300b004ba4aee2e34mr6048662pfc.82.1640337681216; Fri, 24
 Dec 2021 01:21:21 -0800 (PST)
MIME-Version: 1.0
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
 <YcCmaJkeKy+R0mhF@kroah.com> <CAOX-t54j9=7eLMAx4n-ngiNdM=Ab=YcK-zdxRW88e41cPS=46Q@mail.gmail.com>
 <YcGOmzKSHOoycZNC@kroah.com> <CAOX-t55fBM7u3qZm7ubLANDnWNFhCiBXB29v00racWd-gy3OgA@mail.gmail.com>
 <YcWL4c0e02mzETMp@kroah.com> <CAOX-t557bRfBk0+ixH_zXkxpt54cf96vNc1Fq7yNejVLOrc--g@mail.gmail.com>
In-Reply-To: <CAOX-t557bRfBk0+ixH_zXkxpt54cf96vNc1Fq7yNejVLOrc--g@mail.gmail.com>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Fri, 24 Dec 2021 17:21:27 +0800
Message-ID: <CAOX-t55bGWY99r0=SYcMgUBpSCHRznHk3KFrtScq9X_J+8boyw@mail.gmail.com>
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

I am still not really understand why you said the driver looks like 8250.
SP7021 SoC have our own register define.
That's why we submit a new serial driver.

Refer to:
https://sunplus.atlassian.net/wiki/spaces/doc/pages/1873412290/13.+Universa=
l+Asynchronous+Receiver+Transmitter+UART

Regards,
Hammer Hsieh

hammer hsieh <hammerh0314@gmail.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi, Greg KH:
>
> 8250 driver means create driver in drivers/tty/8250/ ?
> and current I create driver in drivers/tty/serial/ not correct ?
>
> Regards,
> Hammer Hsieh
>
> Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:59=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Fri, Dec 24, 2021 at 03:16:55PM +0800, hammer hsieh wrote:
> > > Hi, Greg KH :
> > >
> > > In patch v1 coding quite mess, it is almost 2000 LOCs.
> > > For down size code under 1000 LOCs, I decide to drop DMA function cod=
e
> > > after patch v3.
> > > I think that's the biggest difference compared with 8250.
> > > Without DMA function, like you said it looks like 8250 variant.
> > > I think I should put DMA function back in next submit.
> >
> > The 8250 driver handles DMA just fine today, why is your chip doing it
> > differently?  Are you sure it is a different chip?  Who created a new
> > uart chip these days?
> >
> > > Another question for why I need PORT_SLUNPLUS ?
> > > I just check many other uart driver, almost all driver define their
> > > own PORT number.
> > > Actually, I didn't know about it.
> > > Maybe some device like bluetooth(use uart port) need autoconfig.
> > > Then it will call ioctl with TIOCSERCONFIG.
> > > I don't have tool for calling type/config/request/release/verify.
> >
> > If you do not need it, and you can not test for it, please do not add
> > it.
> >
> > thanks,
> >
> > greg k-h
