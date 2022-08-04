Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561745897DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbiHDGsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbiHDGsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:48:01 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4C3AB22;
        Wed,  3 Aug 2022 23:48:00 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id c24so4397491ejd.11;
        Wed, 03 Aug 2022 23:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5C7rvtcpzk2BbJJ0+B6At0AsmYoyb/SdIgBeDzMA0yw=;
        b=JvjS4jjIqUdPWZrpG240FrCuxC3k7i3vLDQqYyXzRn5it71GvZ9zGxNTIz18KBueC0
         LmFhlJ+d43I5qQWELVnJGK0ExTEjrG/Ysj604VJN5qaqUKLmrFbjDmPXA1xyCrwu8TiN
         r5atRq72cMqsNsft/bowoiFZsepULTJH49kLihiQtBLHfjjS1ZjPw1CuTTMeLdOJFvVD
         /Ns4WhC8r6ajAUwgn5W41C8irapRfKt8Q12BVM8+Fatz5gkGhVfhFXEpnS8HmftqOa9j
         FkAE6Gao2uvzl4A/QmWdAC6g7qPvy2W4g6dVX3aG0kKVxTA+wPgMsTc0czXjKr/NnLoi
         jJPw==
X-Gm-Message-State: ACgBeo3k0Ezqvx+sIHpBqWCDFEFm5pYfmNZb2FsTWzhlYKCmfzI76zsI
        5vg6uSPFTs2sZkuoMI9CFxM=
X-Google-Smtp-Source: AA6agR6af04MGTADwH+Gf4eafBH82jSQwB8xdmG8C0QXBmLPLLWcIJ58NNfyXGYhW1Rc9cP5AEP0uQ==
X-Received: by 2002:a17:906:cc50:b0:730:b5fd:89cf with SMTP id mm16-20020a170906cc5000b00730b5fd89cfmr331349ejb.221.1659595678841;
        Wed, 03 Aug 2022 23:47:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id t22-20020a05640203d600b0043ce5d4d2c3sm205165edw.14.2022.08.03.23.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 23:47:58 -0700 (PDT)
Message-ID: <f1e00958-d889-d6d0-db41-fb79cb614a7a@kernel.org>
Date:   Thu, 4 Aug 2022 08:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] Revert "Kbuild, lto, workaround: Don't warn for
 initcall_reference in modpost"
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>
References: <20220730173636.1303357-1-masahiroy@kernel.org>
 <20220730173636.1303357-3-masahiroy@kernel.org>
 <CAKwvOdkq1or=UOWJLU2DaS=MFGO9OmH7HG6=FDKS6h_saoKLAw@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAKwvOdkq1or=UOWJLU2DaS=MFGO9OmH7HG6=FDKS6h_saoKLAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 08. 22, 20:04, Nick Desaulniers wrote:
> On Sat, Jul 30, 2022 at 10:37 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> This reverts commit 77ab21adae509c5540956729e2d03bc1a59bc82a.
>>
>> That commit was 8 years old, and it said "This is a workaround".
>> If this is needed for GCC LTO, it should be added in a proper way.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> Please don't forget to cc the author & reviewers for a patch when
> submitting a revert.
> 
> + Jiri in case a patch needs to be carried in any downstream trees for
> re-application.

IMO we already got rid of -fno-toplevel-reorder (we have noreorder 
attribute now), so:

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for letting me know.

>>   scripts/mod/modpost.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>> index c6a055c0291e..a8ee27496da7 100644
>> --- a/scripts/mod/modpost.c
>> +++ b/scripts/mod/modpost.c
>> @@ -1462,9 +1462,6 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
>>          from = find_elf_symbol2(elf, r->r_offset, fromsec);
>>          fromsym = sym_name(elf, from);
>>
>> -       if (strstarts(fromsym, "reference___initcall"))
>> -               return;
>> -
>>          tosec = sec_name(elf, get_secindex(elf, sym));
>>          to = find_elf_symbol(elf, r->r_addend, sym);
>>          tosym = sym_name(elf, to);
>> --
>> 2.34.1
>>
> 
> 


-- 
js
suse labs
