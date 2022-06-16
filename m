Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFDD54EB59
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378223AbiFPUjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378465AbiFPUjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:39:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB3F5DD12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:39:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso2501911pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pkTlqBCv4kkUBzXfdE69AlbwDzWnDXPmq1X/ctwZ1RI=;
        b=ROZn+y/7o3WKT8p5stMPNJszpKJne4D3/Za9voE4D9qs7VwnFgZTseD6+HxsBnKHov
         rlTxbyYs4W0Iquvo4qHE70ivqOFlD9BOvwBoC+2PAKOw5Li1rI5SuWzQIMoZoQdgMPQQ
         xeKSWDr237Bfr3p2GiCiYStFm/NkPc/o4cp4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pkTlqBCv4kkUBzXfdE69AlbwDzWnDXPmq1X/ctwZ1RI=;
        b=leVyaMbJjB6Z/0k/Hhkffu0Qit4JNU3yVMXY17tmQyj74KIpDs+uQ2fi6nsdifhcod
         gUmDu81XJnlzh9ISeZ0nI/yXzZmww+ZO7r2gmqrMR88jEnCnT+hpTEXDRmU+nQPDr6vQ
         1D/1ypt9WFOjnUq+20U10xGF2d9XW8XGRmp4n021SI5w1l+xru3FvWGjrqkAG5JohsW4
         YE5uqkfAmtGF7mUIMEQiLj2JNZ/0lRa0ZhJ6T/WQgBav6KzbFxJMd6atFKTpiwCVamQ/
         oisT5jRvfU57mWg5tvBYSjfRgQyWMYsC7VvTrRF89ArR2sXmooohTM43OTdy5VJXoIOO
         /rDg==
X-Gm-Message-State: AJIora+yzE2ykYX7fOEGhEv1u0cdoGWWda7/WFNeohN24vhHBnadN9As
        tWqQOgyZinUZLQw4gKHBl/QrFQ==
X-Google-Smtp-Source: AGRyM1uRzdYi2h3WMgzsyG09F2s9/Uo4CiVLNg4n/tohSEwV59gL8BG6VgxVEBMNWkC3PEFczoXGPA==
X-Received: by 2002:a17:902:a609:b0:169:a8b:7c3c with SMTP id u9-20020a170902a60900b001690a8b7c3cmr3281133plq.67.1655411957916;
        Thu, 16 Jun 2022 13:39:17 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4709:a407:1ca6:24ea])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b00168b9093a06sm2038204plb.243.2022.06.16.13.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:39:16 -0700 (PDT)
Date:   Thu, 16 Jun 2022 13:39:14 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ASoC: dt-bindings: rockchip: Document
 pinctrl-names for i2s
Message-ID: <YquU8hN+9ETu8tB2@google.com>
References: <20220616155836.3401420-1-judyhsiao@chromium.org>
 <20220616155836.3401420-4-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616155836.3401420-4-judyhsiao@chromium.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 03:58:36PM +0000, Judy Hsiao wrote:
> This patch documents pinctrl-names for i2s.
> 
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
> index 5ea16b8ef93f..af1069278623 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
> +++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
> @@ -61,6 +61,13 @@ properties:
>            - const: tx
>            - const: rx
>  
> +  pinctrl-names:
> +    oneOf:
> +      - const: default
> +        - items:

I'm far from a YAML expert, but I think you have the indentation wrong?
You want the "const: default" and the "items:" schema to be on the same
level of indentation, right?

If you haven't already, you might run through the 'make
dt_binding_check' process.

Brian

> +          - const: bclk_on
> +          - const: bclk_off
> +
>    power-domains:
>      maxItems: 1
>  
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 
