Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AEB48AA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349268AbiAKJYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiAKJY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:24:27 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486EC06173F;
        Tue, 11 Jan 2022 01:24:27 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c6so43392402ybk.3;
        Tue, 11 Jan 2022 01:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cv3VWXBT1vzgw9fDSWsZVII7SUUK8DtKIhodYFlsIgk=;
        b=DVGodsGp+VSGl7PLbXH13orlTCsJpSeMcZG5duC7hgmBKdGMjygDHD2lgi2pgB0CEf
         C7fJUfCweIb1aY/Mb7vLCY9wjKClUB0MJ0Ijjfz4TPnUDX2eDCt4aeFTCTJGFYGKi8q/
         ISIDry3hXhQfA/SZnnW719Jloste+ehWznIrd5TISbbtj9uVVFwy2RJHNZgbOUbVX2hH
         y8vOMmbHaggPUUBcU+k7XULIxA5JuP7MzCUSJ3F3kvj549pNh0PAbkEwgjlisdYr/UTT
         +/2eybRR0P5mF1mA4pzNvBA3gj4gmmpUxdM7+BXG6FyF2nC9MiWyc+dbsSXZypM6PCxS
         6jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cv3VWXBT1vzgw9fDSWsZVII7SUUK8DtKIhodYFlsIgk=;
        b=SEMdA8Q9iV5gT4SS6gOr4I/TMvkoaO0AK1dIgQAtJgmrbr2bUQj8sJ/Hc0Qpb1AhSQ
         NSCCEpfkat8YnaAuVrfyV+6OS9Ed4wvC4rEreFGEHJzY7DlNKgjeAo0leU46GYJrCmy1
         AoPVWtAolbkhD3UNeDnACaWBWMkT5a8AEUwPkh3gCA1aFhcXouPOQe0apvXY4IABdnDa
         9IWJlOHjj9n6vu8GBYWFPweFbaIFAUClUBtVBJ9xZu8WuRenQGZ9/hzsG/vVFf8TPL/5
         LIoeff9pdEXeTbhJ+CTPrJ1JzFkwbDbz2C10Y6+i8E9ypbIeHIsWENSl/EYcnXX+T9dW
         pOKA==
X-Gm-Message-State: AOAM533tw/G85y/eq2pojHbpxl4yIrOBsA7YrcQImRvnDWmtsjz7ZvgE
        Yh46Mya2Yey9hANfcDjy2+LVhWK8i/dReNz9ew8=
X-Google-Smtp-Source: ABdhPJyJDd8TkgoLs5BNf/NvRNq5BIDjYbteoC9S6P4Tzqyj4XtaIIoEpJ8yq8xa7iX3muDvh7OWB7MhJjZG8rvt+h0=
X-Received: by 2002:a25:2cd0:: with SMTP id s199mr4858451ybs.234.1641893066617;
 Tue, 11 Jan 2022 01:24:26 -0800 (PST)
MIME-Version: 1.0
References: <20211224141213.27612-1-kevin3.tang@gmail.com> <20211224141213.27612-2-kevin3.tang@gmail.com>
In-Reply-To: <20211224141213.27612-2-kevin3.tang@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 11 Jan 2022 10:24:21 +0100
Message-ID: <CAKXUXMyXYcdWOTMMdUxXMYvBKiRor4LMtK-JgACo+iA8ogvqmw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/sprd: remove the selected DRM_KMS_CMA_HELPER
 in kconfig
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, sean@poorly.run,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, pony1.wu@gmail.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, zou_wei@huawei.com,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 3:12 PM Kevin Tang <kevin3.tang@gmail.com> wrote:
>
> On linux-next, commit 43531edd53f0 ("drm/sprd: add Unisoc's drm kms master") adds the config DRM_SPRD,
> which selects DRM_KMS_CMA_HELPER.
>

That this commit is _currently_ on linux-next is just a matter of the
current state. The commit message that goes into the project's history
should probably not state "on linux-next";
this information is probably outdated or of no interest to any further
future reader at the time of reading.

So, just drop "On linux-next". The commit 43531edd53f0 ("drm/sprd: add
Unisoc's drm kms master") will exist until the end of time.

> However, commit 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option") just removed the
> DRM_KMS_CMA_HELPER. So, the select DRM_KMS_CMA_HELPER refers to a non-existing kconfig symbol.
>

I would be happy about acknowledging my work of reporting with a
Reported-by tag, although I accidently send the report only to you
without cc-ing the mailing lists.

Please add:
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

That said you may also add a Reviewed-by tag now:
Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>


Lukas

> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  drivers/gpu/drm/sprd/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sprd/Kconfig b/drivers/gpu/drm/sprd/Kconfig
> index 3edeaeca0..9a9c7ebfc 100644
> --- a/drivers/gpu/drm/sprd/Kconfig
> +++ b/drivers/gpu/drm/sprd/Kconfig
> @@ -3,7 +3,6 @@ config DRM_SPRD
>         depends on ARCH_SPRD || COMPILE_TEST
>         depends on DRM && OF
>         select DRM_GEM_CMA_HELPER
> -       select DRM_KMS_CMA_HELPER
>         select DRM_KMS_HELPER
>         select DRM_MIPI_DSI
>         select VIDEOMODE_HELPERS
> --
> 2.29.0
>
