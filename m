Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74190481C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbhL3NfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:35:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45880 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhL3NfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:35:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4A3B921114;
        Thu, 30 Dec 2021 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640871308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNJvjKHb4Y8WpSKSBpjur0q65UAXxFw+5COgWD3TSkQ=;
        b=ySTCD4dzHT45RWhvm7QKBRXvojUln4DCqNdWMBXkEJoaegCuRFsAR1OzSprt57oEJVjE0u
        KO/aG0o5Vk5yQ3Wr7Od4TWiGvaispaTGb1LDa5VorvGCPfNWDdgTLq/B6MX3T/2knHsgB1
        VXuuVECwYuEPBxFi/TNduP7ZF7IfwPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640871308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNJvjKHb4Y8WpSKSBpjur0q65UAXxFw+5COgWD3TSkQ=;
        b=AmFlXTRzy0H4/OaxTx2mk/5o34KXQR4/K1ufxQ1NQqL0YZ7N4xXpSnG7RiWOafbZyYmlwK
        88yGNI746BKVjjBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D791713BC5;
        Thu, 30 Dec 2021 13:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5kS7MIu1zWH5SAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 30 Dec 2021 13:35:07 +0000
Subject: Re: [PATCH v3 2/3] ahci: Use macro PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
 <20211229161119.1006-2-pmenzel@molgen.mpg.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <f16c35bc-43fe-5b06-e867-81a75ffaf675@suse.de>
Date:   Thu, 30 Dec 2021 14:35:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211229161119.1006-2-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/21 5:11 PM, Paul Menzel wrote:
> Use the defined macro from `include/linux/pci_ids.h`.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>   drivers/ata/ahci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 1e1167e725a4..6a2432e4adda 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -436,7 +436,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>   		.class_mask = 0xffffff,
>   		board_ahci_al },
>   	/* AMD */
> -	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE), board_ahci },
>   	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>   	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
>   	/* AMD is using RAID class only for ahci controllers */
> 
Weelll ... there are defines for AMD Hudson-2 and similar in the pci_ids 
file, yet these definitions are not used here.
I'd vote keeping the style for all entries, ie either convert all 
entries here to use #defines, or stay with the numeral.

But we shouldn't mix them.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
