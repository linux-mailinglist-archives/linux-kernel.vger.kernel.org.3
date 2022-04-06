Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C924F6176
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiDFOD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiDFOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:02:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AD726AF3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:20:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h4so2185834wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=W2aIkhSbWTJlWRBmYZEWYtrp0yLkamumDlvUWGDjJiI=;
        b=JZIfw3GHWIPY0Sa9qHp8NyB6Oim7mUgr96GyW0rRJieHrrsLkU6hxeUahe3oK1e8+B
         SdRcfmSLRMGJtHdvfy5100qjasQeK4knEGgDa/HIhyJVZkW0EBr7mAdnuDa4S6kTwu6F
         4Zt1zYMhHFfBsGwHrZefb9/7qIemr9sk6Gfu/BIzlVHP2GL+aNMh+0jhOXRbDMpT9Xi3
         2uXQzkLloVh60g8safmJuPGdzuVqH0YqgDVQWys5IWngVxD9OOGBkIY943jthA4/PejL
         5UWBsOBja1Cumr69Sf3kr7WEni22hVGQCKaZL/W7Svvq5bq58aT6lSNg/dgmFgaaDJFl
         RDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=W2aIkhSbWTJlWRBmYZEWYtrp0yLkamumDlvUWGDjJiI=;
        b=kKukpDdvjx/+5ckqmY90aIsFwsIeLSJqQRRRn0HSpm5XY9/mnQBWuyi2uDRbDdl/XR
         7GnEJI+U+SJIgiqkJSrs1L5GymElLDAzUwmnmJcOvBYIjfw6H165JwmcBYSKj3ZUeQwK
         VMSIYJblS3cWlw2veVf3cxAbNIjOQV0t3A4FKKpMhRYyDL7cUljHTxJeudbH8tDHLEJ2
         eK7jLLbqO0Cv7SeXfwBlBtDPo0XbegqWLp/m/jQeeZI6r7+uWeI0LN0PAvRNOAdxFesh
         bvc/iBuYBSv7XFurC+61F7MxGuk3Ge1oakaCHp8UyZUGjS7tIbO4QD9RNqbmCavxiHsp
         XYCQ==
X-Gm-Message-State: AOAM531M6Cs6pmFyhEimA8PpianLjTq4smOcoNFmmkQG+n8GNUMNDm2g
        nZDxGJrQrOexP5gTs7Q/uD4a3A==
X-Google-Smtp-Source: ABdhPJzgMIrKDZHP11m0BbEp9aD8JUJktaSH2xen2F0e/uKtKJEwkgGvuV/pcq0Q6dfVMJZ6Km5hAg==
X-Received: by 2002:a5d:588a:0:b0:204:1f46:cf08 with SMTP id n10-20020a5d588a000000b002041f46cf08mr5911861wrf.133.1649236817626;
        Wed, 06 Apr 2022 02:20:17 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:d960:ec5e:e421:9c9e? ([2001:861:44c0:66c0:d960:ec5e:e421:9c9e])
        by smtp.gmail.com with ESMTPSA id q187-20020a1c43c4000000b0038e70f4f42dsm4318396wma.47.2022.04.06.02.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 02:20:17 -0700 (PDT)
Message-ID: <203a2b93-a842-8cf2-b265-864f520c16a6@baylibre.com>
Date:   Wed, 6 Apr 2022 11:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 3/5] drm: bridge: dw_hdmi: Enable GCP only for Deep
 Color
Content-Language: en-US
To:     Sandor.yu@nxp.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com
Cc:     shengjiu.wang@nxp.com, cai.huoqing@linux.dev, maxime@cerno.tech,
        harry.wentland@amd.com, hverkuil-cisco@xs4all.nl,
        amuel@sholland.org
References: <cover.1649230434.git.Sandor.yu@nxp.com>
 <ebd9830fe35d79153cb0051bed0d255fb004fb63.1649230434.git.Sandor.yu@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <ebd9830fe35d79153cb0051bed0d255fb004fb63.1649230434.git.Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 10:48, Sandor.yu@nxp.com wrote:
> From: Sandor Yu <Sandor.yu@nxp.com>
> 
> HDMI1.4b specification section 6.5.3:
> Source shall only send GCPs with non-zero CD to sinks
> that indicate support for Deep Color.
> 
> DW HDMI GPC default enabled, clear gpc_auto bit for bpp 24.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index b11577de4836..c7b11582529e 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1160,6 +1160,14 @@ static void hdmi_video_packetize(struct dw_hdmi *hdmi)
>   		HDMI_VP_PR_CD_DESIRED_PR_FACTOR_MASK);
>   	hdmi_writeb(hdmi, val, HDMI_VP_PR_CD);
>   
> +	val = hdmi_readb(hdmi, HDMI_FC_DATAUTO3);
> +	if (color_depth == 4)
> +		/* disable Auto GCP when bpp 24 */
> +		val &= ~0x4;
> +	else
> +		val |= 0x4;
> +	hdmi_writeb(hdmi, val, HDMI_FC_DATAUTO3);
> +
>   	hdmi_modb(hdmi, HDMI_VP_STUFF_PR_STUFFING_STUFFING_MODE,
>   		  HDMI_VP_STUFF_PR_STUFFING_MASK, HDMI_VP_STUFF);
>   

Do you handle the case when color_depth == 0 when output is YUV422 ?

Neil
