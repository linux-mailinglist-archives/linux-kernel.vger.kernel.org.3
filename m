Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDEE4F9C31
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbiDHSEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiDHSEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:04:41 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D82A83B8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:02:36 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t207so4045736qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnWn/G1v8AMjgZeV0vrRRskVP5PKCPkKnjAvSBWCiog=;
        b=Yrv/4DfWo8XzuZKX3n2fnRyM5qg5cpPd9RJn0imI4WJgfA4/hq+XwK9Zez1bIwBFYG
         QxCMABFF3bqiHIWYhC6zjNtGol7oTSnOQqqyJFcuFqDNXpPyLZ4B69ms5ViWU63tMj+8
         uVXMMz2FNHEUtmwK6ym9rZiV1MBctW2Kf7hipW8dlYW3COwe6ol7B3iEqbxxH1VB98C8
         aOIvIk6e5JtfwqivEiIizEpJiJV/ST6bkAayH/VrgmDzhchacsaK+uSJE0OnvGg2/eGU
         cMu9HHoge1H5LkMbBB1zaIdGPc4PwFNWUQA1vngF5bjc+F94yqev4OLIAImsKsRY4Vh1
         6+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnWn/G1v8AMjgZeV0vrRRskVP5PKCPkKnjAvSBWCiog=;
        b=4AI0S/tzkkGwVo5mAarLWGYTw+/4yeKlYiBxVkBAJYFedhBO6ECpuTP2D8wygSqZHc
         DmJurlOam2+QVUEMFkGhKykbBobJDGL3UivaqiX/XZhH6OgEAHkB/jWWxw4bpSGXVQ8Z
         bJZKl4p4FsH63tFJo+sLPW+1SZZPNRQWChaygXYg+fix1610QhUtc7E5t/QpSfDTYPqM
         sylP1gbATN6SrEvjS66M9Rf5NWfbN2BlMHb5SKe2grNGlxya4JmjInthMUH2sk4VmfTr
         ur3RLZpiLwzaHS4MyYlAzy6bSFJUAd2Rge1rQCnnKsW9TVjpFaXDRKrqE3bwY/mO5RVv
         Oavg==
X-Gm-Message-State: AOAM530Dzwv8rLfzONfpKsNmazIGkobpvTUHfn0NJUw9efcs60TtoZtv
        bVMU11t9Ia/yyRuRWhkOoNFw0ncxa7NZRADUwdRxrA==
X-Google-Smtp-Source: ABdhPJy0Zg7wGYGP3Y4ju21eKWOojsGNF/XGXzPyEC1bFWczC1hJ830VSwicu8jxDsJoQJjrLC3tmgMKEMTuAl3yecw=
X-Received: by 2002:a05:620a:170a:b0:67d:be5c:204a with SMTP id
 az10-20020a05620a170a00b0067dbe5c204amr13919747qkb.593.1649440955444; Fri, 08
 Apr 2022 11:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-6-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=Wn-XypjRcw-D0VtBHZbuTz=RHiMq6RCHCa=CWmZM42nQ@mail.gmail.com>
 <94da2c97-2ad2-4575-bd73-d66ad989e17b@linaro.org> <MW4PR02MB7186B3A2F8EDF388CA521498E1E99@MW4PR02MB7186.namprd02.prod.outlook.com>
In-Reply-To: <MW4PR02MB7186B3A2F8EDF388CA521498E1E99@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Apr 2022 21:02:24 +0300
Message-ID: <CAA8EJppMnDR15ZSS7FyMvDH0yshfNtgZgoYaxpYkJ3=xYm+Ggw@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] drm/msm/dp: prevent multiple votes for dp resources
To:     Sankeerth Billakanti <sbillaka@qti.qualcomm.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 at 20:12, Sankeerth Billakanti
<sbillaka@qti.qualcomm.com> wrote:
>
> > > On Wed, Mar 30, 2022 at 9:04 AM Sankeerth Billakanti
> > > <quic_sbillaka@quicinc.com> wrote:
> > >>
> > >> The aux_bus support with the dp_display driver will enable the dp
> > >> resources during msm_dp_modeset_init. The host_init has to return
> > >> early if the core is already initialized to prevent putting an
> > >> additional vote for the dp controller resources.
> > >>
> > >> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> > >> ---
> > >>   drivers/gpu/drm/msm/dp/dp_display.c | 10 ++++++++++
> > >>   1 file changed, 10 insertions(+)
> > >
> > > I'm not a huge fan of this but I'll leave it up to Dmitry. In general
> > > it feels like there should be _a_ place that enables these resources.
> > > Checks like this make it feel like we just scattershot enabling
> > > resources in a bunch of random places instead of coming up with the
> > > design for enabling them in the right place.
> >
> > I'd prefer to see a check for eDP in dp_display_config_hpd(). Or even better
> > to see that this function isn't called for eDP at all.
> >
>
> This needs to be called when eDP is not using the aux_bus path. If the eDP panel is
> given as a separate panel driver, then the resources need to be enabled here.
>
> If we don't want to support eDP without aux_bus, then we can skip this function.

I think it's up to you to decide, if it's necessary or not.
But if it is, please change it accordingly.

> > >
> > > In any case, if we do end up landing this patch, it sure feels like it
> > > needs to move earlier in the patch series, right? This patch shouldn't
> > > hurt even without the other patches in the series but if you apply the
> > > earlier patches in the series without this one then you'll have a bug,
> > > right? That means this needs to come earlier.
> > >
> > > -Doug
> >
> >
> > --
> > With best wishes
> > Dmitry
>
> Thank you,
> Sankeerth



-- 
With best wishes
Dmitry
