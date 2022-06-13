Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36FC549D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346153AbiFMTQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbiFMTQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:16:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131EF5FBD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:31:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h19so4784530wrc.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=b6LI4jSTppnwbn/7MHPjsmN7q6vhTZpE2X7+c7LKVK0=;
        b=TjSewGIwP0DCjp2l8QRZYjpF076U4CIy6nnYCGcm+6wAHhgocXZcndKQ01Sjwf9Z9x
         aXsRs94nQKH5njHHI5X7xUl9u0+ErvEIIcs8zmW47MyZ+dMJZxJ85VMQeFMaNCAD7vy3
         2ELYlJ9/lA4/XTMg+JlYX2JAu6BTqdSCb+uilS5l4cRVuQ8ixXvoQHC9Xp9/sVcMQxhZ
         35ROofq60l6F0c8S4Ebs/EkepuPtAh3ZzaZcxkoYYHjC7CFnab4ZQp0ZI7ywJZT3HeAZ
         YsajnPx8xEl6dED0MwsybEwHga8p1kd/sdmv+pyhisG6Wj9drHS0aIFJgwWat+9CyjoY
         NCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b6LI4jSTppnwbn/7MHPjsmN7q6vhTZpE2X7+c7LKVK0=;
        b=BNmi1AvuaLeRxqslSDWoBQhhINrP2LS69HDtzXjq3iUxmkIAXnbiaKq/AfC3DJyKpC
         5z0by4JMSwIyyRxFKQU5NevWHeJIvmthEkTj4QdGJgwjMlHH6lQBri/y6MBAqymV2ptr
         MBOD7MY+/vqJq3j5cZFUA2J/l5CfUM5vuxKpjTThH/S/e3ANJZ6AsoiLsE8d9/dokZJB
         2AkgEGai4PTMQld1i/QZfzfhvFS43GSsH39OVKhdy24B00nx0rW1WWNiOw2JccJgMZlX
         RgsFPs4oWbnOnP7KdoHJjKU8wi/DUvNEGyqXFmv1/nRY4XsLEljIdk2Fs4Aorw12OQoT
         sqWg==
X-Gm-Message-State: AJIora+piKsnOZ2QcPbzTBIX8y3q+r7an5wjJIXBnT99iSkPCXya5JGg
        sYnQEs6ZJNCYTp3yTt65Dkg=
X-Google-Smtp-Source: AGRyM1vtq4iKf+PhOy3uDZ8M6ggtx+BY/XhVl3NLTzqQGYY0BcpgVGbFm3Ker6Ngqo0WovrLJDRabw==
X-Received: by 2002:a5d:46cc:0:b0:214:2d66:2d51 with SMTP id g12-20020a5d46cc000000b002142d662d51mr886667wrs.349.1655141462582;
        Mon, 13 Jun 2022 10:31:02 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c3b8400b0039c5224bfcbsm14479675wms.46.2022.06.13.10.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:31:02 -0700 (PDT)
Date:   Mon, 13 Jun 2022 19:30:58 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Robert Foss <robert.foss@linaro.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: anx7625: Zero error variable when panel
 bridge not present
Message-ID: <20220613173058.GA132991@elementary>
References: <20220613163705.1531721-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613163705.1531721-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 12:37:05PM -0400, Nícolas F. R. A. Prado wrote:
> While parsing the DT, the anx7625 driver checks for the presence of a
> panel bridge on endpoint 1. If it is missing, pdata->panel_bridge stores
> the error pointer and the function returns successfully without first
> cleaning that variable. This is an issue since other functions later
> check for the presence of a panel bridge by testing the trueness of that
> variable.
> 
> In order to ensure proper behavior, zero out pdata->panel_bridge before
> returning when no panel bridge is found.
> 
> Fixes: 9e82ea0fb1df ("drm/bridge: anx7625: switch to devm_drm_of_get_bridge")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 53a5da6c49dd..3aed4de16690 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1657,8 +1657,10 @@ static int anx7625_parse_dt(struct device *dev,
>  
>  	pdata->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
>  	if (IS_ERR(pdata->panel_bridge)) {
> -		if (PTR_ERR(pdata->panel_bridge) == -ENODEV)
> +		if (PTR_ERR(pdata->panel_bridge) == -ENODEV) {
> +			pdata->panel_bridge = NULL;
>  			return 0;
> +		}
>  
>  		return PTR_ERR(pdata->panel_bridge);
>  	}
> -- 
> 2.36.1
> 

Thanks for spotting this error Nícolas. As you mentioned, prior to
9e82ea0fb1df the "pdata->panel_bridge" pointer was not modified
(i.e. left to NULL) on the ENODEV error branch.

I missed it during the refactor, sorry about that.
