Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3644D1A0F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347347AbiCHOKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbiCHOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:10:50 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4A54AE01
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:09:54 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id c23so21086895ioi.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 06:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbG/qqfr/wurjd2//LUTHT4MZ/YTGKmKEm4o3JLwT/s=;
        b=HvQ65t8feIo0gRSK95UMXEATxi4c4DoYSB6JJZCO8NKipsnwvobh9/vyJW6KnA4Ta1
         d7ZwUmtiJ9X9jqfy4IyCBp4LwwKTbw252gdFl5IvhQiRdHGR+yCENQLl6YhN+Eluw8tQ
         kcsLzGPN/hCZpD3pYKze6xFjB0UPWoHCBjA50sP7SsW7R5wpEeuxbiE3yJhYMEBqJ9bL
         DL4o8ZvmQtB1yX8NmUi3iRxe7s+oVJCKQx4wO7WQnzy96JG53slddSp/RQXUmkWTUPAr
         nRzkkgeolSvSx262NMoqgxSeyHHln9AkpMp2esCK/ML/vQmG2XrTEL8q9aTEd6O62roq
         FPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbG/qqfr/wurjd2//LUTHT4MZ/YTGKmKEm4o3JLwT/s=;
        b=VLqGrKqGDD2vMd6FQxn+wO2V/WfJYSPm/SB7pKnHzX5Fqh9ePN8SlSxz+ApFSIJ9al
         gaYJJ5HlPlWIH9yHl166VRNu+R2qimxgI3YsKsSqdb2caLQ03BS9YmOHzvhLKXfKQz/n
         Gynq7eIr7KtYszJ2sWPoUcx/xhtsSz2j9oJrLbppuKSUnf5B2Yv9uwN7bxEebNd/spn8
         XEvjunbUssu5SC/RZ4ptoKcnLJm8/+ACuhjKPeWRMFrJppNkZZq+d42SfBq+tFYMsw+E
         Bm493HD4Jt8OGtLI11P5OTV6UtzAnv1pSkTrCbyDfCP+/rQW9QrOPmUWSTZbeqUYboTg
         HtCQ==
X-Gm-Message-State: AOAM532lQCdbfQBa2UqpM07QqzHrm0Bu3Rm+itr6LpYMR+6o91BPF8pL
        jGEex0n/EqQbxsLdnv9AXMrCM3ftJJ5StOt6jIUz7qTa
X-Google-Smtp-Source: ABdhPJyHVEnG80mBmkBO7S9LJFrKBhfsOeGnPEpj31gTwsUsW8Xe9N4Iq792Vb2CDymIu/7dlukAnPRZFx0iJ7bN6ok=
X-Received: by 2002:a05:6638:d85:b0:317:d2f5:8f1d with SMTP id
 l5-20020a0566380d8500b00317d2f58f1dmr4997851jaj.117.1646748593868; Tue, 08
 Mar 2022 06:09:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646237226.git.andreyknvl@google.com> <029aaa87ceadde0702f3312a34697c9139c9fb53.1646237226.git.andreyknvl@google.com>
 <CAG_fn=WE80ueUTC3EYjGNGJc8FvAG8Ph-La9cxBXGRBX17d-6w@mail.gmail.com>
In-Reply-To: <CAG_fn=WE80ueUTC3EYjGNGJc8FvAG8Ph-La9cxBXGRBX17d-6w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 8 Mar 2022 15:09:43 +0100
Message-ID: <CA+fCnZd-0jE22cocyL8XPC4oEuY508U-7PB1oYOkTxJiLeUTiQ@mail.gmail.com>
Subject: Re: [PATCH mm 05/22] kasan: print basic stack frame info for SW_TAGS
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 6:34 PM Alexander Potapenko <glider@google.com> wrote:
>
>> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
>> index d2298c357834..44577b8d47a7 100644
>> --- a/mm/kasan/report_sw_tags.c
>> +++ b/mm/kasan/report_sw_tags.c
>> @@ -51,3 +51,14 @@ void kasan_print_tags(u8 addr_tag, const void *addr)
>>
>>         pr_err("Pointer tag: [%02x], memory tag: [%02x]\n", addr_tag, *shadow);
>>  }
>> +
>> +#ifdef CONFIG_KASAN_STACK
>> +void kasan_print_address_stack_frame(const void *addr)
>> +{
>> +       if (WARN_ON(!object_is_on_stack(addr)))
>> +               return;
>> +
>> +       pr_err("The buggy address belongs to stack of task %s/%d\n",
>> +              current->comm, task_pid_nr(current));
>
> This comm/pid pattern starts to appear often, maybe we could replace it with an inline function performing pr_cont()?

Sounds good, will do if/when posting a v2. Thanks!
