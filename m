Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF46587309
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiHAVXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbiHAVXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:23:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511962A72D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:23:02 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id k25-20020a056830169900b0061c6f68f451so9086973otr.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=9mmgjmEfi+Pg8SxIlnb6z90AkOOq77tXAXYNH2j8r6c=;
        b=VPwlC71IfmGW7jPQEyXLB72afN/1A/fwLOhvIvdGAMmffhnD0IATcH9CjCi+39TpO2
         Ukvgw5hg33gf8eijtv+C+MgESZ4VgU+2fWQvbhoV9BUeg36vW3O9iuJ3U0UHTPKAWS/K
         OKj2Sg6PR520xucLZYh5MRVZyBTlCosijLq1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=9mmgjmEfi+Pg8SxIlnb6z90AkOOq77tXAXYNH2j8r6c=;
        b=skThDQGIvc2vBl9CMlvm1EuIELmDQx92PXtrzVz0oLt3keaA2P5xsAAuiwchk9+bHm
         I/3swc0Oz2kOiPbRlQDzHvK5hPuSIGbFnY6w6hEN648GJ8zMO/T5C2EK2mBOXZxOdr3M
         d/PH3lkgEcRXYGWTeOMpjeLLxED5Bttd39FV+BFcVoQlyMbwp0w6ur6j3NGnPR7i5Vq9
         owTQ0qW3SNL5eu1gJDIu5N9+pnb95P3tvaprUX5EYiBzx/1rxf/vhI4XhXFkwk8OgQPp
         DAa28M/qam/jjXavqGVyHPWQJwXK+MuWzw9tO/tNOn9nXP+4jhaSZAQw/PlzbDU1lEma
         P+IQ==
X-Gm-Message-State: AJIora/j6que/FzRtUauPYlwzXF4itQnCtcyMaTVfL+rSzR26Pyx49qh
        JZnR4czcN6+PGDkUjqgmCAjaTwiYnL5Msxe0KyszeA==
X-Google-Smtp-Source: AGRyM1sUB8eswJRQLrjOnWt5dJ6AtP8vAygSNit8h9wqXLud09ajwRml5TZPxv8NkDyBb3vu1U97mtm3o3BLiJrw72c=
X-Received: by 2002:a05:6830:2645:b0:61c:b7cd:bde3 with SMTP id
 f5-20020a056830264500b0061cb7cdbde3mr6503564otu.73.1659388981595; Mon, 01 Aug
 2022 14:23:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Aug 2022 16:23:01 -0500
MIME-Version: 1.0
In-Reply-To: <1659384830-9909-1-git-send-email-quic_khsieh@quicinc.com>
References: <1659384830-9909-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 1 Aug 2022 16:23:01 -0500
Message-ID: <CAE-0n51ZaL9skMN=PGog5=i4e1FX2tA2BDFYSTGfCDxMcXF55A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: delete DP_RECOVERED_CLOCK_OUT_EN to fix tps4
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-08-01 13:13:50)
> Data Symbols scrambled is required for tps4 at link training 2.
> Therefore SCRAMBLING_DISABLE bit should not be set for tps4 to
> work.
> RECOVERED_CLOCK_OUT_EN is for enable simple EYE test for jitter
> measurement with minimal equipment for embedded applications purpose
> and is not required to be set during normal operation.
> Current implementation always have RECOVERED_CLOCK_OUT_EN bit set
> which cause SCRAMBLING_DISABLE bit wrongly set at tps4 which prevent
> tps4 from working.
> This patch delete setting RECOVERED_CLOCK_OUT_EN to fix SCRAMBLING_DISABLE
> be wrongly set at tps4.
>
> Changes in v2:
> -- fix Fixes tag
>
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
