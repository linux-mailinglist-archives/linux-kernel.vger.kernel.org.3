Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C857453A67E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbiFANyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353562AbiFANxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:53:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21614090D;
        Wed,  1 Jun 2022 06:53:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso3078265wmh.3;
        Wed, 01 Jun 2022 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Gkqx8uNGHQMl7//wICbhrmo/07INDVRlCWrBKZDsclM=;
        b=Ve12/IxpNSBPttcoaHlRlZrHm92pIFyNWIzGp4j9wwkTa8iHtIBw8dcwytxiJU8E9B
         cFQ8hZrytmwx2s4f2UuEwjOO9UIJ6Dm1r3s9CpXENWPhIN6j5t/DO8piLQudyplqOCei
         SqfMGdd7Kv1zkZBObq7ReXs/cDEdX3dmrr4qSk/Hat5dBCjKpV+0gQ48ir6mweiNWHZP
         Lpp/B+T5YF9t93Pw1FEd0hUK8VsfRdwGHO8yXJIhiHP+KLwzpcdvaHNY8Qjt4hWjaGhc
         lRY3O9gyGScMsaYLgihxPTpmmW1O3KnfbzzvT3tOGJChyuY4aVaclh9t6SI3BjcCyOgI
         gmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gkqx8uNGHQMl7//wICbhrmo/07INDVRlCWrBKZDsclM=;
        b=ew1rDMT25/gQzAaL6JYwB4EUiglBMhO9x/WbNze2vGau/rzMmo1F30Ef6+t9E+CAsx
         ZDoHCDJhvXK/jvSzvKXA4I5hy+G+g+LHpK/JUw/+HR8030lC3Pmr6dTG3O02K5FHhAjr
         1h8xBWBJL31W7QneOpIn9gsphFd945W5cRPs1T0CDMpvYjsLnQTwsdtg8/RnPpAZ1Rw9
         82diH4e7+sdFpkcLKD0+7eIVtABoM0TxDU5s/bP/v1pHeaKqkSyDeb3ELlPU2M+MlmhC
         OLDgs/uoR/PlZTosjdnLxqOMB+a6OwBnngZOss4ifqkWNoijqCvQikbQznXeeY3n3gzg
         iN7w==
X-Gm-Message-State: AOAM531K7FZXyj/BPYixnQdPDCCVdLW4yFkEa34+W7qgl8757lyDR/ts
        QWRqoTUkKjK9dfMxDcYcEl144qxaF3I=
X-Google-Smtp-Source: ABdhPJwbZYR808yKUqN3/m85GcP2QTKQJSBiDQBR3SnLiJ67wdJ3ufk1zAMFeaXfFzxf1FgkOaYUlA==
X-Received: by 2002:a05:600c:414e:b0:397:55aa:ccc0 with SMTP id h14-20020a05600c414e00b0039755aaccc0mr29543460wmm.51.1654091576305;
        Wed, 01 Jun 2022 06:52:56 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:d1fb:e1e4:e193:e55f? ([2a02:908:1256:79a0:d1fb:e1e4:e193:e55f])
        by smtp.gmail.com with ESMTPSA id c16-20020a7bc850000000b003942a244f48sm5240824wml.33.2022.06.01.06.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 06:52:55 -0700 (PDT)
Message-ID: <ab42ca92-70e3-ec82-c52c-0fc41d5b4a53@gmail.com>
Date:   Wed, 1 Jun 2022 15:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Linaro-mm-sig] Re: [PATCH] dma-fence: allow dma fence to have
 their own lock
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20220530142232.2871634-1-senozhatsky@chromium.org>
 <7eee4274-bd69-df8d-9067-771366217804@amd.com> <YpWCvniLzJfcp684@google.com>
 <33aba213-b6ad-4a15-9272-c62f5dfb1fb7@gmail.com>
 <YpdoEzLmlBfJks3q@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YpdoEzLmlBfJks3q@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.06.22 um 15:22 schrieb Daniel Vetter:
> On Wed, Jun 01, 2022 at 02:45:42PM +0200, Christian König wrote:
>> Am 31.05.22 um 04:51 schrieb Sergey Senozhatsky:
>>> On (22/05/30 16:55), Christian König wrote:
>>>> Am 30.05.22 um 16:22 schrieb Sergey Senozhatsky:
>>>>> [SNIP]
>>>>> So the `lock` should have at least same lifespan as the DMA fence
>>>>> that borrows it, which is impossible to guarantee in our case.
>>>> Nope, that's not correct. The lock should have at least same lifespan as the
>>>> context of the DMA fence.
>>> How does one know when it's safe to release the context? DMA fence
>>> objects are still transparently refcount-ed and "live their own lives",
>>> how does one synchronize lifespans?
>> Well, you don't.
>>
>> If you have a dynamic context structure you need to reference count that as
>> well. In other words every time you create a fence in your context you need
>> to increment the reference count and every time a fence is release you
>> decrement it.
>>
>> If you have a static context structure like most drivers have then you must
>> make sure that all fences at least signal before you unload your driver. We
>> still somewhat have a race when you try to unload a driver and the fence_ops
>> structure suddenly disappear, but we currently live with that.
>>
>> Apart from that you are right, fences can live forever and we need to deal
>> with that.
> Yeah this entire thing is a bit an "oops we might have screwed up" moment.
> I think the cleanest way is to essentially do what the drm/sched codes
> does, which is split the gpu job into the public dma_fence (which can live
> forever) and the internal job fence (which has to deal with all the
> resource refcounting issues). And then make sure that only ever the public
> fence escapes to places where the fence can live forever (dma_resv,
> drm_syncobj, sync_file as our uapi container objects are the prominent
> cases really).
>
> It sucks a bit.

It's actually not that bad.

See after signaling the dma_fence_ops is mostly used for debugging I 
think, e.g. timeline name etc...

Christian.

> -Daniel

