Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B1D53A561
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353030AbiFAMpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243984AbiFAMpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:45:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F325003E;
        Wed,  1 Jun 2022 05:45:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gi33so3536424ejc.3;
        Wed, 01 Jun 2022 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3gXXAFCIgEtF+YzTyCewnTjN33A3GV3iuvrjUd27wQQ=;
        b=gta6eDw43Uu7sglXZL/Vx2eKNZv/oPKGubWeykfGXP6+d5MRPMny64oKmMnBVj1ov2
         WBL+iirMwlra8edJZnYxIOoIQ+8fT9uqyc0vdTXiddtI5+dqrGKxPTEgZzRaq7luDAgW
         Xbes5Fr0LjMEQOnXST9oMj7xnFY4gwNGyBwYzLwh3XRe3rysTNoaTaIJkSEtAtcG52IY
         j7zMyk3iHiwwhxX7XXJeotHqR/xNBwJwhjlLqqwdHbJMW0Q6Ah3hCeYIQXfzX5inb5tu
         NWNJLs72EwPyi5ZAzHA+k5531RYCDHMCs7XtmvxEfrpgZgFOXJFeJv1Uj0wa5qdZEjAh
         wRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3gXXAFCIgEtF+YzTyCewnTjN33A3GV3iuvrjUd27wQQ=;
        b=0RXi64uLfvqRkQWhz7APJFHjXjJE+8mKXx2JaHIJKMQdW6EDTgOdFSY5blIOxyOzWa
         V6Kd+gjmSC9doVTDCUPDyjJq2IyY7gCjhsHuqxEHGgTJOdXPd6+MyM7NJIxFLkbQDScl
         ZEWwRbz8wDvxIl+0Tf2nv2xPWq0z2sdYXe2QJxiqty6b+dUJAZwpoqHFaBLUQF319eOA
         jHSvvZU0SZMKXp7h+GPHswCTPQpBlOnY1juafRIOxcCC0QNgRc2+mmzTZ59nxGPvBHgZ
         1Z9YC8UB0E34XGOh3kYkxhcLUi9dmKdmqtLpU6fLcv5XPwhvFcVGnP2sm2Iwq8HMvoXR
         1uGA==
X-Gm-Message-State: AOAM532Uysx7UVi0MijWuveKCSVzfBg6Er85/aAaNPCf1+Qp+Tq1j0D1
        Jz390vsi/dFxR8BaBUpOR2I=
X-Google-Smtp-Source: ABdhPJw2hNXssU1Die826uY3QfwCGMNWy9eIR9jcXgxN1q7weKBiW4r00uIvzYLOojrC71wHndfrzQ==
X-Received: by 2002:a17:906:2416:b0:6fe:a0be:91d5 with SMTP id z22-20020a170906241600b006fea0be91d5mr54759460eja.132.1654087544558;
        Wed, 01 Jun 2022 05:45:44 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id gk2-20020a17090790c200b006febce7081esm677798ejb.177.2022.06.01.05.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 05:45:43 -0700 (PDT)
Message-ID: <33aba213-b6ad-4a15-9272-c62f5dfb1fb7@gmail.com>
Date:   Wed, 1 Jun 2022 14:45:42 +0200
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
 <7eee4274-bd69-df8d-9067-771366217804@amd.com> <YpWCvniLzJfcp684@google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YpWCvniLzJfcp684@google.com>
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

Am 31.05.22 um 04:51 schrieb Sergey Senozhatsky:
> On (22/05/30 16:55), Christian König wrote:
>> Am 30.05.22 um 16:22 schrieb Sergey Senozhatsky:
>>> [SNIP]
>>> So the `lock` should have at least same lifespan as the DMA fence
>>> that borrows it, which is impossible to guarantee in our case.
>> Nope, that's not correct. The lock should have at least same lifespan as the
>> context of the DMA fence.
> How does one know when it's safe to release the context? DMA fence
> objects are still transparently refcount-ed and "live their own lives",
> how does one synchronize lifespans?

Well, you don't.

If you have a dynamic context structure you need to reference count that 
as well. In other words every time you create a fence in your context 
you need to increment the reference count and every time a fence is 
release you decrement it.

If you have a static context structure like most drivers have then you 
must make sure that all fences at least signal before you unload your 
driver. We still somewhat have a race when you try to unload a driver 
and the fence_ops structure suddenly disappear, but we currently live 
with that.

Apart from that you are right, fences can live forever and we need to 
deal with that.

Regards,
Christian.

> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

