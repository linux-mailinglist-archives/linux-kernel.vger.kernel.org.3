Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9485A9244
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiIAImb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiIAIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:42:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4061314EB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:42:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq23so23400858lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=RvfIkWc0bW8B7wnGaAcM/Ac2S5bgNnC3+MvXeeZ8fuk=;
        b=eRLDtnk9qCQJEwuChBabwNsXau6eGMaipUQ3wrr1P5QJyAo8ubW3G8T/7Eg1I7JCKg
         6BB9O/e6efJTNIr3w4O4xEcNnSTIQChDAXVannRrAX6lhl6/Pti++etEz5rDUMR9GkxQ
         2ATUNY4AmrdsgN8abNyz4E0ecc+koIWTb1top4tFJPoc9BiOOwhKDpdNvwHe84vTdoV7
         Oofn8CwOKXVEfP45iB7dZ0hkyzodUaOnwGpt5Y0ms6BXqj+WsHQWunY7sb8Kg+yro58t
         acqvNAoM1/QfXNaNrmniEjQkPj+N2KmqH8/A7OBN8WlvH9i9IC1N8FYr/f/YZuYaCuhY
         WCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RvfIkWc0bW8B7wnGaAcM/Ac2S5bgNnC3+MvXeeZ8fuk=;
        b=IYKd7VymjzLsFGD3WyZ5mM6JIXVHUdSJyrgWUqlar9fz8dw0kC6VHuTlS5RQYMDLL6
         cKwe/YAo2Cl7Ahaj4b+O+BgjDs0yUdSqZLinWOBQq2r5GkBMCCxLk1vkhsy62nzIO59y
         IPlXhJFElmGqgetjplLV7Dw1Xg/IyzQmJLs0pjpgnYezCHXvNjFbIVPm7YUE+nFc6RX5
         Zq1nN6pxC+14x8IXh0xCEcag0P2GfVvCNfsqgpOGQ9LYPPaa5LiEaRDC+sCJMMrZIDcE
         GbTcf/CUyFmDOhxwaJcg81VXx5VERVT7no2vdcgRxhiD00b/wm5UjC+eKSqp0YFYUX3+
         yBhw==
X-Gm-Message-State: ACgBeo0vq09guunRcpihUjTrQ/lFf39rErRMHIU3A2jUbWR9J5FfvU3K
        37T9t4CdQr5pl4zBy5k91DmDgA==
X-Google-Smtp-Source: AA6agR7hAot1/XTvtAntt8TEbAoNfzNE+fTLSxY8/82G5LZY2RV30hpblCF1wuPvOUz0eoWcoxq2Ng==
X-Received: by 2002:a05:6512:12c5:b0:48c:df54:a41a with SMTP id p5-20020a05651212c500b0048cdf54a41amr9799353lfg.464.1662021744393;
        Thu, 01 Sep 2022 01:42:24 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i3-20020a2ea223000000b00262fa7bae79sm1992830ljm.81.2022.09.01.01.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:42:22 -0700 (PDT)
Message-ID: <23615048-dae5-d972-9b10-ff1356c0a02f@linaro.org>
Date:   Thu, 1 Sep 2022 11:42:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] drm/msm/dsi: Set panel orientation when directly
 connected
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20220706191442.1150634-1-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220706191442.1150634-1-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2022 22:14, Stephen Boyd wrote:
> Set the panel orientation in drm when the panel is directly connected,
> i.e. we're not using an external bridge. The external bridge case is
> already handled by the panel bridge code, so we only update the path we
> take when the panel is directly connected/internal. This silences a
> warning splat coming from __drm_mode_object_add() on Wormdingler boards.
> 
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> This relies on commit 5e41b01a7808 ("drm/panel: Add an API to allow drm
> to set orientation from panel") which is in drm-misc

With the msm/dsi being switched to DRM_PANEL_BRIDGE this is no longer 
relevant. Dropping this from the queue.

-- 
With best wishes
Dmitry

