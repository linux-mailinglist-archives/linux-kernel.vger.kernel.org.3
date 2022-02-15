Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0504B66C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiBOI6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:58:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiBOI6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:58:51 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7455989CCA;
        Tue, 15 Feb 2022 00:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644915521; x=1676451521;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2tcfDxeDAVM/eJu/wovPGYvQnd2sBsEVvR4TYdoGVlQ=;
  b=JxxKMoioi2Ew9izQjAUVO8jHBBI5dJp73IPSKIRwkcAVhm29Mpd1YwnH
   qbA3OwfksiG+hbeSUt8JzEVcQoRnbkD+Pl2ufK5hz+hzo82uRswrw7szT
   MhI6pwbRq6TE36pY/ZRsrYgmujOgAPWpxpY19h0ilXWmd3L7z1p8OcX0O
   oObkwMDy3xyKnbh/KPahFR0qdvjdWyEXS9LxeDypDHK8rTcXAIGz8EzU7
   p73ec2d4DGWBMSxbIpBlmYmMhJz3JJglalrmIj5zTiwTsGzzL7JpOwpyT
   Ws82GsLaKSLwJzoERUZ1mBeLRWX/OHDezXE5XnosVUbGvLn+NTkS/3HOU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230924961"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="230924961"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:58:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="680924474"
Received: from ylian16-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.20.230])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:58:36 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        dmitry.baryshkov@linaro.org, bjorn.andersson@linaro.org
Cc:     quic_sbillaka@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_abhinavk@quicinc.com, Kuogee Hsieh <quic_khsieh@quicinc.com>,
        quic_aravindh@quicinc.com, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add connector_type to debug info to
 differentiate between eDP and DP
In-Reply-To: <1643828199-8564-1-git-send-email-quic_khsieh@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1643828199-8564-1-git-send-email-quic_khsieh@quicinc.com>
Date:   Tue, 15 Feb 2022 10:58:33 +0200
Message-ID: <87v8xg5ww6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2022, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> 1) Add connector_type to debug info to differentiate between eDP and DP
> 2) add more debug info to cover dp Phy
> 3) repalce DRM_DEBUG_DP with drm_debug_dp

In the future, please include the drm/msm/dp prefix also in the cover
letter. Thanks.

BR,
Jani.


>
> Kuogee Hsieh (3):
>   drm/msm/dp: add connector type to enhance debug messages
>   drm/msm/dp: enhance debug info related to dp phy
>   drm/msm/dp:  replace DRM_DEBUG_DP marco with drm_dbg_dp
>
>  drivers/gpu/drm/msm/dp/dp_audio.c   |  49 +++++++++------
>  drivers/gpu/drm/msm/dp/dp_catalog.c |  34 ++++++-----
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 116 +++++++++++++++++++-----------------
>  drivers/gpu/drm/msm/dp/dp_display.c | 103 ++++++++++++++++++++++----------
>  drivers/gpu/drm/msm/dp/dp_drm.c     |   4 +-
>  drivers/gpu/drm/msm/dp/dp_link.c    |  99 +++++++++++++++++-------------
>  drivers/gpu/drm/msm/dp/dp_panel.c   |  43 +++++++------
>  drivers/gpu/drm/msm/dp/dp_parser.c  |   2 +-
>  drivers/gpu/drm/msm/dp/dp_power.c   |  20 ++++---
>  9 files changed, 283 insertions(+), 187 deletions(-)

-- 
Jani Nikula, Intel Open Source Graphics Center
