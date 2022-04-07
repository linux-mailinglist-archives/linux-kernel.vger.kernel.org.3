Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB534F863F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbiDGRcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346477AbiDGRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:31:51 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B6A25EA7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:28:46 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-df02f7e2c9so7074636fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1N3e7+zBRerbyIy8I0yBbprV6Ezo9J/qMAppeug0poA=;
        b=iJFfJWlP1IpPeuhNJIFwGsz63887gCyYlNl+4Ef0qLDWZtU/raTSE+MNYheRNV+JnY
         yimrBpVOYAIdG0Xbch/hnOqiwt+0iS99NPllE69BKl/YTW1JMVZ4zYmx4fQmX/hEsUyF
         EeUFpDdJaH4Zl1ZMa5kFnP5iMnbbzLIX2H30k5WRkYKowowr0gk5+xCeSoeg7ykvxNta
         I2T4pNXiJc+bhsmqkp3DUvtelKbR7olrNeP6evMKB1C23Mkr8DQJfr0eWmpP03MFJgAW
         We+3HBF38Vg2n2CUdXWKEOrn6PsavngN3sPxHI5z6w2tjw4CGOZpX+OuR8Vtpmp7NiNU
         v1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1N3e7+zBRerbyIy8I0yBbprV6Ezo9J/qMAppeug0poA=;
        b=PnH0bOj/s/9jRZxrsERqZbFdoXyAVDD0lqB5tovHUzdBkMplPxbTgAduomiSKrMcX8
         +Unti10QK5LF32Gunp6k2X16TieOiFLcIgq9nDz+Mzje6Fg6jv8CwFCuusBpzswP9W0V
         5UnOfA31me0BETMGqOtJVUv8PzTbJrVToyQfH3l6AgPaHnGsqMd0/29lCne+nclec8xd
         gU/hbeOyFq0vcgmv/s2tn9Ayj7khh2LpRAllCxOggTKnLhJusigtHBcy1GayuxM3BF/8
         a1VqDD3H9F08tQhh0VhyvrHevs0htcEPYvCWxEmaM44UXns4+clnPnUenYpiMPy4LaK4
         HoUQ==
X-Gm-Message-State: AOAM533nwMoezbbZs3sdWg+RhjqdKxPxnbNTIFns5EIblM9j6ggocTyA
        mpGa+hjFmtVWrjgHNRNVOiZhrlJEUpaw+5UMQxVP2pX0
X-Google-Smtp-Source: ABdhPJyNOD2ht5NWllAPCYxZmV9hr+8sW6q+V63TMLZza8JlhP09NPnm4xKNqRiUAZvY9SMwAPgw7pfu4DkTPQSvsdk=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr7056265oap.253.1649352524685; Thu, 07
 Apr 2022 10:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220403142137.2234322-1-trix@redhat.com> <513a5993-2cc5-54fa-2d6c-f4162d76ab0e@amd.com>
 <462e2f2a-0cc8-2e2e-93b6-504cc12aa768@redhat.com> <e0397927-06fc-933e-f73a-794e0629e0fd@amd.com>
In-Reply-To: <e0397927-06fc-933e-f73a-794e0629e0fd@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Apr 2022 13:28:33 -0400
Message-ID: <CADnq5_P90qk9Daw3jdmap0QZPWdFxjKMPkUWq4xf1eX35CHhsw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: cleanup extern usage in function definition
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Tom Rix <trix@redhat.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wenjing Liu <wenjing.liu@amd.com>, waynelin@amd.com,
        Anson Jacob <Anson.Jacob@amd.com>, Yu-ting.Shen@amd.com,
        Kees Cook <keescook@chromium.org>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Apr 4, 2022 at 11:57 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2022-04-04 11:43, Tom Rix wrote:
> >
> > On 4/4/22 8:22 AM, Harry Wentland wrote:
> >>
> >> On 2022-04-03 10:21, Tom Rix wrote:
> >>> Smatch reports this issue
> >>> hdcp1_execution.c:500:29: warning: function
> >>>    'mod_hdcp_hdcp1_dp_execution' with external linkage
> >>>    has definition
> >>>
> >> Which branch are you using?
> >
> > linux-next from 4/1
> >
>
> Apologies. I was looking at the wrong function.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > Tom
> >
> >>
> >> I don't see the 'extern' on
> >> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c>>>
> >> Harry
> >>
> >>
> >>> The storage-class-specifier extern is not needed in a
> >>> definition, so remove it.
> >>>
> >>> Signed-off-by: Tom Rix <trix@redhat.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 6 +++---
> >>>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> >>> index 6ec918af3bff..1ddb4f5eac8e 100644
> >>> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> >>> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> >>> @@ -497,9 +497,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_execution(struct mod_hdcp *hdcp,
> >>>       return status;
> >>>   }
> >>>   -extern enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
> >>> -        struct mod_hdcp_event_context *event_ctx,
> >>> -        struct mod_hdcp_transition_input_hdcp1 *input)
> >>> +enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
> >>> +                         struct mod_hdcp_event_context *event_ctx,
> >>> +                         struct mod_hdcp_transition_input_hdcp1 *input)
> >>>   {
> >>>       enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
> >>>
> >
>
