Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB71255AE98
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiFZDqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 23:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiFZDq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 23:46:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E1C1400F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 20:46:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k7so5389253plg.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 20:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkR3yCBKwWtovdy4WYrNPg8uwIMMvvK6YP84XNpC5FM=;
        b=SxczHg72LRcYZZeyIiUC/dUDmUHIX+IHXLm7tA8PS5Ey9h032Xo+Sjupj1Ocg4iqZF
         irqH8LnQAzeWHEXHcpEt3W4vm6vsGmG6DIjsthtOpO5exP/Br/dq49lYYjfJebUUYmZb
         KrL7/zML1qJP6xaQ6jcxtxWNVEI9A8LuBDc/ePcgtgxx4XW/t7xnoij0Z/kNkT2bqVj9
         eMatniqkhJwtBACFarHU48BoitruvajYm4RApdoaFJy+smp6Ffyjf+yj/q1rmOhbfbzp
         uXy3tgH3cKC77M01KYi1TuygQFn3/FC5YO6Z4ZrGtitatyQwH9b+q52m3GKtVZ7h1nAc
         8IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkR3yCBKwWtovdy4WYrNPg8uwIMMvvK6YP84XNpC5FM=;
        b=B3eORaahLu8gvZZuYm/Hko/xhp/yB1gSQfMlZ1H8gIfgdrxG7NYFfSgAWdQ0uf/Rn5
         RT2lTOiN+xa9wxs8NF1Kem83K6AtV5cb4PdxEQumzyGg3Hg7wMP+1RNneG5J4jL66vKc
         1SYHP3tCRB37dwwjo6BUNUArqB27UXjMP7boL57P2ZyfqqZVM+SnmP9zYpuBkllXFHSM
         lE8Ou2zHs+LneefKSiSXNSdMQcSwSyIKq3rMYNm4vAAMp5YfjuARJAxAcZLsfD0dbrN6
         1SMRocFSmmLL0Bpa/zwBqZraMzml/iVQ0Zip4rnQ9cMd1P7qXReoQ2dMo/EUrpbPNlIP
         2MPg==
X-Gm-Message-State: AJIora+tQ7+QssLnM9wi5FwDEV94+6viNa5n7HxlyE1pgYphUEDM6TeL
        RraSe0Q9Q9MWrSNe/zQbLA2GRDCjXZ/fh4hPfJG5hBJo
X-Google-Smtp-Source: AGRyM1vIlFu2iMfIY1UA/3VhwYoNMAHpoKy2HsfungMuGCOUct2c8BjuyKL2gt576KiN6kYP7FPK+vw5/HCjoIbmG5E=
X-Received: by 2002:a17:902:e748:b0:16a:726e:7c9e with SMTP id
 p8-20020a170902e74800b0016a726e7c9emr7253919plf.12.1656215186453; Sat, 25 Jun
 2022 20:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220624005036.37268-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220624005036.37268-1-yang.lee@linux.alibaba.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Sun, 26 Jun 2022 11:46:15 +0800
Message-ID: <CA+H2tpHf-LoJE45-OJ17M4r9oE7_ruitvq9P4tk8odQBiw0YPg@mail.gmail.com>
Subject: Re: [PATCH -next] drm: Remove unnecessary print function dev_err()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Jun 24, 2022 at 8:50 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
>
> Eliminate the follow coccicheck warning:
> ./drivers/gpu/drm/sprd/sprd_dpu.c:808:2-9: line 808 is redundant because platform_get_irq() already prints an error
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Orson Zhai <orsonzhai@gmail.com>

> ---
>  drivers/gpu/drm/sprd/sprd_dpu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
> index 3664089b6983..de4848dc0d22 100644
> --- a/drivers/gpu/drm/sprd/sprd_dpu.c
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.c
> @@ -804,10 +804,8 @@ static int sprd_dpu_context_init(struct sprd_dpu *dpu,
>         }
>
>         ctx->irq = platform_get_irq(pdev, 0);
> -       if (ctx->irq < 0) {
> -               dev_err(dev, "failed to get dpu irq\n");
> +       if (ctx->irq < 0)
>                 return ctx->irq;
> -       }
>
>         /* disable and clear interrupts before register dpu IRQ. */
>         writel(0x00, ctx->base + REG_DPU_INT_EN);
> --
> 2.20.1.7.g153144c
>
