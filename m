Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A35524105
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349226AbiEKXZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245183AbiEKXZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:25:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775CC202B31
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:25:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so6125173lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7ee9VsqZs3R0q1Ol8XBVP7c4JuwLiaeH0j2GOCI20bk=;
        b=TXIawwqIYCwHSUzBurh+oUQrTGWcpvKzU+K/HwaFRZzf9TqYELeMMsAai6Kvqlwtnj
         yYMSBGuACItmDIvqAk59lsZ6CWBbnyDx7jm8HSnPnngw0TtjA9volohqPAFFsCsqM4sV
         KjcbHpN+CJIcMIPcoZexrs2Tq31vUZXYVa7zme0/DUCM7sDnAHvkWuszFyhFFVwVQ4ve
         E5bZxs2l6Z0I8LJDXxcYmLzNHAM7IFGrOOChR7TWK9ylveLt6pS57zb21m+8pbBVd9Js
         L5APxcJKw0O2b5I6cRKu8Bp3vp6Z5zqTQmm5Mb0V8TXQUOIQ8sc6stX299BzezbxhSdg
         5aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7ee9VsqZs3R0q1Ol8XBVP7c4JuwLiaeH0j2GOCI20bk=;
        b=YKWnRgvLbQ5rceaj2bn/NtntkOcfMCpJvOg6ttPdA3HhlbOVZPha8zuWflyGEMaXPl
         2JqBKxF6d3DL3J/fd26xYymPgTnLhY+6BcLLZySfrGHvuB6jZeF/cfbenjgoY+MpC+k4
         2UvN097EpUvDyf9F4RrJ8OcnJheNX6t65UyWUUeeqg3kGRAl8VZRvJmcd0eHmYPPV08D
         hFF2gfFNiyV48L0KdL4UvKEuj+ujp7SitGP6LksAO8QBAFcfjGVvc8E5Vvs6WI+9nLXW
         P2oKhJJL5jUqz9H/9tntmhAokH7lmzVJfMyBjVN9mWGExCN9fdRW8G40WDeKsidVZpDX
         B/tw==
X-Gm-Message-State: AOAM530St4/pNLZsMKpskuXQgd1X/ILXDzakmOYlZiJJ990qD9MlWcw+
        6g034cD5XnfxajMvXClBrjSmXw==
X-Google-Smtp-Source: ABdhPJwQxJtLD6fYIqLpAZafjT/9q2YUVoO6GuZlPL5rawsjVyr2hZx94fTbNxBt3M/94vPZXYVH3w==
X-Received: by 2002:a05:6512:150a:b0:474:bb9:5174 with SMTP id bq10-20020a056512150a00b004740bb95174mr17407643lfb.207.1652311503777;
        Wed, 11 May 2022 16:25:03 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i3-20020a05651c120300b0024f3d1daedasm576957lja.98.2022.05.11.16.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 16:25:03 -0700 (PDT)
Message-ID: <67a91eca-a116-7db8-f905-25750d8bf4b6@linaro.org>
Date:   Thu, 12 May 2022 02:25:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] Revert "drm/msm/dsi: move DSI host powerup to modeset
 time"
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220511161539.v2.1.Ia196e35ad985059e77b038a41662faae9e26f411@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220511161539.v2.1.Ia196e35ad985059e77b038a41662faae9e26f411@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 02:15, Douglas Anderson wrote:
> This reverts commit 7d8e9a90509f1bd1d193a0c93cb8d1dbad9049fb.
> 
> The patch causes sc7180 Chromebooks that use the parade-ps8640 bridge
> chip to fail to turn the display back on after it turns off.
> 
> Let's revert to get these devices back to a working state. It seems
> like the DSI powerup problem is somewhat common and probably we should
> land something more general like Dave Stevenson's series [1] that
> would give more flexibility.
> 
> [1] https://lore.kernel.org/r/cover.1646406653.git.dave.stevenson@raspberrypi.com
> 
> Fixes: 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset time")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Remove the mud from my face.

