Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F12531EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiEWWwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiEWWwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:52:45 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C9F9BAC4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:52:44 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id b11so4498586qvv.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUVpHrGsWFdpmHijjTHWgW3zbODgXYO9/RKM5yTRDuI=;
        b=dbwT19t5cpVruIALgVmfGy44+S5C32idyjwxhDCuTYIvCRilH0ylGpz6YxpJPRg+xn
         MEg4hduZqdTC46dHgHZNetXKPRkJT+V0xntPmDgNck+9MGz049AyhRjDVo+T9DdR0nyH
         rkxTcTti1/4X39o14uHqaGdH/w3KW/zqoIfUlMWVbR6VcJhXsytkmfjtPNI2IGVze1IE
         0Q+oyv1yhdkLWhjIKaI7oLbk1edD+liaDjWF4+Lv35Rxgt8/r9VircuNHbltNvVsadcx
         0izyRQYCDe7bUrJvl/zQrTR2TSPnv5/fVQpNV4ONkyk3sqAJxl6mz8GyruRIIOjwECNb
         mo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUVpHrGsWFdpmHijjTHWgW3zbODgXYO9/RKM5yTRDuI=;
        b=5M3DFBPzL+iy3AA1L0lwGQmv3V0odWJg0+Q73yz8JJQ3A8U5cA22zVT8twOH8yuD05
         8eSmPwF+dNRIMGmuaifoJ+/APg4z3TTotLM1gM7z1iTG8F26acWvT225fwqGJcJi4O34
         RLfL4XI9DueaItuRZq4xsXswsJNGkGkBv76D+/uIUYKLmUEHmjAwWpCbdTCugxnRoD/K
         sKJM/Wasr1vmCbaqp56QcrbDExNGY9wQb2LlzS5S1GlLfH0e673ec15CmcMJdu5z9Ump
         mYMQffZGYzFvrdag1tk7PptE1l3iyZTwHGG06cavaTC1oEuqkI3QdM35wTJjVbKzPJph
         xApA==
X-Gm-Message-State: AOAM5318Y7oegyLAIE1GJNdE2nRw9FDNYNpyEse5X9GVslSvg0UdOWVJ
        RdQr+y+n+soHQgjf3NdcilwC9CrsbBwScgfrZFwNCg==
X-Google-Smtp-Source: ABdhPJz0L862d4LbPRYNVicS2bt3U+l7geWkMJ97OKfiAKAymqSQWmgMZll4IQHbb+ItHL14MvPGMGWpODDcIwbZ36g=
X-Received: by 2002:a05:6214:931:b0:461:d289:b7f6 with SMTP id
 dk17-20020a056214093100b00461d289b7f6mr19245958qvb.55.1653346363592; Mon, 23
 May 2022 15:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220523213837.1016542-1-marijn.suijten@somainline.org> <20220523213837.1016542-10-marijn.suijten@somainline.org>
In-Reply-To: <20220523213837.1016542-10-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 May 2022 01:52:32 +0300
Message-ID: <CAA8EJpqfS6xi40Zewm+v7La=jER5CR6s1=htn1C7jLka5SuKGQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] drm/msm/dsi_phy_7nm: Replace parent names with clk_hw pointers
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>
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

On Tue, 24 May 2022 at 00:39, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> parent_hw pointers are easier to manage and cheaper to use than
> repeatedly formatting the parent name and subsequently leaving the clk
> framework to perform lookups based on that name.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 92 +++++++++++------------
>  1 file changed, 42 insertions(+), 50 deletions(-)
>

-- 
With best wishes
Dmitry
