Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E8E514F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378254AbiD2PUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378247AbiD2PU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:20:27 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EAF60A95
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:17:04 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e67799d278so8403705fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xlZKMfXOWwYkt3Pm+HzAM1Ba+HT7GaPjlYqQGfMcvo=;
        b=QypqKKBFuHoePNg/EBj+EfIUoy30MRZiE5ofHJB3ajmDmt7aLSIf///QKFV+TmjsG1
         6W7hS0XYz13rWWuNGjI0rVJa/WJvSk8rv/aiosm5EkPKl6XlGRP2yF518uRwrKKxmVfj
         BAlMSbVMQGidrtbJ6DoPyT8WFZYacrKCq+nPWNmZEZArIIAbcjcGUkQTPW4rCfhAFuXw
         Lin7LneIYmI67eHrDAdZDL5L0VZegbdD2UIC541tzvcTy+adrBu9Aup366/cVsCRxXqu
         QjmILPHh42Mg3dD62YJELG8E6SFPHHwT118A6IhOZi3y9m7laKzqzwpYqFJZvQTTbF4q
         gTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xlZKMfXOWwYkt3Pm+HzAM1Ba+HT7GaPjlYqQGfMcvo=;
        b=YE64tcmZf0CpJy4vkMCsAQe0Gq4VJJPuAh6LTv2fiHIx2TUdT0Z0itJQzNPbpNiW3Q
         LPq+3hjD+2xomDsO0hqNcgJ+avgne0RbYUTM1hp+zFlOO2+jQ4foCt3xKMkkklqEpuus
         eVjZGImQDec9uN5F1nQbDpX9TpcCTNtYluRh9GqO0TlJ1PAgIc+pKahqB/vrhZDSlm+r
         kv49oW5wzwDWfL7DSFOkRUZqcdTVwYOQJkuluDpBS4JgVrFpnUwVfbfCusBgWNDe9yBV
         PcgEGZkFYHWztVddVbFa9iPIEqsXrvlfbAQiCDhC3dfM+jIf3xbGZAQDZfBKmkdBfXVL
         Y8ig==
X-Gm-Message-State: AOAM532rz0VLH7fG8IUPY0J3oSat60Uo3MAJJUkAohRt4x1YSveZ+ozH
        k7uYAUYqZw6ba0rQhO64VT3KRmBnfMZWctZI3MQ=
X-Google-Smtp-Source: ABdhPJylMMPfIHZM+tbLHh9jwNnT2hwrhUaVbJ09UCTwM3SA3vKZrfUm7HL45LOfRaIY9kbZUD2awJ1Ldcc6+oQYHMw=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr1480700oaa.200.1651245424273; Fri, 29
 Apr 2022 08:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220429054841.3851915-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220429054841.3851915-1-chi.minghao@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 29 Apr 2022 11:16:52 -0400
Message-ID: <CADnq5_Oo4KM+Jjiy8b+42UAP5PhaEMp76zS7gi3iRua2jTyUPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify the return expression of iceland_ih_hw_init
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>, Zeal Robot <zealci@zte.com.cn>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Minghao Chi <chi.minghao@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Apr 29, 2022 at 1:48 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Simplify the return expression.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> index ddfe4eaeea05..aecad530b10a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -308,14 +308,9 @@ static int iceland_ih_sw_fini(void *handle)
>
>  static int iceland_ih_hw_init(void *handle)
>  {
> -       int r;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       r = iceland_ih_irq_init(adev);
> -       if (r)
> -               return r;
> -
> -       return 0;
> +       return iceland_ih_irq_init(adev);
>  }
>
>  static int iceland_ih_hw_fini(void *handle)
> --
> 2.25.1
>
>
