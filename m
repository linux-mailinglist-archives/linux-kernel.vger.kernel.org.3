Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2338753A56D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353092AbiFAMrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353075AbiFAMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:47:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2DC64ED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:47:03 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o15so1851149ljp.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqDKJWJn3KR6F/t8EuCHiF1PKuDwpntQP0fkdEdQKws=;
        b=Fh6mGwxvUqrYxnGeAf6gRK0flNakrFnVg9b2xz1C0/zw54bfM+TF+jUKVOFwQNYRp+
         Fcvt5S3hwHMsigKcVt7+uHOLwQRDUSmE9mE/ZU+/wrEkc/M0SuU861PbAuNH8qb+T9E2
         MV7wlVsmnB6J5j3mAoKwYwuuDeOctq+f/Z0ws6OvbJIfDoWe56zcXxWcWFhs/9QMc9q8
         701JG9yzRYGhH3j5OoSroN5LU4zBLGWA2KYRMEMa0lnaKRhMDy9UOoZqpSOUDkeV4fI0
         Qb9Z5HA8xEgqxYfnH9kZ1b2VN2cJ2gTe00YFR07+KpDBiywxJo5UiXprOq+U/Q3Qt2ND
         v1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqDKJWJn3KR6F/t8EuCHiF1PKuDwpntQP0fkdEdQKws=;
        b=n3mIXR7Ee/ip1uAbev7E1WyoBm5N8zGfY5IMbZrTfIP4M6G/+UCQvsuKiytQYSyAer
         PjZQ1yR6g7MyJq3WjBHs3PCDZFFQVMm5m/5UxTxOJP8oGsnhlAo5PmUULaxBXGWKg2zR
         IU+j9g+AY/8GBmKgheA4wm/8MGayY6mAFuHmse6hBWKVKpfb5m8OZNY34Dfs/VUjCK70
         y6I7Iv0WXeSLR4hRnH+OMNJwY9qiLYdVowLBSnNvSMTxdw/TH8evL0yQj3tvzaRPd8s9
         i7fkepuCyVu0kZA6AO1q9KGkbfshgS0OOuA5bxIdQNLZTmFALlLLHmPypjPhDUUriONC
         NpzQ==
X-Gm-Message-State: AOAM531IXXYNaoeaaY5nqnyrDb0GYdMyWv7HC8rkaZwE9MeTSuEri4eF
        k5NA3o1U6cdXvz5oM7+9++bvgO36fNRWRmKawnyWIA==
X-Google-Smtp-Source: ABdhPJxJIs39WEUtGpVqKIIbRC1ZzEuJkg8hkJUTVxGDs/YlupuKseOHBIm/4fxNJmL142hY/6+4H6ajgpj9hkeXWnY=
X-Received: by 2002:a2e:a273:0:b0:253:e0e7:7948 with SMTP id
 k19-20020a2ea273000000b00253e0e77948mr33626186ljm.463.1654087621703; Wed, 01
 Jun 2022 05:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220530123857.692076-1-fparent@baylibre.com>
In-Reply-To: <20220530123857.692076-1-fparent@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 14:46:25 +0200
Message-ID: <CAPDyKFqNegBhdqc0URv27OLKMupXEMEU5c7-e4YasWsKGA0OQg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: fix typo
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022 at 14:39, Fabien Parent <fparent@baylibre.com> wrote:
>
> Fix a typo: Fianl -> Final.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Queued for v5.20 on the devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 195dc897188b..c7d196f805ec 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2318,7 +2318,7 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
>         else
>                 val = readl(host->base + PAD_DS_TUNE);
>
> -       dev_info(host->dev, "Fianl PAD_DS_TUNE: 0x%x\n", val);
> +       dev_info(host->dev, "Final PAD_DS_TUNE: 0x%x\n", val);
>
>         return 0;
>
> --
> 2.36.1
>
