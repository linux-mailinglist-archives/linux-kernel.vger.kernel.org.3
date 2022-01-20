Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980D749533E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiATRae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230486AbiATR3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642699771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fGfF78FiR/TzahdqKpCXizGLCvDzp3FWHvuTZrk93bk=;
        b=SlJzSBpkK8dnhDHxdGBe9NHnWTnADpf+fft8HmFBfjG56NnZfZTSlhSWz1sL2OsCGzcazG
        hUM9HedSgYPwlKwQxY1rxFXt+EitJrM6aM+AHOwT/jJaL5rQfcL8bh9d3ErjVLgH68+bOJ
        BuffdLJbr3rATvwW/G6+Q5PGtfzLFd8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-aLP9_HRXMQqWu-9DzwhrYg-1; Thu, 20 Jan 2022 12:29:29 -0500
X-MC-Unique: aLP9_HRXMQqWu-9DzwhrYg-1
Received: by mail-wm1-f72.google.com with SMTP id j6-20020a05600c1c0600b0034c02775da7so3224195wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fGfF78FiR/TzahdqKpCXizGLCvDzp3FWHvuTZrk93bk=;
        b=03P7tOCDnc25/KfI1f0zmHSXeXs1Ro4SCufWkhvNGyw4JZFk1nRLxtupwMge4m175G
         8ObgHF3IdOQN3FZbPBCk3wCm1+T+zOIe5yKyCBmkGxEUQMWuoPHa9waeosYvO198hC54
         ZahjHQp3GHi8u8nqfRrrjSyOMr7SAULdHFw7Z0Ci5wD1aGJI/S0iUhIYpOQ0gY2oT+dH
         1lx+7fJ68VJzTYanr46NKA4Mi3CCCvUwqFMSl5rO7gDRfhQUE3yIZIjeQ3EltnjvePd1
         ug3jWEgOGqdS11bifaNnYnEV5spSVacHH64zrwk4APOJHZrJIZNUh9yeDWV+K14TkVSW
         TdfQ==
X-Gm-Message-State: AOAM530R18AbpYC8pMM/6R41Ymk5LaXRQHDN0L3kjsZjLja/Cq2xhoWo
        KmtboSql/ASA+BKQBZqy+NyZt8mQRwso3mOwSTpBMPGUVfrCFKM4Mva3UmXC2R0sGCJ8cQZqDXf
        kcYfz07o1aAT7I4saSsXMBRfB
X-Received: by 2002:a05:600c:502a:: with SMTP id n42mr10159475wmr.17.1642699768475;
        Thu, 20 Jan 2022 09:29:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOLpt9bWrFi8wq1OKXWM943uI9rcK9LKtFK7tuoO5lzYUIgZU9u0GfBs1pC7CiHnudNbuldA==
X-Received: by 2002:a05:600c:502a:: with SMTP id n42mr10159460wmr.17.1642699768245;
        Thu, 20 Jan 2022 09:29:28 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id f9sm3958172wry.115.2022.01.20.09.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 09:29:27 -0800 (PST)
Message-ID: <f7413789-f6f2-612e-2323-bf35afdb8a02@redhat.com>
Date:   Thu, 20 Jan 2022 18:29:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 4/7] kvm/mips: rework guest entry logic
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aleksandar.qemu.devel@gmail.com,
        alexandru.elisei@arm.com, anup.patel@wdc.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        seanjc@google.com, suzuki.poulose@arm.com, svens@linux.ibm.com,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-5-mark.rutland@arm.com>
 <20220120164455.GA15464@C02TD0UTHF1T.local>
 <a2b628b4-907c-4e15-df91-18c0db099228@redhat.com>
 <20220120171551.GB15464@C02TD0UTHF1T.local>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220120171551.GB15464@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 18:15, Mark Rutland wrote:
> As above, we'll also need the guest_state_{enter,exit}() calls
> surrounding this (e.g. before that local_irq_enable() at the start of
> kvm_mips_handle_exit(),

Oh, indeed.  And there is also an interrupt-enabled area similar to 
s390's, in both vcpu_run and the exception handler entry point (which 
falls through to the exit handler created by kvm_mips_build_exit).  For 
example:

         /* Setup status register for running guest in UM */
         uasm_i_ori(&p, V1, V1, ST0_EXL | KSU_USER | ST0_IE);
         UASM_i_LA(&p, AT, ~(ST0_CU0 | ST0_MX | ST0_SX | ST0_UX));
         uasm_i_and(&p, V1, V1, AT);
         uasm_i_mtc0(&p, V1, C0_STATUS);
         uasm_i_ehb(&p);

I'd rather get rid altogether of the EQS for MIPS.

> and that needs to happen in noinstr code, etc.

There are bigger problems with instrumentation, because the 
runtime-generated code as far as I can tell is not noinstr.

Paolo

