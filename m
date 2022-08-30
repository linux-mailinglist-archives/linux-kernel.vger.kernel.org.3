Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E948A5A6DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiH3T4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiH3T4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:56:18 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212926F573
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:56:17 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so19316192fac.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lBTUT+GVdBiQUCihY+/A5rUw5kNVJzfY/JeA/pnXpEs=;
        b=DgaiEVgslI7e0eGNfIOS5Vp94gC4G2BU9LxhMOe3TchCkRG9cnOj/FnEXjayigu4DL
         ZdJT3HDemNCb6dFTR+Uz6SDQKuyibPwDoc2ASmRiEIHgYZ/t1BO+gcFIgzpofiPzdUxp
         24XMiwCeGU4GTiAbSQSjQegzHgkTPhU6Fb9GmYrR8/Fsc6rLlh9B/Z/XoGAbJIbtBSAE
         TyV3oDVj/nlrUGPA8NnKCmErrGWQ5+11J016FaTWPPPkxHmNnv5mIb+K1DvflSgH3Txc
         d/ev4tICWkHSxrtFUIyNgioJWSzu32zFuDZBtdPrXaKL/5yq5eBlAPC6fg1lLCYt+jV8
         pvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lBTUT+GVdBiQUCihY+/A5rUw5kNVJzfY/JeA/pnXpEs=;
        b=mMhTdAk8uyUHTGZTn0MmPJg9BFw9Oqzv5gH1G0fSx/bTEI0E6SnqN6wvcdC60x0sgb
         VSqjn6ycqQ45JR5h1BQO9O9Yn9T45nSffJ5EmfBuJ9u5vl4uIXMbTdScgOqOTtX5OEg4
         GBY1KlK8gLVwIJS45Y489eRM676ifZjZ7AvqV59E0NgDtY66PzaSI4hVTUu3C+pQ4ROm
         RYR4N4VGAiYlvEadOrBPfr4JysPvSX7w36aDgJUPta6kbmft2I+Rt/yn5QCQcZxY2zok
         5suaLvuzhlW72t7MJ+rjjd4eA7/XcGSQcudQ7lrHy/CSvVKBBkPtQgn/mqmODmrN1ucE
         N4eA==
X-Gm-Message-State: ACgBeo0QhJ/ZbS8rSXYpPm3whbphUqhRBJ+IFxEcFZgbsLt2knvGh0Po
        v3y3LiyK43yrjGwj53P4jbIcbFBmuQrpiIqUlt4=
X-Google-Smtp-Source: AA6agR641haMjojLY/HZV4ZaOM/8iZ69AXdkLv8EK6YA7hL7dCZBvYc4kpbe7afMxtyK/FXR/v6fZTgZQKPGSv0CkCk=
X-Received: by 2002:a05:6808:2187:b0:344:eccd:3fc5 with SMTP id
 be7-20020a056808218700b00344eccd3fc5mr10666398oib.46.1661889376533; Tue, 30
 Aug 2022 12:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220830083243.276646-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220830083243.276646-1-ye.xingchen@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 30 Aug 2022 15:56:05 -0400
Message-ID: <CADnq5_OhFNSLus1-=NxgePEvJhUu3pxgtwZZA6LOvO9QngCCvg@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amdgpu: Remove the unneeded result
 variable 'r'
To:     cgel.zte@gmail.com
Cc:     alexander.deucher@amd.com, Jack.Xiao@amd.com, tao.zhou1@amd.com,
        airlied@linux.ie, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        rajib.mahapatra@amd.com, YiPeng.Chai@amd.com,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Hawking.Zhang@amd.com
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

On Tue, Aug 30, 2022 at 4:32 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value sdma_v4_0_start() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 65181efba50e..0cf9d3b486b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2002,7 +2002,6 @@ static int sdma_v4_0_sw_fini(void *handle)
>
>  static int sdma_v4_0_hw_init(void *handle)
>  {
> -       int r;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         if (adev->flags & AMD_IS_APU)
> @@ -2011,9 +2010,7 @@ static int sdma_v4_0_hw_init(void *handle)
>         if (!amdgpu_sriov_vf(adev))
>                 sdma_v4_0_init_golden_registers(adev);
>
> -       r = sdma_v4_0_start(adev);
> -
> -       return r;
> +       return sdma_v4_0_start(adev);
>  }
>
>  static int sdma_v4_0_hw_fini(void *handle)
> --
> 2.25.1
