Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB3588AE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 13:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiHCLJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 07:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiHCLJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 07:09:30 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CB41AD8B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:09:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h22so12314240qta.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ni8odVu9N3fk9U9c9SMmRIWk/Y6CS1n2Honac+jmqgs=;
        b=Th5oMiLjG03N9iifNJ+PqTAXgjG8zvJ0AEDvGCFY4OmRya8dUm1vyXHag+GTqc/UH9
         g63yIX90v3j3GhyXhCtEJR8a97K9KRbms0q9AZb4WCqU0tDqUTBM7403hP+yEHMKTMAs
         8Fgwcm5ZP06m4PxK/WZEmfee7579c4OpAMvGP8/JHVyvgGC2BQoq3QYN11tI/rTw3M4a
         Km0n4F/sLlmf1Qyy+NtyQXRKCk+Kfewv+RMWDeNiuSn2pyzn27e7C0dRCRftX30AXelh
         dH+n7OCSzAjSKZfS0OYZeQl1GihHZVFu1rpsE45QcePSqDaYKKLmnRoLDg9+R3Z5vAzZ
         eRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ni8odVu9N3fk9U9c9SMmRIWk/Y6CS1n2Honac+jmqgs=;
        b=2Qc/IJs/j2EQsuU1IEWwo6ZBAqoo0JlejIOnoUFh5hkiCHq1+1tGClYHlT9gz4wUa9
         P5cg+26/Hrs4Hjd8uP5/VFbG1BwUVZii1RCjn9BeKvqLgDksdZ12OTUWozfsbpU8GF1U
         g/LTw5OCP83kIvyUU+zimdbhCGyxJvJ1nDj/TtSBFtviCTeRSCBQj3UIBRqnERcrcEjQ
         M8Aox2nm64HYGjgVgGs4E74FKcl1gpqCMM/hge8st6oQelcLIZfVxavNYbBS850vbMzU
         SjGnTKHln3B0uQNb05HoJu39+OAb1MmjMxRWdMlqw4L5xeudelXKsGxzkXiJSaWoSY7m
         HHww==
X-Gm-Message-State: AJIora9kK6cQjEa93pIzYuaOMw0lh6VqpXue/hWn5rFHxdmppNXZZkgQ
        dQzMHxiACVc+M/I1d1Pu9AIoQdHaw53KJxodWAKhoA==
X-Google-Smtp-Source: AGRyM1seDx27XYMUBT57CYfQofAFqfovuO2uZ8Up/W6X6P7dbfW63+VBwTQvz9D+Wu7uMwiNerkJzyu2CRWYpP9Q8cE=
X-Received: by 2002:ac8:5942:0:b0:31f:39f6:aba7 with SMTP id
 2-20020ac85942000000b0031f39f6aba7mr21127160qtz.295.1659524968328; Wed, 03
 Aug 2022 04:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220730150952.v3.5.I176567525af2b9439a7e485d0ca130528666a55c@changeid>
 <8715e07f-9d58-1ae3-9a3a-25828b545905@linaro.org> <0a81938b-f30e-fa78-fd73-c753af4e324b@quicinc.com>
In-Reply-To: <0a81938b-f30e-fa78-fd73-c753af4e324b@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 3 Aug 2022 14:09:16 +0300
Message-ID: <CAA8EJppAprzF5S-zvYYo53QenosUkXU49kiWWzWndVwhWZgS7Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] drm/msm/a6xx: Ensure CX collapse during gpu recovery
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2022 at 13:15, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 8/2/2022 12:44 PM, Dmitry Baryshkov wrote:
> > On 30/07/2022 12:40, Akhil P Oommen wrote:
> >> Because there could be transient votes from other drivers/tz/hyp which
> >> may keep the cx gdsc enabled, we should poll until cx gdsc collapses.
> >> We can use the reset framework to poll for cx gdsc collapse from gpucc
> >> clk driver.
> >>
> >> This feature requires support from the platform's gpucc driver.
> >>
> >> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> >> ---
> >>
> >> Changes in v3:
> >> - Use reset interface from gpucc driver to poll for cx gdsc collapse
> >>    https://patchwork.freedesktop.org/series/106860/
> >>
> >>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 ++++
> >>   drivers/gpu/drm/msm/msm_gpu.c         | 4 ++++
> >>   drivers/gpu/drm/msm/msm_gpu.h         | 4 ++++
> >>   3 files changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> index 1b049c5..721d5e6 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> @@ -10,6 +10,7 @@
> >>     #include <linux/bitfield.h>
> >>   #include <linux/devfreq.h>
> >> +#include <linux/reset.h>
> >>   #include <linux/soc/qcom/llcc-qcom.h>
> >>     #define GPU_PAS_ID 13
> >> @@ -1224,6 +1225,9 @@ static void a6xx_recover(struct msm_gpu *gpu)
> >>       /* And the final one from recover worker */
> >>       pm_runtime_put_sync(&gpu->pdev->dev);
> >>   +    /* Call into gpucc driver to poll for cx gdsc collapse */
> >> +    reset_control_reset(gpu->cx_collapse);
> >
> > Do we have a race between the last pm_runtime_put_sync(), this polling
> > and other voters removing their votes beforehand?
> I can't see any issue with a race here. reset_control_reset() will
> return immediately in that case.

Ack, ok then.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
