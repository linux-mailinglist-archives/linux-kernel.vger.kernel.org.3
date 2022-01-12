Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA348C915
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355466AbiALRIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355456AbiALRIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:08:24 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44B6C061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:08:23 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id fo11so3598807qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2r8zDaYEYO7JZzEvLRafkjVzXVbOIdjMODi9DYi7oM=;
        b=pcl455766GGKJIZFYn04i9FUJCfW2GO3Xmf3oujv9PplioZn00+KmCY+eNiGNSIz8L
         JbfEeFNoDL/e5tZc7pKNsY4pTnOp1fW6byXxLwSUHRObnNE2Hi5PczASCFJKNOOG2o+t
         l9SlrIT077C3Lhq+66244UsOQLeNfuwt6LWsu+KRHl/lCnhY6IyGq+choJ9aE19eeaEQ
         g2yTI+wdnHV2nRPFkHWA0YlWhWv+w7ZgAjysx9pYCtk8G49RZcuzTCEGRBJn1cYmTOFa
         199KZNVJuznrJEGatnpi42djyi83fGpiyqtB3eQSOMXYqAnDooW04oHUloXrDz2VBAhn
         wBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2r8zDaYEYO7JZzEvLRafkjVzXVbOIdjMODi9DYi7oM=;
        b=J9KxnLrib/dZ+TSJw0djDymWzRAnCwFjCxf5leizQTc6GpAYWi0ZSMuTU9xeLJvJ7l
         h52+pkWJs1V5gGMxmdIFAnWww+65XU0fpzlx9dUB04YGkQd9G6xyeVs3e//c95Qk6OJX
         Y+awe/YFPzBU2MUE8tVWjQSUZhidy5Y4mLuZEhu2NVZ6I1Qvr4YthHKHPsqpzCbOTyS1
         M8UMFMgpoVAYNhoqUCWCr1oIOcq/kWQDI67H7JpeDE6bQWg0VtScndPUD9ViF9hJfvg5
         +9hFvouLTmPqaU8+m2pb47IFQARkgODr6iSR4PrQwF472SAE6z04Ip2Poh2LzfiSBvIx
         xpxw==
X-Gm-Message-State: AOAM532NJ3BVDeXTetdBlZgbpzvF2tv8IMFHy6GC3jQXFN1ZIRhIhqv4
        17st3sb0Dek0f9Lx3oFsFQz4OxHTBgq38acsiKhBRQ==
X-Google-Smtp-Source: ABdhPJzuydkdLlBEqhT2Ingy9JfQSKSOyMicJqfQgOWz6bBtPSJmKMoL5u/fbWZ94Y9IO9CPi05xx2f7tr4W3Dhlg7Y=
X-Received: by 2002:a05:6214:27cc:: with SMTP id ge12mr664250qvb.122.1642007302831;
 Wed, 12 Jan 2022 09:08:22 -0800 (PST)
MIME-Version: 1.0
References: <1641819337-17037-1-git-send-email-quic_rajeevny@quicinc.com>
 <1641819337-17037-3-git-send-email-quic_rajeevny@quicinc.com>
 <CAA8EJpr_iEvv3oM-KteT7or3HyMk45Z8mzWyKwZ=rnASm-hNXA@mail.gmail.com> <MW2PR02MB3820E98516A4F484A3ECF25FEA529@MW2PR02MB3820.namprd02.prod.outlook.com>
In-Reply-To: <MW2PR02MB3820E98516A4F484A3ECF25FEA529@MW2PR02MB3820.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 12 Jan 2022 20:08:11 +0300
Message-ID: <CAA8EJpqdrmnhDFd7kYyt1E+8U5sUjiR+oR1DoMX72iZjAE5QXw@mail.gmail.com>
Subject: Re: [v2 2/3] drm/msm/dsi: Add dsi phy tuning configuration support
To:     Rajeev Nandan <rajeevny@qti.qualcomm.com>
Cc:     quic_rajeevny <quic_rajeevny@quicinc.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        quic_mkrishn <quic_mkrishn@quicinc.com>,
        "jonathan@marek.ca" <jonathan@marek.ca>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 19:09, Rajeev Nandan <RAJEEVNY@qti.qualcomm.com> wrote:
>
> Hi Dmitry,
>
> > >
> > > +       if (phy->cfg->ops.tuning_cfg_init)
> > > +               phy->cfg->ops.tuning_cfg_init(phy);
> >
> > Please rename to parse_dt_properties() or something like that.
> Sure. I didn't understand your comment in v1 to use config_dt() hook. I think, now I understood.
> This function can be used to parse PHY version (nm) specific DT properties, currently we will be using it for PHY tuning parameters, and later some other properties can be added.
> I will use parse_dt_properties() in next post. Please correct me if I still didn't get it.

