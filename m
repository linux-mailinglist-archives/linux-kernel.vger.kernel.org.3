Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387994C0DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbiBWIBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiBWIBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:01:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D7E7806E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:00:33 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id bd1so1976005plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wNwlylqM8UG+h4dpaoNyh+r+m1r4BIsa//SdX9MQ3a8=;
        b=ZPPisKGmhHTBx2WsKs0jYw6Oks8a5UDgAHIt8opueNDY+CUdq8RJcRFPbKpNutlWUJ
         1m5XqEE2UTB3jV7PMRTWTM3mWfoymZllDK7ChgJrG/eCBCilAbbvHG+sQvhcIZW6LWX2
         MefUEMqxPHjxSbl+QKfuywhtyaoBktVIR+IPbCGka2yBRdfCKYgj1xH7joPFOVElmcwq
         ci3GEsy9NolmqSSPFUeABd6cVM2L8f0UBzf+e15YCOSG0AJaskpQL3QP64jajs/51NRj
         9QE3eV+eaz3aNBoItJVnopyNyxYFyAJsJoianMUj9cESsKx7HKoyvYCikmsa+yV+8RU5
         8dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wNwlylqM8UG+h4dpaoNyh+r+m1r4BIsa//SdX9MQ3a8=;
        b=syfqM86EXQVSUM5vsoI1sQ5b8KlqZb67Ay4Ublk5+aUPX22Gm7YjNdteMwAA/W9nLR
         vCXMzG54VTvsLLDgEdHNd1h1StJVqkGRkpMOLUF3YbirgfuIN0KZae3nUbS/TG+bMWoi
         bnN2riWEYvF78kca3kMgqp0wc1l5M+xLTWKvEE3QRp6SeW7KvTDMzWrWDdYYg3RwsEOx
         jWmItq6EuI6ulksKX71/VY9+/DyIsjKpwU8A2jR9WhRlttmt16RvMyK6UXttdc35sZLk
         2NH2gstR7pAkOE/J+1c6393IS1AgS9Uoiszz2PbC8nMoJjL7SjgqOMX2Sz/qa/UMAVFc
         XIUg==
X-Gm-Message-State: AOAM533WM/Cj2uNBCUTlkhRSE3kmPAhBPvqMo4uhIIPuslL7OccSZk/f
        HLd9vlBkDHBnTSuLmQK4XAuCy64tOts84A==
X-Google-Smtp-Source: ABdhPJwanoqHKILjEIhFMJdUsfeGsDQ/fx0MwTEeS7SIofH6SyT+Shqtkerc+U2jJvrwTyt3XwJDYQ==
X-Received: by 2002:a17:903:404a:b0:14f:944f:22eb with SMTP id n10-20020a170903404a00b0014f944f22ebmr16980810pla.21.1645603233357;
        Wed, 23 Feb 2022 00:00:33 -0800 (PST)
Received: from [10.255.215.56] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm1902444pjn.14.2022.02.23.00.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 00:00:33 -0800 (PST)
Message-ID: <5d64733b-8d2a-4928-c4dc-ce4f3b5fc561@bytedance.com>
Date:   Wed, 23 Feb 2022 16:00:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [External] Re: [PATCH] arm64/ftrace: Make function graph use
 ftrace directly
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, broonie@kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220222130049.81284-1-zhouchengming@bytedance.com>
 <20220222105218.28e3d5aa@gandalf.local.home>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220222105218.28e3d5aa@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/22 11:52 下午, Steven Rostedt wrote:
> On Tue, 22 Feb 2022 21:00:49 +0800
> Chengming Zhou <zhouchengming@bytedance.com> wrote:
> 
>> As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
>> use ftrace directly"), we don't need special hook for graph tracer,
>> but instead we use graph_ops:func function to install return_hooker.
>>
>> Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
>> implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
>> the same optimization on arm64.
> 
> Note. Ideally we want it to hook with DYNAMIC_FTARCE_WITH_ARGS, and not
> FTRACE_WITH_REGS. If arm64 is like x86_64, saving all regs at every
> function call has a bit more overhead than saving the minimum. The
> DYNAMIC_FTRACE_WITH_ARGS, means that the minimum is still saved, but now
> exposes the arguments and the stack pointer, which function_graph_tracer
> needs.

Yes, it would be better to implement DYNAMIC_FTRACE_WITH_ARGS on arm64 too,
and this patch just use DYNAMIC_FTRACE_WITH_REGS to install return_hooker
for graph tracer, so it's a code cleanup, no performance optimization.

Thanks.

> 
> -- Steve
> 
> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
