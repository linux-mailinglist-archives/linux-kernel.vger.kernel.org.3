Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEFE4F95F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiDHMmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbiDHMmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:42:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B3A295252
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:40:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so7465457wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JtXxBqYHvoARiWzEnaLQz1KM8jdVHYhcJ4+dJSrCNho=;
        b=DaN6uMg1mWoy0sJAV0g1YvUeexSJXdw69mB/G8cDTl88B7hvvTMuHBQkKlxH+KxDBa
         H81GzezGvpaDopE334/4Okotf/kCCXHz0vTpmLLKEx+Bku9pLOU5FLpp5gk3GohhXLd2
         zblz1C20kzVUnt868ukX1W9mV9hWWq59Ym5miWpnU+vOc0PlqLBFpI4eiVEtZciOwdpN
         9oRD1RByZh4b3H8vb6DNYjQgBx23gDCP7JeF9fdpNoGmFL1sUyzTBxx/b2Te50F26SqH
         T5Cz05dVjRAjbO/3D1xZCcCuQgILdFS7HDXoHATbCKG4OH8TImR3t40881bgVzivKS3t
         mUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JtXxBqYHvoARiWzEnaLQz1KM8jdVHYhcJ4+dJSrCNho=;
        b=VZBfg/gcQj6T3S6XPjd4x7jJyE8GqxVkDlGbnJF5VpkfE3/D/MjWHq2HPepjbIDrxJ
         3lPnxQ2zsbWbReVceu2Mom2pNYstk2/Oh198EWtHhS4CwLwqe2WGWNWvRXNXmJVdlonA
         6s1GGEJ2yLLSXOg1TEVzzpKIQgyO1iIEvaf5vRJFByPOBXd+jxaVpb9L8fyZPa+QvlFM
         AuGBly8g05NLS6kxmUjvQ6BQ2ulyayWHdlGMgv4EQR434Z2Jut/1yg58Al/FKYiJPUlH
         U7YBtd6/5VMQu55GuKAIr+8sWiyjE2sd7XaLOAMb238d47N5mwhzfJyE7xcxGz1NL4xW
         oJxQ==
X-Gm-Message-State: AOAM531D4wqsF9hBuyt6SSvEBWOjNo4avd9GaDY8SImnoivVtPfyURZ3
        aq2IYmKx3QjljKDVgKFHPCINMw==
X-Google-Smtp-Source: ABdhPJwoCjsjihXGrySnrwKn6BzJl3Dg6+P50meXlcaikWCGLEuuq9Lafl4Wwjjb/OVp8TTTx0TyAg==
X-Received: by 2002:a05:600c:3d86:b0:38d:581:89ad with SMTP id bi6-20020a05600c3d8600b0038d058189admr17088800wmb.42.1649421627958;
        Fri, 08 Apr 2022 05:40:27 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:eacd:ce6:e294:acd1? ([2001:861:44c0:66c0:eacd:ce6:e294:acd1])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0038cc9aac1a3sm11597138wmq.23.2022.04.08.05.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 05:40:27 -0700 (PDT)
Message-ID: <25ca3826-44ee-ca6f-fb6b-1ef62f6da456@baylibre.com>
Date:   Fri, 8 Apr 2022 14:40:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/5] drm: bridge: dw_hdmi: Enable GCP only for Deep
 Color
Content-Language: en-US
To:     Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl
Cc:     shengjiu.wang@nxp.com, cai.huoqing@linux.dev, maxime@cerno.tech,
        harry.wentland@amd.com
References: <cover.1649412256.git.Sandor.yu@nxp.com>
 <a0f9def7e7438592f78ef0a16cd0a560be0e6133.1649412256.git.Sandor.yu@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <a0f9def7e7438592f78ef0a16cd0a560be0e6133.1649412256.git.Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 12:32, Sandor Yu wrote:
> HDMI1.4b specification section 6.5.3:
> Source shall only send GCPs with non-zero CD to sinks
> that indicate support for Deep Color.
> 
> DW HDMI GCP default enabled, clear gpc_auto bit for 24-bit color depth.

It's right because we do not handle AVMUTE, Pixel Packing nor Default_Phase.

> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 02d8f7e08814..5a7ec066e37a 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1108,6 +1108,8 @@ static void hdmi_video_packetize(struct dw_hdmi *hdmi)
>   	unsigned int output_select = HDMI_VP_CONF_OUTPUT_SELECTOR_PP;
>   	struct hdmi_data_info *hdmi_data = &hdmi->hdmi_data;
>   	u8 val, vp_conf;
> +	u8 clear_gcp_auto = 0;
> +
>   
>   	if (hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format) ||
>   	    hdmi_bus_fmt_is_yuv444(hdmi->hdmi_data.enc_out_bus_format) ||
> @@ -1117,6 +1119,7 @@ static void hdmi_video_packetize(struct dw_hdmi *hdmi)
>   		case 8:
>   			color_depth = 4;
>   			output_select = HDMI_VP_CONF_OUTPUT_SELECTOR_BYPASS;
> +			clear_gcp_auto = 1;
>   			break;
>   		case 10:
>   			color_depth = 5;
> @@ -1136,6 +1139,7 @@ static void hdmi_video_packetize(struct dw_hdmi *hdmi)
>   		case 0:
>   		case 8:
>   			remap_size = HDMI_VP_REMAP_YCC422_16bit;
> +			clear_gcp_auto = 1;
>   			break;
>   		case 10:
>   			remap_size = HDMI_VP_REMAP_YCC422_20bit;
> @@ -1160,6 +1164,14 @@ static void hdmi_video_packetize(struct dw_hdmi *hdmi)
>   		HDMI_VP_PR_CD_DESIRED_PR_FACTOR_MASK);
>   	hdmi_writeb(hdmi, val, HDMI_VP_PR_CD);
>   
> +	val = hdmi_readb(hdmi, HDMI_FC_DATAUTO3);
> +	if (clear_gcp_auto == 1)
> +		/* disable Auto GCP when 24-bit color */

Maybe add a new define for HDMI_FC_DATAUTO3_GCP_AUTO bit and use it here.

> +		val &= ~0x4;
> +	else
> +		val |= 0x4;
> +	hdmi_writeb(hdmi, val, HDMI_FC_DATAUTO3);

Please also add a comment explaining we clear GCP because we only
transmit CD and do not handle AVMUTE, PP nor Default_Phase (yet).

> +
>   	hdmi_modb(hdmi, HDMI_VP_STUFF_PR_STUFFING_STUFFING_MODE,
>   		  HDMI_VP_STUFF_PR_STUFFING_MASK, HDMI_VP_STUFF);
>   

Thanks,
Neil
