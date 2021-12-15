Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E904762E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbhLOUOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbhLOUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:14:22 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9ACC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 12:14:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t9so40192103wrx.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 12:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E1VZMDNDn7cqxKxApca8uJlehdzt88dyZchiwwKVm7U=;
        b=g1YyMuTJ5GsMHrXtXUEAz4CRABMZW0S01hXe8QKWhyABEJi3BSEjuBy3EaXP0Yw2UM
         Il36LK+Tu016+3Ogmt+dKV2opDXRvH3DInp+s2ABpg92+3aVMbIIxDVNTR0x8kbtqKnX
         s5DlUfbxNhTFU7fWAbhPB9mSAi+mbLD7qYcVGGZo05cj+AlxhrTdSMZjMQ36IoS/H15U
         Ncf4K+gfKNpj5EpmlPU3POL7uLtoU643+74wvawF0qyKP0FohOPXapbgdRi7JzHJBfBX
         8H3ZNubWMsoFWlFLipISi+RUENOj5G4b4eqHp/wHzdFCwzWSMDXNOX7tDscJQ/3P98zJ
         U+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E1VZMDNDn7cqxKxApca8uJlehdzt88dyZchiwwKVm7U=;
        b=WUDqbDPwVGPsBQELaPHiiYpMs+szw7I8L8KWUJLDHeYC47tdyru6mBUtKcpf9/rCC6
         nMCf42lI28ZpM7wWlFZawSh6fODpx/8Zx2kY6/zNMdZj73dyiRvBK3CIuKOcuib4GLUu
         phkc+YJvVMmYryATiL1cickmWBl/l7GD3VYzuHNF5DMKCfewQB0l5HFOWyc6Ktpl856K
         A3AiaIFnjPwCc0p1nuxkYrVolfJsslZX/8B1zhYx0QuCsCbefw2E936YnUoBoVoOrpzR
         fWppAzTbYt+VxGY2V8UnI+72oYg4I+chLfvnx150WnIYA0ZUEQ8CiaUgwaDOP5iy0FMv
         E6JA==
X-Gm-Message-State: AOAM532LEEtwEYde2X3TsMlPMeYP324hkHlMJeVGoSqyYbWwsi7BAn1a
        OHLpOwmgrK/ZIFDj1gzY0YA=
X-Google-Smtp-Source: ABdhPJxBcM7HgZAgdlpi5+nkMNlxm9PmJ9F1y1ZmeyiXC8WxsVPU+9cBAt9sxOLu46Lj9oHh7lCXAg==
X-Received: by 2002:a5d:47a1:: with SMTP id 1mr6122296wrb.436.1639599260782;
        Wed, 15 Dec 2021 12:14:20 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
        by smtp.gmail.com with ESMTPSA id a1sm3810907wri.89.2021.12.15.12.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 12:14:20 -0800 (PST)
Message-ID: <5b90dd50-f088-8250-7683-fe359d9679a8@gmail.com>
Date:   Wed, 15 Dec 2021 21:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 5/7] drm/mediatek: dpi: Add dpintf support
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211110130623.20553-1-granquet@baylibre.com>
 <20211110130623.20553-6-granquet@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211110130623.20553-6-granquet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2021 14:06, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> dpintf is the displayport interface hardware unit. This unit is similar
> to dpi and can reuse most of the code.
> 
> This patch adds support for mt8195-dpintf to this dpi driver. Main
> differences are:
>   - Some features/functional components are not available for dpintf
>     which are now excluded from code execution once is_dpintf is set
>   - dpintf can and needs to choose between different clockdividers based
>     on the clockspeed. This is done by choosing a different clock parent.
>   - There are two additional clocks that need to be managed. These are
>     only set for dpintf and will be set to NULL if not supplied. The
>     clk_* calls handle these as normal clocks then.
>   - Some register contents differ slightly between the two components. To
>     work around this I added register bits/masks with a DPINTF_ prefix
>     and use them where different.
> 
> Based on a separate driver for dpintf created by
> Jason-JH.Lin <jason-jh.lin@mediatek.com>.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
[...]
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
> index 4bba275e235ac..56ed2fa5f59e8 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -19,6 +19,8 @@ enum mtk_ddp_comp_id {
>   	DDP_COMPONENT_DITHER,
>   	DDP_COMPONENT_DPI0,
>   	DDP_COMPONENT_DPI1,
> +	DDP_COMPONENT_DP_INTF0,
> +	DDP_COMPONENT_DP_INTF1,
>   	DDP_COMPONENT_DSI0,
>   	DDP_COMPONENT_DSI1,
>   	DDP_COMPONENT_DSI2,
> 

For the mtk-mmsys.h:
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
