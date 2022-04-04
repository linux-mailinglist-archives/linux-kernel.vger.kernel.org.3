Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A71D4F1D8F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383166AbiDDVc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380145AbiDDTBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:01:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010C624598;
        Mon,  4 Apr 2022 11:59:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso227007pjj.1;
        Mon, 04 Apr 2022 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oMVaKBgzoQqc7gxkYgb60MlXgXZZVMwR1kc99VQvjLA=;
        b=KLeLuThRs2MiFPARUNGy9/wBt8j9oC4NUv6OA1qkh3wwKwWqn1v2WyHaHbvNXtD81r
         hYeMB992L8FGwLeeJF1kmQQpQATlZpit/BeXgxxOM7Py4pf+9zG3UGbFG6RLkP/VbOGq
         Rf/m+hXlWg8JGM5Jh78VeO/JhNKm/mL2HaGt9eflIiQjLHgvYzqpI+3EwrASr1zzNsWR
         XjQ8MdY6p9tlCbundm5SciMoRUGjammmsPomk1CAqLqrX08sAU0fWqHUEVt4NoYtgG4m
         hcmR4RFRoEtQCNFGUZQUh6lGGfHEqcAy8WF70FfMglzOyQNApCqTtGhwpyCVCcagPntV
         0s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oMVaKBgzoQqc7gxkYgb60MlXgXZZVMwR1kc99VQvjLA=;
        b=cFX0QwakqoWrTScEuIVaReSAvInGxNB2lW0JRRp4GhXRmNJFtp7bVh5DBzYUzXiZ3O
         rz/54rbMvRgkajXUo+RkbStUqjWyGBoJnro6mV+QQvsuuRhkqI0UDEsP3mUqCytD9kHk
         FmWxa/NBaIPtFYFyvDWjde6elXFIu3y9NeGqaJ8OI76EHVu5PnOGojJ7I93rFyv/mzyy
         ECYKcPUovUxF/gYuGUAUTK0KExYDxfyVZzkAqvKiKfMb7ewRXQu/NurYdWpDZ630x0Xw
         y7s9lOf3W+vV4ZbFPz2G7v0efcjM/J1+bxYBgsONjOrGoQ0Dx76EsUZ/QSHfq4WFw9Ic
         pHCA==
X-Gm-Message-State: AOAM530vVsUpVJVDDzCEoc1ez/6IZcZH7Qst+TpN9ukv+B37t9p5rajU
        h8bpUUxNgbzlDUxjaJC+eks=
X-Google-Smtp-Source: ABdhPJyoHAxIXDgPuzQYSYXmM0MUfvH0ZIPUhBbJtiYgDk4sxbS9KpnJ46j0O8SLg92GcaWMP+hUWw==
X-Received: by 2002:a17:902:7245:b0:156:20aa:1534 with SMTP id c5-20020a170902724500b0015620aa1534mr1450307pll.94.1649098776500;
        Mon, 04 Apr 2022 11:59:36 -0700 (PDT)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a001ad000b004fb358ffe86sm13116733pfv.137.2022.04.04.11.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 11:59:35 -0700 (PDT)
Message-ID: <91357075-d8d0-fc0b-5264-4f5cfe368250@gmail.com>
Date:   Tue, 5 Apr 2022 03:59:30 +0900
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
 <4d6307d0-cd67-dfb2-6d6d-2f37bf4a271b@gmail.com>
 <CAJZ5v0gu4VsC7P6276p=S3ZyOg-BWP_dG6rzou2GDYA4TTMsSw@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <CAJZ5v0gu4VsC7P6276p=S3ZyOg-BWP_dG6rzou2GDYA4TTMsSw@mail.gmail.com>
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

On 2022/04/05 3:56, Rafael J. Wysocki wrote:
> On Mon, Apr 4, 2022 at 8:25 PM Akihiko Odaki <akihiko.odaki@gmail.com> wrote:
>>
>> On 2022/04/05 3:13, Rafael J. Wysocki wrote:
>>> On Sun, Apr 3, 2022 at 8:25 AM Akihiko Odaki <akihiko.odaki@gmail.com> wrote:
>>>>
>>>> This reverts commit 87ebbb8c612b1214f227ebb8f25442c6d163e802.
>>>>
>>>> ACPI processor power states can be transitioned in two distinct
>>>> situations: 1. when CPU goes idle and 2. before CPU goes offline
>>>> ("playing dead") to suspend or hibernate. Case 1 is handled by
>>>> acpi_idle_enter or acpi_idle_enter_s2idle. Case 2 is handled by
>>>> acpi_idle_play_dead.
>>>>
>>>> It is necessary to flush CPU caches in case 2 even if it is not
>>>> required to transit ACPI processor power states as CPU will go
>>>> offline soon. However, the reverted commit incorrectly removed CPU
>>>> cache flushing in such a condition.
>>>
>>> I think what you mean is that the CPU cache must always be flushed in
>>> acpi_idle_play_dead(), regardless of the target C-state that is going
>>> to be requested, because this is likely to be part of a CPU offline
>>> procedure or preparation for entering a system-wide sleep state and
>>> the stale cache contents may lead to problems going forward, for
>>> example when the CPU is taken back online.
>>>
>>> If so, I will put the above information into the patch changelog.
>>
>> I guess it is causing problems because the dirty caches will not get
>> written back and the RAM becomes stale if they are not flushed. From my
>> understanding, the CPU should have an empty cache and read back contents
>> from RAM when it is taken back online.
> 
> OK, please see if the changelog I've added to the patch is looking good:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=dfbba2518aac4204203b0697a894d3b2f80134d3

It looks good for me.

Thanks,
Akihiko Odaki
