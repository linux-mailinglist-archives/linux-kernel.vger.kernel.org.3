Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1273484927
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiADUTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiADUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:18:59 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF9BC061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:18:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e5so78444308wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 12:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YqfimjW8kCsOGvR2KcD4RHQdQET20TI1ORmSBFI8sRI=;
        b=WDkFXYDph6APi2TpmYV6NVvr0fZ/tTd6JqHKrtaa4wc/trS5pJhe8kbolGjpUT6ykG
         j8sFJUO9Yz9duMqOO7bySuDXp67t3obD3aB+SGWYX9uHrP9mthyOt6bVHewnu7ZMC44X
         tTLwK8u8keXTHuNpACSB7d3eJ4GVIH/Kg7zCPK6GEtKy4516s+ejpdz8VjvfPRVYSP/3
         TqRkV10FROCbDFXAvbYBYisOywawYWOUgvuiawoB+Z/Lcu6yVLeWl+gTmEsGSgTuPklS
         Dpg1kPbglEXCVmrE4Lcltu0vrAFNW4MStnZwWUAtQKda9Shag3duJO4//29OZDeUVgZB
         iy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YqfimjW8kCsOGvR2KcD4RHQdQET20TI1ORmSBFI8sRI=;
        b=2wkynjH2wde2tPylvqGiC4z3f14fjuH7up/PpUMXCN3nQraU3n+nVLnmO49Gcdr171
         tT7ZanfsAmFw/kd/YiWMFbWWKRoP7YwFny3++vTzc6d1qygCETrOPEiAg4qk5NZ5US/W
         S2/qgJkWBPM8Sv52muB2lCJrvseahijpMDYw30RboY5ko2zdCyE3h0Qnqxp6AdSmJ5zr
         OIRjyCKuGII0bUXAqyRUA8aRJB7VelYWnkxcD0AzvOVZ5mjpRe5ToMTpi1RyWphQQFbB
         UOWn6nqyWbtY7cUHR4v+ywMES4/EPE44Lp51vIW6c0U3F6Vhn/44m5uSxx9CxSFDlYNe
         eVSQ==
X-Gm-Message-State: AOAM531qE+vEt99JmJHyvX5bs01aya4ePO5ZCCo0FHXt+eJBcNvHTf1L
        nKMo4TK/rQ7JRudLHdzEtBPWQ6lItFo4wpnU
X-Google-Smtp-Source: ABdhPJy6tdRfuf7vNvrCfa4kPR0PUvJ+rN7Ff5/CjrEw6jTzUch5sDRmqtRdda/moa/f0FdJEWxUzQ==
X-Received: by 2002:a05:6000:1188:: with SMTP id g8mr35565138wrx.134.1641327537601;
        Tue, 04 Jan 2022 12:18:57 -0800 (PST)
Received: from ?IPV6:2003:d9:9708:b800:49a3:330d:2aba:c4a2? (p200300d99708b80049a3330d2abac4a2.dip0.t-ipconnect.de. [2003:d9:9708:b800:49a3:330d:2aba:c4a2])
        by smtp.googlemail.com with ESMTPSA id c11sm492175wmq.48.2022.01.04.12.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 12:18:57 -0800 (PST)
Message-ID: <5818b7e5-5d21-9f80-3571-f0d34b4f5c23@colorfullife.com>
Date:   Tue, 4 Jan 2022 21:18:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] ipc/sem: do not sleep with a spin lock held
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>, cgel.zte@gmail.com
Cc:     stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, chi.minghao@zte.com.cn,
        Davidlohr Bueso <dbueso@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, unixbhaskar@gmail.com,
        Vasily Averin <vvs@virtuozzo.com>, zealci@zte.com.cn
References: <63840bf3-2199-3240-bdfa-abb55518b5f9@colorfullife.com>
 <20211223031207.556189-1-chi.minghao@zte.com.cn>
 <CALvZod7pTO6D5Lx62-eVWORSj4Q=Px2iu=qUgqA_9AZwQOKsUg@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <CALvZod7pTO6D5Lx62-eVWORSj4Q=Px2iu=qUgqA_9AZwQOKsUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 19:20, Shakeel Butt wrote:
> On Wed, Dec 22, 2021 at 7:12 PM <cgel.zte@gmail.com> wrote:
>> From: Minghao Chi <chi.minghao@zte.com.cn>
>>
>> We can't call kvfree() with a spin lock held, so defer it.
>> Fixes: fc37a3b8b438 ("[PATCH] ipc sem: use kvmalloc for sem_undo
>> allocation")
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Manfred Spraul <manfred@colorfullife.com>

--

     Manfred

