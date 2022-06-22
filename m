Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5401554DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358168AbiFVOxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357566AbiFVOxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:53:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493D97651
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:53:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u15so7137662ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WW5wittx5G93z/fxX3hONBF5yJMDD5Vb20PalWKZlwc=;
        b=xiUiZvtEaIGVWNVnRez41O11BTnN0TVeMjGeQ0uv6FabQWCJRCJtQTfjt70Y/C7sGH
         03hotucc5vivg7+i/Jn6k3NGEaSMS/8Nh78Cyy0VkUMAevQvBN7u4SOqq3hXmKdPy/y9
         zKEiK2xP1wYN671Vx8hD79QuVf3iZ99jqSXJIpXuzk3yBoTCzPGic/xwp3RSoLnhY6rP
         dEsDJ2fwU2UCzTv6141pm0oHxKP3MtR+jJO/SaQkcmyz1t0XhrEg6Q/QirYF92WUznhC
         XN1GmdctLZ31oInQNAoAQ03yiUjEl8kpchtnFeLKeIORdYSSb6CV4jDzO3aHulQeqshR
         KuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WW5wittx5G93z/fxX3hONBF5yJMDD5Vb20PalWKZlwc=;
        b=1rQhzrMbUtmm2thRRBMnAwP9bhsSnPxqpF6YY05uZ39Xh61gPU+NW3U5FWsDIaHwtD
         3oCq0A9DobcQxzVyjyFrUzRuw/alf6fBWeTUAoAbdvli0AWb82mzK9Xe1GoI8jpogMOd
         xd0bi1AMJkYlUOEecehuLxjp1JAm9zJv7SwJNHlPKsQ1mIPFnBqheGhEJ6wXFXyQmEDM
         ocmSejxIIPLYwBP9cyi2lpzLnM6BPju6t8/6+8lkURq2gEmw4QIeZGzavYpgYWKDErzA
         /r/sTemoLqw4/8TtCCEUld0L65DMGFni1WI5j0Na3OgtXaiHIr/fqqwiF0wJMVygoZtL
         +YwQ==
X-Gm-Message-State: AJIora+sW+68389wOzcA+d1OMeo3N/PT4sgNepC2SYCeNG3lW+Fw5CGv
        5MHr4HPs2cB0PW4v2U4NbZGm4g==
X-Google-Smtp-Source: AGRyM1uPgeut0y2Ppo8Aai3MFPCopfyBrMHoOygiSUD3tz424dyZas7hNdeqizhQQiP1tfLjUAuEPA==
X-Received: by 2002:a17:907:1b0c:b0:6fe:25bf:b3e5 with SMTP id mp12-20020a1709071b0c00b006fe25bfb3e5mr3427169ejc.689.1655909579662;
        Wed, 22 Jun 2022 07:52:59 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906308600b006fec63e564bsm9485417ejv.30.2022.06.22.07.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:52:59 -0700 (PDT)
Message-ID: <9bb9cd5b-2a92-4fbd-c83a-a4a5e4e1d90e@linaro.org>
Date:   Wed, 22 Jun 2022 16:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 3/7] dt-bindings: usb: Add Type-C switch binding
Content-Language: en-US
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
References: <20220615172129.1314056-1-pmalani@chromium.org>
 <20220615172129.1314056-4-pmalani@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220615172129.1314056-4-pmalani@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 19:20, Prashant Malani wrote:
> Introduce a binding which represents a component that can control the
> routing of USB Type-C data lines as well as address data line
> orientation (based on CC lines' orientation).
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
