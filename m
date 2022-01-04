Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9BD48496E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiADUs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiADUs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:48:57 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A0C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:48:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso439812wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 12:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ooWecQNigVE8zIWQ771yQHVCG/Luw6UW39pf+jKA1Vo=;
        b=1thCSJs4PrVpLeNSxTgucaZw90QODsEZGTxIgKA+IgwkZc+n/EjZVhSkBteE7E3faR
         Egw88Tj5/edkUIiwUD8SS+ju0HINcNJq9TwKpyC0IHtPyDIIgK9au3vdAl1CMUN5IGMK
         +yrcfhsnQBOOz4WPAFzfNQtbftAXxTfxyTEP0hCCIEAlNmTqbZ0kN1C0fEDHzLgrWpr3
         o65eP6ON0Gtb81v4tALoeYam5fgpDCrnvUvga6Dzy1o8Ile5njWEazW748m+j/kQhbwb
         IIuVJyXJG6xJ6+vS/Chfu+e4N66pR4vaZtMYNjri9jEHTbBR9cSK5/ZQBLZqxIHbTENX
         GlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ooWecQNigVE8zIWQ771yQHVCG/Luw6UW39pf+jKA1Vo=;
        b=gZ1j6NToBiLFYAMulSjY1qK1K03LL/HgEODynOpVFsroRh/TtC01PUNDmFr7+2IV52
         3N4Cb69f6fi0sbA5+HSVMlKl2/TRuaPF42FCiWnzdQt/IqLfmTX0bf5LCSLDj0XmIpyh
         vq/3UTEabeqiSUv7IWHMt79AF3bfugDJFYrzf0UmSWbaG+qGmJ6y4Stz4Dfs1t7VBerq
         7JJyuBQ22EPzZrStatkYQWkvVPOlysht+w5WlDQ7O21WumTG09AroT1fP/ApPF5kv/ny
         5EruRoO64W/TUB6PZlr1b1hz7yTRmW0scCDdS0JKThYmDCrV0tN+UnuMrjD/8FT2pw6V
         h8vA==
X-Gm-Message-State: AOAM530L4C6TpD+4+z4QDmx1q8v28AMZjtIhU+Lx/nva3qKO7bUp/8dm
        u195eJlp17L87vDTVW0MTaLmpA==
X-Google-Smtp-Source: ABdhPJwT7chVjLZZVthjh2u2ySDREcM4f4FmRAV2iAdj4rzaWxb+jkT3krSbBBFGFBRdBSxfChSghw==
X-Received: by 2002:a05:600c:3507:: with SMTP id h7mr103619wmq.122.1641329335647;
        Tue, 04 Jan 2022 12:48:55 -0800 (PST)
Received: from ?IPV6:2003:d9:9708:b800:49a3:330d:2aba:c4a2? (p200300d99708b80049a3330d2abac4a2.dip0.t-ipconnect.de. [2003:d9:9708:b800:49a3:330d:2aba:c4a2])
        by smtp.googlemail.com with ESMTPSA id c12sm17293190wrr.7.2022.01.04.12.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 12:48:55 -0800 (PST)
Message-ID: <40ca86a1-ea36-0185-1ba5-c69005e46d3f@colorfullife.com>
Date:   Tue, 4 Jan 2022 21:48:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] ipc: Store mqueue sysctls in the ipc namespace
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        kernel test robot <lkp@intel.com>
References: <0f0408bb7fbf3187966a9bf19a98642a5d9669fe.1641225760.git.legion@kernel.org>
 <792dcae82bc228cd0bec1fa80ed4d2c9340b0f8f.1641296947.git.legion@kernel.org>
 <c8edba64-9b4b-1ef8-f0b3-1b4beacf1551@colorfullife.com>
 <87v8yzfilp.fsf@email.froward.int.ebiederm.org>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <87v8yzfilp.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On 1/4/22 19:42, Eric W. Biederman wrote:
> Manfred Spraul <manfred@colorfullife.com> writes:
>   Hi Alexey,
>> On 1/4/22 12:51, Alexey Gladkov wrote:
>>> Right now, the mqueue sysctls take ipc namespaces into account in a
>>> rather hacky way. This works in most cases, but does not respect the
>>> user namespace.
>>>
>>> Within the user namespace, the user cannot change the /proc/sys/fs/mqueue/*
>>> parametres. This poses a problem in the rootless containers.
>>>
>>> To solve this I changed the implementation of the mqueue sysctls just
>>> like some other sysctls.
>>>
>>> Before this change:
>>>
>>> $ echo 5 | unshare -r -U -i tee /proc/sys/fs/mqueue/msg_max
>>> tee: /proc/sys/fs/mqueue/msg_max: Permission denied
>>> 5
>> Could you crosscheck that all (relevant) allocations in ipc/mqueue.c
>> use GFP_KERNEL_ACCOUNT?
> They are not.
>
>> We should not allow normal users to use up all memory.
>>
>> Otherwise:
>> The idea is good, the limits do not really prevent using up all
>> memory, _ACCOUNT is the better approach.
>> And with _ACCOUNT, it doesn't hurt that the namespace root is able to
>> set limits.
> Saying the cgroup kernel memory limit is the only thing that works, and
> that is always better is silly.
>
>
> First the cgroup kernel memory limits noted with ACCOUNT are not
> acceptable on several kernel hot paths because they are so expensive.

I was not aware that ACCOUNT allocations are very expensive.

OTHO adding ACCOUNT resolved various out of memory crashes for IIRC 
ipc/sem.c and/or ipc/msg.c. But we also do not have an RLIMIT for 
ipc/sem.c or ipc/msg.c

Let me rephrase my question:

When we allow non-root users to write to /proc/sys/fs/mqueue/msg_max, 
are there any _relevant_ allocations that bypass _all_ limits?

As you write, we have RLIMIT_MSGQUEUE.

And several allocations for ipc/mqueue already use ACCOUNT:

- the messages themselves, via load_msg()/alloc_msg().

- the inodes, via mqueue_inode_cachep().


> Further the memory cgroup kernel memory limit is not always delegated to
> non-root users, which precludes using the memory cgroup kernel memory
> limit in many situations.
>
>
> The RLIMIT_MQUEUE limit definitely works, and as I read the kernel
> source correct it defaults to MQ_BYTES_MAX aka 819200.  A limit of
> 800KiB should prevent using up all of system memory, except on very low
> memory machines.

I'd agree that 800 kB is not relevant. But we need to be certain that 
there are no loopholes.

I do not see anything relevant, e.g. 0-byte messages should be covered 
by mq_maxmsg. But perhaps I overlook something.

> So please let's not confuse apples and oranges, and let's use the tools
> in the kernel where they work, and not set them up in contest with each
> other.
>
> Rlimits with generous but real limits in general are good at catching
> when a program misbehaves.  The cgroups are better at setting a total
> memory cap.  In this case the rlimit cap is low enough it simply should
> not matter.
>
> What has been fixed with the ucount rlimits is that (baring
> implementation bugs) it is now not possible to create a user namespace
> and escape your rlimits by using multiple users.
I'll try to check the patch in detail in the next few days.


--

     Manfred

