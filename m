Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459BC569CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiGGIM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiGGIMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:12:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC893192D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:12:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v16so13725177wrd.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=5KfID2vuM9CP0pMWQOIDcQIWQounMtJmRp+vRLZPJ6g=;
        b=vXiTyYAYMh0EwfFiUwBp/Apr5OkbQGXt0OLPij1Xt8AeDJRdmS84oHyrZKfZwTPAWG
         g///yHMqtUNLS9XG9d7jbap2sF/2AkpcIy1PHGBCzbJqhgx83ElRx14WQFjNxpL6pguf
         hukDPr+JlrTg2jtEjMBP1CNn67CiJXpzDnpQwI2nuoVGh/cKOhmoh7tns7aQ+/Ol8aPb
         Av78TOeVoSI3aB3VsADL+XyAW7fRxBzdEVjL38Wvd9xEjJXA/hRkq8aLlMjXUFrAy8WF
         f5m5Abi3clYRYb4fOtfDzgmWJI0qdap5FBY/T1UrgKpfark383YbDitGo5GDHUj/D8Bn
         rIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=5KfID2vuM9CP0pMWQOIDcQIWQounMtJmRp+vRLZPJ6g=;
        b=cP0SyExbw4MeiKEm9UOtDK11ejikqOydv7HmBLS+I/VQ3ggH2i/5Jgj+6rqbwa90LT
         4KtazKaYCoUU5Mrme44F+Jc8xNvtfWC9v2NOSXH6Q1OEprEFPpmd0oCfk5c8JZ/jleHi
         pVR7Aa6PBJXZX8E8y+vuKJG+kZV3K1dLowI0gh1Ga1Zu9sNwOnJ9lgcy76/6vWAuYEc5
         FjZb1ujJl6U9qHWNiUsezEGOEbrk6O3QMnuFDcAb945fNU5JHyy6+pCNE4qPoRA34OEb
         pQvDNjI+u8RehD9r+CYM+3h8fHA5FJUU0J0ofFON/UDi41/swXH+7HyYLMWYfAVLMV01
         7JTg==
X-Gm-Message-State: AJIora83ch0zqmccNBPcQSf1hEk3IMyO3LOCzGlqD2qHySP70rCARJ/B
        ETwSQyoCsp/AgmfXea0b/wtyFA==
X-Google-Smtp-Source: AGRyM1uKML1qmvsrD8QZ1sHB4rThITkVFvlqHifUHsC9bHdadZZyiox3TC38A0dOfryc4q384xmqJQ==
X-Received: by 2002:a5d:584c:0:b0:21c:1395:f0c4 with SMTP id i12-20020a5d584c000000b0021c1395f0c4mr40937029wrf.24.1657181522410;
        Thu, 07 Jul 2022 01:12:02 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:ae1e:293e:9510:6c36? ([2001:861:44c0:66c0:ae1e:293e:9510:6c36])
        by smtp.gmail.com with ESMTPSA id bq25-20020a5d5a19000000b0021d6d74a0ecsm9303406wrb.96.2022.07.07.01.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 01:12:02 -0700 (PDT)
Message-ID: <08146e65-0189-b74a-5548-2a773da5d51f@baylibre.com>
Date:   Thu, 7 Jul 2022 10:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] drm/bridge: fsl-ldb: Fix mode clock rate validation
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>, Marek Vasut <marex@denx.de>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org, linux-imx@nxp.com
References: <20220701065634.4027537-1-victor.liu@nxp.com>
 <20220701065634.4027537-2-victor.liu@nxp.com>
 <201c6bb7-ad86-5b89-e9a1-20a5740b8869@denx.de>
 <CAG3jFyun7NkLCy+bM0XHNRPrk6_kt7z8aB4Ud+4HdeNhffQydA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <CAG3jFyun7NkLCy+bM0XHNRPrk6_kt7z8aB4Ud+4HdeNhffQydA@mail.gmail.com>
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

Hi,

On 06/07/2022 15:34, Robert Foss wrote:
> On Fri, 1 Jul 2022 at 13:00, Marek Vasut <marex@denx.de> wrote:
>>
>> On 7/1/22 08:56, Liu Ying wrote:
>>> With LVDS dual link, up to 160MHz mode clock rate is supported.
>>> With LVDS single link, up to 80MHz mode clock rate is supported.
>>> Fix mode clock rate validation by swapping the maximum mode clock
>>> rates of the two link modes.
>>>
>>> Fixes: 463db5c2ed4a ("drm: bridge: ldb: Implement simple Freescale i.MX8MP LDB bridge")
>>> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>>> Cc: Robert Foss <robert.foss@linaro.org>
>>> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>>> Cc: Jonas Karlman <jonas@kwiboo.se>
>>> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
>>> Cc: David Airlie <airlied@linux.ie>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> Cc: Sam Ravnborg <sam@ravnborg.org>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: NXP Linux Team <linux-imx@nxp.com>
>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Applied 1-2/3 to drm-misc-next. Picked Mareks patch for 3/3 since it
> was submitted first and is identical.

Seems we'll have a conflict when drm-misc-fixes is backmerged in drm-misc-next !

Neil
