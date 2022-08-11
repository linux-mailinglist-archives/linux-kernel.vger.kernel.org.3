Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B9D58FE08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiHKOF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiHKOFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:05:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C190C52;
        Thu, 11 Aug 2022 07:04:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so5528829pjo.0;
        Thu, 11 Aug 2022 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Dj6bB22FSCprvzSCdzPnalbNqdw4+7MgbO1K3Nk4hes=;
        b=VLNchb/CBg9rGN3HwVrnxX6MEK6WSff4Mm0bX0PnDP86xsYEFddRY3N86NLjsz4d98
         FJVEr0KhiZHuTfS3+uTmkX24wBl+DyNQXBHarmdqVnRRVvTfcmgPyD7CXKfwR8j0w1BS
         qMced17ziT4aHo5DJQR7wnAaRAX7IDgEj4m9QZKB/zj1z+k37blNqZPjrWfztNz/f1iu
         oDf9+mm+Rm83ETnU8n+xNSPJSy7BpncHosHrZQxYfPllFMQ0HgqtVJ57qUYfYyF4mqXX
         M4eUkFKfj3pqkmOFAb/7r7tUkhjQFSgC1Ith+AuFtzzDoAZKW9/6SmCh2+lO+3wQpO3d
         1Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Dj6bB22FSCprvzSCdzPnalbNqdw4+7MgbO1K3Nk4hes=;
        b=XpYsUaQ9EkV1i+ECerEFNYOT620UD0Oxz90d6ct4dE5/Ie6zOi96o34jDp+oVmGBCw
         Db7kuVOIMIptaK8HHS5kdQETRu2z7MRAf48305nxEiGXAxL/w6A/Ba8BXvBqZAlcwUsW
         Ux39102u1pTbHgQU6cIEyuqgge4oP+WhxpHGYHv1EctTLs5eSsE0Ot/fTg1SEu/9ohqS
         +EqgQ1iFunD0h71Zx4Jyw0NppB/eofJlWqjEV6u3J4Aj25kkkbh39APEjdfiDaVvYh2Q
         1SxEnRSPgptixz51D8Jiuj+5/UNgwcC5cJRk56fUj6UZVEQdo4oF4qiGLd4HSc21rCSM
         W2Nw==
X-Gm-Message-State: ACgBeo1hf9j8DGJE1NsuHO+BpqXN8/k1tAwMxNZ3ClaJ9uRWj/v84tFR
        +rS+gW41QpC/+7b9dVZU4C3i1LD0lLiAn63+LHU=
X-Google-Smtp-Source: AA6agR7hiJzcTlyuNpDaCn+bU/kYswnNN0IO9VF+n4dkqjZNU1VXaD845OUQz8aKn0Bvh0OZ7xwllsBl3t2uwC3DIXg=
X-Received: by 2002:a17:902:e746:b0:16e:f7cf:671f with SMTP id
 p6-20020a170902e74600b0016ef7cf671fmr32178991plf.168.1660226681760; Thu, 11
 Aug 2022 07:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220721101050.2362811-1-martyn.welch@collabora.com> <20220721101050.2362811-2-martyn.welch@collabora.com>
In-Reply-To: <20220721101050.2362811-2-martyn.welch@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 11 Aug 2022 11:04:27 -0300
Message-ID: <CAOMZO5CVNK-yxGAp_-yi-0nsEu3aDs9c5EsKworm_uDJiS_T7A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mp-msc-sm2s: Add device trees for
 MSC SM2S-IMX8PLUS SoM and carrier board
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Thu, Jul 21, 2022 at 7:11 AM Martyn Welch <martyn.welch@collabora.com> wrote:

> +&eqos {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_eqos>;
> +       phy-mode = "rgmii-id";
> +       phy-handle = <&ethphy0>;
> +       phy-reset-gpios = <&tca6424 16 GPIO_ACTIVE_LOW>;
> +       phy-reset-duration = <1>;
> +       phy-reset-post-delay = <1>;
> +       status = "okay";
> +
> +       mdio {
> +               compatible = "snps,dwmac-mdio";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               ethphy0: ethernet-phy@1 {
> +                       compatible = "ethernet-phy-ieee802.3-c22";
> +                       reg = <1>;
> +                       eee-broken-1000t;
> +                       phy-reset-gpios = <&tca6424 16 GPIO_ACTIVE_LOW>;

You have already added  phy-reset-gpios above.

The phy-reset- properties are deprecated. It's better to use
reset-gpios,reset-assert-us, etc inside the mdio node.

> +&fec {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_fec>;
> +       phy-mode = "rgmii-id";
> +       phy-handle = <&ethphy1>;
> +       phy-reset-gpios = <&tca6424 17 GPIO_ACTIVE_LOW>;
> +       phy-reset-duration = <1>;
> +       phy-reset-post-delay = <1>;
> +       fsl,magic-packet;
> +       status = "okay";
> +
> +       mdio {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               ethphy1: ethernet-phy@1 {
> +                       compatible = "ethernet-phy-ieee802.3-c22";
> +                       reg = <1>;
> +                       eee-broken-1000t;
> +                       phy-reset-gpios = <&tca6424 17 GPIO_ACTIVE_LOW>;

Same here.

> +&sdma1 {
> +       status = "okay";

No need to enable it as sdma1 is not disabled in imx8mp.dtsi.
