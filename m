Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0114BB020
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiBRDQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:16:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiBRDP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:15:58 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE72F1BBF61
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:15:42 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y11so1281078pfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cvti9DbyWYs8dMjlWXIsVfLl8mOEd5qxZxKU5ZS8qhM=;
        b=EnqUrDW/nfup+NhWajLnkDWhSOvmFoQK+dIo4ycSZlbsaVZJQ3toa0sV/8PDtLpVtc
         Ua0hdYljmfKvlJdq+WpMj2cGgilXh8rXHSlRESdUebGxMXfw/A205qgyBOIEVWv+4brN
         NG9GiLi0ZFqeHR/zxleMZYNtBDRe15bxJfg3g6yujkyJ6YLRflwF2dEv+AXmhyQvEDPx
         iaqI9kaMr1J66C769SPr6XBkLO0cER66YfEcxLJ/YbkQLScKp1HiLAfpbDFm2hc6/00x
         Iij4aCq5PBkd0bXF/fU869XzGKcQR0BoA78b38hn4VifEuBUufctF3qushtC1R+qGyZk
         9N+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cvti9DbyWYs8dMjlWXIsVfLl8mOEd5qxZxKU5ZS8qhM=;
        b=b+8gP2JEMImwyrVnpojMIUKHpC9yi9z4XilgQYiVB7J0PVAHIMr9TUavKPZ3mSFGq3
         vi6EM0mEwUPdBtJz1wQlHWUYAeU77Cf13Kuqq7gMhXqPVehjTc9hyNDfAPUujDG91HsN
         jvLCWzJHoGsYCQJhqdOM5pzt9BF94UlJewYkkbh0EoS1mfxvhfAxDYkyq1aARCEZWd5E
         HKLOcV8QTLfKKWJlRsnzplWgyZu9ugJnu9ieO85W6sEc9pigtHj7dvzj5srO33P9CTNo
         EylMVps/HxIDacRVpoOC0yY+IH9N2q8XHsRg6mAfl8lUczOHkiZJTh0iEHgbzYWiBdH/
         Q9Zg==
X-Gm-Message-State: AOAM5324CNrVKdAkC3tju67nOplse3UeYTcw+W4VmKbQfGMQI57CDp2O
        AtmtSTH8gjzcyXZzeDr5cyo84g==
X-Google-Smtp-Source: ABdhPJxR3+NulIemLCe52Otg1HdG7AnjP7K5Epp9CJhpKw23x3HRAJOPywscd3ggEHJRYfc4lVgE9Q==
X-Received: by 2002:a63:f90e:0:b0:373:da89:c0bd with SMTP id h14-20020a63f90e000000b00373da89c0bdmr462001pgi.135.1645154142317;
        Thu, 17 Feb 2022 19:15:42 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id m19sm929643pfk.215.2022.02.17.19.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 19:15:41 -0800 (PST)
Subject: Re: RE: [PATCH v2 3/3] virtio-crypto: implement RSA algorithm
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        kernel test robot <lkp@intel.com>
References: <20220211084108.1254218-1-pizhenwei@bytedance.com>
 <20220211084108.1254218-4-pizhenwei@bytedance.com>
 <c9144b0d82e34566a960f210ddc32696@huawei.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <8ef2f660-bd84-de70-1539-402c73795dfe@bytedance.com>
Date:   Fri, 18 Feb 2022 11:12:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c9144b0d82e34566a960f210ddc32696@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto
>> +*vcrypto) {
>> +	int i = 0;
>> +
>> +	mutex_lock(&algs_lock);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
>> +		uint32_t service = virtio_crypto_akcipher_algs[i].service;
>> +		uint32_t algonum = virtio_crypto_akcipher_algs[i].algonum;
>> +
>> +		if (virtio_crypto_akcipher_algs[i].active_devs == 0 ||
>> +		    !virtcrypto_algo_is_supported(vcrypto, service, algonum))
>> +			continue;
>> +
>> +		if (virtio_crypto_akcipher_algs[i].active_devs == 1)
>> +
>> 	crypto_unregister_akcipher(&virtio_crypto_akcipher_algs[i].algo);
>> +
>> +		virtio_crypto_akcipher_algs[i].active_devs--;
>> +	}
>> +
>> +	mutex_unlock(&algs_lock);
>> +}
> 
> Why don't you reuse the virtio_crypto_algs_register/unregister functions?
> The current code is too repetitive. Maybe we don't need create the new file virtio_crypto_akcipher_algo.c
> because we had virtio_crypto_algs.c which includes all algorithms.
> 

Yes, this looks similar to virtio_crypto_algs_register/unregister.

Let's look at the difference:
struct virtio_crypto_akcipher_algo {
         uint32_t algonum;
         uint32_t service;
         unsigned int active_devs;
         struct akcipher_alg algo;
};

struct virtio_crypto_algo {
         uint32_t algonum;
         uint32_t service; 

         unsigned int active_devs;
         struct skcipher_alg algo; /* akcipher_alg VS skcipher_alg */
};

If reusing virtio_crypto_algs_register/unregister, we need to modify the 
data structure like this:
struct virtio_crypto_akcipher_algo {
         uint32_t algonum;
         uint32_t service;	/* use service to distinguish 
akcipher/skcipher */
         unsigned int active_devs;
	union {
		struct skcipher_alg skcipher;
	        struct akcipher_alg akcipher;
	} alg;
};

int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto)
{
	...
         for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
                 uint32_t service = virtio_crypto_akcipher_algs[i].service;
		...
		/* test service type then call 
crypto_register_akcipher/crypto_register_skcipher */
                 if (service == VIRTIO_CRYPTO_SERVICE_AKCIPHER)
			crypto_register_akcipher(&virtio_crypto_akcipher_algs[i].algo.akcipher);
		else
			crypto_register_skcipher(&virtio_crypto_skcipher_algs[i].algo.skcipher);
		...
         }
	...
}

Also test service type and call 
crypto_unregister_skcipher/crypto_unregister_akcipher.

This gets unclear from current v2 version.

On the other hand, the kernel side prefers to separate skcipher and 
akcipher(separated header files and implementations).

-- 
zhenwei pi
