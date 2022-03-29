Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E744EB00C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiC2PQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiC2PQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:16:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C12487AB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:14:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 5so30845595lfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TCWrlmneGOD7IIFil77Bp2XL5E/ZrBLzGSn/OUyCQN0=;
        b=0snEddn4uogq3VRB+KJjhfSrZK0razWsMw5N20v12tpvTWhHFw5VFy8nvCgvuchIeq
         Y8v6/6i4BLlGIMlkmbcg3+chXOTbVnBcyRLfNg7XJG13BhDqNF91CiR0mB9ALoCBZbgq
         VJD5pBeofBjWJlkwGPG3vqvs94AwJVutuxn3Ylj5RReI524R0enkpU0i2VKtmE6bAmpa
         m0+FEOeMcNSDJhKcLqB5dVigUHoK/NJ8pkA8HfIS5wc+4eFZceLS7vN0WodHSC6DEij0
         U1XvgqwBepu3VF8TwViTKTaJ6Ijm0iWkHRd+WbEEqRo8kT0FBi02EW6AVaNw/EdJAqna
         xypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TCWrlmneGOD7IIFil77Bp2XL5E/ZrBLzGSn/OUyCQN0=;
        b=KODsIMmwJSd2WKaqeGpVymgwTV/VmFPWE7tWaO7j0vHTFdVh0Q22qdtV4AvyMIjRad
         ZH1V5bbzH4xq12GvggSw0ev9hSzWW2yeBRrwu+GNXH7kRDhca6Ndd2heK/gZpJlP6NoP
         oi/PBLnsgP/M/jqr1u25BRxnkJLonrJCvbxHDyQplQplJcFNrc9oX+8Kot7i/KosMHNE
         D02BbEsgNrOGhwCe4Whd+2hcpSRUr4GCcO4UtPwRMg5wGXEDn7eSZQ+KN1KeIZdulfKh
         /w2UdVeLGdFLlAphbRpC5j7ES06OFoSVAQsOzu2PrjoLXXmqrek7gCVuvPCbZ8TXT/07
         s+Pg==
X-Gm-Message-State: AOAM531lXrXRwudDGIv/uMqHR0nQXplSoPihfodJ3AkCDGZ9jIxjgrz8
        8gjg6XH/hAEiC3pXIsknmFuYulXJORHXiBH58/w=
X-Google-Smtp-Source: ABdhPJxWSF7zpEgBOOCeivx+pQN3jDM+rv6d44kgAKyIFW8havUT3LmsKKoQ3S9eXl9h7KTZgf/AwQ==
X-Received: by 2002:a05:6512:128f:b0:44a:2b70:91e3 with SMTP id u15-20020a056512128f00b0044a2b7091e3mr3211444lfs.160.1648566896888;
        Tue, 29 Mar 2022 08:14:56 -0700 (PDT)
Received: from [192.168.0.120] ([2.92.192.13])
        by smtp.gmail.com with ESMTPSA id y24-20020a199158000000b0044a76a4808esm1462330lfj.22.2022.03.29.08.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:14:56 -0700 (PDT)
Message-ID: <ccd18622-9c38-2252-27d8-25bb8538ac26@openvz.org>
Date:   Tue, 29 Mar 2022 18:14:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [dm-devel] [PATCH 0/4] dm: Introduce dm-qcow2 driver to attach
 QCOW2 files as block device
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        khorenko@virtuozzo.com
References: <164846619932.251310.3668540533992131988.stgit@pro>
 <YkME5ZS2CpXuNmN6@infradead.org>
From:   Kirill Tkhai <kirill.tkhai@openvz.org>
In-Reply-To: <YkME5ZS2CpXuNmN6@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.2022 16:08, Christoph Hellwig wrote:
> On Mon, Mar 28, 2022 at 02:18:16PM +0300, Kirill Tkhai wrote:
>> This patchset adds a new driver allowing to attach QCOW2 files
>> as block devices. Its idea is to implement in kernel only that
>> features, which affect runtime IO performance (IO requests
>> processing functionality).
> 
> From a quick looks it seems to be like this should be a block driver
> just like the loop driver and not use device mapper.  Why would
> you use device mapper to basically reimplement a fancy loop driver
> to start with?

This is a driver for containers and virtual machines. One of basic features
for them is migration and backups. There are several drives for that, which
are already implemented in device-mapper. For example, dm-era and dm-snap.
Instead of implementing such the functionality in QCOW2 driver once again,
the sane behavior is to use already implemented drivers. The module-approach
is better for support and errors eliminating just because of less code.

1)A device-mapper based driver does not require migration and backup devices
  are built in a stack for the whole device lifetime:

  a)Normal work, almost 100% of time: there is only /dev/mapper/qcow2_dev.
  b)Migration: /dev/mapper/qcow2_dev is reloaded with a migration device,
    which points to new qcow2_dev.real:

    /dev/mapper/qcow2_dev          [migration driver]
      /dev/mapper/qcow2_dev.real   [dm-qcow2 driver]
    
   After migration is completed, we reload /dev/mapper/qcow2_dev back
   to use dm-qcow2 driver. So, there is no excess dm layers during normal work.

2)In case of the driver is not a device-mapper based, it's necessary to have
  the stack built for the whole device lifetime, since it's impossible to reload
  bare block driver with dm-based driver on demand:

    /dev/mapper/qcow2_dev          [migration driver]
       /dev/qcow2_dev.real         [bare qcow2 driver]

  So, we would have excess dm layer during whole device lifetime.

Our performance tests show, that a single dm layer may cause up to 10% performance
decrease on NVME, so the reason is to eliminate such the fall. Also, the general
reasoning say that excess layer is a wrong way.

Other reason is previous experience of implementing file-backed block drivers.
We had ploop driver before. Ploop format is much simpler that QCOW2 format, but
there are about 17K strings, while dm-qcow2 driver took about 6K strings.
Device mapper allows to avoid writing a lot of code, the only thing you need
is to implement proper .ctr and .dtr functions, while the rest of configuration
actions are done by simple device-mapper reload.

>> The maintenance operations are
>> synchronously processed in userspace, while device is suspended.
>>
>> Userspace is allowed to do only that operations, which never
>> modifies virtual disk's data. It is only allowed to modify
>> QCOW2 file metadata providing that disk's data. The examples
>> of allowed operations is snapshot creation and resize.
> 
> And this sounds like a pretty fragile design.  It basically requires
> both userspace and the kernel driver to access metadata on disk, which
> sounds rather dangerous.

I don't think so. Device-mapper already allows to replace a device driver with
another driver. Nobody blames dm-linear, that it may be reloaded to point wrong
partition, while it can. Nobody blames loop, that someone in userspace may corrupt
its blocks, and filesystem on that device will become broken.

The thing is kernel and userspace never access the file at the same time.
It case of maintenance actions may be called in userspace, they must be, since
this reduces the kernel code.
 
>> This example shows the way of device-mapper infrastructure
>> allows to implement drivers following the idea of
>> kernel/userspace components demarcation. Thus, the driver
>> uses advantages of device-mapper instead of implementing
>> its own suspend/resume engine.
> 
> What do you need more than a queue freeze?

Theoretically, I can, in case of this flushes all pending requests. But this
will increase driver code significantly, since there won't be possible to use
reload mechanism, and there are other problems like problems with performance
like I wrote above. So, this approach look significantly worse.

Kirill
