Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508F255A504
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 01:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiFXXpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 19:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiFXXpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:45:47 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B48AC21
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:45:46 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id z12so3033789qki.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3MRZDPjbjqka5SFCsRF0GaePuedl2AIb6glbaDxLPo=;
        b=T1jZ/wuAXd4vkBbmbjvR4zc2gMr+VrXytSGHLBHq2r677FwX7N3/8VRvVeku7U9PL4
         z5UOWQn1DzpuX52KtITNRF3Ywiklcq2o9+xtPOrMchkBSRMQBAh9u2490x1FYlA83+Fw
         3q7/7YYig0nseD0c+Z92CqG7EJ7irgF7zexvcR/iaNm9ym7oke5sLufp9rSdU2HBRYgn
         lFpWRdhpyb2VnBVu1ENsguh/VNuNa9AdK2OKDjFndacjelg0wh+eEtq2hlJ801HyxLXn
         OQxYh3jQLwSrcxj2ROwUU9NLUWQl/Z1tLvlA65PmyaHELR6gJsMf2lJpP1DYZsm88RIG
         kRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3MRZDPjbjqka5SFCsRF0GaePuedl2AIb6glbaDxLPo=;
        b=OEPFMor6MoxtjiJ4Cq9PqzkYR37i6LxQYNyqLADK+lbIT2bYMh6yRuF0ijt4O3uZ94
         0tvlhuFak4ovS8VMZRIP0wx+4yz3dnD8XO1aF6z0n2fV18fLtgtnGw3xIfNte8GbNlYo
         BNNiXtwy4NECGdJUTVyHvYV+rBXRD0Fs3BrfZ5nUxEnRcHJcn0CIaVOeQWLObt55CzCB
         p7DZhSZdmM74r/dV9sTgtRJ/WQmOF0K5lEANKI1rVhIe7fgecnU6lHev6HDiYN6FAHZ0
         QS5/I3nffERUAqL5VngchHjwHBxhOKT6+JfVa/hXD2ACq06xUpcev0yrpPCGSTKmYLYf
         705Q==
X-Gm-Message-State: AJIora9mEPI/WhS8sD4z2dsnPn8YaqI6Q5AfNJMWQzyGJCMRzgbkcoBr
        EpIDXRE7Rsr/q8vIRJAXWtuMabMUlAeq1tLV/KaXng==
X-Google-Smtp-Source: AGRyM1v/i8BJMvLqu4IlBuePJHdL20SOPQr3QObkB7VQeNVKxSUFFYLdnJmiIKpbsI6PhCqNqVQetH1um/ElYuHDTPU=
X-Received: by 2002:a05:620a:31a0:b0:6a7:549f:a788 with SMTP id
 bi32-20020a05620a31a000b006a7549fa788mr1331198qkb.203.1656114345250; Fri, 24
 Jun 2022 16:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
 <1656090912-18074-2-git-send-email-quic_khsieh@quicinc.com>
 <CAD=FV=XD0Nb8GiaqEM52rEkUeVjuo46hBv9YUizdDu9zOH6QfA@mail.gmail.com> <0632e72a-3bd2-6320-4a00-6d3cf7d40513@quicinc.com>
In-Reply-To: <0632e72a-3bd2-6320-4a00-6d3cf7d40513@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 25 Jun 2022 02:45:33 +0300
Message-ID: <CAA8EJpqfdzmcpGeLHr5wBA7B91rAegoJhpFG=CYyJ4C2gxVBXw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/msm/dp: move struc of msm_display_info to msm_drv.h
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022 at 00:51, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> On 6/24/2022 2:40 PM, Doug Anderson wrote:
> > On Fri, Jun 24, 2022 at 10:15 AM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:

> >> +struct msm_display_info {
> >> +       int intf_type;
> >> +       uint32_t capabilities;
> >> +       uint32_t num_of_h_tiles;
> >> +       uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
> >> +       bool is_te_using_watchdog_timer;
> > ...but then when you "move" the structure to its new location, which
> > should be a noop, then <poof> the "dsc" variable vanishes (along with
> > the kernel doc description of it before the structure).
>
> Sorry, i did not resolve the conflicts correctly  when i cherry-pick
> them to msm-next tree.
>
> Will fix them.

I would strongly suggest doing development on top of msm/next or
linux-next. Using any other tree results in lots of problems starting
from the lame Fixes tags that we have been constantly seeing for the
last few months, conflicts when the patch is being rebased or
cherry-picked and ending up with the patches not being tested with the
tree that they are being applied to.

-- 
With best wishes
Dmitry
