Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A7C46130A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353653AbhK2LG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbhK2LE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:04:58 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E97CC0613F9;
        Mon, 29 Nov 2021 02:18:41 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v64so40742062ybi.5;
        Mon, 29 Nov 2021 02:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXH2HaKOYFSvNYsZNxqPTQGPmOPgtDAaeXAEosri/GI=;
        b=PSmlwAD7ACyEfBEhWvQkj7823/mBOTnX0C1DcD2ayQHwP89r+UFyiEg9w7xfrnaX5b
         WycVZDqwMYSsLtj825Dh1xzpCAYz8fuqP6M9c5pg+n5zZ1XAOsA2oPtHt1HxUqdnwS4z
         3qW3VU0aBxsa+f+v56h5v5rL5IFzjTfRqK1QkDk5Sh0B50lqEXGj+6K6HdxygkPOi2MX
         wfQ+gKX6KezMgdekoGLVpbLS77ZbxsaHdBj1NbnVwRMxYis1AuMznTmPWrT1ydCgMv/i
         LQzumcasuCBwF/npDfnwM9rDhT8bwWluLo+wvYS9NXWMwBp4N/ysroCiUtRjgp87W+MU
         hD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXH2HaKOYFSvNYsZNxqPTQGPmOPgtDAaeXAEosri/GI=;
        b=mgVLvg6PYgqm2wMtEqMwL2pEH+ueR/oUw3/FpmXLnNN1jr97ZnEudZ8Ih0bw1+S1hi
         ByxgHp9M4Tf5cM3I9J3BeMHHwVnsF8f4RTvUMepaTnyCDLoGmm7tk3GcNte9eAH9aSpO
         nzTls/tV5+/P78YH2w7MMJQQ/U/ANyS0kX5osNGtNC3qpx0ZWvWUDz6PqYrtKB7B98LP
         pT6ytk/vTQJVbEJHxWf8TiwLCCQDG05WKzxjVXZsMGwpPqryqaX4HPX+xgwOgHrjBn6U
         DqPEcq0pmKystjZPDmC4cxoUKbBrbvZSA4k8dZHdq/Ivl/R9PHO5Fcyg63ipM8LzCJTQ
         Urjw==
X-Gm-Message-State: AOAM531dWmaDrUd5LIL3CXbIE4gzP7ZU/zyJHwGnIXSOkhbYEBEc33+P
        2BXlb1GL2XQYBPj9s+nOe3/+sK026MpFJu6N7fw=
X-Google-Smtp-Source: ABdhPJwBcC0P8wpnRfvlyKdmfKjUUAGGe4jlRwZyfRjWFthpP4ftdxrbP3niRKyeNIIJjlNk0TURUyDLbx2eRbbbdlw=
X-Received: by 2002:a25:1004:: with SMTP id 4mr6066537ybq.669.1638181120359;
 Mon, 29 Nov 2021 02:18:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638179135.git.mchehab+huawei@kernel.org> <7447911ef26de9ac73265df6aee306fbe59691a0.1638179135.git.mchehab+huawei@kernel.org>
In-Reply-To: <7447911ef26de9ac73265df6aee306fbe59691a0.1638179135.git.mchehab+huawei@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 29 Nov 2021 10:18:14 +0000
Message-ID: <CA+V-a8twBgAd_H6mSJqtP4KL52yYo_iFuPgmODL-Y72=cavWeQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/20] media: davinci: get rid of an unused function
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 9:47 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> vpif_get_default_field() seems to be some left-over from a
> past code that sets the field order.
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>
> See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/
>
>  drivers/media/platform/davinci/vpif_capture.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
Prabhakar

> diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
> index ae92e2c206d0..aba105fa7ef9 100644
> --- a/drivers/media/platform/davinci/vpif_capture.c
> +++ b/drivers/media/platform/davinci/vpif_capture.c
> @@ -618,17 +618,6 @@ static void vpif_calculate_offsets(struct channel_obj *ch)
>         ch->vpifparams.video_params.stdid = vpifparams->std_info.stdid;
>  }
>
> -/**
> - * vpif_get_default_field() - Get default field type based on interface
> - * @iface: ptr to vpif interface
> - */
> -static inline enum v4l2_field vpif_get_default_field(
> -                               struct vpif_interface *iface)
> -{
> -       return (iface->if_type == VPIF_IF_RAW_BAYER) ? V4L2_FIELD_NONE :
> -                                               V4L2_FIELD_INTERLACED;
> -}
> -
>  /**
>   * vpif_config_addr() - function to configure buffer address in vpif
>   * @ch: channel ptr
> --
> 2.33.1
>
