Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7DC595FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiHPP7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiHPP7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:59:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823B340E06;
        Tue, 16 Aug 2022 08:57:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27GFuo1R009280;
        Tue, 16 Aug 2022 10:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660665410;
        bh=hF1G+UmMgunfhWfrMJQlFTQPKah74HDd79WdAbqaK/s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=X1evldaX/mpN5VpJ/e/wy1wpiufmRJjWYJXr+/8VD1jsgZ7LPrG11wiPNRO4tfZ/h
         xB0mTLKdFWGPmVFPPIvBVXq22xwtwzKjkVEcUrG9jtqAx2T88keQlP2BSF9auYgd1e
         RDUoAXOcs/GXd5DTb9UCozVwCRiOIxZGL21LxdOo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27GFuoGA062891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Aug 2022 10:56:50 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 16
 Aug 2022 10:56:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 16 Aug 2022 10:56:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27GFunOS005780;
        Tue, 16 Aug 2022 10:56:49 -0500
Date:   Tue, 16 Aug 2022 10:56:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Robert Nelson <robertcnelson@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
Subject: Re: [PATCH] dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
Message-ID: <20220816155649.zbnqds65hb7g2zy7@stoic>
References: <20220815234824.772836-1-robertcnelson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220815234824.772836-1-robertcnelson@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:48-20220815, Robert Nelson wrote:
> This board is based on the ti,j721e
> 

Might want to add the links:

https://beagleboard.org/ai-64
https://git.beagleboard.org/beagleboard/beaglebone-ai-64

> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Nishanth Menon <nm@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index 61c6ab4f52e2..ecb5fa9d4644 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -36,6 +36,7 @@ properties:
>                - enum:
>                    - ti,j721e-evm
>                    - ti,j721e-sk
> +                  - beagle,j721e-beagleboneai64

alpha sort might be nice, but I see we have'nt been too consistent here.

>                - const: ti,j721e
>  
>        - description: K3 J7200 SoC
> -- 
> 2.30.2
> 

Also please sequence the patches so that the bindings come prior to the
dts.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
