Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E504A2CA9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 08:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbiA2HyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 02:54:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343747AbiA2HyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 02:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643442855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+99wX3UyzhorNUDurNKwAZVXIRbI4+49JLU9KY77P08=;
        b=AEhyaP+76IZPcg12U8AtaQ7TKfVhB36Ps0XbGEI+ATHu23pjZ5uRK3xsQ7C2NWOCNieCoN
        w7/6U7UWlMUvePKtUp1wyo15B2sOrWSbKPLfXg7Fyces7qObZgs8V9dENYwaJzDDZHQt9W
        R6CN31oC6IRuqqa2kT0sOsh9LISVsTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-93QRKsMtMlON074S51FL1g-1; Sat, 29 Jan 2022 02:54:11 -0500
X-MC-Unique: 93QRKsMtMlON074S51FL1g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8953C8144E0;
        Sat, 29 Jan 2022 07:54:10 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E13B055F54;
        Sat, 29 Jan 2022 07:53:59 +0000 (UTC)
Date:   Sat, 29 Jan 2022 15:53:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Yang Li <yang.lee@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] proc/vmcore: Fix vmcore_alloc_buf() kernel-doc
 comment
Message-ID: <20220129075357.GB17613@MiWiFi-R3L-srv>
References: <20220129011449.105278-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129011449.105278-1-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29/22 at 09:14am, Yang Li wrote:
> Fix a spelling problem to remove warnings found
> by running scripts/kernel-doc, which is caused by
> using 'make W=1'.
> 
> fs/proc/vmcore.c:492: warning: Function parameter or member 'size' not
> described in 'vmcore_alloc_buf'
> fs/proc/vmcore.c:492: warning: Excess function parameter 'sizez'
> description in 'vmcore_alloc_buf'

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/proc/vmcore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index edeb01dfe05d..6f1b8ddc6f7a 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -480,7 +480,7 @@ static const struct vm_operations_struct vmcore_mmap_ops = {
>  
>  /**
>   * vmcore_alloc_buf - allocate buffer in vmalloc memory
> - * @sizez: size of buffer
> + * @size: size of buffer
>   *
>   * If CONFIG_MMU is defined, use vmalloc_user() to allow users to mmap
>   * the buffer to user-space by means of remap_vmalloc_range().
> -- 
> 2.20.1.7.g153144c
> 

