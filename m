Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ABA56AA59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiGGSTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbiGGSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:19:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC1C4D154
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:19:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dn9so28560480ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wixbTUKGw6v/KYVrJD+0MJ30pPTbNQGpAShEP65D3hg=;
        b=PVPcvLv1jIUpAdYe6oWvatJBVJOeU/yylqB5WtMu1ZP3bVUm5EplsFPnweKXsxQnIY
         e6Iyx8mE+p6NadnH0IJUFuwiwrkB5e36rsAZEWR8uAL0FjCGYb4S8XVLjszaiaZldE2d
         blMaQXFuk3DWp2ZMbd8PBL0D+NZheb7vbq8zPpaP8TUoT8F8szSjPEu6PrjrqSNSbz0z
         p5zd0XcR4c9Cy+CtqZzYmEe8FFAZ+LZLR/qsD1LfnbKmOyGnJD1SVxBO6z95kLVFV/Jz
         GjcpoR85DbIr5WEM4lbpyLA0ErF2rGjPSoq3HZenNee8e6B9IjhCh83f++zz7tQq+rVf
         4zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wixbTUKGw6v/KYVrJD+0MJ30pPTbNQGpAShEP65D3hg=;
        b=4LuTxE/u6nSXoGjfPiSWnjR9Xh0EiBBdY3o30o5H0NMqpkCE+mD/fhxn4lBoj9hya4
         DEqyltHZHVT3nC1r+oRFIEeZ++HKvi8yXe/YTN4QkHv/L2XcOEd1T7HQj7DLH4aWe7xp
         VCPgWVozTuw+jOQFVREhK06mUGzaDFiPg3x3FRS8TmgHmo5WK89bY9iASiEgOW1g7KqQ
         U4w7u1bMVcSjIuglYSLB9XXBfd6lWF009d4N4AdvxgKfpxsh7Ne7R+P36os7NGyKEcE+
         GikJ0EI5jt5VANIgunOIfot3geAN0CDnsL2ouLVv4illSdbcBW2ZZHmhmEWsO4HpT5D/
         KfXA==
X-Gm-Message-State: AJIora972Lc9JMrezZtLgGlbXHt/cHYzbmJsh/10D5Ie9ifEpJC2isVu
        0pwc4qDFjoodHZ5WDFxKjLHbF9aQuG/AF811YGQVC4wL
X-Google-Smtp-Source: AGRyM1tz+cZU0wvekVWZnSjpNOKd6IRe391vbE3w6pk/lHxOoSQsqzJ5UYHw+IGIjq0dxCY18yL0h5hZp7gEWKpoXRw=
X-Received: by 2002:a17:907:75e1:b0:72a:ebee:5f61 with SMTP id
 jz1-20020a17090775e100b0072aebee5f61mr13952037ejc.171.1657217976438; Thu, 07
 Jul 2022 11:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220707125446.379104-1-sunliming@kylinos.cn>
In-Reply-To: <20220707125446.379104-1-sunliming@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Jul 2022 14:19:24 -0400
Message-ID: <CADnq5_NM3h1go3QhTzQq-sbYCYhoVLxwBbS0X0RmoEDQyzBGsw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove redundant header file references.
To:     sunliming <sunliming@kylinos.cn>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel test robot <yujie.liu@intel.com>,
        kelulanainsley@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

Thanks for the patch, but someone else beat you to it.

Alex

On Thu, Jul 7, 2022 at 9:05 AM sunliming <sunliming@kylinos.cn> wrote:
>
> Fixes the following includecheck warning:
>
> drivers/gpu/drm/amd/display/dc/os_types.h: drm/drm_print.h is included more than once.
>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/os_types.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
> index 795dd486b6d6..6b88ae14f1f9 100644
> --- a/drivers/gpu/drm/amd/display/dc/os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
> @@ -39,8 +39,6 @@
>  #include <drm/display/drm_dp_helper.h>
>  #include <drm/drm_print.h>
>
> -#include <drm/drm_print.h>
> -
>  #include "cgs_common.h"
>
>  #if defined(__BIG_ENDIAN) && !defined(BIGENDIAN_CPU)
> --
> 2.25.1
>
