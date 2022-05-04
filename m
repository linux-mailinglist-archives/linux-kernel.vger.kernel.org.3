Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9AC519743
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbiEDGQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiEDGQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:16:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FDF17051
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:12:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j4so614840lfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 23:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2tuqEYU8OdIQxZ+rdModr4KYTKneYsLdEMUMbVDbBTk=;
        b=BWUeIlVpukCSflMHB1tgYceEosqVc9oe/jVXzIYsrusbl87pNjhYnDjv9qEL0oLhwn
         aa5UjM1m72/z0Hga1RJHxiWZAKJqXW7wF3rMzST8CqwYHbsHDVJmbnoWbRlJOuZlx6tU
         ySVvgdDG7ZICzvh3u7mvZrki7RSf7Jlvyp9n+9KOD688mckez/KQg0eVURkS5L/boK+e
         IbT0Ut7YD4VLvL2Hh6VnoxQu4td6H/Fr3wJXIwAUC0p64RQorCh9AzQc5A4aFkxjWj4X
         zV3ANrN2TxFoRJ8c3bWK+NaiHY6YqPwSlTVWKpnmiPXr/oEYIm7X6CGb+/md6PS/104Z
         VzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2tuqEYU8OdIQxZ+rdModr4KYTKneYsLdEMUMbVDbBTk=;
        b=hec23Veh5TMteIfzo8ujr22kPo4KB6zdAFBayb0rc9cDjy/FreGv/WMH9ahxLa8liM
         NN3Dv6VPYhlqF7divpwAZIF2LBLcc5iRmBoLC08136MwEBKZOtaLNYqfaqVhhNDzR1Qe
         LFxf58EIM8yDOumGXsUTNvpo4lmaPgCTHN7gdzU+aYOS8hsCg89WCfeaZufl4+2QyhYY
         Zqq3v3fGoW1F73zLQntdusRyJ4/hIhCbNy3OCQ1Oah73Zn3oq0TiIfBX6nVGrbD+pjjS
         3iMQuFnxvQqAbGkh0biJu7ZiJNtOpn9djvgTbqyV4c2l4nApJl0uc+PBWiKPabaMf1d2
         sDkg==
X-Gm-Message-State: AOAM532ZOxxiIXOoXZmJuT0zHXXBcNk329Q5lPnHOr2Q/UBkWxmtgq1j
        SQ50P0+GBm2D1TXuyi+QbRIn5g==
X-Google-Smtp-Source: ABdhPJwS/7njQpo3DbfyMqUKtFd3wGDymfnni39lsDf6ApW3pU5xpDjIEk2egMPRoKYUqDcviFdi4w==
X-Received: by 2002:a05:6512:118b:b0:46b:a9ae:3a3b with SMTP id g11-20020a056512118b00b0046ba9ae3a3bmr13477930lfr.188.1651644772957;
        Tue, 03 May 2022 23:12:52 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c3-20020ac25303000000b0047255d210f9sm1119231lfh.40.2022.05.03.23.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 23:12:52 -0700 (PDT)
Message-ID: <031fccd7-0082-8284-967d-285525a64394@linaro.org>
Date:   Wed, 4 May 2022 09:12:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm: Document that power requirements for DP AUX
 transfers
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20220503162033.1.Ia8651894026707e4fa61267da944ff739610d180@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220503162033.1.Ia8651894026707e4fa61267da944ff739610d180@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 02:21, Douglas Anderson wrote:
> When doing DP AUX transfers there are two actors that need to be
> powered in order for the DP AUX transfer to work: the DP source and
> the DP sync.

Nit: sink

> Commit bacbab58f09d ("drm: Mention the power state
> requirement on side-channel operations") added some documentation
> saying that the DP source is required to power itself up (if needed)
> to do AUX transfers. However, that commit doesn't talk anything about
> the DP sink.
> 
> For full fledged DP the sink isn't really a problem. It's expected
> that if an external DP monitor isn't plugged in that attempting to do
> AUX transfers won't work. It's also expected that if a DP monitor is
> plugged in (and thus asserting HPD) that it AUX transfers will work.

then

> 
> When we're looking at eDP, however, things are less obvious. Let's add
> some documentation about expectations. Here's what we'll say:
> 
> 1. We don't expect the DP AUX transfer function to power on an eDP
> panel. If an eDP panel is physically connected but powered off then it
> makes sense for the transfer to fail.
> 
> 2. We'll document that the official way to power on a panel is via the
> bridge chain, specifically by making sure that the panel's prepare
> function has been called (which is called by
> panel_bridge_pre_enable()). It's already specified in the kernel doc
> of drm_panel_prepare() that this is the way to power the panel on and
> also that after this call "it is possible to communicate with any
> integrated circuitry via a command bus."
> 
> 3. We'll also document that for code running in the panel driver
> itself that it is legal for the panel driver to power itself up
> however it wants (it doesn't need to officially call
> drm_panel_pre_enable()) and then it can do AUX bus transfers. This is
> currently the way that edp-panel works when it's running atop the DP
> AUX bus.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> 
>   include/drm/display/drm_dp_helper.h | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> index dca40a045dd6..e5165b708a40 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -370,9 +370,17 @@ struct drm_dp_aux {
>   	 * helpers assume this is the case.
>   	 *
>   	 * Also note that this callback can be called no matter the
> -	 * state @dev is in. Drivers that need that device to be powered
> -	 * to perform this operation will first need to make sure it's
> -	 * been properly enabled.
> +	 * state @dev is in and also no matter what state the panel is
> +	 * in. It's expected:
> +	 * - If the @dev providing the AUX bus is currently unpowered then
> +	 *   it will power itself up for the transfer.
> +	 * - If we're on eDP and the panel is not in a state where it can
> +	 *   respond (it's not powered or it's in a low power state) then this
> +	 *   function will return an error (but not crash). Note that if a
> +	 *   panel driver is initiating a DP AUX transfer it may power itself
> +	 *   up however it wants. All other code should ensure that the
> +	 *   pre_enable() bridge chain (which eventually calls the panel
> +	 *   prepare function) has powered the panel.
>   	 */
>   	ssize_t (*transfer)(struct drm_dp_aux *aux,
>   			    struct drm_dp_aux_msg *msg);


-- 
With best wishes
Dmitry
