Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78D5507109
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352933AbiDSOxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiDSOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:53:35 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0A33A5CB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:50:52 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e2fa360f6dso17756582fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Tg5nZzh9oQDL1KQptjvk3ZiAVxwof7ABn++cYNncss=;
        b=jTfmgMbGgpK2pFoqKs+aBE32BYvM2n2aKjYyoCe2lQ5+kWewpr1JDFdMXK6YQKcd56
         0Y5VkKgFsVvxWH7EW3wHq8n280yuRTJYli6DfghqSch0dWkpqamWyZ0vbUM49KSaGtBb
         3fnqVGuAXNPG1i3lPsSckn7aWDqL5e+3E5MAMHJm21+TTty28/NZUmq9pAeDndnFbA0J
         JOvbO76AGwEo3RdqJtZumr1fuTJ9hpSHXYk1gGSMXLQFVM5wUp+opXHILw4vP29veUCH
         dcLCM9X5Zk7EDPNUhflH6L6uKkyf2yso846VRIHnlgxWC8FP7zkbuhdjjekfIwU+pZeP
         elyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Tg5nZzh9oQDL1KQptjvk3ZiAVxwof7ABn++cYNncss=;
        b=QC6JTClMVOX8SxQYgHWaa86Aua7sa1lXV+GOabLmy9P09wfJ52b0Ddn5EWknn+XVmv
         3n8mJ5nPxhrR2gG90FyILYVZp40/PNQc5emy29CQRDxW2eCcwoZnju/+ZGaC2ZDMbiKg
         llnOUKjPCboduZjuuRTdF9zomVLiCWKwwIUMo4bq3V3FpHerJd6WNDm8jr8rC/LdfsM1
         PpgcADaZkGJ6tCZx6BJXyqtZCG7rb0tA/Z2QfZIkJ7DP7LYjxdf9tK1cehNNfEouUwHG
         Fi7naEujwU6eqxjIlIeZ0IuOOd80XuU7tF7SEqfQHRk1BwAQxzxUcNevrNsAGymC1Wd7
         44+g==
X-Gm-Message-State: AOAM5305hBzpH7/XOYhByhYG3nyG24xb+J5yRveJBi+J1Rm9TVrC6C7y
        te+AWmY/ytmnEFbXM2kr9yDxBSLPAFv1DsMFSUM=
X-Google-Smtp-Source: ABdhPJxqXxqKIvUyCMkpdd15R7yoX0oYv19nBoQ8aXfGbeSnhB+k6n+l60epVZPfGevIPY1sac2Iy3lI/5vW2NsATLM=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr6769659oap.253.1650379852002; Tue, 19
 Apr 2022 07:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220418194830.3266024-1-trix@redhat.com>
In-Reply-To: <20220418194830.3266024-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 19 Apr 2022 10:50:41 -0400
Message-ID: <CADnq5_Mjzbg5jpnnAU8v7C7At9i-s_Dq=qZ21UNudyM+rKrWQw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add virtual_setup_stream_attribute decl
 to header
To:     Tom Rix <trix@redhat.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stylon Wang <stylon.wang@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
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

On Mon, Apr 18, 2022 at 3:48 PM Tom Rix <trix@redhat.com> wrote:
>
> Smatch reports this issue
> virtual_link_hwss.c:32:6: warning: symbol
>   'virtual_setup_stream_attribute' was not declared.
>   Should it be static?
>
> virtual_setup_stream_attribute is only used in
> virtual_link_hwss.c, but the other functions in the
> file are declared in the header file and used elsewhere.
> For consistency, add the virtual_setup_stream_attribute
> decl to virtual_link_hwss.h.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
> index e6bcb4bb0f3a..fbcbc5afb47d 100644
> --- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
> +++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
> @@ -28,6 +28,7 @@
>  #include "core_types.h"
>
>  void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx);
> +void virtual_setup_stream_attribute(struct pipe_ctx *pipe_ctx);
>  void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx);
>  const struct link_hwss *get_virtual_link_hwss(void);
>
> --
> 2.27.0
>
