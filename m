Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F89049B8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384876AbiAYQdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:33:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376765AbiAYQ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643128166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pDIe5zZeGAsMhGaJS5ubWDueDUmxVke0X9bRn+VSe9M=;
        b=inCvX9zhjHHVjUm67YSd5MI11TSxhtMQbaRWTtVuTtaSY3kNlffR1YFtSShCXW5VBZ3jAv
        RGoCY7nKFIW49oiMpednejdq0q667zNKv77722zWQ9TgDwPna4tA+fdNGXm8JRQjedUXHU
        qYs7o9xoK9PwO8x63jyiXXAVP1WQr/M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593--rjdOubkNjWsoDaFcTGWxw-1; Tue, 25 Jan 2022 11:29:24 -0500
X-MC-Unique: -rjdOubkNjWsoDaFcTGWxw-1
Received: by mail-ed1-f69.google.com with SMTP id o25-20020a056402039900b0040631c2a67dso9058395edv.19
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pDIe5zZeGAsMhGaJS5ubWDueDUmxVke0X9bRn+VSe9M=;
        b=Xijr/4Fbqz2TPT6MTYOJgBM1v5ybL53shd4KUXfhPs0OkIOgTHqI/5GZnRQujGJrtm
         kApgrTFFc1032IPdWNPjo94TEf/VBi4PmO7OlxakYph30+XJpKSyPugTk/ik42sQjeFV
         6gnOGVp4QX51EsgTlQ32dwJk/DDgTNIfPFElMqL3SpbzFtGkdrw4CI49Ymf0M2P/gm23
         XbT+6FPJ5JTIn/DaDMe7+xpsJDAEQ/QUfKrU8FvxIPJuH58QTxC8iU+BfIxEN4c+AaHT
         N4X4s39gYn8hJDgDnJv9+dIS8pT4f7WZP9DQDsCAlp+UsAThhNuVoDRqllAPixeVbrtK
         l+ng==
X-Gm-Message-State: AOAM5317xzsk2xgYWYdPL3noSVVlZzFo+FqYR2egnhqnt0xROkdi/0kQ
        hytTi20/EARHFi7ZLMiKUj42lvtkn86O91iiUnSbzqUG9QoUXVBrMsBrwMdP0kq0otqThycauOq
        XG/lIAM8ZximhBeSRbLh73aUY
X-Received: by 2002:a17:906:5d0e:: with SMTP id g14mr16775507ejt.171.1643128163260;
        Tue, 25 Jan 2022 08:29:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuLr/3qd5F6bInJNse2Y9c8TkItUf/jK4OeCeJ43Pp+Mc9PGhnOncOSwvm2GYeNwXNJ+dQiw==
X-Received: by 2002:a17:906:5d0e:: with SMTP id g14mr16775491ejt.171.1643128162956;
        Tue, 25 Jan 2022 08:29:22 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id q8sm4889436eja.209.2022.01.25.08.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 08:29:22 -0800 (PST)
Message-ID: <c4994952-efe0-ffe1-a129-7525ec9e7317@redhat.com>
Date:   Tue, 25 Jan 2022 17:29:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 09/19] KVM: x86/svm: Remove unused "svm" of
 sev_es_prepare_guest_switch()
Content-Language: en-US
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220125095909.38122-1-cloudliang@tencent.com>
 <20220125095909.38122-10-cloudliang@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220125095909.38122-10-cloudliang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 10:58, Jinrong Liang wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> The "struct vcpu_svm *svm" parameter of sev_es_prepare_guest_switch()
> is not used, so remove it. No functional change intended.
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>   arch/x86/kvm/svm/sev.c | 2 +-
>   arch/x86/kvm/svm/svm.c | 2 +-
>   arch/x86/kvm/svm/svm.h | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6a22798eaaee..eae234afe04e 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2902,7 +2902,7 @@ void sev_es_vcpu_reset(struct vcpu_svm *svm)
>   					    sev_enc_bit));
>   }
>   
> -void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
> +void sev_es_prepare_guest_switch(unsigned int cpu)
>   {
>   	struct svm_cpu_data *sd = per_cpu(svm_data, cpu);
>   	struct vmcb_save_area *hostsa;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 744ddc7ad6ad..3e75ae834412 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1276,7 +1276,7 @@ static void svm_prepare_guest_switch(struct kvm_vcpu *vcpu)
>   	 * or subsequent vmload of host save area.
>   	 */
>   	if (sev_es_guest(vcpu->kvm)) {
> -		sev_es_prepare_guest_switch(svm, vcpu->cpu);
> +		sev_es_prepare_guest_switch(vcpu->cpu);
>   	} else {
>   		vmsave(__sme_page_pa(sd->save_area));
>   	}
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 47ef8f4a9358..0a749bbda738 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -622,7 +622,7 @@ int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
>   void sev_es_init_vmcb(struct vcpu_svm *svm);
>   void sev_es_vcpu_reset(struct vcpu_svm *svm);
>   void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
> -void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu);
> +void sev_es_prepare_guest_switch(unsigned int cpu);
>   void sev_es_unmap_ghcb(struct vcpu_svm *svm);
>   
>   /* vmenter.S */

This should instead receive a struct vmcb_save_area *, since the vmsave 
part is common between sev_es_prepare_guest_switch and the "else" branch 
in svm_prepare_guest_switch.  I'll send a patch - thanks for the report.

Paolo

