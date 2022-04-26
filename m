Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA855101E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352269AbiDZPbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiDZPbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:31:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19B3B1E3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:28:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k2so5556498wrd.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=VvHeXPeRp+l0umkp3zLFpUL9QE8qvJf0yCKCEof3gxA=;
        b=buq77vk5gnKXmPdRMlrIaECKUB6ReZFkK9jjEduILoQPFcZ4UqFbAXkY7sxvxnid+h
         Yo15E1M9u8FN1jC0h1MkDs4Q0tljFZaq3Mz1yFOgLwDZZoa6Y1nZDCxZOZxGOZ9emRRl
         tYKbeShhkMYMulIffkgOV2rF8qoWnjaUWGbftT8erqriq1GTfnH1SA7fdTKXpF4yLP7W
         DBgROt1/xsnPuby2ARGWEinPTWYZfZhv1M4Lqaril+1XRNnFxNi2gQYmPl9jxwnjdEs/
         B19jiHF/Rteq3osbm5IViD2jAJwIBy0iKAw5rJm55mKQrSmmOQiVc7DnBYCiMEHwXFj0
         gw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=VvHeXPeRp+l0umkp3zLFpUL9QE8qvJf0yCKCEof3gxA=;
        b=VzRluADFiHj21gbThxg5QkDlAEOLmXjBLcqcDlv+44iQ3DxdkQPNrDZFWHraXSB1ki
         +3aQoAaDB4oEpYxJd4NSwXakhfhZ0xLVpA4NCXW4FoOZeJS0xueQFG5HWGyeD+tEKz6p
         Rz5+PWzUsF7ZgXlT6CMo23D36hsKDipUA7YEUZDIu4hvvDlmmZiUA6sK8ICqbYNGFpw6
         WyDszaxvbpgjO3IiqiHQDwxnfKHREvS0b0pJ9lG+RkFJaD8q+UW9odiIN8HVgxDTa808
         0BKaZW5GRosHxPMOShfezLy7MMUvLu/qQoNPOAMaQGOS+9QdcnC9T51ejX/YAFlO1Bnf
         GYCw==
X-Gm-Message-State: AOAM533sPo2BkOtU0Y/FwcBj6uzkjlp8dKjo2AxebJlHEPS9HGTAIx8/
        5Ceorxi30cJ+PiSHRi0KpFCQeA==
X-Google-Smtp-Source: ABdhPJx9Uc6kKSe37g5dNJxiEA3I/nHqSTMZYaXUAKy2tRG8l+KXOhNYXNfBScM2Vq6X5f/eKAx6BA==
X-Received: by 2002:a5d:584e:0:b0:20a:9034:e312 with SMTP id i14-20020a5d584e000000b0020a9034e312mr19433566wrf.518.1650986881965;
        Tue, 26 Apr 2022 08:28:01 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:5959:ca32:2e01:b6fc? ([2001:861:44c0:66c0:5959:ca32:2e01:b6fc])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b00207b5d9f51fsm11725738wrf.41.2022.04.26.08.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 08:28:00 -0700 (PDT)
Message-ID: <f946068e-4f97-b6e2-1671-6580aa1a0105@baylibre.com>
Date:   Tue, 26 Apr 2022 17:27:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/bridge: fix it6505 Kconfig terms
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Robert Foss <robert.foss@linaro.org>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
References: <20220403151637.15546-1-rdunlap@infradead.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220403151637.15546-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/04/2022 17:16, Randy Dunlap wrote:
> Fix around 50 undefined references when DRM_ITE_IT6505=y while
> DRM_DP_AUX_BUS=m and DRM_DP_HELPER=m.
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Allen Chen <allen.chen@ite.com.tw>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Hermes Wu <hermes.wu@ite.com.tw>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> ---
>   drivers/gpu/drm/bridge/Kconfig |    2 ++
>   1 file changed, 2 insertions(+)
> 
> --- linux-next-20220401.orig/drivers/gpu/drm/bridge/Kconfig
> +++ linux-next-20220401/drivers/gpu/drm/bridge/Kconfig
> @@ -78,6 +78,8 @@ config DRM_ITE_IT6505
>           tristate "ITE IT6505 DisplayPort bridge"
>           depends on OF
>           select DRM_KMS_HELPER
> +	select DRM_DP_AUX_BUS
> +	select DRM_DP_HELPER

The indentation is wrong here.

>           select EXTCON
>           help
>             ITE IT6505 DisplayPort bridge chip driver.

Neil
