Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F007858668D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiHAIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiHAIrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:47:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E98432D81
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:47:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DCEDA60FB9;
        Mon,  1 Aug 2022 08:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659343630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i3plC4gDCirp0/qEelmSAUkiw7vjt0l7z6WMBswDQpA=;
        b=kvjC6SkQ2jq0/pIqyrMLbUusGyMzDJgTpRqcOZB+GQy53XYapOoF+xKlAXR4Cyre0whHO2
        oSKg3XevIukFCA/b4rkpJf9TIrsNdY5/MYcIMnyXCFW5abcsX72PGY8p+f9yCohFEDD15M
        idBdYfxPiuLIiCsrGQZWAWRAVXkS5/4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6ED113A72;
        Mon,  1 Aug 2022 08:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nPMLKg6T52IMMwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 01 Aug 2022 08:47:10 +0000
Date:   Mon, 1 Aug 2022 10:47:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_ext: remove unused variable in offline_page_ext
Message-ID: <YueTDphOhJgvB58e@dhcp22.suse.cz>
References: <1659330397-11817-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659330397-11817-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-08-22 10:36:37, Charan Teja Kalla wrote:
> Remove unused variable 'nid' in offline_page_ext(). This is not used
> since the page_ext code inception.
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks

> ---
>  mm/page_ext.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 3dc715d..e22a928 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -336,7 +336,7 @@ static int __meminit online_page_ext(unsigned long start_pfn,
>  }
>  
>  static int __meminit offline_page_ext(unsigned long start_pfn,
> -				unsigned long nr_pages, int nid)
> +				unsigned long nr_pages)
>  {
>  	unsigned long start, end, pfn;
>  
> @@ -362,11 +362,11 @@ static int __meminit page_ext_callback(struct notifier_block *self,
>  		break;
>  	case MEM_OFFLINE:
>  		offline_page_ext(mn->start_pfn,
> -				mn->nr_pages, mn->status_change_nid);
> +				mn->nr_pages);
>  		break;
>  	case MEM_CANCEL_ONLINE:
>  		offline_page_ext(mn->start_pfn,
> -				mn->nr_pages, mn->status_change_nid);
> +				mn->nr_pages);
>  		break;
>  	case MEM_GOING_OFFLINE:
>  		break;
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
