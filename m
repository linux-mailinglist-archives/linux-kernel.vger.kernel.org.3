Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2B3524682
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350723AbiELHI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350766AbiELHIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:08:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D3B517E5;
        Thu, 12 May 2022 00:08:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C6A721BB5;
        Thu, 12 May 2022 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652339289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUuA2pZ/f7UU2troMD6CEcY43Cqa5Ipx6IIjJqW0siM=;
        b=Q9moOVs/8kADcB6JkjtHMxX2aLgaxAmKEGaBxOfflN7JWLHyx+LKdRPRN0R5M6tXTYMIcS
        rTC9pF7CI5BLGSJM+0HDdahoxTI0SGZvTQWph53fRSVtlJKBnz3Jrda3t8AUZPg24j0tO0
        jWHcdGSUWyw8n2xjKjT/dyWjZFDXhF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652339289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUuA2pZ/f7UU2troMD6CEcY43Cqa5Ipx6IIjJqW0siM=;
        b=Nymkhp9ueqTVBIy8ofTEPqJyLT3nXbr9RA9KdKvd+RrEq7vEZxGN7JBypO/heMlEQ3SWPe
        Z9zRzzeu5rx776Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E82213A97;
        Thu, 12 May 2022 07:08:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cN3dElmyfGI+XgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 07:08:09 +0000
Message-ID: <f6ec7945-e507-c806-ec1b-d65bf8e8f8e7@suse.de>
Date:   Thu, 12 May 2022 09:08:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 18/23] dt-bindings: ata: ahci: Add DWC AHCI SATA
 controller DT schema
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-19-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-19-Sergey.Semin@baikalelectronics.ru>
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

On 5/12/22 01:18, Serge Semin wrote:
> Synopsys AHCI SATA controller is mainly compatible with the generic AHCI
> SATA controller except a few peculiarities and the platform environment
> requirements. In particular it can have one or two reference clocks to
> feed up its AXI/AHB interface and SATA PHYs domain and at least one reset
> control for the application clock domain. In addition to that the DMA
> interface of each port can be tuned up to work with the predefined maximum
> data chunk size. Note unlike generic AHCI controller DWC AHCI can't have
> more than 8 ports. All of that is reflected in the new DWC AHCI SATA
> device DT binding.
> 
> Note the DWC AHCI SATA controller DT-schema has been created in a way so
> to be reused for the vendor-specific DT-schemas (see for example the
> "snps,dwc-ahci" compatible string binding). One of which we are about to
> introduce.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Replace min/max constraints of the snps,{tx,rx}-ts-max property with
>    enum [ 1, 2, 4, ..., 1024 ]. (@Rob)
> ---
>   .../bindings/ata/ahci-platform.yaml           |   8 --
>   .../bindings/ata/snps,dwc-ahci.yaml           | 123 ++++++++++++++++++
>   2 files changed, 123 insertions(+), 8 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
