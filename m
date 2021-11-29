Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848164619E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378864AbhK2Omj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379016AbhK2OkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:40:22 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42640C08ED7F;
        Mon, 29 Nov 2021 05:10:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so71709384edd.9;
        Mon, 29 Nov 2021 05:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pY+oBIJ6nsDonvusI0wqpwLwI06OOOrdfnr9/OEWHxQ=;
        b=MtIcIlmo4ivVnodFYETHeD3gQ54PlKGvSXomU3ABxOd5mf+0nfmhtbJ4+b2yiU6nmP
         ADV329TLM8fb8MRst0whcjGOONwxfMpfy8oTZeQ2QALkXj8S3udnuZn4zhE5/qZkYIaQ
         xHDPEGVdtnb2km6GrxSXJQdqL3pgcCgzeYesLVFbypiDvMY9dwjqFT6UayYLHcg9cbAD
         C+Q8GSoeZ0bUC1WYnBXmo/dIW+k85R9X/2c4Pczk/SJUwwIRbHLlR/6lQRsVHdPv4L6Q
         5GnCkRp8hPWzRmPZ2gkEUhIH59Dz7eJYgZQ2QtRMpCCf0Bu6UHKbjyLNcqoQ/vLVA92S
         kKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pY+oBIJ6nsDonvusI0wqpwLwI06OOOrdfnr9/OEWHxQ=;
        b=kPgQPpsnayO/T9bktjq5hmBl2wW2UQHWTn/IfEqy9jk6dvs2iBYm0sHtw2yEIJBwn7
         PDM4T7hlSlkjzVDf75aMfX4pPy91ZgeftuzENlQ0bx2XqUrHRQUhuzIT7WDeqoLCVxWB
         FJcZY+DFoOD8aJFy9368GqddvTHWawbD9dxgxMStfRo8iYMU8+JOUDlS0tqUETMT5B3T
         9j90QsAQUOhoqbBJmL96oBc4sgmYO21YWS25o/r9p4YMpaXgbCyXSEoG4yy6E8xprffN
         VK2RkENn+ew/mTYvo8BDrkoNX7R5jHitqHt95NaiBIF8PftWS0VebIdwGZg7zFW8txqK
         4o7g==
X-Gm-Message-State: AOAM531pSIkBtobEFBlYNJ/SAzVsBHmTwKGm5R6HAtf4BLIA9HlrwUcw
        mOjIdhjGW7j/HwI60aQN7A0BXa+3uF2elLADZK8=
X-Google-Smtp-Source: ABdhPJxubt2PpVpW9xRww6T+5TVp5a6a6yyZmst2klLH4iVp9EsPxnQVZP+hLqyD8dnQAVbAQPIVC/xdsiIfeLnVnro=
X-Received: by 2002:a05:6402:291:: with SMTP id l17mr75370842edv.242.1638191443745;
 Mon, 29 Nov 2021 05:10:43 -0800 (PST)
MIME-Version: 1.0
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <cover.1637547799.git.lh.kuo@sunplus.com> <e5f2549224cf875d81306ef5f6e98db1cfd81c2e.1637547799.git.lh.kuo@sunplus.com>
 <CAHp75Vd2=OHbrpGtsU8AMXdtNfvSPhpc7vhzkWnahaV48XbfUQ@mail.gmail.com>
 <YZz0n6Mpjl3tKmMe@sirena.org.uk> <CAHp75Vf6+monqu4Hq-yoFSohD9tNFqZTuKjqDDKAJE3Om2BUYQ@mail.gmail.com>
 <6eb68a8153ba46c48862d00f7aa6e0fe@sphcmbx02.sunplus.com.tw>
 <CAHp75VftSORts5cbDxvfyHgqhxmb7K74BfPd=mST+75C+Ch9dQ@mail.gmail.com>
 <33d50e94059b4734939db60b5c531bc9@sphcmbx02.sunplus.com.tw>
 <63a467164c985cadce0e28e50508363a8d2f6622.camel@pengutronix.de>
 <YaDbHe+COa3pke+s@sirena.org.uk> <d33a3a4f3b8248a78fae572a7f88050a@sphcmbx02.sunplus.com.tw>
In-Reply-To: <d33a3a4f3b8248a78fae572a7f88050a@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Nov 2021 15:10:10 +0200
Message-ID: <CAHp75VftWNHXG7k09qHtJNFaYe0hvSfNBnQht=D6O7UJH27a5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] SPI: Add SPI driver for Sunplus SP7021
To:     =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "LH.Kuo" <lhjeff911@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 8:20 AM Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=AA <lh.Kuo@=
sunplus.com> wrote:

>    Feel sorry. I haven't found any devm PM API use in the SPI driver, and=
 I didn't realize that PM function also has devm API. So I was confused bef=
ore. I will move the pm_runtime_enable() after the devm_spi_register_contro=
ller() . I have rewritten the Probe and Remove functions as shown below.

Neither you found APIs for clock and reset, Try to grep for
devm_add_action_or_reset().

So, for PM it is probably good to leave it last, but you still have the iss=
ue.

>    And sp7021_spi_controller driver is modified and the code cleaned more=
 than -50 LOCs. If the Probe and Remove functions is OK I will start next s=
ubmission.

No, it's not okay.. yet, but we are closer. See my comments above and below=
.

