Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A174250702A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353268AbiDSOXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353333AbiDSOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:22:47 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9409063B6;
        Tue, 19 Apr 2022 07:20:04 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id w194so153439oiw.11;
        Tue, 19 Apr 2022 07:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VgdRnd9bpdceRif0299S3ykKHSVMUwPtZgbwTlR6fjI=;
        b=FNnPwmgsPJkl2z17etPuuuhUE5Cxj52WD+uhuBoFGqXuaOOoEfZpETYb1HHueuBBOE
         /Kl7vh51nvn3Uef0AfUqnOcRprdy6ZrbotKUk4uhAVPfNW6TLRM+77ksXGB7eXOOgeCI
         sy92tRhoYTl7Vl7DWOYgQEROiJYc13jC/7bSUa4Ddr4nefIPH3cRAEBmOvbLZZoT5dnJ
         MW/aUK50EmNYcs8gKJ2WoAq9ZmsPkfkGMs+myyjj40kA5coVybwb/1sReIh6LQM7nrl4
         TpH0rez9r3ORvcfd5c4RlZjPnsHM1KnT3JExUSrsqd5m0QVqjT8yl3KYZwcnjZm6o3mb
         r51g==
X-Gm-Message-State: AOAM533B7OqF/a6eZF5O28HYCz917lF+FnDNKV6J7eFXfSKG80nB2Cpe
        xhkBhEmiTegX9/96TWnN+g==
X-Google-Smtp-Source: ABdhPJz/8eHniA/MbQVrURiit4Y5m329UMTk5wqUlgVlgHQSwRcyGZcRmbiP8oSqsceOmAnEhLvLow==
X-Received: by 2002:aca:c056:0:b0:322:4f77:517e with SMTP id q83-20020acac056000000b003224f77517emr8250843oif.18.1650378003722;
        Tue, 19 Apr 2022 07:20:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q6-20020a056870028600b000d9be0ee766sm5076841oaf.57.2022.04.19.07.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:20:03 -0700 (PDT)
Received: (nullmailer pid 2490554 invoked by uid 1000);
        Tue, 19 Apr 2022 14:20:02 -0000
Date:   Tue, 19 Apr 2022 09:20:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomba@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: ti,am65x-dss: Add missing
 register & interrupt
Message-ID: <Yl7FEuHEy66KUc5F@robh.at.kernel.org>
References: <20220419070302.16502-1-a-bhatia1@ti.com>
 <20220419070302.16502-2-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419070302.16502-2-a-bhatia1@ti.com>
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

On Tue, Apr 19, 2022 at 12:33:01PM +0530, Aradhya Bhatia wrote:
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

You've just broken the ABI.

New entries have to go on the end.

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

Once there is more than 1, we need to know what each entry is and the 
order.

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
> 
