Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767964CC7A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbiCCVMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiCCVMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:12:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961021DA60;
        Thu,  3 Mar 2022 13:11:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i8so9698472wrr.8;
        Thu, 03 Mar 2022 13:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jye9sG2e7guSL+XkxjuDpz9zKUvCzbczzcyn6VXMn/4=;
        b=WlWvof+JqXVsRd9apJd50cF/PMSOpTDenWGWYpkbGhUy6cZ6X+vRNd2W+i9L+iTp+E
         dyCTuqZyIWsWXYofbP8hbOVT9SXwbMaw9TmXRYMF5UJo7dQ375UBFZOvArtKjFJZ2MAR
         izsGwbIdS1cHwzkXG7JLFXOHxaVMMcOZR8p8xAIsyZr7kkH/KrxXq25FOINQBWBzVuzF
         4epJfzS59UBru4Y5+RSwDL3GHyM4aZEQogBF4aYqZutHknmX9ktrCxI0Hz5jkKObzE3x
         JWz/mCoYrJ4LV3wX/bnDVvWcwAnwz9UNxhseROWWbmLl1K86M71tupRCidRVSI56zhm8
         zVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jye9sG2e7guSL+XkxjuDpz9zKUvCzbczzcyn6VXMn/4=;
        b=CwCKsnWAFU4EON3gDOb2Wd6zWs7ze4N6VT805CmYy9691ef28psE8k5Xyd43YyV+n3
         2wRGLfMn4ZMJhhpjSEMcrcrMieQdXvIdmu8C41ivwyoj4OmlojDMNEcybI9OlzJ8LT5w
         mj5fWJK7EyJNQKjKh0Y8P8HZSifZKnP3iNUCDIKYOvU+JjgqTOZL9ZdqZWlu7KumdnAW
         LsfoME+nN/pjYIzqUiaHKpgYNbHH4mE/W13TAKWhFcrkLexCQ7lpyP8K5/oPESZ4ah8B
         65/YtRHNfTvqPBM0CCNfHxWDZWSo1EXf9h9yjK+hNo7CmPz4yF9tEFsuGinHK5es2PN5
         6o+A==
X-Gm-Message-State: AOAM533OdWolMerTnnXTJi8de3gRt3OqBI2ArfJ9UNT+rOzjS0JpPT2l
        uVAUrf2ZfvDLbgewEUgfVQ4smhw/jyDcLGNLMUrdYrOJ
X-Google-Smtp-Source: ABdhPJzB4WtMzRM3XDI9bRh4CZsC8i9GN2+hN6rMt+voo6lSphjjflunNJUvo59Cu6gcZebWOsNqC6X/LVLyKNI3MJ0=
X-Received: by 2002:a5d:5382:0:b0:1f0:2f64:5a5a with SMTP id
 d2-20020a5d5382000000b001f02f645a5amr6921862wrv.418.1646341874028; Thu, 03
 Mar 2022 13:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20220303194758.710358-1-robdclark@gmail.com> <20220303194758.710358-2-robdclark@gmail.com>
 <1a42ff3e-154a-b2b8-9c99-8d5fba9a38e5@quicinc.com>
In-Reply-To: <1a42ff3e-154a-b2b8-9c99-8d5fba9a38e5@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 3 Mar 2022 13:11:43 -0800
Message-ID: <CAF6AEGvBzFKbPVe+6+kHVDdFFvxXeFCp-7Jx=61or96HdQby4g@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/msm: Update generated headers
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Thu, Mar 3, 2022 at 12:42 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Hi Rob
>
> On 3/3/2022 11:46 AM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Update headers from mesa commit:
> >
> >    commit 7e63fa2bb13cf14b765ad06d046789ee1879b5ef
> >    Author:     Rob Clark <robclark@freedesktop.org>
> >    AuthorDate: Wed Mar 2 17:11:10 2022 -0800
> >
> >        freedreno/registers: Add a couple regs we need for kernel
> >
> >        Signed-off-by: Rob Clark <robdclark@chromium.org>
> >        Part-of: <https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/15221>
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/adreno/a2xx.xml.h         |  26 +-
> >   drivers/gpu/drm/msm/adreno/a3xx.xml.h         |  30 +-
> >   drivers/gpu/drm/msm/adreno/a4xx.xml.h         | 112 ++-
> >   drivers/gpu/drm/msm/adreno/a5xx.xml.h         |  63 +-
> >   drivers/gpu/drm/msm/adreno/a6xx.xml.h         | 674 +++++++++++-------
> >   drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h     |  26 +-
> >   .../gpu/drm/msm/adreno/adreno_common.xml.h    |  31 +-
> >   drivers/gpu/drm/msm/adreno/adreno_pm4.xml.h   |  46 +-
> >   drivers/gpu/drm/msm/disp/mdp4/mdp4.xml.h      |  37 +-
> >   drivers/gpu/drm/msm/disp/mdp5/mdp5.xml.h      |  37 +-
> >   drivers/gpu/drm/msm/disp/mdp_common.xml.h     |  37 +-
> >   drivers/gpu/drm/msm/dsi/dsi.xml.h             |  37 +-
> >   drivers/gpu/drm/msm/dsi/dsi_phy_10nm.xml.h    |  37 +-
> >   drivers/gpu/drm/msm/dsi/dsi_phy_14nm.xml.h    |  37 +-
> >   drivers/gpu/drm/msm/dsi/dsi_phy_20nm.xml.h    |  37 +-
> >   drivers/gpu/drm/msm/dsi/dsi_phy_28nm.xml.h    |  37 +-
> >   .../gpu/drm/msm/dsi/dsi_phy_28nm_8960.xml.h   |  37 +-
> >   drivers/gpu/drm/msm/dsi/dsi_phy_5nm.xml.h     | 480 -------------
> Why is the 5nm PHY removed? Am i missing something?

Dmitry removed it in mesa, because it was identical to 7nm

BR,
-R

>
> Thanks
>
> Abhinav
