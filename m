Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E82D4D2A54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiCIIFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCIIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:05:33 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CF9710D5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:04:34 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so2840043wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 00:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=U1D/3A7OGVZLniswJ8+s6z6Hi+6szsOAA85P72ar9O4=;
        b=oXXmdxSa9EK6PyApp1vchkzTPZQjHDdJA2RhBUOj685CSyBtqbbl1sfN+Opd04o/w9
         rgl0Lu9ILcp0+8aNQo39SMl7gZFK7BxzWO5+l/9OVoB3AsHrvNp+LiJ2hyu8w+xXsSkP
         li1E968Ru6mwKyqk0Q1OfrenTNITj0+uGoLufw38g7hWrnR2Knok6ni1QX9xyTBkAnI4
         veLjferX2gyXo8bx36F5vrz5MQHnbOT54ot25FvEE5t7Q3zJoAP+hfwme0ZX9oVwHDIc
         3/XGdcYpMMTEqvfAGDtYgptGNPV3A1yOKHAiPUEoI7ZJfPsr2BKrjbjXxuzSfV+/zqhD
         V0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=U1D/3A7OGVZLniswJ8+s6z6Hi+6szsOAA85P72ar9O4=;
        b=BRYS+CcxVIxNYAw24N8ojefoHuVuJdLw+e6RykfnQ74bn9sERmtvm2azjl/UQ25tXk
         cM7jHP8rRmkm2eDEyfBrKzZoXpkSPHhts6ycZncfWi5jWsJ7g6nodXFLyK+pOcxrNy2c
         fU8KxUuwtIktW+XqnEqIObtXPj1niGe+2vOO3Vk+8P3rmJg1M5AP4AJZJSDRzPwsVjwM
         +XbmwtNnm0d8Ir16vpE8Vf3LKtox7esFDO5hWsQeAr1X5nfHb9q2kTlXPwsUFsK3NOGr
         /ojRo94Ery39ud1Dd5qhULkOekgjT9cDaOjpkNKj8j180gSMJ5zhXNMDW/C6B+7e7m6R
         tJuQ==
X-Gm-Message-State: AOAM530I5uoNAk8s77rK5+gLkk4zhutQQT9fPZ3g9OBH2XCmQ2uYxb+m
        h4GoaQge+V2ZwkFFml2doqP22Q==
X-Google-Smtp-Source: ABdhPJxWAnPzNAFriE/hOf1GBpLWPZEaTw/EytIGyGix86yk1qL/T8KwVPxgeXpbYVmDGBWcOyborg==
X-Received: by 2002:a05:600c:a45:b0:346:5e67:cd54 with SMTP id c5-20020a05600c0a4500b003465e67cd54mr6430729wmq.127.1646813073133;
        Wed, 09 Mar 2022 00:04:33 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:e587:9f12:6489:6b8? ([2001:861:44c0:66c0:e587:9f12:6489:6b8])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b00389a420e1ecsm967251wmb.37.2022.03.09.00.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 00:04:32 -0800 (PST)
Message-ID: <9fb21623-60e1-fe35-b740-9577f096f84e@baylibre.com>
Date:   Wed, 9 Mar 2022 09:04:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] drm/bridge: Add MAINTAINERS entry for DRM drivers for
 bridge chip bindings
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
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

On 08/03/2022 20:06, Douglas Anderson wrote:
> The bindings for bridge chips should also get the same maintainers
> entry so the right people get notified about bindings changes.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0216d2ffe728..a73179d55d00 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6403,6 +6403,7 @@ R:	Jonas Karlman <jonas@kwiboo.se>
>   R:	Jernej Skrabec <jernej.skrabec@gmail.com>
>   S:	Maintained
>   T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	Documentation/devicetree/bindings/display/bridge/
>   F:	drivers/gpu/drm/bridge/
>   
>   DRM DRIVERS FOR EXYNOS

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
