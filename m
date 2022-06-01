Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD553A62B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353340AbiFANua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347009AbiFANu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:50:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4796EC68;
        Wed,  1 Jun 2022 06:50:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso3071234wma.4;
        Wed, 01 Jun 2022 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8js3BmhqDmlsACbALLq5e90PLEF4lborosfHSvoWOKM=;
        b=YTm8+7dPHONlBsZR4SMEitCaBrfkbRXNUYC3ZuJKHQrTTGF4FMpWDkHvPvAUKxe/7W
         vdWoMgFNonHPdtNFLs8dJ0eKIrl3TVQfXZJ1W0tL8u1KraHZ3D4SYSONkggVAD+CYTXc
         vmgHav8NPKJ04dRy1E1KYZ6JMM3uN6Mbr1xauaHZ7Yu5PzCs6IOS9W3k8KXkoAtGZ+Kj
         3WTmHnwAlXIAlgL8PwWAtd6lN4A7aT+ryvS5oVzEY7RSSG+IjEpqmsMSZk4Zg8mHPLnn
         iayVlAoBzt92WTZsmg6sguCvUgZ2C7pPg2hJF3Jn/ExC9EtV0aaEwYCXejT3Wp+8zJqK
         u0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8js3BmhqDmlsACbALLq5e90PLEF4lborosfHSvoWOKM=;
        b=elYrwZtsBAYxu9scsnYvzWSwodOPXNRNFSW0S8/fVXt2QSx7+i7+NrA0cWRrfacdts
         VBzsEvFbj4BG28krlEpmCzhIyQ78iuiMT6zwO4TinNGn5xMtXtXKrWuptuh6Hf+Or3nt
         /sYJsgVGHCdWDTejpQ2ZIi89FosyzwOg95LfPUlOsXJH1StxHNJ2SkpWcRnBrPla0N0n
         aBMd/fWLmLWxaHI7Oa0s8HN1PSlKqj+TFx5qs+7asBeSwGA5vwChy+eXSjkPwJzX832n
         j2bL5KSDYdUIVZLBk03n6YCJ1BtvyV28Ed4uulmDNDTBWKr82lzH9CJolZJ4/R7MsWpX
         L5tw==
X-Gm-Message-State: AOAM532X1mS4Sfm12kjPClP/SXUzqlYV4JlFL/K3fi7F257WCQj2cKjW
        GMlxvyvDkoPXNscL6EGcymY=
X-Google-Smtp-Source: ABdhPJwrKHJfq73KfKlhy8VE3p9Xdk0H07fsnJbZrGsy5keEhwCnMaJoppLUFggoAw0VxEGq5FlEhQ==
X-Received: by 2002:a7b:c1d9:0:b0:397:335d:4d9f with SMTP id a25-20020a7bc1d9000000b00397335d4d9fmr29006967wmj.55.1654091425051;
        Wed, 01 Jun 2022 06:50:25 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:d1fb:e1e4:e193:e55f? ([2a02:908:1256:79a0:d1fb:e1e4:e193:e55f])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d400d000000b0020ff7246934sm1664650wrp.95.2022.06.01.06.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 06:50:24 -0700 (PDT)
Message-ID: <87724f19-7976-3a2c-96bc-8652a1cec9e8@gmail.com>
Date:   Wed, 1 Jun 2022 15:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Linaro-mm-sig] Re: [PATCH] dma-fence: allow dma fence to have
 their own lock
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20220530142232.2871634-1-senozhatsky@chromium.org>
 <7eee4274-bd69-df8d-9067-771366217804@amd.com> <YpTmhixkV7+yh6wo@google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YpTmhixkV7+yh6wo@google.com>
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



Am 30.05.22 um 17:45 schrieb Sergey Senozhatsky:
> On (22/05/30 16:55), Christian König wrote:
>> If you just want to create a single dma_fence which is also only bound to a
>> single context you can embed the lock into the fence without much problem.
>>
>> See how the dma_fence_array does that for example: https://elixir.bootlin.com/linux/latest/source/include/linux/dma-fence-array.h#L37
> Christian, I'm not sure I'm following you on the "embed the lock into the
> fence without much problem" part. If I understand it correctly this should
> be something like:
>
> 	fences = kmalloc_array(1, sizeof(*fences), GFP_KERNEL);
> 	for_each_fence(...) {
>
> 		// what spinlock should I use here?
>
> 		dma_fence_init(&fences[i], .. &lock ..);
> 		dma_fence_get(&fences[i]);
> 	}
> 	fence_array = dma_fence_array_create(1, fences, ....);
> 	sync_file_create(&fence_array->base);

Well no, that's the high level usage of the dma_fence_array.

What I meant was this here:

struct dma_fence_array {
     struct dma_fence base;

     spinlock_t lock;
...
};

Regards,
Christian.

> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

