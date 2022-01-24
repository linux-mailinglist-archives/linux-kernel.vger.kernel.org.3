Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A972497C57
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiAXJpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:45:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234440AbiAXJpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643017521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmXv04fnyoP4zoPNtf6cFMWSBMwmJY5rreRBLuTuJUU=;
        b=gmZlJUpvRozbT1SWLiFUvdczqJjeyWezk0rhbqDQR3DOlQAAyoTlyB5KcB4c6AxvzaKQxB
        vczdT99ZdhYCrun+PW8MHXK7d7lU4CEUHvWHaDMF1eeZ7bonlxpUbJ0y+d1gVUmq8JWybN
        lwHAmDre8esBEXkKiD1x1q+p8QpDtbU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-k_YkFqCZMEy5nLEAgorytQ-1; Mon, 24 Jan 2022 04:45:19 -0500
X-MC-Unique: k_YkFqCZMEy5nLEAgorytQ-1
Received: by mail-ed1-f70.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso12858676ede.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zmXv04fnyoP4zoPNtf6cFMWSBMwmJY5rreRBLuTuJUU=;
        b=M1eV0arSG1TSQTH9/b/EYO2goGuj0UY8ZPPBqXUQLlPEVuYrfLd2GH5d+azpToDN7l
         ruLqtgX0Yk2sLKdS9ZtabUOvhxRB7yikGbkN8b8ZZO/zkS75ZY7LjSLQINnfsG+9csm+
         AHXVFYVDJBU0yoBel5oihsyuYfqT++XE/I8/JBX//+/3dbXqTwsm6+demumdJN83ZBoA
         NuGDRdgslSbJMo8lWDn+tcTeAi1ecapbHodm3kg+dmLXFlZeK7vs+1thesTn/+tALYss
         Rs6XZIXg93PHM4zhZpyRWBEPyCF3Zg1Yp+oG6loePOcd+OlVXj4iCR8PFXDYdEGjugbg
         dlzg==
X-Gm-Message-State: AOAM533pHEmilhiMHwELuXURo8WspKVbGjdePSMX5bz+bszk0j43rZmy
        OcW6FMDgoyKRkZpNQlfHMRbwfkY6Cc15NyPYFgLnxNrOrh7/u4JbHkZU/yB69rzW0apJ6luUBns
        sgfzM8Wvtha7K38aTC9bxKNkA
X-Received: by 2002:a05:6402:268b:: with SMTP id w11mr15342283edd.295.1643017518230;
        Mon, 24 Jan 2022 01:45:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2BCgX8pFoXJr0DJ/b91j2pd+AAtD5YwhbxryYX4X2eWRf+2RlG8doduaIrPw4KqXBgD8nXg==
X-Received: by 2002:a05:6402:268b:: with SMTP id w11mr15342274edd.295.1643017518086;
        Mon, 24 Jan 2022 01:45:18 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id u3sm4671237ejz.99.2022.01.24.01.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 01:45:17 -0800 (PST)
Message-ID: <1d5ac5a0-2f7a-c79a-3775-a41429e2ec5f@redhat.com>
Date:   Mon, 24 Jan 2022 10:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 2/5] KVM: x86: Move CPUID.(EAX=0x12,ECX=1) mangling to
 __kvm_update_cpuid_runtime()
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220121132852.2482355-1-vkuznets@redhat.com>
 <20220121132852.2482355-3-vkuznets@redhat.com>
 <2ba86d3f-5ab2-af2f-1f7d-ba2d6b7e78d2@redhat.com> <878rv8jiag.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <878rv8jiag.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/22 09:17, Vitaly Kuznetsov wrote:
> Thanks,
> 
> there is also a change in "[PATCH v4 3/5] KVM: x86: Partially allow
> KVM_SET_CPUID{,2} after KVM_RUN" where I switch to memcmp (as suggested
> by Sean). I can send an incremental patch if needed.

Sure, thanks!

Paolo

