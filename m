Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9A47CB38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 03:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhLVCCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 21:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhLVCCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 21:02:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20635C061574;
        Tue, 21 Dec 2021 18:02:34 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so2329306edd.8;
        Tue, 21 Dec 2021 18:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pvJ0VJBvj9qiKz1E6D8UeM5hFtVE1+1j1opSDSflxo=;
        b=hso3Yd7IWueqzl2mIgrOpP66XETFw/Qq6TD71x/nVKTezClSMd/aVDBCarWi1F3D3i
         nEwOP1sxgBDEslD6aKDTAFIN/JhQpIdVH2xWXv8G0WxGtpGnQGIGwrEhQDUExRVE6pOm
         7vQPP7Mry2+W5V2toB26R8UJyxWHJS5EKR/F8jiNQv3D0VzsjLQ/DYikkdfEwhC8oeiV
         hBHZdkKcZJXCo7o4bQZ/5I3rhrbCZ/J/hDqbFn0jiD/ukhw9tTS8VrVtRqwqH0NixuYr
         NZbvBwT3kPOxYXnF6YYJlfe7shMMAhQI87TWQC41zrPRxXMyCblQgvhC2Cz5yuUH3MDO
         uBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pvJ0VJBvj9qiKz1E6D8UeM5hFtVE1+1j1opSDSflxo=;
        b=Xsxr4pEDLSK6M2+s97MGNGNkOip6fn3t81VuM7+aJWdS9UWdnuOkHvL1jLTpeg29xm
         4VkCf7zMyAHfmUiXwL/i3kuGZiXmC/VSMqsA0v5l6I9EB2fhkTAgl//hbWOkoV60WXJK
         OrEY0IXC1ISC6yc2CTlqjSxM3ZlCT3INBd1l4MaO512pv+QcDUqpAKXM6wKp1T+7OmtK
         iCi/vc49hEUXAFTgYC2bPbHnOztoErxa5lQVpBBn+lUdwKTWoWWiUP1GldUU2Ru/B6DL
         22H5ID/QnBQwvOXzeS9ZPqGfNLAUfrzTuqovbUbiiEb2Tfk0GfWGN1KmTtQFxbErO6Ls
         FqBQ==
X-Gm-Message-State: AOAM530D/RSBfOv4NU7yOv7/Kbzk5FE8DNmf4rqPLQl6+j0AbI1A/pPz
        UTFW2rbXR54IhqV3wmQPpHGwfeYRDKkoEgmIBV4=
X-Google-Smtp-Source: ABdhPJzLpnG/UsK725GwrFFKPbmxb8uA6enGbrXJVIDRT1VOpS7WXzeYwddNf5loslL9Xzc0bUG2deH5QOcNKv1rmo8=
X-Received: by 2002:a17:907:7205:: with SMTP id dr5mr791523ejc.696.1640138552651;
 Tue, 21 Dec 2021 18:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20211222015244.2464671-1-Mr.Bossman075@gmail.com> <20211222015244.2464671-6-Mr.Bossman075@gmail.com>
In-Reply-To: <20211222015244.2464671-6-Mr.Bossman075@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 21 Dec 2021 23:02:21 -0300
Message-ID: <CAOMZO5DV7WKU_dO3KRERpcoManFZs1MbdL54BtSmtMnVY5ujrg@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] clk: imx: Add initial support for i.MXRT1050 clock driver
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

On Tue, Dec 21, 2021 at 10:52 PM Jesse Taube <mr.bossman075@gmail.com> wrote:


> +static struct platform_driver imxrt1050_clk_driver = {
> +       .probe = imxrt1050_clocks_probe,
> +       .driver = {
> +               .name = "imxrt1050-ccm",
> +               .of_match_table = of_match_ptr(imxrt1050_clk_of_match),

No need for of_match_ptr() here.
