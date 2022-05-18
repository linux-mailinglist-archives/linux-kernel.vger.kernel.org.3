Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E88F52BDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbiEROVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiEROVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:21:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686CC1C103;
        Wed, 18 May 2022 07:21:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq30so3941235lfb.3;
        Wed, 18 May 2022 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgF7hB842Xb1tcpu/exVm00l5yNp9b+2bCf12T/zGxc=;
        b=e7RUpvLPw1/sKoLVxVoOxzKi3xQRj3PpyVvr333lxyBp/yvOTfwmgKKAHFDm9CshR4
         NvheW1Z+C/naejxdGvSKLOi7EaEmLYVb2fq254kes7ntQmFcbqCtIH7qgqj0uBlSjewP
         y3nmYCWY/Wo+7Dyt53yvbAI8H+jCSAP4XJ3P9S/ukSPyKuJY5V2guFPrT2FPhT+LnyX7
         WmVSTfkIGQgIo6m+LzUYb6iGOdDEWE6hyXuTeyFNzIl1y0R/Tw+BXAbPiVjjc6NEcHA9
         v0l0cm1kMLgAuH/fG6sa1VdNDaE/61nnECZLz+KEkuIIK2tJpo86oiYElEkpUKfImlF3
         sLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgF7hB842Xb1tcpu/exVm00l5yNp9b+2bCf12T/zGxc=;
        b=VQiaBrrk+NcVIYdFLa68mOTJuAGuULjH2pPhsFC1MMVJ/gAvtrgeIr9FwdcqUj/ZJg
         xtfuwqAYfPb3Avxfa3A4triB3CFfOpcKZxSYDYeFrgLDKYBHamTXLaj4pWGEDtdcSGfs
         fFZY2oyVVsAh6ab+hp0c7hHea5Rgp1gl983faAq1+GuHHsh5Hm8BYDS+rL3aWw7whOeF
         qA8iAIekakIEWfzEZzvqJDD50vVy3X3QdASvFI7U5+XCZwBcByqXRjnyEX10D05Ad3Lw
         tAoKKFuprUokM1g/+D1OK0wUZXE/3gQH68vwNZ62zBsrW2Baoc9ll8eOdcgTsbxSTzsv
         WPQQ==
X-Gm-Message-State: AOAM532+iv+YwxbOzbyZR8IorFeF4/ou2wiOUIj9d3DWvlKKAiD1xa5s
        1hwp0ApHMklMogukx0Sh0rDhM3suLATia+VINUo=
X-Google-Smtp-Source: ABdhPJwBXTEz06RJoigcTFP/EBVz+helwZx8NYWmO9cAOVwwvhieqj9DYnDaTZICu64zreOkTLHGIXwQvCu7H+MnSEg=
X-Received: by 2002:ac2:550f:0:b0:477:bc6e:9bcc with SMTP id
 j15-20020ac2550f000000b00477bc6e9bccmr1697600lfk.279.1652883674662; Wed, 18
 May 2022 07:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220516115846.58328-1-max.oss.09@gmail.com> <20220516115846.58328-12-max.oss.09@gmail.com>
 <CAOMZO5DhTNDHLt_VZoWqD5dMBHq3rvJ+0j8-4xHHThyqheqcgQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DhTNDHLt_VZoWqD5dMBHq3rvJ+0j8-4xHHThyqheqcgQ@mail.gmail.com>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Wed, 18 May 2022 16:21:03 +0200
Message-ID: <CAEHkU3Xtm9gk6xXr586M3pm4tPpFA-fGn+QyKXfF+Cqqa8VK8g@mail.gmail.com>
Subject: Re: [PATCH v1 11/17] ARM: dts: imx6q-apalis: Add ov5640 mipi csi camera
To:     Fabio Estevam <festevam@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio

On Mon, May 16, 2022 at 2:08 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Max,
>
> On Mon, May 16, 2022 at 8:59 AM Max Krummenacher <max.oss.09@gmail.com> wrote:
> >
> > From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> >
> > The Apalis iMX6 modules allow connecting a mipi-csi video input.
> > Add support for our OV5640 camera module but have it disabled.
> > This allows to enable it in an overlay per the current system
> > configuration.
> >
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > ---
> >
> >  arch/arm/boot/dts/imx6qdl-apalis.dtsi | 67 ++++++++++++++++++++++++++-
> >  1 file changed, 66 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> > index 506d040ea37a..0d1004eede62 100644
> > --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> > @@ -29,6 +29,12 @@
> >                 status = "disabled";
> >         };
> >
> > +       clk_ov5640_osc: clk_ov5640_osc_int {
>
> Node names should have "-", not "_"

Ups, missed that one. Will fix it in V2. Thanks.

>
> clk_ov5640_osc: clk-ov5640-osc
>
> Also, no need for the _int suffix.
>
> Just curious: is ov5640 mipi support functional?
>
> I recalled that I had issues in getting Gstreamer pipeline to capture
> from the ov5640 mipi.
>
> There were some errors related to LP-11 during the start of the capture.

In my (limited) testing I saw no issues that the camera would not come up.
It takes 2 to 3 seconds until the pipeline is running but I noted no hickups.
I did this with setting the resolution to 640x480 and 1920x1080 which
probably would not relate to the LP-11 issue you mention.

I.e. I set up the v4l2 pipeline and start capture to the screen as follows:
```
media-ctl -l "'ov5640 1-003c':0 -> 'imx6-mipi-csi2':0[1]"
media-ctl -l "'imx6-mipi-csi2':2 -> 'ipu1_csi1':0[1]"
media-ctl -l "'ipu1_csi1':2 -> 'ipu1_csi1 capture':0[1]"
media-ctl -V "'ov5640 1-003c':0 [fmt:UYVY2X8/640x480 field:none]"
media-ctl -V "'imx6-mipi-csi2':2 [fmt:UYVY2X8/640x480 field:none]"
media-ctl -V "'ipu1_csi1':2 [fmt:AYUV32/640x480 field:none]"
gst-launch-1.0 v4l2src device='/dev/video0' ! videoconvert ! waylandsink
```

Max
