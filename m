Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58656502600
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350884AbiDOHLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbiDOHL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:11:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D303EA1456
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:09:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so7264354wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=TRdg950Mi7asbD+Hg99qC5L9J8U55Ud01eS+T2DqwmQ=;
        b=b0+1f2xc7m7CjeDoQMzPHxKjrSXdOUjqEkCfMg+y1sGq6kXGPJr8m3/wyXSMyVhZpT
         xAIU8EjoxEyp2nn2iFhFRx0PqvuJNA6xNvtv9CEchU+RJHEa1CBBBRGczvFfsN8lYF8I
         YkAfr45naK3B59yr/QlcWho37BmgS2sWcRWWovtUOfPrlyiGrCRrmSPfvcHyAG/KSa+b
         iarrHqyaIhlgzqgGQRdm8MQ3qkYOpobugBblglGy26UEqYP5ugK9aTmPy+C4jm5zLCiQ
         ln1ZMP8dpWCLbHBo2fWzqR92cJS76HBykUd33VUm+8qGPTjhY7z0PqNdIWW4snFP1zs0
         0k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=TRdg950Mi7asbD+Hg99qC5L9J8U55Ud01eS+T2DqwmQ=;
        b=LAx9vGVcReq1r5ed1N4sUYNhQSfcKtpK57ado0ahfsTUaY+CJzDIIOhx3H72ie4Tvn
         DzOqSWjwmnjVJns+F1CEcua8bu4YNywOcA8SY/C+N0N79XfxGYND23dMoY615VkEuXZW
         9hpf0aPdtQMN3HkreUmXud77SEl7xl3icdEQKeUL/xlcCUrC7Z0RiaO5onxP1evt6p0A
         qYEmCd9zvxLBje0TaoBkyBoKj1aDoqM/yuLtSFNn5HlIdukBcmGalhQC/aoiKPdvy22L
         rbb8PGMaagFl1vx8eNkgkinhNsZvjze4Dfgz+SxlyJkpw8Kr3lXMq8kDMAL9ryzifY2j
         BxDw==
X-Gm-Message-State: AOAM533Ao8vGkryj8+6mso6dlok9Btwl/lhu/mN6W/boylHBMf+Gkjd7
        DgIZOGv2mR/7TpS1F1Pr5PyskDAJL4ZE07gG
X-Google-Smtp-Source: ABdhPJxRpom9zkd3rr9FaT4PGAI1AGHg/uy5fbHtwQ00mv0NQMtBdpODztu1bNq8QwekcCxeOTnJ0g==
X-Received: by 2002:a05:600c:5126:b0:38e:d475:de0e with SMTP id o38-20020a05600c512600b0038ed475de0emr1950877wms.169.1650006539205;
        Fri, 15 Apr 2022 00:08:59 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:fc5c:ffc8:c900:53c9? ([2001:861:44c0:66c0:fc5c:ffc8:c900:53c9])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0038eb8171fa5sm4233081wme.1.2022.04.15.00.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 00:08:58 -0700 (PDT)
Message-ID: <e38e8450-94c5-90f6-207e-07af972f3ed0@baylibre.com>
Date:   Fri, 15 Apr 2022 09:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/4] drm: bridge: dw_hdmi: Enable GCP only for Deep
 Color
Content-Language: en-US
To:     Sandor.yu@nxp.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl
Cc:     shengjiu.wang@nxp.com, cai.huoqing@linux.dev, maxime@cerno.tech,
        harry.wentland@amd.com
References: <cover.1649989179.git.Sandor.yu@nxp.com>
 <78fa41e4fb3d3d53354034bc221fcf870dbac617.1649989179.git.Sandor.yu@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <78fa41e4fb3d3d53354034bc221fcf870dbac617.1649989179.git.Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2022 04:42, Sandor.yu@nxp.com wrote:
> From: Sandor Yu <Sandor.yu@nxp.com>
> 
> HDMI1.4b specification section 6.5.3:
> Source shall only send GCPs with non-zero CD to sinks
> that indicate support for Deep Color.
> 
> DW HDMI GCP default enabled, but only transmit CD
> and do not handle AVMUTE, PP norDefault_Phase (yet).
> Disable Auto GCP when 24-bit color for sinks that not support Deep Color.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 17 +++++++++++++++++
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  3 +++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 02d8f7e08814..312500921754 100644
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
> @@ -1160,6 +1164,19 @@ static void hdmi_video_packetize(struct dw_hdmi *hdmi)
>   		HDMI_VP_PR_CD_DESIRED_PR_FACTOR_MASK);
>   	hdmi_writeb(hdmi, val, HDMI_VP_PR_CD);
>   
> +	/* HDMI1.4b specification section 6.5.3:
> +	 * Source shall only send GCPs with non-zero CD to sinks
> +	 * that indicate support for Deep Color.
> +	 * GCP only transmit CD and do not handle AVMUTE, PP norDefault_Phase (yet).
> +	 * Disable Auto GCP when 24-bit color for sinks that not support Deep Color.
> +	 */
> +	val = hdmi_readb(hdmi, HDMI_FC_DATAUTO3);
> +	if (clear_gcp_auto == 1)
> +		val &= ~HDMI_FC_DATAUTO3_GCP_AUTO;
> +	else
> +		val |= HDMI_FC_DATAUTO3_GCP_AUTO;
> +	hdmi_writeb(hdmi, val, HDMI_FC_DATAUTO3);
> +
>   	hdmi_modb(hdmi, HDMI_VP_STUFF_PR_STUFFING_STUFFING_MODE,
>   		  HDMI_VP_STUFF_PR_STUFFING_MASK, HDMI_VP_STUFF);
>   
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> index 1999db05bc3b..18df3e119553 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> @@ -850,6 +850,9 @@ enum {
>   	HDMI_FC_DATAUTO0_VSD_MASK = 0x08,
>   	HDMI_FC_DATAUTO0_VSD_OFFSET = 3,
>   
> +/* FC_DATAUTO3 field values */
> +	HDMI_FC_DATAUTO3_GCP_AUTO = 0x04,
> +
>   /* PHY_CONF0 field values */
>   	HDMI_PHY_CONF0_PDZ_MASK = 0x80,
>   	HDMI_PHY_CONF0_PDZ_OFFSET = 7,

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
