Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FA847BC11
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhLUIqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:46:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235786AbhLUIqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640076412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZk6+BHjdh3P9084Tou7Ooqh6nDjDABDkvC7zaszK0w=;
        b=fuhvQ+yf1RYc3KWkBKyJ9qyhSxr1zkQrfD7KrOvgpikWPemvcV2UhIBm7Q1Bilu8PhZvP6
        nXljV0TCQ7zeI0BDo6bbKdbTBjALfUc/k++j9zE+AMyveEVBLxqbujVgE4Yiu/kjoUovbp
        +9pC4N7es8l4FeHyOeU75qtwYnItQqg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-FJeyfhI0Mh-bHaMsHcLVRA-1; Tue, 21 Dec 2021 03:46:49 -0500
X-MC-Unique: FJeyfhI0Mh-bHaMsHcLVRA-1
Received: by mail-wm1-f72.google.com with SMTP id b75-20020a1c804e000000b0034569bde713so933647wmd.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 00:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MZk6+BHjdh3P9084Tou7Ooqh6nDjDABDkvC7zaszK0w=;
        b=iQ0i2+SPb2pdp+Aqw15qloQk09YRLeWcK6MI9KBhtCWjdGNBedKImJyrpiwHZGHoXG
         Nk2z2PYMIEUm2lvb3Mu6/vb2vLsL1coO3NJxOPFsQ8/8nDRk6Dfr2mLsL2VjUCfTEWnW
         60U279YCz/4hMoA3YhXMibU2dwCpGdtPCJeajV5hcDIk5LfQBVErL03zfdrDRsad71PL
         bW2u+kYcpWkX/Wuodp4z/104nMj2xjgsh1e7qiuOFcuSow5WnE2XZBcXDJujHYNOboXS
         bwqUJh0n/s2o/NSDD0Su3nma5QYXcaOelXFC2t/JUnFlSxhK0AasKSHbUZVKvUQXm06V
         RKQA==
X-Gm-Message-State: AOAM533gEkdKpAJFGGzrCQOd1V6+zBTelFzvVw8klERB5zyUSohlXpWC
        S89oZ1CjaTl/o6Kh7XHTJwyrhSkvsTRNRWur59hSzGYbdq9LkkIl+ETbNY+k/k6NxgKnj5aYfNJ
        By+1XhFFc9Jx94I8fRa5HzANj
X-Received: by 2002:a05:600c:6009:: with SMTP id az9mr1754780wmb.32.1640076408033;
        Tue, 21 Dec 2021 00:46:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmnBZwI36XasGXlIbCL5DTmyAMHj70U6oBHzNIjWPE5ThZfSWfUSt0bapqZyKde4pus4iMhA==
X-Received: by 2002:a05:600c:6009:: with SMTP id az9mr1754765wmb.32.1640076407872;
        Tue, 21 Dec 2021 00:46:47 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id p13sm1684921wms.41.2021.12.21.00.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 00:46:47 -0800 (PST)
Message-ID: <015e7a47-19b1-9bee-14ff-c3ee4739a59c@redhat.com>
Date:   Tue, 21 Dec 2021 09:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 22/23] kvm: x86: Disable interception for IA32_XFD on
 demand
Content-Language: en-US
To:     "Liu, Jing2" <jing2.liu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "Christopherson,, Sean" <seanjc@google.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
References: <20211217153003.1719189-1-jing2.liu@intel.com>
 <20211217153003.1719189-23-jing2.liu@intel.com>
 <6e95b6f7-44dc-7e48-4e6e-81cf85fc11c6@redhat.com>
 <MWHPR11MB1245BC0FA24DE0565D6952AAA97C9@MWHPR11MB1245.namprd11.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <MWHPR11MB1245BC0FA24DE0565D6952AAA97C9@MWHPR11MB1245.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 07:42, Liu, Jing2 wrote:
>> Please instead add a "case" to vmx_set_msr:
> OK, it seems the passthrough setup is preferred in vmx.c.
> Do we also want a case in vmx_get_msr (for patch 11), even though
> no specific handling there?

No, thanks.

Paolo

