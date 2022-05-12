Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D552458A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350251AbiELGTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350240AbiELGTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:19:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF20222C30;
        Wed, 11 May 2022 23:19:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDD0421C01;
        Thu, 12 May 2022 06:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652336375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W4zJzTbI8PefgbWx1zx74MIYt9iZv7cublZ+LgLMo64=;
        b=PDZYeurxQVL67/hgOv8uyiB8QMeTaTuZEtMXTTBTpzOfHR49w3DfCESf2M0NAHGPy0nQ43
        Q8UjVUqpWKBPJLrWuW8JMi0fQdmfboEkJ4EDEk/PLdGNFYaCn5ykk4941/QhUj2uH/5iVn
        OkpH6cXexRoagH5nc3JIfXXhaseAr+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652336375;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W4zJzTbI8PefgbWx1zx74MIYt9iZv7cublZ+LgLMo64=;
        b=4siQAhW4qAw0ZkKfV3Xadtrge5QnnE3nh4VyugvHfIpczGW80vpSD83Zp09CMQeqy3N3Pb
        avyBBHSO9nH3ARAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BC2413ABE;
        Thu, 12 May 2022 06:19:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JyGyIvemfGLSSwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:19:35 +0000
Message-ID: <63a15d7a-df10-3f6c-3eb5-1fb9e9742c16@suse.de>
Date:   Thu, 12 May 2022 08:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 02/23] dt-bindings: ata: ahci-platform: Detach common
 AHCI bindings
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-3-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-3-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 01:17, Serge Semin wrote:
> In order to create a more sophisticated AHCI controller DT bindings let's
> divide the already available generic AHCI platform YAML schema into the
> platform part and a set of the common AHCI properties. The former part
> will be used to evaluate the AHCI DT nodes mainly compatible with the
> generic AHCI controller while the later schema will be used for more
> thorough AHCI DT nodes description. For instance such YAML schemas design
> will be useful for our DW AHCI SATA controller derivative with four clock
> sources, two reset lines, one system controller reference and specific
> max Rx/Tx DMA xfers size constraints.
> 
> Note the phys and target-supply property requirement is preserved in the
> generic AHCI platform bindings because some platforms can lack of the
> explicitly specified PHYs or target device power regulators.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Folks, I don't really see why the phys/target-supply requirement has been
> added to the generic AHCI DT schema in the first place. Probably just to
> imply some meaning for the sub-nodes definition. Anyway in one of the
> further patches I am adding the DW AHCI SATA controller DT bindings which
> won't require having these properties specified in the sub-nodes, but will
> describe additional port-specific properties. That's why I get to keep the
> constraints in the ahci-platform.yaml schema instead of moving them to the
> common schema.
> 
> Changelog v2:
> - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> 
> Changelog v3:
> - Replace Jens's email address with Damien's one in the list of the
>    schema maintainers. (@Damien)
> ---
>   .../devicetree/bindings/ata/ahci-common.yaml  | 117 ++++++++++++++++++
>   .../bindings/ata/ahci-platform.yaml           |  68 +---------
>   2 files changed, 123 insertions(+), 62 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> new file mode 100644
> index 000000000000..620042ca12e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ahci-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Properties for Serial ATA AHCI controllers
> +
> +maintainers:
> +  - Hans de Goede <hdegoede@redhat.com>
> +  - Damien Le Moal <damien.lemoal@opensource.wdc.com>
> +
> +description:
> +  This document defines device tree properties for a common AHCI SATA
> +  controller implementation. It's hardware interface is supposed to
> +  conform to the technical standard defined by Intel (see Serial ATA
> +  Advanced Host Controller Interface specification for details). The
> +  document doesn't constitute a DT-node binding by itself but merely
> +  defines a set of common properties for the AHCI-compatible devices.
> +
> +select: false
> +
> +allOf:
> +  - $ref: sata-common.yaml#
> +
> +properties:
> +  reg:
> +    description:
> +      Generic AHCI registers space conforming to the Serial ATA AHCI
> +      specification.
> +
> +  reg-names:
> +    description: CSR space IDs
> +
> +  interrupts:
> +    description:
> +      Generic AHCI state change interrupt. Can be implemented either as a
> +      single line attached to the controller as a set of the dedicated signals
> +      for the global and particular port events.
> +
> +  clocks:
> +    description:
> +      List of all the reference clocks connected to the controller.
> +
> +  clock-names:
> +    description: Reference clocks IDs
> +
> +  resets:
> +    description:
> +      List of the reset control lines to reset the controller clock
> +      domains.
> +
> +  reset-names:
> +    description: Reset line IDs
> +
> +  power-domains:
> +    description:
> +      List of the power domain the AHCI controller being a part of.
> +
> +  ahci-supply:
> +    description: Power regulator for AHCI controller
> +
> +  target-supply:
> +    description: Power regulator for SATA target device
> +
> +  phy-supply:
> +    description: Power regulator for SATA PHY
> +
> +  phys:
> +    description: Reference to the SATA PHY node
> +    maxItems: 1
> +
> +  phy-names:
> +    maxItems: 1
> +
> +  ports-implemented:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description:
> +      Mask that indicates which ports the HBA supports. Useful if PI is not
> +      programmed by the BIOS, which is true for some embedded SoC's.
> +    maximum: 0x1f
> +
> +patternProperties:
> +  "^sata-port@[0-9a-f]+$":
> +    type: object
> +    description:
> +      It is optionally possible to describe the ports as sub-nodes so
> +      to enable each port independently when dealing with multiple PHYs.
> +
> +    properties:
> +      reg:
> +        description: AHCI SATA port identifier
> +        maxItems: 1
> +
> +      phys:
> +        description: Individual AHCI SATA port PHY
> +        maxItems: 1
> +
> +      phy-names:
> +        description: AHCI SATA port PHY ID
> +        maxItems: 1
> +
> +      target-supply:
> +        description: Power regulator for SATA port target device
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: true
> +
> +required:
> +  - reg
> +  - interrupts
> +
> +additionalProperties: true
> +
> +...
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index 9304e4731965..76075d3c8987 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -36,8 +36,7 @@ select:
>       - compatible
>   
>   allOf:
> -  - $ref: "sata-common.yaml#"
> -
> +  - $ref: "ahci-common.yaml#"
>   

What happened to 'sata-common.yaml' ?
Not needed anymore? Included via other means?

Please clarify.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
