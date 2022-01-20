Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C83494B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359663AbiATJwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiATJwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:52:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A8EC061574;
        Thu, 20 Jan 2022 01:52:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z22so26074429edd.12;
        Thu, 20 Jan 2022 01:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u7cI7G3trpUtnHCfqhJut3Gt91Xt99WAiwIJwAPsTAw=;
        b=Bn4QBTi3qUFOEld4FbuzD4vMnYnTqwdK+G1fNwrrZ6KfaG0UQ+3HG73aYE5wwFlOZE
         ESK+SW5NjSt6ewacY0L+HwFr2+b8zm6aBd3O+097nA53oDyjEfpU9vS8Bck09EYV+RQ1
         te3/x2WvicezIlvYZpOJCzzPVtD9Idq8v/VBbccvQUAcml1ToyaFPu4NUwFD1AsXEOFp
         XGXe0q2UUW3Ff86m0uWB3ulVW1MK07WVNLYpDcpqs1bp4fDDRI0c6p3q5nIEJ/j5Gc9D
         fCANAT+CQIgfbw2LhqORBICjVk9HoYKOSBxyYaKNI0RmdqYONz61iyk3fqXwgffqIZwS
         8tJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u7cI7G3trpUtnHCfqhJut3Gt91Xt99WAiwIJwAPsTAw=;
        b=H69uywMOhZcJ+TMdR8wDytA9OZn6yP6v2fSEDSGCoI7bpUsdxFptZ5kQ1Aw1hy7AC2
         XAW1APsUQXCTzGvjnJmGgyaqRKNjX/VQlGJvyKi5Lom64KXLt5S8on6Ig6B4fZxbLO7V
         21K6tXnxIyOta/2uuz0XlBqHTSOof7D57KDXty7FTFbBdqCuuBKRWWdvNZFmVQdcQYVF
         EwwMf/BivrhEuVkqCrILO/JxRce14PsYZHPCDpGdOAEn7lhwJsC9CbuSZxCkDQf4ICSH
         IxdmYbkO7lQgnBLgFvna3kTnPGyQLz7fiF5QPjdny6u/+iPi7p3GH4DVD2laE9+l8gmU
         L1Aw==
X-Gm-Message-State: AOAM532nr2hoBKpVC9KwCfLyMfrPQ2KuAFcgZ8p+ZI2UArYa+m0T/U5x
        c06+ZI8Ika2YyENzyZTkKNa0YzJgtmjY3G/ah00=
X-Google-Smtp-Source: ABdhPJx4+iS7ZkJcPZi0fD7oBM2YZShC8sysR8IZth0qPgv938kiIhEIqRFJ+pQme4LKAHtGx0LwZ2irIzmheauxbwA=
X-Received: by 2002:a17:907:968c:: with SMTP id hd12mr27722577ejc.639.1642672327429;
 Thu, 20 Jan 2022 01:52:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642494310.git.lhjeff911@gmail.com> <37998e515d561e762ee30d0ac4fca25a948e0c5c.1642494310.git.lhjeff911@gmail.com>
 <CAHp75VdKc3UDzaqM2G5J5+G90U6Spqyhz_vuOYKhqJ4V-uf=wg@mail.gmail.com> <a354d7c1dce4463ea57706dd5443fe7a@sphcmbx02.sunplus.com.tw>
In-Reply-To: <a354d7c1dce4463ea57706dd5443fe7a@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Jan 2022 11:51:30 +0200
Message-ID: <CAHp75VcCpye1u3+PK=C3CT8fMHPSOsXTL5AhbLVy0YyGWfyfkQ@mail.gmail.com>
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

On Thu, Jan 20, 2022 at 11:22 AM Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=AA <lh.Kuo=
@sunplus.com> wrote:

...

> > > +       if (xfer->tx_buf)
> > > +               dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO=
_DEVICE);
> > > +       if (xfer->rx_buf)
> > > +               dma_unmap_single(dev, xfer->rx_dma, xfer->len,
> > > + DMA_FROM_DEVICE);
> >
> > Why can't you use SPI core DMA mapping code?
>
> I didn't find the SPI core DMA mapping code for single maping.
> The method currently used is the general DMA single-map code usage method=
.

Why do you need single page mapping?
What's wrong with SG mapping that SPI core provides?

...

> > > +       device_set_node(&ctlr->dev, pdev->dev.fwnode);
> >
> > Use dev_fwnode() in the second argument.
>
> You mean as below ?
>
> device_set_node(&ctlr->dev, dev_fwnode(dev));

Yes.

--=20
With Best Regards,
Andy Shevchenko
