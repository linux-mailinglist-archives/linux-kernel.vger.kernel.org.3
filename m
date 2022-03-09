Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3584D3D97
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbiCIXcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiCIXcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:32:19 -0500
X-Greylist: delayed 1460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Mar 2022 15:31:20 PST
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.51.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC332119413
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:31:20 -0800 (PST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 982551BC8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:06:59 -0600 (CST)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id S5OVnRO1Z22u3S5OVnB9zU; Wed, 09 Mar 2022 17:06:59 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d9Pj9k0JNH8SUjGrNlVfpwb0uWjmzh22akXzSnwgw0c=; b=rmdVolCQVW9S9lBuuetI/MtrZr
        oX/qOdvDQd+546CwDLIO70GhQ6P22WhZuIqNFA2uxpFwp+PUAWGNgM0Mo+C8W9MJl5TDS9wChh1vq
        il5GOzwPz/CYfnBj3lRalIxlvq20Hww5g2d/kdCCPiH3tRinT470AbCwz5KJXvWuXZiDQTjjvGjbK
        8Xs4xbEQPmyU7sMhZifoo+oWNWwP3STJY3ldX0NDa7FR3Zpue80qKYkx24kq6d3jQg2D9AvHRTCW5
        ydNBP/Zq360MgkkEUd3D7dmboCN9Tlyp89zbAbMKgXZABSG1Ej6/YzrpBdsJLTvlRQADWCTLfNEU7
        NBYN5nnQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57404 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nS5OU-000E8V-Pr; Wed, 09 Mar 2022 23:06:58 +0000
Date:   Wed, 9 Mar 2022 15:06:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: renesas,wdt: Document RZ/V2L
 SoC
Message-ID: <20220309230657.GA3801916@roeck-us.net>
References: <20220301122332.14796-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301122332.14796-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nS5OU-000E8V-Pr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57404
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 36
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 12:23:32PM +0000, Lad Prabhakar wrote:
> Document RZ/V2L WDT bindings. RZ/V2L WDT is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-wdt" will be used as a fallback.
> 
> While at it, drop the comment "# RZ/G2L" for "renesas,rzg2l-wdt"
> compatible string as this will avoid changing the line for every new
> SoC addition.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v1->v2:
> * Included RB tags
> * Drop the comment "# RZ/G2L" for "renesas,rzg2l-wdt" compatible string
>   as suggested by Geert.
> 
> v1:
> https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220227225309.28098-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> index 91a98ccd4226..146ae20eacbb 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> @@ -22,7 +22,8 @@ properties:
>        - items:
>            - enum:
>                - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
> -          - const: renesas,rzg2l-wdt     # RZ/G2L
> +              - renesas,r9a07g054-wdt    # RZ/V2L
> +          - const: renesas,rzg2l-wdt
>  
>        - items:
>            - enum:
