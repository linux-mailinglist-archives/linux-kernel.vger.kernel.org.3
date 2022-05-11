Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32E9522A75
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbiEKDbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbiEKDbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:31:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83445F26B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:31:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so884663pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0Cuz/4c60eAy74LVoGu/qfMMHC1/J7T3iJogMolLBpY=;
        b=V4ZE0XDxk26uwPSQS8dJPeFtf5cIpGdQnSJhziEOEYbidw5ZiU1L5yPsD1GPsa+HOz
         tQTsF4MIFhOYiUuXT6VrVPnZ/YDdwSKEj8Jxz2hjTZe+Q2WitMTb3TRmYchmTZwsrBht
         NO0blCP5OEyyYsvgJLxXOBrITmTOtMAt6Dsao/WkJUbNf4QEhGMIzV4Pqdm/VE7dkKu/
         vMz0QnLSUIMnzs/ikouWcRwlLJg01nwuGrXJ2zLlfoBsoRmN9/jwbojf7rQsr/AmvB+e
         U5mc9rqZahHXdbY5SeXRJI5hTe3QpmaAdq4cCycFRusJxZ6FOmKGdTWhQ2UteZOsc7DZ
         LLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Cuz/4c60eAy74LVoGu/qfMMHC1/J7T3iJogMolLBpY=;
        b=BUaT8n6Fh9JKX3SIc8YwJ4b/ODR3E08JDoUT/sH+Z8s8PCkVT2JnQoxokokamSpYuV
         L51lTeAA4yuctvDhiPlJyGSzyK3fi+5kwYjbjIPhoIqACkFOBiiXE7UyLwO00zwbPHpA
         EppVl+WO/Lb39e6chV9UQR+L5hprdywPXMs17s1OEL77TNrnVbzn1PZZI/p3+lbVP+go
         lFSw49RQl327y/cUsNvSCz4vtUjaUXkbkedWVVlE5fP9bRwP7O8bLpWKsD6wuZH4SZtk
         5bYY296nOH+pFQPvQUiWDfQC+9HuochinUJDX1hiJ+D5zeT27pNrLt/XyvilIU4REbXU
         AiLA==
X-Gm-Message-State: AOAM5325arFIc4nsGaKX9F1Zkm3OJt86Dp5xwWT9uB28YuoSHVZQxEmt
        3vPHvPHd2FUUZ/MLlahXdgiSpg==
X-Google-Smtp-Source: ABdhPJxY0SlCXZqyVxerhzEeDAaBhp6GhEa2eaFw/HdrskiYy68wUGSjbKGUmrMT8YnswcQAMiPSSg==
X-Received: by 2002:a17:90b:194f:b0:1dd:a47:3db5 with SMTP id nk15-20020a17090b194f00b001dd0a473db5mr3157292pjb.74.1652239907513;
        Tue, 10 May 2022 20:31:47 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id q6-20020a056a0002a600b0050dc76281f0sm307226pfs.202.2022.05.10.20.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 20:31:46 -0700 (PDT)
Message-ID: <55fc700a-9cdb-a4ed-c155-5b03a328eb6c@bytedance.com>
Date:   Wed, 11 May 2022 11:27:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: PING: [PATCH v6 0/5] virtio-crypto: Improve performance
Content-Language: en-US
To:     mst@redhat.com
Cc:     jasowang@redhat.com, arei.gonglei@huawei.com,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net
References: <20220506131627.180784-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220506131627.180784-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael

I would appreciate it if you could review this series!

On 5/6/22 21:16, zhenwei pi wrote:
> v5 -> v6:
>   - Minor fix for crypto_engine_alloc_init_and_set().
>   - All the patches have been reviewed by Gonglei, add this in patch.
>   Thanks to Gonglei.
> 
> v4 -> v5:
>   - Fix potentially dereferencing uninitialized variables in
>     'virtio-crypto: use private buffer for control request'.
>     Thanks to Dan Carpenter!
> 
> v3 -> v4:
>   - Don't create new file virtio_common.c, the new functions are added
>     into virtio_crypto_core.c
>   - Split the first patch into two parts:
>       1, change code style,
>       2, use private buffer instead of shared buffer
>   - Remove relevant change.
>   - Other minor changes.
> 
> v2 -> v3:
>   - Jason suggested that spliting the first patch into two part:
>       1, using private buffer
>       2, remove the busy polling
>     Rework as Jason's suggestion, this makes the smaller change in
>     each one and clear.
> 
> v1 -> v2:
>   - Use kfree instead of kfree_sensitive for insensitive buffer.
>   - Several coding style fix.
>   - Use memory from current node, instead of memory close to device
>   - Add more message in commit, also explain why removing per-device
>     request buffer.
>   - Add necessary comment in code to explain why using kzalloc to
>     allocate struct virtio_crypto_ctrl_request.
> 
> v1:
> The main point of this series is to improve the performance for
> virtio crypto:
> - Use wait mechanism instead of busy polling for ctrl queue, this
>    reduces CPU and lock racing, it's possiable to create/destroy session
>    parallelly, QPS increases from ~40K/s to ~200K/s.
> - Enable retry on crypto engine to improve performance for data queue,
>    this allows the larger depth instead of 1.
> - Fix dst data length in akcipher service.
> - Other style fix.
> 
> lei he (2):
>    virtio-crypto: adjust dst_len at ops callback
>    virtio-crypto: enable retry for virtio-crypto-dev
> 
> zhenwei pi (3):
>    virtio-crypto: change code style
>    virtio-crypto: use private buffer for control request
>    virtio-crypto: wait ctrl queue instead of busy polling
> 
>   .../virtio/virtio_crypto_akcipher_algs.c      |  95 ++++++------
>   drivers/crypto/virtio/virtio_crypto_common.h  |  21 ++-
>   drivers/crypto/virtio/virtio_crypto_core.c    |  55 ++++++-
>   .../virtio/virtio_crypto_skcipher_algs.c      | 140 ++++++++----------
>   4 files changed, 182 insertions(+), 129 deletions(-)
> 

-- 
zhenwei pi
