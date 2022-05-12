Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF62D524577
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350210AbiELGOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350198AbiELGOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:14:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF8312FECD;
        Wed, 11 May 2022 23:14:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D080E1F8B4;
        Thu, 12 May 2022 06:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652336087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJJQrqKpUdOhCI/15eTOWlmDL44aOTRLwCxdI80vWys=;
        b=Ab4fhjGN9hMujF9ZN+gsSsGy6tsYzbYvAa5ArN/KK90xXmrpFSghVgedAZaH3Q2BZbaZBa
        j9dimymzknFMvoZyNq6e99KOC5AussfTs+dxIc4nYdhtHtFtUU8FYCCGgShzavagJFz4Hi
        E5ySt9g701QSSBMXNLTD1VBhRcNgIsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652336087;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJJQrqKpUdOhCI/15eTOWlmDL44aOTRLwCxdI80vWys=;
        b=JLnuxdSb7iPKEOeH4ztkyo0vK9bRc/4kBQtf0p+ych8SY539BF8WFYnv9AdsgGs7cA7Apd
        Z/bY751DUvy2cCAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B27A213ABE;
        Thu, 12 May 2022 06:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id inXXKtelfGIXSgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:14:47 +0000
Message-ID: <274a783c-256d-5d35-f1a8-d93fff6ea35a@suse.de>
Date:   Thu, 12 May 2022 08:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 01/23] dt-bindings: ata: ahci-platform: Drop
 dma-coherent property declaration
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
 <20220511231810.4928-2-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-2-Sergey.Semin@baikalelectronics.ru>
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
> It's redundant to have the 'dma-coherent' property explicitly specified in
> the DT schema because it's a generic property described in the core
> DT-schema by which the property is always evaluated.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> ---
>   Documentation/devicetree/bindings/ata/ahci-platform.yaml | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index c146ab8e14e5..9304e4731965 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -87,8 +87,6 @@ properties:
>       description:
>         regulator for AHCI controller
>   
> -  dma-coherent: true
> -
>     phy-supply:
>       description:
>         regulator for PHY power

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
