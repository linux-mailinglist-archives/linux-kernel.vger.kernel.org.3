Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED384D222B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350126AbiCHUGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350121AbiCHUGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:06:38 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388ED4A3FF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:05:41 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id x26-20020a4a9b9a000000b003211029e80fso314525ooj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=QX67c8/LWZdvLCoz7zI9uFhqDQjOSWv595jQDqaaHvw=;
        b=AoYICMH8irjSWwtZb+Z4eLYjCkWJeNSak3Ym+tkyXo7JKkBgfi/ApgCW8h+4uiTLk4
         9/ZBh92aXPInfCxmDlAWVb4MzPrC9fWhQAXR1EaTZrKwakYnK4HXEBRhrYs3Ep5zfB2E
         sF7dLTDPwJru+Mre8SMqknSkzXsiym3TOgeUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=QX67c8/LWZdvLCoz7zI9uFhqDQjOSWv595jQDqaaHvw=;
        b=PQBmXQYxElCyp+GpweGFY0uPS/JTvoP9j1aWe09mxSD2Qj8mjScXI+JmQu9H+pH2bp
         UbEeSOgYe0CAYQ0w+lypOeBXlkrfolrhFkguCiWtisjuhFXvbBQn7GqL+aG18AVGXiAg
         uiXkSWmbDtFwhSvSKwLYuNrTRRbeyUB/XpsapkfmI7/WVC2PJYe98J4i85grzxS6TMQq
         yhY/KNX04zzZ4RqbsXAHlDPdXRlbewpD22iWmLhcOX6TlgABSJJDE6bpnU/6YuSJwpi2
         tNGEhufMWhj4nq3lV1AR6WbGVFUUVIO4EZwKGmEXfaBX2U3OXsQIQk0bdp78ixwIltx7
         GXdA==
X-Gm-Message-State: AOAM532yOtmp3ecsxfAcCXo555YhkWxWi09Uskl17Pjc/J4RjtSZKkfN
        cbrmjKKxqjUKjOxkpVOgTET19Yj445c8Tbd/17+icA==
X-Google-Smtp-Source: ABdhPJxFRuIHirmuMcP8JQW2CiIQQrW1zixcggRe6oOvjNpt2ZWhCvmWo6ALkosrHI8M9jLM4bLDX5HuCCoQWjlEW1Q=
X-Received: by 2002:a05:6870:d250:b0:da:b3f:3211 with SMTP id
 h16-20020a056870d25000b000da0b3f3211mr3425601oac.193.1646769940572; Tue, 08
 Mar 2022 12:05:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Mar 2022 12:05:39 -0800
MIME-Version: 1.0
In-Reply-To: <1646758500-3776-2-git-send-email-quic_vpolimer@quicinc.com>
References: <1646758500-3776-1-git-send-email-quic_vpolimer@quicinc.com> <1646758500-3776-2-git-send-email-quic_vpolimer@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 8 Mar 2022 12:05:39 -0800
Message-ID: <CAE-0n51bfqWs8yOiyQ-A_bEQ7CZSqavz8epcFEWYyZxxoRYFHg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] arm64/dts/qcom/sc7280: remove assigned-clock-rate
 property for mdp clk
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_kalyant@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Polimera (2022-03-08 08:54:56)
> Kernel clock driver assumes that initial rate is the
> max rate for that clock and was not allowing it to scale
> beyond the assigned clock value.

How? I see ftbl_disp_cc_mdss_mdp_clk_src[] has multiple frequencies and
clk_rcg2_shared_ops so it doesn't look like anything in the clk driver
is preventing the frequency from changing beyond the assigned value.

>
> Drop the assigned clock rate property and vote on the mdp clock as per
> calculated value during the usecase.
>
> Changes in v2:
> - Remove assigned-clock-rate property and set mdp clk during resume sequence.
> - Add fixes tag.
>
> Changes in v3:
> - Remove extra line after fixes tag.(Stephen Boyd)

This changelog should be removed.

>
> Fixes: 62fbdce91("arm64: dts: qcom: sc7280: add display dt nodes")

I thought folks were saying that this is bad to keep? I don't really
mind either way, but I guess it's better to drop the fixes tag because
this is largely a performance improvement?

> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
