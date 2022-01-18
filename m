Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B823492C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347068AbiARRMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:12:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346919AbiARRMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642525943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTFcvZshGd418XxQ4f5JMIidhKASZvElX59Zaynhob4=;
        b=IzRuYszDk6bzRAFOmBMimVyHJg32yzafGC2S4QD1H1+OrAMR80i+pTw7ZUVfZ0TwNmciMd
        h7KWqptZWJI2yg7bGxN7lijws9KL7MtlrIeeGmR66syznWJaxMymUUInFMZAX4oubeMCFO
        CGCCgE/z259F+UQFG2dvGzxy2v/cOWM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-UkGwWek1PeyuKpnP7-gZbQ-1; Tue, 18 Jan 2022 12:12:19 -0500
X-MC-Unique: UkGwWek1PeyuKpnP7-gZbQ-1
Received: by mail-ed1-f69.google.com with SMTP id bs4-20020a056402304400b004032af6b7ebso4367045edb.16
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CTFcvZshGd418XxQ4f5JMIidhKASZvElX59Zaynhob4=;
        b=NSBScL9owDL3R+gYbtY6VTXEvjQk7KTcxgFXWw5SgaJ3CpFgdHCrAVFZzTgL+csO8j
         PHQDdJ5w182guGcG7spgFXpQayxlhVV1oRexAB8tcKTDQ/S7tEuzxWSCNWOWOmeIhsT1
         oKzxmIX3WwrhIBLPWwCxGvjs8jfaCv6enfbRWjjSOynW07muA1+8Cu5GlFTFf2dqY72x
         fnz2rBHXMVWXd6e9vU2gV4ClJWeReNaFoCviGc4Vr2SjdJAKIowo2YFDMDrZjcI9lzRs
         MaGQytoBcM3uVyqD97OhysFEG6fakvNEQ89hLb2bWsp0aX5CPOG7ylQJVNV0H/QL6Je9
         VjQg==
X-Gm-Message-State: AOAM532wvexYmg7RJPt3IEB8ifyZodCWyc+YuxSV8x9Ccoy4qPyJKiS/
        qcZo5uF6FSS2cMkq+SDIGADNQZtmax5+kNk6OXt3neu4Y6Vq3NfmNlALHE9LRublr8S6can6GBz
        0LgTUP2pXhn6UYJQuhe+MYyeA
X-Received: by 2002:a17:906:9746:: with SMTP id o6mr20727222ejy.112.1642525937917;
        Tue, 18 Jan 2022 09:12:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwljlno0wVWgKk1pGv+IEFTQBr9kKOJljcK59bCW2njywhQcJtIwVh22D7avYUEqToB1+2oCw==
X-Received: by 2002:a17:906:9746:: with SMTP id o6mr20727210ejy.112.1642525937722;
        Tue, 18 Jan 2022 09:12:17 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id 16sm5601542ejx.149.2022.01.18.09.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 09:12:17 -0800 (PST)
Message-ID: <4a87b289-05a7-8247-9529-a8148924a7c5@redhat.com>
Date:   Tue, 18 Jan 2022 18:12:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/4] KVM: x86: Partially allow KVM_SET_CPUID{,2} after
 KVM_RUN for CPU hotplug
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Igor Mammedov <imammedo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20220117150542.2176196-1-vkuznets@redhat.com>
 <20220118153531.11e73048@redhat.com>
 <498eb39c-c50a-afef-4d46-5c6753489d7e@redhat.com>
 <YebwkcAgszlyTzJ+@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YebwkcAgszlyTzJ+@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 17:53, Sean Christopherson wrote:
>>
>> and I think we should redo all or most of kvm_update_cpuid_runtime
>> the same way.
> Please no.  xstate_required_size() requires multiple host CPUID calls, and glibc
> does CPUID.0xD.0x0 and CPUID.0xD.0x1 as part of its initialization, i.e. launching
> a new userspace process in the guest will see additional performance overhread due
> to KVM dynamically computing the XSAVE size instead of caching it based on vCPU
> state.  Nested virtualization would be especially painful as every one of those
> "host" CPUID invocations will trigger and exit from L1=>L0.
> 

Agreed, but all of the required data is by Linux cached in 
xstate_offsets, xstate_sizes and xstate_comp_offsets; moving 
xstate_required_size to xstate.c and skipping the host CPUID would 
probably be a good idea nevertheless.

Paolo

