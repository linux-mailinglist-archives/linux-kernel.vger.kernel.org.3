Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640075283DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiEPMIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiEPMIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:08:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8264D25C6A;
        Mon, 16 May 2022 05:08:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kq17so28238562ejb.4;
        Mon, 16 May 2022 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnOxnQcb4Fu3paGsTHPyp7sfC5DipN/N3rq9yeMMHF4=;
        b=iU1ciYcrfm2hMbbA52EonHWO4UjvozsZo9+atKivTNQ0QJ4F3eIkjAW4/BuByThOU+
         sXRbHpxeUKIUgcDA6a7DmyP6LDS04X8smMgARYnV7sGmCPvwT4PPhDXJuFt01vtzu6Yt
         wx2/z3FzorWePJMyoTkZfk07ZYiY6Pttb5em+qlO0bbIAnajPXjQI/5lOMpOtZLORYbI
         aguFT56I+E1t66sxT4+qEoMFrG0W3CrUWoQm0no1i/YkHw/55yWI7NMRoyyNSjt5wSeh
         pIzen3CQ+eqp0nb7ncne55RmnjlG+TSIiDxddXUMibUdRBRza2khxJQQVTZ7cr9GWcCK
         Hofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnOxnQcb4Fu3paGsTHPyp7sfC5DipN/N3rq9yeMMHF4=;
        b=6PuguFVXDkpD0vCWMaWPZvM99pMg2m18sZeWvke3+dK3FgQLOdMdrNk/XuctaGqHIz
         3Mv6uNocCRN5mo1KJVG+s90dbe0CZbJcpi2VxjtMfd/s2cutg/NDel6EgLVfvkBaiLDc
         K31YXTY+cD0/i31y0xHYCp5fJw9DO0hKDFomBM19ClUiG1AxH2AZ/uJ4W7Dg1jleawNo
         0pjzOLIk51lU0nAMqB3a2dWWToSibiixFeotgBtgkTx+wU0ABSbey1ggSGdw3RPGyIvw
         2EDeLJCmP2Kr2sUFt5w7D0AM5OlbBeeCew7PXufUPomQkUSM5V1vPsZrLPeib1c4yuMz
         zLWw==
X-Gm-Message-State: AOAM530GRBq3dInK9q/1b3jTN/nqaY1qBNcq2N29mDGOqEo2DFYzoBsx
        AygbEz/okJk8pxQfApixQL2ZBDp9tUJWG8MdCaY=
X-Google-Smtp-Source: ABdhPJwQvqRaLEwzE8DMq08M3j9ibkibZBnZ2FqxJF0nncGfQeoPRDb1Bb8mbWxmBph9fjkFdFmKfq0fs8XHCzqq6po=
X-Received: by 2002:a17:907:7b9f:b0:6f4:d8c5:392c with SMTP id
 ne31-20020a1709077b9f00b006f4d8c5392cmr14673262ejc.652.1652702909931; Mon, 16
 May 2022 05:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220516115846.58328-1-max.oss.09@gmail.com> <20220516115846.58328-12-max.oss.09@gmail.com>
In-Reply-To: <20220516115846.58328-12-max.oss.09@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 16 May 2022 09:08:20 -0300
Message-ID: <CAOMZO5DhTNDHLt_VZoWqD5dMBHq3rvJ+0j8-4xHHThyqheqcgQ@mail.gmail.com>
Subject: Re: [PATCH v1 11/17] ARM: dts: imx6q-apalis: Add ov5640 mipi csi camera
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Max,

On Mon, May 16, 2022 at 8:59 AM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
>
> The Apalis iMX6 modules allow connecting a mipi-csi video input.
> Add support for our OV5640 camera module but have it disabled.
> This allows to enable it in an overlay per the current system
> configuration.
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> ---
>
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi | 67 ++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 506d040ea37a..0d1004eede62 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -29,6 +29,12 @@
>                 status = "disabled";
>         };
>
> +       clk_ov5640_osc: clk_ov5640_osc_int {

Node names should have "-", not "_"

clk_ov5640_osc: clk-ov5640-osc

Also, no need for the _int suffix.

Just curious: is ov5640 mipi support functional?

I recalled that I had issues in getting Gstreamer pipeline to capture
from the ov5640 mipi.

There were some errors related to LP-11 during the start of the capture.
