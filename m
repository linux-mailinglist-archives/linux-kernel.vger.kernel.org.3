Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6647CE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbhLVIaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:30:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237931AbhLVIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5R13w0zfTN1gfH0nX3lNZrmWuAI/MqkwgiuEDiE6RY=;
        b=XZsZWTIY/2viV+nDWxUICzOhspqgBGua3i0VaPU6LtnUB4eA/eoylR6wUcvZ1e9rUyhTo3
        szjIRhiW/88k+QKHb6KZRQkjOM1TIZMWKvZuf3agiLcpCxJMNwNCxLZPmoLL3snLSmLMUr
        nxTuihVCx676snVz0Jif34XpyuA+tDA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-tONb0uz9NgeycLzrQUoSOg-1; Wed, 22 Dec 2021 03:30:07 -0500
X-MC-Unique: tONb0uz9NgeycLzrQUoSOg-1
Received: by mail-wm1-f70.google.com with SMTP id c5-20020a1c3505000000b00345c92c27c6so404522wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=K5R13w0zfTN1gfH0nX3lNZrmWuAI/MqkwgiuEDiE6RY=;
        b=jI72S4OmISgOe0R/CVHowoD567tGRcONQv3gvkLAxpycuf9wFnm+MtsQnLn2qF3wXI
         VO3mbItUZRg1UabMhXwGhaPrhhrE+hi7mhY9KaETFGfbQhR40NrAbMHLsSDHhwcwJV1K
         7C1VEC+/eG43K5/s43rlpnk8yBCBkdeOg5/cuUNA38jCQPN1vNzedRZBhPdAF8x4+XYE
         tHQ/yJ402VU8pBsJhTjvP6H61mZtmNNeEG6Zfl0TXglhXo1WWegtlAazhmHyEUTBM+gz
         7Vw+/CvCwIdvbu2oh0fzWrS9YT1wpEcRN+th8OVR5PtG7FJma9VMZYgay//b1q3fVqAU
         UrQg==
X-Gm-Message-State: AOAM531XFu/urvkAvAaGcr6S1NCOwJ9d8HVvLvI9+EicJeXT1tZ809nD
        8ppoh8ugGskFlGYDHO58+DajEW3Ko/jtHUsLA95itMwws46iCVqUb/edA5qKK0ODytJZckQyDHA
        yXUeOkL8qsgmepct6LM8uwGLg
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr119029wmh.70.1640161806600;
        Wed, 22 Dec 2021 00:30:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaZ676bBfkbDM9ipvMcx7Mwzr6YXpVK+BGvG7K1IdqnkI9kzwsmGfVYCo0meG5jwXnlGK2Tw==
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr119007wmh.70.1640161806438;
        Wed, 22 Dec 2021 00:30:06 -0800 (PST)
Received: from [192.168.3.132] (p5b0c646a.dip0.t-ipconnect.de. [91.12.100.106])
        by smtp.gmail.com with ESMTPSA id m35sm10660481wms.1.2021.12.22.00.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 00:30:06 -0800 (PST)
Message-ID: <e6d5d38c-c309-5646-84e2-5840fc037a5c@redhat.com>
Date:   Wed, 22 Dec 2021 09:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221235916.GI1432915@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211221235916.GI1432915@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.21 00:59, Jason Gunthorpe wrote:
> On Tue, Dec 21, 2021 at 06:40:30PM +0100, David Hildenbrand wrote:
> 
>> What adds complexity to correctly maintain the "exclusive" state are at
>> least:
>> * KSM (might be harder, have to think about it)
> 
> I know little about it, but isn't KSM like fork where it is trying to
> WP pages with the intention of copying them? Shouldn't KSM completely
> reject WP'ing a page that is under any kind of writable GUP?

I think KSM will, similar to fork(), always have to try removing
PageAnonExclusive() while synchronizing against concurrent GUP pins. If
that fails, the page cannot be converted to KSM and consequently not be
shared.

That will need some rework of KSM  AFAIU, but shouldn't be impossible to do.

-- 
Thanks,

David / dhildenb

