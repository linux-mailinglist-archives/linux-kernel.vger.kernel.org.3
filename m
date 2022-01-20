Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5961B494C70
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiATLCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:02:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57686 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiATLCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:02:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A89C1F766;
        Thu, 20 Jan 2022 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642676569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3BqDV1ig3o00bV+/31wlTcHkbP1cECkqVf9yFw8L1Q=;
        b=01SrN6rMZ1shkMT4kYWA9HnqBDMzl6gT93XmfiFF1n1HO3dqQqp8mNa6fp9MKHCSLH9vkF
        UgVRXuuNIBCvWIXM3WamVb9ywMHjkDdKazvvnpHEhhph+MjqxSn6VJPaRGHCpijdcWUFZF
        XPI5BGPgzjJDtAOR6zaoDbJ5sHNuRx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642676569;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3BqDV1ig3o00bV+/31wlTcHkbP1cECkqVf9yFw8L1Q=;
        b=QlcXv1R6f60jWk/EAYeSynTum2DIWp37sF0SfSTV7ST/H3UwA5k6aepXluNoR9Cv7i3lKk
        vfcQc75N5T2YqfCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72B2B13E46;
        Thu, 20 Jan 2022 11:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pfYIG1lB6WH8NwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 20 Jan 2022 11:02:49 +0000
Subject: Re: [PATCH 1/2] block: remove commented out code from diskstats_show
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-2-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <83b281e5-16c2-d659-172d-3a2c911c7ff0@suse.de>
Date:   Thu, 20 Jan 2022 12:02:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220120105248.117025-2-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 11:52 AM, Daniel Wagner wrote:
> The diskstats format is ABI, so we just can't add a new header. The
> code snippet has been commented out since at least v2.6.12-rc2.
> Remove it.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  block/genhd.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 626c8406f21a..c9d4386dd177 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1162,14 +1162,6 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>  	struct disk_stats stat;
>  	unsigned long idx;
>  
> -	/*
> -	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
> -		seq_puts(seqf,	"major minor name"
> -				"     rio rmerge rsect ruse wio wmerge "
> -				"wsect wuse running use aveq"
> -				"\n\n");
> -	*/
> -
>  	rcu_read_lock();
>  	xa_for_each(&gp->part_tbl, idx, hd) {
>  		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
