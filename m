Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5351EAC5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 03:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiEHB1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 21:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiEHB1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 21:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7256F11A15;
        Sat,  7 May 2022 18:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F1160F7F;
        Sun,  8 May 2022 01:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE52AC385A6;
        Sun,  8 May 2022 01:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651973009;
        bh=bkpfuiHpthyo4eMUiXJ6/JZTEy7lTJlasVB2DKI6S8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+j+lD2+UAojrB2xodzbNxE19De7dQFVtyt/le/bgy8fvWA22kdpcJDwOhCYv0lok
         g1fCEwLdZHU9knJZxXdN2VJNQdqPqZqugRigzph1cgAt/Dh2diJ8ZafkZdH/Ipgdyo
         PKcKtWXL1DPoMs2wmwd4G77coyA7h7IwIQW6F/EWSsMeUmehlxejx00NS76TMx8B0o
         zm7KAci0oRJmswVOE7q+SKx8JOzRZVH+8Dz4s+4cm+iUH7uz3reEfNZ/wGZBpfegcR
         O9nTRTg/arAYEbVpJrIMr+U1pIZKT4IBulHqVzQwtf8rjrd+zddr0Y0XcIQ6msmuvD
         hzNl7qClY4Zmg==
Date:   Sun, 8 May 2022 09:23:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 1/4] dt-bindings: arm: fsl: add imx93 11x11 evk board
Message-ID: <20220508012321.GM14615@dragon>
References: <20220507065309.3964937-1-peng.fan@oss.nxp.com>
 <20220507065309.3964937-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507065309.3964937-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 02:53:06PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add the board imx93-11x11-evk in the binding docuemnt.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index b8b0efa55339..391f92282453 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -910,6 +910,11 @@ properties:
>                - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
>            - const: fsl,imx8mp
>  
> +      - description: i.MX93 based Boards
> +        items:
> +          - const: fsl,imx93-11x11-evk    # i.MX93 11x11 EVK Board
> +          - const: fsl,imx93
> +

It breaks the order of the list.  Should be added after
"i.MX8ULP based Board" entry, I think.

Shawn

>        - description: PHYTEC phyCORE-i.MX8MP SoM based boards
>          items:
>            - const: phytec,imx8mp-phyboard-pollux-rdk # phyBOARD-Pollux RDK
> -- 
> 2.25.1
> 
