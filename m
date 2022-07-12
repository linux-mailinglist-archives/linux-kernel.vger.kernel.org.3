Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993C6571614
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiGLJs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiGLJsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:48:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B30AA742
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:48:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v16so10345124wrd.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WcPIJHWyToGVlIzDYOdfUB4mbv1ws7QerB6L3JMPYZ0=;
        b=qTn9s6H2hO+MfqMpLno3oo6tu+sKBx1LyvIZ9q4T2q6toceAyIopXU8BLiLSSJh8Y5
         gOMGN/tva7VtKfi/E7zxIfu4EygB4KXSzlahhUZABzcp0mb8n22EtrxNnN2uhka+jt3F
         jM7yPbQN2NxmfGSx3Zu+dILeI4CqzzLaJYElYWrxe9g/4rWz4fFvP6zYieOJNN1aUE0B
         KtcyVselTQRu9d1tyguKxAQcYRrhkv0zB4zefB0/vdgeqLAqu+U4hiqadhnGm6thgaYC
         hSBVL+vaVO61bTPDOqmObpLN88sGQJxNa8oHy271N7jyFymCls6oJoecMFJUm1XLOrLW
         PNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WcPIJHWyToGVlIzDYOdfUB4mbv1ws7QerB6L3JMPYZ0=;
        b=Sg5EgnJTsnpnhTZF7wkRrj/LxNhVnRxfMTksZgbDzusVqNGMixKaWXa6eTOayjYQEj
         6Y/zDNQae2pt+dpD4g7L0voxQGUhi05yY+BR1GkCww4JS7KpA012N+r7p4ZvqF4cyC9X
         bJkwQuu0MF3TPVJq8BCVDJxcg9mc0wnvF9ZmQob6BBOOr955wuitHK9DxivRWAg0Ph2T
         Im+Qd4lOVsN3YzGs2AxGUp9ytaW+2AxNgpGZLZW0dz+2KIhN7em3rPlv/SqnjCp00BpB
         Q5mTOHu4OMrDFYRXs/GyEM4cqpPPbL0toJdKGR6nrFl0rXkbKeviKSW5EHEvR2q2UPI5
         9I+Q==
X-Gm-Message-State: AJIora/emk6P51Xb9E31nTIrZShxiqY6oiajXKLDGQ5D1sVFyQQoLx3V
        e6lQSWfzt26Pzr04H2B1kZCLPQ==
X-Google-Smtp-Source: AGRyM1t8KGr5XoQft8lPqDZI8l7AxfbF/t6JDU+4e6F9ndr5oYREAwYjj1hvJgKWw4r5YUmX41ahuA==
X-Received: by 2002:a5d:6d49:0:b0:21b:a3ba:30b5 with SMTP id k9-20020a5d6d49000000b0021ba3ba30b5mr21773949wri.513.1657619301745;
        Tue, 12 Jul 2022 02:48:21 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n68-20020a1c2747000000b0039c96b97359sm9024370wmn.37.2022.07.12.02.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 02:48:21 -0700 (PDT)
Message-ID: <a443a6f9-fd6f-d283-ce00-68d72b40539d@isovalent.com>
Date:   Tue, 12 Jul 2022 10:48:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH v2] bpf/scripts: Generate GCC compatible helpers
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        James Hilliard <james.hilliard1@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
References: <20220706172814.169274-1-james.hilliard1@gmail.com>
 <a0bddf0b-e8c4-46ce-b7c6-a22809af1677@fb.com>
 <CADvTj4ovwExtM-bWUpJELy-OqsT=J9stmqbAXto8ds2n+G8mfw@mail.gmail.com>
 <CAEf4BzYwRyXG1zE5BK1ZXmxLh+ZPU0=yQhNhpqr0JmfNA30tdQ@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzYwRyXG1zE5BK1ZXmxLh+ZPU0=yQhNhpqr0JmfNA30tdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 05:40, Andrii Nakryiko wrote:
> CC Quentin as well
> 
> On Mon, Jul 11, 2022 at 5:11 PM James Hilliard
> <james.hilliard1@gmail.com> wrote:
>>
>> On Mon, Jul 11, 2022 at 5:36 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 7/6/22 10:28 AM, James Hilliard wrote:
>>>> The current bpf_helper_defs.h helpers are llvm specific and don't work
>>>> correctly with gcc.
>>>>
>>>> GCC appears to required kernel helper funcs to have the following
>>>> attribute set: __attribute__((kernel_helper(NUM)))
>>>>
>>>> Generate gcc compatible headers based on the format in bpf-helpers.h.
>>>>
>>>> This adds conditional blocks for GCC while leaving clang codepaths
>>>> unchanged, for example:
>>>>       #if __GNUC__ && !__clang__
>>>>       void *bpf_map_lookup_elem(void *map, const void *key) __attribute__((kernel_helper(1)));
>>>>       #else
>>>>       static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>>>>       #endif
>>>
>>> It does look like that gcc kernel_helper attribute is better than
>>> '(void *) 1' style. The original clang uses '(void *) 1' style is
>>> just for simplicity.
>>
>> Isn't the original style going to be needed for backwards compatibility with
>> older clang versions for a while?
> 
> I'm curious, is there any added benefit to having this special
> kernel_helper attribute vs what we did in Clang for a long time? Did
> GCC do it just to be different and require workarounds like this or
> there was some technical benefit to this?
> 
> This duplication of definitions with #if for each one looks really
> awful, IMO. I'd rather have a macro invocation like below (or
> something along those lines) for each helper:
> 
> BPF_HELPER_DEF(2, void *, bpf_map_update_elem, void *map, const void
> *key, const void *value, __u64 flags);
> 
> And then define BPF_HELPER_DEF() once based on whether it's Clang or GCC.

Hi, for what it's worth I agree with Andrii, I would rather avoid the
#if/else/endif and dual definition for each helper in the header, using
a macro should keep it more readable indeed. The existing one
(BPF_HELPER(return_type, name, args, id)) can likely be adapted.

Also I note that contrarily to clang's helpers, you don't declare GCC's
as "static" (although I'm not sure of the effect of declaring them
static in this case).

Thanks,
Quentin
