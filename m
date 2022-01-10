Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99F3489888
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbiAJMYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:24:35 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:52584 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245392AbiAJMYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tV+aFHC5/3ebeEinWddoq0ybUZobbAPSWYP9SJGYPLw=; b=RgdlBsV4Px/x5GOovwle3JNiba
        sonLerR8GKItcz2A8EhjVqzMFZ1CUGJLXQyTNAOGwpOcdAlbs9TQU0HCR1Omddf3KfE7WEEDshWw3
        lCzec7Ak5pNXdokm07NMpDElDXLuetvgcKziaR9OKKQdcCF7deUK+b0gDvfjqYOsUL1Op+RGGoq+M
        pXPBNYOMZlPgLS+tjEhrJcGWG9qkXnuPKbBzccZ7VJtJNlQkKi/CfTlsSsncyJyOKZircAYBAeE2r
        r4UzslPYqD4DgXtCU19nK04HgnmiQhWZRv9ZB0nqmCpcYfwzvj8deymaM35WPuVJpIcWukk+2J9mf
        +ajc7Dzg==;
Received: from [179.113.53.20] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n6tir-0001N8-Hs; Mon, 10 Jan 2022 13:24:25 +0100
Message-ID: <d1769d1c-9f0d-5aa7-d5c6-d0f9d2b3dba8@igalia.com>
Date:   Mon, 10 Jan 2022 09:24:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] sysctl: documentation: fix table format warning
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20220109055635.6999-1-rdunlap@infradead.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220109055635.6999-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2022 02:56, Randy Dunlap wrote:
> Fix malformed table warning in sysctl documentation:
> (don't use ':'s)
> 
> Documentation/admin-guide/sysctl/kernel.rst:798: WARNING: Malformed table.
> Text in column margin in table line 7.
> 
> =====  ============================================
> bit 0  print all tasks info
> bit 1  print system memory info
> bit 2  print timer info
> bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
> bit 4  print ftrace buffer
> bit 5: print all printk messages in buffer
> bit 6: print all CPUs backtrace (if available in the arch)
> 
> Fixes: 934d51cad60c ("docs: sysctl/kernel: add missing bit to panic_print")
> Fixes: addc64999934 ("panic: add option to dump all CPUs backtraces in panic_print")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> ---
>  Documentation/admin-guide/sysctl/kernel.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20220107.orig/Documentation/admin-guide/sysctl/kernel.rst
> +++ linux-next-20220107/Documentation/admin-guide/sysctl/kernel.rst
> @@ -795,8 +795,8 @@ bit 1  print system memory info
>  bit 2  print timer info
>  bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
>  bit 4  print ftrace buffer
> -bit 5: print all printk messages in buffer
> -bit 6: print all CPUs backtrace (if available in the arch)
> +bit 5  print all printk messages in buffer
> +bit 6  print all CPUs backtrace (if available in the arch)
>  =====  ============================================
>  
>  So for example to print tasks and memory info on panic, user can::

Thanks a lot Randy and Stephen!

Reviewed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