As stated, I'm for this revert, but after getting the mentioned patchset 
in. Will that work for you? If not, I'd prefer to land a patch adding 
modparam to powerup the DSI during the mode_set or during the pre_enabel().

> 
>   drivers/gpu/drm/msm/dsi/dsi_manager.c | 43 ++++++++-------------------
>   1 file changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 50b987658b1f..8d51711a3417 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -315,12 +315,13 @@ dsi_mgr_connector_best_encoder(struct drm_connector *connector)
>   	return msm_dsi_get_encoder(msm_dsi);
>   }
>   
> -static void dsi_mgr_bridge_power_on(struct drm_bridge *bridge)
> +static void dsi_mgr_bridge_pre_enable(struct drm_bridge *bridge)
>   {
>   	int id = dsi_mgr_bridge_get_id(bridge);
>   	struct msm_dsi *msm_dsi = dsi_mgr_get_dsi(id);
>   	struct msm_dsi *msm_dsi1 = dsi_mgr_get_dsi(DSI_1);
>   	struct mipi_dsi_host *host = msm_dsi->host;
> +	struct drm_panel *panel = msm_dsi->panel;
>   	struct msm_dsi_phy_shared_timings phy_shared_timings[DSI_MAX];
>   	bool is_bonded_dsi = IS_BONDED_DSI();
>   	int ret;
> @@ -361,34 +362,6 @@ static void dsi_mgr_bridge_power_on(struct drm_bridge *bridge)
>   	if (is_bonded_dsi && msm_dsi1)
>   		msm_dsi_host_enable_irq(msm_dsi1->host);
>   
> -	return;
> -
> -host1_on_fail:
> -	msm_dsi_host_power_off(host);
> -host_on_fail:
> -	dsi_mgr_phy_disable(id);
> -phy_en_fail:
> -	return;
> -}
> -
> -static void dsi_mgr_bridge_pre_enable(struct drm_bridge *bridge)
> -{
> -	int id = dsi_mgr_bridge_get_id(bridge);
> -	struct msm_dsi *msm_dsi = dsi_mgr_get_dsi(id);
> -	struct msm_dsi *msm_dsi1 = dsi_mgr_get_dsi(DSI_1);
> -	struct mipi_dsi_host *host = msm_dsi->host;
> -	struct drm_panel *panel = msm_dsi->panel;
> -	bool is_bonded_dsi = IS_BONDED_DSI();
> -	int ret;
> -
> -	DBG("id=%d", id);
> -	if (!msm_dsi_device_connected(msm_dsi))
> -		return;
> -
> -	/* Do nothing with the host if it is slave-DSI in case of bonded DSI */
> -	if (is_bonded_dsi && !IS_MASTER_DSI_LINK(id))
> -		return;
> -
>   	/* Always call panel functions once, because even for dual panels,
>   	 * there is only one drm_panel instance.
>   	 */
> @@ -423,7 +396,17 @@ static void dsi_mgr_bridge_pre_enable(struct drm_bridge *bridge)
>   	if (panel)
>   		drm_panel_unprepare(panel);
>   panel_prep_fail:
> +	msm_dsi_host_disable_irq(host);
> +	if (is_bonded_dsi && msm_dsi1)
> +		msm_dsi_host_disable_irq(msm_dsi1->host);
>   
> +	if (is_bonded_dsi && msm_dsi1)
> +		msm_dsi_host_power_off(msm_dsi1->host);
> +host1_on_fail:
> +	msm_dsi_host_power_off(host);
> +host_on_fail:
> +	dsi_mgr_phy_disable(id);
> +phy_en_fail:
>   	return;
>   }
>   
> @@ -569,8 +552,6 @@ static void dsi_mgr_bridge_mode_set(struct drm_bridge *bridge,
>   	msm_dsi_host_set_display_mode(host, adjusted_mode);
>   	if (is_bonded_dsi && other_dsi)
>   		msm_dsi_host_set_display_mode(other_dsi->host, adjusted_mode);
> -
> -	dsi_mgr_bridge_power_on(bridge);
>   }
>   
>   static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,


-- 
With best wishes
Dmitry
