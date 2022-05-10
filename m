Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69675215FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242157AbiEJM44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242099AbiEJM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:56:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53B813C369;
        Tue, 10 May 2022 05:52:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id be20so19852959edb.12;
        Tue, 10 May 2022 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WI1zTOfSIg5efVZfyvBSsp8//tfBd0cdczBSSxTFZbM=;
        b=M0XRCTZL5/OCjpLOp6VQQC7z0Re+F/RgmF1UukIrioiMykPB0R7Aj13djyzrg2StTD
         VJDOyuKku0W+egHu+VrN33KttIt3d5+iHhTH3n/5IAmZek52mv17Dg1VcM7yXoyQttmc
         /ZZ+3qIfmL178zYSJkv8X3S0uvoLXDPUu45142K201/sJhbuvvpMuTRzgyPc3YuIXza6
         wIiYACOsi0KOPM/2POCEvOByBujP9Syuh5km2bLbH4e9CB0SYHbUVAnBIqvgA0oOQTmr
         7gOt+5bvgMYuCV5wk35z/SUzp8lENBLwnQYKgIQPJW4nLEsiPn9P1pvj2F4NPM8pdkaE
         AsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WI1zTOfSIg5efVZfyvBSsp8//tfBd0cdczBSSxTFZbM=;
        b=FKhywKOKz1HqzsTMQZM9rD9uW/qR8sBICi+Xb6Wu1sj2YCW8ef4SfcUuK/T7+/4TV2
         bqw0w/4sKdHjfY5772fhSWUOHkGNoO6flJDNX6TYT76e3FGkT0g6mpT78Dx6dpHp9Iu1
         4ep6XZzJ7lV32Sq1bvXNY/tpMkUD+sYUI62ei/OgfJYD2u1Hd+er45d5s5TbrEKGG6Xa
         RfhtPmxyuRGVGx9WSFG0mDAqbnTX62XXnhHaJMukL5sFMdqWJ75oPWIzveeoAplC4eov
         6+60CGG9Wzhka10HtW0qsoqUI9VxBOnYhGS5+7aitXSiwy6nuoMnBD5J3ZBWVbF0ysPe
         /e5Q==
X-Gm-Message-State: AOAM530egDNV37vRdiKKEBbsOPDJ07Mn8yW7uUGQUq5lzZOfAjA/R2HQ
        smgkw5yXBp9ctMr61nEXp9Q=
X-Google-Smtp-Source: ABdhPJyN5CN/JhTtUeKUlijPnHsp542eYOzriocQW2nzKpv+Am+UGABpfo9csh4/XMFj0hFFENFGfA==
X-Received: by 2002:a50:ce14:0:b0:425:cb75:5322 with SMTP id y20-20020a50ce14000000b00425cb755322mr23429940edi.386.1652187176341;
        Tue, 10 May 2022 05:52:56 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:616c:3555:9eac:59cc? ([2a02:908:1256:79a0:616c:3555:9eac:59cc])
        by smtp.gmail.com with ESMTPSA id s3-20020a170906284300b006f3ef214df2sm6096680ejc.88.2022.05.10.05.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 05:52:55 -0700 (PDT)
Message-ID: <ae249cf7-7367-d3c2-60e5-7bfab6e3ef73@gmail.com>
Date:   Tue, 10 May 2022 14:52:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Linaro-mm-sig] Re: [PATCH] dmabuf: ensure unique directory name
 for dmabuf stats
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        sumit.semwal@linaro.org, tjmercier@google.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <1652178212-22383-1-git-send-email-quic_charante@quicinc.com>
 <YnpF1XP1tH83uBlM@kroah.com> <039e1acc-8688-2e06-1b2a-1acbe813b91e@amd.com>
 <YnpWNSdAQzG80keQ@kroah.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YnpWNSdAQzG80keQ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.05.22 um 14:10 schrieb Greg KH:
> On Tue, May 10, 2022 at 01:35:41PM +0200, Christian König wrote:
>> Am 10.05.22 um 13:00 schrieb Greg KH:
>>> On Tue, May 10, 2022 at 03:53:32PM +0530, Charan Teja Kalla wrote:
>>>> The dmabuf file uses get_next_ino()(through dma_buf_getfile() ->
>>>> alloc_anon_inode()) to get an inode number and uses the same as a
>>>> directory name under /sys/kernel/dmabuf/buffers/<ino>. This directory is
>>>> used to collect the dmabuf stats and it is created through
>>>> dma_buf_stats_setup(). At current, failure to create this directory
>>>> entry can make the dma_buf_export() to fail.
>>>>
>>>> Now, as the get_next_ino() can definitely give a repetitive inode no
>>>> causing the directory entry creation to fail with -EEXIST. This is a
>>>> problem on the systems where dmabuf stats functionality is enabled on
>>>> the production builds can make the dma_buf_export(), though the dmabuf
>>>> memory is allocated successfully, to fail just because it couldn't
>>>> create stats entry.
>>> Then maybe we should not fail the creation path of the kobject fails to
>>> be created?  It's just for debugging, it should be fine if the creation
>>> of it isn't there.
>> Well if it's just for debugging then it should be under debugfs and not
>> sysfs.
> I'll note that the original patch series for this described why this was
> moved from debugfs to sysfs.
>
>>>> This issue we are able to see on the snapdragon system within 13 days
>>>> where there already exists a directory with inode no "122602" so
>>>> dma_buf_stats_setup() failed with -EEXIST as it is trying to create
>>>> the same directory entry.
>>>>
>>>> To make the directory entry as unique, append the inode creation time to
>>>> the inode. With this change the stats directory entries will be in the
>>>> format of: /sys/kernel/dmabuf/buffers/<inode no>-<inode creation time in
>>>> secs>.
>>> As you are changing the format here, shouldn't the Documentation/ABI/
>>> entry for this also be changed?
>> As far as I can see that is even an UAPI break, not sure if we can allow
>> that.
> Why?  Device names change all the time and should never be static.  A
> buffer name should just be a unique identifier in that directory, that's
> all.  No rules on the formatting of it unless for some reason the name
> being the inode number was somehow being used in userspace for that
> number?

My impression was that we documented that should have been a number, but 
I might be wrong on this. And if it's not documented to be a number, I 
think it should be.

The background is that you probably need to associate the DMA-buf with 
some userspace structure for accounting and that becomes easier when you 
can just put them into a radix.

Regards,
Christian.

>
> thanks,
>
> greg k-h
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

