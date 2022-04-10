Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C720E4FAB39
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 02:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiDJArj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 20:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiDJArd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 20:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36065E13;
        Sat,  9 Apr 2022 17:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A32F60ABE;
        Sun, 10 Apr 2022 00:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4ECC385A4;
        Sun, 10 Apr 2022 00:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649551523;
        bh=ibGsfvoxyETUMsOBNUAGCCBYPkqHdtnM/rr3Q+QX1XA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1rV7onQT8dM2y9Or9t5ccLspwi/uyRZ8+KZ7KC1E6gYXmHvkfy6ZEXZJvZ2Z+O4w
         Egdmri5I8gBi598YO53X5692QK3xwF+I3hNNHod4FVl9V0/6ItrZRweODAfC6MCaUY
         cH6/csfuaYlKXicm4Qyp9m23/HuRgcJdY7cRupjE9VWZcYqhO1tgPHz1bcQDUdtiQk
         B1hxX3kgBWqSyid4LloP02tcJ9yAtx1R0SWOtVqYuqoAkDEObmbpiQx1enw1+rvh9T
         sKcJyCQpn65PjfChUTJ+Aq/vGEtgB3J3lLzLLNLlT4mwlms1UVnTRkoPCeGblricuo
         G/yK/qCzp8hyA==
Date:   Sun, 10 Apr 2022 08:45:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     max.krummenacher@toradex.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>, Lucas Stach <dev@lynxeye.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] dt-bindings: arm: fsl: imx6dl-colibri: Drop
 dedicated v1.1 bindings
Message-ID: <20220410004514.GD129381@dragon>
References: <20220314162958.40361-1-max.krummenacher@toradex.com>
 <20220314162958.40361-2-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314162958.40361-2-max.krummenacher@toradex.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 05:29:45PM +0100, Max Krummenacher wrote:
> The dedicated device tree for V1.1 modules has been dropped. Remove
> its bindings too.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Please fix your email client to avoid the checkpatch warning below.

WARNING: From:/Signed-off-by: email address mismatch: 'From: Max Krummenacher <max.oss.09@gmail.com>' != 'Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>'

Shawn

> ---
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 97f6eebad76a..cf854203bfb1 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -411,7 +411,6 @@ properties:
>                - technologic,imx6dl-ts4900
>                - technologic,imx6dl-ts7970
>                - toradex,colibri_imx6dl      # Colibri iMX6 Modules
> -              - toradex,colibri_imx6dl-v1_1 # Colibri iMX6 V1.1 Modules
>                - udoo,imx6dl-udoo          # Udoo i.MX6 Dual-lite Board
>                - vdl,lanmcu                # Van der Laan LANMCU board
>                - wand,imx6dl-wandboard     # Wandboard i.MX6 Dual Lite Board
> @@ -492,13 +491,6 @@ properties:
>            - const: toradex,colibri_imx6dl           # Colibri iMX6DL/S Module
>            - const: fsl,imx6dl
>  
> -      - description: i.MX6DL Boards with Toradex Colibri iMX6DL/S V1.1 Modules
> -        items:
> -          - enum:
> -              - toradex,colibri_imx6dl-v1_1-eval-v3 # Colibri iMX6DL/S V1.1 M. on Colibri Evaluation Board V3
> -          - const: toradex,colibri_imx6dl-v1_1      # Colibri iMX6DL/S V1.1 Module
> -          - const: fsl,imx6dl
> -
>        - description: i.MX6S DHCOM DRC02 Board
>          items:
>            - const: dh,imx6s-dhcom-drc02
> -- 
> 2.20.1
> 
