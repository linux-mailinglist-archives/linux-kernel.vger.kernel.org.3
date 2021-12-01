Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8BD46567D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhLATdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245394AbhLATdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:33:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452A0C061756;
        Wed,  1 Dec 2021 11:29:40 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y12so106196982eda.12;
        Wed, 01 Dec 2021 11:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HSA+wpNkFVTgXTMQMK9Eo4CLbDnWx6QS1vWmLRNYZ2s=;
        b=WDfqpi5ZYEY0azY9Z4QrgVLDsvTYCM+c4/TVNNFk9gXVSDiLKUTAB9CiLatc6eaD7g
         C34gQ6t/CEctbaDc2UUqR9c2qpdqKLT1HELMG/Yy2ol3bYLH0wC7U3TJz8YLSLr8oACG
         XZcOij1SLUwOWKyu/UcXyown+70dn+YaxClWxzp3p58QhRt39Cxa0XI5mS7ZzwpXQhzk
         LQQx014YSy+VXq2mwqUgdHWlHM5nX+S1oNSIHAPEpd6prgWD5MGqGmJ11DUFhBscMmxb
         qJ2cNzyQuLwsqbEG2iwp9dI9b/5XvLj1MGeWE6leu3kUpU7pbJhId+eAUO/jce582v+S
         yyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HSA+wpNkFVTgXTMQMK9Eo4CLbDnWx6QS1vWmLRNYZ2s=;
        b=Y0HR+VB92VpNQkFHmXU8/im9OgUQtExgPV/DmrN4UmMYc5sDEfzoU7M1fXgY65t/sz
         eQ/lMfxF9FtB1G46ul9Ajb06rQtzzSSf6ovD/ab+ql8/YhZvMT3rB5ZANAE6nqV6c5VC
         jQbo7PhLK03ZlxZr0KKsziTJ7IRsfU+07qtQEAJ+h//CNIWoG03wiUDoC9fCjpNwMWXt
         +TB1cZf1sms14LDtaw6seTwriqFcn+3KY+K98zJjfTiPSQUZmDyGwuXH8brlulWxGiO9
         FaOTX/NB2+L+MtwfaZxdJqo5BY1GwjWpAkG1PPCbG+dIXux/osB/E1+hwln+KIyUEXOU
         M2lg==
X-Gm-Message-State: AOAM530qIWgqKx2Pri+fXOxJiCRto78YIQh1UWt0VapGiTyuumAtjgce
        8AwTKa/+FwYjXvJUgZKiiSkdWpp6jE2HARqZJKw=
X-Google-Smtp-Source: ABdhPJwXKA5yyhQvQ3J79nSZqcS7ZG5U+cMz1A9BLSzFUJy0AWX6+XvPhzoGcS3fDgn3Pdf/CGbfjnrnX7mrxeV3PzA=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr9874209ejc.141.1638386978775;
 Wed, 01 Dec 2021 11:29:38 -0800 (PST)
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
 <CAHp75VftWNHXG7k09qHtJNFaYe0hvSfNBnQht=D6O7UJH27a5w@mail.gmail.com> <3d792085d6fc4be19253f5200c181041@sphcmbx02.sunplus.com.tw>
In-Reply-To: <3d792085d6fc4be19253f5200c181041@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Dec 2021 21:28:02 +0200
Message-ID: <CAHp75VfTqWy_J6SgTPsWOuav8uJrNVV3wDzxB+Ned7LXipaiwA@mail.gmail.com>
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

On Tue, Nov 30, 2021 at 10:32 AM Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=AA <lh.Kuo=
@sunplus.com> wrote:

> > >         ctlr->dev.of_node =3D pdev->dev.of_node;
> >
> > device_set_node()
>
> Is this funciton set as follows?
>         device_set_node(&ctlr->dev, of_fwnode_handle(pdev->dev.fwnode));

Can you please do something?
For example, figuring out yourself (Elixir is a very good service for
that): https://elixir.bootlin.com/linux/latest/A/ident/device_set_node

...

> > >         pspim->mas_base =3D devm_platform_ioremap_resource_byname(pde=
v, "master");
> > >         pspim->sla_base =3D devm_platform_ioremap_resource_byname(pde=
v,
> > > "slave");
> >
> > Where are the error checks?

> The changes are as follows? is this correct?

Almost, but not enough. Please run checkpatch.

>         pspim->mas_base =3D devm_platform_ioremap_resource_byname(pdev, "=
master");
>         if (IS_ERR(pspim->mas_base)) {
>                 return dev_err_probe(dev, PTR_ERR(pspim->mas_base), "mas_=
base get fail\n");
>         }
>
>         pspim->sla_base =3D devm_platform_ioremap_resource_byname(pdev, "=
slave");
>         if (IS_ERR(pspim->sla_base)) {
>                 return dev_err_probe(dev, PTR_ERR(pspim->sla_base), "sla_=
base get fail\n");
>         }

...

> > >         if (ret) {
> > >                 dev_err_probe(dev, ret, "failed to deassert reset\n")=
;
> > >                 goto err_free_reset;
> > >         }
> >
> > These two need to be wrapped as I explained above.
>
> I think these changes are depend on remove-function.

No, it's the other way around: ->remove() implementation depends on
these changes.

> These settings are as follows? is this correct?

No.

>         pspim->spi_clk =3D devm_clk_get(dev, NULL);
>         if (IS_ERR(pspim->spi_clk))
>                 return dev_err_probe(dev, PTR_ERR(pspim->spi_clk), "clk g=
et fail\n");
>
>         pspim->rstc =3D devm_reset_control_get_exclusive(dev, NULL);
>         if (IS_ERR(pspim->rstc))
>                 return dev_err_probe(dev, PTR_ERR(pspim->rstc), "rst get =
fail\n");
>
>         ret =3D clk_prepare_enable(pspim->spi_clk);
>         if (ret)
>                 return dev_err_probe(dev, ret, "failed to enable clk\n");
>
>         devm_add_action_or_reset(dev, (void(*)(void *))clk_disable_unprep=
are,
>                         pspim->spi_clk);

Please, find other drivers as examples of how to do that and take care
about possible errors.

>         ret =3D reset_control_deassert(pspim->rstc);
>         if (ret)
>                 return dev_err_probe(dev, ret, "failed to deassert reset\=
n");
>
>         devm_add_action_or_reset(dev, (void(*)(void *))reset_control_asse=
rt,
>                         pspim->rstc);

Ditto.

>         ret =3D spi_register_controller(ctlr);

Read what Lukas said.

>         pm_runtime_enable(dev);
>         if (ret) {
>                 pm_runtime_disable(dev);
>                 return dev_err_probe(dev, ret, "spi_register_master fail\=
n");
>         }
>
>         return ret;
>
> }
>
> static int sp7021_spi_controller_remove(struct platform_device *pdev)
> {
>         struct spi_controller *ctlr =3D dev_get_drvdata(&pdev->dev);
>
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
>
>         return 0;
> }

--=20
With Best Regards,
Andy Shevchenko
