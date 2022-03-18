Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656E64DE472
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbiCRXTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbiCRXTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:19:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80017F3C9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:18:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i11so7569982plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IVcHCcBYklMVp4ZyFJpnqeq2akbdktOMbyQu0M7lWkM=;
        b=i6IuYY1bVJG39GO25gWKj5fXg0j0g3I1ecz1VrdlDqj3a1wuctE1U+LTJku3FqmExS
         hYoE0JspcExfIyvNBOQqVMKx/OJZAk+UrfOqDU34OjVg4ar9ahcpI90IRKK9TTATJyKo
         sYFPP+CrvR84SvMKeF17KtvCFS41Z8E1by0bBhZbwRaY2S4OzULATWkDBmzy+zm7+C6h
         4CbQMWoZGcn0rcnx+n8PiNK5h2UUO8Vpa8QvtHafxxmqGIiMNfDrAS6V6raO6EFhgIkX
         RmTzJ8+dtkMGdIQYTzz3OWpTXOd92HJS0/XWxD/chrQaICXkM0ThqSqoPBvCB2X9pDGS
         0wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IVcHCcBYklMVp4ZyFJpnqeq2akbdktOMbyQu0M7lWkM=;
        b=FGHB0luKtPP/o2qKnkSPkA9Qvz3c01OEUtwT7axBsbAl9MlK7aLNMDYt57+EJ0EJog
         gx7opzeNMw7bGj0WkuChyfjD9jzlm5JwfHGMgcRMJ7CoEPo5w5N2J/HF4ujXJsiRc1Px
         I1kAtsuiNuflsyi2xPkeLfcF9Pg4MlVym7Og96ITq2LJ2hdDb+EtgMzrf9z4z6TW598i
         UQAl5pvaWwmapt0ubbwhmij/EfZ8W7pyVZwLFxoC5egLuqczsXt/HFlFTHkDGqkquQMZ
         3IL63BHxiunzmVZQBn5awi+Ufnz7EUMaPRrhPWAXWQO9zgJa1PU0IAnK7/uuIp8werAg
         gTvw==
X-Gm-Message-State: AOAM531zreliZBJ2kjlm7cz8f1TMm+taiKfOnG/ompfAO/8Hq+4LWzmK
        +AdzavZJ9xxhbfrjCOdQRPmjQQ==
X-Google-Smtp-Source: ABdhPJxvNF2QqGdofMuiYHtC41lDTJzN93eVTLBVb+qhspMXCxsDm0j7jVlkPmTFfrsk+BhsNod8bA==
X-Received: by 2002:a17:90a:4a06:b0:1c6:d786:10a8 with SMTP id e6-20020a17090a4a0600b001c6d78610a8mr14591pjh.207.1647645495306;
        Fri, 18 Mar 2022 16:18:15 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id cd20-20020a056a00421400b004fa7d1b35b6sm562516pfb.80.2022.03.18.16.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 16:18:14 -0700 (PDT)
Date:   Fri, 18 Mar 2022 16:18:14 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Mar 2022 16:18:09 PDT (-0700)
Subject:     Re: [PATCH] riscv module: remove (NOLOAD)
In-Reply-To: <YhEelqnPDr1u4uTD@dev-arch.archlinux-ax161>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     maskray@google.com, nathan@kernel.org
Message-ID: <mhng-7fe2c5d9-a8e6-4123-ac5c-0c9190792520@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Feb 2022 08:45:10 PST (-0800), nathan@kernel.org wrote:
> On Fri, Feb 18, 2022 at 12:26:11AM -0800, Fangrui Song wrote:
>> On ELF, (NOLOAD) sets the section type to SHT_NOBITS[1]. It is conceptually
>> inappropriate for .plt, .got, and .got.plt sections which are always
>> SHT_PROGBITS.
>>
>> In GNU ld, if PLT entries are needed, .plt will be SHT_PROGBITS anyway
>> and (NOLOAD) will be essentially ignored. In ld.lld, since
>> https://reviews.llvm.org/D118840 ("[ELF] Support (TYPE=<value>) to
>> customize the output section type"), ld.lld will report a `section type
>> mismatch` error. Just remove (NOLOAD) to fix the error.
>>
>> [1] https://lld.llvm.org/ELF/linker_script.html As of today, "The
>> section should be marked as not loadable" on
>> https://sourceware.org/binutils/docs/ld/Output-Section-Type.html is
>> outdated for ELF.
>
> Thank you for the patch! As mentioned on the arm64 patch, this needs
> your Signed-off-by tag. With that provided:
>
> Cc: stable@vger.kernel.org
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>
> This needs to go to stable so that older trees with a newer toolchain do
> not warn.

Yep, just checking on that SOB line.  A 

Fixes: 596b0474d3d9 ("kbuild: preprocess module linker script")

seems appropriate as well.

Thanks!

>
>> ---
>>  arch/riscv/include/asm/module.lds.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/module.lds.h b/arch/riscv/include/asm/module.lds.h
>> index 4254ff2ff049..1075beae1ac6 100644
>> --- a/arch/riscv/include/asm/module.lds.h
>> +++ b/arch/riscv/include/asm/module.lds.h
>> @@ -2,8 +2,8 @@
>>  /* Copyright (C) 2017 Andes Technology Corporation */
>>  #ifdef CONFIG_MODULE_SECTIONS
>>  SECTIONS {
>> -	.plt (NOLOAD) : { BYTE(0) }
>> -	.got (NOLOAD) : { BYTE(0) }
>> -	.got.plt (NOLOAD) : { BYTE(0) }
>> +	.plt : { BYTE(0) }
>> +	.got : { BYTE(0) }
>> +	.got.plt : { BYTE(0) }
>>  }
>>  #endif
>> --
>> 2.35.1.265.g69c8d7142f-goog
>>
>>
