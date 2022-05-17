Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8491C52ABBE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352559AbiEQTOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346100AbiEQTON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:14:13 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D1B38BF9;
        Tue, 17 May 2022 12:14:12 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id a22-20020a9d3e16000000b00606aeb12ab6so12826596otd.7;
        Tue, 17 May 2022 12:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dmlJ+WrVnHqQkYVAdf8E6mqVMyTNk109pO+okefrzE0=;
        b=fF8iKKBGndm9nz18ruvNSMSAW+/KrrhElY1aJdbuEt3BdB+Vp554iikh2IOd0GXPP4
         fYSFz/mNwn6xWOW834iKLcAof4Jbw9fsx454SeH94iimPMKNzHCxbnVzx7Mb4zh93NqS
         BFdxk+lM+ywZ4bs8H+KOCVPEIFP+mDGJLJyKa4o82TvNtRJvdgOgjrIQPh/GMBNgCcI2
         us+PwKwLkC9pQhA4drLYXcSMg5C4E0fVWkZzM/trvLRd75/2A27vg3+3ad9yCYvIPG1i
         J+wLxvdEESSaSCT7LAxTNd82g2NkvkJwlvJpTHglfc4ZWaaXJwAfEldhwdEapPSnNbTV
         s5MA==
X-Gm-Message-State: AOAM532N8XjRzsBDqmSaVhRLtpWFhwTSan/YLRZcum55vsAEaL/Ggqvw
        J7AcsQDzlBGaMSdB4tJOrUThSOZdng==
X-Google-Smtp-Source: ABdhPJzeIxaVmNc6cK48l1Uxajk2FN2DcpRhsKvsVRKMFX9a6fnSKfhctVBNlus42xU+fjBJtDju4Q==
X-Received: by 2002:a9d:61c3:0:b0:605:e1cf:ff90 with SMTP id h3-20020a9d61c3000000b00605e1cfff90mr8645516otk.54.1652814851492;
        Tue, 17 May 2022 12:14:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t82-20020acaaa55000000b00326b27905adsm86638oie.2.2022.05.17.12.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 12:14:10 -0700 (PDT)
Received: (nullmailer pid 1450827 invoked by uid 1000);
        Tue, 17 May 2022 19:14:09 -0000
Date:   Tue, 17 May 2022 14:14:09 -0500
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
Subject: Re: [PATCH v3 03/23] dt-bindings: ata: ahci-platform: Clarify common
 AHCI props constraints
Message-ID: <20220517191409.GA1445438-robh@kernel.org>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511231810.4928-4-Sergey.Semin@baikalelectronics.ru>
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

On Thu, May 12, 2022 at 02:17:50AM +0300, Serge Semin wrote:
> Indeed in accordance with what is imeplemtned in the AHCI paltform driver
> and the way the AHCI DT nodes are defined in the DT files we can add the
> next AHCI DT properties constraints: AHCI CSR ID is fixed to 'ahci', PHY
> name is fixed to 'sata-phy', AHCI controller can't have more than 32 ports
> by design.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Changelog v2:
> - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> ---
>  .../devicetree/bindings/ata/ahci-common.yaml      | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> index 620042ca12e7..a7d1a8353de3 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> @@ -31,6 +31,8 @@ properties:
>  
>    reg-names:
>      description: CSR space IDs
> +    contains:
> +      const: ahci

Okay, with this it makes sense to keep. The others still should go.

>  
>    interrupts:
>      description:
> @@ -71,14 +73,13 @@ properties:
>      maxItems: 1
>  
>    phy-names:
> -    maxItems: 1
> +    const: sata-phy
>  
>    ports-implemented:
>      $ref: '/schemas/types.yaml#/definitions/uint32'
>      description:
>        Mask that indicates which ports the HBA supports. Useful if PI is not
>        programmed by the BIOS, which is true for some embedded SoC's.
> -    maximum: 0x1f
>  
>  patternProperties:
>    "^sata-port@[0-9a-f]+$":
> @@ -89,8 +90,12 @@ patternProperties:
>  
>      properties:
>        reg:
> -        description: AHCI SATA port identifier
> -        maxItems: 1
> +        description:
> +          AHCI SATA port identifier. By design AHCI controller can't have
> +          more than 32 ports due to the CAP.NP fields and PI register size
> +          constraints.
> +        minimum: 0
> +        maximum: 31
>  
>        phys:
>          description: Individual AHCI SATA port PHY
> @@ -98,7 +103,7 @@ patternProperties:
>  
>        phy-names:
>          description: AHCI SATA port PHY ID
> -        maxItems: 1
> +        const: sata-phy
>  
>        target-supply:
>          description: Power regulator for SATA port target device
> -- 
> 2.35.1
> 
> 
