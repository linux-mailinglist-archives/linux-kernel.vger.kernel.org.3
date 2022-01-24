Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5CC4981E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiAXOSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231918AbiAXOSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643033893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wdJhT+d/EHIj8mi3M2s9axVpMHb56FmhaRK7sF0fZKA=;
        b=YP1Bm17hgSqvwXTmLvav3ogeBtZY0nmLhYzXADEEqLuysJTWaKpw70vscmZ4pr28IZ39bX
        L9EL9cwzhvbPAq/oEJhjPpeijmLfwhNJOU0993s0lmp4X11TH3iDT+quQ3SzomCWWZ4QfO
        GpjAWVqQbvemfykF+3uC74wAyHnxe3k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-4lxPlNQfPeOKdSmokzhccQ-1; Mon, 24 Jan 2022 09:18:12 -0500
X-MC-Unique: 4lxPlNQfPeOKdSmokzhccQ-1
Received: by mail-ed1-f72.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso12042368edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 06:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wdJhT+d/EHIj8mi3M2s9axVpMHb56FmhaRK7sF0fZKA=;
        b=qQZocmtd/ZpI6nX5LsQ3OW01k9JybZh9UhJ5JVO/xQaNMeFtAPy/G2+V1TS0SF9/LX
         zCXbdIXnwizNfH7q/NjHlHBedFn+8rE4lBJ9WJvyHtVf5gEF2v6PQNGOKgCiOkFxX7oz
         E1rO8Ic+dvJD7GdkdtDoKu4EqbAhv2shf/n1IqSdlRrO+vzzbU8mImDUTPJJMPAnLBzV
         iGfvwtxbWt8QEHYFhoA4cDFAzWjiUhRDwvUW6WVT7VxqTbzpN5YT2L2L/wi66JX7cKDI
         oTeeHroUcfqBaH3VuHBpsjsx0DAGEKEIJul5M/BmtmwdqAfPrPVmLjk58jnfYNDWdede
         HspA==
X-Gm-Message-State: AOAM531EfhqHXgAbSNluviAsQfLzSRzpcjr1fJmHW/NME37WWFoOb3pa
        iVnlx6VmnTEUvvduRekwWhzOG6BZRLZIzqv9rgJKoMpgszvBbqyfOti6X/YkIuzS6BtT/F1KHW3
        X9KcMo+LdghlL9jn2xIu837jR
X-Received: by 2002:a17:907:2da3:: with SMTP id gt35mr12644552ejc.493.1643033891321;
        Mon, 24 Jan 2022 06:18:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNEjT0YjeDjSR2UQg/EIK4lDAYiQs+Zof1xa+Z++jLFwH3PoLfzadLDz69HPojlYCiE4JFaQ==
X-Received: by 2002:a17:907:2da3:: with SMTP id gt35mr12644534ejc.493.1643033891068;
        Mon, 24 Jan 2022 06:18:11 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id gg14sm4945743ejb.63.2022.01.24.06.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 06:18:10 -0800 (PST)
Message-ID: <ee85e10c-deb6-5173-0b2e-20226e2d6e8b@redhat.com>
Date:   Mon, 24 Jan 2022 15:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM/X86: Make kvm_vcpu_reload_apic_access_page() static
Content-Language: en-US
To:     Quanfa Fu <quanfafu@gmail.com>, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
References: <20211219091446.174584-1-quanfafu@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211219091446.174584-1-quanfafu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/21 10:14, Quanfa Fu wrote:
> Make kvm_vcpu_reload_apic_access_page() static
> as it is no longer invoked directly by vmx
> and it is also no longer exported.
> 
> No functional change intended.
> 
> Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
> ---
>   arch/x86/include/asm/kvm_host.h | 1 -
>   arch/x86/kvm/x86.c              | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 2164b9f4c7b0..f1c4ba208ed6 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1855,7 +1855,6 @@ int kvm_cpu_has_extint(struct kvm_vcpu *v);
>   int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
>   int kvm_cpu_get_interrupt(struct kvm_vcpu *v);
>   void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
> -void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu);
>   
>   int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
>   		    unsigned long ipi_bitmap_high, u32 min,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0cf1082455df..6569a62ea38b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9621,7 +9621,7 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>   		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
>   }
>   
> -void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
> +static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
>   {
>   	if (!lapic_in_kernel(vcpu))
>   		return;

Queued, thanks.

paolo

