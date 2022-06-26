Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5255B44E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 00:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiFZWWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiFZWWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:22:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2EA2DD6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:22:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id pk21so15417259ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dRXy76sdL7Y/YzwJ1RSzZzZXuzUmmJM6patKce0lSs=;
        b=G/QzgObNuFFB6sQpSeSJ/EwNSjfapmrUIiFxEqiKsD92cORGQxK0WvfCeqrW1RyHgL
         dkMOce31bPuID+gguD1GV16x5RlELmZfSHbvHFYMMZOBrCJMX8673EGBBHYheLhWCTec
         y1BXVOsVFp4erFXgxhTzJOLLaFAWEkvsQRc54jOLsou7qpuk9EE2XHyPqJtDhEi8yyWr
         hL0Ud993pU5ey7KpUxaavcoHG880XaiTs7PnAtxk8fxT18+6c8Vrwuo478eg9B9yjlqY
         qk9bp3Io7FlriuoklO4v4NiDv32p1Jy063RsTmSAZVeIiqSktHSbg+jbMyVB+7DvlpaS
         xQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dRXy76sdL7Y/YzwJ1RSzZzZXuzUmmJM6patKce0lSs=;
        b=C8+QSPEWytwkBtN0xsZeiA6jgoZFXqyNgxgSlO5MaSg093phXs5AGywWLxwPUGzsXN
         1tbOsm0ygN1mwny9yXHrg2fDJciisXcyOd36uKCPZLM1TLP1qsErNKo7XZu4VtvTkXm6
         CRxdQfGbsyRz1bfg8d+QRI9QjE6Rw7sWv22UTErDzEWW6tTstHN1Jx9ZW+nGeI7XeIFp
         lBJg7K8+iDB4h980/T8P6BXq2Zq7VVNEyTuuxF+ggMqXk1gFzllDUeHI9BTdHSnhbxw2
         OiDZwG9Pzo+cBVwRGnPg5OQqu3SgDK/s7XjM2GKSZFm/kpqS0okMkGFihrTNylPY1cEF
         KSDA==
X-Gm-Message-State: AJIora9ddypgXRsb/p3FkJEaqRFZRwyHOgqAvT7ORMFlk4FQsRKtkxR0
        cPlEpIqWYhOIGSFLOXEtwr7uaTnVWDhlU47Bo0I=
X-Google-Smtp-Source: AGRyM1sLRgxNCsB7cXaoTsisvOlnKbFi+KeCPUXiQpDKnxmlU0RfmCxf8a50de/VHNNaGr0vNXlRLQJlSpLEs7hCE7s=
X-Received: by 2002:a17:906:7a0e:b0:722:e8c5:ee96 with SMTP id
 d14-20020a1709067a0e00b00722e8c5ee96mr9907372ejo.147.1656282122843; Sun, 26
 Jun 2022 15:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220616133811.1674777-1-narmstrong@baylibre.com> <20220616133811.1674777-3-narmstrong@baylibre.com>
In-Reply-To: <20220616133811.1674777-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Jun 2022 00:21:52 +0200
Message-ID: <CAFBinCCcx_pG7rsMMGsoOOZC6E0-+qiWY3HPQTizMsDWm9wBnw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] phy: amlogic: Add G12A Analog MIPI D-PHY driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, vkoul@kernel.org, linux-phy@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Jun 16, 2022 at 3:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic G12A SoCs embeds an Analog MIPI D-PHY used to communicate with DSI
> panels.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/phy/amlogic/Kconfig                   |  12 ++
>  drivers/phy/amlogic/Makefile                  |   1 +
>  .../amlogic/phy-meson-g12a-mipi-dphy-analog.c | 177 ++++++++++++++++++
>  3 files changed, 190 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
>
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 486ca23aba32..e4d1170efd54 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -59,6 +59,18 @@ config PHY_MESON_G12A_USB3_PCIE
>           in Meson G12A SoCs.
>           If unsure, say N.
>
> +config PHY_MESON_G12A_MIPI_DPHY_ANALOG
> +       tristate "Meson G12A MIPI Analog DPHY driver"
> +       default ARCH_MESON
> +       depends on OF && (ARCH_MESON || COMPILE_TEST)
> +       select GENERIC_PHY
> +       select REGMAP_MMIO
I think this should be "select MFD_SYSCON" as we're not using
REGMAP_MMIO directly

[...]
> +       /* Get the hhi system controller node */
> +       map = syscon_node_to_regmap(of_get_parent(dev->of_node));
I just reviewed a patch that adds of_node_put() for the node returned
by of_get_parent() (after (syscon_node_to_regmap() has been used).
I think we need the same here

> +       if (IS_ERR(map)) {
> +               dev_err(dev,
> +                       "failed to get HHI regmap\n");
> +               return PTR_ERR(map);
to simplify we can use:
    return dev_err_probe(dev, PTR_ERR(map), "failed to get HHI regmap\n");
doesn't make much difference for this one though, but...

[...]
> +       priv->phy = devm_phy_create(dev, np, &phy_g12a_mipi_dphy_analog_ops);
> +       if (IS_ERR(priv->phy)) {
> +               ret = PTR_ERR(priv->phy);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "failed to create PHY\n");
> +               return ret;
here dev_err_probe() would simplify the code a lot

[...]
> +static const struct of_device_id phy_g12a_mipi_dphy_analog_of_match[] = {
> +       {
> +               .compatible = "amlogic,g12a-mipi-dphy-analog",
> +       },
> +       { /* sentinel */ },
super nit-pick: no comma here


Best regards,
Martin
