Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6154A5C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiBAM0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:26:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236574AbiBAM0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643718369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOsQ7tCjggbyJsap3yPkhYLBomgSptsnuwvSsGz14Vk=;
        b=hmmAluwcTx2cd2SyXrjyv3T18yfHpKTQLNISVAzb2jmRQKK9qWNgvc3Nj/KgEWxrpz5Nm4
        v8A5mbWCABKWNNYxkQAM6GYyCsw4ZwKyxl93bHL3W1zW2xeyy/XLBxuFKOpmd6BDzpgDoy
        YEzUbgUdjdAZei3+8oRx0fpXLMER1a0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-twnniAk5NjeJWpIFl5y92w-1; Tue, 01 Feb 2022 07:26:08 -0500
X-MC-Unique: twnniAk5NjeJWpIFl5y92w-1
Received: by mail-ej1-f71.google.com with SMTP id q3-20020a17090676c300b006a9453c33b0so6405835ejn.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 04:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZOsQ7tCjggbyJsap3yPkhYLBomgSptsnuwvSsGz14Vk=;
        b=vAxB1tbKBp3FiexGYYzJXZEoQ+k79ylZwwazD0K3FDdjNVxohpbR6j2Kjk5o2aXqhY
         /zANXfe17+iVKFefp9MeGgA55IVLttKm6bU4LnQ0VfgOhxv84Aft2NyGrQKJ2IVGljza
         hd8uU6I+jkR9ksjULJP9vsps6wgheKEi4xCF4HK1NeLYX1K3zRBj/UBY44iCJ418/cFl
         A+qBMMA7b0bakoeVn35vUJ3N8NA9CwBzsTdYqAunohJLX5QqIk2fwGQt2MNPZQwHxqfv
         nNpAd687mM5il/t4WGBXJ+wd0gsdV5kHRElBD2+8bG2fJjrcAklkG5C90ogecDY14JiL
         kEDA==
X-Gm-Message-State: AOAM532MhvoaDtgQkg5sCd9Dbb1fCk0xNGRX4gww4sNfreoevEaFoovm
        He5hs6J06scztXFCfReTmUCv0Ot6Bjc8NEWSYLlsYtczOexPMpD3DsdUax6v8NNH862LJNDGgXc
        ge7juryvAOg72/YDctdY2rbGr
X-Received: by 2002:a17:906:cc54:: with SMTP id mm20mr19996349ejb.313.1643718367518;
        Tue, 01 Feb 2022 04:26:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHXhxwLpXav5KTYsLp1XBTl+8R3PESRejFZhEZXppgLCXd4Ex7CZ9M9KE024cKby9FudzbrQ==
X-Received: by 2002:a17:906:cc54:: with SMTP id mm20mr19996335ejb.313.1643718367349;
        Tue, 01 Feb 2022 04:26:07 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id d5sm14481372ejr.200.2022.02.01.04.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 04:26:06 -0800 (PST)
Message-ID: <6690a921-5df7-5c31-e115-96b89cc5057e@redhat.com>
Date:   Tue, 1 Feb 2022 13:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH kvm/queue v2 1/3] KVM: x86/pmu: Replace
 pmu->available_event_types with a new BITMAP
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>
References: <20220117085307.93030-1-likexu@tencent.com>
 <20220117085307.93030-2-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220117085307.93030-2-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 09:53, Like Xu wrote:
> +/* Mapping between CPUID 0x0A.EBX bit vector and enum perf_hw_id. */
> +static inline int map_unavail_bit_to_perf_hw_id(int bit)
> +{
> +	switch (bit) {
> +	case 0:
> +	case 1:
> +		return bit;
> +	case 2:
> +		return PERF_COUNT_HW_BUS_CYCLES;
> +	case 3:
> +	case 4:
> +	case 5:
> +	case 6:
> +		return --bit;
> +	}
> +
> +	return PERF_COUNT_HW_MAX;
> +}
> +

Please use an array here (e.g. cpuid_event_to_perf_hw_id_map[]).

Paolo

