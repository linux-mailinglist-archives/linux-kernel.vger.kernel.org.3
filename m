Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492AC58C28A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 06:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiHHE1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 00:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiHHE1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 00:27:22 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B625DF8C
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 21:27:21 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id y11so5641525qvn.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 21:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XRB76YrJG2tUNqd+V8czPXYw0ocV/d6mqBd8+wHh7CU=;
        b=ao+qAnjVpvkE5Gqe3bwruQNKa+4Iu3REhN4vINJuWVNZ7UxeUHUhXzX9ZWNApDR91v
         zEoElNuW43lHnKty2SsLVwbTcU++dnvqUHPkB3w9K3Mfea5kIHlxATMNF24GSC9btE/l
         uYLYsyhJWaoA7tXTrOe0jK67bl8CVowJ3g/SXD+QVhap1V/k14LnKKd8wrjpNZ91LYqf
         D2bMD2w2nP5uhKAG+qlaXEBV1fF2PkLfFvcTmILg/vSq6B6uynbXzlBEb2lvvTZFtGNT
         Mop6O483uLrM3/mhWetrT2j6XVH5aSeZfRK2uvM6XI0Lm93frsU22g0hYr0pVfkeU1xl
         XXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XRB76YrJG2tUNqd+V8czPXYw0ocV/d6mqBd8+wHh7CU=;
        b=Do3P8duitOfF0ZQIK97jS1y4x6NTs1ZyDi0VxlUgvGc/ASOMDPt+5Jr7dvf7+cPPaB
         Fpx0jQT5r6qyb0+HHaEMkkik0E/Ty/oVeEbX0cmDlTY57FrojTghHVcKKC54/hiQe+X8
         nGhU7QqocP2bTx++7G/F068wrspg0do1IfkM0KGWXeML0WAAxXC8BsWxlwEW6Aq/Fbcq
         pw3+rFVmmHZf3Mc1zjdD1FTDU3pYFevmSLz7DNy7lFD/gQk7F3+yyzayR9hqCFUkEcnS
         SpWqAZTba+0l8mrNUhRpP+chfEUh+n/fkKOZt9/z7lT8VlJmZR90eDoHUHXrCkJxFbw7
         edGA==
X-Gm-Message-State: ACgBeo1Gy6QVJLMocYEyBYHgRNhBukkp/JJtyugRZ3RwW8hkHeVy9gq5
        Vi0DCeUtbiqXiNvYRsTjiey+o1NVfw==
X-Google-Smtp-Source: AA6agR4S5l1t73bAKKN28Q0+8mC1E9KhPF+lhfWHoQvofdfvI70LkkEIDQNCjtSAsrHbz5Y0IDTwkQ==
X-Received: by 2002:a05:6214:d05:b0:477:274f:6a6d with SMTP id 5-20020a0562140d0500b00477274f6a6dmr14014781qvh.15.1659932840661;
        Sun, 07 Aug 2022 21:27:20 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id cq9-20020a05622a424900b0031ef366c9b5sm7480860qtb.34.2022.08.07.21.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 21:27:19 -0700 (PDT)
Message-ID: <6ffce33f-8ab7-a29a-e931-8d7522cfa8ab@gmail.com>
Date:   Mon, 8 Aug 2022 00:27:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v5 29/32] d_path: prt_path()
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com
References: <20220808024128.3219082-1-willy@infradead.org>
 <20220808024128.3219082-30-willy@infradead.org> <YvCOVGdlGqRVlZwL@ZenIV>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <YvCOVGdlGqRVlZwL@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 00:17, Al Viro wrote:
> On Mon, Aug 08, 2022 at 03:41:25AM +0100, Matthew Wilcox (Oracle) wrote:
>> From: Kent Overstreet <kent.overstreet@gmail.com>
>>
>> This implements a new printbuf version of d_path()/mangle_path(), which
>> will replace the seq_buf version.
>>
>> Part of what we're trying to do with printbufs is standardizing a
>> calling convention so they don't have to live in lib/vsprintf.c, and can
>> instead with the code for the types they're printing - so this patch
>> adds prt_path() to d_path.c, another patch will switch vsprintf.c to use
>> it.
> 
> To use it for *what*?  If you mean replacing %pd with it - forget about that.
> Not going to happen.
> 
> There's a hard requirement for printk - it should be safe to call in any
> locking environment.  d_path() isn't, and that's impossible to avoid.

Oof, good catch. It was to replace seq_buf_path() in this patch series, 
and is only used in trace_seq.c. I'll have to investigate what's going 
on in the tracing code, because now that you mention it that did look 
suspect.
