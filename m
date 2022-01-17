Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB544903B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbiAQIY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:24:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235385AbiAQIY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642407897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T00R205fMcHWKdEH+b98ldDIpd3jWVFkDTPCDk3okwc=;
        b=W4OhCUpzRL766/oOru7Ul+5LYEyk0vqFItcyaeuAAx8oJ3HLgiuOvlLxe41Y79GNhWza31
        bU3BXnWo0UhpW9Lym+O4juhRymKXLuPA81h2OfspwWSs2hBLkWEQWihnzetaVq2II6EQ4J
        3gtC3TSl0PynTz6Xy/aH26fruI1Ed3A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-D0-vHRgPMQKE6sXgthyYhg-1; Mon, 17 Jan 2022 03:24:54 -0500
X-MC-Unique: D0-vHRgPMQKE6sXgthyYhg-1
Received: by mail-wm1-f70.google.com with SMTP id w5-20020a1cf605000000b0034b8cb1f55eso4417783wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T00R205fMcHWKdEH+b98ldDIpd3jWVFkDTPCDk3okwc=;
        b=dVl926BB989Vfu/SZnC+VO7Y1vtQPybKdaDsVEoQyVC0cYNpRPuNIjEdcNSYT7PaFs
         PJhOt0MfxdCCF0Vl9WDVvU8VR0B4c3KD2Ex3KifCYKTqu+/AtoootwssKBFqV2sbS0hm
         c02XUFoeBXGiyGXgfscPzN1rdp9cC0Q5kMiI5ERBxiveJmboF2vJvaGzc2Pxx4ijk9TI
         bEJS2fHKvpmMwB+4gI84jATRAF/QCx6n7YwMQcXjRqEPLD72av5a4QQsShe19AzYUdUb
         tUcxKnfhICYVF1oFoXELW1f33q+O9EuTrpE5Ov1wdAWGEM33QCmiejlxTBm+5xlHtjyy
         vVsQ==
X-Gm-Message-State: AOAM533af3A6txZx5pywY3gpe/nEM1bLowGlkEa60iRiQNbIAIZyzbzI
        4wx9TiYHypCiigKHdP8RlB8kEgontPZtUUIVsZQvoVEhFTVK9J0owiMXx30vF944EcfXKkluYwS
        QEddeWpMG2uDkRP21DUG10c69
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr2248803wmg.80.1642407893040;
        Mon, 17 Jan 2022 00:24:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUKnXP8oRbBQDA2P6gdWm6LKpC7mpJNhzJ5rCEjq+zEvjWjRdy+wBTEKY/CoHkLzURbBJgMQ==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr2248787wmg.80.1642407892801;
        Mon, 17 Jan 2022 00:24:52 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id i10sm16692176wmq.45.2022.01.17.00.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:24:52 -0800 (PST)
Message-ID: <af5c41af-d54d-a1ba-094b-9174311e9cdd@redhat.com>
Date:   Mon, 17 Jan 2022 09:24:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] x86/cpufeatures: Move the definition of X86_FEATURE_AMX_*
 to the word 18
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jing Liu <jing2.liu@intel.com>, linux-kernel@vger.kernel.org
References: <20220117062344.58862-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220117062344.58862-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 07:23, Like Xu wrote:
> We have defined the word 18 for Intel-defined CPU features from CPUID level
> 0x00000007:0 (EDX). Let's move the definitions of X86_FEATURE_AMX_* to the
> right entry to prevent misinterpretation. No functional change intended.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

