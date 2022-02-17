Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3791D4BA6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiBQRRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:17:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243632AbiBQRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:17:36 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8CE15C9E0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:17:22 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 13so281230oiz.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9zgQPfz8LOJwvyN9TkCqdRl9MbRaNDX/aR5wunJ990=;
        b=DINAnzkZ3yxrbaFtDAYZmhpuXrR/mzBHe+vr2DEiBG3ftwzLyGNCDwNo0aWdundMlY
         sYYPRo2ua/mUlkwsglmxpqxr04T8gzaIFbZPVILJZWFtt6KG8gOjF3ltKVAs7NB4Ll5A
         EYztNyGCg/NYX3KCvFPleeQ8mjTULOIut+sofWlAJbUmSJoGUrcL1hBg30XDPTzG2P4w
         UWMCShLbWEJwlle7OziBionFS3Twi3vfDUcs+1sPf0IUcWblXibpCNNarLcSJGdhlNIm
         72+weM6Yxvsi1mB0VDx+GRhGhoxE3g+vEl5TjBcOqh2X+IF/XQmtQZkwcqnFb9FB84W5
         fZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9zgQPfz8LOJwvyN9TkCqdRl9MbRaNDX/aR5wunJ990=;
        b=m7/zfREmn0REqbuf1m6lRjyrYZ+TK+nubEwDEusHDNTF2jOmAclDIXfCmFaRUqHORe
         XjG+BPQbBXjHTTNJDdoZ95CQSeE0O/ki856a6VyvvDr1d2cQeTpI3I3QLblK837CGpnC
         Wxk13ibCI86rMnsj7TRZ9rIn++/++DxAbFZBY2SRfW45qTcPnI+B/NtUhJx1JYqrraSG
         ZRR/LbJsxXzetnd/xjapvUBHX4GaOoiOSoQ4eNB+DGNIhxkC0RHvmeNMufmvz/giAepe
         K4oycRrGYDLLQJhZMWR4tBQACAcOawqpvg4LDkm3MepdYcLYIKwUwDnxbzcWj239eMCY
         rcLA==
X-Gm-Message-State: AOAM531efRAa6574YxHmdIZWpBJmaq2CMl9r+EnW7iPt3ad+in99AfuB
        Y1x/+ewj1C8mC3S5LwkhXDmfnIBJD2ZCb18BdPE=
X-Google-Smtp-Source: ABdhPJw6jj/QGKAkol2tdthTwTYyyoP4CDqrp37TKDAO46tPjdL6fNFaDwTVUFznUtAy4H33vyaax1MFxyQNLygI+KE=
X-Received: by 2002:a05:6808:f8b:b0:2ce:6ee7:2c99 with SMTP id
 o11-20020a0568080f8b00b002ce6ee72c99mr3309777oiw.199.1645118241433; Thu, 17
 Feb 2022 09:17:21 -0800 (PST)
MIME-Version: 1.0
References: <20220217164110.3258269-1-trix@redhat.com>
In-Reply-To: <20220217164110.3258269-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 17 Feb 2022 12:17:10 -0500
Message-ID: <CADnq5_OasHZ=P_tkZrSSA87HACHJhQ49oMGSdFxzQ5g7GhjWMw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix typo in setting enum value
To:     Tom Rix <trix@redhat.com>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kim, Jonathan" <jonathan.kim@amd.com>, llvm@lists.linux.dev,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
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

Nathan just sent out the same patch and I already applied it.  Thanks!

Alex

On Thu, Feb 17, 2022 at 11:41 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang build fails with
> kfd_packet_manager_v9.c:267:3: error: implicit conversion
>   from enumeration type 'enum mes_map_queues_extended_engine_sel_enum'
>   to different enumeration type
>   'enum mes_unmap_queues_extended_engine_sel_enum'
>    extended_engine_sel__mes_map_queues__sdma0_to_7_sel :
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This looks like a typo, the function is _unmap_, the enum
> extended_engine_sel__mes_map_queues__sdma0_to_7_sel  is _map_.
> To match the packet->bitfields2.extended_engine_set type
> it should be extended_engine_sel__mes_unmap_queues__sdma0_to_7_sel.
>
> Fixes: 009e9a158505 ("drm/amdkfd: navi2x requires extended engines to map and unmap sdma queues")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 806a03566a24..18250845a989 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -264,7 +264,7 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>                                         sizeof(struct pm4_mes_unmap_queues));
>
>         packet->bitfields2.extended_engine_sel = pm_use_ext_eng(pm->dqm->dev) ?
> -               extended_engine_sel__mes_map_queues__sdma0_to_7_sel :
> +               extended_engine_sel__mes_unmap_queues__sdma0_to_7_sel :
>                 extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
>
>         packet->bitfields2.engine_sel =
> --
> 2.26.3
>
