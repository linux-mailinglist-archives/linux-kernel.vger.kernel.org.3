Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055EB477A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbhLPRSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhLPRSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:18:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05800C061574;
        Thu, 16 Dec 2021 09:18:51 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z29so9355967edl.7;
        Thu, 16 Dec 2021 09:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=31bykhqmr0M5/64+8ZN/KQ0RToq8F8e7rCshC7U5iiI=;
        b=pmpM3t7hxLdaCmjZf08hGQDcCDpxeNw0i3UTJpMQqGWSObyLoiYkZeuTwLbfXDJDJP
         vMEx3aMFVB9BGWSlD5KwiGEle4+nrN9/oLWBiUq7/bb/p8JXRWREVTseOFCLr9K05EI0
         IK59LDrNjDNJ+2FgYwpKhyBSis3IToLu+UMYeDJT79qWozIRcLYCdarVO+8j413ncIit
         tuZITaL7z3UU008AAYT7gGfL+gDaGiazeTLRKzB9Ax3hGKsszN6ts1/zBpBAB3/OMpEF
         Yr5ytDEiFaAIMq+EhuZCJF/4YEo+McDzNWROHTiwSHjdtUnPqt/XmjVBiSKsRO6sagnf
         eFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31bykhqmr0M5/64+8ZN/KQ0RToq8F8e7rCshC7U5iiI=;
        b=OF2Cfh+fSi9sbiW3tsDoRnza/u/1efZW2aeNleZGM3+HRMUV80k73W33Q7ZGux25pu
         YIqNLpo0bzQyYroAdNPfzghEsBoWhLc/YO5L96FCEpWzIiiSL6mkQgHXPGZFuXkcoeoF
         3A0eNwEA4hdGco7GuDvTAz2DoCWNFoTDUEgJMckQ2ixDcqHZ1idttHtZuOhIiau4c5k+
         lYxJx8HQzeeVyGIrDkoQFd7BAxXwlEYbeHHz+tfy21Q4lysr6GYFJFTJSTKkZI8Y+8xO
         vtrnDBGpm1MFxPNDkzOj3rRLB+G2QxhRaG5h6f4LwMlSOBE93lZDua0+cflWrwOvkdAg
         GtnA==
X-Gm-Message-State: AOAM530PMCS52nicurkM5GVrcI9a5rjN5O2yB5m/lCje51Ypoz8jV0aB
        AKVoBWVdDg4BSNhURJ4bjYSLgr7t/JA/1E/Nt20=
X-Google-Smtp-Source: ABdhPJy3lurNLVOtpHxmxsno5k/on9qXZg/MWhbDTYrsr3jHZC83+9oERKpgEVNe+8ncRmYY5piVmD4tzRIpHCrFFSU=
X-Received: by 2002:a05:6402:184c:: with SMTP id v12mr7081960edy.154.1639675128877;
 Thu, 16 Dec 2021 09:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20211216165851.64708-1-reinhold.mueller@emtrion.com> <20211216165851.64708-3-reinhold.mueller@emtrion.com>
In-Reply-To: <20211216165851.64708-3-reinhold.mueller@emtrion.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 16 Dec 2021 14:18:37 -0300
Message-ID: <CAOMZO5C346Om3QS19RQB3EzPu9Ey2b1jt_V_hzOZCk6bEd9wtQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mm: Add support for emtrion
 emCON-MX8M Mini
To:     reinhold.mueller@emtrion.com
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinhold,

On Thu, Dec 16, 2021 at 1:59 PM <reinhold.mueller@emtrion.com> wrote:

> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               rpmsg_reserved: rpmsg@b8000000 {
> +                       no-map;
> +                       reg = <0 0xb8000000 0 0x400000>;
> +               };
> +
> +               loader_reserved: loader@bb700000 {
> +                       no-map;
> +                       reg = <0 0xbb700000 0x0 0x00100000>;
> +               };
> +
> +               pci_reserved: pci@bb800000 {
> +                       no-map;
> +                       reg = <0 0xbb800000 0x0 0x00200000>;
> +               };
> +
> +               ivshmem2_reserved: ivshmem2@bba00000 {
> +                       no-map;
> +                       reg = <0 0xbba00000 0x0 0x00100000>;
> +               };
> +
> +               ivshmem_reserved: ivshmem@bbb00000 {
> +                       no-map;
> +                       reg = <0 0xbbb00000 0x0 0x00100000>;
> +               };
> +       };

Are these reserved nodes needed with mainline?

Looks like they are remnants from NXP vendor BSP.

> +&fec1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_fec1>;
> +       phy-mode = "rgmii-id";
> +       phy-reset-gpios = <&gpio1 9 0>;

phy-reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;

Actually, phy-reset-gpios is considered deprecated.

You could also add an mdio node as fec child and:
add reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>; there.
