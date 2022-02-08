Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA544AD2D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiBHIIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiBHII2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:08:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4FC0401EF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:08:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so1410391pjl.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=icZsox5sq6ultu6TBsIJo70bSWmvRrOrYh40bnoCXSA=;
        b=f7BLPpX9Kdcp6c+XKww27RgznlN9w7vJ/rwnYc8aXFfbhuPjTKndfj98aEe9aGp/H0
         gDW0Pbxs49VUqPYttoU+IDhO88/znyPoQFDeWB7NEEoAttwom3pdt7Xf6CXIpp9ToWmH
         CXUhHUtr2zA9exLVlapzmyY5arLAdeyZgG6fnhps8gJiedratNKwoa6lisn53DHrCdjx
         drF4YV3XNcz/DRTLYi8EKs9oWPIpGofhQpe+OAUP5ShZFW/l2AC+6ZFgz5VFyvVDf/tO
         93TZDufIftMx1+LivUOiuw4moCgCviWOLRQuM/YNE1k3L1DSd9/8M8dlFl9vOr/TAjfh
         JbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=icZsox5sq6ultu6TBsIJo70bSWmvRrOrYh40bnoCXSA=;
        b=mDIPvgGS4IcapT2e+F+zc4ZFY/5fkH3cWW4qJ71RBLA7weu9GJU8bffVo1ft9YnhmG
         hZFh+KlARENPurZO0Jz87y/8vlNRtqto/yLKq769brq6A3HjSwTeonTGcjuP+uWmWYoS
         8W32ME1GT01x5H0y0AxbEiUTehDd0Fx1ZLObMTea6RJ4tDzDh5JjngytjRW+WFXw9Gn2
         ed9rg4fwiTzUXj4N2GdtpVNIPIiRp3DBuP9znjdikMqoncBtPK+4AVtHyBiwDO+osSof
         sBqZuMkxnHnmdtk3MRXFKLMVQ4ZQMLl8UCZgMjF+w7eeVIqZZn3pVynvGyiMUQ3aSMtZ
         ZzhQ==
X-Gm-Message-State: AOAM530IZdAxS5uT03DKU/xz5uK0VbxijnbbbLlfi+zqXgew+QVygvio
        WmcdmZqri1MVuWB1EKoADUM=
X-Google-Smtp-Source: ABdhPJz+3oXn7aGYiRSFAyWkWE8xU9mGG0mXjlBNYy3tYZjcQz67PEbxPu/fK6PzUMZpvm6ZKiQmOg==
X-Received: by 2002:a17:90b:4c8e:: with SMTP id my14mr23545pjb.243.1644307707177;
        Tue, 08 Feb 2022 00:08:27 -0800 (PST)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id p1sm15875187pfh.98.2022.02.08.00.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 00:08:26 -0800 (PST)
Message-ID: <1105cf7d-0d61-3ae2-f372-3b1f80c08c60@gmail.com>
Date:   Tue, 8 Feb 2022 16:08:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/cpufeatures: Move the definition of X86_FEATURE_AMX_*
 to the word 18
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jing Liu <jing2.liu@intel.com>, linux-kernel@vger.kernel.org,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220117062344.58862-1-likexu@tencent.com>
 <8b274c5f-6b68-aed9-117d-f89249e57e18@intel.com>
 <47362220-30d5-c513-a2aa-61187ee91c41@redhat.com>
 <bc272301-af11-621a-3bda-ee398754fd0a@gmail.com> <YfVM+xdDS76E3d6r@zn.tnic>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
In-Reply-To: <YfVM+xdDS76E3d6r@zn.tnic>
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

On 29/1/2022 10:19 pm, Borislav Petkov wrote:
> On Wed, Jan 19, 2022 at 11:41:31AM +0800, Like Xu wrote:
>> Thanks Dave and Paolo.  Just for your convenience:
>>
>>  From 588c2221999c1f5860188a7cbaeb0d4f80c6d727 Mon Sep 17 00:00:00 2001
>> From: Like Xu <likexu@tencent.com>
>> Date: Mon, 17 Jan 2022 14:23:44 +0800
>> Subject: [PATCH v2] x86/cpufeatures: Move AMX CPU feature defines to correct
>>   word location
>>
>> From: Like Xu <likexu@tencent.com>
>>
>> The word 18 for Intel-defined CPU features from CPUID level 0x00000007:0 (EDX)
>> has been defined in the same file. Move the definitions of X86_FEATURE_AMX_* to
>> the right entry to prevent misinterpretation. No functional change intended.
>>
>> Signed-off-by: Like Xu <likexu@tencent.com>
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> v1 -> v2 Changelog:
>> - Refine the commit message and subject; (Dave)
>>
>>   arch/x86/include/asm/cpufeatures.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> $ test-apply.sh /tmp/urgent.01

Emm, are you willing to make "test-apply.sh" public (or have done) and let 
others benefit ?

> checking file arch/x86/include/asm/cpufeatures.h
> Hunk #1 FAILED at 299.
> patch: **** malformed patch at line 45: IBPB) */
> 
> Don't ever send patches from

Got you.

> 
> User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0) Gecko/20100101 Thunderbird/91.5.0
> 
> That thing mangles them.
> 
> See Documentation/process/email-clients.rst for further info.
> 

Sorry for the late reply, and here's a new version from git-send-email:

https://lore.kernel.org/lkml/20220208080103.8119-1-likexu@tencent.com/
