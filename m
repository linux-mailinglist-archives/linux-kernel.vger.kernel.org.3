Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C29E47B663
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 01:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhLUAGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 19:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhLUAGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 19:06:38 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949BFC061574;
        Mon, 20 Dec 2021 16:06:37 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bm14so32113777edb.5;
        Mon, 20 Dec 2021 16:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvUzazrWWp7IQK+actEDMRd1Nwhih5uO5PeylPSgyaY=;
        b=U285jPI+Lfhd0lkiAZbY6UWOPFzuOEi9jJRpkElvFsoN5lGK9wHzqkFks/o7efXlI5
         KXtmHwVoybu6lwGzEFzEA2XmXKcHCYHHfcQorMCtaXpInCCygBZVwddgodiuQd5jtWix
         GvctX3yedFAOM4LxIUvhyRxThod1Gublpm7WrM2fSJvDssX94KKOmLlD2V6Fntbaugz2
         /FpWgY4qxp1ww3HCBpjTwGotrmoYI3JOE0lJkLXxoMMaNEW01RE06z0KmrEQKowIIg3o
         ufftNkvu0phd8H2jbACerDFV8zDi7/xijfQFeeW+YTIeYC135fGtWy3Al/jiDUf5fvKu
         I+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvUzazrWWp7IQK+actEDMRd1Nwhih5uO5PeylPSgyaY=;
        b=6Cv8ZSTGGYEIuBi0ep0hYOU9lhOX26AgjRueIlh0HjLs36SCm4RqQ0zlCp8xKbGzgA
         JahB3e0oZf5qaK4ZjHJ5Op15mSgeXPGKTB17DKLTuWq9sF9Xvf6+C+Gld/A9N6/AclYQ
         SerTS2CSXxKXyX5uJLcCuUnxkKehYLfIQ3t6DM1TYSckDRFobAyXVBYoHgCnx4QYjj9Y
         yxy5IrbwTCT8fbo4ZG4xzyC8KjU85v5S02EEdHfGG8jiqvHrrJkjIXv8FEhd1+qSiYu1
         WefYm/V9yHlHmzaZ0fvU7mxu3pzwGiX5JiB82BeZ/+pUVH9dzB56D7zac3ca6sVSLICG
         xFLA==
X-Gm-Message-State: AOAM533Pq6xiEHlE+W2hD9YnUUlbL+1zEtWWckBH7w0W7EYhX2cRcet+
        zSjWIjfCo9ZeesnxqbKPhRKOB7Di+RDYfNmmJdU=
X-Google-Smtp-Source: ABdhPJwhsj6nPnnGFryy1KBigHXOfjaBah3GIIiYUyZ/6xUxTf3gNiH45X7rpT8Tb5BMBICwWN3jhuhvcOGoM2JaeGU=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr583443edd.108.1640045195940;
 Mon, 20 Dec 2021 16:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20211220072332.81072-1-reinhold.mueller@emtrion.com> <20211220072332.81072-3-reinhold.mueller@emtrion.com>
In-Reply-To: <20211220072332.81072-3-reinhold.mueller@emtrion.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 Dec 2021 21:06:25 -0300
Message-ID: <CAOMZO5BvLZYh3=q_-XNcw-v5wDcBpR3Qo26Gd3hTtJ_a-FQiuA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8mm: Add support for emtrion
 emCON-MX8M Mini
To:     reinhold.mueller@emtrion.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinhold,

On Mon, Dec 20, 2021 at 4:23 AM <reinhold.mueller@emtrion.com> wrote:

> +       pinctrl_ecspi1: ecspi1-grp {
> +               fsl,pins = <
> +                       MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK            0x82
> +                       MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI            0x82
> +                       MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO            0x82
> +               >;
> +       };
> +
> +       pinctrl_ecspi1_cs: ecspi1-cs {
> +               fsl,pins = <
> +                       MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9               0x40000
> +                       MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13              0x40000

This version looks good to me.

One nit: you seem to use a single SPI chipselect, but you add two entries here.

Is the MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13 needed too?

Either way:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
