Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D95A4E94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiH2Nvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiH2Nvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:51:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A194EEB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:51:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb36so15803851ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=C2AjxMNWtzIecaqFsK7iRg4ch6dPyQx/KkfOOxiXtYg=;
        b=j6qW4o3z3baEDyFDKHuHqekQwtXbltPLi5duAgmuHm6bFSRWytH3Cvnp3br51bwDZ4
         iVeXMqGEjF3Arg4umGGmkAMgblbqyT1rPNHDTd/JtXOmZQY+oh+D+vQfQ96oJjXfabMf
         Up0NNnhMjRuILZTQlIw+zD4iRQdRSr85aTK2z06BHQxdOkV4p+oYwQzyHDVDHJw/SPyW
         gY5r/Vt54KS8CkPBfrnbtkEOXPKenXrmWJRNBpWvfo8FfVVj+tEppY6T0djYnhnbMfdV
         yWkbnXT1O7sCPmgsWAL3MfAiuqwE76UIs3Uu+BBvWdr/zrA4srpuWhnss1pf4EZHhLEe
         uGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=C2AjxMNWtzIecaqFsK7iRg4ch6dPyQx/KkfOOxiXtYg=;
        b=cap1q0WYABmIKCOHQ54iqRsmEW+moh5ew3iUYRGdsZWUGEI3luVTojt+6wpczxzYCa
         +BQv0dwtxJGpJbyt2IVPHs3tWw85DMgjXtnuDr41V54d7sPaEFSAP6x87vq8d16L7Gjj
         DMK5h1OJBN0xS6nZY411cJ9IWrSPzINHz/IFJPZrf3wkjy8exyA8X60Ho5wxkW30aAZL
         vxq9Osd93LxyyM2wCERlEsMMxl0OuYyOSr6zvz2FZc3csEapCaBZuGEA/0cRvQfCajxf
         o0vHWhkoEDp++Sh9kElLo51t4gxturpvHHsJ264w91h/vGub4C/DCrkNI+fITxDAjCj4
         /BPg==
X-Gm-Message-State: ACgBeo0nvqoTFsNaRHHi89TMCswsKJwcYvpCdCHdI0tpyatBgBOWWLUV
        1MKpLF6grxPtNiXYxu5oB4Dmmtkjn2GiKzdAEkem5w==
X-Google-Smtp-Source: AA6agR5N6OvgYRnL1gCQiIwUvNMBbnV9YYUPJqU898krDerbnUiyVa4rqTO2acXLCLQG7084iwFQay5QIxtE8nAp1tY=
X-Received: by 2002:a17:906:cc5d:b0:73d:c534:1aaa with SMTP id
 mm29-20020a170906cc5d00b0073dc5341aaamr13534876ejb.626.1661781091816; Mon, 29
 Aug 2022 06:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220812205746.609107-1-mairacanal@riseup.net> <20220812205746.609107-2-mairacanal@riseup.net>
In-Reply-To: <20220812205746.609107-2-mairacanal@riseup.net>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 29 Aug 2022 15:51:20 +0200
Message-ID: <CAG3jFyuMF4+Zfu2eDrE96nO7EWfhhQE8a+VQ=HhJ+iLYaX8HZg@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/bridge: anx7625: Drop of_gpio header
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maira,

On Fri, 12 Aug 2022 at 22:58, Ma=C3=ADra Canal <mairacanal@riseup.net> wrot=
e:
>
> This driver includes the deprecated OF GPIO header <linux/of_gpio.h>
> yet fail to use symbols from it, so drop the include.
>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index 79fc7a50b497..d7d4ca1c8b30 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -17,7 +17,6 @@
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>
> -#include <linux/of_gpio.h>
>  #include <linux/of_graph.h>
>  #include <linux/of_platform.h>
>
> --
> 2.37.1
>

This cleanup looks good to me.

Reviewed-by: Robert Foss <robert.foss@linar.org>
