Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756374828B0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 23:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiAAWDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 17:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiAAWDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 17:03:23 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8884C061574;
        Sat,  1 Jan 2022 14:03:22 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id o7so34476765ioo.9;
        Sat, 01 Jan 2022 14:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THNuUA/tawUOChSQp/rfs6Latr7Yv/+qgS3Y2JmuUGA=;
        b=ZacxIIWNUo+AbuiIdxvpb5y8+2CauYGT7/ignb/84oOsyae5r5y0/6F49APuiqyCge
         iC6ThtbrG8wvoUZj3S17tSfs8M6m8K9vrMDFIit0V/T161s8UyTpn23HQGzt8FFl8oLx
         WeRbWB8f4UL/MdFpPF+0fnjDjRUFldX+scN+68dc4tdBYW9OalEH+xWNHAEW/B/Ubq+B
         Fr6yfs+lO3HKMbIQ2ieISXgBBZaPg11Ma3gygL9jOT2SLfFzx+q5kma9bKNs8pRiIiwi
         B9UCN4pmXkPwJiuWsntwI5Tcr1/kD+R2BIGLXiC66IECZfe8BtTadXdAg6AgX3ppRDpy
         Zcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THNuUA/tawUOChSQp/rfs6Latr7Yv/+qgS3Y2JmuUGA=;
        b=b7SYMqzNxkp3nSIqP56d0+yiwkXQiUB1DriZNOr2OXJpGz5cdLMDP6C48wddgaDZ1e
         rvf3l3Rv0yZbEZNXBnT3UybFSYPio/Qbk23pTuTui879yrY1BHZADXQoldltEx97Rm0R
         Yl8Ms65DhnKxNfXnLGQEtFKtYftz18iTBbL+62At6+kOTTjT+wB/Vdi8cLk8tx0fCzpS
         h8heqh42CHVEjumwvpX5FHIjGpnYzprhhjuzoA2+pJIPjnrHL1Tg9WEml4LmQTNTV1+W
         8a9LGZPv/xBG9DRMBFH09372ev7mVLsm5pcUTtIC4VgCOyHtx+c9J8l22JakTGxzEOiM
         ttJA==
X-Gm-Message-State: AOAM533xKfWmrY8sW0W6rleWNUTtkI+BDxHJHrbG3xq2BgTE3Hx4zBNk
        klAl9T821PYKkgEoO2RZe/XsyLmiQG9em5I9XD0=
X-Google-Smtp-Source: ABdhPJxcG0EXw2tagv/W5t5LK62AU4A1PFcHqm07qBTmFiz/YbDF7BDVZZrWch9dJLDeK5Yf7lZp6YvMCElQropPc50=
X-Received: by 2002:a05:6602:140c:: with SMTP id t12mr18092473iov.187.1641074601679;
 Sat, 01 Jan 2022 14:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20211216122525.136139-1-alistair@alistair23.me>
In-Reply-To: <20211216122525.136139-1-alistair@alistair23.me>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sun, 2 Jan 2022 08:02:55 +1000
Message-ID: <CAKmqyKP79x-PdEiBAye3tBtYgj17T6WF6pM84vXVHYwPNXshgg@mail.gmail.com>
Subject: Re: [PATCH v17 0/8] Add support for the silergy,sy7636a
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Sascha Hauer <kernel@pengutronix.de>, lgirdwood@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-hwmon@vger.kernel.org, amitk@kernel.org,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:25 PM Alistair Francis
<alistair@alistair23.me> wrote:
>
> v17:
>  - Rebase and fix build issues
> v16:
>  - Improve vdd regulator comments
> v15:
>  - Address comments on the patches
> v14:
>  - Merge the thermal driver and hwmon
> v13:
>  - Address comments on thermal driver
>  - Rebase on master (without other patches)
> v12:
>  - Rebase
> v11:
>  - Address comments on hwmon
>  - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message
> v10:
>  - Use dev_get_regmap() instead of dev_get_drvdata()
> v9:
>  - Convert to use the simple-mfd-i2c instead
>
> Alistair Francis (8):
>   dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
>   mfd: simple-mfd-i2c: Add a Kconfig name
>   mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
>   regulator: sy7636a: Remove requirement on sy7636a mfd
>   hwmon: sy7636a: Add temperature driver for sy7636a
>   ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
>   ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a
>   ARM: dts: imx7d-remarkable2: Enable lcdif

All of the code changes have been reviewed or acked. Could some of
these patches go into 5.17?

Alistair

>
>  .../bindings/mfd/silergy,sy7636a.yaml         |  82 +++++++++++
>  Documentation/hwmon/index.rst                 |   1 +
>  Documentation/hwmon/sy7636a-hwmon.rst         |  26 ++++
>  arch/arm/boot/dts/imx7d-remarkable2.dts       | 136 ++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig          |   3 +
>  drivers/hwmon/Kconfig                         |   9 ++
>  drivers/hwmon/Makefile                        |   1 +
>  drivers/hwmon/sy7636a-hwmon.c                 | 106 ++++++++++++++
>  drivers/mfd/Kconfig                           |   2 +-
>  drivers/mfd/simple-mfd-i2c.c                  |  11 ++
>  drivers/regulator/Kconfig                     |   1 -
>  drivers/regulator/sy7636a-regulator.c         |   7 +-
>  include/linux/mfd/sy7636a.h                   |  34 +++++
>  13 files changed, 415 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
>  create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst
>  create mode 100644 drivers/hwmon/sy7636a-hwmon.c
>  create mode 100644 include/linux/mfd/sy7636a.h
>
> --
> 2.31.1
>
