Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B93659C3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiHVQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbiHVQSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:18:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060ED2C644
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:18:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l19so7948023ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1Hr7SjKBusnPB/mCwhMi+HTasXJ+kgjUChQRe0sHC4c=;
        b=VZYHkaUxFphhVCpOzMwyrR83EdFG4s5zPBA3RysDY6Eg7ujIBgxsxUXezLtWCArBLy
         /rbfXHq9tqqbefZR/wQDNPi2bdaJ4rpXnOqtz/086QDIL+eenDOAO1MzJ9HA/G9e9jAb
         vtXFMeFHEvZWxwwXWPAgZhjCgRfdIe1gfjQ8RzVdd7uWGg36qGzlS0KNMnlxnLkcmRdp
         R/FjJWCt4EPfNpDYDtNVAppLifgAD4WVZS93Deqtb57zktPHZw/PvYcREatlbDNfJZk8
         6OlBUYvPFNArhk0eIPqA2QUGk4HPqB5evxe46vrF+1wiMvCf+8bwkBq37h7E7MxbFUom
         MVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1Hr7SjKBusnPB/mCwhMi+HTasXJ+kgjUChQRe0sHC4c=;
        b=afg975r61HSWcKcrLABVqGGgewMeoFDLL8+ev7DRjrHCQwE2iQxF16PrKe00haHdUC
         Rkypgl345WvdMN9CQ2/zsPyjDeNE6EKIOVu0uzLh1XSeG5DUOtnvXne1qKcm7pRA9WT/
         NbUYcZAifL9zqPQu/K70/100um9Wn8c+Dl4M8lIZKbCKT5YDTkFV3ZO9xHlQ3F3A3o8v
         CutqZbQ2o1ThHWh4Elev09KqMHX+TI+8xVNfRvEMyfSDMyZNpjZhN4oQwvZ2ENsfyu2b
         49evRvefVuYZyIV/KS2JxnYYmUyHvGgRgMb6mHp+PhGGS26MrR8Lq+KGHcIcFtj8t4QN
         IYqg==
X-Gm-Message-State: ACgBeo2YkSIAi3RT1bq+YajDzLq7bCUTWqO77b4gX3bMO5v/5GtExRlk
        YClIYlwNjMCbAnSzwmEmsav5mw==
X-Google-Smtp-Source: AA6agR46GWQER6lDZQUost5Rtlh4FosszefiNZP7xBW2a5jcfTvEBwoKdziELVVeMY2QYWIF6/dfEg==
X-Received: by 2002:a2e:9d5a:0:b0:25e:2c67:edaf with SMTP id y26-20020a2e9d5a000000b0025e2c67edafmr6088739ljj.437.1661185119654;
        Mon, 22 Aug 2022 09:18:39 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w18-20020a05651234d200b0048b193041easm1988698lfr.209.2022.08.22.09.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 09:18:39 -0700 (PDT)
Message-ID: <f211520a-cb9c-1202-0752-7bb200726ae8@linaro.org>
Date:   Mon, 22 Aug 2022 19:18:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] drm/msm/dp: add atomic_check to bridge ops
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1660759314-28088-1-git-send-email-quic_khsieh@quicinc.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1660759314-28088-1-git-send-email-quic_khsieh@quicinc.com>
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

On 17/08/2022 21:01, Kuogee Hsieh wrote:
> DRM commit_tails() will disable downstream crtc/encoder/bridge if
> both disable crtc is required and crtc->active is set before pushing
> a new frame downstream.
> 
> There is a rare case that user space display manager issue an extra
> screen update immediately followed by close DRM device while down
> stream display interface is disabled. This extra screen update will
> timeout due to the downstream interface is disabled but will cause
> crtc->active be set. Hence the followed commit_tails() called by
> drm_release() will pass the disable downstream crtc/encoder/bridge
> conditions checking even downstream interface is disabled.
> This cause the crash to happen at dp_bridge_disable() due to it trying
> to access the main link register to push the idle pattern out while main
> link clocks is disabled.
> 
> This patch adds atomic_check to prevent the extra frame will not
> be pushed down if display interface is down so that crtc->active
> will not be set neither. This will fail the conditions checking
> of disabling down stream crtc/encoder/bridge which prevent
> drm_release() from calling dp_bridge_disable() so that crash
> at dp_bridge_disable() prevented.

I must admit I had troubles parsing this description. However if I got 
you right, I think the check that the main link clock is running in the 
dp_bridge_disable() or dp_ctrl_push_idle() would be a better fix.

> 
> SError Interrupt on CPU7, code 0x00000000be000411 -- SError
> CPU: 7 PID: 3878 Comm: Xorg Not tainted 5.19.0-stb-cbq #19
> Hardware name: Google Lazor (rev3 - 8) (DT)
> pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __cmpxchg_case_acq_32+0x14/0x2c
> lr : do_raw_spin_lock+0xa4/0xdc
> sp : ffffffc01092b6a0
> x29: ffffffc01092b6a0 x28: 0000000000000028 x27: 0000000000000038
> x26: 0000000000000004 x25: ffffffd2973dce48 x24: 0000000000000000
> x23: 00000000ffffffff x22: 00000000ffffffff x21: ffffffd2978d0008
> x20: ffffffd2978d0008 x19: ffffff80ff759fc0 x18: 0000000000000000
> x17: 004800a501260460 x16: 0441043b04600438 x15: 04380000089807d0
> x14: 07b0089807800780 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000438 x10: 00000000000007d0 x9 : ffffffd2973e09e4
> x8 : ffffff8092d53300 x7 : ffffff808902e8b8 x6 : 0000000000000001
> x5 : ffffff808902e880 x4 : 0000000000000000 x3 : ffffff80ff759fc0
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffffff80ff759fc0
> Kernel panic - not syncing: Asynchronous SError Interrupt
> CPU: 7 PID: 3878 Comm: Xorg Not tainted 5.19.0-stb-cbq #19
> Hardware name: Google Lazor (rev3 - 8) (DT)
> Call trace:
>   dump_backtrace.part.0+0xbc/0xe4
>   show_stack+0x24/0x70
>   dump_stack_lvl+0x68/0x84
>   dump_stack+0x18/0x34
>   panic+0x14c/0x32c
>   nmi_panic+0x58/0x7c
>   arm64_serror_panic+0x78/0x84
>   do_serror+0x40/0x64
>   el1h_64_error_handler+0x30/0x48
>   el1h_64_error+0x68/0x6c
>   __cmpxchg_case_acq_32+0x14/0x2c
>   _raw_spin_lock_irqsave+0x38/0x4c
>   lock_timer_base+0x40/0x78
>   __mod_timer+0xf4/0x25c
>   schedule_timeout+0xd4/0xfc
>   __wait_for_common+0xac/0x140
>   wait_for_completion_timeout+0x2c/0x54
>   dp_ctrl_push_idle+0x40/0x88
>   dp_bridge_disable+0x24/0x30
>   drm_atomic_bridge_chain_disable+0x90/0xbc
>   drm_atomic_helper_commit_modeset_disables+0x198/0x444
>   msm_atomic_commit_tail+0x1d0/0x374
>   commit_tail+0x80/0x108
>   drm_atomic_helper_commit+0x118/0x11c
>   drm_atomic_commit+0xb4/0xe0
>   drm_client_modeset_commit_atomic+0x184/0x224
>   drm_client_modeset_commit_locked+0x58/0x160
>   drm_client_modeset_commit+0x3c/0x64
>   __drm_fb_helper_restore_fbdev_mode_unlocked+0x98/0xac
>   drm_fb_helper_set_par+0x74/0x80
>   drm_fb_helper_hotplug_event+0xdc/0xe0
>   __drm_fb_helper_restore_fbdev_mode_unlocked+0x7c/0xac
>   drm_fb_helper_restore_fbdev_mode_unlocked+0x20/0x2c
>   drm_fb_helper_lastclose+0x20/0x2c
>   drm_lastclose+0x44/0x6c
>   drm_release+0x88/0xd4
>   __fput+0x104/0x220
>   ____fput+0x1c/0x28
>   task_work_run+0x8c/0x100
>   do_exit+0x450/0x8d0
>   do_group_exit+0x40/0xac
>   __wake_up_parent+0x0/0x38
>   invoke_syscall+0x84/0x11c
>   el0_svc_common.constprop.0+0xb8/0xe4
>   do_el0_svc+0x8c/0xb8
>   el0_svc+0x2c/0x54
>   el0t_64_sync_handler+0x120/0x1c0
>   el0t_64_sync+0x190/0x194
> SMP: stopping secondary CPUs
> Kernel Offset: 0x128e800000 from 0xffffffc008000000
> PHYS_OFFSET: 0x80000000
> CPU features: 0x800,00c2a015,19801c82
> Memory Limit: none
> 
> Fixes: 8a3b4c17f863 ("drm/msm/dp: employ bridge mechanism for display enable and disable")
> Reported-by: Leonard Lausen <leonard@lausen.nl>
> Suggested-by: Rob Clark <robdclark@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/17
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_drm.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index 6df25f7..c682588 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -31,6 +31,25 @@ static enum drm_connector_status dp_bridge_detect(struct drm_bridge *bridge)
>   					connector_status_disconnected;
>   }
>   
> +static int dp_bridge_atomic_check(struct drm_bridge *bridge,
> +			    struct drm_bridge_state *bridge_state,
> +			    struct drm_crtc_state *crtc_state,
> +			    struct drm_connector_state *conn_state)
> +{
> +	struct msm_dp *dp;
> +
> +	dp = to_dp_bridge(bridge)->dp_display;
> +
> +	drm_dbg_dp(dp->drm_dev, "is_connected = %s\n",
> +		(dp->is_connected) ? "true" : "false");
> +
> +	if (bridge->ops & DRM_BRIDGE_OP_HPD)
> +		return (dp->is_connected) ? 0 : -ENOTCONN;
> +
> +	return 0;
> +}
> +
> +
>   /**
>    * dp_bridge_get_modes - callback to add drm modes via drm_mode_probed_add()
>    * @bridge: Poiner to drm bridge
> @@ -61,6 +80,9 @@ static int dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connector *
>   }
>   
>   static const struct drm_bridge_funcs dp_bridge_ops = {
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state   = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_reset           = drm_atomic_helper_bridge_reset,
>   	.enable       = dp_bridge_enable,
>   	.disable      = dp_bridge_disable,
>   	.post_disable = dp_bridge_post_disable,
> @@ -68,6 +90,7 @@ static const struct drm_bridge_funcs dp_bridge_ops = {
>   	.mode_valid   = dp_bridge_mode_valid,
>   	.get_modes    = dp_bridge_get_modes,
>   	.detect       = dp_bridge_detect,
> +	.atomic_check = dp_bridge_atomic_check,
>   };
>   
>   struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *dev,

-- 
With best wishes
Dmitry

