Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C08851098D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354458AbiDZULS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiDZULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:11:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E99E1594BF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:08:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dk23so14978350ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tLEXJAA00IeUn92g+4KPqheiYchRzNk1CErI3hE/2ek=;
        b=GZTVe7N8eI4UTdUZ9Tjai6ca3oa5nN6rkKqDwJU5o1VwzHSMXgIHJRjjZsQACU5uBr
         GlkbgtWhXlTBtH3QXpvEoPAkUzhX7wHNUHEaLjFraK4Fxtf4kIrosSkKY/VWdTxIs6pf
         5j3hctG+fUcS4QoW3bLZ0xoaJyYh9V/s3+zsgtxv2L2OcFOc1uHBT5Q7sglwvPcZZZdv
         bavXpvLDh9qLJjqRuhTKl+u9s40qyzYO9BnYYSieFdcxtSESEFvW2YK+MMlVYbi0SMeb
         Fc/sEvZjRZVKC3V11zRIwjbWtuJxw1dSkIWhUS+sK4rScXto270+v/jPojKThfYXG71w
         +PLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tLEXJAA00IeUn92g+4KPqheiYchRzNk1CErI3hE/2ek=;
        b=pRoWMVPzanu+/C6DOeXy5Ic0XOKdvosyDwtu0cogWcJ7kfefY2+bwgDXVoDQIobDcb
         hkNAKLOtQ84uhstkI6mjsYf+bB55qfTzxnvgjgkKuBhHHOSZFRzWFCDRr3ZRjQ7tDUiV
         oNssuZ3h0YP1fpDJ9zUEXmsD5LPMkq9M0M2K/nDUAJ73DSP0kwo4Bl9HY3j6vPyoHhTc
         JHK4gcWNHI4qRHdlH8vrKkmA17fK5PRGI9gR4q8YKhvNQjNA6eHQkoZ/eGri7E5HI5DT
         lS4D93DYVOQzey1qcfCx9yu5gnkgSKCMiXT+8yNT7oKHp1WyFeW70zh3LiRJ0nB9/ySa
         k5+A==
X-Gm-Message-State: AOAM530upMkkaqU+3mmNT/2hIUFZ/TaIXxzgiS/2o9hu33+HJdIm/7wB
        vDtNGz8Db6M3H25KN7jksXg1mg==
X-Google-Smtp-Source: ABdhPJw9/fEtAIeFtCRKchGp8lfvceTRS5BAE6i9Fuu3os3IVIddM48wscmCVR8F4475NEB0tvMcPg==
X-Received: by 2002:a17:907:62a6:b0:6ef:8118:d3e2 with SMTP id nd38-20020a17090762a600b006ef8118d3e2mr22587094ejc.605.1651003685427;
        Tue, 26 Apr 2022 13:08:05 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d053:7ae:ded9:ba66? ([2a02:578:8593:1200:d053:7ae:ded9:ba66])
        by smtp.gmail.com with ESMTPSA id kt24-20020a170906aad800b006f37988318esm4074017ejb.48.2022.04.26.13.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 13:08:02 -0700 (PDT)
Message-ID: <645fe7b9-4751-f94a-2ae7-37e6c1a7165a@tessares.net>
Date:   Tue, 26 Apr 2022 22:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] x86/pm: fix false positive kmemleak report in
 msr_build_context()
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220423182410.1841114-1-matthieu.baerts@tessares.net>
 <YmgOP1FFmidS9ecJ@zn.tnic>
 <CAJZ5v0gzvOagiYsMxznksrjmtZFV873DaLAiOo4YHkoUq5qTTA@mail.gmail.com>
 <Ymgrn03YqecDlPOB@zn.tnic>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <Ymgrn03YqecDlPOB@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav, Rafael,

Thank you for your reviews!

On 26/04/2022 19:27, Borislav Petkov wrote:
> On Tue, Apr 26, 2022 at 06:24:04PM +0200, Rafael J. Wysocki wrote:
>> So can the comment be dropped entirely?
> 
> Looks like it to me. All the accesses in wakeup_64.S are done through
> those offsets which are computed at build-time so they should always be
> valid.
> 
> OTOH, I wouldn't mind having there some text making any future person
> touching this, aware of where to look when making changes.
> 
> Some changes like removing a struct member are nicely caught, ofc,
> see below. But for something else which is a lot more subtle having a
> comment say "hey, have a look at where this is used in wakeup_64.S and
> make sure everything is still kosher" is better than having no comment
> at all. IMHO.
Good point, let me update the comment and the commit message in a new v3.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
