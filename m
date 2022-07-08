Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD956C2F6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiGHU7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbiGHU7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:59:05 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D36AA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:59:03 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x17so1544152qkh.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGl9x6k8v5djYyGKx5MXjpUaSuYQZtgM2PHdebhPLrI=;
        b=YHn+dY/1CDbJhtHksr0WeaOZtcVsTgWN8nKsKQX257vSBDXJG9EJmiFhC8I3V6+R6v
         hgKR98YDa7L5Aa2THh/5998SSzmcZ3wh36NhXb9Qc/kA6gAS8V274yGocQVC9oPD3v4K
         rQb/R7X5B+K4i+2eUBFLMFwPWVurbq2LXgbTxrAymvG18LutUVSbYul4//UGzb9zxGUR
         4EVSS7O1KymuzP3uvh/GmfDbjBVYhiNnsj2SCtvzuzFEjYAw3lC3IYafZjEROuGANY8u
         F6u0AbNhLdNtz/FvhwD+LvZ2caCAyDvbmZXc5hflWX7+kKbXAFTGhm56//HbQWE58SxT
         mv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGl9x6k8v5djYyGKx5MXjpUaSuYQZtgM2PHdebhPLrI=;
        b=kXxK7fvpQu2YHzjBGPDcTTO116k/wH7DEyMjTDW2NudCk7UNgyrf0wNoBEeb9mOxLu
         wxyAE8Pj6G9tfiCUkhPasrZypxVFh84o/bgOTZdwEJ+wnHRV9WYg3TRf7kc19tuBJsai
         lHig3Jdk1HW6lkt421ahv6G42MYf0YJaPnwhArJkQbAGPmxq7lKNuONqHB15Ec8YI6Aa
         bp4kFjhFEMtGaE/ydemG73Oh0EALDvA4wei9SQPg95ScMHdNvmygWhR6JAAVbbutsLiE
         ZZRKi7/iAfe1TzYpynlZyASH7HjWUGOdrxCr5tclGQomDDn54fTI6OdrslqsWzZQE8gq
         uJXA==
X-Gm-Message-State: AJIora890i6B0Q3B35Y4wBTNOAXgZXnX4EsKnKszhg8tBh/UD/xsN44J
        PBwIJW1g7SxoeRAVbKX2hiRhTr2Zpo2oaP39luTsdQ==
X-Google-Smtp-Source: AGRyM1ujmsVxb4yca/Yn9DPXvNZf7Hft+9m3xnJmwXIsLCcS7mcLswtUHojB5b8j9AbZ/z3C7lZVtVOGDTv+FHFiiR0=
X-Received: by 2002:a05:620a:d5b:b0:6b5:660b:2939 with SMTP id
 o27-20020a05620a0d5b00b006b5660b2939mr3029175qkl.30.1657313942992; Fri, 08
 Jul 2022 13:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220706191442.1150634-1-swboyd@chromium.org> <CAD=FV=UrYCwm2ByN_5EN3fq-ayMJNjmWfJ5sooRy51ZiCoMcjA@mail.gmail.com>
 <60252405-81f2-2465-bc20-5f91a9072031@quicinc.com> <ffad2e39-f775-00de-3119-f9b0ca3fe4f7@quicinc.com>
In-Reply-To: <ffad2e39-f775-00de-3119-f9b0ca3fe4f7@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Jul 2022 23:58:51 +0300
Message-ID: <CAA8EJpo-CS9ZUzA7wDZ05W+Wcz9P_1fXHYPaZACEhMOjnJv_Yg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Set panel orientation when directly connected
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2022 at 22:42, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 7/8/2022 9:00 AM, Abhinav Kumar wrote:
> >
> >
> > On 7/8/2022 8:25 AM, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Wed, Jul 6, 2022 at 12:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >>>
> >>> Set the panel orientation in drm when the panel is directly connected,
> >>> i.e. we're not using an external bridge. The external bridge case is
> >>> already handled by the panel bridge code, so we only update the path we
> >>> take when the panel is directly connected/internal. This silences a
> >>> warning splat coming from __drm_mode_object_add() on Wormdingler boards.
> >>>
> >>> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> >>> Cc: Douglas Anderson <dianders@chromium.org>
> >>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >>> ---
> >>>
> >>> This relies on commit 5e41b01a7808 ("drm/panel: Add an API to allow drm
> >>> to set orientation from panel") which is in drm-misc
> >>>
> >>>   drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >>
> >> I don't personally have objections to this, but (to my understanding)
> >> "the future" is that everyone should use panel_bridge. If we made the
> >> move to panel_bridge today then we wouldn't need to do this. In
> >> general I think panel_bridge would end up letting us delete a bunch of
> >> code...
> >>
> >> See commit 4e5763f03e10 ("drm/bridge: ti-sn65dsi86: Wrap panel with
> >> panel-bridge") for when this was done by ti-sn65dsi86.
> >>
> >> Then again, I spent a small amount of time looking into this and it's
> >> definitely non-trivial. Still likely worthwhile, but not worth
> >> blocking a tiny fix like this. It also should be fairly obvious that
> >> we should delete this when we switch to panel_bridge.
> >
> > Right, from what I saw on IRC, panel_bridge is the way forward and
> > dmitry did push a change to do that
> >
> > https://patchwork.freedesktop.org/patch/492585/
> >
> > But I think we can go ahead with this change because its simple enough.
> >
> > Regarding the panel_bridge migration, I am going to start reviewing that
> > as well.
> >
>
> I did some more digging up on the panel_bridge migration.
>
> Dmitry has posted this towards december last year
>
> https://patches.linaro.org/project/dri-devel/patch/20211207222901.988484-3-dmitry.baryshkov@linaro.org/
>
>
> and I had given my R-b on this already in Jan.
>
> I am not sure why this change was dropped OR was not part of msm-next
> already.
>
> Dmitry, any reason this change was left out so long and why the R-b was
> not retained and this was reposted?
>
>  From what i can see the change looks identical.

I don't remember if it is identical or not. Basically it was postponed
to allow DSC to flow in. We used drm_panel to pass DSC pps data. And
if we use panel-bridge, we don't get a handle of the panel.
Later on I have posted the series moving DSC pps pointer from
drm_panel to mipi_dsi_device (which is logical anyway, since it's not
only the panel, who can provide the DSC pps info, some bridges can
process DSC-compressed data). But since that time it received no
feedback.


-- 
With best wishes
Dmitry
