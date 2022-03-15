Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424744D9B14
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348228AbiCOMY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348227AbiCOMYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:24:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA586436
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:23:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r22so26203447ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRpn9k07AvFRGh0gF6YNXgmPxpnxq7wyCuwbzm66mLY=;
        b=NpcMfLCqOAjT2sSeV2QqGd3mVpMck4r8/tTTwR2NqNCDqUgjj1ku8olci2AYbWVWSM
         7/pwvHGIT4rLhKXrwy9JGibkOvzcmbIBtdsjb73CDUIt15Tv1gKSbdqdj00GESjfXH4v
         Re/lrRPmgkYVNgNBKm3V9vwRYgxGVMxS6fXIANYcBpaUNRxd81mFdoDXuAaZAKxNL7Kr
         tsNlouITyJipc4mN1YQDc06DHWRtdgOskGMbY2Frn6vypqk1p+pAiP0imz2KQA3QbMbe
         xMby9/TNvVxnrvP3GrelxqBxGtR10TmBCHNVA8f+vB8C5+BUbC2KK34tQUgLuprmojc6
         QWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRpn9k07AvFRGh0gF6YNXgmPxpnxq7wyCuwbzm66mLY=;
        b=PUOF5kRu7uOb4cAojOXrGQD7VE9kjtVG1zhQdADJorPzs6oEVJUxBHd63nHZNThpM5
         b+Gm1BtyyiVpRmlDPCNuMbtTR8eVfr7uq5L+PSYWThV3qOJOEa311agxgKNkkcmnnWZY
         wISN+bvIZF5oesc/mjdHVFNtrSjNVUQteMtPfyiKH7qEUC5u2SXbQgNKcjfpswzZj5BM
         fWM2bF0aK9HosJKhu/i4RuFlZyUpBdv+Cl+72nubMThrgyfXE1kdaVz9BcymCq5Mfy4g
         8q85sCUnuplbW0l298hzhUasjgLcICrUW65TUVIuV/6PbVp26Kdb2/UW1oV2jUOSjqTH
         tZlg==
X-Gm-Message-State: AOAM530JkJxllb4xLbNBdyx8F8CarmdAPYp1u4tudNqNUMMxhDD8NXeF
        wwxhNTH+eLw3y6DGvcT+t+Jk3HcoeW6Uu6R3X6xuYw==
X-Google-Smtp-Source: ABdhPJzu8qPCA6D1kpxXHeMtMO8O3TbgLh0QyLY8oWy5P2UKXJg3HmMXMtdXQRnulGznlGIGslhhvaCuFE5JlYb47eI=
X-Received: by 2002:a2e:890e:0:b0:249:295a:eb40 with SMTP id
 d14-20020a2e890e000000b00249295aeb40mr9371355lji.463.1647347015757; Tue, 15
 Mar 2022 05:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220311103320.3072171-1-abailon@baylibre.com>
In-Reply-To: <20220311103320.3072171-1-abailon@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 13:22:59 +0100
Message-ID: <CAPDyKFp4QbaCvOQoK_5rdh4X_iuvvsZ6M-iGiBCNp-VuQ+WChg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: Silence delay phase calculation debug log
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 at 11:33, Alexandre Bailon <abailon@baylibre.com> wrote:
>
> The driver prints the following log everytime data is written to RPMB:
> mtk-msdc 11230000.mmc: phase: [map:ffffffff] [maxlen:32] [final:10]
>
> dev_info is used to print that log but it seems that log is only
> useful for debbuging. Use dev_dbg instead of dev_info.
>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index d5a9c269d492..05c8b4de46f3 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1914,8 +1914,8 @@ static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
>                 final_phase = (start_final + len_final / 3) % PAD_DELAY_MAX;
>         else
>                 final_phase = (start_final + len_final / 2) % PAD_DELAY_MAX;
> -       dev_info(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
> -                delay, len_final, final_phase);
> +       dev_dbg(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
> +               delay, len_final, final_phase);
>
>         delay_phase.maxlen = len_final;
>         delay_phase.start = start_final;
> --
> 2.34.1
>
