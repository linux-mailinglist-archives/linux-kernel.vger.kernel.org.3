Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2449249EC22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiA0UGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiA0UGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:06:07 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76236C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:06:07 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id e81so8080228oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbKovafJqxrxwXPbGoli47dYNTXZx5if0xOvJbes1n4=;
        b=WfsqeZeB8+li+mdCAXmE+EF4ZRqHlHrJzP2yutjB+v6HxVpxELeq+TMjgrbMGR3zEI
         +8x0msUyys1XPwGqa3fdLHzvWscjB3u0wupX4CCRp03rQ3hi4nPKleTA0ptfwtnLHbRe
         hAk24ujnHHi7GQq98BUvHXMXD7RHGQrVV9QOq7EkM43SKDznN2X+U3rgZ6P+Nu6f7zMW
         7w7gB78qJ8nx/LX2+GPB45H52puMqCdCn4PMq/Y951J39wBhUeYndJQP9J09E0MCgfTc
         d3/ueGUTCAJ+xwUxdYbO4bzhIfJyKE661DoWt1xW9RhpaR/rrACuniPtY4N+D6ixUfz7
         6hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbKovafJqxrxwXPbGoli47dYNTXZx5if0xOvJbes1n4=;
        b=6fW5KJNapqPr8WxKaOLne5SYg7wVy83daD6Iygwwta02Yq+SF/SBg6eL3hB4Ji6nHH
         FPceg2tK7K1/7Q+3S1e3u3a2ZE6E3mejr66ZFMuRpy109qowaIHpSxwHBYiOw1VddGBe
         TONEPWjHmjJbyubCbWRS4BYjx5g8Z8Fg+9wRayaN9wwiNXgbkW0b3dYP1Sk2gOno501F
         wzIM04XWB3UcfuRQ96ZNWn+++H+pxz4qI4ddJ/3zXDWXFSmM4AeLsU5otXS55FLydy9K
         GNGiVtEnSmVZeiX1LwLJuoR/aNLnVO/1izbNm4nTIg4wG8zxrGBO5hqCqK/TM4876ViO
         42VQ==
X-Gm-Message-State: AOAM531qWEecGKiKzYwTM6bzWwO/NyJnIxPLzzdV9OvfxX0BrfvPkmy+
        npi03XW/n8ZEB3r1ZV7bve7MoYjSTWgPMzQ/6Y/Ukkgk
X-Google-Smtp-Source: ABdhPJxHBpcoUFN1+scsDxMoRLl4j1oxUKa7K+WMYr5203HWdFDjlL8IAsQAu0hWcYb6baNdXROmNcUwivxZk2AYsQc=
X-Received: by 2002:a05:6808:2189:: with SMTP id be9mr8099468oib.93.1643313966887;
 Thu, 27 Jan 2022 12:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20220127071239.30487-1-tangmeng@uniontech.com>
In-Reply-To: <20220127071239.30487-1-tangmeng@uniontech.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Jan 2022 15:05:55 -0500
Message-ID: <CADnq5_NR_=FACtfo_V22gK_nhBOcnp=Y-8NQooKtkKzJULeN3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: fix spelling mistake "disbale" -> "disable"
To:     tangmeng <tangmeng@uniontech.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jan 27, 2022 at 3:45 AM tangmeng <tangmeng@uniontech.com> wrote:
>
> There is a spelling mistake. Fix it.
>
> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index aef9d059ae52..a642c04cf17d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -544,7 +544,7 @@ static int xgpu_vi_mailbox_rcv_irq(struct amdgpu_device *adev,
>  {
>         int r;
>
> -       /* trigger gpu-reset by hypervisor only if TDR disbaled */
> +       /* trigger gpu-reset by hypervisor only if TDR disabled */
>         if (!amdgpu_gpu_recovery) {
>                 /* see what event we get */
>                 r = xgpu_vi_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
> --
> 2.20.1
>
>
>
