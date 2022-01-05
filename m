Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F110548526A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbiAEM0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbiAEM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:26:43 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E202C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 04:26:43 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id q4so37366517qvh.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+6zUFKikZ5uI7X+WBRedpvpkwDXnTgkeRYffGhJplBQ=;
        b=v0GeznWOJp1intYhv38FsyRKC2LY+s7ndDGtu8347+i9nbXXv04HckdcZQOYkPKp90
         /jX/cn0VqKe2GUgFg8xH4/RRsX2gOU2vi4YIq2jnAXgtJFu8NKWOmv5UTm7JKOBG3wVd
         yX9NM8tByP/uwWU3/WPQ7QTsUzFb47l90lqhxnFgpjcN80pQu3wHho0EGORmw4jD4Hze
         2N7+JCrk4rGAxSTsjSt08zwMWj9DQKe79mw7iOhhxX8p6AUqdjfORxMRC/f4QgTqsNJB
         wYnJmPOreCRXYJ/LqiEG5E0tR+gwvKZVim6Fcfba4VyFEW0Zya6GV1LFeZO/aFjf05Op
         DDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+6zUFKikZ5uI7X+WBRedpvpkwDXnTgkeRYffGhJplBQ=;
        b=p8N4U1GnGlC5MuyzfpO9CnrYBHz+fUIBO6sXTY0dBjTjRA8h/kad99EuCBS/c6mQPU
         I5GTCrnvwuo4OIK4qDgAAP3EJT/ZSzkV7YSJqG85FxCsG3DZvjkuzJaaM7IQtXm2KLUR
         7fOVeSHiyN7p2E5oZQGqeyC0LMvAcV/G1KwYktg+Z8Q6Z+5dvP3lZjhj2pGYwcNZfR6+
         FEI+do1bQ5sLfElY4fyLzrIbpTgvnnULKvuBs9vAns66PjvBOAGC1I/EwSXTzJY9R0I6
         38CwxyrTxdrcK7nTTmu6yMGa4CMCdM78YJAKfnfa/vEOpMOSI4NNrydAHOM+T4j5x1lA
         JUdA==
X-Gm-Message-State: AOAM530s6s/AyQ+1HrlgGgr5mQTeFpUOxkuMm22XUlgJamWOMReERfx7
        YDuKMgqwU3rCEeZz/knqJ+VXuQ==
X-Google-Smtp-Source: ABdhPJxqbVB7XWk6LPZe9NdWapRfu4IObMFem/esLdwpybt5KuvKvaxSKJK/v6LXDUp/1xX65da8KA==
X-Received: by 2002:a05:6214:262d:: with SMTP id gv13mr49591568qvb.23.1641385601790;
        Wed, 05 Jan 2022 04:26:41 -0800 (PST)
Received: from eze-laptop ([186.122.18.30])
        by smtp.gmail.com with ESMTPSA id a15sm36481925qtb.5.2022.01.05.04.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 04:26:39 -0800 (PST)
Date:   Wed, 5 Jan 2022 09:26:33 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        jernej.skrabec@gmail.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, kernel@collabora.com
Subject: Re: [PATCH v4 1/2] media: hevc: Remove RPS named flags
Message-ID: <YdWOecbZHO+Skbnn@eze-laptop>
References: <20220104073842.1791639-1-benjamin.gaignard@collabora.com>
 <20220104073842.1791639-2-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104073842.1791639-2-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Tue, Jan 04, 2022 at 08:38:41AM +0100, Benjamin Gaignard wrote:
> Marking a picture as long-term reference is valid for DPB but not for RPS.
> Change flag name to match with it description in HEVC spec chapiter
> "8.3.2 Decoding process for reference picture set".
> Remove the other unused RPS flags.
> 

A change like this, which is affecting a kernel interface and has impact
on userspace and drivers, requires a lot more attention in the commit description.

If I understand correctly, this change is related to how HEVC was first
introduced and how the DPB was originally represented in V4L2.

Originally, a DPB entry struct v4l2_hevc_dpb_entry had an rps field
which can be:

  V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_BEFORE
  V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_AFTER
  V4L2_HEVC_DPB_ENTRY_RPS_LT_CURR

Perhaps this idea followed libva, where a VAPictureHEVC has flags field
which can be:

  VA_PICTURE_HEVC_RPS_ST_CURR_BEFORE, 
  VA_PICTURE_HEVC_RPS_ST_CURR_AFTER,
  VA_PICTURE_HEVC_RPS_LT_CURR,
  VA_PICTURE_HEVC_LONG_TERM_REFERENCE

In this representation, the sets PocStCurrBefore, PocStCurrAfter,
PocLtCurr are implicit, and must be built by the kernel from the DPB
entries struct v4l2_hevc_dpb_entry, using the information in the rps field.

Last year, we changed this with your commit:

commit d395a78db9eabd12633b39e05c80e803543b6590
Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Date:   Thu Jun 3 13:49:57 2021 +0200

    media: hevc: Add decode params control

Which added the control v4l2_ctrl_hevc_decode_params, which includes
the sets PocStCurrBefore, PocStCurrAfter, PocLtCurr explicitly and therefore
moved the responsability of creating and maintaining the sets to userspace.

This effectively made the rps field in the struct v4l2_hevc_dpb_entry
useless. The longterm flag is still needed though for a DPB entry.

With this in mind, you could even say this commit is doing actually two
things:

1. Removes the unused rps field.
2. Adds a flag field, for the longterm DPB entry boolean.

Do you think a single byte of flags will be OK for a DPB entry?
I think so, but I'd love yours/others input here.

If the above is more or less accurate then, and provided you
submit a new version with a more detailed commit description:

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Also, a small question:

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 4:
> - check flags with & and not ==
> 
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 8 +++-----
>  drivers/staging/media/hantro/hantro_g2_hevc_dec.c         | 2 +-
>  drivers/staging/media/sunxi/cedrus/cedrus_h265.c          | 2 +-
>  include/media/hevc-ctrls.h                                | 6 ++----
>  4 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index e141f0e4eec9..38da33e61c3d 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -3166,11 +3166,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>  	:c:func:`v4l2_timeval_to_ns()` function to convert the struct
>  	:c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.
>      * - __u8
> -      - ``rps``
> -      - The reference set for the reference frame
> -        (V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_BEFORE,
> -        V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_AFTER or
> -        V4L2_HEVC_DPB_ENTRY_RPS_LT_CURR)
> +      - ``flags``
> +      - Long term flag for the reference frame
> +        (V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE)

Is this longterm flag associated in any way to a syntax element
or an HEVC process? If so, please document that.

Thanks,
Ezequiel
