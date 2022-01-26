Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C29849D060
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbiAZRFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:05:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243359AbiAZRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643216743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3ZjP6VeZe7Q/860UowGIN2PNeWTZEeU6WyQSGVUMls=;
        b=i2udVVoCiGcHG7U/3F+5CwueIt2r30R2VZEpLHngxXHmCWBpT+FM9kOoCdylCnqSLLDRYs
        F7hepdvuXzYhSIwUuuSJ8RKuUJz6B6QvkPyMuS2X2qFoaFgmE8kZfhAmckcq34SFfO1Svn
        daCfhBDVQF+v/m7/gs8j41ChbcUi4x8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-DPG9592oNAuIzBmtTlgY4Q-1; Wed, 26 Jan 2022 12:05:42 -0500
X-MC-Unique: DPG9592oNAuIzBmtTlgY4Q-1
Received: by mail-ej1-f70.google.com with SMTP id b12-20020a17090630cc00b006a7190bdfbaso5190035ejb.18
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v3ZjP6VeZe7Q/860UowGIN2PNeWTZEeU6WyQSGVUMls=;
        b=Lg7OnpJVZoMXLEBTE9OWikOeUkFo7NRP32PE+pl8y3hvdoodcVSUmzjklUrDw+wuWh
         I40cQhUTtEm5LyWdAy+kd4iis50jlXCGWqXEYRsZm6OogTfjrvAZX7kiuHiYgSvvH2Qk
         YoSn1ksTK888GOOM5i2Ynfnx6v5ozKE1txfb+9r+6nboBDu4UZ0WgDJsKVLBFQOaATCU
         hccZAd4usQwG/DDUqVu2K5Uj0xj/EREXEvQnEbw4erpTK4bMRAW7bNPauIECsOqeXwHf
         UGuKo/eGQ/B47IuwB+ZinrDI3OrwxT5HBoKiJHqcSmwHKv8pdmFYohSfkHke5KCGy+1Q
         auHQ==
X-Gm-Message-State: AOAM5303IzlckGo7X1jkGlj/+aoSZl3VvoVJ3Vkl6WitxSB6Rq7FSpmr
        XOvbius/TJm0zHNJg3+sZgNWTaaLYRvuTLBEIy41cxdVhxaeOVu+jnXSJfU6IU9ef/BjuXFDeNj
        m/0Hy2Vjpb/0ldBxN0N9QvNwT
X-Received: by 2002:a17:906:589:: with SMTP id 9mr21630210ejn.721.1643216740643;
        Wed, 26 Jan 2022 09:05:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQll0mEg6+MLnV3bkmv7NaUphAuzY7ys699gfAchb37yFJ8kgpOBpXpBCU/k5yG8HQ0z2M2A==
X-Received: by 2002:a17:906:589:: with SMTP id 9mr21630190ejn.721.1643216740408;
        Wed, 26 Jan 2022 09:05:40 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id s20sm7617207ejc.189.2022.01.26.09.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 09:05:39 -0800 (PST)
Message-ID: <a7afb949-4865-f668-b2f3-414c8c4a47b6@redhat.com>
Date:   Wed, 26 Jan 2022 18:05:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: nVMX: WARN on any attempt to allocate shadow VMCS
 for vmcs02
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220125220527.2093146-1-seanjc@google.com>
 <87r18uh4of.fsf@redhat.com> <053bb241-ea71-abf8-262b-7b452dc49d37@redhat.com>
 <YfF1TQx/vsV5OepU@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YfF1TQx/vsV5OepU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 17:22, Sean Christopherson wrote:
> I don't like preceeding, because that will likely lead to a crash and/or WARNs if
> KVM call the helper at the right time but with the wrong VMCS loaded, i.e. if
> vmcs01.shadow_vmcs is left NULL, as many paths assumes vmcs01 is allocated if they
> are reached with VMCS shadowing enabled.  At the very least, it will leak memory
> because vmcs02.shadow_vmcs is never freed.
> 
> Maybe this to try and clarify things?  Compile tested only...

Your patch is okay, just with an extra paragraph in the commit message:


The previous code WARNed but continued anyway with the allocation,
presumably in an attempt to avoid NULL pointer dereference.
However, alloc_vmcs (and hence alloc_shadow_vmcs) can fail, and
indeed the sole caller does:

         if (enable_shadow_vmcs && !alloc_shadow_vmcs(vcpu))
                 goto out_shadow_vmcs;

which makes it not a useful attempt.

Paolo

