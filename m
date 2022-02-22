Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41714C0376
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbiBVU6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiBVU6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:58:33 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720ACB3E53
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:58:07 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id p15so15992817oip.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=NynQNF0vX996pWM8oXRiHAyv1zn8urGitpw21EUF3Ig=;
        b=L/8fx6WNUMxviiyfdvx+MGczbT7qrRWXltvUI3yYAlhX786QC8OveavbrQQljj6iAB
         XSYVJXmNJhCpKFngP93KQCqgOXuVJ8JuEiIX2Pa3TYI46TQVRX7lavz7/HA9pcZ/GRwr
         Pazm7NAEKcHpghc7LdbcTZgvieufT8c5NUjQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=NynQNF0vX996pWM8oXRiHAyv1zn8urGitpw21EUF3Ig=;
        b=5uEYfovkEHKdUtihKRzlYFWshabp0xsktjRkwfp+4Apzar1vcUKV1ELdmEYPFIvASG
         Bj7MC3FDrVsKdlWhyfnOvGhU47hldgSXUmX3J9tC0rMMJ14yasVv23Z5kf9g1F3Xunv6
         XPZqI41da2K9CCWBfWLgTKn2ua0xfl6h7m9Iia7ZNZYxrqxYTICSTTJwrIv7j6UQEXgm
         1KAWs60KpvQSHS3TYISnQnJRp3pTreXTYeXR6xQs+ViQp36rfBGyUi6zq32WuIhLuIFd
         oXy8U+8MzFu+v03dk740DftQTIdFdDi+jukMTnfK/vlvzhuD1Q1sSJ9T0mUoMZoUoUAY
         2nDg==
X-Gm-Message-State: AOAM533GDuqvIH1wUIpXtSYMQLWK6L3wxKpfAWZa1RlFJ3+vauO6P/11
        QDq1CidDUjE3+Cb3f8LUHjuohHJdUGwlDi9hpSvkpw==
X-Google-Smtp-Source: ABdhPJx6fQYRY7rvcoUFumSJbC7mrI8sA642kTB5r6LSvTKI5ctWF6uGfP0c5mRHN4PAc2LCLE3717+B+ntjiMevFFI=
X-Received: by 2002:a05:6808:f88:b0:2d4:c8c2:b898 with SMTP id
 o8-20020a0568080f8800b002d4c8c2b898mr2943846oiw.112.1645563486853; Tue, 22
 Feb 2022 12:58:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Feb 2022 20:58:06 +0000
MIME-Version: 1.0
In-Reply-To: <1645449126-17718-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1645449126-17718-1-git-send-email-quic_vpolimer@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Feb 2022 20:58:06 +0000
Message-ID: <CAE-0n507XcYRz4=Uw-K37kPsLRqi_gN2L9y1wcu_X-UJP+6ySg@mail.gmail.com>
Subject: Re: [v1] arm64/dts/qcom/sc7280: update mdp clk to max supported value
 to support higher refresh rates
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, dianders@chromium.org,
        quic_kalyant@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Polimera (2022-02-21 05:12:06)
> Panels with higher refresh rate will need mdp clk above 300Mhz.
> Select max frequency for mdp clock during bootup, dpu driver will
> scale down the clock as per usecase when first update from the framework is received.
>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>

Please add a Fixes tag.

> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index baf1653..7af96fc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2895,7 +2895,7 @@
>                                 assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
>                                                 <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
>                                                 <&dispcc DISP_CC_MDSS_AHB_CLK>;
> -                               assigned-clock-rates = <300000000>,
> +                               assigned-clock-rates = <506666667>,

Why not simply remove the clock assignment and set the rate based on the
OPP when the driver probes?

>                                                         <19200000>,
>                                                         <19200000>;
>                                 operating-points-v2 = <&mdp_opp_table>;
