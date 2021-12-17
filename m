Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F754792C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbhLQRXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:23:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232533AbhLQRXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639761817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2E4moqp/c8I4AQdWLvxljNuUdO0Hkrp+/zBhC2tHogE=;
        b=CpUDKrSICM8u29mKZKbmqtfvYQZDX0hcv4KoFRaAbelwM7gwPFgqaK6ejMXDKyPW5t+6Mt
        MNBYaRGl5auRVBZWl3wR7Lc+AKoptl0Z7I/m8QH2NWqQ4RXEl8RHTZInxWCQ2d3mAwOnCC
        +6IAYEiQ+GynibIuHd0NzQXTAt7h75k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-Cyq7ejCqO8Gc3xBvPBAI-Q-1; Fri, 17 Dec 2021 12:23:36 -0500
X-MC-Unique: Cyq7ejCqO8Gc3xBvPBAI-Q-1
Received: by mail-ed1-f72.google.com with SMTP id v19-20020a056402349300b003f7eba50675so2512275edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 09:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2E4moqp/c8I4AQdWLvxljNuUdO0Hkrp+/zBhC2tHogE=;
        b=sG23zkHFTyCYLH9zdVusSGYomaSJcdPEQVvypqaYFbWvc09w7ii/AJriLDOnxYSSf/
         L/GNRLSKT42Kvxdi6dZDjeRiojyQwHkl2zVk5e693eqqP8D2+0Ld0WC18/u0iUjEKDjZ
         LCnMOyPeLEZkrSNLCFwYIAJjjg8DyEbQi3mf0xvw5q0rAoZcZikhjaP99nrS9Byv7Ixi
         5zyVJgR0GGtF/sfMMXWq0pK3sZjQhQBkaxayULdc/pCkcrT/KyzZxv9w+Igks1ega/HE
         xyaY6FcBJPpb84I6hdcJ56d2g+Tey6D90/fi0ws0ehnynEjCTh31kIfNfqc67DOHnplI
         1y8Q==
X-Gm-Message-State: AOAM530rUvKZRlhWSEiWuF9AqPfxEhjumee6BfEQnGPkz5qeoWxHoozG
        lOETAE5QgD+lcPealX9t7AWpgN/81uz4R9Pio2VWVKHc9WFxaULF0apChTnxETAQEjs2DHQtuNX
        29bKlmQXtODgybm3MufO8ohS6
X-Received: by 2002:a17:907:2d9f:: with SMTP id gt31mr3276990ejc.353.1639761815435;
        Fri, 17 Dec 2021 09:23:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyYaUeLeDwkSn+1UkB3EEbIuMyCeJwU20sBpBLMNBVvm8tzJn+Taaia56Rbt5qT+bN3TbTMg==
X-Received: by 2002:a17:907:2d9f:: with SMTP id gt31mr3276976ejc.353.1639761815192;
        Fri, 17 Dec 2021 09:23:35 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312::ac3? ([2001:b07:6468:f312::ac3])
        by smtp.googlemail.com with ESMTPSA id a16sm1798277ejk.8.2021.12.17.09.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 09:23:34 -0800 (PST)
Message-ID: <24268298-c51f-afcd-72e2-22c39eb002b5@redhat.com>
Date:   Fri, 17 Dec 2021 18:23:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        maz <maz@kernel.org>, frederic <frederic@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
 <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
 <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
 <20211217160749.GS641268@paulmck-ThinkPad-P17-Gen-1>
 <f3d6095a-70aa-3da0-08a6-3caff2638809@redhat.com>
 <20211217164535.GU641268@paulmck-ThinkPad-P17-Gen-1>
 <4c369ca2-2ad0-4a02-90e9-2d82df6c289d@redhat.com>
 <20211217171218.GV641268@paulmck-ThinkPad-P17-Gen-1>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211217171218.GV641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 18:12, Paul E. McKenney wrote:
> On Fri, Dec 17, 2021 at 06:02:23PM +0100, Paolo Bonzini wrote:
>> On 12/17/21 17:45, Paul E. McKenney wrote:
>>> On Fri, Dec 17, 2021 at 05:34:04PM +0100, Paolo Bonzini wrote:
>>>> On 12/17/21 17:07, Paul E. McKenney wrote:
>>>>>> rcu_note_context_switch() is a point-in-time notification; it's not strictly
>>>>>> necessary, but it may improve performance a bit by avoiding unnecessary IPIs
>>>>>> from the RCU subsystem.
>>>>>>
>>>>>> There's no benefit from doing it when you're back from the guest, because at
>>>>>> that point the CPU is just running normal kernel code.
>>>>>
>>>>> Do scheduling-clock interrupts from guest mode have the "user" parameter
>>>>> set?  If so, that would keep RCU happy.
>>>>
>>>> No, thread is in supervisor mode.  But after every interrupt (timer tick or
>>>> anything), one of three things can happen:
>>>>
>>>> * KVM will go around the execution loop and invoke rcu_note_context_switch()
>>>> again
>>>>
>>>> * or KVM will go back to user space
>>>
>>> Here "user space" is a user process as opposed to a guest OS?
>>
>> Yes, that code runs from ioctl(KVM_RUN) and the ioctl will return to the
>> calling process.
> 
> Intriguing.  A user process within the guest OS or a user process outside
> of any guest OS, that is, within the host?

A user process on the host.  The guest vCPU is nothing special: it's 
just a user thread that occasionally lets the guest run by invoking the 
KVM_RUN ioctl.  Hopefully, KVM_RUN will be where that user thread will 
spend most of the time so the guest runs at full steam.  KVM_RUN is the 
place where you have the code that Nicolas and Mark were discussing.

 From the point of view of the kernel however the thread is always in 
kernel mode when it runs the guest, because any interrupt will be 
recognized while still in the ioctl.

(I'll add that from the point of view of the scheduler, there's no 
difference between a CPU-bound guest and a "normal" CPU-bound process on 
the host, e.g. wasting time with "for(;;)" or calculating digits of PI 
is the same no matter if you're doing it in the guest or in the host. 
Likewise for I/O-bound guests; e.g. doing "hlt" or "wfi" constantly in 
the guest looks exactly the same to the scheduler as a process that 
spends its time in the poll() system call).

Paolo

