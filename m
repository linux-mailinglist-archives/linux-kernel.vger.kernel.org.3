Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE83487087
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbiAGCgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:36:20 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:44602 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344793AbiAGCgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:36:17 -0500
Received: by mail-qt1-f176.google.com with SMTP id a1so4229276qtx.11;
        Thu, 06 Jan 2022 18:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1K15mtU3zzMsv0QlhLQ7Ko388P+IV6nME1cO1C6EvU=;
        b=RwWfijicqAvoLpSjeB7cgho9YCGFNscwsH29QH23LpBQzLpCIJnUFkvEafSrwtVQ9N
         otIkWAw3VNIVEJsPteIr70LIAmJvg9Nw+1duHoR4W8Rs5+JVRqLc14uTIGWZRgaviLrj
         hGUUOdxk1Cu7Y8h7g30/svpTKmCHB2iwvXP5kEoUx6dM2eqQujcbmt4rPXa92Cy/Hquj
         7JvRxgp9i44CkHYcz9U4bd8A+oEKbDX03FcHy3psFy4sz9RoOuTqdBnVN8Y8qd6oupmt
         bSSZVmomVbEDzg9NPK9Elh2DEcTOG0Dd3ipYjdP+mIGnY9VQFwZxAidaMy6IK3g2JkZ7
         I81g==
X-Gm-Message-State: AOAM530AuZG5ME1uYSKCyz39fcfA6A7K9r8WzeQWu3TwpDar8U4Kajth
        8MriW1Lp2VVF/zjGlm5cE/wt2xRjeiXOoHoB
X-Google-Smtp-Source: ABdhPJwctH+K6wy/8G3P/ejagpHh3YQ8FjNq147K/x4fdUGFhbbD2HkKy7q43wGLdGsqa3wWDPLUXg==
X-Received: by 2002:a05:622a:4c:: with SMTP id y12mr55998380qtw.21.1641522976789;
        Thu, 06 Jan 2022 18:36:16 -0800 (PST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id l9sm2502430qkj.37.2022.01.06.18.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 18:36:16 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id kj16so4236122qvb.2;
        Thu, 06 Jan 2022 18:36:16 -0800 (PST)
X-Received: by 2002:a05:6214:252a:: with SMTP id gg10mr57473867qvb.19.1641522975923;
 Thu, 06 Jan 2022 18:36:15 -0800 (PST)
MIME-Version: 1.0
References: <1063e5a4738d897adcaffce2ab8e4e45f07998ff.1635969326.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <1063e5a4738d897adcaffce2ab8e4e45f07998ff.1635969326.git.christophe.jaillet@wanadoo.fr>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 7 Jan 2022 10:36:04 +0800
X-Gmail-Original-Message-ID: <CADRPPNRke7ga1MsSKEpr948wkgNygNTQhcnB7Kk-f7DhMpptMQ@mail.gmail.com>
Message-ID: <CADRPPNRke7ga1MsSKEpr948wkgNygNTQhcnB7Kk-f7DhMpptMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: guts: Revert commit 3c0d64e867ed
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     tyreld@linux.ibm.com, kernel-janitors@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 4:09 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> This reverts commit 3c0d64e867ed
> ("soc: fsl: guts: reuse machine name from device tree").
>
> A following patch will fix the missing memory allocation failure check
> instead.
>
> Suggested-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next.  Thanks.

> ---
> This is a follow-up of discussion in:
> https://lore.kernel.org/kernel-janitors/b12e8c5c5d6ab3061d9504de8fbaefcad6bbc385.1629321668.git.christophe.jaillet@wanadoo.fr/
> ---
>  drivers/soc/fsl/guts.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 072473a16f4d..af7741eafc57 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -28,7 +28,6 @@ struct fsl_soc_die_attr {
>  static struct guts *guts;
>  static struct soc_device_attribute soc_dev_attr;
>  static struct soc_device *soc_dev;
> -static struct device_node *root;
>
>
>  /* SoC die attribute definition for QorIQ platform */
> @@ -138,7 +137,7 @@ static u32 fsl_guts_get_svr(void)
>
>  static int fsl_guts_probe(struct platform_device *pdev)
>  {
> -       struct device_node *np = pdev->dev.of_node;
> +       struct device_node *root, *np = pdev->dev.of_node;
>         struct device *dev = &pdev->dev;
>         const struct fsl_soc_die_attr *soc_die;
>         const char *machine;
> @@ -159,8 +158,9 @@ static int fsl_guts_probe(struct platform_device *pdev)
>         root = of_find_node_by_path("/");
>         if (of_property_read_string(root, "model", &machine))
>                 of_property_read_string_index(root, "compatible", 0, &machine);
> +       of_node_put(root);
>         if (machine)
> -               soc_dev_attr.machine = machine;
> +               soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
>
>         svr = fsl_guts_get_svr();
>         soc_die = fsl_soc_die_match(svr, fsl_soc_die);
> @@ -195,7 +195,6 @@ static int fsl_guts_probe(struct platform_device *pdev)
>  static int fsl_guts_remove(struct platform_device *dev)
>  {
>         soc_device_unregister(soc_dev);
> -       of_node_put(root);
>         return 0;
>  }
>
> --
> 2.30.2
>
