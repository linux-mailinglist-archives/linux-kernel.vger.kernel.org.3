Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E5452C3A3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbiERTnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242059AbiERTnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:43:01 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477121C15F8;
        Wed, 18 May 2022 12:43:00 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2fed823dd32so35413557b3.12;
        Wed, 18 May 2022 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7zHFESk42U3UBmzkmcgo7A2Pfdlr24WiPzijq7ymak=;
        b=lyk72HbviVdVVj7A5PSBnMoOHYhxquyKcKH/i5ivoOphl32X2GsyF5WAa946fHGxKY
         4GFUy2wBdmi8+J+6pcclPt18fXLh5rn552afQTTHl+SYarmxf4P/volmHqB6o5+G4ZOb
         oxTekprfxY/y5LwrIVonb2heXKAXiOBN/iyhY8dLuBKhH8RE8q0LLOqjq9Y+99aIO2t6
         Y5m4oXzWb4c1AQCJ2XqhwexoTKAyQHuNiaH12PNLxBE39pVUd8LO7f/wo63XCt4qTiF6
         0xUfVOuLJeIpkvY4arNMHULNRTnfsYk5HuTa0xK5N/Vpm9C609AFKRmKn75UWwgitULI
         lg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7zHFESk42U3UBmzkmcgo7A2Pfdlr24WiPzijq7ymak=;
        b=U3yjjBYDSdRnYiT5wNJ4uL3LPCLZVbvxCMxSOVezr7bkn2+iJfHpHEfnwH4X4R2xdz
         /5N9ehrzG+GzuGW68Nxko8oS+5x/2CI9P8lkPowk4W+ws/CV68L+lgHP7Z3pvYpRgmpD
         9MJ7QF9uqaoSB2KPjtoclkfMDOQib6wlUjaddUI8L1tkucF1cZFuOQuPPI2WoEVj6NDb
         3PRpu4gyNJzYNoVz0N2aM/xfZcEM0r+2o1S1TbdDt8BGEe9yXjrGGIQS9dJtzNpHGbHg
         kWfptt7bd1MOvXNcBB00uxbInCbI5IRgfvpNgaQHtDN1rrqvGkpDN2mQF0RwQqh2FjAq
         dZxQ==
X-Gm-Message-State: AOAM5337TLRqiimDBFYvJ9XHeFfr2gDYfxj+hw//1V91IZ/RbFNlCIUp
        Cm3m3fLoOLH7nZRqaJ848XtoVXVSQ/92ZihjgZsg5mtL4NiLPQ==
X-Google-Smtp-Source: ABdhPJxsuB2L2/okYBIBUgjzpSLwK33A+WTMNVXKuvQowifRq6xNlFMjzWAX2SGv7HSAyQK1ueer4IN6KhGtJLxQfbE=
X-Received: by 2002:a81:ac5b:0:b0:2ff:45c:2e85 with SMTP id
 z27-20020a81ac5b000000b002ff045c2e85mr1143478ywj.16.1652902979559; Wed, 18
 May 2022 12:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220426030544.3537713-1-yangyingliang@huawei.com> <20220426030544.3537713-2-yangyingliang@huawei.com>
In-Reply-To: <20220426030544.3537713-2-yangyingliang@huawei.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 18 May 2022 20:42:33 +0100
Message-ID: <CA+V-a8vkwVKQ4fR4hOfbh6UgaN8=0oZL-hKEpm3iTtO2=k7U_Q@mail.gmail.com>
Subject: Re: [PATCH -next 2/3] [media] dm644x_ccdc: remove unnecessary check
 of res
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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

On Tue, Apr 26, 2022 at 3:53 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> The resource is checked in probe function, so there is
> no need do this check in remove function.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/media/platform/ti/davinci/dm644x_ccdc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
Prabhakar

> diff --git a/drivers/media/platform/ti/davinci/dm644x_ccdc.c b/drivers/media/platform/ti/davinci/dm644x_ccdc.c
> index c6378c4e0074..e4073e99914c 100644
> --- a/drivers/media/platform/ti/davinci/dm644x_ccdc.c
> +++ b/drivers/media/platform/ti/davinci/dm644x_ccdc.c
> @@ -839,8 +839,7 @@ static int dm644x_ccdc_remove(struct platform_device *pdev)
>
>         iounmap(ccdc_cfg.base_addr);
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (res)
> -               release_mem_region(res->start, resource_size(res));
> +       release_mem_region(res->start, resource_size(res));
>         vpfe_unregister_ccdc_device(&ccdc_hw_dev);
>         return 0;
>  }
> --
> 2.25.1
>
