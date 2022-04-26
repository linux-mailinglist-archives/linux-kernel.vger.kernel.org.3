Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91A6510A38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354837AbiDZUTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354850AbiDZUSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:18:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A56EA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:15:42 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bn33so23437321ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NoH+Q2JRO6SKcFvlMJuCO580Qoh6JOOoycqYQgBg9Ro=;
        b=cWB0TVSq8VKcPdtkF3M26lXQbeIW1kHtVsp0FDBMnEKF3reK6Q2MuOAyXLaMgZrW7n
         ijHrNuaCDG/pz5dROHnVVq3xj6N16Rm7onIyGZT6bacYY68GG7+vpd+wHnnabQnAXyB3
         rWjH3iOHckvnlEFaIw0/go6q29XOrF7nDGopwT98p39Tk88l58PNKSdiAJHdID6G127l
         FDeGRlU2CeFXqKI8IB48fCse5Jj7jknXvWDO2D++PLSp+Lw1JpILw2JhwMpPB32HV/5V
         Pp4n5TwBSyrUf3jONeM+VMZxd+H+e5qRkv65DR5S68TotRVguKv3Cq568cYm6GIiDjr9
         f/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NoH+Q2JRO6SKcFvlMJuCO580Qoh6JOOoycqYQgBg9Ro=;
        b=joUlVHgfxGmThFwe1Zv+8gM556iaZC9zvoiRK7+NXu3D/sLCggtKDCTRVK8VSHSU11
         VYlMAPPbX36uOc54JwlHrDAzLUGooUPxENet9rwfAmnWA3AheRDT08UxgEzFOuX6NeHf
         bLbqzOiPeoSzD9nYUg4JM2GISdpOiqQDFVt0xzMb3Q3KAG7SGVctnOCqaEeU0eyfL2vJ
         YHXoh/t1bPm4da9kgYTCw25uPHcyyyZiSuN50jLJA+1/pq4prbFt0Jbod+HZcrnwrKSg
         SJhXpZQcCcyAbTxsuTGNesG0XCkAjqc+mm4FKUGk6wfGYx6Gzqc7MdpuN92mj9SVlqi2
         NwfQ==
X-Gm-Message-State: AOAM533PUNBP34BXVMSO4IOemtL4U/TBo/qk1C5VgjRNKRBdxd4DTdva
        9I4vMwwBxughUln7ulc0MbkPjQ==
X-Google-Smtp-Source: ABdhPJz2e3A8i09zQrnVOpL83T9ubklwt+3pWXhS5CcK/Muf+ApEy2u+oQF0FV2zPUXzGlOs+SgVww==
X-Received: by 2002:a2e:3e15:0:b0:247:d94b:c004 with SMTP id l21-20020a2e3e15000000b00247d94bc004mr15684754lja.428.1651004140400;
        Tue, 26 Apr 2022 13:15:40 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d29-20020a19385d000000b004720e1cc3fasm606630lfj.70.2022.04.26.13.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 13:15:40 -0700 (PDT)
