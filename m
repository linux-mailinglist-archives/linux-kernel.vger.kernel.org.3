Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16464922B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbiARJZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:25:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240396AbiARJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642497939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nq095TkJlSpuY4rbTmJ/BPV6+8ZTsXWbcWRpQDxML5s=;
        b=B527O2PMCj0vn2NhBcw7NTAwmAPlBMLe0+sWplc2FxhmBq8gjScvTgjxCk6gbaMxrtRell
        KAoHM48VKTSnARzhiskAGoMNwaganGQazWOWTYMseqgfmDpf97y6au7wYaIVWAmFKuiIos
        L6JX8EnHq/Vr2fCicsilJptQ9JSa7WQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-2BfCR0DzNPiel4UqJQmxCA-1; Tue, 18 Jan 2022 04:25:38 -0500
X-MC-Unique: 2BfCR0DzNPiel4UqJQmxCA-1
Received: by mail-wm1-f72.google.com with SMTP id a3-20020a05600c348300b0034a0dfc86aaso1362208wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nq095TkJlSpuY4rbTmJ/BPV6+8ZTsXWbcWRpQDxML5s=;
        b=Akl6SQbFryxG7MsEofnESsM9Aj7TYIENWvFcKrViwotN07Ry/F/zGsgKmQ5DCnmCni
         pgWQ02DYkuj8LPVA7XpWriTUDJprW+7DZncgrZZuXyXbnnQnyF9ch8shrk6OuaYsdqqF
         dbKy3QOrth6H0Ktu1+2Ajom6BKpb1pP/4T3aRxXZheb5Yzc2jzbOit9AoO4oXyJjT16t
         0jZV2DCBPGgMBl+ZNaxUcfNjLvsXBCDHZyveCT6Un1w1KxTYe6dV96gnZU/YLfVIQDbe
         vqXI8aNCmoroUaIfcVKMZtqhNcgEmjHoWQJk7NNTScdu5JL9ZflXy40IEgSt3XVP7tBM
         NTmQ==
X-Gm-Message-State: AOAM531CxKY8e/uFrkxMJz519htmECQVtxtkn4d6VQXOLaFQN/YBkCC+
        C9Uyh/r+92mGlHkO3aIKZAmZoX2hPMosOG6HOMZ4XqSB/r4JlMSCoCjD/miawo2iwPjmmTL9ACa
        93OcvB0MbodQ3BwwvW7KR4vN0
X-Received: by 2002:a5d:6701:: with SMTP id o1mr23155946wru.128.1642497937039;
        Tue, 18 Jan 2022 01:25:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLYfy+MfLeHTayXwm2KHg+oGdRAn04Rd9F20J8h5I7a8FYwiCMHv5zIQQ1rA6Qh00793tU7w==
X-Received: by 2002:a5d:6701:: with SMTP id o1mr23155927wru.128.1642497936805;
        Tue, 18 Jan 2022 01:25:36 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id f8sm1935324wmg.3.2022.01.18.01.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 01:25:36 -0800 (PST)
Message-ID: <4af811ff-a05e-703f-38f3-c78ceab7d412@redhat.com>
Date:   Tue, 18 Jan 2022 10:25:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/2] KVM: VMX: Fix and test for emulation + exception
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+82112403ace4cbd780d8@syzkaller.appspotmail.com
References: <20211228232437.1875318-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211228232437.1875318-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/21 00:24, Sean Christopherson wrote:
> Fix an issue that allows userspace to trigger a WARN by rejecting KVM_RUN
> if userspace attempts to run a vCPU that require emulation in KVM and has
> a pending exception, which is not supported in KVM.
> 
> No small part of me thinks this is a waste of code and that we'd be better
> off just deleting the WARN.  But it's also not hard to fix and there are
> still folks out there that run on Core2...
> 
> Intentionally didn't tag for stable.  I highly doubt this actually fixes
> anything for anyone, the goal is purely to prevent userspace from triggering
> the WARN.
> 
> Sean Christopherson (2):
>    KVM: VMX: Reject KVM_RUN if emulation is required with pending
>      exception
>    KVM: selftests: Add a test to force emulation with a pending exception
> 
>   arch/x86/include/asm/kvm-x86-ops.h            |   1 +
>   arch/x86/include/asm/kvm_host.h               |   1 +
>   arch/x86/kvm/svm/svm.c                        |   6 +
>   arch/x86/kvm/vmx/vmx.c                        |  22 ++-
>   arch/x86/kvm/x86.c                            |  12 +-
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../vmx_exception_with_invalid_guest_state.c  | 139 ++++++++++++++++++
>   8 files changed, 178 insertions(+), 5 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
> 

Queued, thanks.

Paolo

