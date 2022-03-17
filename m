Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D04DCF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiCQUdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiCQUcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:32:51 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F4518A3CF;
        Thu, 17 Mar 2022 13:31:34 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 12so6803008oix.12;
        Thu, 17 Mar 2022 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4LhBNYnhdygc0CZZHH2ej2UF+qrm4ulwWEIxzmxAaw=;
        b=dar6Vs3kjGkCthhBYvhfxSifJx9V/Ldg9ALQfn/DAwU7An1VoKquqdZhbmS/6Yzub9
         QbqN6HXQaSgE3UTOC0oN+gejpLxQxIFQkHjs8hplnYWwKhvOvUAvtID/1WYMBW9s+t5h
         dTBX6BdaXctfugE6/4qMa0PCgBsKKIMaBFLkf334qEAK3CI2SunnI+cHHTIiE366YE7U
         taG1Hr1vOdFfqhube0rpis+ncHTP3XYWtFQIVMEcqqd4vGE0gXF8mOngvwLnnTHCxDFj
         mjihcCmduqABv7XB10XJxA/Sp8ahuxiqPMTgjGm81S3JHjZhWiNjjWLPcxXiV6NpukQY
         h3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4LhBNYnhdygc0CZZHH2ej2UF+qrm4ulwWEIxzmxAaw=;
        b=zvHQhz7ZHwVeHYyANoai3bkzYeRapJ3CR8xi8Q5fLEd/8NXZxeJ+OIs06VLfdkP/XY
         QC5Scwhw92KnX4pcX8InOW6uDNj0oUQlMxVZ+4QPiciUuq+IAU1DXL7mOkbnLIUoLCtX
         JwO+bF9fkxLN0jxn+y1xAYiVWPrDk4qY3tgBovWOp+g7l/7d8ZwYgOijwtd2hrxJMUuO
         x2BwUf0CrC2SSbB47Z3e66sKg0TOgK0Tb8BJ4jabYW9giDlxCGBPQn+tOYY27CN8nY+y
         ueISN4TIeGTKB5bHLceljr645FgRKmzlL/3zWXkxr3Xah/39Zp5QN3JNGJ91PiijpPXL
         eUjg==
X-Gm-Message-State: AOAM5301ZbFPeeEV++lnBSVSqGrNsUtBARMMBz6Xw15vjUz1c9eWkXU2
        lQtZVY+haY1oUYagZlvCpJstQr6GTc6GMMDCx78a15H6
X-Google-Smtp-Source: ABdhPJzfXLl6CjRpcz/xsIrozszoM9Zxzo1ZghzalC9LjaTSEVZBWPtjOkaOWTRLElQXRVjGKWPWZU4nF/4n3UlgxUM=
X-Received: by 2002:aca:d07:0:b0:2ec:eaaf:a036 with SMTP id
 7-20020aca0d07000000b002eceaafa036mr2865348oin.253.1647549094217; Thu, 17 Mar
 2022 13:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220315201959.2952327-1-colin.i.king@gmail.com>
In-Reply-To: <20220315201959.2952327-1-colin.i.king@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 17 Mar 2022 16:31:23 -0400
Message-ID: <CADnq5_PE-zWB9Cjw05Pby44G-uNG4t8i09Z92-f9O_QiPo+HfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix spelling mistake "regiser" -> "register"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
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

Alex

On Tue, Mar 15, 2022 at 4:20 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a dev_error error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index a025f080aa6a..9aa355a5ac3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -919,7 +919,7 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
>                                                 "wrong operation type, rlcg failed to program reg: 0x%05x\n", offset);
>                                 } else if (tmp & AMDGPU_RLCG_REG_NOT_IN_RANGE) {
>                                         dev_err(adev->dev,
> -                                               "regiser is not in range, rlcg failed to program reg: 0x%05x\n", offset);
> +                                               "register is not in range, rlcg failed to program reg: 0x%05x\n", offset);
>                                 } else {
>                                         dev_err(adev->dev,
>                                                 "unknown error type, rlcg failed to program reg: 0x%05x\n", offset);
> --
> 2.35.1
>
