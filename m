Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED3D4A0059
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350626AbiA1SvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiA1Su7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:50:59 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C39C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:50:59 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id q19-20020a056830441300b0059a54d66106so6663948otv.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKX9pAz2N6f1LeV5jE9JpWncxYcfxVHZaRugBIOPKbo=;
        b=JtN7o50xVFQqlIL781UZBwe/EcDEfw8NHpccQlecEyj0wdpmnCb1zGecF/++5xnfMd
         F5ewgBhpYWA7EE1CdbXoz/tt1SrKQSxiwzFdisFm0+t5cF4rI4O8rdxr2JEu4AY7bqcc
         aUHDzqeQCIpziYIE8mPOYNzEo7ATgYzz0JAKl8hSM2CWD17lLcEHpktsFNbgem3tQRYR
         N92AH6vAJfpjvF37rqJaLSbIvpzvWxjpkuPG1Umen3AVtFyoBCwxarMUFv6w2P7mgQlQ
         +WhvsBX8ujfWZi2ogq0C8IHDx4Bde7mPn+l6c2CE1//imvnKK25t3TW1OUrJndUMuaVX
         7UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKX9pAz2N6f1LeV5jE9JpWncxYcfxVHZaRugBIOPKbo=;
        b=29larDqrrOPB1EghGJPXXyOr4h3LI+1y7gGnnLlWv11Y5fU8EfEQQgy41fbGhJAetf
         e48u7XG/WPJr+VZN7NfiN3OZoroZYabgyJxrPlwYtPjvkohrQCJv/nZZnfJieDzhn//D
         KRZ4sM4tjoDWtGem25eK0OqIawRFDk3yTf2pa/6EpG4RKjBCsas9W7S6UgBnvrYTRNbE
         anXPlHzLBCbmCH/cNV58STrCqs9wD6SxFG4WmH1LsSXsjNIRDjrQPHIuTkZMqFpkJL+y
         WlBzQU1Q+Eq8Vi6aQbmiXIHuxY0/nn6iXdplIlzMzt/vM+2baxeOZIFdoo4PRPj1b2mE
         lN+A==
X-Gm-Message-State: AOAM5326ViIVjmb4B2kuCrHUGokKwQsAFmEmfiKgxLwqaSig/SvyaeKq
        IgqvcSQlGg8KYpWQMEmLPZMWBhYFWo1otigDL30=
X-Google-Smtp-Source: ABdhPJw5/vywGryf/EN4HvDyYic34Z2ylrPo+NRS3fcU525WNAQVjajsZilknfkCeEONCcJK9pI7KZhvlzNa3DWjl2s=
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr5524190oth.357.1643395857180;
 Fri, 28 Jan 2022 10:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20220128071936.1210682-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20220128071936.1210682-1-deng.changcheng@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 28 Jan 2022 13:50:46 -0500
Message-ID: <CADnq5_NMAEvgRKM864Vf+xsLuui8+gr_a6r2jViXYX6B5RGh_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: remove duplicate include in 'arcturus_ppt.c'
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Quan, Evan" <evan.quan@amd.com>,
        "Lazar, Lijo" <lijo.lazar@amd.com>,
        "Chen, Guchun" <guchun.chen@amd.com>,
        Dave Airlie <airlied@linux.ie>, Zeal Robot <zealci@zte.com.cn>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Powell, Darren" <darren.powell@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        "Nieto, David M" <david.nieto@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Fri, Jan 28, 2022 at 2:19 AM <cgel.zte@gmail.com> wrote:
>
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> 'amdgpu_dpm.h' included in 'arcturus_ppt.c' is duplicated.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index ee296441c5bc..709c32063ef7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -46,7 +46,6 @@
>  #include <linux/pci.h>
>  #include "amdgpu_ras.h"
>  #include "smu_cmn.h"
> -#include "amdgpu_dpm.h"
>
>  /*
>   * DO NOT use these for err/warn/info/debug messages.
> --
> 2.25.1
>
