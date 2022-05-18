Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B4452C3BE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242137AbiERTqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242089AbiERTqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:46:48 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE8186295;
        Wed, 18 May 2022 12:46:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i187so3246324ybg.6;
        Wed, 18 May 2022 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsuE1ABWsB6b7Hsgob1VVtsU14xSna0mLGCkyQVROLY=;
        b=KaO9l1foVfB0brtQxLf6U9LXDVB+mL7N/kZKGEsHkIbIyMH+s5Xfr4VvfyCaZeYOYQ
         E06Eujq7zk+hiTDqO6qDOtNQ+kvQyUmuLMAmaVs2h7/nrvMB4ApBScCJJ9B8z7EUjABX
         qgOBf0tFcHSqw36OwstkZ5AOkJNDfpq1iq0jcEigDeJRgHG8SkDRE8P5Q5i10OkXAnhY
         9yOz8VIwQwD8aj03++d+4EmS5Z4T4Qg7UDXyER1dYuNQ+6yOXlEFJjKDHtkHVcqyaI6I
         ChX49WV7vKOmZgEHxguzCqFsaZAoUjOhxM0sUSUouHoAeqvieg138zfUqJc7zrsZx+yf
         GZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsuE1ABWsB6b7Hsgob1VVtsU14xSna0mLGCkyQVROLY=;
        b=70o5Z5woxk0g4n0StHZgAmkC/p3lZj/sfdMHVLr8zdcg9tYltV0sP0km29753EDA3j
         j9cRIxgYdEascUNq61W/oSe2tUnZPfXEqIllmuErNaAi47rZpvus+gBTGJZlQIk5Jflh
         6RM3vYPaRuUVoQlmiClejNfbNSzNyMjJ4qG8dCfsdmDrq5j6bvgVNK97Vfwxc2//3kTF
         i4jCGtHH0dZQPYEbDotFF/jFu5LxCt1DrCLG2XISxZC2QazZ8LBVV0+1SV0jvUDCTvqG
         lP2blt0DYNmqqpkJ/wUL4gODsBu6Lv4B2/Lt63EwT3gcNP7iRpgyVetvRTo6lzvDoV+J
         jqQg==
X-Gm-Message-State: AOAM5301TJWjd0rCPrQ4yAtM/3N0xE5/g1qK5Y0sNXK+RV7XuwdHdHj0
        JYA3tjRfBvWLRivMez0uMhygSycTwWe+tUhEDPJX7iHcDQcXqA==
X-Google-Smtp-Source: ABdhPJwvjDBcRwOkT0WZiDvWeUp+xaCQNNykqEv7DhpPxVzcA/DYGmdN14aSyNwYRolRX93/t9AGunXpMkwv/z9FZ+M=
X-Received: by 2002:a05:6902:1407:b0:64a:ecc7:aa2 with SMTP id
 z7-20020a056902140700b0064aecc70aa2mr1197261ybu.645.1652903207329; Wed, 18
 May 2022 12:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220426030544.3537713-1-yangyingliang@huawei.com> <20220426030544.3537713-3-yangyingliang@huawei.com>
In-Reply-To: <20220426030544.3537713-3-yangyingliang@huawei.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 18 May 2022 20:46:20 +0100
Message-ID: <CA+V-a8vS+Y94Rn0JL3+hf3yZxM8FOfPmMyP86GHB058gZ62VKA@mail.gmail.com>
Subject: Re: [PATCH -next 3/3] media: isif: remove unnecessary check of res
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
>  drivers/media/platform/ti/davinci/isif.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
Prabhakar

> diff --git a/drivers/media/platform/ti/davinci/isif.c b/drivers/media/platform/ti/davinci/isif.c
> index c53cecd072b1..69e862de014f 100644
> --- a/drivers/media/platform/ti/davinci/isif.c
> +++ b/drivers/media/platform/ti/davinci/isif.c
> @@ -1107,8 +1107,7 @@ static int isif_remove(struct platform_device *pdev)
>         isif_cfg.linear_tbl1_addr = NULL;
>         while (i < 3) {
>                 res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> -               if (res)
> -                       release_mem_region(res->start, resource_size(res));
> +               release_mem_region(res->start, resource_size(res));
>                 i++;
>         }
>         vpfe_unregister_ccdc_device(&isif_hw_dev);
> --
> 2.25.1
>
