Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E125A308D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344881AbiHZUig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243095AbiHZUid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:38:33 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC74C3F6D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:38:32 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w197so3360310oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5mncRjzin9wlcZNDsEO172TV0Ul8tMZirzBBF90PHYg=;
        b=gG4Knf/gdXVho0oGA/THgGs9YZMmPwAcRCZ9+8qInlAXXKSPV9AiMhXXcHykPvGmNe
         u5ZC9B5lRxzTzTJ+isXDbsWquIYxI8Vj9eq1tlgv9HUApBJnv1oUDyGtjSxrNuENa4OF
         CbscbARS9Vbnx5Tw+NmrSQ9y7il04f8AiKAHpdRzfAhQMrFo9NWKFj6GYZTvwNHRZw8+
         jtyJ/SW/NXIb2kqxs5PHohVlhx6hYF8GxUe2x+tKXPJ5IYTsUj17pihXOh4X/ZJRfe64
         pr3HUm3ntM8le3VxJfgxtGf8l+N7Ks8AgpG5DBpyRlw9KIufMZ1Oh+mutvcKlcZC32IK
         qrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5mncRjzin9wlcZNDsEO172TV0Ul8tMZirzBBF90PHYg=;
        b=Oe5RMBK3PWehGIR7XcmS2jTeufV7emD/6vt7xls0ytVE4vxWSIrtrnYPY41Xg5OQ+N
         CTJ+tBRLGnMB0ghcaGOd3I4dWlrV/zXT7Tn+hk3TkpqIHpnzh640K4dOPrZ6NTg01O+z
         nJaukhOBSTlY0cuLbyL7SUIijxRziuStcN6rwoQVOXcuoe8JSSV/NhtIktkqsMbFUncG
         U8QzqWBKdkZ7apjhxUjlKSOB429g40nl3951pBGBptjyrenBbJxLgtyPtqBdAyEFT6EX
         CtIyRVkqtXirgnotIKo6Mc1atvK5XsjVy/cTNb05tji/qe/mCPtvfAMNBt3xcQDoknKi
         ANzQ==
X-Gm-Message-State: ACgBeo3gUCwGMsx2TTnBuZCLynQooQa3zMjcq6nacBpjZi7XgIDhgJU3
        wJ8oHv/WZ4x1XQKIMgoOreXLSSZJhfj57vw/2ng=
X-Google-Smtp-Source: AA6agR6KadgKBn2RwRHJWrGBEuHgLqVDS6sb61DxTyadIWpwUClXCmOiYv8ghycHEYa/4ConkgAgjXz0ApLVT5ZeDbQ=
X-Received: by 2002:a05:6808:138e:b0:345:13d1:fd66 with SMTP id
 c14-20020a056808138e00b0034513d1fd66mr2405135oiw.96.1661546312148; Fri, 26
 Aug 2022 13:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220826072357.252676-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220826072357.252676-1-ye.xingchen@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 26 Aug 2022 16:38:20 -0400
Message-ID: <CADnq5_N+q9=oEYwiYxwRRgYeSfp+XaCxs6fwj9iFJsKhJOL2Tg@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amdgpu: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     alexander.deucher@amd.com, Jack.Xiao@amd.com, guchun.chen@amd.com,
        airlied@linux.ie, Bokun.Zhang@amd.com,
        Zeal Robot <zealci@zte.com.cn>, Xinhui.Pan@amd.com,
        ricetons@gmail.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Prike.Liang@amd.com,
        dri-devel@lists.freedesktop.org,
        ye xingchen <ye.xingchen@zte.com.cn>, christian.koenig@amd.com,
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

On Fri, Aug 26, 2022 at 3:24 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value sdma_v5_2_start() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 83c6ccaaa9e4..95689ef4be10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1413,12 +1413,9 @@ static int sdma_v5_2_sw_fini(void *handle)
>
>  static int sdma_v5_2_hw_init(void *handle)
>  {
> -       int r;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       r = sdma_v5_2_start(adev);
> -
> -       return r;
> +       return sdma_v5_2_start(adev);
>  }
>
>  static int sdma_v5_2_hw_fini(void *handle)
> --
> 2.25.1
