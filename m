Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2138E480A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhL1O6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhL1O6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:58:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440AC061574;
        Tue, 28 Dec 2021 06:58:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v7so38779362wrv.12;
        Tue, 28 Dec 2021 06:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0EKkFOMfBMhnj4gE/wIselffM6hh1xaDY0vBPskTeK8=;
        b=eXsUiD+XAMAE366M0Wq6CbF2W26uA1pXycMjbBq7X+U66zEEo+SoA+P4y3ntdUVGlr
         jm6UekdgB/CgC66w/KPa1+ShM4A812w9EoG0xqo2lop2qbE9muOduFLnj5JlsUygP/06
         OKZMxLeR2K1JnmrChdxuhbdi3XvKkjidwaC5bUHQUFiyFaTYYtAOLgRlZxSu0gCPmdPf
         lGmgbBBICPdCOQIYEV4rjGh6VOwjYOWaYd+fiZFeZhoz33zPlONZuHoGRyw3EaiAwEQe
         Zhs4b20PfFnA8NVZ8wKS/E/9u33C3jG8PlTq0mDip2v+djyFuDcmJUFMgV8ZxFOE8G84
         jxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0EKkFOMfBMhnj4gE/wIselffM6hh1xaDY0vBPskTeK8=;
        b=sicjMGVFbNAEOjevQqnuWjSCGbIns8GFQaw9HsRMQEXDVcJbO4++tmxvPtljCFmrXE
         Wfy8fjm+C9A2IZAtcXA1jrM6R3eK/uLamfx+6P3XXCiKIrOdAuE8VvUgnRjWIPycO0OU
         ZVecRBFK0cdMoU91vedOO1RWzsuxEQScMRFxGJff9HBy11DPN20MeGSI9tE+iRymszE4
         vv18sP6EZrNPsqr9lyoW3bbNHq/0ROsLkgHoJU2eDrmiq7Ia+3dJp0pQ7a9CFOO5dSrT
         eI1hUxfL0yaSMqyFZ7pp4wKU2lX+0bWfVLd4V7Gq9frHNd0J+DHMIzl3Hft78tKlKLnk
         8Z0A==
X-Gm-Message-State: AOAM533che01zJHSXEIYPJounFfLvSBx/2gGBQzdMlad4QegUmDtisgM
        vu5JGkoncAKgc3cqAiTRmRg=
X-Google-Smtp-Source: ABdhPJzKqa0L9wwBoXeKIwPS6rl8ONnmr/bs6OUl8sS5RxFlF7/bBldlKueEtJCsTu+6NI81czaDiw==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr17239895wri.277.1640703507827;
        Tue, 28 Dec 2021 06:58:27 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id b6sm16320534wri.56.2021.12.28.06.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 06:58:27 -0800 (PST)
Message-ID: <0eab31b6-2b8a-b9e1-a738-232cc8f86379@gmail.com>
Date:   Tue, 28 Dec 2021 15:58:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] mailbox: fix gce_num of mt8192 driver data
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>, tzungbi@google.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, nancy.lin@mediatek.com,
        singo.chang@mediatek.com
References: <20211223145155.25704-1-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211223145155.25704-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/12/2021 15:51, jason-jh.lin wrote:
> Because mt8192 only have 1 gce, the gce_num should be 1.
> 
> Fixes: 85dfdbfc13ea ("mailbox: cmdq: add multi-gce clocks support for mt8195")
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> Change in v2:
> - fix tilte tag from cmdq to mailbox
> - rebase on kernel-5.16
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 1faf35e8aff0..2895484f8349 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -650,7 +650,7 @@ static const struct gce_plat gce_plat_v5 = {
>   	.thread_nr = 24,
>   	.shift = 3,
>   	.control_by_sw = true,
> -	.gce_num = 2
> +	.gce_num = 1
>   };
>   
>   static const struct gce_plat gce_plat_v6 = {
> 
