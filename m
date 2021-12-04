Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A17468438
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384680AbhLDKum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351571AbhLDKuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:50:40 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C66C061751;
        Sat,  4 Dec 2021 02:47:15 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x6so21827088edr.5;
        Sat, 04 Dec 2021 02:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d77EM0tE3JUwSxHiDu+PhK1bKg9re3Pgc3NQ6IiDdU0=;
        b=QREKril2aVYAeeErWGoUn7QGA7lzEfM8Bnfjg66RWZUwJmgfoNOH3BG8L9AxQPF6pJ
         AvGgyjTeu8vqYR6+vSr3AwNS+BmJOjGSfLEf/EUDWeIKUQ7erkhAavWUsQJ3ZWn7mGys
         mh7cNCCvpWRMx5iloQoly5kzF2tFucLZ7tiQyq3EUDIz4R1LFIynn2G3YFR9NiAUa8fb
         iIdiX3mEsvJUXmWlt5RNrVvaHlM6yBG5Ej6fVjyU8OoqWTkaU94YMCe3yX3iVjtVIorW
         pm8esUmh7dKNsphuRyVrmuozykq2O3iJyIL5YQ2CHLpY4Vdg3Nc/50LS+bRVVvYnVsci
         XwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d77EM0tE3JUwSxHiDu+PhK1bKg9re3Pgc3NQ6IiDdU0=;
        b=pVaz0Dlr7wMe+vA1C9li3I7rttV6wPObfLjomzEMZqgETpZrP4Y1DB3hsRQC35Iiu7
         tPut9dUTOFfHiQEFSDpJk4688R9vI3PfdeNJ9dngQ0H3lQB0dBZ1dAbUJ5tX+xbS1XId
         oWNkjA6qbmZg3PaoC+FlFV8bRumfRu9YzLfd/MAyVo6Hd1EJjR+ig6TbWHm+BS8ZydQm
         qrixLuMOmw2dz+Rnq0uELq5xuM8nwD2gIQP+eDOoxRy3pneVOwTvFvCNiz/u6rl36umH
         SCFka1jZAmD+WVAFaUdV2nfYFMWu96VyAKMPDtAgkml0fFnQyJHDfAPN1vrNR5Wsi5Hp
         h7SA==
X-Gm-Message-State: AOAM532ZM0B1+iTrW9pnP+coHxCZ9826BwTsqJOQNK8C82hWxJXxmZo1
        YIGVYbYMDvqvaeVAVpJBQo5rxazswteUnDw4Ulk=
X-Google-Smtp-Source: ABdhPJzjNMGKt1kskPkry21udVYUmkbii2mprzGh/hM7XWBm/ujHf1wyM5vRF8TshW0guQMFwG8dkpaCrs1muwTCrMk=
X-Received: by 2002:a17:907:1689:: with SMTP id hc9mr29466609ejc.445.1638614833775;
 Sat, 04 Dec 2021 02:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 4 Dec 2021 07:47:02 -0300
Message-ID: <CAOMZO5B15PqGZcGi6zneiqAmaA7y9-tELpeV7xRFYJm0SPLYqA@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Add initial support for the i.MXRTxxxx SoC
 family starting from i.IMXRT1050 SoC.
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
        Abel Vesa <abel.vesa@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

On Sat, Dec 4, 2021 at 3:10 AM Jesse Taube <mr.bossman075@gmail.com> wrote:

> Giulio Benetti (5):
>   ARM: imx: add initial support for i.MXRT10xx family
>   pinctrl: freescale: Add i.MXRT1050 pinctrl driver support
>   dt-bindings: imx: Add clock binding for i.MXRT1050
>   ARM: dts: imx: add i.MXRT1050-EVK support
>   ARM: imxrt1050_defconfig: add i.MXRT1050 defconfig
>
> Jesse Taube (8):
>   dt-bindings: pinctrl: add i.MXRT1050 pinctrl binding doc
>   ARM: dts: imxrt1050-pinfunc: Add pinctrl binding header
>   dt-bindings: clock: imx: Add documentation for i.MXRT clock
>   clk: imx: Add initial support for i.MXRT clock driver
>   dt-bindings: serial: fsl-lpuart: add i.MXRT compatible
>   tty: serial: fsl_lpuart: add i.MXRT support
>   dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT compatible string
>   mmc: sdhci-esdhc-imx: Add sdhc support for i.MXRT series

The emmc and pinctrl patches have already been applied and they are available
in linux-next. No need to resend them.
