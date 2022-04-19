Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B225506C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243313AbiDSMnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiDSMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:43:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6352E9C8;
        Tue, 19 Apr 2022 05:40:52 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23JCeWUV017359;
        Tue, 19 Apr 2022 07:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650372032;
        bh=SAynF30FSQ6K9ukzyMaqpx99lcJVTiwSIIzH8EHuwe4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uvQAkjBBE3/CiJqPsVLJgPqNUoeOumc+7aH/vpWPI1UDaTbd/8lJ1tKeKOWf5ixyY
         BO7sonjVuQPlrfxB4iLw/PVCy5KlbYeR6s+bpQu2Q0zFXj8Duocpr+5Mm8xfvOi5h/
         GHIohB1kJamvtzo6ahWQsjw6VP2Qi2EoYa5c5VVM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23JCeWTq007823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Apr 2022 07:40:32 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Apr 2022 07:40:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Apr 2022 07:40:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23JCeVSN083693;
        Tue, 19 Apr 2022 07:40:31 -0500
Date:   Tue, 19 Apr 2022 07:40:31 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
CC:     Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomba@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: ti,am65x-dss: Add missing
 register & interrupt
Message-ID: <20220419124031.5b6bn3yoqzlgjgcw@coleslaw>
References: <20220419070302.16502-1-a-bhatia1@ti.com>
 <20220419070302.16502-2-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220419070302.16502-2-a-bhatia1@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:33-20220419, Aradhya Bhatia wrote:
> The DSS IP on the ti-am65x soc supports an additional register space,
> named "common1". Further. the IP services a maximum number of 2
> interrupts.
> 
> Add the missing register space "common1" and the additional interrupt.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  .../devicetree/bindings/display/ti/ti,am65x-dss.yaml   | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index 5c7d2cbc4aac..102059e9e0d5 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -26,6 +26,7 @@ properties:
>        Addresses to each DSS memory region described in the SoC's TRM.
>      items:
>        - description: common DSS register area
> +      - description: common1 DSS register area
>        - description: VIDL1 light video plane
>        - description: VID video plane
>        - description: OVR1 overlay manager for vp1
> @@ -36,6 +37,7 @@ properties:
>    reg-names:
>      items:
>        - const: common
> +      - const: common1
>        - const: vidl1
>        - const: vid
>        - const: ovr1
> @@ -64,7 +66,7 @@ properties:
>      maxItems: 3
>  
>    interrupts:
> -    maxItems: 1
> +    maxItems: 2

What are the interrupts supposed to be?

>  
>    power-domains:
>      maxItems: 1
> @@ -122,13 +124,14 @@ examples:
>      dss: dss@4a00000 {
>              compatible = "ti,am65x-dss";
>              reg =   <0x04a00000 0x1000>, /* common */
> +            reg =   <0x04a01000 0x1000>, /* common1 */
>                      <0x04a02000 0x1000>, /* vidl1 */
>                      <0x04a06000 0x1000>, /* vid */
>                      <0x04a07000 0x1000>, /* ovr1 */
>                      <0x04a08000 0x1000>, /* ovr2 */
>                      <0x04a0a000 0x1000>, /* vp1 */
>                      <0x04a0b000 0x1000>; /* vp2 */
> -            reg-names = "common", "vidl1", "vid",
> +            reg-names = "common", "common1". "vidl1", "vid",
>                      "ovr1", "ovr2", "vp1", "vp2";
>              ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
>              power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
> @@ -136,7 +139,8 @@ examples:
>                              <&k3_clks 216 1>,
>                              <&k3_clks 67 2>;
>              clock-names = "fck", "vp1", "vp2";
> -            interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>;
> +            interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>;
>              ports {
>                      #address-cells = <1>;
>                      #size-cells = <0>;
> -- 
> 2.35.3
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
