Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECB548E281
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiANCWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiANCWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:22:47 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58D4C061574;
        Thu, 13 Jan 2022 18:22:46 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 78so1518064pfu.10;
        Thu, 13 Jan 2022 18:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LxWz1XxWmdHwZ1n5pMFNTmKldKNHYVPbLqBsLCq6Sgc=;
        b=l96zVBJJ1msARQn9eZ7o74aqyk/6ZZaWiZ617DAeASvuWP7eqwxTNR1wAN3UiOE7j6
         KqOYGB4zyu8o8882RLBy0mVem9nSr6fg++WFEbfV2RxvOdM/2pjR95bVu1g3MY7lEZks
         ylV7SvKnESL7psW9sh6GidwltslfvSCuxcHVI4DhI0oI3dK3fNq79kDwSnEUDj9Sauch
         a+WyX3kGbcj3319zLUsMpontZGe4G6aruLpA4el5+rzhV4lP8vE4yLax4W60nuKF6NFp
         17BUErrJDRANS1YlBw6x9Td1TpP0uO4pH8r7aIuWM75xJaruNxU5tDTWHsyoTdsU8E3t
         2m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LxWz1XxWmdHwZ1n5pMFNTmKldKNHYVPbLqBsLCq6Sgc=;
        b=sMutJiTzOrZ0AeoykKjNJaciGgerYuSWzeBzWVUcM9Q/nM9eoHbjWf4KIyO7t4Oym7
         5U67ebkGxw14ijhdnrRIJg6mAOYhLcBWFUe470fZk/j6nD/IFCvasBeGNZ2MJE5CfiZ4
         QZU14k8KqmCP0blE//eAfjszrKBQY6sPw/bog+w+Uut9aOsKsDufRg1YcW7kgEvP3UeY
         XbXHp9A1B3MHKiMiLDIp6jdSGGJNMa9yRI0c+R/ORGXs80cl8a7GpHvjxfSeaZPXyn7A
         0cojQcTUHlvSiGtBZWoSKJTYe4YN3Sw9wwMXUsX2AdL0QEgFpyNClCF2WYG+H8FtOP0g
         ZlAg==
X-Gm-Message-State: AOAM531BAM95VxN67D2fyQ/PdwjlwBrp5FyY/YK7QXXtTe/xUgsDDpLs
        sI0CTrvVQ6w2eT/6BNQK/yb0P9qiMJ+Npt6L95c=
X-Google-Smtp-Source: ABdhPJycQjByHPHGZGk0Zwa6KNQli7U81Q02cS0/fP6/dEzjuugC58mxATM483BsHEpVYhlB2XF6wRJAChbUAiUhGpQ=
X-Received: by 2002:a63:8548:: with SMTP id u69mr1217959pgd.476.1642126966364;
 Thu, 13 Jan 2022 18:22:46 -0800 (PST)
MIME-Version: 1.0
References: <1641979444-11661-1-git-send-email-hammerh0314@gmail.com>
 <1641979444-11661-3-git-send-email-hammerh0314@gmail.com> <fcd43c65-6201-9e44-061c-f04e39cef726@kernel.org>
 <CAOX-t54oA9V94d3901w2xKSagSzmXc9r=TDTtbgaSLfL1DxNbw@mail.gmail.com>
 <d6d3aa07-7bf1-2b6d-356f-ae13c7b9d6cd@kernel.org> <CAOX-t57KZb0hNDuhPsabkmkf_qOOLqyH3yuvkHP6UNwhLodWDg@mail.gmail.com>
 <2cde3ff0-5180-7c1e-82fd-7b58e41d462a@kernel.org>
In-Reply-To: <2cde3ff0-5180-7c1e-82fd-7b58e41d462a@kernel.org>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Fri, 14 Jan 2022 10:22:56 +0800
Message-ID: <CAOX-t573QkixRC7xa1KUOYXfL12Q+Ltxph9rX7V8tm2BMoqxgA@mail.gmail.com>
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
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 13. 01. 22, 11:56, hammer hsieh wrote:
> >> Could you explain me what posted write is and how does it not matter i=
n
> >> this case?
> >>
> >
> > Each UART ISC register contains
>
> No, you still don't follow what I write. Use your favorite web search
> for "posted write" and/or consult with your HW team.
>

Maybe this time, we are on the same page.
Our SP7021 chipset is designed on ARM Cortex-A7 Quad core.
Register Access through AMBA(AXI bus), and it is non-cached.

Did you mean
case1 have concern about "posted write", and you want to know why it not ma=
tter?
case2 will be safer?

Case1 :
spin_lock_irq_save()
writel(0, target register)
spin_unlock_irqrestore()
Case2 :
spin_lock_irq_save()
tmp =3D readl(target register)
tmp &=3D ~(bit4 | bit5)
writel(tmp, target register)
spin_unlock_irqrestore()

I test uart port with linux-serial-test tool.
Ex. send char
linux-serial-test -y 0x55 -z 0x31 -p /dev/ttySUPx -b 115200
driver will call from uart startup till uart shutdown.
And it works fine, so I didn't think about "posted write" on Register bus.

> --
> js
> suse labs
