Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DEC5B2863
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiIHVTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIHVTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:19:22 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79789114A54;
        Thu,  8 Sep 2022 14:19:18 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-12ab0eaa366so8437883fac.13;
        Thu, 08 Sep 2022 14:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KMHsaGNDvslboYLAxw3EKuXtaLLoCBvjt3oIq+2C3AI=;
        b=N6A/5jHb9pINSezlUayMPfNuu/of3L6lEuFgg/6HfMR7GUICUY7ZlKzKVZKNGknyMy
         3D5+hm3SXUpba+QpSo8VAFUCfmfGRo+wSwH8K6NhTsksR7fj8XMyPlYNeMHOTnm8nAjt
         iSC5niKAP77riumXmBZt3K9ssNLOjQIViq5p+u/+MvgOUsmXAErw4GIcaDR0T8pU5nTe
         7KG9ZWApuvPpJcnyddY3cga5lbU5ucnU0uQvhEXta/4/OEmTPIIEtjWkN1lD6sXSmKEk
         GbB2Bwauvxz3pXBM1Gn87nUXbkPonEq41j5KZW72dv5vQNGU2uK0FO0Ihn62yzSFFigX
         U+Gg==
X-Gm-Message-State: ACgBeo1puL9cMFrvBSmBMWIZ8ZLtI9YUdBo1656qHvvUk9qpTm+Qin2Y
        u93vN6iN4CsplR59a+Bb0Q==
X-Google-Smtp-Source: AA6agR6qv2N7WLFSotO1lYgem5+1/Wg2sBDJ7EN5QweFLaR/H/u0neTRujfbz8NSHxZIfTXmdrF5Hg==
X-Received: by 2002:a05:6808:e90:b0:345:6ee0:9a68 with SMTP id k16-20020a0568080e9000b003456ee09a68mr2499120oil.173.1662671957745;
        Thu, 08 Sep 2022 14:19:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h18-20020a9d6f92000000b006396521c804sm67750otq.55.2022.09.08.14.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:19:17 -0700 (PDT)
Received: (nullmailer pid 3359326 invoked by uid 1000);
        Thu, 08 Sep 2022 21:19:16 -0000
Date:   Thu, 8 Sep 2022 16:19:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add i.MX8M Mini Gateworks GW7904
 board
Message-ID: <20220908211916.GA3348959-robh@kernel.org>
References: <20220902230500.2624739-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902230500.2624739-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 04:04:59PM -0700, Tim Harvey wrote:
> Add DT compatible string for i.MX8M Mini based Gateworks GW7904 board.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 7431579ab0e8..ce89fac1898e 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -831,6 +831,7 @@ properties:
>                - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
>                - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
>                - gw,imx8mm-gw7903          # i.MX8MM Gateworks Board
> +              - gateworks,imx8mm-gw7904   # i.MX8MM Gateworks Board

A useful comment would be ones that distuiguish these boards. It's 
obvious from the compatible it's a i.MX8MM board from Gateworks.

>                - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
>                - menlo,mx8menlo            # i.MX8MM Menlo board with Verdin SoM
>                - toradex,verdin-imx8mm     # Verdin iMX8M Mini Modules
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
