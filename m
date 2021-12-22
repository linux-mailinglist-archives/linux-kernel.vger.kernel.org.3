Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF847CE31
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhLVI1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhLVI1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiCJI2Ld40vcwNQ1UmTsVWp+vpo93LIjdzoVcEzuB/c=;
        b=Is28GX3q6zOv7YhzJDQAyNfUwb+FM/6AgvbUVXIncSj0o1g/8jCgf8nfgYSuKwlbQ6NUi/
        42UnmHGESXQGQwRtgOqsTLkAKMxJiP7ul7I/4QaGa35FNireVSJTvoYA5LpelrqkhhlK9F
        z8DK8mvuuIaBahaQz9Azb3Ed8/gZnfw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-vqukhtmvN-KBfstahjqDRA-1; Wed, 22 Dec 2021 03:27:34 -0500
X-MC-Unique: vqukhtmvN-KBfstahjqDRA-1
Received: by mail-wr1-f69.google.com with SMTP id p1-20020adfba81000000b001a25b07ff53so520445wrg.22
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=YiCJI2Ld40vcwNQ1UmTsVWp+vpo93LIjdzoVcEzuB/c=;
        b=Sa3meT+p5PGsazdwGU8oHCnpWuswv6P6IVaw+/f3mWOiVZ1sK+SJg7u2pF0L/aWweh
         X+RAG8MRomff1PydxxsN/br5PtYzU5YBx0csufE3B/oVQFzaWVxmOGK9hHejFEroF9qi
         CRqUsFHvETvXwZ04IchZGPqmyY9REcOhw81VbQyLjXKqiwPo0Sf9PvZT0AoDQGq7FBr1
         LZMZPQ+pObya7JpsJPz6Q2z5a3ucgbBjPIQAw1LjZQbnnQXaVYMoxhil9IN7BxfEXByj
         sKyjTRHl38+W4oOuT3xNmDMdzq+Z0dZWp/7Tmj4HoB6dgPhMeZLwFSNpg0a3UKo1XpkU
         03FA==
X-Gm-Message-State: AOAM533OhcHW8D37jwt32VHqT0ND3DtL09Ti0zeo7pWyCM5rYH8kux6q
        cZS9sf2sVilNwRf0tb6F7C9j7qTvGaHP39/hG9comgOq6//lCkYnCCQGDhXNTwvWZEf2sK0Lubl
        bp/WIdLhqIBv4o6BS3Al3qK3C
X-Received: by 2002:a7b:c457:: with SMTP id l23mr120646wmi.24.1640161653046;
        Wed, 22 Dec 2021 00:27:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWxMheKBopAqBgCXoAxuJXOZ6bUwWYRp22yAOCWcNz13FizqbU4zHNjtnz+PQeYZV6wpX7ng==
X-Received: by 2002:a7b:c457:: with SMTP id l23mr120634wmi.24.1640161652845;
        Wed, 22 Dec 2021 00:27:32 -0800 (PST)
Received: from [192.168.3.132] (p5b0c646a.dip0.t-ipconnect.de. [91.12.100.106])
        by smtp.gmail.com with ESMTPSA id u13sm5243476wmq.14.2021.12.22.00.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 00:27:32 -0800 (PST)
Message-ID: <94cb5c11-97b1-f157-ad8e-d916175e0690@redhat.com>
Date:   Wed, 22 Dec 2021 09:27:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Peng Hao <flyingpenghao@gmail.com>, mst@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211222011225.40573-1-flyingpeng@tencent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] virtio/virtio_mem: handle a possible NULL as a memcpy
 parameter
In-Reply-To: <20211222011225.40573-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.21 02:12, Peng Hao wrote:
> There is a check for vm->sbm.sb_states before, and it should check
> it here as well.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  drivers/virtio/virtio_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 96e5a8782769..b6b7c489c8b6 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -592,7 +592,7 @@ static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
>  		return -ENOMEM;
>  
>  	mutex_lock(&vm->hotplug_mutex);
> -	if (new_bitmap)
> +	if (vm->sbm.sb_states)
>  		memcpy(new_bitmap, vm->sbm.sb_states, old_pages * PAGE_SIZE);
>  
>  	old_bitmap = vm->sbm.sb_states;

Right, on the first iteration (vm->sbm.sb_states == NULL) we would copy
from NULL.

I wonder why this never failed so far. I guess that's because "the
behavior is undefined" if a NULL pointer is passed.

I assume the memcpy implementation that we've been using so far simply
skips the operation if they detect a NULL pointer, although according to
the standard the behavior is undefined:

"
AFAIK, most implementations allow null pointers for no-op calls to
memcpy() but gcc issues a warning when it detects at compile time
that a null pointer is passed as the first or second argument to
memcpy().
" [1]

Fixes: 5f1f79bbc9e2 ("virtio-mem: Paravirtualized memory hotplug")
Cc: stable@vger.kernel.org # v5.8+


Thanks!

[1]
https://mail-archives.apache.org/mod_mbox/stdcxx-dev/200804.mbox/%3CCFFDD219128FD94FB4F92B99F52D0A49010A36F4@exchmail01.Blue.Roguewave.Com%3E

-- 
Thanks,

David / dhildenb

