Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B400568E61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiGFPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiGFPyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:54:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBE7B49A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:53:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z41so19869998ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwbqnUpjiSN4hgfIC7ffIeFKyZvoDEGRDTZHu+A2QaQ=;
        b=ILrEVzPO9R1qY/womGdC0iB2h8cQstee4G6RPCy8IsBo5G+Oq1Ac4D3JEMDqXno5YZ
         rFglDoNwKgK5Ahs8bN0iXQY4O5xB27jjUnHkySSsL57Ii34QAArVmX3OQekHTkkSSiRB
         lDv7xx5uodVD6HJ2t6PVpYOHPl2h1WdPvty70Z6HrwMflqOXkgWnbVt8eI4WTxeM5L1+
         h6j7f0LJ8E2EwJPhDutzUUJMM+MwW9MLyJ4qwQhfTDR9UGXJn3it3H1kXzCocDtQlz8V
         EcrMmHqGrEZcZS5qLyv4QAPv8RvMVvgUYNGpB5zviOt1DErrU4n2KBj2EfHGsTOfRjfv
         8CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwbqnUpjiSN4hgfIC7ffIeFKyZvoDEGRDTZHu+A2QaQ=;
        b=N4WLOS0oINT36cJhWwbIv8jUrIBg7084wnfUIbDWs0fIyktXJZg00DVXurl76N7SGn
         26YQ64i8XPxAmj+y51LJtBgPr1Jcpsx+7xUsa5/ig99zaUmK7slisLq5icQHj49AWtlS
         AkAc1MBoa0SfXfX05F7VCgvADDPVQaR/2A9uWNK7X7G8/zQVh0pMB4M151VSF/p21wOE
         /6hPDoFUqHAWv+F3s8nmpqnRd/KCSsKRQX2fUrgHdg7LPbjzFFwVtauNPYqAwPSDo6f1
         qihXGqSray3MCnySva6Fkj/laoKkSkkdWalp6EdgBzYDZpb1eAgoSBocKff8VO5aInzy
         97Yw==
X-Gm-Message-State: AJIora804qwOP3VCVilvPTqgggkY9ApuEsuoj8njTcQSzgTclnvSvBdl
        y6M0h9tT2I52NetUktRDoYdoGAFmd7re0DeRtF4=
X-Google-Smtp-Source: AGRyM1uwT5QDUQoR6JIWgndHtR6Gp682jCxMwaMSkfBVcUtVDpJAybSMPRNGuI9Y7y3A8712mLoRkOZB/2rknVTIUzo=
X-Received: by 2002:a05:6402:380a:b0:437:d11f:b8b0 with SMTP id
 es10-20020a056402380a00b00437d11fb8b0mr55333549edb.425.1657122828767; Wed, 06
 Jul 2022 08:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220706091329.62192-1-guozhengkui@vivo.com> <5dc99a6e-569c-a736-9f64-ac632433da81@amd.com>
In-Reply-To: <5dc99a6e-569c-a736-9f64-ac632433da81@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Jul 2022 11:53:36 -0400
Message-ID: <CADnq5_NLkSzg9PA+JHoCi+0+vtkVrSctGs=RPTBeYrW7YbyTgQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove repeated includes
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Guo Zhengkui <guozhengkui@vivo.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jimmy Kizito <Jimmy.Kizito@amd.com>,
        "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhengkui_guo@outlook.com
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

On Wed, Jul 6, 2022 at 9:49 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-07-06 05:13, Guo Zhengkui wrote:
> > Remove a repeated "#include <drm/drm_print.h>"
> >
> > Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/os_types.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
> > index 795dd486b6d6..6b88ae14f1f9 100644
> > --- a/drivers/gpu/drm/amd/display/dc/os_types.h
> > +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
> > @@ -39,8 +39,6 @@
> >  #include <drm/display/drm_dp_helper.h>
> >  #include <drm/drm_print.h>
> >
> > -#include <drm/drm_print.h>
> > -
> >  #include "cgs_common.h"
> >
> >  #if defined(__BIG_ENDIAN) && !defined(BIGENDIAN_CPU)
>
