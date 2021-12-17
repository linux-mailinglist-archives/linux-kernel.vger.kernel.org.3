Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B01479185
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbhLQQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:34:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235631AbhLQQeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639758851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ChIkAA1P0rhxmMj+OSv7E9eITrJWi4wnxfRUd873BMw=;
        b=CPd1BWE6OLW6SVUtnbR0MlqmxFBZNBNn9TTR2FqUcxr6iLSE/uRPshQrQptexjsKCngcii
        qqakzCoK2xx1tXpugALuqC5jezmuVRnJZhLxfNh/CcQLnXo8q0m2DlSq0xSGKDvtuquI8k
        P8roqy9OvmyotpJqtGXg9ADaq/ftmBU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-q55WocgTMLe7hpYV-q_WOw-1; Fri, 17 Dec 2021 11:34:10 -0500
X-MC-Unique: q55WocgTMLe7hpYV-q_WOw-1
Received: by mail-wm1-f71.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso1288246wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ChIkAA1P0rhxmMj+OSv7E9eITrJWi4wnxfRUd873BMw=;
        b=pSThDg9E5r6Uykn+AJCj/6pPFGpAEBxmsnGjcWN+CU8MCwV/yTVmgQjfRQMTC9I/C7
         LBzTlXDng7dJX+Repbnqxq12vYD919xKb7sPUxHl19pznA3GBFcV27COVdoqYw4kB9jH
         cTXagTlTUvJps4k+45Tz/UeJEHkuKd0menjaDvy7dqMgDFYfjhV9G02qp2pKlx2tFUjF
         OtNru4uYjba7x3QwLzIUrUP5X0zVV9MspnMpF3gO7nWIauevQJcsdGFeAXZJzmdamP5g
         O+jTgL896SXPEXNzGBqwyr56IFmHs698q08T6VNP8XHb5kofETVNugSaGI4izz9aivos
         13Vg==
X-Gm-Message-State: AOAM532LR9GVXhTkv443Ak/NdN8yj/41gYy8UqcNiw12KezCyysu0UWa
        fGyFanwu7B3VpHHaYvcj+U3KAtKlg/gj/ntlImFKyiAu18xLeEqQ5CV8q7V/cxmgo/C23OHOYZS
        o5cL5flCsOI45pcIuFy43QK3J
X-Received: by 2002:adf:fb05:: with SMTP id c5mr3071890wrr.497.1639758849201;
        Fri, 17 Dec 2021 08:34:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDLzLvZGGbxXRIrttXF2p3HboGOachfgkml4ByJfP3WTVmRAGVDmx2EyyY0y0qV0GcR/afCw==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr3071876wrr.497.1639758849019;
        Fri, 17 Dec 2021 08:34:09 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:48f9:bea:a04c:3dfe? ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
        by smtp.googlemail.com with ESMTPSA id h204sm7828484wmh.33.2021.12.17.08.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 08:34:08 -0800 (PST)
Message-ID: <f3d6095a-70aa-3da0-08a6-3caff2638809@redhat.com>
Date:   Fri, 17 Dec 2021 17:34:04 +0100
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
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211217160749.GS641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 17:07, Paul E. McKenney wrote:
>> rcu_note_context_switch() is a point-in-time notification; it's not strictly
>> necessary, but it may improve performance a bit by avoiding unnecessary IPIs
>> from the RCU subsystem.
>>
>> There's no benefit from doing it when you're back from the guest, because at
>> that point the CPU is just running normal kernel code.
>
> Do scheduling-clock interrupts from guest mode have the "user" parameter
> set?  If so, that would keep RCU happy.

No, thread is in supervisor mode.  But after every interrupt (timer tick 
or anything), one of three things can happen:

* KVM will go around the execution loop and invoke 
rcu_note_context_switch() again

* or KVM will go back to user space

* or the thread will be preempted

and either will keep RCU happy as far as I understand.

Paolo

