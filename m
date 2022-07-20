Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE32957C0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiGTX2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiGTX2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:28:49 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F963DBFE;
        Wed, 20 Jul 2022 16:28:48 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id v1so6515915ilg.4;
        Wed, 20 Jul 2022 16:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lj7ZdYTFFmCvkqUW4bAz3eNYzxAsTwlFDtn0plbsmo0=;
        b=DJXkppJdKOPyCg2Z0RN6txhAFLuws5ec8BVKTs6m2AMq7pF7/bB3RxVwkKNmKJkjnD
         XzCB3MFX/OEgg9J+aiUrOALdzjoUF1Q0/EuOYusFK8Bqsf3uJYmHgaeMI8ldvRSaiFw+
         UqaAMJDXpw/tSWCnWB20/d1GXQuEgCU5lDFLsbaORoFL7haXiobOQMSlVi/KbIs5WuR5
         FDttw6QnfJi+dMsu+244QNCY4na22W6Jaw0I+gGl3BtUANCrBMU2Uf0oAbXWfW70WuhB
         PghNvx1RHatceaWNWXF0FKBBimaSQrL+94jMVexORjY6OOjITx7hc5FqQe5JRA3csQsk
         7OgA==
X-Gm-Message-State: AJIora9btXD94l1S98vzucwRs6Tmzr25+eKZJ99cXXGKPa9ywSuMIOss
        gvCY25wcnCncQ56CbPXieATc9FFuiQ==
X-Google-Smtp-Source: AGRyM1vSrC7x8Cv1BL5qsGSLx/0xJk23RB7zjk5vAxLrkaX7Jwt32B8ZciEUdlhXO22D9AlabLTxpg==
X-Received: by 2002:a92:d64a:0:b0:2dc:fa9f:7b27 with SMTP id x10-20020a92d64a000000b002dcfa9f7b27mr6200033ilp.173.1658359727764;
        Wed, 20 Jul 2022 16:28:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s12-20020a92d90c000000b002dc1f1a7cc2sm147953iln.31.2022.07.20.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:28:47 -0700 (PDT)
Received: (nullmailer pid 4179862 invoked by uid 1000);
        Wed, 20 Jul 2022 23:28:45 -0000
Date:   Wed, 20 Jul 2022 17:28:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Darren Etheridge <detheridge@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: display: ti,am65x-dss: Add port
 properties for DSS
Message-ID: <20220720232845.GA4164694-robh@kernel.org>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-2-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719080845.22122-2-a-bhatia1@ti.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 01:38:38PM +0530, Aradhya Bhatia wrote:
> Add "ti,oldi-mode" property to indicate the tidss driver the OLDI output
> mode. The 2 OLDI TXes on am625-dss allow a 3 different types of panel
> connections with the board.
> 
> 1. Single Link / Single Mode on OLDI TX 0 OR 1.
> 2. Single Link / Duplicate Mode on OLDI TX 0 and 1.
> 3. Dual Link / Single Mode on OLDI TX 0 and 1.
> 
> Add "ti,rgb565-to-888" property to override 16bit output from a videoport
> for a bridge that only accepts 24bit RGB888 DPI input.
> 
> On some boards the HDMI bridge takes a 24bit DPI input, but only 16 data
> pins are actually enabled from the SoC.  This new property forces the
> output to be RGB565 on a specific video port if the bridge requests a
> 24bit RGB color space.
> 
> This assumes that the video port is connected like so:
> 
> SoC : Bridge
> R0 ->   R3
> R1 ->   R4
> R2 ->   R5
> R3 ->   R6
> R4 ->   R7
> G0 ->   G2
> G1 ->   G3
> G2 ->   G4
> G3 ->   G5
> G4 ->   G6
> G5 ->   G7
> B0 ->   B3
> B1 ->   B4
> B2 ->   B5
> B3 ->   B6
> B4 ->   B7
> 
> On the bridge side R0->R2, G0->G1, B0->B2 would be tied to ground.
> The bridge sees 24bits of data,  but the lsb's are always zero.

Unless the bridge ignores the LSBs, that's not the right way to do 16 to 
24 bit. The LSBs should be connected to the MSB of the color component 
to get full color range.

> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  .../bindings/display/ti/ti,am65x-dss.yaml     | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index 6bbce921479d..11d9b3821409 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -80,15 +80,35 @@ properties:
>  
>      properties:
>        port@0:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description:
>            The DSS OLDI output port node form video port 1
>  
> +        properties:
> +          ti,oldi-mode:
> +            description: TI specific property to indicate the mode the OLDI TXes
> +              and the display panel are connected in.
> +              0 -> OLDI TXes OFF (driver default for am625-dss)
> +              1 -> Single link, Single Mode (OLDI0) (driver default for am65x-dss)
> +              2 -> Single link, Single Mode (OLDI1)
> +              3 -> Single link, Duplicate Mode
> +              4 -> Dual link (Only Single Mode)
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3, 4]

Wouldn't 'data-lanes' property work for this purpose.

Generally, we don't put properties in port nodes.

> +
>        port@1:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description:
>            The DSS DPI output port node from video port 2
>  
> +        properties:
> +          ti,rgb565-to-888:
> +            description:
> +              property to override DPI output to 16bit for 24bit bridge
> +            type: boolean

There's work underway for standard way to handle interface formats[1]. 
Please help/comment on that to make sure it works for you. 

Rob

[1] https://lore.kernel.org/all/20220628181838.2031-3-max.oss.09@gmail.com/
