Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF684A0052
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350643AbiA1Srl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiA1Srg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:47:36 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC77C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:47:36 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id b186so7808296oif.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eEjXoPAEz8WirABSDqS1VUwttblJowoR0W8TU5D2lVM=;
        b=KFRzjl5NTJdsPdkPMCDpbIuJjDHgQwM51Fs65bDH+tfGTW9KIaOqhdT5kG2e/5yRM6
         NArO4NpAK/BjldFJSm9O9IXDgCedtUpqaYjm7eRusR5xsmmq+08nP1KxL5757ynFlsDB
         xEcz9SSXcUPJwbN9PTuxoD87NTqsS4L7VKtcnvKbS21RqIvXcGiyX8oT4lpUCfG1h1tJ
         yxZu4nYQfbxv4wMay7gKh/sxgDsZbd2qp3TbtsmPh/OgpTKlsJuqlpKGibEKqF6tFS4r
         N/f4aEaRTx8eP5qY+zVag2yeH15isrxZeIK7YMYLLqZjr5B7PWbnODYOn3gT/F7rxArm
         V8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEjXoPAEz8WirABSDqS1VUwttblJowoR0W8TU5D2lVM=;
        b=6uriLgXUcVeMickqqkJHnVQtGe1t+/Pn2c7c76N33gWOr5J2v7PbLA6m+LtM3twXFn
         eF60Q18LQoVGo4iIBnXY2bha+I0CG9suuT2RveZNAju7qFHruP5sdEMMm8wyeJM0HHdf
         y5u3h0dMpLXGYd0sk+oTvcFyQgU+ZxvAgK34xIYUF1Zj+vsxvEtuDr4jUQELt43sSfEe
         7vji4h7UmBt88ycnepVYZfxi/+LwNmuk5r/egz6hvzZrKrEEmzOYLRjJ7uRBZHzIZT7q
         mMGDcPrjT4BKPEjH2KzJ/8qWkAp02dQjOSlaPR77rqp/wPn9Rp1Gl9W5ADhlBWDEoc5A
         mkEw==
X-Gm-Message-State: AOAM531vgPsYZpoP0pfHpNsnlzWDmfLhWxw4G6N0fBuIvU331ChH5k/2
        jSlRGCm3kKAujseNr+IGhrx0MZ53w8KCQU049/k=
X-Google-Smtp-Source: ABdhPJwM9t2ruoxdGjT3rJNiqxAPK3A1fVDMMJuvwY5Biz08JHaqoxdPUhurTw22ug6GZxDVXG4WGx9bVPOZ/vIhhGA=
X-Received: by 2002:a54:4e94:: with SMTP id c20mr6267113oiy.132.1643395655765;
 Fri, 28 Jan 2022 10:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20220128070519.1210105-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20220128070519.1210105-1-deng.changcheng@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 28 Jan 2022 13:47:24 -0500
Message-ID: <CADnq5_O_RyzKDfaFE9zbEWgioAfoczDgWFtd9qBb5vwWLS9Enw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove duplicate include in 'amdgpu_device.c'
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Jack Zhang <Jack.Zhang1@amd.com>,
        "Lazar, Lijo" <lijo.lazar@amd.com>, Dave Airlie <airlied@linux.ie>,
        Zeal Robot <zealci@zte.com.cn>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Shaoyun Liu <shaoyun.liu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Quan, Evan" <evan.quan@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Jan 28, 2022 at 2:05 AM <cgel.zte@gmail.com> wrote:
>
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> 'linux/pci.h' included in 'amdgpu_device.c' is duplicated.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index dd5979098e63..289c5c626324 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -56,7 +56,6 @@
>  #include "soc15.h"
>  #include "nv.h"
>  #include "bif/bif_4_1_d.h"
> -#include <linux/pci.h>
>  #include <linux/firmware.h>
>  #include "amdgpu_vf_error.h"
>
> --
> 2.25.1
>
