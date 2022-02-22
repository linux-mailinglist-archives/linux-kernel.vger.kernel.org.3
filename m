Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262B64BFE88
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiBVQ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiBVQ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:28:11 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE93129BBB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:27:45 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 12so7074736oix.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wc0yqHfoagRsyXzdU2Y5/dAqtfWLM+jPqSQjyf20DAQ=;
        b=OHvXsiq6g3Rnm/ksDpKM0+8vS0aMDT5I0AZgHcAPddmSWj23yidnTLsiT5ki1k+pXC
         1p9cfzcgh6jCI28Jxy5mljhTRq8Z2cxKb4SM+a+RJa3Tmz+BA4IEosYgK1omDVW96b6w
         De7m1v1lUngpKTVZdoXCcVvmPiZ55am3YZIE5Gu09L7Hh/sVJ2f8JMI2cW5sni7V3eVs
         PLDdZlHkN2Tz/vPzC1rhAXKbr+uJD6LrNvLVoASYseP+j2wUmW1ADbLBvLoytPM+XP9q
         l7zb1W7wU69C+O3FHe3by/W1BzYzFpHV3NH0xOygMopJWD78LuX2GkmdNhGz4wUtX/hF
         /a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wc0yqHfoagRsyXzdU2Y5/dAqtfWLM+jPqSQjyf20DAQ=;
        b=4E1H+3pj+aAZayQccX+b/9EammRPC1PL+GKNZHg7neWXURjw5Xf7qBsgKVjRTdKxE9
         UzyUkHMPQ9OaBx/5rS93kwDFVDrmJG6YoBrFkv9I+bpY+32bzQhx3g6ZIGD/HzVkCNtE
         up1+mDlEOr5qEXfSsdUzKcK1TUqaCgVzDd5RzfaRO3JIEXrfDnXZRresHVt3WgH9+57j
         9W1L9HHZvb8ons9Z/qWe5LmV7JLUCQTyLKARzyTGoPZNNZifA0uEjcn0F422kQUsm1s9
         uzEgUkwcLyi4Lew6mb4gR9Aav1H9/OUSnmktOFhwYeL2oGbpCBAVHdcbDB0qayzfdu+7
         wfFA==
X-Gm-Message-State: AOAM5322baIk5wJi4rTNMSEkY/6uMe+Wua4W8/1CGn53F1oKnXhfJRIC
        cYozLVbbhDmvkZDAEd9gCAuofqiJ0Rxgt9IAoRY1OSAN
X-Google-Smtp-Source: ABdhPJzMY92Uod9CyBXvXvpyKVk0Yx2FnD1eNM4cD0ag4qAyG9Rjjzu0pW/fwzoshhVCCjQURT/oah1xCbxHxh0TvcA=
X-Received: by 2002:aca:ab4c:0:b0:2d4:7c7d:606e with SMTP id
 u73-20020acaab4c000000b002d47c7d606emr2360947oie.132.1645547265176; Tue, 22
 Feb 2022 08:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20220222131701.356117-1-maira.canal@usp.br> <20220222131701.356117-2-maira.canal@usp.br>
In-Reply-To: <20220222131701.356117-2-maira.canal@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Feb 2022 11:27:34 -0500
Message-ID: <CADnq5_M0yBD7oE+y-gcsKkSxP+CmYxx-pdzytG-Wpqv=hw=r-g@mail.gmail.com>
Subject: Re: [PATCH 01/10] drm/amdgpu: Change amdgpu_ras_block_late_init_default
 function scope
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        "Chai, Thomas" <YiPeng.Chai@amd.com>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        "Joshi, Mukul" <mukul.joshi@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, mwen@igalia.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Isabella Basso <isabbasso@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 22, 2022 at 8:17 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> Turn previously global function into a static function to avoid the
> following Clang warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2459:5: warning: no previous prot=
otype
> for function 'amdgpu_ras_block_late_init_default' [-Wmissing-prototypes]
> int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
>     ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2459:1: note: declare 'static' if=
 the
> function is not intended to be used outside of this translation unit
> int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
> ^
> static
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index e5874df3c9ca..dff5240efcc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2456,7 +2456,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device=
 *adev,
>         return r;
>  }
>
> -int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
> +static int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev=
,
>                          struct ras_common_if *ras_block)
>  {
>         return amdgpu_ras_block_late_init(adev, ras_block);
> --
> 2.35.1
>
