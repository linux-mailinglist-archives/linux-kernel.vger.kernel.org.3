Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4514AE979
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiBIFoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:44:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiBIFlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:41:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F259C014F3A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644385306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKphUtpJBcvwT3GQrOXUSizk13uf7SY936QiEWqygaM=;
        b=EgTu6ccsPCajOBanUuLxfanQfSm23XXiwCC02KSsX4fdfSyS1LWbg/GTczfvNRRiTGgjR/
        Raa17/GMogTTECH80vt9+qXjXoL34rnVJ0Xk7P8EYL8SnoqEIP3Az+YyV0NT09yLNEjxGm
        y1RnGFNU3/mmB9Hlhqo92zjfIQb84/Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-3W5504vUO86dgbhPEe0bSA-1; Wed, 09 Feb 2022 00:41:45 -0500
X-MC-Unique: 3W5504vUO86dgbhPEe0bSA-1
Received: by mail-pj1-f72.google.com with SMTP id y10-20020a17090a134a00b001b8b7e5983bso1023452pjf.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 21:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dKphUtpJBcvwT3GQrOXUSizk13uf7SY936QiEWqygaM=;
        b=HHmw6WtZaRmGTnDYuhx7e2VhdSl/hJLlm4H9UQcyD91R9/dDZ9Cx5VGcVNGWRgKPrb
         ddifZWk+0SVKaJJbTroecWndTIkgGtiduku7xXtR4IihBOQVwu6jRm3llZT0TbjDkfs6
         r2IgXbs4o6/BmNa+Np5VxRpQlD0QI4T4lNXb60EJYxlVOVVBsIrK+SrMWXIAH5Kvb9iS
         mk8XtK/LwjdrLq4XvXz8fjscn+/YD2b0gPOzEoRHkllSHIQ6EA25Jyzlmub3Lj/eVtvW
         Q2mMI/deAT9bC0zKSAzMLP/HQg9eXhZ1qIxj8GhNfT7YB2g36a5kzCFKgam7cGvXV/zZ
         nMOw==
X-Gm-Message-State: AOAM5327N0pH3jGx+atppjIWCo4cYY6naGJcQuRh8LzBNrMcDubkhAFU
        5QXMQuqfD12/Z1iqEBaOv4eS34EzztRynPAyKRxnPSTggXkfesAAdqlIsLkAjnJyqIoIbdMAEji
        5c2OA/WvaVSYpTEf0VHBWQmgj
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr1622598pjb.131.1644385304513;
        Tue, 08 Feb 2022 21:41:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzay6oWtdjb4LB2F6BtE6XSszk1Azb7VpPnr9e4Xq6zAtP7GUe68A2SMWO42AYmL05pn3TfJw==
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr1622583pjb.131.1644385304257;
        Tue, 08 Feb 2022 21:41:44 -0800 (PST)
Received: from [10.72.12.214] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z13sm18336691pfj.23.2022.02.08.21.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 21:41:43 -0800 (PST)
Message-ID: <3ab523ac-0ab5-5011-5328-e119840e1c07@redhat.com>
Date:   Wed, 9 Feb 2022 13:41:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH 0/5] TUN/VirtioNet USO features support.
Content-Language: en-US
To:     Andrew Melnichenko <andrew@daynix.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Yan Vugenfirer <yan@daynix.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
References: <20220125084702.3636253-1-andrew@daynix.com>
 <1643183537.4001389-1-xuanzhuo@linux.alibaba.com>
 <CAOEp5OcwLiLZuVOAxx+pt6uztP-cGTgqsUSQj7N7HKTZgmyN3w@mail.gmail.com>
 <CABcq3pE43rYojwUCAmpW-FKv5=ABcS47B944Y-3kDqr-PeqLwQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <CABcq3pE43rYojwUCAmpW-FKv5=ABcS47B944Y-3kDqr-PeqLwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/2/8 下午9:09, Andrew Melnichenko 写道:
> Hi people,
> Can you please review this series?


Are there any performance number to demonstrate the difference?

Thanks


>
> On Wed, Jan 26, 2022 at 10:32 AM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
>> On Wed, Jan 26, 2022 at 9:54 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>> On Tue, 25 Jan 2022 10:46:57 +0200, Andrew Melnychenko <andrew@daynix.com> wrote:
>>>> Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
>>>> Technically they enable NETIF_F_GSO_UDP_L4
>>>> (and only if USO4 & USO6 are set simultaneously).
>>>> It allows to transmission of large UDP packets.
>>>>
>>>> Different features USO4 and USO6 are required for qemu where Windows guests can
>>>> enable disable USO receives for IPv4 and IPv6 separately.
>>>> On the other side, Linux can't really differentiate USO4 and USO6, for now.
>>>> For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
>>>> In the future, there would be a mechanism to control UDP_L4 GSO separately.
>>>>
>>>> Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
>>>>
>>>> New types for VirtioNet already on mailing:
>>>> https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html
>>> Seems like this hasn't been upvoted yet.
>>>
>>>          https://github.com/oasis-tcs/virtio-spec#use-of-github-issues
>> Yes, correct. This is a reason why this series of patches is RFC.
>>
>>> Thanks.
>>>
>>>> Also, there is a known issue with transmitting packages between two guests.
>>>> Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
>>>>
>>>> Andrew Melnychenko (5):
>>>>    uapi/linux/if_tun.h: Added new ioctl for tun/tap.
>>>>    driver/net/tun: Added features for USO.
>>>>    uapi/linux/virtio_net.h: Added USO types.
>>>>    linux/virtio_net.h: Added Support for GSO_UDP_L4 offload.
>>>>    drivers/net/virtio_net.c: Added USO support.
>>>>
>>>>   drivers/net/tap.c               | 18 ++++++++++++++++--
>>>>   drivers/net/tun.c               | 15 ++++++++++++++-
>>>>   drivers/net/virtio_net.c        | 22 ++++++++++++++++++----
>>>>   include/linux/virtio_net.h      | 11 +++++++++++
>>>>   include/uapi/linux/if_tun.h     |  3 +++
>>>>   include/uapi/linux/virtio_net.h |  4 ++++
>>>>   6 files changed, 66 insertions(+), 7 deletions(-)
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>> _______________________________________________
>>>> Virtualization mailing list
>>>> Virtualization@lists.linux-foundation.org
>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

