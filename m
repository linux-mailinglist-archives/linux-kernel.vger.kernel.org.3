Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF450A624
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiDUQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiDUQud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:50:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0CC49275
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:47:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so6262045wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=TSBE+75DEItnElqK6i/9Llmt2S09XqfUaLkR6TjRbyo=;
        b=NXb7KRvWuPLwtdKDNwdZHcukQ9NuizddPugTM4tliMQvmLXPN1STsxMbESzFB6OjBb
         T0cjMh+liiDry+aW7ahUc3C6tGFvR5E4aj79ra6iTlNzdMhzUErpmpPnEni9BnZ9vOSX
         2mmhQ6KobQJWeEulTngmjSbJQJLQiS77r2oLiASzrwMGfk2bcvDHGYWK5Ap/sV3Mw8LX
         uKbJC/tlZDHWscq3LuA9iaRm4NQPfDr+2qV8HZa96prxedIg+lCt4FM6gUq3xIx16YKL
         Bw6BruhZlC4hlVmbYthpwobkw3iewSzb5ZvhVJpQIJuQB9kPCUPBE0bbysLX87aQkOzY
         3srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=TSBE+75DEItnElqK6i/9Llmt2S09XqfUaLkR6TjRbyo=;
        b=PUhEx8bvWjp+QXHGFcJ41bke4OsdWXZbZq/qXIL5Y8/ouVZ/1DAGnNHge+OVCFVeDk
         nZ3U8LIHw1K/WBJHfA1tqUD/i7QV6F5YpnuFmhxk9iY1+tRMk72ZV+G88zYYJ7nMKyYX
         RSBTvPjKJJNJRpUGog3TaawxdT526RcO2e0Km8bxndpZUBQCwBZMY+EhvF4O+GNU6W/U
         yqYGwcRFoLOMKY9NxqbgfVqQUDHrzDOdIhXN+nw9sQUHZKn541Nzem+SGYnCucyNQBoZ
         m2CVlZobETQLRtszROoUpZX/cnDi6CecQKRFfg9J0qZocyIfZvmc4tt8L356lktaLHda
         Ambg==
X-Gm-Message-State: AOAM531ahI5tw8C056S/6QVJm+224yro3A7nZ5BJvBDI7FCGifPRUmPf
        NxyDm+2YqKfbXtasXyGxITfQig==
X-Google-Smtp-Source: ABdhPJzOCephvK5l4jzG/E57jouUNpfO0ypqRAA/i0utRt/u5B9jDkk6ogV5WOtk3t8EIkLiIXsmZQ==
X-Received: by 2002:a05:600c:3ca3:b0:392:990b:af11 with SMTP id bg35-20020a05600c3ca300b00392990baf11mr211439wmb.173.1650559660823;
        Thu, 21 Apr 2022 09:47:40 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:35ba:2677:956:980d? ([2001:861:44c0:66c0:35ba:2677:956:980d])
        by smtp.gmail.com with ESMTPSA id f13-20020a0560001a8d00b0020aab7cefc4sm2649396wry.46.2022.04.21.09.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:47:40 -0700 (PDT)
Message-ID: <b12c1e0c-7383-547d-b4ee-a9e60b2eea12@baylibre.com>
Date:   Thu, 21 Apr 2022 18:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm: bridge: dw_hdmi: Audio: fix returnvar.cocci warnings
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Sandor Yu <Sandor.yu@nxp.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Robert Foss <robert.foss@linaro.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <202204212311.TnfpcTGm-lkp@intel.com>
 <YmFzutFV/iDyEQF2@dd18de969aa6>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <YmFzutFV/iDyEQF2@dd18de969aa6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 17:09, kernel test robot wrote:
> From: kernel test robot <lkp@intel.com>
> 
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c:80:5-8: Unneeded variable: "ret". Return "0" on line 94
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c:105:5-8: Unneeded variable: "ret". Return "0" on line 112
> 
> 
>   Remove unneeded variable used to store return value.
> 
> Generated by: scripts/coccinelle/misc/returnvar.cocci
> 
> CC: Sandor Yu <Sandor.yu@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: kernel test robot <lkp@intel.com>
> ---
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   65eb92e4c9f0a962656f131521f4fbc0d24c9d4c
> commit: d970ce303ff80ae57bbd3e784f2772dbf3056e0c [4441/5346] drm: bridge: dw_hdmi: Audio: Add General Parallel Audio (GPA) driver
> :::::: branch date: 8 hours ago
> :::::: commit date: 2 days ago
> 
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c |    6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c
> @@ -77,7 +77,6 @@ static int audio_hw_params(struct device
>   			   struct hdmi_codec_params *params)
>   {
>   	struct snd_dw_hdmi *dw = dev_get_drvdata(dev);
> -	int ret = 0;
>   	u8 ca;
>   
>   	dw_hdmi_set_sample_rate(dw->data.hdmi, params->sample_rate);
> @@ -91,7 +90,7 @@ static int audio_hw_params(struct device
>   				   params->iec.status[0] & IEC958_AES0_NONAUDIO);
>   	dw_hdmi_set_sample_width(dw->data.hdmi, params->sample_width);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static void audio_shutdown(struct device *dev, void *data)
> @@ -102,14 +101,13 @@ static int audio_mute_stream(struct devi
>   			     bool enable, int direction)
>   {
>   	struct snd_dw_hdmi *dw = dev_get_drvdata(dev);
> -	int ret = 0;
>   
>   	if (!enable)
>   		dw_hdmi_audio_enable(dw->data.hdmi);
>   	else
>   		dw_hdmi_audio_disable(dw->data.hdmi);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static int audio_get_eld(struct device *dev, void *data,

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
