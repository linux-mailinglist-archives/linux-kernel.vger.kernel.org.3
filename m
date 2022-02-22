Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B314BFE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiBVQcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiBVQb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:31:58 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8406C6266
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:31:32 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id p206-20020a4a2fd7000000b0031bfec11983so18276863oop.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dtYXm2hT3lcm5wvRcUbNMDyXlIE45DADQhitf3Rlc88=;
        b=LLMAhUgwrk/DYdWw6wgJuwrPS/o2NfgI10xeypJfrum8mmbBBX7d3r55885xcA0GSs
         N/0qnhPz6EDwjfCDK9EZLNApIQzBOjUAMTbhqcUrBws8r9XcYI+ZsjrQ1ackTdFYnXca
         KSe0mNO3CmeSvS7ItohT2P9sU7Dj+jbiFaynHZLO0MRk1EWBfi4n3U+MDt0xN/KgkRbR
         PUNRwRCH7/I5NqRt3zdTxI5yt4hkikKqm97sSwd5jrXi84dTOOy6v7mgYho9MtQZxmcW
         QzXsp71CoMubPYHdfyu53sEstrFfcN6QNLP2z/JN+YpWcau4FD4aw1cQMev20HollGSz
         gEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dtYXm2hT3lcm5wvRcUbNMDyXlIE45DADQhitf3Rlc88=;
        b=AxD7P8Us1RDgjZ2bJ0k7dEIx7GY2dJE8oPP/MIdQfdUFM5UKzjNCR1gFHtLZRF+jGH
         QXgFqhzZPsSox/d1S8tLLqVxpZDr7Ibg34jnJKQ3nZ9VoUj9ysX883FRWfviD0R2+nKa
         4VMcYEieGwvy+UY8o4rYBondwkXLef8DxWRTrsqTMJq7Zx+N18m5jtlvEGKceWfAcv8g
         iTy5yZwbtdNbNcizn6X7W+JgvhFSwg2ABvC3or9VZaWVKp96ORwFyxvSlfq1WPbeRLGK
         0u9Ci9766W6jn5sZUxwqIjYh515kmIbZMWm/g9rIGq6BE2WfPoaIFkCqhykXAErWaG/e
         3+dA==
X-Gm-Message-State: AOAM530hLVWF8EKuxmyn2p0KVxYgMaw8sOkHaVY1YEl7paCzGNkMOvLK
        OvPfeLdjeTmT0WmA2X1SZQyam1mZg66BPZf08/A=
X-Google-Smtp-Source: ABdhPJwfj6FZ41K/ClOtZcMS0gc0gQWKuRYKXqqfYle6jHWNbXIrWRxGaQ1cQvTxxQ6ZhiRII8f7GBeUIdvBRT/zdf8=
X-Received: by 2002:a05:6870:3e0d:b0:d3:fe6d:57c3 with SMTP id
 lk13-20020a0568703e0d00b000d3fe6d57c3mr2020968oab.225.1645547491928; Tue, 22
 Feb 2022 08:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20220222131701.356117-1-maira.canal@usp.br> <20220222131701.356117-5-maira.canal@usp.br>
In-Reply-To: <20220222131701.356117-5-maira.canal@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Feb 2022 11:31:20 -0500
Message-ID: <CADnq5_NSMvOUuLo936pbs+J7ajMCn3zDV5knYQo5t1f94KYW-w@mail.gmail.com>
Subject: Re: [PATCH 04/10] drm/amd/display: Remove unused temp variable
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

Alex

On Tue, Feb 22, 2022 at 8:18 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> Remove unused temp variable from the dmub_rb_flush_pending function by
> using arithmetic to remove the loop.
>
> The -Wunused-but-set-variable warning was pointed out by Clang with the
> following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:12: warnin=
g:
> variable 'temp' set but not used [-Wunused-but-set-variable]
>     uint64_t temp;
>              ^
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gp=
u/drm/amd/display/dmub/inc/dmub_cmd.h
> index fb01ff49e655..d3088836d4e4 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -2918,11 +2918,8 @@ static inline void dmub_rb_flush_pending(const str=
uct dmub_rb *rb)
>         while (rptr !=3D wptr) {
>                 uint64_t volatile *data =3D (uint64_t volatile *)((uint8_=
t *)(rb->base_address) + rptr);
>                 //uint64_t volatile *p =3D (uint64_t volatile *)data;
> -               uint64_t temp;
> -               uint8_t i;
>
> -               for (i =3D 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i+=
+)
> -                       temp =3D *data++;
> +               *data +=3D DMUB_RB_CMD_SIZE / sizeof(uint64_t);
>
>                 rptr +=3D DMUB_RB_CMD_SIZE;
>                 if (rptr >=3D rb->capacity)
> --
> 2.35.1
>
