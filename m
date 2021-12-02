Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427144663AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346860AbhLBMdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240508AbhLBMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:32:59 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B89DC06174A;
        Thu,  2 Dec 2021 04:29:37 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so115187565edv.1;
        Thu, 02 Dec 2021 04:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCcTTm4Maa5TXcDLbYXLbRt75Jjc8zsc+pqvwVk93Go=;
        b=p3a5v+dmRty+NzGaTklO7c3S7cmkU6iNa7PdqxChmAB0V5xj1hN63Ofj/42kXmCxiF
         Xdyhex7gLrRinMTJsh7H5RpTa8qc1goG1rYQZI4YNG+AvphUrBJa4iNNNmr+tZwAqGVN
         i/jsZL6UH1XBJ1Sb5gxCfyjDr91HyvwxNjJHRtbdUmqq4DkWiVVjvLJMFQNuH6JIGR9p
         9AfSfuFPZnCvS8LOvMEScb8kioqB6npoyAuAeKdKIg7V+BO8CoLj8Li8lLVLXy8ZssUe
         5CFxHL4dWNDb5S49AhVLVW2vCQSwBuKyyVBRE65vitv3Y7mSLj0EDYN8SFa8HcTbt+TP
         Eu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCcTTm4Maa5TXcDLbYXLbRt75Jjc8zsc+pqvwVk93Go=;
        b=RjVu3jU/gd5ThjnPjgz/AL2f6mi8GZlQpJf2nWoQuOF6A592dLM83svIXdz8vL8oeU
         2HQeqFScmRciHN9W/383sKGTEeIcchSnAkBkjBMR+gN9fYPAM5UAvnLztMQWCLxi8cYY
         g5l+tCyT2VCFhaqgLzBmL1O6K3Lel8cAMxYIuG0Mcl5VOZYXlohoKJZQ0LtckPWJi4GU
         rHysjpRVaVJsQWymTioEXXH5MB71YxeU9RnGl+GrKVu4FoAstIjGn8UYGsYuS0HpJOUy
         FGjhVfswfz9rwYxj31DIRk15SLdlMxSTSdz6+Pl4xf/e9X9am7g6rn2oTUYsX08ku7aF
         wQ+Q==
X-Gm-Message-State: AOAM531LfwvAhvNVi4lvxW7xu/ev0YVbzE1CbMwNNF5m6zxsnI9LSjd+
        mcg0fdMcDybPa4Pi/TQ2WFzwbHjxlE6uBztM5PF2AnZ/iU9j4g==
X-Google-Smtp-Source: ABdhPJxZShngoNPXgDS47UOI6ZLXwYKwCSeA5fm1NU+vtEE5ZuL/ae0cWNshOkPvmA9ECfEdUoS5U3VQpTZ7DznM8f8=
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr17723394edc.398.1638448175027;
 Thu, 02 Dec 2021 04:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20211202041627.291625-1-aford173@gmail.com>
In-Reply-To: <20211202041627.291625-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 2 Dec 2021 06:29:23 -0600
Message-ID: <CAHCN7xJHuOFTQBQWk1yKsk3M0iDB7aKc0=L2DisUoSXVeO3xXQ@mail.gmail.com>
Subject: Re: [RFC V3 0/2] arm64: imx8mm: Enable Hantro VPUs
To:     linux-media <linux-media@vger.kernel.org>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Tim Harvey <tharvey@gateworks.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Adam Ford-BE <aford@beaconembedded.com>,
        hverkuil-cisco@xs4all.nl, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 10:17 PM Adam Ford <aford173@gmail.com> wrote:
>
> The i.MX8M has two Hantro video decoders, called G1 and G2 which appear
> to be related to the video decoders used on the i.MX8MQ, but because of
> how the Mini handles the power domains, the VPU driver does not need to
> handle all the functions, so a new compatible flag is required.
>
> V3 is rebased from git://linuxtv.org/hverkuil/media_tree.git for-v5.17c
> This branch has support for VP9.
>
> I set cma=512M, but this may not be enough memory as some tests appeard to run out of memory
>
> V3 of this series has several changes:
>
> Update imx8m_vpu_hw to add missing 'reg' reference names for G2 and include references to VP9
> Update device tree to remove IMX8MQ_VPU_RESET, remove some duplicate vpu clock parenting
> Fix missing reg-names from vpu_g2 node.
> Apply patch [1] to manage the power domains powering down.
> [1] - https://lore.kernel.org/linux-arm-kernel/20211016210547.171717-1-marex@denx.de/t/
>
> With the above, the following Fluster scores are produced:
>
> G1:
> ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> Ran 90/135 tests successfully               in 74.406 secs
>
> ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> Ran 55/61 tests successfully               in 8.080 secs
>
> G2:
> ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> Ran 127/303 tests successfully               in 203.873 secs
>
> Fluster and G-Streamer were both built from their respective git repos using their respective master/main branches.
>

I should note, that both interrupts appear to be triggering.

# cat /proc/interrupts |grep codec
 57:      13442          0          0          0     GICv3  39 Level
  38300000.video-codec
 58:       7815          0          0          0     GICv3  40 Level
  38310000.video-codec




>
> Adam Ford (2):
>   media: hantro: Add support for i.MX8M Mini
>   arm64: dts: imx8mm: Enable VPU-G1 and VPU-G2
>
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi   | 41 +++++++++++++
>  drivers/staging/media/hantro/hantro_drv.c   |  2 +
>  drivers/staging/media/hantro/hantro_hw.h    |  2 +
>  drivers/staging/media/hantro/imx8m_vpu_hw.c | 65 +++++++++++++++++++++
>  4 files changed, 110 insertions(+)
>
> --
> 2.32.0
>
