Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A454F1E87
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359672AbiDDV5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379963AbiDDS1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:27:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E890413F48;
        Mon,  4 Apr 2022 11:25:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i11so8816648plg.12;
        Mon, 04 Apr 2022 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nW+R2aELHMuslWsI+4yUFjr+ad8rO4vRUmzN+6iX3w0=;
        b=AGsQ4XN/coB22xLf2XWLJpswQIPEHRILCm8rV/x6fdotpjLDbSMr5O6RsPD0mJwPSk
         BmUe8xb/Sotcl0zH3GihiocxLus2PZRfGgIf2wZjoiYtQH4pFRrCfmAMGeyzLAqwUjGJ
         zUalFPHQ/eoadYCmrmUXIKRxpm1JYh8e1hyPd4uB5d23VQVp3Z3/95RmQ+Nk+jwrzqoO
         BRt9pBBWrgr9kMdf+5M96ORy0GXKltQbyqkBFNY+hBrfjybpEOBGaaNs/2QWDsx1Lohp
         OE54gIPTzWtBpnL/+e7aMXKdDogYJ4OdsKu62+8lshXLOXBDjsunRQnUKGtPKXgQsh7Q
         RP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nW+R2aELHMuslWsI+4yUFjr+ad8rO4vRUmzN+6iX3w0=;
        b=3uR0qIwPYoQmSP5yh7EEq1HaIij7nuXZqBndTx2U/g98ZiVlrET1hkn7+UBfNkaYMQ
         4JfkJJAb/2UGrwpSsYJqCeLGEz6oDT0MCUuHfWSdTC6ajHTFlXxlRcJBQSe1Rwmmo8FX
         PEViqmOAS4pfCte0L8oQnnJvz2UmU2qzPqlZzhTR9Z9JlX6Ay+xwIJwS4xJ/UIOV4UCD
         u+rL4ErVfZcQHlUkL4I0ajwQ517LRLQmdlGvW+t7E34TNnSaKS+Gd+FywI4LzboQv6f1
         uk/bAe6hIrTSlWaZBTJ0j5NGFkY2luobEh8NXg7kgCRYpYzUiyuMRGN8KP218E3d9ZTw
         XCzw==
X-Gm-Message-State: AOAM532XaZa+O6vshSmBN1tqVeBMCoVv7DHc8P2mPbs1gdXrgm9bGVa5
        RjS7FdaHJKLmBcS9MYA/RvU=
X-Google-Smtp-Source: ABdhPJxf3ByNCA70KyPk6gBFS1sJ43qJGOvIwwj+jQn+oMAAxXF8VTs004VDAXGv/34dW0LUB4Wa4Q==
X-Received: by 2002:a17:902:a510:b0:156:6cf9:9a7c with SMTP id s16-20020a170902a51000b001566cf99a7cmr952088plq.151.1649096743340;
        Mon, 04 Apr 2022 11:25:43 -0700 (PDT)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id k23-20020a17090a591700b001ca00b46cf9sm158807pji.18.2022.04.04.11.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 11:25:42 -0700 (PDT)
Message-ID: <4d6307d0-cd67-dfb2-6d6d-2f37bf4a271b@gmail.com>
Date:   Tue, 5 Apr 2022 03:25:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Revert "ACPI: processor: idle: Only flush cache on
 entering C3"
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20220403062322.3168-1-akihiko.odaki@gmail.com>
 <CAJZ5v0gaRr-r8VFCEGSP1nTX0CwrOi35DXZB5Z8A9tiLufNxPg@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <CAJZ5v0gaRr-r8VFCEGSP1nTX0CwrOi35DXZB5Z8A9tiLufNxPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/05 3:13, Rafael J. Wysocki wrote:
> On Sun, Apr 3, 2022 at 8:25 AM Akihiko Odaki <akihiko.odaki@gmail.com> wrote:
>>
>> This reverts commit 87ebbb8c612b1214f227ebb8f25442c6d163e802.
>>
>> ACPI processor power states can be transitioned in two distinct
>> situations: 1. when CPU goes idle and 2. before CPU goes offline
>> ("playing dead") to suspend or hibernate. Case 1 is handled by
>> acpi_idle_enter or acpi_idle_enter_s2idle. Case 2 is handled by
>> acpi_idle_play_dead.
>>
>> It is necessary to flush CPU caches in case 2 even if it is not
>> required to transit ACPI processor power states as CPU will go
>> offline soon. However, the reverted commit incorrectly removed CPU
>> cache flushing in such a condition.
> 
> I think what you mean is that the CPU cache must always be flushed in
> acpi_idle_play_dead(), regardless of the target C-state that is going
> to be requested, because this is likely to be part of a CPU offline
> procedure or preparation for entering a system-wide sleep state and
> the stale cache contents may lead to problems going forward, for
> example when the CPU is taken back online.
> 
> If so, I will put the above information into the patch changelog.

I guess it is causing problems because the dirty caches will not get 
written back and the RAM becomes stale if they are not flushed. From my 
understanding, the CPU should have an empty cache and read back contents 
from RAM when it is taken back online.

> 
>> In fact, it made resuming from
>> suspend-to-RAM occasionally fail on Lenovo ThinkPad C13 Yoga.
> 
> So this probably means that resume from suspend-to-RAM occasionally
> fails on Lenovo ThinkPad C13 Yoga and reverting the commit in question
> fixes this problem.  Is that correct?

Yes, that is what I meant.

Regards,
Akihiko Odaki

> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
>> ---
>>   drivers/acpi/processor_idle.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index f8e9fa82cb9b..05b3985a1984 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -570,8 +570,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>>   {
>>          struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>>
>> -       if (cx->type == ACPI_STATE_C3)
>> -               ACPI_FLUSH_CPU_CACHE();
>> +       ACPI_FLUSH_CPU_CACHE();
>>
>>          while (1) {
>>
>> --
>> 2.35.1
>>

