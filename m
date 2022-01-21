Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89BF495D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379876AbiAUKJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiAUKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:09:53 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3058C061574;
        Fri, 21 Jan 2022 02:09:52 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b13so41144170edn.0;
        Fri, 21 Jan 2022 02:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+nHiMUAJkmDRtT1AUkXpecRKxulMj5tC/X/ZVwXvTX4=;
        b=ec8CeU9fMopF+iyri4E1qG/C22ppZFFNHMX3E4T1DA1zhNeXeVvLhhdwFBMspO5J3v
         JAb8u1GE4vwHkTgKzHXvFPZTUFeLQrfK6UVtV+f+XqEnPE+laqy6eiCIzhmiRzPQFiyE
         LRSboTvy7GhSK0Ap+TVXufp0dT5ljRnQ7lvSbotfQr2tSbdmohPEQkfSY9Xl4ZmWGZ0n
         DRGPAb0n4qT57LZEtlnGekvuTGNepK16GKVF9qdytph4FcjNaOtmNJTUcr8Zha64wNPl
         o1WB6WWBAScg+S/qbHpom5dFPRr3QNPd8cHEIsDXklcpcugfi4QgvUKolOEXEaVOXMSX
         79iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+nHiMUAJkmDRtT1AUkXpecRKxulMj5tC/X/ZVwXvTX4=;
        b=U1Ht74ApnGRdcbBoBbnu8NKoY0Q8FAEWjuS48SFAxUzwmlXNbPSX3NdOboZGDi4s9b
         Tc2vTonDSziYo+Jhqk2kdadwHIoQ2LOqBClDD7HheNkG0R0mX/0XqaEWGpwC2KmDahRk
         Q+5ifmHouzP4SXX4tRJr4YwkL1PAK7muqNipH3sBXBfdegOR7tJfNSybRdlTh9Je7gqJ
         NLs5ib0r+QgO1JfIGHSIykQSopW6huv4ZHmmXs5loXKB+W6VQcNtyCEnmcZ/SKkOtIcl
         y4/1Fq8tfI75cANYBKgr8i1G4g1qs1/9ls5jrcJEedj3RV1gBAUF5y33+cN9TAvvPLqu
         A/IA==
X-Gm-Message-State: AOAM530HihnWJSH3zMz/QXD8vNfCIMC/U/3SkMm+okfq6uqiS6kiDCL4
        +YHd/Vx6VmSa/wqCsyP40OkbFt+j5457E0QoyUg=
X-Google-Smtp-Source: ABdhPJwSzqwy6NLX4yEOhFYJkTtQdtsqNz2Q2jwoJY94p1ChkT7wOUYm2RT29n3Kym151PPMMz/VsHhI3wojm16AsBE=
X-Received: by 2002:aa7:c0c9:: with SMTP id j9mr3547651edp.270.1642759791349;
 Fri, 21 Jan 2022 02:09:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642494310.git.lhjeff911@gmail.com> <37998e515d561e762ee30d0ac4fca25a948e0c5c.1642494310.git.lhjeff911@gmail.com>
 <CAHp75VdKc3UDzaqM2G5J5+G90U6Spqyhz_vuOYKhqJ4V-uf=wg@mail.gmail.com>
 <a354d7c1dce4463ea57706dd5443fe7a@sphcmbx02.sunplus.com.tw>
 <CAHp75VcCpye1u3+PK=C3CT8fMHPSOsXTL5AhbLVy0YyGWfyfkQ@mail.gmail.com> <ee5838c307f84bb99ace070292167a26@sphcmbx02.sunplus.com.tw>
In-Reply-To: <ee5838c307f84bb99ace070292167a26@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Jan 2022 12:09:15 +0200
Message-ID: <CAHp75VcmFPCC0kDxOma6gunwFRf-eXEr6+ZxQs1dt5GH2quT4Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
To:     =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Cc:     Li-hao Kuo <lhjeff911@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 8:54 AM Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=AA <lh.Kuo@=
sunplus.com> wrote:
>
> > > > > +       if (xfer->tx_buf)
> > > > > +               dma_unmap_single(dev, xfer->tx_dma, xfer->len, DM=
A_TO_DEVICE);
> > > > > +       if (xfer->rx_buf)
> > > > > +               dma_unmap_single(dev, xfer->rx_dma, xfer->len,
> > > > > + DMA_FROM_DEVICE);
> > > >
> > > > Why can't you use SPI core DMA mapping code?
> > >
> > > I didn't find the SPI core DMA mapping code for single maping.
> > > The method currently used is the general DMA single-map code usage me=
thod.
> >
> > Why do you need single page mapping?
> > What's wrong with SG mapping that SPI core provides?
>
> SP7021 SPI slave dma only supports single dma in one trigger.
> It is not suitable for using SG mapping.
> If the length of the transfer is larger than the length of the SG-mapping=
,
> Slave-mode will get error in the transfer.

Same story for SPI DesignWare on Intel Medfield, where no SG transfers
are supported by hardware. Nevertheless, the DMA driver takes care of
this and on each interrupt recharges a channel to continue. Why can't
the same be implemented here?


--=20
With Best Regards,
Andy Shevchenko
