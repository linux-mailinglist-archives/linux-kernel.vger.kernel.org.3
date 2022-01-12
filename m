Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0E548C2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbiALLEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:04:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239350AbiALLEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641985474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQRmWQJO7h35wGy22fa7tdbvt7nutmZtPTdgCQaUOQQ=;
        b=ZMk023g4XJaPW8MzWRFaY/W4dbmo8E8VbCjA82gkRaSzkJ++v615edZJOdGW4DKgPsdNi9
        VgPnQFFPJW8/qkSALIodu0874lSzDny5suxIobURJGDWHDO9tD2kDvRCJnJf47djP24wAw
        uwZkrw25mi/q989dSJuuzLR7GPpFhJI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-yFlQCGPVP2alIVAGwweVMw-1; Wed, 12 Jan 2022 06:04:32 -0500
X-MC-Unique: yFlQCGPVP2alIVAGwweVMw-1
Received: by mail-ed1-f72.google.com with SMTP id ec25-20020a0564020d5900b003fc074c5d21so1902903edb.19
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=eQRmWQJO7h35wGy22fa7tdbvt7nutmZtPTdgCQaUOQQ=;
        b=DyLrYXKkIzvw5Af/LY/3Tq4Rg5YpKMBBw4T74DX7bnrx7tcONRRrgf2ykr3TeHfgPr
         caSdLcSEhUM+cgsQg3L7dgeC7Jgi0k2jZoJcIY+149zvSclxSxl/UhP+FmW31FME9+xI
         1ETqtXQ8Y3X975gYh+kvjAr7QN5TyUE0D1Kr27jxx3/xhQvso1qO1ubewHn7w9HPldTg
         RBnnyDuJnjCypfDBCKTuNwZxcVkwzmKd4BEbAVe7/Ml61DFJse+iqlkrtljDlORoHq1h
         QoiQBIskT3RgrD/ycf0CKi+PdqdV1O7CfzA1neHAdGMeyOAq4sJs8MTbCoIRrOpjZOzl
         3R6g==
X-Gm-Message-State: AOAM533Y+KtHKYycR8YXvisgvF7AtFHVrqliBsLN1rTqKcySc1JtGq3e
        DQuocO83H3fxNR+ZKKY0RL/kkOedztgxzYFwwBKr8fJIrCDr7n7drP9V5zRXvYSSHuGWDMet12v
        Fd2DVlAtrhqtbShDXhd6EVUAS
X-Received: by 2002:a05:6402:486:: with SMTP id k6mr8580288edv.330.1641985471847;
        Wed, 12 Jan 2022 03:04:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLu6iWsDVwPl07dmV9nmwCMbbplxs+ZFDOgPiX/VhbSWFK2LAa03DeMHirncilimRMIa9S6A==
X-Received: by 2002:a05:6402:486:: with SMTP id k6mr8580274edv.330.1641985471689;
        Wed, 12 Jan 2022 03:04:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec? (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de. [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
        by smtp.gmail.com with ESMTPSA id qw4sm4413621ejc.55.2022.01.12.03.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 03:04:31 -0800 (PST)
Message-ID: <970ca2a4-416d-7e8f-37c7-510c5b050f4b@redhat.com>
Date:   Wed, 12 Jan 2022 12:04:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 3/8] mm: migrate: allocate the right size of non
 hugetlb or THP compound pages.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-4-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220105214756.91065-4-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.22 22:47, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> alloc_migration_target() is used by alloc_contig_range() and non-LRU
> movable compound pages can be migrated. Current code does not allocate the
> right page size for such pages. Check THP precisely using
> is_transparent_huge() and add allocation support for non-LRU compound
> pages.

IIRC, we don't have any non-lru migratable pages that are coumpound
pages. Read: not used and not supported :)

Why is this required in the context of this series?


-- 
Thanks,

David / dhildenb

