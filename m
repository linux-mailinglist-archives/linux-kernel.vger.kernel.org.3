Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBED0524590
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350257AbiELGVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347424AbiELGVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:21:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0B63DA6F;
        Wed, 11 May 2022 23:21:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D2901F8F4;
        Thu, 12 May 2022 06:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652336503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZCkAVlqK4be51Iao9TAxRWn1tf1liEtuTyxdtziUME=;
        b=XVG6WYWpgxTlc1QAjyFQKda84XQH/ddCehEX3+/2JdRWk2RMHw5R/LvoiiNfHc4nab89Xs
        kQ67oaHGn1tkUhdflhKqGWWrsmS1rMJETQ8XjYXKK0HqlXWC2SD5qzJYH8rMDFIA/EMOZl
        yDZ3pX4FtTJyby1LI/LQpV52fdwo6Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652336503;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZCkAVlqK4be51Iao9TAxRWn1tf1liEtuTyxdtziUME=;
        b=qNpR4yLBd+2ipVw2OGK6OEjXYydiCTUrYps2c2J37BnzRoX93eYHSoUJXj4Qj1tNrNIlel
        y7d0feS5aOQV6GAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E430513ABE;
        Thu, 12 May 2022 06:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CY8eNHanfGKETAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:21:42 +0000
Message-ID: <d73f45d3-171f-a704-e479-411a54699d3b@suse.de>
Date:   Thu, 12 May 2022 08:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 03/23] dt-bindings: ata: ahci-platform: Clarify common
 AHCI props constraints
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
 <20220511231810.4928-4-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-4-Sergey.Semin@baikalelectronics.ru>
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
> Indeed in accordance with what is imeplemtned in the AHCI paltform driver

Spelling; 'imeplemtned' and 'paltform'

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
>   .../devicetree/bindings/ata/ahci-common.yaml      | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> index 620042ca12e7..a7d1a8353de3 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> @@ -31,6 +31,8 @@ properties:
>   
>     reg-names:
>       description: CSR space IDs
> +    contains:
> +      const: ahci
>   
>     interrupts:
>       description:
> @@ -71,14 +73,13 @@ properties:
>       maxItems: 1
>   
>     phy-names:
> -    maxItems: 1
> +    const: sata-phy
>   
>     ports-implemented:
>       $ref: '/schemas/types.yaml#/definitions/uint32'
>       description:
>         Mask that indicates which ports the HBA supports. Useful if PI is not
>         programmed by the BIOS, which is true for some embedded SoC's.
> -    maximum: 0x1f
>   
>   patternProperties:
>     "^sata-port@[0-9a-f]+$":
> @@ -89,8 +90,12 @@ patternProperties:
>   
>       properties:
>         reg:
> -        description: AHCI SATA port identifier
> -        maxItems: 1
> +        description:
> +          AHCI SATA port identifier. By design AHCI controller can't have
> +          more than 32 ports due to the CAP.NP fields and PI register size
> +          constraints.
> +        minimum: 0
> +        maximum: 31
>   
>         phys:
>           description: Individual AHCI SATA port PHY
> @@ -98,7 +103,7 @@ patternProperties:
>   
>         phy-names:
>           description: AHCI SATA port PHY ID
> -        maxItems: 1
> +        const: sata-phy
>   
>         target-supply:
>           description: Power regulator for SATA port target device

Other than that it looks okay.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
