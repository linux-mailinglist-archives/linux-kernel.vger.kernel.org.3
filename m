Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D313499982
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455564AbiAXVfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:35:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1392240AbiAXUuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643057451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5c5UK/SJnH0GNmhSmScmYGQtLKcq6CRrf3IVpkQpYk=;
        b=bERgZotDNF3uBtRN5dm90botcvVebA2zmgOmHu9iGk32hDGiTvA+Yk/P4JFKSNngyehMkT
        cPR85KPlL7Pmfm0YPbBnbSwzPFVoMIXK/dSC2K64ds5rWFVbCkwrnfzeXU5F3fyXCG9Lz4
        BOI8Cvb+sfjJAwesaxu5ATB9pHtdG3M=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-FaeU1DAhMQmTHL3PgqhTjw-1; Mon, 24 Jan 2022 15:50:50 -0500
X-MC-Unique: FaeU1DAhMQmTHL3PgqhTjw-1
Received: by mail-oi1-f197.google.com with SMTP id r17-20020a056808211100b002cda6863beaso1641551oiw.14
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W5c5UK/SJnH0GNmhSmScmYGQtLKcq6CRrf3IVpkQpYk=;
        b=sI1Gy6R4ub3LYOSMkw26zqxxs6yTzu/fjlXC1rkxJj+ZMIN9qKI8ykjXtha9AhkGYe
         YNtTirY5Ol28WMwG/WDdUToz2czrCYxbH4qIKX7xmgBkDqeepxY1py0ZPCj68BshXJet
         htq16gpFcm6b70WokmSd3EhN+HALL5mytAomhdrfCIuWSf+hli+oIZx69TnMMI2bQlY3
         illE+2gZ5Uhl2oLwB/tv/YiS5NZIEWPRqbtzyPQCW+LBvehc6dSDhOojXsTU7ywcWWTB
         /PeG6488AIskZchpm0gq+uGkwXqUkAEtKPU1nt7z6IwO81U6beidfBoFWMT3yXSCJ7wf
         G3fw==
X-Gm-Message-State: AOAM530OQVLx6GwBYFeF1h1C1OqZbZuVyfGlWCvAlbeGFHlo6zkLVpkY
        8JhAoRsWSNp2ZAV7di1wBbBQhK0odv+r14j8UeTLXxMP2nh+LHfvukqr5EocFd/7e8KQQqNHOCn
        KvYOocFve+3lT0UvLdF+bVtRfYNWSCX78v35v+gFuH+H8MyvOTPaP3Xl7XNEZssj4UhYyxog=
X-Received: by 2002:a4a:4584:: with SMTP id y126mr4402248ooa.80.1643057449485;
        Mon, 24 Jan 2022 12:50:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAYU9XhxKMknK71q/gt6tjzBlHExLAImx5gFnEHVWq6mED4gVTXkTaRslPZ563SVTMYqb27g==
X-Received: by 2002:a4a:4584:: with SMTP id y126mr4402228ooa.80.1643057449212;
        Mon, 24 Jan 2022 12:50:49 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s11sm2531756otq.69.2022.01.24.12.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 12:50:48 -0800 (PST)
Subject: Re: [PATCH] lib: zstd: clean up double word in comment.
To:     Nick Terrell <terrelln@fb.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220120132006.749016-1-trix@redhat.com>
 <BFE23560-5B80-4876-9FAA-726E0E9AADC1@fb.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0e972d79-aeb0-670f-ba1f-0adea7306084@redhat.com>
Date:   Mon, 24 Jan 2022 12:50:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BFE23560-5B80-4876-9FAA-726E0E9AADC1@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/22 12:18 PM, Nick Terrell wrote:
>
>> On Jan 20, 2022, at 5:20 AM, trix@redhat.com wrote:
>>
>> From: Tom Rix <trix@redhat.com>
>>
>> Remove the second 'a' and 'into'.
> Thanks for the patch!
>
> I'll merge this into my tree and get this into the 5.18 merge window.
>
> If you are able to, can you please submit this patch as a PR upstream [0]?
> Else, I will backport it before my next update. Either way I'll merge this patch.

yes, here it is

https://github.com/facebook/zstd/pull/3026

Tom

>
> Best,
> Nick Terrell
>
> [0] https://github.com/facebook/zstd/blob/dev/lib/zstd.h#L1396-L1407
>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>> include/linux/zstd_lib.h | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
>> index b8c7dbf98390f..6b91758b61af9 100644
>> --- a/include/linux/zstd_lib.h
>> +++ b/include/linux/zstd_lib.h
>> @@ -1330,7 +1330,7 @@ ZSTDLIB_API size_t ZSTD_generateSequences(ZSTD_CCtx* zc, ZSTD_Sequence* outSeqs,
>>
>> /*! ZSTD_mergeBlockDelimiters() :
>>   * Given an array of ZSTD_Sequence, remove all sequences that represent block delimiters/last literals
>> - * by merging them into into the literals of the next sequence.
>> + * by merging them into the literals of the next sequence.
>>   *
>>   * As such, the final generated result has no explicit representation of block boundaries,
>>   * and the final last literals segment is not represented in the sequences.
>> @@ -1377,7 +1377,7 @@ ZSTDLIB_API size_t ZSTD_compressSequences(ZSTD_CCtx* const cctx, void* dst, size
>> /*! ZSTD_writeSkippableFrame() :
>>   * Generates a zstd skippable frame containing data given by src, and writes it to dst buffer.
>>   *
>> - * Skippable frames begin with a a 4-byte magic number. There are 16 possible choices of magic number,
>> + * Skippable frames begin with a 4-byte magic number. There are 16 possible choices of magic number,
>>   * ranging from ZSTD_MAGIC_SKIPPABLE_START to ZSTD_MAGIC_SKIPPABLE_START+15.
>>   * As such, the parameter magicVariant controls the exact skippable frame magic number variant used, so
>>   * the magic number used will be ZSTD_MAGIC_SKIPPABLE_START + magicVariant.
>> -- 
>> 2.26.3
>>

