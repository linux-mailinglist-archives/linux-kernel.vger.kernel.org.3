Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828E456FFA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiGKLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGKLCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:02:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8305071BDC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:07:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bu42so7916415lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z0gWPzpnf+Fkqqtj9BV5xWECqcqhY1y27pcs8oB10pk=;
        b=USz9x/SbaDxxtjzvjpOXTqjIY7Mz9wUW+iryz/OKPMURFKzZRjviyzbB12zhJrtslY
         6aSHB4/fWCPW83DzUcvU3/ueoVONNJDF7O0QvgmHtNJXrQcmdXl0HltHAtmNd4aAq//V
         +g11Z6ZRJGlJCc5iOOpu2RR9QafTi+rymGrPE4XhZDCpeQenMqeZHyTYbQyhzhKqLg2v
         DBITsYLlulyjx63sVrcPHmZpuzo89AINn3GNyS2GOWXYCKX3GNDNniFJ/v0U5ADeeJZ0
         jWwCYFPpwpTjMAasLOSDjhmmPxkwAtpZ3q1XIcRyO2b9HDgO0gVhV0Oyek2oK+n1qSEM
         vIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z0gWPzpnf+Fkqqtj9BV5xWECqcqhY1y27pcs8oB10pk=;
        b=OgrUugtwbBEa9Ojy66aAGNt0AvazExHaaQXqO9FsloVqNipjeGYrSmdMznPL5IZp3m
         KNxa0OPBtf08OiQ/UXTQ+ADuEQheSJP1Si9Yr9J46CSgv+525AdgrO3VFD6z7kOJnWAZ
         e8yBoW7Z5n/7SNllTAGGzNiH4c6sEu5KwDlS6269yX6/n28t833phKiFbLZQ6IB4VxSP
         mJiqg55EjorF+IqV23ZpoXPbXrnTzeNIqDaMWEHautFP8NAe/GdcqsmnPfjFt18geT3u
         QMBnX/fmREFWZy24J4ZxQuNDy1NagD4j1Yweq8u4x8P9ipTNKjf/Z0167/Elw8ctMPcd
         AeXg==
X-Gm-Message-State: AJIora+N+UBEF1+UjqLiMohaRkDKezYxdBQzNq6WcVfhQw2nd3TTuwnw
        WL+SdGwkndB1ez6GyrX7CWjBpg==
X-Google-Smtp-Source: AGRyM1sQ4qfv3Gvrp6kUtXMTCc4OAJoE7ATLT59r9LNAKRYX4a5MGu0ec17krDwhI+DPHVOyIzdq/Q==
X-Received: by 2002:a05:6512:b23:b0:489:d24e:5abf with SMTP id w35-20020a0565120b2300b00489d24e5abfmr5358846lfu.636.1657534075775;
        Mon, 11 Jul 2022 03:07:55 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q22-20020a05651232b600b0047255d21190sm1449353lfe.191.2022.07.11.03.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:07:55 -0700 (PDT)
Message-ID: <9005c10b-01a6-b463-d150-1935e79f92eb@linaro.org>
Date:   Mon, 11 Jul 2022 13:07:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 00/10] Add PSR support for eDP
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, bjorn.andersson@linaro.org,
        quic_aravindh@quicinc.com, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com
References: <1657532880-12897-1-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1657532880-12897-1-git-send-email-quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 12:47, Vinod Polimera wrote:
> Changes in v2:
>    - Use dp bridge to set psr entry/exit instead of dpu_enocder.
>    - Don't modify whitespaces.
>    - Set self refresh aware from atomic_check.
>    - Set self refresh aware only if psr is supported.
>    - Provide a stub for msm_dp_display_set_psr.
>    - Move dp functions to bridge code.
> 
> Changes in v3:
>    - Change callback names to reflect atomic interfaces.
>    - Move bridge callback change to separate patch as suggested by Dmitry.
>    - Remove psr function declaration from msm_drv.h.
>    - Set self_refresh_aware flag only if psr is supported.
>    - Modify the variable names to simpler form.
>    - Define bit fields for PSR settings.
>    - Add comments explaining the steps to enter/exit psr.
>    - Change DRM_INFO to drm_dbg_db.
> 
> Changes in v4:
>    - Move the get crtc functions to drm_atomic.
>    - Add atomic functions for DP bridge too.
>    - Add ternary operator to choose eDP or DP ops.
>    - Return true/false instead of 1/0.
>    - mode_valid missing in the eDP bridge ops.
>    - Move the functions to get crtc into drm_atomic.c.
>    - Fix compilation issues.
>    - Remove dpu_assign_crtc and get crtc from drm_enc instead of dpu_enc.
>    - Check for crtc state enable while reserving resources.
> 
> Changes in v5:
>    - Move the mode_valid changes into a different patch.
>    - Complete psr_op_comp only when isr is set.
>    - Move the DP atomic callback changes to a different patch.
>    - Get crtc from drm connector state crtc.
>    - Move to separate patch for check for crtc state enable while
> reserving resources.
> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> 
> Vinod Polimera (10):
>    drm/msm/disp/dpu1: clear dpu_assign_crtc and get crtc from connector
>      state instead of dpu_enc

Generic comment: please use 'drm/msm/dpu:' prefix instead.

>    drm: add helper functions to retrieve old and new crtc
>    drm/msm/dp: use atomic callbacks for DP bridge ops
>    drm/msm/dp: Add basic PSR support for eDP
>    drm/msm/dp: use the eDP bridge ops to validate eDP modes
>    drm/bridge: use atomic enable/disable callbacks for panel bridge
>    drm/bridge: add psr support for panel bridge callbacks
>    drm/msm/disp/dpu1: use atomic enable/disable callbacks for encoder
>      functions
>    drm/msm/disp/dpu1: add PSR support for eDP interface in dpu driver
>    drm/msm/disp/dpu1: check for crtc enable rather than crtc active to
>      release shared resources
> 
>   drivers/gpu/drm/bridge/panel.c              |  68 ++++++++--
>   drivers/gpu/drm/drm_atomic.c                |  60 +++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  17 ++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  55 +++++---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |   8 --
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |   2 +-
>   drivers/gpu/drm/msm/dp/dp_catalog.c         |  81 ++++++++++++
>   drivers/gpu/drm/msm/dp/dp_catalog.h         |   4 +
>   drivers/gpu/drm/msm/dp/dp_ctrl.c            |  73 +++++++++++
>   drivers/gpu/drm/msm/dp/dp_ctrl.h            |   3 +
>   drivers/gpu/drm/msm/dp/dp_display.c         |  31 +++--
>   drivers/gpu/drm/msm/dp/dp_display.h         |   2 +
>   drivers/gpu/drm/msm/dp/dp_drm.c             | 187 ++++++++++++++++++++++++++--
>   drivers/gpu/drm/msm/dp/dp_drm.h             |   9 +-
>   drivers/gpu/drm/msm/dp/dp_link.c            |  36 ++++++
>   drivers/gpu/drm/msm/dp/dp_panel.c           |  22 ++++
>   drivers/gpu/drm/msm/dp/dp_panel.h           |   6 +
>   drivers/gpu/drm/msm/dp/dp_reg.h             |  27 ++++
>   include/drm/drm_atomic.h                    |   7 ++
>   19 files changed, 634 insertions(+), 64 deletions(-)
> 


-- 
With best wishes
Dmitry
