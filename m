Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9AD4D59A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346387AbiCKEhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346384AbiCKEg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:36:57 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBFD1A8068
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:35:48 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id u17so4744874pfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V1/TnLPrornoIN/WK1P7jxHhGPmmerjcFisapQwZfNE=;
        b=SPKGt49qDswbf2PivcNvXaZJ62enQa2p8KpJzako40QAEEFJAF12UBaljhGOfFLz7h
         l4Ifv4wgpLYh/BE3pvqcuz5Xkb4K/E12DRJzkEak0tnMAMaQSR4kCUJ2igcKqf30Qjfn
         ojR5TJ2MKHni0RODfI65PdMT73Ksb44ff6kfNrY4vXSF07CB2qwnZcSjYww8HcGJMea9
         k/q5jbxbVkExV+7GKBT5zfe7d/uCIFzf+p4IBkKanZx7A3gFMpKQM9t8gs3nDb+DHlad
         kqFDSelbAqaKZuoAwqc0QbTSgTzbvpzm+3ruG8dXMcGV1F/38N1YpxBMgAJHcTMV2mqR
         uPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V1/TnLPrornoIN/WK1P7jxHhGPmmerjcFisapQwZfNE=;
        b=dJ4NO+NjGoq1wtZAmcwZ0FCW1bKSdQRDyc3wpWVrgqFrXZRPoHDlTsSmv/QGrexe6+
         jtDCXfBNHY7xXHb4Q2B6fUp0IMvjHTXgUQDNAmlFFz/D/ja28gNeILyRNbpfgXjyp4jx
         zx3TQcIkt2/OTIpHbtO8FOK9m4Ro5S1oF7cZBICoOM1nIxQlM7ElbvfYTMB6pNd9avTA
         Ts6zol9SSqkf9HMthYwuclBpswq+OWLV2YJ6lv51512w1ZYNDaYWSo1/M3keQmlH4sYm
         UCSVCtlGxM3qZSyN+h2nm2eAdNIUyeK2g3ThAsl1ekTuPKTiQaUYIYBraY4Hkr0lyAyJ
         CYCw==
X-Gm-Message-State: AOAM532MDS7NQPAERc7aQIykk8wGkGe9SpszCGV5voVCiT/szBFh04Gr
        ck5IiAD8Pd2H2qcBKKmHuUU2Zw==
X-Google-Smtp-Source: ABdhPJw1jjulB8lFEQ7TbEdQ+NxHJ+yLJT+gpcnsL8IO5hql9Q5QGjJnn8awRNRvVfABCnjn97tfgQ==
X-Received: by 2002:a62:684:0:b0:4f7:803:d1b0 with SMTP id 126-20020a620684000000b004f70803d1b0mr8551366pfg.10.1646973348053;
        Thu, 10 Mar 2022 20:35:48 -0800 (PST)
Received: from [10.61.2.177] (110-175-254-242.static.tpgi.com.au. [110.175.254.242])
        by smtp.gmail.com with ESMTPSA id j7-20020a637a47000000b003803fbcc005sm6829615pgn.59.2022.03.10.20.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 20:35:47 -0800 (PST)
Message-ID: <03683f2e-4153-4b4d-fdc2-063aa10c24ac@ozlabs.ru>
Date:   Fri, 11 Mar 2022 15:35:36 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:98.0) Gecko/20100101
 Thunderbird/98.0
Subject: Re: [PATCH] powerpc: Replace ppc64 DT_RELACOUNT usage with
 DT_RELASZ/24
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7Ju?= =?UTF-8?Q?g?= 
        <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220309055118.1551013-1-maskray@google.com>
 <CAKwvOdmMS4=QAoBFvhAdXWaLHOwH2252FX9i_yZyiCOpOt=3Dw@mail.gmail.com>
 <CAFP8O3+jJf=amTYjm6YQbJKAuK0XRNoG3Gwc6C+E0=CPd46ZAw@mail.gmail.com>
 <87a6dxm8e8.fsf@mpe.ellerman.id.au>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <87a6dxm8e8.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/22 15:15, Michael Ellerman wrote:
> Fāng-ruì Sòng <maskray@google.com> writes:
>> On Thu, Mar 10, 2022 at 11:48 AM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>>>
>>> On Tue, Mar 8, 2022 at 9:53 PM Fangrui Song <maskray@google.com> wrote:
>>>>
>>>> DT_RELACOUNT is an ELF dynamic tag inherited from SunOS indicating the
>>>> number of R_*_RELATIVE relocations. It is optional but {ld.lld,ld.lld}
>>>> -z combreloc always creates it (if non-zero) to slightly speed up glibc
>>>> ld.so relocation resolving by avoiding R_*R_PPC64_RELATIVE type
>>>> comparison. The tag is otherwise nearly unused in the wild and I'd
>>>> recommend that software avoids using it.
>>>>
>>>> lld>=14.0.0 (since commit da0e5b885b25cf4ded0fa89b965dc6979ac02ca9)
>>>> underestimates DT_RELACOUNT for ppc64 when position-independent long
>>>> branch thunks are used. Correcting it needs non-trivial arch-specific
>>>> complexity which I'd prefer to avoid. Since our code always compares the
>>>> relocation type with R_PPC64_RELATIVE, replacing every occurrence of
>>>> DT_RELACOUNT with DT_RELASZ/sizeof(Elf64_Rela)=DT_RELASZ/24 is a correct
>>>> alternative.
>>>
>>> checking that sizeof(Elf64_Rela) == 24, yep: https://godbolt.org/z/bb4aKbo5T
>>>
>>>>
>>>> DT_RELASZ is in practice bounded by an uint32_t. Dividing x by 24 can be
>>>> implemented as (uint32_t)(x*0xaaaaaaab) >> 4.
>>>
>>> Yep: https://godbolt.org/z/x9445ePPv
>>>
>>>>
>>>> Link: https://github.com/ClangBuiltLinux/linux/issues/1581
>>>> Reported-by: Nathan Chancellor <nathan@kernel.org>
>>>> Signed-off-by: Fangrui Song <maskray@google.com>
>>>> ---
>>>>   arch/powerpc/boot/crt0.S       | 28 +++++++++++++++++-----------
>>>>   arch/powerpc/kernel/reloc_64.S | 15 +++++++++------
>>>>   2 files changed, 26 insertions(+), 17 deletions(-)
> ...
> 
>> I rebased the patch on
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> master and got a conflict.
>> Seems that https://lore.kernel.org/linuxppc-dev/20220309061822.168173-1-aik@ozlabs.ru/T/#u
>> ("[PATCH kernel v4] powerpc/64: Add UADDR64 relocation support") fixed
>> the issue.
>> It just doesn't change arch/powerpc/boot/crt0.S
> 
> Yeah sorry, I applied Alexey's v4 just before I saw your patch arrive on
> the list.
> 
> If one of you can rework this so it applies on top that would be great :)


I guess it is me as now I have to add that UARRD64 thing to crt0.S as 
well, don't I?

And also we are giving up on the llvm ld having a bug with RELACOUNT?


