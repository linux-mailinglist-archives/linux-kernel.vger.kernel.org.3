Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D8B481C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbhL3M37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhL3M36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:29:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C094DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 04:29:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i22so50100966wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 04:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O0+J3hfYi+tJOX87FRscUIQ71ohxgIJHCX2HAI7b8Uk=;
        b=WMadPGKQYElHu5jMUqicwQrvbZw0wasy3D2dwh6uxHrjnJIKPJU2olLLJiUHlD3145
         plls98wtenzGF2fKfmdY+zgaoa+jfm1UcyH2wkz5HwMtk+9/Qh9TIqO85tG2dg+DB6lC
         +3e+sFx8vK+EaZzrlOQ4oMNMl7NxCcMoBoZJDv9wivx7eB6ftjYEV3iYCqcuggnraFTV
         AG6lYgy2JNYCSPoWhUz1P8FK3E5ws6ZBZTMb1uJZTczp3CiqAHm9U46gHeH3dcpnqQIH
         1tS9OsNRcHYpfa4tH+NupuN9/QJu3+dM2VWCPAjJH1oxL2Qu9yUuX6I/dXc6pxLQ1KOy
         0KTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O0+J3hfYi+tJOX87FRscUIQ71ohxgIJHCX2HAI7b8Uk=;
        b=u67xhKN/MraJwNNzcAnp5Ah2fzsfPijBkzDCbEcCmEdqndkVeSeIpCFhcVPN93xtCj
         DbuxPjJlb78Jz8R/65zEv+gj3iLR7fuZxgNx3a29EmGybcRf8gGG4KQPXe5zYZCt4a9K
         3TUIXi2dDDrF1UsBnrwECVC4+3V6ggmKP/C+GK6z8hvhvp4I+LOTep/mV1VWUXNdGjBx
         sepiqFghOoAYMswSdo9uY6BwQKtyJkyWH9bwJWhxF+orNd0fR8np0tFyCzt/zZh53PyO
         BuM3QLEWvJHh6dOqM8nCC4hcXsTjt5GolWmEu1dkT8Z+4mbbr0Gxpa0i8SgO8zhHyPZ0
         uJ9A==
X-Gm-Message-State: AOAM531yWAlHjDmq02RgnuQjAEwNraDfk3PRUckZpfDtperKBmJ0uA4j
        eo8IxfUN9GGHEI/vzTe20EQ=
X-Google-Smtp-Source: ABdhPJyeMdqRs+cOsnbASw7H4TcBciKWFlGxLhfRAl5VE2g8s7FE8D4hxsDXVPloniZ7EO3XL58Fpg==
X-Received: by 2002:a5d:4385:: with SMTP id i5mr24410955wrq.178.1640867396353;
        Thu, 30 Dec 2021 04:29:56 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id o12sm23945584wrv.76.2021.12.30.04.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 04:29:55 -0800 (PST)
Message-ID: <d784e170-a115-bd0a-a87c-07aed0fb73fc@gmail.com>
Date:   Thu, 30 Dec 2021 13:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] drm/mediatek: Fix unused-but-set variable warning
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jie Qiu <jie.qiu@mediatek.com>,
        Junzhi Zhao <junzhi.zhao@mediatek.com>
Cc:     Zhiqiang Lin <zhiqiang.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20211230093610.28012-1-miles.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211230093610.28012-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/12/2021 10:36, Miles Chen wrote:
> clang reports a unused-but-set variable warning:
> drivers/gpu/drm/mediatek/mtk_cec.c:85:6: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
> 
> In current implementation, mtk_cec_mask() writes val into target register
> and ignores the mask. After talking to our hdmi experts, mtk_cec_mask()
> should read a register, clean only mask bits, and update (val | mask) bits
> to the register.
> 
> Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
> 
> Cc: Zhiqiang Lin <zhiqiang.lin@mediatek.com>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

I'm still not happy with the commit subject, I think it is misleading. Clang 
only helped to find the bug, but the we are fixing something else, that's not 
just a clang warning. But I don't want to nit-pick too much so:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> 
> ---
> 
> Change since v1:
> add Fixes tag
> 
> Change since v2:
> add explanation of mtk_cec_mask()
> 
> Change-Id: Iec6402b0532942f4d0e8bc56817eb87b95c03fad
> ---
>   drivers/gpu/drm/mediatek/mtk_cec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
> index e9cef5c0c8f7..cdfa648910b2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_cec.c
> +++ b/drivers/gpu/drm/mediatek/mtk_cec.c
> @@ -85,7 +85,7 @@ static void mtk_cec_mask(struct mtk_cec *cec, unsigned int offset,
>   	u32 tmp = readl(cec->regs + offset) & ~mask;
>   
>   	tmp |= val & mask;
> -	writel(val, cec->regs + offset);
> +	writel(tmp, cec->regs + offset);
>   }
>   
>   void mtk_cec_set_hpd_event(struct device *dev,
> 
