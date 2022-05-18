Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3230352C39D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbiERTmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbiERTmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:42:12 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E96D396;
        Wed, 18 May 2022 12:42:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id j2so5546565ybu.0;
        Wed, 18 May 2022 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIFswqFpJE+LYp33RSOtEn9hjp7HRzUG7X1FIKlVf3k=;
        b=cACMbUC5qMKiXKbU+3vCq+NseHnnmkWsxWpW3UPeSbvfCq1ifhpT/pWs7vkZf5GqbG
         SIldrr4w33+mMLG7jOxfV0QZScpGOpjgD/LSTWbj3/BSBF/dzvUI10U4YYyU0agSYnw0
         VD1YTBp59r1MHO2ll6eYDgp/TMn5dhOTLcD4Vke3dBA/6cYzYEfAHtItvAxfBT130lSj
         1mzKqVbkRKq4bQRmZb5oC7PfBvZxyEzy4JkWz0Rvf8Uc/uscivN2LxbV9Q9rhb7XOtKn
         qlnpIdtfnxpWf4JNDMcKWKBDiLdjWdHtn4Dcu7Cy809+u4sNbV2GTjzENed25tB0XCd8
         nyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIFswqFpJE+LYp33RSOtEn9hjp7HRzUG7X1FIKlVf3k=;
        b=YYDYHsdbwpoGw/yxdUNEXZveGHQxUOtNtXI8uUZkM9sD7x/xW6k9oLnxwyGLjxA9Rs
         q2JHR5af72AOThlCzfleKS3G5kRB9y4hf90reaYcfkVM4LhTUG15fmMdvBO6PeKuJZpF
         SIHtfpbWh1BBkpunPmjItFiEpv+iYm0dD4YiEG/th/yzENH5tEfoADYY1QbmB28mGGu0
         Ie1VRzHQ1a6Xzm+sroLs8Hz53We5tByyh1Ufy+Dt4KQMTToU3MHkeqxyCGrhkcgmky52
         OJ6Khmie93gpPKXvDG5UJC7X7JaRfn5IKFjqz9xN2BJJ4DlVdeiy04hFCTKn/kH1YWkX
         5Kjw==
X-Gm-Message-State: AOAM5307TAMU96bf94WkqCSjnskhQH7XVv+cwOq4Qq4aSlhylEaLUoIX
        Ds6woR/CJNpTGKRbTgEhVqySLfGbyKSzWaKa9z+AGsy2sBQvQQ==
X-Google-Smtp-Source: ABdhPJx3NZk8TBbzyc9+/aD982tSTNiVuNOKsFNydMdfKJo0elYEE722V+AvWWoto60+9hGMJpySmx2GdidDp4voe2c=
X-Received: by 2002:a5b:246:0:b0:619:5651:3907 with SMTP id
 g6-20020a5b0246000000b0061956513907mr1218173ybp.190.1652902930700; Wed, 18
 May 2022 12:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220426030544.3537713-1-yangyingliang@huawei.com>
In-Reply-To: <20220426030544.3537713-1-yangyingliang@huawei.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 18 May 2022 20:41:44 +0100
Message-ID: <CA+V-a8vA-B=6RHK85c3Eyzq5Om28PNkyv6g7=qLUck0qh6thBA@mail.gmail.com>
Subject: Re: [PATCH -next 1/3] [media] dm355_ccdc: remove unnecessary check of res
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
>  drivers/media/platform/ti/davinci/dm355_ccdc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
Prabhakar

> diff --git a/drivers/media/platform/ti/davinci/dm355_ccdc.c b/drivers/media/platform/ti/davinci/dm355_ccdc.c
> index e06d113dfe96..8fe55d1b972c 100644
> --- a/drivers/media/platform/ti/davinci/dm355_ccdc.c
> +++ b/drivers/media/platform/ti/davinci/dm355_ccdc.c
> @@ -918,8 +918,7 @@ static int dm355_ccdc_remove(struct platform_device *pdev)
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
