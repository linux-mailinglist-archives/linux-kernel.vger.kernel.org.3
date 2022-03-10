Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BFC4D5386
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343924AbiCJVTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244230AbiCJVTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:19:05 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0404220EC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:18:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r10so9961103wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GLYfYjKYhGeuO9cwBbNFdK5OLsNYW6r1/vF7iHoZpf8=;
        b=bnTSnEHsHQ9Ryu+/9on7487yeHcImgWtQ8wbY0FCN67k39bj93EVE5/lYcsfPbDuQs
         +zxxAnRthtpVWcSLOwl2xDYhs6VLwhE9kdIMBctK+b3etQfaMZ5FLOKLA49nMAO0N6Yy
         KYyOLTGeI1GHGJjX0f2tCJUFV5tZgDHnbazZFAoN9MzJclMaV8khV8jjVnMTcu8zFy1N
         YQhcSQYcvi1UT2Ne7Cy4q9SuY8bmoipv+yEWFHpJHCxnAlzk2stE+7up2jI7PeoBOgrD
         93LsUeaRDXrzM29LCCo9Ex0r1V98kEAFC7kH1q8ikLsVdLLy65CJYypgpD/2J20y8jP0
         7rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GLYfYjKYhGeuO9cwBbNFdK5OLsNYW6r1/vF7iHoZpf8=;
        b=7k35JraVeGxkaq4YbWrhwicxI42YpClPPPDQK8ttNyGzJs4OCWcVmUCLD56N3M8oew
         iZQOfg4gHXgSbiNhLyKDThnUW5gulqHvdO5GVHaZLM+1sSzHcJqp73oiW9BWlGDhc/+Q
         Q+EGkOKTDdjk9NDa+YDEvC2Mqoz/Soo6OZNWE+7Ryz3AC8+0U15p3FlfO5l7lcsMK0t6
         ME5ikwGQkCCkqlnq/zuCVLY0+05HFshI808Zx4mZqX7Vi7JifvNHOoHBqImKnQqgJtZI
         /P/T4XlbNZrmoDIZ6jF6pVWYbbus6/U4IXqV8hKGB5jqR2Nahu2jRUPYESlyoDph+Z2w
         6wig==
X-Gm-Message-State: AOAM53296SjCy8QQgDOXDg6y8aTPRcKj5q3+mFmEZk+SwB/WzCUcKHIT
        eJkKGMvRDl18HKWrx00FtfgGtw==
X-Google-Smtp-Source: ABdhPJytgTpS5Y9Kb/rhchWgE2PDTEK5dnB9LNEZLwUEbOA/kf5h9VMdXCqqQ17C1f75Z1sj5Q1M7w==
X-Received: by 2002:a5d:47a1:0:b0:1f1:d733:ea8d with SMTP id 1-20020a5d47a1000000b001f1d733ea8dmr4849381wrb.557.1646947081442;
        Thu, 10 Mar 2022 13:18:01 -0800 (PST)
Received: from ?IPV6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id x2-20020adff0c2000000b001f1fa284a32sm5100744wro.115.2022.03.10.13.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 13:18:01 -0800 (PST)
Message-ID: <6b2513db-7c31-8da4-38ec-0b9898c6589c@arista.com>
Date:   Thu, 10 Mar 2022 21:17:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 00/23] Add generic vdso_base tracking
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20210611180242.711399-1-dima@arista.com>
 <8bba9ed8-ae1f-7c98-fde5-808927935447@csgroup.eu>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <8bba9ed8-ae1f-7c98-fde5-808927935447@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 3/9/22 15:41, Christophe Leroy wrote:
> Hi Dmitry,
> 
> I'm wondering the status of this series.

Yeah, I plan to work on v4 addressing the reviews.
WFH has quite affected my work on side-projects and I've laid aside for
a while this patch set that touches every architecture and is besides
a bit challenging to upstream.

> Wondering what to do while reviewing pending powerpc patches and
> especially
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20201103171336.98883-1-ldufour@linux.ibm.com/

Please, go ahead with that - I'll base v4 patches on the top of that.
Thanks for pinging me about this.

> Christophe
> 
> Le 11/06/2021 à 20:02, Dmitry Safonov a écrit :
>> v3 Changes:
>> - Migrated arch/powerpc to vdso_base
>> - Added x86/selftest for unmapped vdso & no landing on fast syscall
>> - Review comments from Andy & Christophe (thanks!)
>> - Amended s/born process/execed process/ everywhere I noticed
>> - Build robot warning on cast from __user pointer
>>
>> I've tested it on x86, I would appreciate any help with
>> Tested-by on arm/arm64/mips/powerpc/s390/... platforms.
>>
>> One thing I've noticed while cooking this and haven't found a clean
>> way to solve is zero-terminated .pages[] array in vdso mappings, which
>> is not always zero-terminated but works by the reason of
>> VM_DONTEXPAND on mappings.
>>
>> v2 Changes:
>> - Rename user_landing to vdso_base as it tracks vDSO VMA start address,
>>    rather than the explicit address to land (Andy)
>> - Reword and don't use "new-execed" and "new-born" task (Andy)
>> - Fix failures reported by build robot
>>
>> Started from discussion [1], where was noted that currently a couple of
>> architectures support mremap() for vdso/sigpage, but not munmap().
>> If an application maps something on the ex-place of vdso/sigpage,
>> later after processing signal it will land there (good luck!)
>>
>> Patches set is based on linux-next (next-20201123) and it depends on
>> changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
>> on my changes in akpm (fixing several mremap() issues).
>>
>> Logically, the patches set divides on:
>> - patch       1: a cleanup for patches in x86/cleanups
>> - patches  2-13: cleanups for arch_setup_additional_pages()
>> - patches 13-14: x86 signal changes for unmapped vdso
>> - patches 15-22: provide generic vdso_base in mm_struct
>> - patch      23: selftest for unmapped vDSO & fast syscalls
>>
>> In the end, besides cleanups, it's now more predictable what happens for
>> applications with unmapped vdso on architectures those support .mremap()
>> for vdso/sigpage.
>>
>> I'm aware of only one user that unmaps vdso - Valgrind [2].
>> (there possibly are more, but this one is "special", it unmaps vdso, but
>>   not vvar, which confuses CRIU [Checkpoint Restore In Userspace], that's
>>   why I'm aware of it)
>>
> 
> I'm wondering the status of this series.
> 
> Wondering what to do while reviewing pending powerpc patches and
> especially
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20201103171336.98883-1-ldufour@linux.ibm.com/
> 
> 
> Christophe
> 


Thanks,
          Dmitry
