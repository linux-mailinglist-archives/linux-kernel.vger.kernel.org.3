Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC55245A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350303AbiELGX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350294AbiELGX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:23:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDCD59BB1;
        Wed, 11 May 2022 23:23:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 17FA621AE4;
        Thu, 12 May 2022 06:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652336633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2Ziuk/8n/V8x8TU5pFnBuxK3RFdRleKuAeFlcwHMJc=;
        b=vu4hYqFJsyev3Gj8hLLyi8kcnv7HULOzkVHqS06qJ8fLlDDiYRhZc35qSAq/4hp2ZHPqy1
        FiueDsPPbh9CcmbwZVa5JKduvgtpULsxtlnrqu/8CgMQd8vfDa9ODMplwixcda06v7J8s5
        N7qSQP6iWBgk8naYH+YtqbN1TcXj9dY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652336633;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2Ziuk/8n/V8x8TU5pFnBuxK3RFdRleKuAeFlcwHMJc=;
        b=fxThtM4CCSKxbBnru7/B789HB2PG/RVOrKqqr5hjF/B0Z5t3PjM9Ld4jJmKtB6Jvl6Z5+i
        t+YijYvgsczK3aBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2D4713ABE;
        Thu, 12 May 2022 06:23:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a4pMJvinfGI5TQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:23:52 +0000
Message-ID: <271251bf-f941-4db3-5ffd-f54439a5434d@suse.de>
Date:   Thu, 12 May 2022 08:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 04/23] dt-bindings: ata: sata: Extend number of SATA
 ports
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-5-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-5-Sergey.Semin@baikalelectronics.ru>
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
> The denoted in the description upper limit only concerns the Port
> Multipliers, but not the actual SATA ports. It's an external device
> attached to a SATA port in order to access more than one SATA-drive. So
> when it's attached to a SATA port it just extends the port capability
> while the number of actual SATA ports stays the same. For instance on AHCI
> controllers the number of actual ports is determined by the CAP.NP field
> and the PI (Ports Implemented) register. AFAICS in general the maximum
> number of SATA ports depends on the particular controller implementation.
> Generic AHCI controller can't have more than 32 ports (since CAP.NP is of
> 5 bits wide and PI register is 32-bits size), while DWC AHCI SATA
> controller can't be configured with more than 8 ports activated. So let's
> discard the SATA ports reg-property restrictions and just make sure that
> it consists of a single reg-item.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Add comma and replace "channel" with "SATA port" in the reg property
>    description (@Damien).
> ---
>   Documentation/devicetree/bindings/ata/sata-common.yaml | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
> index 7ac77b1c5850..9c9c621761ca 100644
> --- a/Documentation/devicetree/bindings/ata/sata-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
> @@ -41,11 +41,10 @@ patternProperties:
>       properties:
>         reg:
>           minimum: 0
> -        maximum: 14
>           description:
> -          The ID number of the drive port SATA can potentially use a port
> -          multiplier making it possible to connect up to 15 disks to a single
> -          SATA port.
> +          The ID number of the SATA port. Aside with being directly used,
> +          each port can have a Port Multiplier attached thus allowing to
> +          access more than one drive by means of a single SATA port.
>   
>   additionalProperties: true
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
