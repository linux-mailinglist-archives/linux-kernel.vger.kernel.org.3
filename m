Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D66494D00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiATLa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:30:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32812 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiATLaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:30:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BB84E1F3A9;
        Thu, 20 Jan 2022 11:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642678215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMdsMQ3UDrdB0PRLNa+gMwzIPnRngx5xU9S2kt0+kEY=;
        b=K0oj/T6SaED8kiu1SBUfv4/4ofe8Yf8K+LUQA206chkyu6eMVprjU9w3+P3QhDYS3OEvvU
        9KnpG5cEE7bHjza8RaVyY+ZdTwpcWqF62/9mVRiUlgDEuaODV4awVEBltI8JA7MIY9Tc1j
        mZ5JOahQa7i+slgZtachrZzdl2ZPHkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642678215;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMdsMQ3UDrdB0PRLNa+gMwzIPnRngx5xU9S2kt0+kEY=;
        b=BzDJdcnmDnK6w3Ytgn+LSyczSS7d3QVDE88+AjfxDO8pLlvwZECAYnd5E6FHQo0cjQxIIQ
        wXSrUKKLYjSK8zBA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D4C00A3B87;
        Thu, 20 Jan 2022 11:30:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 66345A05D9; Thu, 20 Jan 2022 12:30:15 +0100 (CET)
Date:   Thu, 20 Jan 2022 12:30:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     trix@redhat.com
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: cleanup double word in comment
Message-ID: <20220120113015.clp4qx4h3hzg7dl6@quack3.lan>
References: <20220116125936.389767-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116125936.389767-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 16-01-22 04:59:36, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'handle'.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks. Applied to my tree.

								Honza

> ---
>  include/linux/quota.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/quota.h b/include/linux/quota.h
> index 18ebd39c94871..fd692b4a41d5f 100644
> --- a/include/linux/quota.h
> +++ b/include/linux/quota.h
> @@ -91,7 +91,7 @@ extern bool qid_valid(struct kqid qid);
>   *
>   *	When there is no mapping defined for the user-namespace, type,
>   *	qid tuple an invalid kqid is returned.  Callers are expected to
> - *	test for and handle handle invalid kqids being returned.
> + *	test for and handle invalid kqids being returned.
>   *	Invalid kqids may be tested for using qid_valid().
>   */
>  static inline struct kqid make_kqid(struct user_namespace *from,
> -- 
> 2.26.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
