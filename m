Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577DC508FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381611AbiDTSv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345869AbiDTSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:51:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3E144A06
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:49:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so2860874pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Nk2NSwsu8i6rTINc46A+r9NE/5YNi7JyHO9FbngN7p8=;
        b=TYs6nRRwUQOFf0gtOjWDh1j18vGSYUtK/5FrQeZVyfc+LVCQdKOhbVjQZZHNUsscec
         GNgdiEnj4ZM4kRz7ic/Mul+yJsrVlfaOlC4WQKe6QJtGkXCpWSlpSlLeXhOo44sehCZj
         5zmAUgRw3YmXiB9ErQ5mzGNIBs/39+GtIY4gL3nMYDeExzMHPqq8rvAcU6RbK5le3vAg
         AlrUwjB5dfhamDuwH6PjpxKTkmH3/+SIo6HuuJrQ5k/pLSyczcEChBfZnzVNh8MlDH23
         3u/2w+5bV/Ff9W1CVHbLsENkaR69HAvIXR1yC4dKEli4yiyIkGeEkf3FouQDwP7zixfV
         bTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Nk2NSwsu8i6rTINc46A+r9NE/5YNi7JyHO9FbngN7p8=;
        b=f6/uI5quRm7ubLN+SD39zD0rJahDmspgSeSGuAXtvZ+GLBPGsIhTzp3k1z8p1ezB59
         x1/5vjIaiJa1Kv84UjG4Yi79ZB9EYQBq1g6Ox2rW10/NcUNxvsa/DSXpXsntCnX95pOc
         M3VXM2lSQTX3CQ4WMl7Bd/NDnJ/XsyTOxiKmBlU7O24GI6Q2PF3TsV+6MF//6rb3qT0f
         HILKV8NiKI0RpoO2SsdYWCYwTzFX/LTzqywe+wNDfkSxncu+o3JHeB6k9HeTQ4ew6mMc
         6BfKe4P1pBpWUzdqzax4hLX4ZxTbww0moFytRVUAiz7+uWPSYaMEqfkEkgZsGcATfo3/
         2I5w==
X-Gm-Message-State: AOAM532JMMG9cZ2jiQszDMULYdVV7G2MXKiCT9SDlKg15gig6aXOCM2X
        yQoXg9u6Wg6ypNqV6+Yf3mNtcA==
X-Google-Smtp-Source: ABdhPJyBGG/7rUjTp4Rg2EZ9aERkWzpgr4mXMyWyplzUjaZ3YGB+GbK8sEX3Uh8uTKo/s29LimuFgA==
X-Received: by 2002:a17:902:a581:b0:154:8c7d:736a with SMTP id az1-20020a170902a58100b001548c7d736amr21954623plb.74.1650480549886;
        Wed, 20 Apr 2022 11:49:09 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f771b48736sm22080232pfj.194.2022.04.20.11.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:49:09 -0700 (PDT)
Date:   Wed, 20 Apr 2022 11:49:09 -0700 (PDT)
X-Google-Original-Date: Wed, 20 Apr 2022 11:49:06 PDT (-0700)
Subject:     Re: [PATCH v1] RISC-V: Add braces around an empty if statement bodies
In-Reply-To: <814ae1e7-297f-102f-972f-ae6130128e7a@infradead.org>
CC:     panqinglin2020@iscas.ac.cn,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        jszhang@kernel.org, wangkefeng.wang@huawei.com, mick@ics.forth.gr,
        vitaly.wool@konsulko.com, rppt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        lkp@intel.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-9b719623-5ae6-4f10-bb76-58d42260bd03@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 13:38:42 PDT (-0700), rdunlap@infradead.org wrote:
> Hi,
>
> On 4/19/22 12:48, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> This triggers -Wempty-body, which will cause the next statement (eventually
>> create_pmd_mapping) to be dropped.  Both of these were introduced by the same
>> commit.  This is safe for the reporting config (which is 32-bit), but IIUC
>> could result in breakages for 64-bit configs without 4/5 level paging like the
>> XIP configs.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Fixes: 677b9eb8810e ("riscv: mm: Prepare pt_ops helper functions for sv57")
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> Might be better to define these to functions that are empty, but that's
>> slightly different than just fixing the commit/warning in question.
>
> Yes, we usually fix this type of problem by changing these to have empty bodies:
>
> #else
> ...
> #define create_pud_mapping(__pmdp, __va, __pa, __sz, __prot)
> #define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot)
> #endif /* __PAGETABLE_PMD_FOLDED */
>
> etc.

Ya, that's the right way to do it -- not sure why I was being lazy here.  
Turns out there was a bunch of other XIP breakage, I sent a v2 that's a 
whole series.

Thanks!

>
>> ---
>>  arch/riscv/mm/init.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 9535bea8688c..637916857c4d 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -798,13 +798,15 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
>>  			   PGDIR_SIZE,
>>  			   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
>>
>> -	if (pgtable_l5_enabled)
>> +	if (pgtable_l5_enabled) {
>>  		create_p4d_mapping(early_dtb_p4d, DTB_EARLY_BASE_VA,
>>  				   (uintptr_t)early_dtb_pud, P4D_SIZE, PAGE_TABLE);
>> +	}
>>
>> -	if (pgtable_l4_enabled)
>> +	if (pgtable_l4_enabled) {
>>  		create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
>>  				   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
>> +	}
>>
>>  	if (IS_ENABLED(CONFIG_64BIT)) {
>>  		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
