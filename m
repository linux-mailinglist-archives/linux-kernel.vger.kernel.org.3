Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A1251D513
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390758AbiEFKDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbiEFKDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:03:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B3B56FBC
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 02:59:27 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a11so5859091pff.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qkYBPtwwXh8wrjml5xjZWpmnyYJc8bz2oezaS0TP4h4=;
        b=yhN7HQkibzNKkcborAKfIJZ1+KFI5v7ka0JP/YFaO15M7iM5JCX3y28qvb6yrz1Qm+
         tsZzBSDZERZUoFnpycq2P8Gv8LylAFM5wybHMOsa26wbefo5t8aY5EF7nPp4hBwBGoKJ
         WeaxwleR2hasu1mCnXJ1eHbEprtWOiowLkefXtZGcDB8f+Yb6LwivSXUXWG85ve/qV9d
         RnGIzxJq40E9JIQsAjAIucr3YNMxnBfLL23bvh5Gr6zC5dU/CMeP49CeUEiTNfFktIZN
         xUve1G3ty7FkdL2P7bww2ONlixR4c/z1MErH2hnRyOVQicRhg5a00l+OEfpFrGLzkyeK
         T43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qkYBPtwwXh8wrjml5xjZWpmnyYJc8bz2oezaS0TP4h4=;
        b=PDvwz9UJY2VB5xZ1zcxIgN0eZTZ95drLAvv6jHeTjW+S3t2jPqV/1cw1ZC80hBgERM
         LgGNfLXhYeGJllv24aEI8pvtpFaUk3Ra4mvqKZcBB8njXWqvmsQraU/pYjxirAYdsxDA
         +H5YHrJVm8oBkOPnxdE9NjiEIqGAxUlWli/i12STFuloUaHvjzNk5AXkCUgmxtuldcNS
         qzwjIo5/wLA8xseSbZg0x+Xo0SdYkZ5dVtBwwjOGMkMQ1ScGEbMml+cO+53nrzuyb4w8
         1xQp0jh3arkh91E2j0maIA+sucDMK4Kmvj7kANRr+OM1QhPEWDHGSpBOidHRuXaGHeYw
         wqYw==
X-Gm-Message-State: AOAM531/fPTUY0N/tDBNBdTkcSh439vwTrNK63gECVQXdjr8G8rQo8/E
        XKRluZ0wpQ7TPDW3u/bK9e9TmA==
X-Google-Smtp-Source: ABdhPJx1UzxZt5oKWOW8EfeuMSxPFYdmNFuHrO7gIAc3jSJG3YfatOtyNZDK/sM/J50XFzYZ7hQiig==
X-Received: by 2002:a65:615a:0:b0:3a9:f4ad:68a8 with SMTP id o26-20020a65615a000000b003a9f4ad68a8mr2168328pgv.108.1651831167259;
        Fri, 06 May 2022 02:59:27 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id me16-20020a17090b17d000b001d26c7d5aacsm3300603pjb.13.2022.05.06.02.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 02:59:26 -0700 (PDT)
Message-ID: <48c9b073-0b03-5769-633b-5b668cea6fa4@bytedance.com>
Date:   Fri, 6 May 2022 17:55:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: RE: [PATCH v5 5/5] virtio-crypto: enable retry for
 virtio-crypto-dev
Content-Language: en-US
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "mst@redhat.com" <mst@redhat.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <20220505092408.53692-1-pizhenwei@bytedance.com>
 <20220505092408.53692-6-pizhenwei@bytedance.com>
 <ad61b1ae4bd145eaa18fc28696e9502a@huawei.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <ad61b1ae4bd145eaa18fc28696e9502a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 17:34, Gonglei (Arei) wrote:
> 
> 
>> -----Original Message-----
>> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
>> Sent: Thursday, May 5, 2022 5:24 PM
>> To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com
>> Cc: jasowang@redhat.com; herbert@gondor.apana.org.au;
>> linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org;
>> linux-crypto@vger.kernel.org; helei.sig11@bytedance.com;
>> pizhenwei@bytedance.com; davem@davemloft.net
>> Subject: [PATCH v5 5/5] virtio-crypto: enable retry for virtio-crypto-dev
>>
>> From: lei he <helei.sig11@bytedance.com>
>>
>> Enable retry for virtio-crypto-dev, so that crypto-engine can process
>> cipher-requests parallelly.
>>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Gonglei <arei.gonglei@huawei.com>
>> Signed-off-by: lei he <helei.sig11@bytedance.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/crypto/virtio/virtio_crypto_core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c
>> b/drivers/crypto/virtio/virtio_crypto_core.c
>> index 60490ffa3df1..f67e0d4c1b0c 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_core.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
>> @@ -144,7 +144,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
>>   		spin_lock_init(&vi->data_vq[i].lock);
>>   		vi->data_vq[i].vq = vqs[i];
>>   		/* Initialize crypto engine */
>> -		vi->data_vq[i].engine = crypto_engine_alloc_init(dev, 1);
>> +		vi->data_vq[i].engine = crypto_engine_alloc_init_and_set(dev, true,
>> NULL, 1,
>> +						virtqueue_get_vring_size(vqs[i]));
> 
> Here the '1' can be 'true' too.
> 
> Sure, you can add
> 
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> 
> Regards,
> -Gonglei
> 
>>   		if (!vi->data_vq[i].engine) {
>>   			ret = -ENOMEM;
>>   			goto err_engine;
>> --
>> 2.20.1
> 

Thanks to Lei!

Hi, Michael
I would appreciate it if you could apply this minor change, or I send 
the v6 series, which one do you prefer?

-- 
zhenwei pi
