Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEAF49B296
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380327AbiAYLGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380190AbiAYLE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643108661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7G0OM7Y6gkeN7L3Twl5XgwRAGbGyt6JwwryGZdSxEo=;
        b=B+lIyMKWCntQVWGRBouF5mFnbd9mQKDXYjIDtfEgkVA95tiQ4fka8EvnthTb/aIDMPIMP3
        MxJPuyxW7ntx9cEEajZL/wkX3lVv4xktLjMtvN0eg2+DjEFbiHHujvAaua/F0L1G5gbipt
        zgflEwaT3mZTS3HTbPrD8O2C4CxARRc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-kb_VditoPs6Xy3fVRIImVw-1; Tue, 25 Jan 2022 06:04:20 -0500
X-MC-Unique: kb_VditoPs6Xy3fVRIImVw-1
Received: by mail-ed1-f70.google.com with SMTP id j1-20020aa7c341000000b0040417b84efeso14661427edr.21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i7G0OM7Y6gkeN7L3Twl5XgwRAGbGyt6JwwryGZdSxEo=;
        b=uwq1pSYzvVSlapp4PCyWUkLIqJXYLW6j/AyLdH9cvKsRgXNoX/WOjuakTJ0yazba1B
         VQ/IqOr7zxuZKp1FsdOWGVt0dTJhfJPABrjjpQLwddGv627DJvO3Y+AJanatIxg6msyO
         ZaLyy3oLeQY2mDyN4RpK4e+28ZQoIoHErmu9OeNpHmCjXAqHjkEIYZjmMEXBhHlEwKiA
         HepIzNTvSdPyS6TYAX4Aum00v9yHgSnmjFUuAeWpZo1RrYAN7Q96KZ1w5RrE/MrJCG9Q
         tXbyHPc+DqzQQsHfSoRI3kNTLQGJRhLHb8uaF1PQIvgKgNUZ8DDafIhcRjgUyaCyqU7D
         6BaQ==
X-Gm-Message-State: AOAM532dE4QGh892UbMa68K9eLpW0Y7OQskSx5bmM1wJMQQzW6600Cmo
        I3ZxQTyl2BI9FAztjHDn/YGy+pmNIYZF8fS9SPOlqjV6P/Zx2MWf5RNtCQ/9XJyyw6HnVZ6KH0k
        kHGuBBWLrZn5EiAtL5XF9+dw9
X-Received: by 2002:a17:907:d8e:: with SMTP id go14mr11357375ejc.616.1643108658457;
        Tue, 25 Jan 2022 03:04:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNY6jb0cUQ7mIMNUdgnmmXyT6nMhdcmxgVsQmrqUHzgupsYg9+NzQuxadWZFpCYLDnSlOgjA==
X-Received: by 2002:a17:907:d8e:: with SMTP id go14mr11357351ejc.616.1643108658233;
        Tue, 25 Jan 2022 03:04:18 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id gz12sm6060382ejc.124.2022.01.25.03.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 03:04:17 -0800 (PST)
Message-ID: <5bae05d4-d4c4-c949-1d26-78cb222e1da5@redhat.com>
Date:   Tue, 25 Jan 2022 12:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: LAPIC: Also cancel preemption timer during SET_LAPIC
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1643102220-35667-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1643102220-35667-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 10:17, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> The below warning is splatting during guest reboot.
> 
>    ------------[ cut here ]------------
>    WARNING: CPU: 0 PID: 1931 at arch/x86/kvm/x86.c:10322 kvm_arch_vcpu_ioctl_run+0x874/0x880 [kvm]
>    CPU: 0 PID: 1931 Comm: qemu-system-x86 Tainted: G          I       5.17.0-rc1+ #5
>    RIP: 0010:kvm_arch_vcpu_ioctl_run+0x874/0x880 [kvm]
>    Call Trace:
>     <TASK>
>     kvm_vcpu_ioctl+0x279/0x710 [kvm]
>     __x64_sys_ioctl+0x83/0xb0
>     do_syscall_64+0x3b/0xc0
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
>    RIP: 0033:0x7fd39797350b
> 
> This can be triggered by not exposing tsc-deadline mode and doing a reboot in
> the guest. The lapic_shutdown() function which is called in sys_reboot path
> will not disarm the flying timer, it just masks LVTT. lapic_shutdown() clears
> APIC state w/ LVT_MASKED and timer-mode bit is 0, this can trigger timer-mode
> switch between tsc-deadline and oneshot/periodic, which can result in preemption
> timer be cancelled in apic_update_lvtt(). However, We can't depend on this when
> not exposing tsc-deadline mode and oneshot/periodic modes emulated by preemption
> timer. Qemu will synchronise states around reset, let's cancel preemption timer
> under KVM_SET_LAPIC.
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>   arch/x86/kvm/lapic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index baca9fa37a91..4662469240bc 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2629,7 +2629,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
>   	kvm_apic_set_version(vcpu);
>   
>   	apic_update_ppr(apic);
> -	hrtimer_cancel(&apic->lapic_timer.timer);
> +	cancel_apic_timer(apic);
>   	apic->lapic_timer.expired_tscdeadline = 0;
>   	apic_update_lvtt(apic);
>   	apic_manage_nmi_watchdog(apic, kvm_lapic_get_reg(apic, APIC_LVT0));

Queued, with Cc to stable.

Paolo

