Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84DB558185
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiFWRBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiFWQ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:57:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F358E3EA9B;
        Thu, 23 Jun 2022 09:53:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ge10so10810521ejb.7;
        Thu, 23 Jun 2022 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dB/YUbV33gsASlwt43eLvtTGgD7GHgvcm51jFsSmolg=;
        b=OLTlxLjQoiKVo4r81x0/z/I7oucCUFZni1cb0k5NlrcBRvxKWxjqv9rTthbcj93dOg
         eba4VzI94/Fy0biC52sVeAeRaY6XNZPGlAdBXPVC30RP2SqMUFR7huF1rGoq5ERK28u1
         jED+gu01s/HrlMFrbgoZP+gPNRwmpU0+V9d50RqLdhncoLtz32NP7+g6+hia3lTtQBNJ
         ZajluoYSjGZb3B9f8pBh0/p6kMnzNn0rRW+/AD9yd/+a7qNEtYNotgXb5Sh3w5Grj2gm
         UlH5g/aqt5DEJkVEyN4nT5zfOxm53uWJT9qJ5JETF+P9Zbvq+j7gfgd3NnEDicxXH9fI
         9brA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dB/YUbV33gsASlwt43eLvtTGgD7GHgvcm51jFsSmolg=;
        b=6lF6uF+lWzPrNlgWCTIjhuK5Qudghhlg8j4M8kykicg/ifoCc1KsQbzTzZxhHXBE82
         tcwfF3mapzmgISHO7zG+hpffcDvlsOccoK+d1+No3Pa7m8av9/KJZ3IWSedVRkz3zoUG
         GByDSfTRF7HRaasMPJNx5xAz5uLR+pCZKsDU6fRo2bTRotDHXLWVmZv25Svz/FsJm0aq
         UmglO8bK+bV06AeGcpOE3kDecTIkrwxQQv1coMr0jGVCojBwxZeBcN3SVb2TFi/F47iS
         GBcQjecJVNv4jbFObL8+9mezu5XXEPeYyjRxuykMLBCnNM0nW56vBjpdRb3FyAwHsAl0
         xLaA==
X-Gm-Message-State: AJIora9Kd+VrJ3DRN8SfI6l6E3D77Pv1bu/4lBuJ3fPmXA7hhpPBi/RA
        AHCyUePBWMQ0TQJBa8BiKB95DmErI56W3wi+8xw=
X-Google-Smtp-Source: AGRyM1v7UCi/dybJ7a8Hu2QcGEODPFGhdz3he6dGZwqW7M53CtDeoODvjoD1bZCwhJ+OPsCkP81b3cYZrPNQEbnMpX4=
X-Received: by 2002:a17:906:5253:b0:711:ee52:764e with SMTP id
 y19-20020a170906525300b00711ee52764emr8998144ejm.171.1656003189377; Thu, 23
 Jun 2022 09:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220623080946.19116-1-colin.i.king@gmail.com> <d3218391-de1f-d64d-bda7-0042473e9833@amd.com>
In-Reply-To: <d3218391-de1f-d64d-bda7-0042473e9833@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Jun 2022 12:52:57 -0400
Message-ID: <CADnq5_MiZvJdR43Ook1F359CtfSUq+aBWvOOfyv+1EKLGwK9ug@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu/display: Fix spelling mistake
 "supporing" -> "supporting"
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
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

On Thu, Jun 23, 2022 at 10:20 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2022-06-23 04:09, Colin Ian King wrote:
> > There is a spelling mistake in a dml_print message. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> > index 7f144adb1e36..7d536c2f4477 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> > @@ -1098,7 +1098,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
> >                               if (mode_lib->vba.ImmediateFlipRequirement[k] != dm_immediate_flip_not_required && v->ImmediateFlipSupportedForPipe[k] == false) {
> >                                       v->ImmediateFlipSupported = false;
> >  #ifdef __DML_VBA_DEBUG__
> > -                                     dml_print("DML::%s: Pipe %0d not supporing iflip\n", __func__, k);
> > +                                     dml_print("DML::%s: Pipe %0d not supporting iflip\n", __func__, k);
> >  #endif
> >                               }
> >                       }
>
