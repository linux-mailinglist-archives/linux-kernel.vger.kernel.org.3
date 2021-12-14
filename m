Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4849473B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbhLNDDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhLNDDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:03:16 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A6C061574;
        Mon, 13 Dec 2021 19:03:16 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z9so3966858edb.5;
        Mon, 13 Dec 2021 19:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQH8VcJRpdtHVG0Aky62QzlY2YR8DIAnVjnhwndnNuQ=;
        b=IrewzDxnwfVRH3+i04KeRgJ+SHoPzpAQZnxuHbX9MhwGhOVZH9HBweheIaHaWtPZw8
         1lcpMaNXHNAxeq0t83hPye+vZWpbg2F0j46EWWZan+aGaAqtrc4b6KfCe8pgFuCxJBbL
         8wJplxMmMuY6uJJlmwpCR0QNNs2eivvprjK2+NFhXAzOjMt1ZaYOGT6+LsJDT+5WspEn
         R/RdFOMqRxIjU4ja0yfHfL7oUWqH41UmEIzAK3xeszQAukNoUXyrvhNTpeO+MR4rOXdX
         8bqPWpI8+t/YzZoV7oa17ZYBRifwcz/u2rh4wOq8AyMU2g4ivY90NA5Vql9eRuM+RhJq
         dx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQH8VcJRpdtHVG0Aky62QzlY2YR8DIAnVjnhwndnNuQ=;
        b=iFFIS68bAhoUM4N+gSQ7OhRGy1g+QnKZXL1ZTEqDWgoX3PtOJTxV69gvTH1cEdTyoM
         ZR5lSYnN3wWcNA5nvVvDrzuJBUu33f7AkaWzuSKkiix//VIiK1X4cF9gWH9v65EoJWv8
         0bzHZj/0EuU9tlxumgjieM+QV+noRadmPc5FnG8nucSXCXDIfhWBmQ3JMrLMKD9/hYmn
         a8v68prRIzxuaqXxjVAZCPsCRbU55XStjbsJj3jEXVgdVT7yJKreuzsf8qfBnu974ic/
         TlMRWzYs64zePmqbePEmbYYCyC5SQt5OSViQwrHEmJycJ3IYf4v8U2zt3g94FUb3/hIV
         RQsQ==
X-Gm-Message-State: AOAM5318tl8FBdZ+IdKHXrmjzJfKcJkdwcLMBn0CADwsuM51+Feb5tkx
        dAmzedcQtVnD1C1i9lphwPOwHQoePWrZ0bLm1Qo=
X-Google-Smtp-Source: ABdhPJxUvcszqU6qByKOzb7FhjxBOeBPm0AadJQj2uaapEihc0OrFupfXKwgi1ZSr+rYH4XDAR0Tx62RJMptfEiUagc=
X-Received: by 2002:a17:907:2da5:: with SMTP id gt37mr2675890ejc.316.1639450994178;
 Mon, 13 Dec 2021 19:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20211128131853.15125-1-aford173@gmail.com>
In-Reply-To: <20211128131853.15125-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 13 Dec 2021 21:03:06 -0600
Message-ID: <CAHCN7x+yOs3icCV2OsKwAPRcov4Cb9Q+K8b2oy7WZowb3YZnRA@mail.gmail.com>
Subject: Re: [PATCH V4 0/9] arm64: imx8mn: Enable more imx8m Nano functions
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 7:19 AM Adam Ford <aford173@gmail.com> wrote:
>
> The i.MX8M Nano is similar to the i.MX8M Mini in some ways, but very
> different in others.  With the blk-ctrl driver for Mini in place,
> this series expands the blk-ctrl driver to support the Nano which
> opens the door for additional functions in the future.  As part of
> this series, it also addresses some issues in the GPCv2 driver and
> finally adds support for enabling USB and GPU.
>
> V4:  Rebase on top of [1] which fixes hangs caused from CSI and DSI reset
>      and add the same fixes for CSI and DSI to the Nano
> V3:  Fixes an the yaml example
> V2:  Fixes the clock count in the blk-ctrl
>
> [1] - https://www.spinics.net/lists/arm-kernel/msg936266.html
>

Shawn,

This series should apply cleanly against your tree now that [1] has
been applied to your tree.  Should I submit this a resend or are you
able to test the build now?

adam
> Adam Ford (9):
>   soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
>   soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
>   dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
>   dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
>   soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
>   arm64: dts: imx8mn: add GPC node
>   arm64: dts: imx8mn: put USB controller into power-domains
>   arm64: dts: imx8mn: add DISP blk-ctrl
>   arm64: dts: imx8mn: Enable GPU
>
>  .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     |  97 +++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 103 ++++++++++++++++++
>  drivers/soc/imx/gpcv2.c                       |  26 +++++
>  drivers/soc/imx/imx8m-blk-ctrl.c              |  77 ++++++++++++-
>  include/dt-bindings/power/imx8mn-power.h      |   5 +
>  5 files changed, 307 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
>
> --
> 2.32.0
>
