Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5404B4896E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbiAJLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbiAJLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:00:54 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E6C06173F;
        Mon, 10 Jan 2022 03:00:54 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 30so50306925edv.3;
        Mon, 10 Jan 2022 03:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whE4KmnTtpH1LRN01z65fDsnjDV+xp8M0wHQj1JxF6k=;
        b=Pt+V7HqzQeecUPMk4kRTh4zz+Gg4lC8R/dh27MRTlzULKpWIYjwnL4Bn8sJvi2BO3e
         utmMjC84zYRzzaACJZ3F/jlTYQfniQnMnYIohuCkypRzBMKg6c2TAxt0U+qakj/JH6Iw
         iXCGdN45gAUY/sSBk6+i0rStLY19qVvsKQYSm4oHqWOD4pWGUyRV4uSJMX5hILmGhDpw
         1bj+5b6kfN41GnwymwZ1m4/qoDQaez8+9a69Xd0VnVjftr7PEe04YPd2LwFHqjmBJMIe
         h8u9+d2KAV4P50WGv7HFBeko+9c7TDrtr6TCk1WNkZ+KRQpIbAcc9kbwcLlwKT2UvBJo
         taeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whE4KmnTtpH1LRN01z65fDsnjDV+xp8M0wHQj1JxF6k=;
        b=z0qf9ic3Ekxb/EWt58hMkghGFliI2dULUTxEoidL1iM4RIudfwjeW017ZYtAkgx5fG
         0QJFWw9E/5HTb1akaOFJLqoslzb+Ad/vURfei/Lrkk0DikDlxDFH8BaWeChHIZ1EkbWp
         g44FEveHJDXF1BTfSk2Mu8lepAx651y085n+Ctie2SEyQ64t3OleHs3xZgSKYkH4mbf4
         jdvmpc5VYOuQ9y1Tjptx+kBmWHP6FT59Gu0FYa7aqrnCSeZ7cfYmP6bKdyCVsmx7uLFM
         V7feXyjGGNaX5V9CoohUazzRUjO279LACZAG/qNmY5MnYnNKl7TxqAM45Cz/y1VmdH3X
         TG7g==
X-Gm-Message-State: AOAM531f6JiUHHjF2NFolp1RIJh2YSZIVka+Ag8bTClUGMzSsE/IC2u9
        ebLbhBLwyMmot5M4TIPH6tKi+jxTVn28MK3TkN/RvU63E2sYOw==
X-Google-Smtp-Source: ABdhPJzuwB3FGbGu10/VJm9BYMQTIgGWTCzQTw1Yt3trPKn7q0NZoUs6mHu2rRb7qt2QmE7N/cfe/nszD1coBHK6rwA=
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr57745851ejc.497.1641812444067;
 Mon, 10 Jan 2022 03:00:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641797029.git.lhjeff911@gmail.com> <761604f7aa4d4df16637103ba10d34674faf3d9b.1641797029.git.lhjeff911@gmail.com>
In-Reply-To: <761604f7aa4d4df16637103ba10d34674faf3d9b.1641797029.git.lhjeff911@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Jan 2022 12:58:56 +0200
Message-ID: <CAHp75VecMe_KxgV1adr5Z7_EDz0s9MWB_RNeS4nY0m6e_eZ9Yw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] SPI: Add SPI driver for Sunplus SP7021
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        "LH.Kuo" <lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 8:47 AM Li-hao Kuo <lhjeff911@gmail.com> wrote:
>
> Add SPI driver for Sunplus SP7021.

In the subject line use small letters in the prefix. Check with `git
log -- drivers/spi` how people do.

Common comment: Consider to use spi_controller_*() APIs over
spi_master_*() ones. Also your SLA/MAS (and sla/mas) are a bit
confusing: spell them in full and master --> controller or ctrl, slave
--> peripheral or alike.

> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v5:
>  - Addressed comments from Mr. Mark Brown
>  - Addressed comments from Mr. Andy Shevchenko

You need to elaborate what exactly you addressed.

...

> +               writel(readl(pspim->m_base + SP7021_INT_BUSY_REG)
> +                       | SP7021_CLR_MAS_INT, pspim->m_base + SP7021_INT_BUSY_REG);

It's better to read with temporary variable being used:

             value = readl(pspim->m_base + SP7021_INT_BUSY_REG);
             value |= SP7021_CLR_MAS_INT;
             writel(value, pspim->m_base + SP7021_INT_BUSY_REG);

...

> +       writel(readl(pspim->m_base + SP7021_SPI_STATUS_REG) | SP7021_FD_SW_RST,
> +              pspim->m_base + SP7021_SPI_STATUS_REG);

Ditto. And for all other similar cases.

...

> +       pspim->xfer_conf |= ((clk_sel & 0xffff) << 16);

Is xfer_conf bigger than 32-bit? If not, why do you need the ' & 0xffff' part?

...

> +               ret = 0;

Is it necessary to do this under the lock?

> +               if (pspim->xfer_conf & SP7021_CPOL_FD)
> +                       writel(pspim->xfer_conf, pspim->m_base + SP7021_SPI_CONFIG_REG);
> +
> +               mutex_unlock(&pspim->buf_lock);

...

> +       if (spi_controller_is_slave(ctlr)) {

Factor out this body to a function, it will increase readability.

> +       }
> +
> +       spi_finalize_current_transfer(ctlr);
> +       return ret;

...

> +       mode = SP7021_MASTER_MODE;

This...

> +       pdev->id = of_alias_get_id(pdev->dev.of_node, "sp_spi");

> +       if (of_property_read_bool(pdev->dev.of_node, "spi-slave"))
> +               mode = SP7021_SLAVE_MODE;

...belongs to this condition, so do not interleave them.

On top of that you may use device property API:

    if (device_property_read_bool(&pdev->dev, "spi-slave"))
        mode = SP7021_SLAVE_MODE;
    else
        mode = SP7021_MASTER_MODE;

...

> +       pm_runtime_enable(dev);
> +       ret = spi_register_controller(ctlr);
> +       if (ret) {
> +               pm_runtime_disable(dev);
> +               return dev_err_probe(dev, ret, "spi_register_master fail\n");
> +       }
> +
> +       return ret;

return 0;

...

> +MODULE_LICENSE("GPL v2");

"GPL", the one you used is legacy.

-- 
With Best Regards,
Andy Shevchenko