Message-ID: <5915a71f-50fa-8783-f186-7bbf9a5409c8@linaro.org>
Date:   Tue, 26 Apr 2022 23:15:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4] drm/msm/dp: remove fail safe mode related code
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1651003453-12282-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1651003453-12282-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 23:04, Kuogee Hsieh wrote:
> Current DP driver implementation has adding safe mode done at
> dp_hpd_plug_handle() which is expected to be executed under event
> thread context.
> 
> However there is possible circular locking happen (see blow stack trace)
> after edp driver call dp_hpd_plug_handle() from dp_bridge_enable() which
> is executed under drm_thread context.
> 
> After review all possibilities methods and as discussed on
> https://patchwork.freedesktop.org/patch/483155/, supporting EDID
> compliance tests in the driver is quite hacky. As seen with other
> vendor drivers, supporting these will be much easier with IGT. Hence
> removing all the related fail safe code for it so that no possibility
> of circular lock will happen.
> 
> ======================================================
>   WARNING: possible circular locking dependency detected
>   5.15.35-lockdep #6 Tainted: G        W
>   ------------------------------------------------------
>   frecon/429 is trying to acquire lock:
>   ffffff808dc3c4e8 (&dev->mode_config.mutex){+.+.}-{3:3}, at:
> dp_panel_add_fail_safe_mode+0x4c/0xa0
> 
>   but task is already holding lock:
>   ffffff808dc441e0 (&kms->commit_lock[i]){+.+.}-{3:3}, at: lock_crtcs+0xb4/0x124
> 
>   which lock already depends on the new lock.
> 
>   the existing dependency chain (in reverse order) is:
> 
>   -> #3 (&kms->commit_lock[i]){+.+.}-{3:3}:
>          __mutex_lock_common+0x174/0x1a64
>          mutex_lock_nested+0x98/0xac
>          lock_crtcs+0xb4/0x124
>          msm_atomic_commit_tail+0x330/0x748
>          commit_tail+0x19c/0x278
>          drm_atomic_helper_commit+0x1dc/0x1f0
>          drm_atomic_commit+0xc0/0xd8
>          drm_atomic_helper_set_config+0xb4/0x134
>          drm_mode_setcrtc+0x688/0x1248
>          drm_ioctl_kernel+0x1e4/0x338
>          drm_ioctl+0x3a4/0x684
>          __arm64_sys_ioctl+0x118/0x154
>          invoke_syscall+0x78/0x224
>          el0_svc_common+0x178/0x200
>          do_el0_svc+0x94/0x13c
>          el0_svc+0x5c/0xec
>          el0t_64_sync_handler+0x78/0x108
>          el0t_64_sync+0x1a4/0x1a8
> 
>   -> #2 (crtc_ww_class_mutex){+.+.}-{3:3}:
>          __mutex_lock_common+0x174/0x1a64
>          ww_mutex_lock+0xb8/0x278
>          modeset_lock+0x304/0x4ac
>          drm_modeset_lock+0x4c/0x7c
>          drmm_mode_config_init+0x4a8/0xc50
>          msm_drm_init+0x274/0xac0
>          msm_drm_bind+0x20/0x2c
>          try_to_bring_up_master+0x3dc/0x470
>          __component_add+0x18c/0x3c0
>          component_add+0x1c/0x28
>          dp_display_probe+0x954/0xa98
>          platform_probe+0x124/0x15c
>          really_probe+0x1b0/0x5f8
>          __driver_probe_device+0x174/0x20c
>          driver_probe_device+0x70/0x134
>          __device_attach_driver+0x130/0x1d0
>          bus_for_each_drv+0xfc/0x14c
>          __device_attach+0x1bc/0x2bc
>          device_initial_probe+0x1c/0x28
>          bus_probe_device+0x94/0x178
>          deferred_probe_work_func+0x1a4/0x1f0
>          process_one_work+0x5d4/0x9dc
>          worker_thread+0x898/0xccc
>          kthread+0x2d4/0x3d4
>          ret_from_fork+0x10/0x20
> 
>   -> #1 (crtc_ww_class_acquire){+.+.}-{0:0}:
>          ww_acquire_init+0x1c4/0x2c8
>          drm_modeset_acquire_init+0x44/0xc8
>          drm_helper_probe_single_connector_modes+0xb0/0x12dc
>          drm_mode_getconnector+0x5dc/0xfe8
>          drm_ioctl_kernel+0x1e4/0x338
>          drm_ioctl+0x3a4/0x684
>          __arm64_sys_ioctl+0x118/0x154
>          invoke_syscall+0x78/0x224
>          el0_svc_common+0x178/0x200
>          do_el0_svc+0x94/0x13c
>          el0_svc+0x5c/0xec
>          el0t_64_sync_handler+0x78/0x108
>          el0t_64_sync+0x1a4/0x1a8
> 
>   -> #0 (&dev->mode_config.mutex){+.+.}-{3:3}:
>          __lock_acquire+0x2650/0x672c
>          lock_acquire+0x1b4/0x4ac
>          __mutex_lock_common+0x174/0x1a64
>          mutex_lock_nested+0x98/0xac
>          dp_panel_add_fail_safe_mode+0x4c/0xa0
>          dp_hpd_plug_handle+0x1f0/0x280
>          dp_bridge_enable+0x94/0x2b8
>          drm_atomic_bridge_chain_enable+0x11c/0x168
>          drm_atomic_helper_commit_modeset_enables+0x500/0x740
>          msm_atomic_commit_tail+0x3e4/0x748
>          commit_tail+0x19c/0x278
>          drm_atomic_helper_commit+0x1dc/0x1f0
>          drm_atomic_commit+0xc0/0xd8
>          drm_atomic_helper_set_config+0xb4/0x134
>          drm_mode_setcrtc+0x688/0x1248
>          drm_ioctl_kernel+0x1e4/0x338
>          drm_ioctl+0x3a4/0x684
>          __arm64_sys_ioctl+0x118/0x154
>          invoke_syscall+0x78/0x224
>          el0_svc_common+0x178/0x200
>          do_el0_svc+0x94/0x13c
>          el0_svc+0x5c/0xec
>          el0t_64_sync_handler+0x78/0x108
>          el0t_64_sync+0x1a4/0x1a8
> 
> Changes in v2:
> -- re text commit title
> -- remove all fail safe mode
> 
> Changes in v3:
> -- remove dp_panel_add_fail_safe_mode() from dp_panel.h
> -- add Fixes
> 
> Changes in v4:
> --  to=dianders@chromium.org
> 
> Fixes: 8b2c181 ("drm/msm/dp: add fail safe mode outside of event_mutex context")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> 
> Fixes: f1b47e6a8df8 ("drm/msm/dp: remove fail safe mode related code")
> Reported-by: Douglas Anderson <dianders@chromium.org>

This does not look correct. Your sign-off should be the latest one. Also 
please recheck the Fixes tags.

> ---
>   drivers/gpu/drm/msm/dp/dp_panel.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index f141872..26f4b695 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -206,17 +206,6 @@ int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
>   			rc = -ETIMEDOUT;
>   			goto end;
>   		}
> -
> -		/* fail safe edid */
> -		mutex_lock(&connector->dev->mode_config.mutex);
> -		if (drm_add_modes_noedid(connector, 640, 480))
> -			drm_set_preferred_mode(connector, 640, 480);
> -		mutex_unlock(&connector->dev->mode_config.mutex);
> -	} else {
> -		/* always add fail-safe mode as backup mode */
> -		mutex_lock(&connector->dev->mode_config.mutex);
> -		drm_add_modes_noedid(connector, 640, 480);
> -		mutex_unlock(&connector->dev->mode_config.mutex);
>   	}
>   
>   	if (panel->aux_cfg_update_done) {


-- 
With best wishes
Dmitry
