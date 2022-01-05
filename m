Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD55485216
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbiAELy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:54:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231766AbiAELy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641383697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAoXt55k6bjaDtUUwkzXgKzyGKHY2KEKPJyhFtkoMeg=;
        b=JPWNZ7A9Sc4iTD0KLjHkFi/0dd2QP9B5OKkBplXjpgnZRiZqkfVVJu9Dt1MWpj5xySMtfN
        qB7coaHHLw06azMY/5EjgUpoFzEEDOYUUNMLsquGueW7NtBABcr2vjFafaijhPh09PkWYS
        pWAMqdc+HmbvO358nw5Qxmy0dQL7fvk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-KkTyp4f-P46TOSzUzRhI3A-1; Wed, 05 Jan 2022 06:54:56 -0500
X-MC-Unique: KkTyp4f-P46TOSzUzRhI3A-1
Received: by mail-ed1-f72.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso4956615edd.22
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 03:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aAoXt55k6bjaDtUUwkzXgKzyGKHY2KEKPJyhFtkoMeg=;
        b=sPA5lt4Ckr18A+T/kISslbv44n1/ClKb4iaTnzDvhJrNoMgi9soLp3Yc0zoQNb+98A
         qxQh/p0W+RSXi/06WG3Z8XQ7V2lrmlpu6KB5ScfaFeYwUmX+ui10ZB6omooaCJ8frsju
         4CkgPXGiMyHK338+jn8snrJ6uVHS4k63XdXPJMKo36pHIeLv0sNRxj2SFD5RmiyZ1RSS
         NU5GQ5TWVr264wluU81whC9K5GoiQNnjzAgGkDpJ1tJshKxv446a8LZxPdWxBLyjXhVK
         AaK4gsy/2qPFHRTujuOLOYFI+qYY7FHU7nKZNL3HY+kVyLtRs/jQuIMHj4pUQ3FOXhD7
         A10Q==
X-Gm-Message-State: AOAM533WEsDL28ZdgjcuBl+SyMFEAW6YAp1OkbxijNJFLcx5w8XqtEBB
        U9uP+CY3l0CMJZwIIjorOna+yUbPJhzamGJeog0QGyOJWQ9b9tm8u5Q5BE2IFtqXuRUmsnK7TPz
        oppbJ36L+lJe+x9wpcXG5nWpF
X-Received: by 2002:a05:6402:ca6:: with SMTP id cn6mr31077592edb.134.1641383695521;
        Wed, 05 Jan 2022 03:54:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLThERT6lJIyl3ORC8aXUxR59uN40IfnEPIcXx69NdeTRY4dRecmfZ19cwhwWx4EdNIOKePw==
X-Received: by 2002:a05:6402:ca6:: with SMTP id cn6mr31077566edb.134.1641383695299;
        Wed, 05 Jan 2022 03:54:55 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id h18sm15738239edw.55.2022.01.05.03.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 03:54:54 -0800 (PST)
Message-ID: <ee5811a7-55a8-158a-7454-7166c045dbc3@redhat.com>
Date:   Wed, 5 Jan 2022 12:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 3/5] KVM: SVM: fix race between interrupt delivery and
 AVIC inhibition
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20211213104634.199141-1-mlevitsk@redhat.com>
 <20211213104634.199141-4-mlevitsk@redhat.com> <YdTPvdY6ysjXMpAU@google.com>
 <628ac6d9b16c6b3a2573f717df0d2417df7caddb.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <628ac6d9b16c6b3a2573f717df0d2417df7caddb.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 12:03, Maxim Levitsky wrote:
>> Hmm, my preference would be to keep the "return -1" even though apicv_active must
>> be rechecked.  That would help highlight that returning "failure" after this point
>> is not an option as it would result in kvm_lapic_set_irr() being called twice.
> I don't mind either - this will fix the tracepoint I recently added to report the
> number of interrupts that were delivered by AVIC/APICv - with this patch,
> all of them count as such.

Perhaps we can move the tracepoints in the delivery functions.  This 
also makes them more precise in the rare case where apicv_active changes 
in the middle of the function.

Paolo