You understanding follows my proposal, thank you.

>
> >
> > > +
> > >         ret = dsi_phy_regulator_init(phy);
> > >         if (ret)
> > >                 goto fail;
> > > diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > > b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > > index b91303a..b559a2b 100644
> > > --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > > +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > > @@ -25,6 +25,7 @@ struct msm_dsi_phy_ops {
> > >         void (*save_pll_state)(struct msm_dsi_phy *phy);
> > >         int (*restore_pll_state)(struct msm_dsi_phy *phy);
> > >         bool (*set_continuous_clock)(struct msm_dsi_phy *phy, bool
> > > enable);
> > > +       void (*tuning_cfg_init)(struct msm_dsi_phy *phy);
> > >  };
> > >
> > >  struct msm_dsi_phy_cfg {
> > > @@ -81,6 +82,20 @@ struct msm_dsi_dphy_timing {
> > >  #define DSI_PIXEL_PLL_CLK              1
> > >  #define NUM_PROVIDED_CLKS              2
> > >
> > > +#define DSI_LANE_MAX                   5
> > > +
> > > +/**
> > > + * struct msm_dsi_phy_tuning_cfg - Holds PHY tuning config parameters.
> > > + * @rescode_offset_top: Offset for pull-up legs rescode.
> > > + * @rescode_offset_bot: Offset for pull-down legs rescode.
> > > + * @vreg_ctrl: vreg ctrl to drive LDO level  */ struct
> > > +msm_dsi_phy_tuning_cfg {
> > > +       u8 rescode_offset_top[DSI_LANE_MAX];
> > > +       u8 rescode_offset_bot[DSI_LANE_MAX];
> > > +       u8 vreg_ctrl;
> > > +};
> >
> > How generic is this? In other words, you are adding a struct with the generic
> > name to the generic structure. I'd expect that it would be common to several
> > PHY generations.
>
> The 10nm is PHY v3.x, and the PHY tuning register configuration is same across DSI PHY v3.x devices.
> Similarly the PHY v4.x devices have same register configuration to adjust PHY tuning parameters.

What about 14nm (v2.x, sdm660)? Or even 0.0-lpm (apq8016)?

>
> The v4.x has few changes as compared to v3.x :
> - rescode_offset_top:
>   In v4.x, the value is not per lane, register is moved from PHY_LN_ block to PHY_CMN_ block. One value needed to configure all the lanes.
>   Whereas in v3.x, configuration for each lane can be different.
>   In case of v4.x, we can use rescode_offset_top[0] and ignore rest values.

Ugh.

>
> - rescode_offset_bot:
>    same as rescode_offset_top comments given above.
>
> - vreg_ctrl:
>    v4.x has two registers to adjust drive level, REG_DSI_7nm_PHY_CMN_VREG_CTRL_0 and REG_DSI_7nm_PHY_CMN_VREG_CTRL_1
>    The first one is the same for v3 and v4, only name is changed (_0 suffix)
>    The second one REG_DSI_7nm_PHY_CMN_VREG_CTRL_1 is added to adjust mid-level amplitudes (C-PHY mode only)
>    We can add a new member vreg_ctrl_1 in the "struct msm_dsi_phy_tuning_cfg" while adding PHY tuning support for V4.x
>
> Apart from the existing members, the v4.x has a few more register config options for drive strength adjustment and De-emphasis.
> We can add new members to address them for v4.x PHY tuning.

I do not like the idea of pushing each and every possible option into
generic structure.
I see two possible solutions:
 - Add opaque void pointer to struct msm_dsi_phy. Allow each driver to
specify it on it's own.

Or:

- add a union of per-nm structures.

From these two options I'm biassed towards the first one. It
encapsulates the data structure with the using code.


>
> The PHY v4.x is the latest PHY version, and most of the new devices are coming with v4.x. So, I can say that the structure member is going to remain the same for some time.
> (Things may/may not change in v5, but I never heard of it coming)
>
> Thanks,
> Rajeev
> >
> > > +
> > >  struct msm_dsi_phy {
> > >         struct platform_device *pdev;
> > >         void __iomem *base;
> > > @@ -98,6 +113,7 @@ struct msm_dsi_phy {
> > >
> > >         struct msm_dsi_dphy_timing timing;
> > >         const struct msm_dsi_phy_cfg *cfg;
> > > +       struct msm_dsi_phy_tuning_cfg tuning_cfg;
> > >
> > >         enum msm_dsi_phy_usecase usecase;
> > >         bool regulator_ldo_mode;
> > > --
> > > 2.7.4
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry
