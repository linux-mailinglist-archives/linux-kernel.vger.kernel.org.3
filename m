Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F6D507300
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbiDSQfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354647AbiDSQf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:35:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CD028E24
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:32:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ll10so15903861pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+beZKhadRb9QR42fP8opIh478PeXQ0qU4zFY/sETBqY=;
        b=kMjol9V1uY4GXuzugDURnjy4OL0zU3Kg9Sl71oCy6WD3M64lIJrWISqaCrVfpUDowz
         f/vEiXwG4l58b+bxXYnG09TkvPqHTwO8QcgBrkVBzNILvLexWG/zYhvtdqNhrqvqzn8/
         /laU5shLdQ5E+Jnjg56PvuSOYvxwg+IbXVgT5qBxyaDMZdskTu5kktj3IwolBZqZepjD
         yXs8eDs0w/nY6LkjFzxKG6qkqxe+PaJz3Q5uAaREH0ucJN8SKf386d3CqfW7PQ/LIs94
         wkB1tZuWaPAGrFnXB2QGRceVBzMXTtcPQ9fxjXR0RIe9y4H/cKFvUfXEsQTSimEFr87a
         nt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+beZKhadRb9QR42fP8opIh478PeXQ0qU4zFY/sETBqY=;
        b=vDviuPvRtL2DtW4ufAuX2GCKK6s9q/E1Bkjk+ZQube6Oy8E/7Nkbecw1o1OG4hUIp7
         TT5eGvNVGzsobcPEfc7o0K1XR4/ULKWeJCHY+e0Zsu2mfjc4LX4fYETm41bHghV48dmW
         OJN1SwuidJx3AqD9qg0yU4szl6qbnVDU15O1O9HRYLBHyAixsYxwWmztsOIHwFpVXXCr
         q86Zvw5SjkJ5oM47WF962kup3IG0Mb0GlMEDbYcy8qCQzy6rr47QLHjmiMenIDatHVkn
         RpFfC/Wetmei3yTgXGviB7+HBb+O3q9TZfPtllCq02PguFkdzH3R68IBLGkEYRnYNdKI
         Tb2A==
X-Gm-Message-State: AOAM532meKNqXoDshV6mcSMS7HCeE8EH7V227DcNTDCWp1Pa86Vekhpo
        mlhGEQtTnFCYKZCc3GpQblgZMIMYj9nnZ5dLnwoxsA==
X-Google-Smtp-Source: ABdhPJx+0ojjTdq9N+q8WWzG1w7KU/sBXKZQo/lqOyZDziKDKzmIAXjaEVd0n4p7TGFBLF/kXrKOMbcOFFkd9Ou1E5Y=
X-Received: by 2002:a17:90a:6501:b0:1ca:a7df:695c with SMTP id
 i1-20020a17090a650100b001caa7df695cmr19913891pjj.152.1650385963261; Tue, 19
 Apr 2022 09:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649989179.git.Sandor.yu@nxp.com>
In-Reply-To: <cover.1649989179.git.Sandor.yu@nxp.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 19 Apr 2022 18:32:32 +0200
Message-ID: <CAG3jFyuhe9CJBLuqKH9u9NSujkqkOhh4NJ59xOD8xEVNO7gnEg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] DRM: Bridge: DW_HDMI: Add new features and bug fix
To:     Sandor.yu@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        shengjiu.wang@nxp.com, cai.huoqing@linux.dev, maxime@cerno.tech,
        harry.wentland@amd.com
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

On Fri, 15 Apr 2022 at 04:43, <Sandor.yu@nxp.com> wrote:
>
> From: Sandor Yu <Sandor.yu@nxp.com>
>
> This is new features and bug fix patch set for DW_HDMI DRM bridge driver
> that has verified by NXP i.MX8MPlus.
> Two new feature added:
> 1. Add GPA interface for DW_HDMI Audio.
> 3. New API for reset PHY Gen1.
> Two bugs fixed:
> 1. Enable overflow workaround for all IP versions later than v1.30a.
> 2. Clear GCP_Auto bit for 24-bit color depth to pass CTS.
>
> v1->v2:
> 1. Save CEC interrupt registers in struct dw_hdmi_cec
> 2. Restore CEC logical address register by cec->addresses.
> 3. Default enable overflow workaround for all versions later than v1.30a.
> 4. Add clear_gcp_auto flag to clear gcp_auto bit for all 24-bit color.
> 5. Remove i.MX8MPlus specific reference.
>
> v2->v3:
> 1. Drop the patch of Add CEC Suspend/Resume to restore registers.
> Because it is not a general feature for other SOCs, their CEC engine are
> enabled in suspend for CEC wakeup.
> 2. More detail comments for patch GCP only for Deep Color.
> 3. Address coments for patch GPA driver and move enable_audio/disable_audio
> from dw_hdmi_phy_ops to dw_hdmi_plat_data.
>
> Sandor Yu (4):
>   drm: bridge: dw_hdmi: default enable workaround to clear the overflow
>   drm: bridge: dw_hdmi: Enable GCP only for Deep Color
>   drm: bridge: dw_hdmi: add reset function for PHY GEN1
>   drm: bridge: dw_hdmi: Audio: Add General Parallel Audio (GPA) driver
>
>  drivers/gpu/drm/bridge/synopsys/Kconfig       |  10 +
>  drivers/gpu/drm/bridge/synopsys/Makefile      |   1 +
>  .../drm/bridge/synopsys/dw-hdmi-gp-audio.c    | 199 ++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 186 ++++++++++++++--
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     |  16 +-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c        |   2 +-
>  include/drm/bridge/dw_hdmi.h                  |  11 +-
>  7 files changed, 400 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c

Fixed two checkpatch --strict formatting warnings.

Applied to drm-misc-next.
