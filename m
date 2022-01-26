Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4E249D322
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiAZUI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiAZUI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:08:26 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88888C06161C;
        Wed, 26 Jan 2022 12:08:26 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id h14so2006350ybe.12;
        Wed, 26 Jan 2022 12:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqDj01fJk5RcRpumzPt7PC8+0u353E8vLqFkPrcBJ5I=;
        b=I1unDZefCd0JIULDdvND7jvN6aCl39EBw7wpnaUnSXLcoQ18AB9gFhE3SxVnGbPtuf
         RlMdoUcEta7GrXWoqlHlyWABFSnvMSQfaHwauV56OtfxD9haGBr0P5x6RjzxsddlskAt
         OiRLiKcggQLm0gOexGQxtjtF9+HcF3Cx9arFreMDJS6zvNx2P3aEwkEunzFuZyNYakdd
         A4SC2mBdlWosWNj8FbDR3Aw25vu6mwLtgsvjAg9H1ePq4GJd9tvwZffc471ec1QMNbo+
         ycJkj/V8gS+5R4vlKEekSwQtpXU3gou1w4vJs/Y3IrRHiRw1sn+xzUUXjSb6NwrWEhLd
         P3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqDj01fJk5RcRpumzPt7PC8+0u353E8vLqFkPrcBJ5I=;
        b=hQ/kZo08nn/lr5HYbmO+czA3+sgu2tyfGi1pvHGV+VMxiIMuI2z9He7rn3z6JS+kOi
         xOUNc+pU+3R+SnoMarUY9s+GSDyELDwmkfRRin++H+i0yP+5QgQ1O2VM7f+pV05D2CJN
         g4ZEatMYq1lmaxrSfVh3mlQ3TtjfHiqkD/Xsce34ygnceJ+qVuSTV70k2g3y/ZdqeJWO
         emwHyXRYuO3zLuqi24VE2gA/+nq5/vHV1uafMw2jBLwa6oqU7l5xWWzTf15Ar0obWmni
         gz6ypakIJpSfCkRhUwkfRrp1IgU5pKMxy6PD38BVUsCOeaSLumVnuwL1z0EYxbC8fjFc
         B52A==
X-Gm-Message-State: AOAM531rG/n/rVM2JBul7k8XFEymV8mnJsEBgs22UkyinTcwH6oCUJOR
        3UhHmnGCw2oWklNjnnuFPqjv6Gdu2qiYPuyQtw8=
X-Google-Smtp-Source: ABdhPJyyqDyJmMNPhR7KuoajESGq8pu/2PvHqCUKw3EtPkIduBQO6fyqkL/Y5aqhP1XfLqJkgDR0tpr/TQsGTlTVYCw=
X-Received: by 2002:a25:40cd:: with SMTP id n196mr852133yba.186.1643227704586;
 Wed, 26 Jan 2022 12:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20220113104416.32352-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220113104416.32352-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 26 Jan 2022 20:07:58 +0000
Message-ID: <CA+V-a8vM-n818iPCUUpon+cUeg2RX4HcCc1xUM6AO_v5CqQNeQ@mail.gmail.com>
Subject: Re: [PATCH v4] media: davinci: vpif: Use platform_get_irq_optional()
 to get the interrupt
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Thu, Jan 13, 2022 at 10:44 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
>
> While at it, propagate error code in case devm_request_irq() fails
> instead of returning -EINVAL.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
>
> This patch is part of series [0], instead of resending the entire series
> I am re-sending this alone patch after rebasing on patch series [1].
>
> [0] https://patchwork.linuxtv.org/project/linux-media/list/?series=7073
> [1] https://patchwork.linuxtv.org/project/linux-media/list/?series=7000
>
> v3->v4
> * Replaced loop with do while.
>
> Cheers,
> Prabhakar
> ---
>  drivers/media/platform/davinci/vpif.c         | 18 ++++++++-----
>  drivers/media/platform/davinci/vpif_capture.c | 27 +++++++++++--------
>  drivers/media/platform/davinci/vpif_display.c | 24 ++++++++++-------
>  3 files changed, 42 insertions(+), 27 deletions(-)
>
Gentle ping, just so that we don't miss out this patch.

Cheers,
Prabhakar

> diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
> index 03b4e51bb13a..97ef770266af 100644
> --- a/drivers/media/platform/davinci/vpif.c
> +++ b/drivers/media/platform/davinci/vpif.c
> @@ -20,8 +20,10 @@
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/spinlock.h>
> @@ -437,11 +439,12 @@ static void vpif_pdev_release(struct device *dev)
>
>  static int vpif_probe(struct platform_device *pdev)
>  {
> -       static struct resource *res_irq;
> +       static struct resource res_irq;
>         struct platform_device *pdev_capture, *pdev_display;
>         struct device_node *endpoint = NULL;
>         struct vpif_data *data;
>         int ret;
> +       int irq;
>
>         vpif_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(vpif_base))
> @@ -471,12 +474,13 @@ static int vpif_probe(struct platform_device *pdev)
>          * For DT platforms, manually create platform_devices for
>          * capture/display drivers.
>          */
> -       res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -       if (!res_irq) {
> -               dev_warn(&pdev->dev, "Missing IRQ resource.\n");
> -               ret = -EINVAL;
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               ret = irq;
>                 goto err_put_rpm;
>         }
> +       res_irq = (struct resource)DEFINE_RES_IRQ_NAMED(irq, of_node_full_name(pdev->dev.of_node));
> +       res_irq.flags |= irq_get_trigger_type(irq);
>
>         pdev_capture = kzalloc(sizeof(*pdev_capture), GFP_KERNEL);
>         if (!pdev_capture) {
> @@ -486,7 +490,7 @@ static int vpif_probe(struct platform_device *pdev)
>
>         pdev_capture->name = "vpif_capture";
>         pdev_capture->id = -1;
> -       pdev_capture->resource = res_irq;
> +       pdev_capture->resource = &res_irq;
>         pdev_capture->num_resources = 1;
>         pdev_capture->dev.dma_mask = pdev->dev.dma_mask;
>         pdev_capture->dev.coherent_dma_mask = pdev->dev.coherent_dma_mask;
> @@ -505,7 +509,7 @@ static int vpif_probe(struct platform_device *pdev)
>
>         pdev_display->name = "vpif_display";
>         pdev_display->id = -1;
> -       pdev_display->resource = res_irq;
> +       pdev_display->resource = &res_irq;
>         pdev_display->num_resources = 1;
>         pdev_display->dev.dma_mask = pdev->dev.dma_mask;
>         pdev_display->dev.coherent_dma_mask = pdev->dev.coherent_dma_mask;
> diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
> index 8fe55374c5a3..bf76c5c83743 100644
> --- a/drivers/media/platform/davinci/vpif_capture.c
> +++ b/drivers/media/platform/davinci/vpif_capture.c
> @@ -1607,7 +1607,6 @@ static __init int vpif_probe(struct platform_device *pdev)
>  {
>         struct vpif_subdev_info *subdevdata;
>         struct i2c_adapter *i2c_adap;
> -       struct resource *res;
>         int subdev_count;
>         int res_idx = 0;
>         int i, err;
> @@ -1632,17 +1631,23 @@ static __init int vpif_probe(struct platform_device *pdev)
>                 goto vpif_free;
>         }
>
> -       while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
> -               err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
> -                                       IRQF_SHARED, VPIF_DRIVER_NAME,
> -                                       (void *)(&vpif_obj.dev[res_idx]->
> -                                       channel_id));
> -               if (err) {
> -                       err = -EINVAL;
> +       do {
> +               int irq;
> +
> +               err = platform_get_irq_optional(pdev, res_idx);
> +               if (err < 0 && err != -ENXIO)
>                         goto vpif_unregister;
> -               }
> -               res_idx++;
> -       }
> +               if (err > 0)
> +                       irq = err;
> +               else
> +                       break;
> +
> +               err = devm_request_irq(&pdev->dev, irq, vpif_channel_isr,
> +                                      IRQF_SHARED, VPIF_DRIVER_NAME,
> +                                      (void *)(&vpif_obj.dev[res_idx]->channel_id));
> +               if (err)
> +                       goto vpif_unregister;
> +       } while (++res_idx);
>
>         vpif_obj.config = pdev->dev.platform_data;
>
> diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
> index 59f6b782e104..fca148b66471 100644
> --- a/drivers/media/platform/davinci/vpif_display.c
> +++ b/drivers/media/platform/davinci/vpif_display.c
> @@ -1221,7 +1221,6 @@ static __init int vpif_probe(struct platform_device *pdev)
>  {
>         struct vpif_subdev_info *subdevdata;
>         struct i2c_adapter *i2c_adap;
> -       struct resource *res;
>         int subdev_count;
>         int res_idx = 0;
>         int i, err;
> @@ -1245,18 +1244,25 @@ static __init int vpif_probe(struct platform_device *pdev)
>                 goto vpif_free;
>         }
>
> -       while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
> -               err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
> -                                       IRQF_SHARED, VPIF_DRIVER_NAME,
> -                                       (void *)(&vpif_obj.dev[res_idx]->
> -                                       channel_id));
> +       do {
> +               int irq;
> +
> +               err = platform_get_irq_optional(pdev, res_idx);
> +               if (err < 0 && err != -ENXIO)
> +                       goto vpif_unregister;
> +               if (err > 0)
> +                       irq = err;
> +               else
> +                       break;
> +
> +               err = devm_request_irq(&pdev->dev, irq, vpif_channel_isr,
> +                                      IRQF_SHARED, VPIF_DRIVER_NAME,
> +                                      (void *)(&vpif_obj.dev[res_idx]->channel_id));
>                 if (err) {
> -                       err = -EINVAL;
>                         vpif_err("VPIF IRQ request failed\n");
>                         goto vpif_unregister;
>                 }
> -               res_idx++;
> -       }
> +       } while (++res_idx);
>
>         vpif_obj.config = pdev->dev.platform_data;
>         subdev_count = vpif_obj.config->subdev_count;
> --
> 2.17.1
>
