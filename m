Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B269B4779E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbhLPRC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbhLPRCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:02:25 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A39C061574;
        Thu, 16 Dec 2021 09:02:25 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g14so88317925edb.8;
        Thu, 16 Dec 2021 09:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAX1DillDzDe1cq2Y4cS5Hx7YpRdt+8cd+A34oUxstg=;
        b=f26UaeIhrwptau+bBYmXy3CAzsPf0oUsp2HfFF11aRbP5g/3IVVkOJaavI2OtD4rj+
         RqX2kCY0usTcPCDseXlzq2g+lS5/8TnTjZE00zluIQPKDosGh7pNwO6EB/AUlbqf07m4
         IPUGGiIk1vFufYjFN5uqYgNQRbVlkK7WS7caup+vp0eZ77gFyHiDpJE2VqNgJ04MvqzQ
         o95CdeyamIWhISKp2BKVHpSGiRl7I2SSrvIALqm09n1dv9ZLx+MmlrikB8xPb2qU8E4Y
         BiXxCGJCf9PAY0NKvyNsKoxGAsBq5BFLLsM49bAO8Qnxj+xnLMxIB4LBeVMJgo3IX0yR
         g5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAX1DillDzDe1cq2Y4cS5Hx7YpRdt+8cd+A34oUxstg=;
        b=MqhHwaqJemx+764K03rYXtO/jPBL5hA2iCkTYE+UskV0tRLcXRTA1Pkdgd+89Cj3LC
         FQtjKK8/828uJd8rz/IQ1dBZXrIAMyDkn92dyRNkm4clBEYjMpjq98AcI7o1IAlPzQxe
         N/imFGaNq7C8UlGxeKeoqUnnUpDer/oSJ6PAwThbiEEIipeZ7j7q3bQ1oQ9iV/ll/FmO
         Y3I95I6vePAWd+c1LdaWbhwhJ9iXVTHg8TZn1WKlKGgilE8VW2bCxMo6wSy3yYiYd+Cz
         GuAULDH9hoVewmOmD8eXK3NbRXtoVPOGoYA2lZ5PZcpSSWs8zM4xZNtV5gItkoSSYkvn
         ef1w==
X-Gm-Message-State: AOAM533/GDs3EGXgkdOHEYgpegEGR1TWE8VZvTLv9/stBxa6bdr6YXGw
        j0QuoLSJ/pe6Pa5mBYVt2e53OZVHqqfbIoSm+A8=
X-Google-Smtp-Source: ABdhPJwusy1Z0natNCWY8k0AsGqbnUQN3iXeEdAbqKhD6r1xMeBarSuf3pT/Xg1NQ6wAs0oNMRSyZyveqhusvrqxHdE=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr4099000ejc.198.1639674142539;
 Thu, 16 Dec 2021 09:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20211216161227.31960-1-tharvey@gateworks.com>
In-Reply-To: <20211216161227.31960-1-tharvey@gateworks.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 16 Dec 2021 11:02:11 -0600
Message-ID: <CAHCN7x+sSixbY0oSsQ0bcEsZ6CVbc+Big1Tx=WDzt1WX0ycOWA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-venice-gw7902: disable gpu
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:12 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> Since commit 99aa29932271 ("arm64: dts: imx8mn: Enable GPU")
> imx8mn-venice-gw7902 will hang during kernel init because it uses
> a MIMX8MN5CVTI which does not have a GPU.
>
> Disable pgc_gpumix to work around this. We also disable the GPU devices
> that depend on the gpumix power domain and pgc_gpu to avoid them staying
> in a probe deferred state forever.
>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>

Fixes: 99aa29932271 ("arm64: dts: imx8mn: Enable GPU")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Adam Ford <aford173@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mn-venice-gw7902.dts      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> index 236f425e1570..2d58005d20e4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> @@ -220,6 +220,10 @@
>         };
>  };
>
> +&disp_blk_ctrl {
> +       status = "disabled";
> +};
> +

Disabling the blk-ctrl also makes it so you cannot use a display
and/or CSI camera.   I don't know the application, so it's likely OK.

>  /* off-board header */
>  &ecspi2 {
>         pinctrl-names = "default";
> @@ -251,6 +255,10 @@
>         };
>  };
>
> +&gpu {
> +       status = "disabled";
> +};
> +
>  &i2c1 {
>         clock-frequency = <100000>;
>         pinctrl-names = "default";
> @@ -546,6 +554,10 @@
>         status = "okay";
>  };
>
> +&pgc_gpumix {
> +       status = "disabled";
> +};
> +
>  /* off-board header */
>  &sai3 {
>         pinctrl-names = "default";
> --
> 2.17.1
>
