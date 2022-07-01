Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D3B5637FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiGAQd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiGAQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:33:54 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AACD37A18;
        Fri,  1 Jul 2022 09:33:53 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id r133so2780195iod.3;
        Fri, 01 Jul 2022 09:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pmdu7h2iGcUXpSD7onJcpB+mZ1oZjCxRS5eOKqA9L/0=;
        b=7E56QWPT6uIFbazQw6rMUDF+N3cvnE5NZYL4Xkh2IiqMs39jn2ew+IKt8YWFTzZ19s
         y/gyV5Fld5vmj7J6cNHzWM5b2g7Ibm/SNjyPbEnf3mTclwzRftQnW0jEQnqUd47xlAmk
         bFFoyDJjiMChfpor1GOyMc9SJaYjdt6Cfjrup7ZPnVSRZ8fs0w4fg651qTMVYnZ3uPDF
         vUfn23dNOHycn2jwZvG/2LoSHEP8VLPqqTyNJmb+ZcyoYIbTlCKA+V//uw+ksAMzSho9
         Z1i3bcZvmVkA+wQxdQ00Z7cyufrI8Mm5zZV54Qf+dICGywLJnq2AI4GGnod5Gj0Xa3js
         XbJw==
X-Gm-Message-State: AJIora9Hg5nuayKUyECAMlAAJ76MKbkuBY7Ug7w/LvII7mo+519C8e70
        qF80Z1oORPySjtdQtkQ9aA==
X-Google-Smtp-Source: AGRyM1toBf+5L/GtFA+ZiGhKOyleryQNcTlxBQpBs2cfZITu2x1v1RS5UT4ctp9OaXWWl/vi9Qh+pA==
X-Received: by 2002:a05:6638:16c9:b0:33c:c0d9:d9fb with SMTP id g9-20020a05663816c900b0033cc0d9d9fbmr9324726jat.11.1656693232246;
        Fri, 01 Jul 2022 09:33:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f65-20020a0284c7000000b00339ddd8adddsm10008166jai.98.2022.07.01.09.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:33:51 -0700 (PDT)
Received: (nullmailer pid 1090177 invoked by uid 1000);
        Fri, 01 Jul 2022 16:33:50 -0000
Date:   Fri, 1 Jul 2022 10:33:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, vkoul@kernel.org, kishon@ti.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v1 3/9] dt-bindings: reset: intel,rcu-gw: Update bindings
 for "legacy" SoCs
Message-ID: <20220701163350.GA1078312-robh@kernel.org>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
 <20220628124441.2385023-4-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628124441.2385023-4-martin.blumenstingl@googlemail.com>
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

On Tue, Jun 28, 2022 at 02:44:35PM +0200, Martin Blumenstingl wrote:
> The Lantiq Amazon-SE, Danube, xRX100 and xRX200 SoCs have up to two USB2
> PHYs which are part of the RCU register space. The RCU registers on
> these SoCs are using big endian. Update the binding for these SoCs to
> properly describe this IP:
> - Add compatible strings for Amazon-SE, Danube and xRX100
> - Rename the xRX200 compatible string (which is not used anywhere) and
>   switch to the one previously documented in mips/lantiq/rcu.txt
> - Allow usage of "simple-mfd" and "syscon" in the compatible string so the
>   child devices (USB2 PHYs) can be described
> - Allow #address-cells and #size-cells to be set to 1 for describing the
>   child devices (USB2 PHYs)
> - #reset-cells must always be 3 (offset, reset bit and status bit) on the
>   legacy SoCs while LGM uses a fixed value of 2 (offset and reset bit -
>   status bit is always identical to the reset bit).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/reset/intel,rcu-gw.yaml          | 84 +++++++++++++++++--
>  1 file changed, 79 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> index be64f8597710..b90913c7b7d3 100644
> --- a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> +++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> @@ -11,9 +11,16 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - intel,rcu-lgm
> -      - intel,rcu-xrx200

It is okay to remove/change this because ?

> +    oneOf:
> +      - items:
> +          - enum:
> +              - lantiq,ase-rcu
> +              - lantiq,danube-rcu
> +              - lantiq,xrx100-rcu
> +              - lantiq,xrx200-rcu
> +          - const: simple-mfd

This says child nodes have 0 dependence on anything in the parent node. 
Such as a clock in the parent needing to be enabled.

> +          - const: syscon

Given the child nodes depend on this, I find the combination to be a 
contradiction. But it's widely used, so oh well.

> +      - const: intel,rcu-lgm
>  
>    reg:
>      description: Reset controller registers.
> @@ -33,8 +40,6 @@ properties:
>          maximum: 31
>  
>    "#reset-cells":
> -    minimum: 2
> -    maximum: 3
>      description: |
>        First cell is reset request register offset.
>        Second cell is bit offset in reset request register.
> @@ -43,6 +48,43 @@ properties:
>        reset request and reset status registers is same. Whereas
>        3 for legacy SoCs as bit offset differs.
>  
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  big-endian: true
> +
> +patternProperties:
> +  "^usb2-phy@[0-9a-f]+$":
> +    type: object
> +    $ref: "../phy/lantiq,xway-rcu-usb2-phy.yaml"
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: intel,rcu-lgm
> +    then:
> +      properties:
> +        "#reset-cells":
> +          const: 2

else:
  properties:
    "#reset-cells":
      const: 3

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - lantiq,ase-rcu
> +              - lantiq,danube-rcu
> +              - lantiq,xrx100-rcu
> +              - lantiq,xrx200-rcu
> +    then:
> +      properties:
> +        "#reset-cells":
> +          const: 3
> +
>  required:
>    - compatible
>    - reg
> @@ -67,3 +109,35 @@ examples:
>          #pwm-cells = <2>;
>          resets = <&rcu0 0x30 21>;
>      };
> +  - |
> +    rcu_xrx200: rcu@203000 {
> +        compatible = "lantiq,xrx200-rcu", "simple-mfd", "syscon";
> +        reg = <0x203000 0x100>;
> +        big-endian;
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        #reset-cells = <3>;
> +        intel,global-reset = <0x10 30 29>;
> +
> +        usb_phy0: usb2-phy@18 {
> +            compatible = "lantiq,xrx200-usb2-phy";
> +            reg = <0x18 4>, <0x38 4>;
> +            status = "disabled";

Why is your example disabled? Don't use 'status' in examples.

> +
> +            resets = <&rcu_xrx200 0x48 4 4>, <&rcu_xrx200 0x10 4 4>;

Humm, a dependency on the parent. Not a 'simple-mfd'.

> +            reset-names = "phy", "ctrl";
> +            #phy-cells = <0>;
> +        };
> +
> +        usb_phy1: usb2-phy@34 {
> +            compatible = "lantiq,xrx200-usb2-phy";
> +            reg = <0x34 4>, <0x3c 4>;
> +            status = "disabled";
> +
> +            resets = <&rcu_xrx200 0x48 5 5>, <&rcu_xrx200 0x10 4 4>;
> +            reset-names = "phy", "ctrl";
> +            #phy-cells = <0>;
> +        };
> +    };
> -- 
> 2.36.1
> 
> 
