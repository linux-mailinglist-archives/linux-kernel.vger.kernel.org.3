Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55E14F64FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiDFQ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbiDFQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:26:00 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0780A4A8BF6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:48:34 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-deb9295679so2933514fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tff9KGQ+bsLXvvlGrFFOOruQ3oJjYqZr9JmnrxOjJ4Y=;
        b=Pz3peI03JaAXX+YmbVRrrD8aT8DBREGrmMjGut2CIoQTdDGqXz2WhW0vUrpoZXBRka
         H51aAXXnoCs6NqrBiAhWA2vseU18kw481zZpIFakuYP8CMlJsr/5Bo6yNfOozVJ6euRy
         u34G5xeCSik5Iawv8qzhX4Wzl7B0pJERh5J1eITcVUYOnZw15yxpyuAU9RELs0mezm0z
         hsUZCpiCmxtOC1v8elYqKefgAHkSABqLHPUpHqxfp3eSXhCbBsJ1NF9i2Smq+pNq41/C
         Drm3AQKIfCGLkHGxHgliJ/oPBCT8qYwhgxYo7qr3mm2M3EJfboJaSZe2lbfVM1b9hKfh
         t52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tff9KGQ+bsLXvvlGrFFOOruQ3oJjYqZr9JmnrxOjJ4Y=;
        b=0MwKC9X02/7DpvptqrI9vF28Y5MUYOLnOZavQPuM8SXVMYj0MAyziPPqa5xugUvsbH
         nn6Gw4fP3Nb191Uad9GlXnEY8sY+WPRSWFfL/ZH2uLwyM60CHR358EhwkdLRbbjPVeCT
         OcVujt0VVzyj5w0/BLF2IFBouZQJdJ6Zkhu/9f1xqQB331ri5eP1KRFlyqgvFaL+9/Hj
         qvQbJet/hRybmZR7cbtoJEM/A7l2GYg0OTGGC1snhFH/vymlDvAJ8VLxNQ8VT7Qiy8vF
         ARhlRdZRdaUzLocYG6F47jUSebBlWtYQl1dFAtJMf0cP935isDd5Pls7ERK4DiZa6CAd
         WR/w==
X-Gm-Message-State: AOAM530leX3AIFg8iuuOX4wm20ehRZeUfpNxZc+asFpTKAyLzjYv8P8i
        /tzZ6UXY5RiSrotRi32BPGhS7Z5Rpg7+SQ0g4/A=
X-Google-Smtp-Source: ABdhPJwBF5ZUL/edR5iad6IQUajo1OlMxWFZiax+WO1MJDzlgdbsH4OO5bN2bmOs9l8HaQAZW75Cg/RP1hV91K7Lkio=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr3687787oaa.200.1649252913998; Wed, 06
 Apr 2022 06:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220406072840.2488056-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220406072840.2488056-1-lv.ruyi@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Apr 2022 09:48:22 -0400
Message-ID: <CADnq5_N1MyBy5C+3-e7pxXewX_hpXCZtavemO_xv-a+ZxCGN4A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/dc:: remove duplicate include
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Wang, Angus" <Angus.Wang@amd.com>, hvanzyll@amd.com,
        Dave Airlie <airlied@linux.ie>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Zeal Robot <zealci@zte.com.cn>, "Guo, Bing" <Bing.Guo@amd.com>,
        lv.ruyi@zte.com.cn, Alvin Lee <alvin.lee2@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
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

On Wed, Apr 6, 2022 at 3:29 AM <cgel.zte@gmail.com> wrote:
>
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> 'dm_services.h' included in 'freesync,c' is duplicated, so remove one.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index d72566c6928a..0130f1879116 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -29,7 +29,6 @@
>  #include "dc.h"
>  #include "mod_freesync.h"
>  #include "core_types.h"
> -#include "dm_services.h"
>
>  #define MOD_FREESYNC_MAX_CONCURRENT_STREAMS  32
>
> --
> 2.25.1
>
