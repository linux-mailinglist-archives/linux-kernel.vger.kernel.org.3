Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C614510269
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352727AbiDZQCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiDZQCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:02:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A3215F5A3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:59:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k36-20020a05600c1ca400b00393f18c8fc5so1851236wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=vRh1gD0f3xCVRZNs5NMMVExn4xhUo4jC6Jov5ZrW884=;
        b=zIByLgjbM9QAGOhZjZJUJReDTpiz294N6O4cijYSvWgNxgsBeKlVwDzSCZ1vjSZdQZ
         ujbZ0h6ZxRNH/KxYzigENRyLkhdBp09Kbv/V3ggeGVpYJNEB+x3hcHqNARjAh1LFTxkW
         CtC8rV53NDnCsiINaTrGiz9iMA/6OKs0tzX8wNazK2W8QcPvMBTeuakxSHOtH3Y/t5yc
         0eW+pt+P0q1biVbFkn59q1784t5TunNpDIrbj/97BpnuWT48yoUy0GFLR0Wf0Jn1AO8D
         KoUnhcaSznftaUmhUHaxk6CmIezYyBhg6U+D16lfHnaEYl5ypf19bO2xRLSQeCmNZXjT
         8ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=vRh1gD0f3xCVRZNs5NMMVExn4xhUo4jC6Jov5ZrW884=;
        b=XgPcO2kELKVpDnHP01JWTvi0B7p/N4j59Rno/SchntWwrNtLjRgUQPybey66dV+5Oj
         amZj35RMMRoOEdcDX+ddqu3WqIDdqwYxYnaUwlVk5mOZsvJtoduy2BAlTVUHml1R1qrL
         OnAFrh5M0P5RgMs57q8a16pbyA2Gk0d7rSDXq/0BOZvSCrV6Zzf7d24G6e/kCoMmUGro
         PX/wHDE3z8dX1JtAFQzOvHiGX6i5hhNDW+ytAjC6aBW4b4Xw0Cw0BKv0ABtDzERS50qM
         wZ+jod52qhFTTvrHncHHlBYskzdx/LUsrk8ZMNHbNnLRQS1tEOizI+Kly28YJOSa9wuh
         4I4g==
X-Gm-Message-State: AOAM533IcKZahLGfmLWfz9dgUelSkxBmiXLu+eZr9EgwbijbD8lLITvq
        TDALQof2Kw6jwTLT1OhZ+ELOaA==
X-Google-Smtp-Source: ABdhPJximPuxz37age9Ai2jn4zX6zE57K74hlGLzvJKA3IabgDDJmhry0esf/sX8PG4M5vD2xUx4GA==
X-Received: by 2002:a7b:c153:0:b0:38e:c1a6:453e with SMTP id z19-20020a7bc153000000b0038ec1a6453emr31697865wmi.131.1650988743282;
        Tue, 26 Apr 2022 08:59:03 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:5959:ca32:2e01:b6fc? ([2001:861:44c0:66c0:5959:ca32:2e01:b6fc])
        by smtp.gmail.com with ESMTPSA id k11-20020adfc70b000000b0020ad82e3ec8sm7150423wrg.62.2022.04.26.08.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 08:59:02 -0700 (PDT)
Message-ID: <13ca5824-c101-823a-b31e-ccf9a6971c20@baylibre.com>
Date:   Tue, 26 Apr 2022 17:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/bridge: ite-it6505: add missing Kconfig option select
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220426141536.274727-1-fparent@baylibre.com>
 <fd02a183-bcaa-86a8-8a13-52a9ddb374d5@baylibre.com>
 <20220426153931.suiuc7o53dt6s2es@radium>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220426153931.suiuc7o53dt6s2es@radium>
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

On 26/04/2022 17:39, Fabien Parent wrote:
> On Tue, Apr 26, 2022 at 05:29:31PM +0200, Neil Armstrong wrote:
>> On 26/04/2022 16:15, Fabien Parent wrote:
>>> The IT6505 is using functions provided by the DRM_DP_HELPER driver.
>>> In order to avoid having the bridge enabled but the helper disabled,
>>> let's add a select in order to be sure that the DP helper functions are
>>> always available.
>>>
>>> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
>>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>>> ---
>>>    drivers/gpu/drm/bridge/Kconfig | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>>> index 007e5a282f67..2145b08f9534 100644
>>> --- a/drivers/gpu/drm/bridge/Kconfig
>>> +++ b/drivers/gpu/drm/bridge/Kconfig
>>> @@ -78,6 +78,7 @@ config DRM_ITE_IT6505
>>>            tristate "ITE IT6505 DisplayPort bridge"
>>>            depends on OF
>>>            select DRM_KMS_HELPER
>>> +        select DRM_DP_HELPER
>>>            select EXTCON
>>>            help
>>>              ITE IT6505 DisplayPort bridge chip driver.
>>
>> http://lore.kernel.org/r/20220403151637.15546-1-rdunlap@infradead.org also select DRM_DP_AUX_BUS,
>> can you check if this is really neaded ?
> 
> Oops, I didn't notice that patch.
> 
> Anyway I can successfully link with the following config:
> CONFIG_DRM_ITE_IT6505=y
> CONFIG_DRM_DP_AUX_BUS=m
> CONFIG_DRM_DP_HELPER=y
> 
> But I cannot with the following config:
> CONFIG_DRM_ITE_IT6505=y
> CONFIG_DRM_DP_AUX_BUS=m
> CONFIG_DRM_DP_HELPER=m
> 
> This suggest that DRM_DP_AUX_BUS is not required for that driver.

Thanks for confirming:
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

> 
> Fabien
> 
>>
>> Neil

