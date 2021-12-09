Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520E346E4A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhLII5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbhLII5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:57:53 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A35C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 00:54:20 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 7so7716758oip.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 00:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OS54GWWcwsrTmTbT3JvuCSiGaQ1hB71d7lr0N1iLqQk=;
        b=mIzGlwDNxua032moc9mIB5jGSsJtFd3Y6ysKCUSN9mczC0Kb9cGqOhn3dxZV3MtfOH
         9bMhfpFN7crCbjA6FkT7kyibcoNX4qf8s+EJ+ed2qD8rTRDBAs4HLtBG8kAexJOQKbgs
         TfERho74HIAubVtxTLOykzOtDDcw6hTDJUdfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OS54GWWcwsrTmTbT3JvuCSiGaQ1hB71d7lr0N1iLqQk=;
        b=yYg84CNqAxFpRE9ADyLDbSRm3G60pFQ0RT/gO7wjSXJF9JyzzoxJX+Wu1G3PwrOeRT
         rO0bFfI6baLzUa1dgbMihTshbUKK6Xz1SIMcPhvsyyJfsjap6FckWm0fz9Xe5XTLhfl8
         EfNa04h1eRCMYyIsJ4iQhZuMGgSNx2gvcCFgeY+bmXRSp3zq8vyKSQYXe9siD0KACj+s
         L1bWmLFy7pm3JJZRX8swFWzGAjiI89daxo0bNPSUMRiQ1Rz8lnFyvYri5/lPmq37GWTO
         qRng7SsbGKXN/PAnceLgWb+XJmfpUY11KboR5vdJDMcxNFKOcwV09i5eQPF8F1Jwl/Wl
         oE9A==
X-Gm-Message-State: AOAM533wRYRD1oDnZIunF/gktbkKmZau0qeo2WiqUPbRgguloOBcm7tV
        YYpuUXJfTq+gMZStw4GYOO4dG9zHUQQZ0g==
X-Google-Smtp-Source: ABdhPJxvzu2dDe7csPoCmNqoGo0YYwfIqqvgFZWNQCr70DS1qbHuHGDuo8GT7xH4x+wfp2tQwVEvpw==
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr4518028oiv.160.1639040059112;
        Thu, 09 Dec 2021 00:54:19 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id a3sm1173397oil.32.2021.12.09.00.54.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 00:54:18 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so5419695otv.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 00:54:18 -0800 (PST)
X-Received: by 2002:a05:6830:22f0:: with SMTP id t16mr4051388otc.349.1639040057919;
 Thu, 09 Dec 2021 00:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20211208174158.114122-1-amhamza.mgc@gmail.com>
In-Reply-To: <20211208174158.114122-1-amhamza.mgc@gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 9 Dec 2021 09:54:06 +0100
X-Gmail-Original-Message-ID: <CANiDSCu-Q=VqkS1_B-1pvc4uZtUZynRYkpyu2ZASddSqsmT31A@mail.gmail.com>
Message-ID: <CANiDSCu-Q=VqkS1_B-1pvc4uZtUZynRYkpyu2ZASddSqsmT31A@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: fix possible memory leak issue
To:     Ameer Hamza <amhamza.mgc@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ameer

Thanks for the patch.

It is already covered by
https://lore.kernel.org/lkml/20210917114930.47261-1-colin.king@canonical.com/
which is in the staging branch of the media tree.

Thanks!

On Thu, 9 Dec 2021 at 01:33, Ameer Hamza <amhamza.mgc@gmail.com> wrote:
>
> In uvc_ioctl_ctrl_map() implementation, there is a possibility of memory
> leak if control id name is not listed and kmemdup() is failed somehow.
> This is a rare scenario but possible.
>
> Addresses-Coverity: 1494069 (Resource leak)
> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index f4e4aff8ddf7..711556d13d03 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -44,8 +44,10 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>         if (v4l2_ctrl_get_name(map->id) == NULL) {
>                 map->name = kmemdup(xmap->name, sizeof(xmap->name),
>                                     GFP_KERNEL);
> -               if (!map->name)
> -                       return -ENOMEM;
> +               if (!map->name) {
> +                       ret = -ENOMEM;
> +                       goto free_map;
> +               }
>         }
>         memcpy(map->entity, xmap->entity, sizeof(map->entity));
>         map->selector = xmap->selector;
> --
> 2.25.1
>


-- 
Ricardo Ribalda
