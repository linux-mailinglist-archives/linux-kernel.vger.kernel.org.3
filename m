Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190C949B4F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386615AbiAYNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1385378AbiAYNTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643116748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nw6/P4vFvvsk6C4bAS0kt4Nq/2orgfJm/8P78VRSln8=;
        b=OINu0tXjJyl2T6cLYaSJD58tkMtpg+Az4VLC48yroNQeJt7w9E6E9UzZGNlQ6dDaE3f2CH
        LJd41rM9ywYt9NKtHBfPym1oRa+gC5jNhI/QzjDWPlQkxaNpOhoAC2yoQE0DGrAXtW7sZD
        xKi4AwPEOoPXzRWen1JDSdnumMXkC2E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-CT81lrWwOvarZbzjdKCIwg-1; Tue, 25 Jan 2022 08:19:07 -0500
X-MC-Unique: CT81lrWwOvarZbzjdKCIwg-1
Received: by mail-ed1-f70.google.com with SMTP id h21-20020aa7c955000000b0040390b2bfc5so14888287edt.15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nw6/P4vFvvsk6C4bAS0kt4Nq/2orgfJm/8P78VRSln8=;
        b=1/OjyMg0PBOQiGI98zTT3oHx5e2IsnM/LDlzIvsSp70HqX/Wv1JaE43DsZyFVtsYcg
         x3eMMzwubUBfgfnGlW/sl5gd3ITfkXJ+1sA/RUewOzWij52jhQKb/zpt8/kzR+zGkW8s
         4z37YxlLmH4simculB1u9RuSlj6MA/vqmoEQ1CaTHoJ9J2hA96rnaC14WVcwLuXemrsy
         6UvT+iMji+ZtHWWou2AUKVFlzGHoXggMHyBfnauZV8+w9pTsvaw/eMwrIATzE6AhDdI6
         wLZG+R48PDEH2P0yG3V1fsWO7qRp/glPaJSVnqNFkEI8yaqkJyQwGUnzE84TSrYi+Nfc
         pw1w==
X-Gm-Message-State: AOAM5316DTOFp8e6iRQjSWeeILuWML6knwZ/L7Pa/56lju80PMGApRGd
        Zf6EeMxC9ZTt3vFdXKDTRMl5fi2XuAKE8yGUuHYWeTULQH9+ks7/tJup0oaU4V3pOPxcrJgkv4b
        Ynd/JfNbu7UmaKay/7LNDpvm/
X-Received: by 2002:a17:907:d07:: with SMTP id gn7mr16409836ejc.575.1643116746360;
        Tue, 25 Jan 2022 05:19:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyw5RW8Nh2bZKDlZodVPV9SulaXaDHTqbUkgiy0r0JjRo0OABJCVp63qdCsEhkiHdy6HcIvA==
X-Received: by 2002:a17:907:d07:: with SMTP id gn7mr16409827ejc.575.1643116746154;
        Tue, 25 Jan 2022 05:19:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8000:9797:8f:1ed9:7596? (p200300cbc70f80009797008f1ed97596.dip0.t-ipconnect.de. [2003:cb:c70f:8000:9797:8f:1ed9:7596])
        by smtp.gmail.com with ESMTPSA id o11sm8214857edq.5.2022.01.25.05.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 05:19:03 -0800 (PST)
Message-ID: <fccf697d-919e-8e99-ea08-3ab991b610eb@redhat.com>
Date:   Tue, 25 Jan 2022 14:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Content-Language: en-US
To:     William Kucharski <kucharsk@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        willy@infradead.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <E44A9AB1-DBF0-4B8E-B049-293DD4DE6093@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <E44A9AB1-DBF0-4B8E-B049-293DD4DE6093@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.22 13:09, William Kucharski wrote:
> I would think this should be the case; certainly it seems to be a more effective approach than having to manually enable sharing via the API in every case or via changes to ld.so.
> 
> If anything it might be useful to have an API for shutting it off, though there are already multiple areas where the system shares resources in ways that cannot be shut off by user action.
> 

I don't have time to look into details right now, but I see various
possible hard-to-handle issues with sharing anon pages via this
mechanism between processes. If we could restrict it to MAP_SHARED and
have some magic toggle to opt in, that would be great. Features like
uffd that we might soon see on some MAP_SHARED pages will require to not
share page tables automatically I assume.

-- 
Thanks,

David / dhildenb

