Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8025852C13C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbiERRRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbiERRQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:16:53 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D565F190D3C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:16:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j3so2039324qvn.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AeSKmYpRieplJqbY6dZu9gnBsUw6uzmIsnN1W8K30V0=;
        b=rLbXfVPr7deF6X6x3JTT+dODTXXHBuyYgpS/GGl1rtEAy1CEVGDA170Y9JrQu7WGzk
         +cA8BopAxiZh9kaM0hqE2z1HxRmdGQbfwZdIjXDtR8mULrC+rOMwQ6mV1O6Y9QiaBRWy
         f72wu3ZVo3173GbjXSNByN983NuGJzJIpnX7TtpZ+/K8+CMuWbm5R/igzyLyW2ffewlJ
         yOted1Uir1/frn7sScctDnEm/BMkgP0Ukb1xP005pgvK/tXxe+z/VQ5hpzq0qZeictTC
         e5ggi7/m3fB+TBwqa6jfyibDPjfdTckiNK4Lnl8FiDEs5PN42VklBFT0BPIPmabmkHgw
         Mz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeSKmYpRieplJqbY6dZu9gnBsUw6uzmIsnN1W8K30V0=;
        b=6CZu2s3Yi2Vxc0Zp3mMISy7Uw7TnflvNyecXayHV7B+dHMdAD/PKIWWP+0WRC3PthI
         NeHmjGlqxCpxrDSyoN7zRYXuyB215fjBsMnA9ZkYx71hL22jbevZQ3V3xuna7/3E9dhm
         ltnZxGWQRfX1fr8k/PN00ALWTqd8sJzB3eTwJrW0eJlGR812ZzjQqB58Bf4wYnVKVjDK
         DcBmuaN+Sk6KPgKD18BOZGAtr20Y+ZxuaVPyxN/1VCP+YWx3YcC/Icm1fjTqtxOp5A3R
         E6oSmlTMRx/6rDrN/rML2bINglf0iVj+QpcU5Lj9aNMo4t4vx+k3HVv8Fa7Q6NlQSV0g
         Kwlw==
X-Gm-Message-State: AOAM533+AxQvu/gex358akI/k/3TVuhXnwtztZj6h7WuPQttvSYugV8A
        ucdkmbGY58NAcE/oMlecMcYjK+HN8yrPUNSujUWPwg==
X-Google-Smtp-Source: ABdhPJzVWhb7JxBV/NHJBAs5arvGPcD2jM/v5t6AhXoRsB6n8cdbpK+D+p5XHnapodoBy5oTR6gn44rqH5iIEDFC8Kg=
X-Received: by 2002:a05:6214:931:b0:461:d289:b7f6 with SMTP id
 dk17-20020a056214093100b00461d289b7f6mr558590qvb.55.1652894209627; Wed, 18
 May 2022 10:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <1652892186-22346-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1652892186-22346-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 18 May 2022 20:16:38 +0300
Message-ID: <CAA8EJpqq4fxxgY0mj0JBans3GE-HAuad4Zsf7Ntwy1WW3bHbTQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] eDP/DP Phy vdda realted function
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org,
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

On Wed, 18 May 2022 at 19:43, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> 1) add regulator_set_load() to eDP/DP phy
> 2) remove vdda related function out of eDP/DP controller

These patches touch two subsystems and have a dependency between them.
How do we merge them?

>
> Kuogee Hsieh (2):
>   phy/qcom: add regulator_set_load to edp/dp phy
>   drm/msm/dp: delete vdda regulator related functions from eDP/DP
>     controller
>
>  drivers/gpu/drm/msm/dp/dp_parser.c  | 14 ------
>  drivers/gpu/drm/msm/dp/dp_parser.h  |  6 ---
>  drivers/gpu/drm/msm/dp/dp_power.c   | 95 +------------------------------------
>  drivers/phy/qualcomm/phy-qcom-edp.c | 25 ++++++++--
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 13 +++++
>  5 files changed, 36 insertions(+), 117 deletions(-)
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
