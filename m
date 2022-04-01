Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476EA4EF788
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348865AbiDAQEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351950AbiDAQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:02:00 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795AB1E375F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:29:48 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id j83so3156121oih.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gyt7OhDDJG/Jjk7Y/BmbMpmUgwu226u2PaT2lDpwvxc=;
        b=j0CYlUEivF/RCALCdJ2Z4wBED5Vbr8IWDxV7p4iIFjdEPkXzwTWODhj30CjLvZmhe7
         2UFCyytz3MgGot99GXMHJIHAVUXsGifPAMzVoAGEz6haXmV9xVL4H6iEFgRz73A/vW/b
         29CVR98yCdyUfqh0UAPAjP3ZbeD46Sh1qT+yaQ1UN1jsn3QMZoCYa8ERKMjHfHjidTF9
         lFwKqatt6pTzk/OJxda5PyWzuYt9NX8ZI/j8WUd1wXS1/sEINWSM1JxS60XJ0msC3Y14
         8opdr8vTS0FJnpA3d+EwYGG8S8YqmX/+EluBLGit5cQrhQrEr84rf6ar3uqf/I5BA2Qj
         o2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gyt7OhDDJG/Jjk7Y/BmbMpmUgwu226u2PaT2lDpwvxc=;
        b=bvljmOF8GU9v4ioDzNvQoo5yxyUMj5Xyh0JqknF4tNMIyPVWEQtBQNdYiZO5OCi6VP
         IDI7INRAbYsyfxQ48grqXUuQ372Et/b3OjEZjTGFHvEl4Luy5TDtmzF0nn1X4m9xQN0K
         PzThy+sWZMPXc07MxOzQylrv3sVtPtTmzkSizVLlT5bc2YMS2HbUY+OLIxMUVpwVf6kQ
         oSO8R+l4qIdGsbVX356rywqVe1FWve+Co3HPFJkydmjN1UQghEf+sD3pd+8M3UjJzATT
         /rPz9eTNPi+Vx/X3yhvBr7cMr+00q1Y6IZinlpbg1o3m7OvR/W2tc737Az/0cPVHs2Cp
         OpTw==
X-Gm-Message-State: AOAM531IrymE6mAzzf/4iaKmgymxRb5HCpVxDlc7pLjwQEBR2hDwDyNe
        tCHgYI47JNySa9iNZborYR+7wJ5yBiaXDrcvU0ZT+yHo
X-Google-Smtp-Source: ABdhPJwyrU8W6jyhWPl9Bn2XENn1UJZ4nH2sM7UDccpjUlXDCe8pBNG9QRtRKHuBY2hCPZOYMIk9gwEPzLWS1mVKl+0=
X-Received: by 2002:a05:6808:df1:b0:2ec:b193:ad6c with SMTP id
 g49-20020a0568080df100b002ecb193ad6cmr4719251oic.200.1648826987831; Fri, 01
 Apr 2022 08:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <2a2b1f76-7e9b-9561-e190-16d808eb5399@molgen.mpg.de> <1648794486-23302-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1648794486-23302-1-git-send-email-baihaowen@meizu.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 1 Apr 2022 11:29:36 -0400
Message-ID: <CADnq5_MyjrUus0BZpzRKLei-asBepNGjZanLgHiFVUFWSmggcQ@mail.gmail.com>
Subject: Re: [PATCH V2] drm/amdgpu/vcn: Remove unneeded semicolon
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Applied.  Thanks!

Alex

On Fri, Apr 1, 2022 at 3:23 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> report by coccicheck:
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:1951:2-3: Unneeded semicolon
>
> Fixes: c543dcbe4237 ("drm/amdgpu/vcn: Add VCN ras error query support")
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: change title; change Fixed info;
>
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 3e1de8c..17d44be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1948,7 +1948,7 @@ static uint32_t vcn_v2_6_query_poison_by_instance(struct amdgpu_device *adev,
>                 break;
>         default:
>                 break;
> -       };
> +       }
>
>         if (poison_stat)
>                 dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
> --
> 2.7.4
>
