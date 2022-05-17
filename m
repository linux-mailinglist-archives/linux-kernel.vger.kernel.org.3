Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC152ABD4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352671AbiEQTUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiEQTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:20:32 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85094427C5;
        Tue, 17 May 2022 12:20:30 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id y14-20020a9d460e000000b00605ee347da1so12849616ote.8;
        Tue, 17 May 2022 12:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jMly9zZBObNQRlIQNVFaY06sIaIahtck7cQNpLIcDRE=;
        b=KKoXsBtHuSNOScxelpdcaXSSyde0uepEm+1Ux+7wgTUTXxBsGkBRIwtGfDennVrdC/
         evN14D9bjfi3tXZclJiES0gg7zLekoeeAvisaPBWkxOEGp+8Ssb2gK7JRqIibGR589PJ
         2z5lRLQPDfNy7h7sdGWFngY2GGbRE7fnDsfb0POp5cmM0Tx0jsJ70EtxnEXTuSiN0+lZ
         hC1jERIwYSfXAXB6zKHG2fLQrMU3BQfVwtBad4dnER57esbvs7/V/KdET0ogJ/EIXV4W
         Krt5BhZT5W2/cma9kcdqjbTG6X0EtzuNcGeU4S9EtBMyiq5WZ3W3fTfXDSU5kYjJnnfU
         WK4g==
X-Gm-Message-State: AOAM530fRhiVxTknSA2Y+miEsxAtZ/JBKLdgtMoayhKaXOVSf7t9vbg6
        X1NOHGzc/juuf7K9lNQwmUOaXimBSA==
X-Google-Smtp-Source: ABdhPJxxgh/F0v4j8Y3VuOwu8SOZrLN5lBS78tigzQM+mMPyMT6Ic8wZDNl1+FvOjbANN75Eh0ioYg==
X-Received: by 2002:a9d:4d8c:0:b0:606:2a57:7f5 with SMTP id u12-20020a9d4d8c000000b006062a5707f5mr8721462otk.78.1652815229742;
        Tue, 17 May 2022 12:20:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p12-20020a9d454c000000b00606b237d850sm98549oti.13.2022.05.17.12.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 12:20:29 -0700 (PDT)
Received: (nullmailer pid 1461903 invoked by uid 1000);
        Tue, 17 May 2022 19:20:28 -0000
Date:   Tue, 17 May 2022 14:20:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 12/23] dt-bindings: ata: ahci: Add platform capability
 properties
Message-ID: <20220517192028.GA1453662-robh@kernel.org>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511231810.4928-13-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 02:17:59AM +0300, Serge Semin wrote:
> In case if the platform doesn't have BIOS or a comprehensive firmware
> installed then the HBA capability flags will be left uninitialized. As a
> good alternative we can define a set AHCI DT-node properties to describe
> all of HW-init capabilities flags. Luckily there aren't too many of them.
> SSS - Staggered Spin-up support and MPS - Mechanical Presence Switch
> support determine the corresponding feature availability for whole HBA by
> means of the "hba-sss" and "hba-smps" properties.  Each port can have the
> "hba-{hpcp,mpsp,cpd,esp,fbscp}" defined indicatating that the port
> supports the next functionality: HPCP - HotPlug capable port, MPSP -
> Mechanical Presence Switch attached to a port, CPD - Cold Plug detection,
> ESP - External SATA Port (eSATA), FBSCP - FIS-based switching capable
> port.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Alternatively we could define them as a bitfield, but having a set of
> boolean properties seemed a better idea since in that case we can
> implement a simple inter-dependency rules for them, which can't be done
> should we take the bitfields path.

I would just provide a CAP register override and be done with it.

The boolean fields only let you set a capability, but not unset one. 
They would need to be tristate.

> ---
>  .../devicetree/bindings/ata/ahci-common.yaml  | 66 +++++++++++++++++++
>  .../bindings/ata/ahci-platform.yaml           | 11 ++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> index a7d1a8353de3..a29edfbb25db 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> @@ -75,6 +75,19 @@ properties:
>    phy-names:
>      const: sata-phy
>  
> +  hba-sss:
> +    type: boolean
> +    description:
> +      Staggered Spin-up Support. Indicates whether the HBA supports the
> +      staggered spin-up on its ports, for use in balancing power spikes.
> +
> +  hba-smps:
> +    type: boolean
> +    description:
> +      Mechanical Presence Switch Support. Indicates whether the HBA supports
> +      mechanical presence switches on its ports for use in hot plug
> +      operations.
> +
>    ports-implemented:
>      $ref: '/schemas/types.yaml#/definitions/uint32'
>      description:
> @@ -97,6 +110,40 @@ patternProperties:
>          minimum: 0
>          maximum: 31
>  
> +      hba-hpcp:
> +        type: boolean
> +        description:
> +          Hot Plug Capable Port. Indicates that this port’s signal and power
> +          connectors are externally accessible via a joint signal and power
> +          connector for blindmate device hot plug. It is mutually exclusive
> +          with the ESP feature.
> +
> +      hba-mpsp:
> +        type: boolean
> +        description:
> +          Mechanical Presence Switch Attached to Port. Indicates whether
> +          the platform an mechanical presence switch attached to this
> +          port.
> +
> +      hba-cpd:
> +        type: boolean
> +        description:
> +          Cold Presence Detection. Indicates whether the platform supports
> +          cold presence detection on this port.
> +
> +      hba-esp:
> +        type: boolean
> +        description:
> +          External SATA Port. Indicates that this port’s signal connector
> +          is externally accessible on a signal only connector (e.g. eSATA
> +          connector).
> +
> +      hba-fbscp:
> +        type: boolean
> +        description:
> +          FIS-based Switching Capable Port. Indicates whether this port
> +          supports Port Multiplier FIS-based switching.
> +
>        phys:
>          description: Individual AHCI SATA port PHY
>          maxItems: 1
> @@ -111,6 +158,25 @@ patternProperties:
>      required:
>        - reg
>  
> +    # eSATA can't be enabled together with the HotPlug capability
> +    oneOf:
> +      - required:
> +          - hba-hpcp
> +      - required:
> +          - hba-esp
> +      - not:
> +          anyOf:
> +            - required:
> +                - hba-hpcp
> +            - required:
> +                - hba-esp
> +
> +    # HotPlug capability must be enabled together with Cold Plug
> +    # Detection and Mechanical Presence Switching.
> +    dependencies:
> +      hba-cpd: ["hba-hpcp"]
> +      hba-mpsp: ["hba-hpcp"]
> +
>      additionalProperties: true
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index 76075d3c8987..6cad7e86f3bb 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -117,14 +117,25 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> +        hba-smps;
> +
>          sata0: sata-port@0 {
>              reg = <0>;
> +
> +            hba-fbscp;
> +            hba-esp;
> +
>              phys = <&sata_phy 0>;
>              target-supply = <&reg_sata0>;
>          };
>  
>          sata1: sata-port@1 {
>              reg = <1>;
> +
> +            hba-fbscp;
> +            hba-hpcp;
> +            hba-mpsp;
> +
>              phys = <&sata_phy 1>;
>              target-supply = <&reg_sata1>;
>          };
> -- 
> 2.35.1
> 
> 
