Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365A64C068E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiBWBBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiBWBBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:01:03 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2241847382;
        Tue, 22 Feb 2022 17:00:36 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d17so1829012wrc.9;
        Tue, 22 Feb 2022 17:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XG2WJdS64Zv9xka8Qt6oMTSA17ZmaSgIVCdRSg9oCbM=;
        b=DeOnaD5P4Lhhd2HeWPLW/pcTMV+nWweTaPBFJW+9UbVYq8fDWdvSwZNkLVbcf8mqq7
         ZSt1ZSfbwfUSF3IsWu60W72SxId+T4CY25htuVkb8clEN/hR1l9vKwWseJ570iczN64b
         V2aurt/i0THReQj7ATd/7j0KZc84YgEoDPo/4aSlfbCul0S0KKZf8ONsT2mS42z4W7+s
         eHJVKADSpdIDvONxIqXEQr4eHc1ZfVr5WFhQu+onfBA80jOjmIsQ0Ve91bCNpkCBxN1h
         iS24esJJrGAFYwrc3rNhDUjOnN/qMXpk6PeKsGN4WqUawJ2QAGgCMHIfnee6m8jANo1/
         rCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XG2WJdS64Zv9xka8Qt6oMTSA17ZmaSgIVCdRSg9oCbM=;
        b=ywvyysfuYcOGlkYIgZ3Gz1VWAnJNR/nQTW5v8dvrJaFl9rNSSQkM/5wuRlhEoizVNZ
         Ch/v+TwusEJxiMKbkKWD8oYKvvOzAPbzDdqC7hvt06Ri4plmzkxlkOMVHj0oNuaeRkIZ
         403TBDEFmVAYBcNjYTghHMdEoz59ncmwVgNBnFoGs+IycKP59BwuTX3l0h3wuQ1CTJh/
         hpBgyfkKO6LX+JL4KkdJEUfTXVmokv8+dysJWpZrfb5QJcy/IZKVukPujxCl5Sg1b45j
         0DLr/GEosXOt+3z64vgeUG0985yxysotakN3wrHKG5y2ch3zSRNmbekckKaixWo5BHP5
         vqCQ==
X-Gm-Message-State: AOAM530Te1u4EM0yC+80Z2/OplYt8ICIp8SLBIKaEdS7SQEh66TYuNtC
        Ed7hxi5CVthAbB0/o7XsV3BhAea3A4zsIxNYi7jUIWIH
X-Google-Smtp-Source: ABdhPJxIURKeTA1QUcPbVoVTcHRlzqa0GY9K67gjU65XtpVZWAn1l2OUwllxJtPnac3iRFwrHB7EgaSI1sUkL1SMzfo=
X-Received: by 2002:a5d:5847:0:b0:1e3:ee8:e6c7 with SMTP id
 i7-20020a5d5847000000b001e30ee8e6c7mr21707901wrf.328.1645578034712; Tue, 22
 Feb 2022 17:00:34 -0800 (PST)
MIME-Version: 1.0
References: <1645454462-27867-1-git-send-email-quic_akhilpo@quicinc.com>
In-Reply-To: <1645454462-27867-1-git-send-email-quic_akhilpo@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 22 Feb 2022 17:00:54 -0800
Message-ID: <CAF6AEGtF440x7Sho03ujeL6J4XXqOrF_NcqiQXGTewwLM5SObA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Support 7c3 gpu SKUs
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Feb 21, 2022 at 6:41 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> This series supercedes [1]. Major change in this series is that it is now
> optional to include a gpu name in the gpu-list. This helps to avoid the
> confusion when we have different SKUs with different gpu names. And also
> I am pretty happy that the overall changes are smaller now.
>
> [1] https://patchwork.freedesktop.org/series/99048/
>

Other than a nit in 2/5, this looks good to me

BR,
-R

>
> Akhil P Oommen (5):
>   drm/msm: Use generic name for gpu resources
>   drm/msm/adreno: Generate name from chipid for 7c3
>   drm/msm/a6xx: Add support for 7c3 SKUs
>   drm/msm/adreno: Expose speedbin to userspace
>   arm64: dts: qcom: sc7280: Support gpu speedbin
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi       | 46 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 18 ++++++++++--
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  1 -
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 35 +++++++++++++++++++----
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  3 ++
>  drivers/gpu/drm/msm/msm_gpu.c              |  4 +--
>  6 files changed, 96 insertions(+), 11 deletions(-)
>
> --
> 2.7.4
>
