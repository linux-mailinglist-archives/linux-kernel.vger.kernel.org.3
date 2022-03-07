Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53E54CF386
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiCGIbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCGIbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:31:22 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE06369E1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:30:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t11so21932278wrm.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=rx8yLAgwRWd5HxxwxNM22XOGHWHvMO2UWDFHTxYRPbY=;
        b=PzxsUr8GCskd/ha2XcgDg2QL4P+bOwFIly3XBO/Xt9YzrrwjfIAQ4g14SPqNycRmtF
         coDdMoft9V5Xcra7GNPqyIhV61IfFJmB0VF0WY3P5NHsaNu/XApWteGTv41D7x33HcKC
         YFB74IGzfnd550j4pufrL3MtFsKRa8NiWeZJ9hYtYsopK8NbRbhySPUqlrm8sEoLXqun
         gTTl1y6LWuJLVuZmfEyuDHNe9iSRaEaSVi5WMxoo/6Ol6a2HAEPAQRHSVmXmqWsWMQgy
         lrwkhIs/0M0CAzxmDamIj7PXC64Mrn1AZC7QbygUj0QeS8SRMDGfVcXGhEpX8/BXaduY
         z5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=rx8yLAgwRWd5HxxwxNM22XOGHWHvMO2UWDFHTxYRPbY=;
        b=F+Mi0ZKEC/sjodFw97IDgddBDUz1NDHkXmbiC2DTSqOj8JpI8bEML+tdaTVAJyDqSI
         uFnSi8C+C5QlanxpS8RajpYVIBGvQyt81n9h/XpZ7KNtg/rEgV5u95uU0idMMRa15QIF
         xH/y4yz2U7diaDFzOW/Ln227VxVE7XsMhBtT53k47I8IizmC/U6iXLKglM8HuzSaUoFc
         eHr/EFjjC8/t6v1cYkD9I8pjzpdpGZY9DniddWrVdutx3Y87AX6GMOsc7uCqLzQ8AV8Q
         eZCyMQgQsqaBdXDH3yG2FTwqp9aCL/Sib7zPmA6YTOYMdpToZIHPuFYEzfnkOXInv7hG
         PB/Q==
X-Gm-Message-State: AOAM532h4FTPrB4YPRm6UfCFvcu6p3ISZJEWnYAWMPfyjmfVdki8dDxd
        2OtfKpyRH8DHicsPlYPJNjfIfA==
X-Google-Smtp-Source: ABdhPJzvPc5TFTjp2S5kZK8I2dRki97feHPUxjcD/hGdln5ABt4ZLetFTLKJr6PSASZR3EMjTSh7gQ==
X-Received: by 2002:a05:6000:1ac7:b0:1f1:f9ee:7c57 with SMTP id i7-20020a0560001ac700b001f1f9ee7c57mr1730287wry.52.1646641825489;
        Mon, 07 Mar 2022 00:30:25 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:1451:71b4:fefe:6096? ([2001:861:44c0:66c0:1451:71b4:fefe:6096])
        by smtp.gmail.com with ESMTPSA id r187-20020a1c44c4000000b0038377fb18f8sm21189154wma.5.2022.03.07.00.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 00:30:25 -0800 (PST)
Message-ID: <af4cffb7-a519-dea1-4b82-f00e9603ce84@baylibre.com>
Date:   Mon, 7 Mar 2022 09:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm: Drop commas after SoC match table sentinels
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <298f0644275d7d0b4aa3ee7143756a2431a4900c.1646311443.git.geert+renesas@glider.be>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <298f0644275d7d0b4aa3ee7143756a2431a4900c.1646311443.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 13:44, Geert Uytterhoeven wrote:
> It does not make sense to have a comma after a sentinel, as any new
> elements must be added before the sentinel.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   drivers/gpu/drm/bridge/nwl-dsi.c  | 2 +-
>   drivers/gpu/drm/meson/meson_drv.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 5abb5ec3de467458..846df1ee7a2888cb 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -1151,7 +1151,7 @@ MODULE_DEVICE_TABLE(of, nwl_dsi_dt_ids);
>   static const struct soc_device_attribute nwl_dsi_quirks_match[] = {
>   	{ .soc_id = "i.MX8MQ", .revision = "2.0",
>   	  .data = (void *)E11418_HS_MODE_QUIRK },
> -	{ /* sentinel. */ },
> +	{ /* sentinel. */ }
>   };
>   
>   static int nwl_dsi_probe(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 26aeaf0ab86ef932..35eaa669e8fe0c2a 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -167,7 +167,7 @@ static const struct meson_drm_soc_attr meson_drm_soc_attrs[] = {
>   		},
>   		.attrs = (const struct soc_device_attribute []) {
>   			{ .soc_id = "GXL (S805*)", },
> -			{ /* sentinel */ },
> +			{ /* sentinel */ }
>   		}
>   	},
>   };

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Tell me if you want me to apply it to drm-misc-next.

Thanks,
Neil
