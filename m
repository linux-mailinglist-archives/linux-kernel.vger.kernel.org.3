Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C7B48DDAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiAMS2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiAMS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:28:48 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64431C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:28:48 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id b15-20020a4a9bcf000000b002dc83a61053so1867994ook.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TwN0a2e4fIau6wBUpvIJm3eDy35/hH3kfFq237STDTg=;
        b=Eo4f+XqQO6PfJPSSqW2tSlTO+bRvdY2DWl5E4hlUWBNYozRCiG46dnKf2MRfymBvJu
         Ir1G0f5s7s7dTXTPQtgXa3O5FN6Fg7On50G+Z95IWyTtg/+gst9e6dmnyW8lhn1l/DzH
         AZW0cyu7C2BhkSCJnXh8HigIZKwMZvsA5rJfd9vgoQsbg3cU01usNRYYDFRyGeub7dAA
         Iwcv5eg313Ri064koctKwGHbKotc7aqlBMp3NQaLE6IVkEewwM3ucSQfrgJt7SisylnB
         nao6PvI75BXgKhTOvyQzUwXdFQgWSuIz/2aaSYgt4Rr1R8tllWCodVYyLEaZJQRo87h3
         /Anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TwN0a2e4fIau6wBUpvIJm3eDy35/hH3kfFq237STDTg=;
        b=Bq92b8bw3I6xU9KV8YEGnYqx24nPsKr2vU5jNueTCBZl6pnhIxJdmhgrW552LcxI7R
         RnvCKFnOm20E66YJOTKLZ3nC4w3wQmjbt+x7VGibsTjo+kfzCj4iT5+W7uZuPyrCYWcY
         o7zPVtH1Ar4nJIHJWzGOmDKIpOXic2mVXnNf/E64pmBDjp98/0yyMgZOjeSC4bVpnH9q
         spEO+4fsqfdK6Q0ftfXZlaaXmRzu52sRciB6xmSjhqeYcP+Ey1ppZJiMRtfZrfPbR1xP
         kA4zidrpO/Y/s2/hQSityE99MKiF7N+be4QxIfCqHaxyw9wEOx4C+3sqR+asiilodJjn
         mFvA==
X-Gm-Message-State: AOAM530WJrmGErdF10r/a+IWpmt2eC2nLZoJND/CUTjXlfBbyIvoM8fz
        xB0pCaIB72NnE3eVjH7Hu9qvUwbnBMVrpDuJINvJAdoM
X-Google-Smtp-Source: ABdhPJzWbHC/EWrSaiSqufm7TdYhQCSUNjjs/NfiCg4SoYTWgvaJ/P4DJQy1crUNBRQRIEFqdx5lQk5BQxYKmV2vMsE=
X-Received: by 2002:a4a:3412:: with SMTP id b18mr3729013ooa.23.1642098527456;
 Thu, 13 Jan 2022 10:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20220113071132.70647-1-yang.lee@linux.alibaba.com> <DM5PR12MB246922D4EC5729F76E481CD2F1539@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB246922D4EC5729F76E481CD2F1539@DM5PR12MB2469.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 13 Jan 2022 13:28:36 -0500
Message-ID: <CADnq5_NKKOjJCoi3qCBUGpy+HWgcUnVniSmRnMBfQ6V504Hemg@mail.gmail.com>
Subject: Re: [PATCH -next 1/2 v2] drm/amdgpu: remove unneeded semicolon
To:     "Chen, Guchun" <Guchun.Chen@amd.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jan 13, 2022 at 8:38 AM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
> Series is:
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Yang Li <yang.lee@linux.alibaba.com>
> Sent: Thursday, January 13, 2022 3:12 PM
> To: airlied@linux.ie; Chen, Guchun <Guchun.Chen@amd.com>
> Cc: daniel@ffwll.ch; Deucher, Alexander <Alexander.Deucher@amd.com>; Koen=
ig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;=
 amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kern=
el@vger.kernel.org; Yang Li <yang.lee@linux.alibaba.com>; Abaci Robot <abac=
i@linux.alibaba.com>
> Subject: [PATCH -next 1/2 v2] drm/amdgpu: remove unneeded semicolon
>
> Eliminate the following coccicheck warning:
> ./drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2725:16-17: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index d4d9b9ea8bbd..ff9bd5a844fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2722,7 +2722,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct am=
dgpu_device *adev)  int amdgpu_ras_set_context(struct amdgpu_device *adev, =
struct amdgpu_ras* ras_con)  {
>         if (!adev)
> -       return -EINVAL;;
> +               return -EINVAL;
>
>         adev->psp.ras_context.ras =3D ras_con;
>         return 0;
> --
> 2.20.1.7.g153144c
>
