Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F4F53A94B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354854AbiFAOi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiFAOi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:38:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100B31233;
        Wed,  1 Jun 2022 07:38:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f7-20020a1c3807000000b0039c1a10507fso1215854wma.1;
        Wed, 01 Jun 2022 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nEz+76T79tFW0RCrZGZI21N3hxWVslYlXYg2VKXX6II=;
        b=MaD8PwmnHt8a09T+peqTHwVOA9ZMJagO1K5G+SyV6SZNU5n+F08WpEiHeJK3218K7q
         TpMa2jHtVr6XzwZz/ZwmfQLeBpaol/DjLjdCgPEuGdts3zI+eeo5NBCLcFvgL1ZP7RD6
         ioO/06Cr9tKOOMtD7GD9rb96R+083ZmEC0FgFh49pdInij8WyfudEHMhbbnzxvPO0cnl
         NAsd2tz/9kZ9GjmlRo3jIZcOE2UrxK0mZt2K0ezbG16koclnfi0uXizmzNTmgP1BeCrB
         gD3TN7uQWiJjBDB+QcU6rgIeiE87c2Uf8tumpI6vGFZpEp5j6HBVnKe/wAZaAMVzCe3d
         oc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nEz+76T79tFW0RCrZGZI21N3hxWVslYlXYg2VKXX6II=;
        b=eTF03sv0XModlC2rUL8sAzXAjCnLIndCsmoIO8Lx9KgUE/RhbdrFkj0RXOhQmlRAIP
         Uo72rqefn2pa7Qw3pq2MGcOwDikxWa7I1GSbK2TxPGbmS8ThtSkQz5l2audYPuP43xIN
         gBb1HySLSxbZ24sbX0FE0Ngvxz634WekORjbsJ3wFTriHvtrjnEfd2Rj/izt7+m+//or
         WJdosRErNnC1Go++rKrwjFQMOYT5lyXu0QoH9d8lXYujewjDPwulZyIC0Ax/L2dc2ryY
         SRvQCucaDpGd8ScOvD486kzj/VOorbUSYjnVUh50kt2x8nHxPs2r4IgxrRhcWpm997mZ
         nzww==
X-Gm-Message-State: AOAM532VBVmRTBSIZsBT5PG+7vfjs8TT50cxNs5oqh9gHug86eY/Ywlr
        HrJsMVcmdsKQPaMHo+EeKek=
X-Google-Smtp-Source: ABdhPJxFJm/fvrtPm0Q76kR0LnUENBqB8SBsBwD/wEAz7gTa4nHm3tJgWR7y3ldaWLBOVk3IV9s8LQ==
X-Received: by 2002:a7b:cb91:0:b0:397:3225:244 with SMTP id m17-20020a7bcb91000000b0039732250244mr28954441wmi.68.1654094333691;
        Wed, 01 Jun 2022 07:38:53 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:d1fb:e1e4:e193:e55f? ([2a02:908:1256:79a0:d1fb:e1e4:e193:e55f])
        by smtp.gmail.com with ESMTPSA id u12-20020adfdb8c000000b002119c1a03e4sm503684wri.31.2022.06.01.07.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 07:38:52 -0700 (PDT)
Message-ID: <a009c207-a5fa-af1e-b961-8083b48360bf@gmail.com>
Date:   Wed, 1 Jun 2022 16:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Linaro-mm-sig] Re: [PATCH] dma-fence: allow dma fence to have
 their own lock
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <Ypd3Us3a93aLonqT@google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <Ypd3Us3a93aLonqT@google.com>
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

Am 01.06.22 um 16:27 schrieb Sergey Senozhatsky:
> On (22/06/01 14:45), Christian König wrote:
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
> OK then fence release should be able to point back to its "context"
> structure. Either a "private" data in dma fence or we need to "embed"
> fence into another object (refcounted) that owns the lock and provide
> dma fence ops->release callback, which can container_of() to the object
> that dma fence is embedded into.
>
> I think you are suggesting the latter. Thanks for clarifications.

Daniel might hurt me for this, but if you really only need a pointer to 
your context then we could say that using a pointer value for the 
context field is ok as well.

That should be fine as well as long as you can guarantee that it will be 
unique during the lifetime of all it's fences.

We would just have to adjust the documentation a bit.

> The limiting factor of this approach is that now our ops->release() is
> under the same "pressure" as dma_fence_put()->dma_fence_release() are.
> dma_fence_put() and dma_fence_release() can be called from any context,
> as far as I understand, e.g. IRQ, however our normal object ->release
> can schedule, we do things like synchronize_rcu() and so on. Nothing is
> impossible, just saying that even this approach is not 100% perfect and
> may need additional workarounds.

Well just use a work item for release.

Regards,
Christian.

>> If you have a static context structure like most drivers have then you must
>> make sure that all fences at least signal before you unload your driver. We
>> still somewhat have a race when you try to unload a driver and the fence_ops
>> structure suddenly disappear, but we currently live with that.
> Hmm, indeed... I didn't consider fence_ops case.
>
>> Apart from that you are right, fences can live forever and we need to deal
>> with that.
> OK. I see.

