Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5AA5246A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350854AbiELHQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350752AbiELHQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:16:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FB122BCB;
        Thu, 12 May 2022 00:16:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 22ED921C96;
        Thu, 12 May 2022 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652339780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAOBiDseOchKBUVGbREzQWb5NJM+9H32dPAb3OH0tjw=;
        b=Sdc0t8UVyGSdnz90CuZRhzPXjeLCP5WOqm9TnPupxUWBBsgAH2waCu0uv7e5E40Fsj1TyM
        v6DBGEGJLsEYP6oLGkoXdIzgVCd670ViGtMortXbCrCus3ZczWnnGxaydAPkYM5SMlulvn
        NVSZqk61rgUM9i3zBga0WIQWT7g1VXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652339780;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAOBiDseOchKBUVGbREzQWb5NJM+9H32dPAb3OH0tjw=;
        b=BEUi1DQB9/71/j/nxeM7w0jg8frWx9FZP9h4USk9A4uOEjSPCsm5HEITpSeUxlFgbaX52g
        LotUHWrULLpRHQDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E864213A97;
        Thu, 12 May 2022 07:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HyZ1OEO0fGL/YQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 07:16:19 +0000
Message-ID: <5b2b3f12-ba1f-45b5-cb05-6f5376e4e2c6@suse.de>
Date:   Thu, 12 May 2022 09:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 23/23] MAINTAINERS: Add maintainers for DWC AHCI SATA
 driver
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-24-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-24-Sergey.Semin@baikalelectronics.ru>
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
> Add myself as a maintainer of the new DWC AHCI SATA driver and
> its DT-bindings schema.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Use dlemoal/libata.git git tree for the LIBATA SATA AHCI SYNOPSYS
>    DWC driver (@Damien).
> ---
>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40fa1955ca3f..04f470519708 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11135,6 +11135,15 @@ F:	drivers/ata/ahci_platform.c
>   F:	drivers/ata/libahci_platform.c
>   F:	include/linux/ahci_platform.h
>   
> +LIBATA SATA AHCI SYNOPSYS DWC CONTROLLER DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-ide@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
> +F:	Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> +F:	Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> +F:	drivers/ata/ahci_dwc.c
> +
>   LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
>   M:	Mikael Pettersson <mikpelinux@gmail.com>
>   L:	linux-ide@vger.kernel.org
Tsk.

One would have thought that you'd be using the same email address for 
sending patches, and not specifying a different one for the maintainers 
file. There is this thing about proof of authenticity and all that ...

I'm not really comfortable with this. Please use the same email address 
for both the Maintainers file and for sending patches.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
