Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27533475CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbhLOQE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:04:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244412AbhLOQEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639584263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+qkhOLxZwUCzoouW57Nu2zO8Pbzn2kT/DzdHBiJ+XI=;
        b=L93H3n7koHctmAVAu5XBdfaq4UYRtBmtY9OWN4k2IDw20gK/2RZqb/+lKbGmvcX5jyrsgF
        fvOK/Zb0BAxwFUsmdiccCM+8cFSsGSL7/AP4jzE/Zvfix9Y0X3dfUTz+Gk/7LddP5Lw3Qe
        zcQQQMyIcecNJp9w6JEbaVxmcL9+qpk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-c3K80wwMPxqoN1uZTRHr3A-1; Wed, 15 Dec 2021 11:04:21 -0500
X-MC-Unique: c3K80wwMPxqoN1uZTRHr3A-1
Received: by mail-wr1-f71.google.com with SMTP id m12-20020adff38c000000b001a0cb286eacso1791596wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=5+qkhOLxZwUCzoouW57Nu2zO8Pbzn2kT/DzdHBiJ+XI=;
        b=O7GS8RHlhLowSGQE5/pOPlyTP1zz7P++SS6r+fPoF28658X6Pk57MhZFpTu0BjUiIT
         Rfjxv6z49bVxrRMPa8GBa1aaqDXzlOdj5eRE3375cjn4p4wi6ac/Ct60UBanSubBp0h+
         GT52Mdb7MRcdkXhjaHwT7PIdGai+qRiAfqHTutJRnegib1RRgO8+XbHgh0Q/nwtVti50
         j8dwS1FldRyVyeb5vUBHMYgGE0stNcM3Qp4r8PGrH4L2lgGMZS9Tu6qL720Ln6kYddvL
         GQFnPcoj6rXzQ20QfYOHvm32u7Bg9OxiYG75q6DlFqpsSUG42QhQRWBL0oTBf3wAbK0V
         1RQA==
X-Gm-Message-State: AOAM530bSzWpLFmFNGzMqV7sT2Elk/HNQdpS8v4qjY6QSnIS3s8V1CgA
        jJSkWciIpEu4ybWJOWURGIvAXTouO+4tHfcuw1zVvGXEegDWC+azBkRMx/4ou487fgsaqNigoJ/
        QGLh5SHnlBIuSMg598wyBF5tJ
X-Received: by 2002:a1c:a905:: with SMTP id s5mr476586wme.85.1639584260226;
        Wed, 15 Dec 2021 08:04:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8+iToR5ZFLyprHiWIwROYMdO2owpbxyBW2o4XlxWdG53Y5ecviQglm6t+MNmZqfkKYVXoiw==
X-Received: by 2002:a1c:a905:: with SMTP id s5mr476565wme.85.1639584260043;
        Wed, 15 Dec 2021 08:04:20 -0800 (PST)
Received: from [192.168.3.132] (p5b0c609b.dip0.t-ipconnect.de. [91.12.96.155])
        by smtp.gmail.com with ESMTPSA id b6sm6684752wmq.45.2021.12.15.08.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 08:04:19 -0800 (PST)
Message-ID: <ccbb3a1f-856c-5879-acbc-fbaff9eb61de@redhat.com>
Date:   Wed, 15 Dec 2021 17:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Cc:     Jianyong Wu <jianyong.wu@arm.com>, will@kernel.org,
        anshuman.khandual@arm.com, akpm@linux-foundation.org,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gshan@redhat.com,
        justin.he@arm.com, nd@arm.com
References: <20211210095432.51798-1-jianyong.wu@arm.com>
 <Ybn4EfweLqKtyW0+@fixkernel.com> <YboRr0BCgjAbYdHe@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YboRr0BCgjAbYdHe@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.12.21 17:02, Catalin Marinas wrote:
> On Wed, Dec 15, 2021 at 09:13:37AM -0500, Qian Cai wrote:
>> On Fri, Dec 10, 2021 at 05:54:32PM +0800, Jianyong Wu wrote:
>>> fixmap is a global resource and is used recursively in create pud mapping.
>>> It may lead to race condition when alloc_init_pud is called concurrently.
>>>
>>> Fox example:
>>> alloc_init_pud is called when kernel_init. If memory hotplug
>>> thread, which will also call alloc_init_pud, happens during
>>> kernel_init, the race for fixmap occurs.
>>>
>>> The race condition flow can be:
>>>
>>> *************** begin **************
>>>
>>> kerenl_init thread                          virtio-mem workqueue thread
>>> ==================                          ======== ==================
>>> alloc_init_pud(...)
>>>   pudp = pud_set_fixmap_offset(..)          alloc_init_pud(...)
>>> ...                                         ...
>>>     READ_ONCE(*pudp) //OK!                    pudp = pud_set_fixmap_offset(
>>> ...                                         ...
>>>   pud_clear_fixmap() //fixmap break
>>>                                               READ_ONCE(*pudp) //CRASH!
>>>
>>> **************** end ***************
>>>
>>> Hence, a spin lock is introduced to protect the fixmap during create pdg
>>> mapping.
>>>
>>> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
>>
>> I am afraid there is a problem to take a spinlock there.
>>
>> node 0 deferred pages initialised in 2740ms
>>  pgdatinit0 (176) used greatest stack depth: 59184 bytes left
>>  devtmpfs: initialized
>>  KASLR disabled due to lack of seed
>>  BUG: sleeping function called from invalid context at mm/page_alloc.c:5151
> 
> Thanks for the report. Definitely a bug, GFP_KERNEL_ACCOUNT allows for
> the page allocator to sleep. I'll drop the patch from the arm64
> for-next/fixes branch for now and sort it out later.
> 

Sounds like we need a mutex then.

-- 
Thanks,

David / dhildenb

