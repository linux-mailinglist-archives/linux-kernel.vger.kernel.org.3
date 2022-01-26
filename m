Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78B449C597
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbiAZIyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238601AbiAZIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:54:10 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA9CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:54:10 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z5so7865850plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=5zdX3SKVScYD6E53UPMXCEiGWfm/6n8BS2yzRJbgsD0=;
        b=CXsZ8yY72uLrT6KrB5yji22/PvBfNIBbbLaQSrgxlwMNMKIG6Ad4o6nD0fvjpM+pRe
         xq2tx1bBFyDMOCNbTawElpfAfMdqQnPpCrEwe9bhh9C6+iTdRlL9gX69xnglqIOwFx9V
         vddqeoPKXgtFSNcoEP9Uqy8C42ir3DK8j/GJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=5zdX3SKVScYD6E53UPMXCEiGWfm/6n8BS2yzRJbgsD0=;
        b=Nxe9rHtWFVEhc4XiIIAPhaMZyRv3ZdaCMoQG7XTQQLepTo7lB0IQ4Wp9cslVeWt77F
         nM3IrAFabTmsjGRYduwy8NL3Di3uWyg2E0v05qeWI151zUELjKf/mV/CZgWqUTlmWBwp
         B8kijJ3Q2HQyg7yvvnYjS11KuPYDm1tey03Ak6VJmGcCLRhA8B2iYXEWFMOuOwiYq8nv
         oxi99sNxw9R4BZ+mrZgv5xsEkZvTobe7g6SlppcMLr3h2oaYjTeuIndiRsSjZ/GZeQ4G
         YyP2RrMJg3rSZdut1vavpcWgFZIfU7j2loemDs2+lxxyzR+JmA6m8bk2P6kmt85bwQo2
         nf+A==
X-Gm-Message-State: AOAM5327g4kQ26WmGly2NMp+3mHIZWiWtoZpyVHBf9hZ4MNfxxQewJq6
        HYsbhTl5zAWqwhqWcoi5RNXKeA==
X-Google-Smtp-Source: ABdhPJwIxLxoJhcwScCr6LVExd31o5dlp/AVmKdGElzDnEe2Uuct1tY91v0fK/lBM6ZpruYO5TJgow==
X-Received: by 2002:a17:90b:4c50:: with SMTP id np16mr944093pjb.118.1643187250205;
        Wed, 26 Jan 2022 00:54:10 -0800 (PST)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o18sm1479052pfu.45.2022.01.26.00.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 00:54:09 -0800 (PST)
Date:   Wed, 26 Jan 2022 00:53:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_kisskb=3A_FAILED_linux-next/m68k-al?= =?US-ASCII?Q?lmodconfig/m68k-gcc8_Tue_Jan_25=2C_18=3A24?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAH8bW93TUpyn8GaZfB83pu8Kvrsz9PHPCBHcG3+UStU7v=s=A@mail.gmail.com>
References: <20220125073137.1.83124@7e6451f583e7> <CAMuHMdVYhwpP0vSK4LT+50ZqB9opD8gcm-2aor8wAc49=GR+-w@mail.gmail.com> <CAAH8bW93TUpyn8GaZfB83pu8Kvrsz9PHPCBHcG3+UStU7v=s=A@mail.gmail.com>
Message-ID: <31219CC3-CEE4-4CFA-A416-B98F2115A527@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On January 25, 2022 10:02:56 AM PST, Yury Norov <yury=2Enorov@gmail=2Ecom>=
 wrote:
>On Tue, Jan 25, 2022 at 12:47 AM Geert Uytterhoeven
><geert@linux-m68k=2Eorg> wrote:
>>
>> On Tue, Jan 25, 2022 at 8:31 AM <noreply@ellerman=2Eid=2Eau> wrote:
>> > FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
>> >
>> > http://kisskb=2Eellerman=2Eid=2Eau/kisskb/buildresult/14688953/
>> >
>> > Commit:   Add linux-next specific files for 20220125
>> >           d25ee88530253138d0b20d43511ca5acbda4e9f7
>> > Compiler: m68k-linux-gcc (GCC) 8=2E1=2E0 / GNU ld (GNU Binutils) 2=2E=
30
>> >
>> > Possible errors
>> > ---------------
>> >
>> > arch/m68k/include/asm/bitops=2Eh:329:20: error: array subscript 2 is =
above array bounds of 'long unsigned int[1]' [-Werror=3Darray-bounds]
>
>The array-bounds warning has been enabled just recently=2E CC Kees Cook f=
or this=2E
>
>> > cc1: all warnings being treated as errors
>> > make[4]: *** [scripts/Makefile=2Ebuild:289: drivers/net/ipa/ipa_mem=
=2Eo] Error 1
>> > make[3]: *** [scripts/Makefile=2Ebuild:572: drivers/net/ipa] Error 2
>> > make[2]: *** [scripts/Makefile=2Ebuild:572: drivers/net] Error 2
>> > make[1]: *** [Makefile:1965: drivers] Error 2
>> > make: *** [Makefile:226: __sub-make] Error 2
>> >
>> > No warnings found in log=2E
>>
>> The code that causes this is drivers/net/ipa/ipa_mem=2Ec:ipa_mem_valid(=
):
>>
>>         DECLARE_BITMAP(regions, IPA_MEM_COUNT) =3D { };
>>         =2E=2E=2E
>>         for_each_clear_bit(mem_id, regions, IPA_MEM_COUNT) {
>>                 if (ipa_mem_id_required(ipa, mem_id))
>>                         dev_err(dev, "required memory region %u missing=
\n",
>>                                 mem_id);
>>         }
>>
>> This only happens with gcc-8, not with gcc-9, so it might be a
>> compiler bug=2E I don't see anything wrong with c:ipa_mem_valid()
>> nor with m68k's find_first_zero_bit()=2E
>
>I don't see any problems about how this code uses bitmap API=2E
>The m68k version of find_first_zero_bit() looks correct as well=2E

The trouble is with "enum ipa_mem_id mem_id;" which is an int, and the bit=
map API requires unsigned long=2E I tried to fix this[1] at the source, but=
 the maintainers want each[2] call site to fix it instead=2E :(

Sorry I missed this case in my build testing! If no one beats me to it, I =
can send a patch tomorrow=2E

-Kees

[1] https://lore=2Ekernel=2Eorg/lkml/20211203100846=2E3977195-1-keescook@c=
hromium=2Eorg/
[2] https://lore=2Ekernel=2Eorg/lkml/?q=3Df%3A%22Kees+Cook%22+%22Use+corre=
ctly+sized+arguments+for+bit+field%22

--=20
Kees Cook
