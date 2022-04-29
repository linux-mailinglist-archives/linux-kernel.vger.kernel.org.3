Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B78A515896
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381575AbiD2Wm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiD2Wm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:42:57 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A55CD64F6;
        Fri, 29 Apr 2022 15:39:38 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id z8so10003012oix.3;
        Fri, 29 Apr 2022 15:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cbmFT06gQ+FCLpyhadq3rgAfKDwGeHIVypMNjP8Pu5Y=;
        b=obYLyMKfzZjTtI4Q5XfaDc31nxhOvL5rm3Yob6a3v24zkuKO29Mfr8WbHohIV9Mvo/
         O6ocPhPPp6O+w40HjZLJAavfv0sfAsLkJHKkcWMNDpAcSOddt3StFlAqrG5HGm3TKuh3
         0C9FdSCz1HZVgPuw2h38jwYb7cIUczyYh7aExu2X1RR0d8uKzi/L3sK1/wlozb3EIHdF
         RZIOFwK1pagvz3ac1YGDslIKw+sE7PGwHodAjfxVPc9TdGTOFb2ae4DQHWppeCkKxLnw
         cQmMVz7m/gOuC01U53Mw/viMTQUDEckiVsv4kXrNVAT3E5ij0E/UmjgfO/qii27HVZp7
         nNLw==
X-Gm-Message-State: AOAM5335PR4G/YEzSOBDr/rudCtwqIqQnlkbWYyJFg3yfx63owzBrkJ3
        X7N2EwmOnKSN8FbSYWwWJg==
X-Google-Smtp-Source: ABdhPJwXBBj9cHsPWQwl+eX9LW5bTZAU6HexJBOWwqIuNHgx7dYVrz/3RzDOqd02GTqBEwED39x6Cg==
X-Received: by 2002:a54:4d9b:0:b0:324:f014:80d5 with SMTP id y27-20020a544d9b000000b00324f01480d5mr2634714oix.110.1651271977531;
        Fri, 29 Apr 2022 15:39:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l2-20020a4ad9c2000000b0035eb4e5a6b7sm1269496oou.13.2022.04.29.15.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:39:37 -0700 (PDT)
Received: (nullmailer pid 3032996 invoked by uid 1000);
        Fri, 29 Apr 2022 22:39:35 -0000
Date:   Fri, 29 Apr 2022 17:39:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 04/15] dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170
 compatible
Message-ID: <YmxpJ//rsCRBO2Jz@robh.at.kernel.org>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
 <20220428214838.1040278-5-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428214838.1040278-5-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 05:48:27PM -0400, Jesse Taube wrote:
> Add i.MXRT1170 compatible string to Documentation.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - New commit to fix dtbs_check
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 19621a2f8beb..b4d98a9c0952 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -34,6 +34,7 @@ properties:
>            - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
> +          - fsl,imx1050-usdhc

typo? Should be fsl,imxrt1050-usdhc?

>            - nxp,s32g2-usdhc
>        - items:
>            - enum:
> @@ -44,6 +45,11 @@ properties:
>                - fsl,imx8qm-usdhc
>                - fsl,imx8qxp-usdhc
>            - const: fsl,imx7d-usdhc
> +      - const: fsl,imxrt1050-usdhc

You don't need this line.

> +      - items:
> +          - enum:
> +              - fsl,imxrt1170-usdhc
> +          - const: fsl,imxrt1050-usdhc
>  
>    reg:
>      maxItems: 1
> -- 
> 2.35.1
> 
> 
