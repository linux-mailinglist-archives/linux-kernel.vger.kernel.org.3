Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4BB46DC31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhLHTag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhLHTaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:30:35 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0F9C061746;
        Wed,  8 Dec 2021 11:27:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so12029596edv.1;
        Wed, 08 Dec 2021 11:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWD7QTQTBQY0167hHhHNyiI2iGNEXy68navUB5oHGUE=;
        b=iSZTWbJ7elOMhCtyRV3gCY3YEcdNsYC0etFgSecojjiDddrZpHh0dZpj+JKUit4IUn
         TPf5R08JhwFogiAMb20Uw19jpkgUVpwpXrl5Nmw60SN9FihLEVo3FonfJFoOVWRDkvl/
         pg1EQLV6Am3db39uVxCPqoUu9Px+caoJpKBoovyDWGxynNS9Lp4lWroLgj6PZsWMeL3x
         NnkcO4rcqmkLoqalctqqtMkZxYRY9rqaCG+XFnf+fWR3nexTXT+tS7faolzpRmpYJKpJ
         zVh7udvLi0x7PblFLQ7kI4SpEHuy/RIGqXAg4n0f9esL7GRVb95XRII5JKIf+sevOl9q
         5htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWD7QTQTBQY0167hHhHNyiI2iGNEXy68navUB5oHGUE=;
        b=FM8KdGop1BW/Xzhxst9eSgb0Ld/ar9CJGjlzzz4i8g4em/4LG7nZvnuL6K73sDJBKS
         I2/BxnJpV+CHx9k0Z/LXNwj8Ebg6eqJ0vwXqKgkz8BWVOkLHK85KVviE3oGHo9rqZztq
         sMRnq9ujOi+iXbkDeJetUqtK+muODcV+2hj1oFwwZvoS3GzxdgDYYgA3BNQaFbyLllnj
         fZFvLxUYR4rrVkJe/tnssx4Mn48Cx3xjM17GDNsfQC830l+MI0+co8udJOAUR7pzBqYd
         V2dQmftTGW4PaXgptM3bH1wuyuDyLGVrUf+STpzCfxQzUFb7bPTQaoQ+Myrn4bCFGLVR
         Vuyg==
X-Gm-Message-State: AOAM530TRatFjEcCO7k7VvWfhE0UKIZm4f1wr85az2A4e4MAd9CtaRJZ
        OwllI1GV4xQw+WGAAYA8OUh/pXRaw6fifsH2Vck=
X-Google-Smtp-Source: ABdhPJzoERlw0Vv5BhJzcvYMSnhWpELuiIRivq7dAufjb2jsbOPA74SlD1zKjdTqM3xQlceQ9GciFnUok0X8pmA1IR8=
X-Received: by 2002:a17:907:7294:: with SMTP id dt20mr9714680ejc.321.1638991621643;
 Wed, 08 Dec 2021 11:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20211208192009.322190-1-ariel.dalessandro@collabora.com> <20211208192009.322190-6-ariel.dalessandro@collabora.com>
In-Reply-To: <20211208192009.322190-6-ariel.dalessandro@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 8 Dec 2021 16:26:50 -0300
Message-ID: <CAOMZO5CnzVm83yHbzg2OD8HqNEV0-sXduDH9zPHctRy2i9ErDA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm: dts: imx8ulz-bsh-smm-m2: Add BSH SMM-M2
 IMX6ULZ SystemMaster
To:     "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        ioana.ciornei@nxp.com, jagan@amarulasolutions.com,
        kernel@pengutronix.de, krzk@kernel.org, linux-imx@nxp.com,
        matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tharvey@gateworks.com, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 4:21 PM Ariel D'Alessandro
<ariel.dalessandro@collabora.com> wrote:
>
> From: Michael Trimarchi <michael@amarulasolutions.com>
>
> Add DTS of BSH SMM-M2 SystemMaster.
>
> This version comes with:
> - 128 MiB DDR3 RAM
> - 256 MiB Nand
> - wifi
> - bluetooth
>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  arch/arm/boot/dts/Makefile               |   3 +-
>  arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts | 146 +++++++++++++++++++++++

There is a typo in the Subject: it says imx8ulz, but it should be
imx6ulz instead.

> +/ {
> +       model = "BSH SMM M2";
> +       compatible = "bsh,imx6ulz-bsh-smm-m2", "fsl,imx6ull";

Shouldn't "fsl,imx6ulz" also be added here like it is done in
imx6ulz-14x14-evk.dts?
