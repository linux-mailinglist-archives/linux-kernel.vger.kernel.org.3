Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7236655A824
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiFYIsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 04:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFYIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 04:48:37 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3FB40E67
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 01:48:36 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v6so3540859qkh.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwAWG5aNymIe8GONpxgKHM0TD4mxy/BWPypQDwrjLVo=;
        b=GPpGfz/knOT3/AjER09tzOY1PgbZVeV/eCZzbZtGCN+uJdwy1zEFWSj9Mfp5FD35Q5
         Nxc77DRAeOcEyf6dGCFNAlysNjiykzlIKp5pn+COoSkeR3+kRnqSvhmGTtvLgiS/9b7L
         W80J0/W6lbR1l0HVWk3cp8yTbjziiKPAF800uis5Vprtlic6lnk7dZqikXUpnU2WeQ/M
         HVxZuH7b591RgdKfz6LwpX1L4dU9NoOe2AO5+jSmhnlMhHA9SOgE60XgsljAO+ja2yf9
         qIsa1x8Ndz0GbhStTCzVQO4LZu90tCxRz48rySqBiYdJIn9TCsHvAMzYvtwXw2x49CzG
         VugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwAWG5aNymIe8GONpxgKHM0TD4mxy/BWPypQDwrjLVo=;
        b=ZkKQF3GFEUnQuZdOgod9kL0akcYD24A6W7PJY5v+s24k9RVcpOhi8seswGUNI90ws3
         cx+0odLu0DAq1cZZuYu6Y4XCz/kBW/30b7vQGA8OebhcBSfKSH0emFRecgFbK3JE98Q6
         OMsLFN59j6jyuMfDTmdef9ST0xJPln1KaOZNrOL18ho6ssXqXzsbLSisbtf9RgMW/Yx0
         Xm5ALNJiz8Vmi+a4Aj5g2xMyaJOZkeMjKY33BGlOk9RTB/+U6oE2KS7gjQmXS+9h1JS5
         Z+JpRL1V+uVy60ExdI2+OFv9VGwDs2UvCtC9qeSU2jb2hmNenLrmPfDH26+5mXkWwA7V
         +SaA==
X-Gm-Message-State: AJIora9jTSAIJ4fbXkZxamJodiDFl1e6EhD/a6y0ycn3EGVKgVei4WHB
        vmBNE56CaFBV/H4zPFJIHkIir2XsEho6jqgwmhNyzA==
X-Google-Smtp-Source: AGRyM1u16jRrSTlBD4cKdLquQJhMiuhvjfK/cJx2+pLsiqrF9JIae2Lil6WCLqGl0uJCrZPslZuCBSr1t08kFR+rUq4=
X-Received: by 2002:a05:620a:2a0e:b0:6a7:8346:1601 with SMTP id
 o14-20020a05620a2a0e00b006a783461601mr2062914qkp.593.1656146916001; Sat, 25
 Jun 2022 01:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
 <1656090912-18074-3-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52RW+UFJ=hqMWjwR8qvEbww7QjzPW1nhL3Atd97QXAnYw@mail.gmail.com>
 <007ea4c9-9701-f4ab-3278-5d36bf2018c4@quicinc.com> <CAE-0n53kNCK0ajHfY2WQr5HEQZtZSBLnhfbTuZwaUNEOZhsKPg@mail.gmail.com>
 <fa7f8bf1-33cd-5515-0143-6596df2bd740@quicinc.com> <CAE-0n51g-EVsC-i9=sJV-ySa8VnE+yT7cg=b-TNMi9+3uBiOVA@mail.gmail.com>
 <326912ff-9771-0711-366d-79acd436908b@quicinc.com> <CAE-0n51qrdrFtSr0vRwgYkMgSZfnzQuinaUROQsp30QoDchWQA@mail.gmail.com>
 <0ff3d6a3-dc5c-7c77-f8a1-6c4f6c1a3215@quicinc.com> <CAE-0n515hMKqQ+Vj1Sg54PpwkbWMYJ77QN+y+KZNBWymjhpWKw@mail.gmail.com>
 <66ff4642-f268-f5b0-7e28-b196368c508a@quicinc.com> <5cf094cf-343a-82d7-91c4-1284683f9748@quicinc.com>
 <CAA8EJprqq=vxXT2DmEWii_Ajx2UbkHRexPTT58xFcWkBa_D5hA@mail.gmail.com> <6523e533-960b-d148-0f87-2ad327a3ac3b@quicinc.com>
In-Reply-To: <6523e533-960b-d148-0f87-2ad327a3ac3b@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 25 Jun 2022 11:48:24 +0300
Message-ID: <CAA8EJprQBnZAc-2AxXD8cV_qMoKrusNa+VSHW9Kw-xKS_ZWAkg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp
 controller_id at scxxxx_dp_cfg table
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, 25 Jun 2022 at 04:23, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> On 6/24/2022 5:11 PM, Dmitry Baryshkov wrote:
> > On Sat, 25 Jun 2022 at 03:03, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >> On 6/24/2022 4:56 PM, Kuogee Hsieh wrote:
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
> >> b/drivers/gpu/drm/msm/dp/dp_display.c
> >> index dcd80c8a794c..7816e82452ca 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >> @@ -140,8 +140,8 @@ static const struct msm_dp_config sc7180_dp_cfg = {
> >>
> >>    static const struct msm_dp_config sc7280_dp_cfg = {
> >>           .descs = (const struct msm_dp_desc[]) {
> >> -               [MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000,
> >> .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
> >>                   [MSM_DP_CONTROLLER_1] = { .io_start = 0x0aea0000,
> >> .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
> >> +               [MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000,
> >> .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
> >>           },
> >>           .num_descs = 2,
> >>    };
> >>
> >>
> >> The reason order is important is because  in this function below, even
> >> though it matches the address to find which one to use it loops through
> >> the array and so the value of *id will change depending on which one is
> >> located where.
> >>
> >> static const struct msm_dp_desc *dp_display_get_desc(struct
> >> platform_device *pdev,
> >>                                unsigned int *id)
> >> {
> >>       const struct msm_dp_config *cfg = of_device_get_match_data(&pdev->dev);
> >>       struct resource *res;
> >>       int i;
> >>
> >>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>       if (!res)
> >>           return NULL;
> >>
> >>       for (i = 0; i < cfg->num_descs; i++) {
> >>           if (cfg->descs[i].io_start == res->start) {
> >>               *id = i;
> >
> > The id is set to the index of the corresponding DP instance in the
> > descs array, which is MSM_DP_CONTROLLER_n. Correct up to now.
>
> Right, this is where I misunderstood his explanation.
>
> Even if we swap the order, but retain the index correctly it will still
> work today.
>
> Hes not sure of the root-cause of why turning on the primary display
> first fixes the issue.
>
> I think till we root-cause that, lets put this on hold.

Agreed. Let's find the root cause.


-- 
With best wishes
Dmitry