>    Thanks for all comments
>
> static int sp7021_spi_controller_probe(struct platform_device *pdev)
> {
>         struct device *dev =3D &pdev->dev;
>         struct sp7021_spi_ctlr *pspim;
>         struct spi_controller *ctlr;
>         int mode;
>         int ret;
>
>         dev_info(dev, "sp7021_spi_controller_probe\n");
>
>         mode =3D SP7021_MASTER_MODE;
>         pdev->id =3D of_alias_get_id(pdev->dev.of_node, "sp_spi");
>
>         if (of_property_read_bool(pdev->dev.of_node, "spi-slave"))
>                 mode =3D SP7021_SLAVE_MODE;
>
>         if (mode =3D=3D SP7021_SLAVE_MODE)
>                 ctlr =3D devm_spi_alloc_slave(dev, sizeof(*pspim));
>         else
>                 ctlr =3D devm_spi_alloc_master(dev, sizeof(*pspim));
>         if (!ctlr)
>                 return -ENOMEM;
>

>         ctlr->dev.of_node =3D pdev->dev.of_node;

device_set_node()

>         ctlr->bus_num =3D pdev->id;
>         ctlr->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_F=
IRST;
>         ctlr->auto_runtime_pm =3D true;
>         ctlr->prepare_message =3D sp7021_spi_controller_prepare_message;
>         if (mode =3D=3D SP7021_SLAVE_MODE) {
>                 ctlr->transfer_one =3D sp7021_spi_sla_transfer_one;
>                 ctlr->slave_abort =3D sp7021_spi_sla_abort;
>                 ctlr->flags =3D SPI_CONTROLLER_HALF_DUPLEX;
>         } else {
>                 ctlr->bits_per_word_mask =3D SPI_BPW_MASK(8);
>                 ctlr->min_speed_hz =3D 40000;
>                 ctlr->max_speed_hz =3D 25000000;
>                 ctlr->use_gpio_descriptors =3D true;
>                 ctlr->flags =3D SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_M=
UST_TX;
>                 ctlr->transfer_one =3D sp7021_spi_mas_transfer_one;
>         }
>         platform_set_drvdata(pdev, ctlr);
>         pspim =3D spi_controller_get_devdata(ctlr);
>         pspim->ctlr =3D ctlr;
>         pspim->dev =3D dev;
>         spin_lock_init(&pspim->lock);
>         mutex_init(&pspim->buf_lock);
>         init_completion(&pspim->isr_done);
>         init_completion(&pspim->sla_isr);

>         pspim->mas_base =3D devm_platform_ioremap_resource_byname(pdev, "=
master");
>         pspim->sla_base =3D devm_platform_ioremap_resource_byname(pdev, "=
slave");

Where are the error checks?

>         pspim->mas_irq =3D platform_get_irq_byname(pdev, "mas_risc");
>         if (pspim->mas_irq < 0)
>                 return pspim->mas_irq;
>
>         pspim->sla_irq =3D platform_get_irq_byname(pdev, "slave_risc");
>         if (pspim->sla_irq < 0)
>                 return pspim->sla_irq;
>
>         ret =3D devm_request_irq(dev, pspim->mas_irq, sp7021_spi_mas_irq,
>                                                 IRQF_TRIGGER_RISING, pdev=
->name, pspim);
>         if (ret)
>                 return ret;
>
>         ret =3D devm_request_irq(dev, pspim->sla_irq, sp7021_spi_sla_irq,
>                                                 IRQF_TRIGGER_RISING, pdev=
->name, pspim);
>         if (ret)
>                 return ret;
>
>         pspim->spi_clk =3D devm_clk_get(dev, NULL);
>         if (IS_ERR(pspim->spi_clk))
>                 return dev_err_probe(dev, PTR_ERR(pspim->spi_clk), "clk g=
et fail\n");
>
>         pspim->rstc =3D devm_reset_control_get_exclusive(dev, NULL);
>         if (IS_ERR(pspim->rstc))
>                 return dev_err_probe(dev, PTR_ERR(pspim->rstc), "rst get =
fail\n");

>         ret =3D clk_prepare_enable(pspim->spi_clk);
>         if (ret)
>                 return dev_err_probe(dev, ret, "failed to enable clk\n");
>
>         ret =3D reset_control_deassert(pspim->rstc);
>         if (ret) {
>                 dev_err_probe(dev, ret, "failed to deassert reset\n");
>                 goto err_free_reset;
>         }

These two need to be wrapped as I explained above.

>         ret =3D devm_spi_register_controller(dev, ctlr);
>         pm_runtime_enable(dev);
>         if (ret) {


>                 dev_err(dev, "spi_register_master fail\n");
>                 goto err_disable_pm_runtime;

  pm_runtime_disable();
  return dev_err_probe();

>         }
>
>         return ret;
>
> err_disable_pm_runtime:
>         pm_runtime_disable(dev);
> err_free_reset:
>         reset_control_assert(pspim->rstc);
>         clk_disable_unprepare(pspim->spi_clk);
>
>         return ret;
> }
>
> static int sp7021_spi_controller_remove(struct platform_device *pdev)
> {
>         struct spi_controller *ctlr =3D dev_get_drvdata(&pdev->dev);
>         struct sp7021_spi_ctlr *pspim =3D spi_master_get_devdata(ctlr);

>         spi_unregister_controller(ctlr);

Lukas already explained to you why this is wrong.

>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);

>         reset_control_assert(pspim->rstc);
>         clk_disable_unprepare(pspim->spi_clk);

This has the same ordering issue as already discussed.

>         return 0;
> }


--=20
With Best Regards,
Andy Shevchenko
