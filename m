Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2074F54BD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbiFNWTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiFNWTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:19:21 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987605002A;
        Tue, 14 Jun 2022 15:19:20 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id i16so10900141ioa.6;
        Tue, 14 Jun 2022 15:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yVlJIdRp+gVn79PICqL9caznCEb0HPWba25K7SqGmeI=;
        b=uAp+0wqUY85/kotizyoRld9yWnX7i8aANxj8bWgO40kQ38h138Ig536jaVjFH7WQXl
         sNxoebYqGbkkbI3BwIvMT7BbkQ0cMqmRMW13OQ3fGMOMyvKBT48Ghz6+rCbbNlLUlEsR
         OaotuVA1qVzKReTmV4P8BaGEr5cUZc/aiqeuZVdoNNj2wq4irWPxqeH+B/++XeAQByH+
         b58P40pDocPnglBodm4ME0/6pn0LegxWuFnRUgaXEqsjMxDmrZSKx1HLlQkAMnJdyZlg
         3HgNnMqCwuxs83K4JhticZUJF8seZHyJjz1xtE6VtwKSs3e8ILki3KmNN0UE5DTA+fi5
         IgJw==
X-Gm-Message-State: AOAM5325dfad2q89cj9eZTJlwLjnUtO4FMVefwQosL/LCiEre1EaRbBk
        4bjR72UhMiek5uv2G/Igtvm366+8EA==
X-Google-Smtp-Source: ABdhPJw4oSZc1AA4n2DOSG62M39PXRkbcLqng1Nkke8x7UpJgOEapzjBxO4ZULWmWhZeaE197ufYDw==
X-Received: by 2002:a05:6602:2f0a:b0:66a:e67:e776 with SMTP id q10-20020a0566022f0a00b0066a0e67e776mr3442783iow.114.1655245159731;
        Tue, 14 Jun 2022 15:19:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id u7-20020a02cbc7000000b003315d11b825sm5320424jaq.13.2022.06.14.15.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 15:19:19 -0700 (PDT)
Received: (nullmailer pid 2830108 invoked by uid 1000);
        Tue, 14 Jun 2022 22:19:17 -0000
Date:   Tue, 14 Jun 2022 16:19:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 11/23] dt-bindings: ata: ahci: Add platform capability
 properties
Message-ID: <20220614221917.GA2824584-robh@kernel.org>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610081801.11854-12-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:17:49AM +0300, Serge Semin wrote:
> In case if the platform doesn't have BIOS or a comprehensive firmware
> installed then the HBA capability flags will be left uninitialized. As a
> good alternative we suggest to define the DT-properties with the AHCI
> platform capabilities describing all the HW-init flags of the
> corresponding capability register. Luckily there aren't too many of them.
> SSS - Staggered Spin-up support and MPS - Mechanical Presence Switch
> support determine the corresponding feature availability for the whole HBA
> by means of the "hba-cap" property. Each port can have the "hba-port-cap"
> property initialized indicating that the port supports some of the next
> functionalities: HPCP - HotPlug capable port, MPSP - Mechanical Presence
> Switch attached to a port, CPD - Cold Plug detection, ESP - External SATA
> Port (eSATA), FBSCP - FIS-based switching capable port.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - Fix some misspelling in the patch log.
> - Convert the boolean properties to the bitfield properties. (@Rob)
> - Remove Hannes' rb tag due to the patch content change.
> ---
>  .../devicetree/bindings/ata/ahci-common.yaml  | 16 +++++++++++++++
>  .../bindings/ata/ahci-platform.yaml           | 10 ++++++++++
>  include/dt-bindings/ata/ahci.h                | 20 +++++++++++++++++++
>  3 files changed, 46 insertions(+)
>  create mode 100644 include/dt-bindings/ata/ahci.h
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> index 12a97b56226f..94d72aeaad0f 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> @@ -58,6 +58,14 @@ properties:
>    phy-names:
>      const: sata-phy
>  
> +  hba-cap:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description:
> +      Bitfield of the HBA generic platform capabilities like Staggered
> +      Spin-up or Mechanical Presence Switch support. It can be used to
> +      appropriately initialize the HWinit fields of the HBA CAP register
> +      in case if the system firmware hasn't done it.
> +
>    ports-implemented:
>      $ref: '/schemas/types.yaml#/definitions/uint32'
>      description:
> @@ -101,6 +109,14 @@ $defs:
>        target-supply:
>          description: Power regulator for SATA port target device
>  
> +      hba-port-cap:
> +        $ref: '/schemas/types.yaml#/definitions/uint32'
> +        description:
> +          Bitfield of the HBA port-specific platform capabilities like Hot
> +          plugging, eSATA, FIS-based Switching, etc (see AHCI specification
> +          for details). It can be used to initialize the HWinit fields of
> +          the PxCMD register in case if the system firmware hasn't done it.
> +
>      required:
>        - reg
>  
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index 15be98e0385b..e19cf9828e68 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -111,6 +111,8 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/clock/berlin2q.h>
> +    #include <dt-bindings/ata/ahci.h>
> +
>      sata@f7e90000 {
>          compatible = "marvell,berlin2q-ahci", "generic-ahci";
>          reg = <0xf7e90000 0x1000>;
> @@ -119,15 +121,23 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> +        hba-cap = <HBA_SMPS>;
> +
>          sata0: sata-port@0 {
>              reg = <0>;
> +
>              phys = <&sata_phy 0>;
>              target-supply = <&reg_sata0>;
> +
> +            hba-port-cap = <(HBA_PORT_FBSCP | HBA_PORT_ESP)>;
>          };
>  
>          sata1: sata-port@1 {
>              reg = <1>;
> +
>              phys = <&sata_phy 1>;
>              target-supply = <&reg_sata1>;
> +
> +            hba-port-cap = <(HBA_PORT_HPCP | HBA_PORT_MPSP | HBA_PORT_FBSCP)>;
>          };
>      };
> diff --git a/include/dt-bindings/ata/ahci.h b/include/dt-bindings/ata/ahci.h
> new file mode 100644
> index 000000000000..6841caebcedf
> --- /dev/null
> +++ b/include/dt-bindings/ata/ahci.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +/*
> + * This header provides constants for most AHCI bindings.
> + */
> +
> +#ifndef _DT_BINDINGS_ATA_AHCI_H
> +#define _DT_BINDINGS_ATA_AHCI_H
> +
> +/* Host Bus Adapter generic platform capabilities */
> +#define HBA_SSS		(1 << 27)
> +#define HBA_SMPS	(1 << 28)
> +
> +/* Host Bus Adapter port-specific platform capabilities */
> +#define HBA_PORT_HPCP	(1 << 18)
> +#define HBA_PORT_MPSP	(1 << 19)
> +#define HBA_PORT_CPD	(1 << 20)
> +#define HBA_PORT_ESP	(1 << 21)
> +#define HBA_PORT_FBSCP	(1 << 22)
> +
> +#endif
> -- 
> 2.35.1
> 
> 
