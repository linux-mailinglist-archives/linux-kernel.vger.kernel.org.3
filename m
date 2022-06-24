Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D2055A4C5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 01:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiFXXZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 19:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiFXXZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:25:18 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBF481530
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:25:16 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b125so2932885qkg.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpOasnc+MpC6k8YV2n5CgA0BI1oTbTynNjCcV+ZfHRs=;
        b=NHb6sx16M7MktkZ3Jo61dJAtykBLRQ7L90BYWPv2UYfd7gTYH2Imv7sGo8sVPuwlCd
         3MzSMUw6RsrSdaH9kaWcFR/nhX3HUHTrofuDUv3N9XBWRtkmXMs74x9X1h6D7hUvEloQ
         xZqSxQLB41Sd3P5nsLa3wY60AtTBzwR9xksRX1rO+ijLlptnUAkOt4a4dbPrFdO6ZUOI
         eJf7OJQp9wYcRSj39MRpVP+exzOBiqETNrSMynq1cLm60ZfW39poLkgFd/c4XlEzX92Z
         urgI7E+FNaezix5BisyfzLdTRLV6DWggT8YDLErAQ+32QXk6815I9uprKrMtEBtLDi3/
         v7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpOasnc+MpC6k8YV2n5CgA0BI1oTbTynNjCcV+ZfHRs=;
        b=PhSmH5HIdzh4PoATyoyoXRSIusRaYq0L+bJLLVlHJpO3vg+JGT0EotGTCpVHgKH5ws
         BlFdaDvObf4j9KZ3H5ckUbaH76vN0kWckpKL6hVidIclEqYPkvEXoGDNTBitBAMTvGY1
         AFBABHAptv33bddUKO7SaQKzVmOSarc1WqM3xCm99El/XSIg4OQoVgkoZmyJISrAC1XJ
         EMfV7eotu5mh2Mmp7srm2Tv/s+r5sq6e+AZSdNfT4jVN90iC5ra5+feQ64roPar5Hova
         kQ1E7q6kE8vYTLPivUbpCESeZbxDdrSprjuyq3CuM2udjRO1zaEjoWtploEPSd3Ey70r
         sIew==
X-Gm-Message-State: AJIora8lORsztAXrm9rJPV6HV7HEO7guWgC0Xhz0reubSts35eorfCZl
        /SQxiJgqtd8JZV0pcnMf5WKBwdVX9CgAcB71W6+KOw==
X-Google-Smtp-Source: AGRyM1uO6ak+ggMtjMmbHyuZ535rKKAdH4kKHL57dRRG0x0TBx5SohM1ORVa07kNl56sasfydWaRzHmOt05i/wBTFkY=
X-Received: by 2002:a05:620a:31a0:b0:6a7:549f:a788 with SMTP id
 bi32-20020a05620a31a000b006a7549fa788mr1285171qkb.203.1656113115648; Fri, 24
 Jun 2022 16:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
 <1656090912-18074-3-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52RW+UFJ=hqMWjwR8qvEbww7QjzPW1nhL3Atd97QXAnYw@mail.gmail.com> <007ea4c9-9701-f4ab-3278-5d36bf2018c4@quicinc.com>
In-Reply-To: <007ea4c9-9701-f4ab-3278-5d36bf2018c4@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 25 Jun 2022 02:25:04 +0300
Message-ID: <CAA8EJprd_kkqU4GZ_p2cZbALCBDE-uFHsnPHXRnra0jZsY_bnA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp
 controller_id at scxxxx_dp_cfg table
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, 25 Jun 2022 at 00:17, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 6/24/2022 1:00 PM, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2022-06-24 10:15:11)
> >> Current the index (dp->id) of DP descriptor table (scxxxx_dp_cfg[]) are tightly
> >> coupled with DP controller_id. This means DP use controller id 0 must be placed
> >> at first entry of DP descriptor table (scxxxx_dp_cfg[]). Otherwise the internal
> >> INTF will mismatch controller_id. This will cause controller kickoff wrong
> >> interface timing engine and cause dpu_encoder_phys_vid_wait_for_commit_done
> >> vblank timeout error.
> >>
> >> This patch add controller_id field into struct msm_dp_desc to break the tightly
> >> coupled relationship between index (dp->id) of DP descriptor table with DP
> >> controller_id.
> > Please no. This reverts the intention of commit bb3de286d992
> > ("drm/msm/dp: Support up to 3 DP controllers")
> >
> >      A new enum is introduced to document the connection between the
> >      instances referenced in the dpu_intf_cfg array and the controllers in
> >      the DP driver and sc7180 is updated.
> >
> > It sounds like the intent of that commit failed to make a strong enough
> > connection. Now it needs to match the INTF number as well? I can't
> > really figure out what is actually wrong, because this patch undoes that
> > intentional tight coupling. Is the next patch the important part that
> > flips the order of the two interfaces?
>
> The commit bb3de286d992have two problems,
>
> 1)  The below sc7280_dp_cfg will not work, if eDP use
> MSM_DP_CONTROLLER_2 instead of  MSM_DP_CONTROLLER_1
>
> since it have num_descs =2 but eDP is at index 2 (CONTROLLER_2) which
> never be reached.
>
> static const struct msm_dp_config sc7280_dp_cfg = {
>          .descs = (const struct msm_dp_desc[]) {
>                  [MSM_DP_CONTROLLER_2] = { .io_start = 0x0aea0000,
> .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
>                  [MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000,
> .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
>          },
>          .num_descs = 2,

Please change num_descs to 3. Or better eliminate it completely and
iterate up to MSM_DP_CONTROLLER_MAX, checking whether the entry
contains real values or is just a zero sentinel entry.

> };
>
> 2)  DP always has index of 0 (dp->id = 0) and the first one to call
> msm_dp_modeset_init(). This make DP always place at head of bridge chain.
>
> At next patch eDP must be placed at head of bridge chain to fix eDP
> corruption issue. This is the purpose of this patch. I will revise the
> commit text.

This text doesn't make sense to me. The dp->id has nothing to do with
the bridge chains. Each dp entry is a head of the corresponding bridge
chain. DP with dp->id = 0 and eDP with dp->id = whatever will be parts
of different encoder -> bridges -> connector chains.

-- 
With best wishes
Dmitry
