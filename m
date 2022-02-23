Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942814C10F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbiBWLD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiBWLD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:03:27 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F084EF71
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:02:58 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso1840461pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uHFBFunfaJIqNpyruyoJx0PZskQ9wSm+0m0Ug2WaIFI=;
        b=kJckXw4hOlbwUqgotgVHd/yvlIaF2pqI2TToQDj148qHYnzjksXpCmJ9hXf6JqODpZ
         povb3QSWwwuT72yJYlLaIeViQNJrizsYlF0H1+ssjEDdYDJh2FU4+kjCVTdaHhdlsLT6
         +cbzquLrs+aQ2wASHBXfkm6bqZjclnyWW45Mq6aYwLvaECXplEQPCuj5WCTrjv4dHvFo
         giCB8GLZtm1azEzdKELDgJNTzmiGjHtjWmF6LcPwhO9LCiDsXWNSuztO2nzxJ9431DeS
         V50h620xDDDDz5z4X3IziyQQDtfluGDB5kOmrHg7KM8za5wvP2TKVGSI//viAYZYLsRy
         Ufdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uHFBFunfaJIqNpyruyoJx0PZskQ9wSm+0m0Ug2WaIFI=;
        b=NdmYcbK5D0XBGmQYvfe5hMIuyH3ucdIM3FGjEkL6G0uIAhtVIM3hpRCH5M1uS7afR8
         fUVqV8rLAy4nCQ5Je9k5eibLwVyi6bZANz5IIHRZDq4nmu/yuoX8rtj41rmPXvsxPmj+
         4r5yQabSsZ5HcVqlt0hxbUZG0gsMCYwCx8yHOgt6DsQeofw+NCTKJ7OjK7isgAYSB7cn
         W8fd3FjbvhElj4ohDkeQKi7npqA0sD16Pj1OGwU1f8+tWdyrj0Ow/wVEgfEU8R1uUvPI
         OpKYI4heJ0oblnJkZ7ps/H7leEcCRG8I0f7BTFc2DrHhOnObewwPNcNWm3VYPfGrVTcp
         m1YQ==
X-Gm-Message-State: AOAM530QmpT8PvS1QMnO8OZdhafBQTigCYMly9no7ngtvdjXB86mmBW3
        NVNgEM++b22HYJ/MLTa7qj0=
X-Google-Smtp-Source: ABdhPJygDdF6N9XosDy2ac1bnn7mItgsmnB783rUZupBIV0aIF2MWctWLuUu3fELfQ9IaoC4Vgc0UQ==
X-Received: by 2002:a17:902:b706:b0:14e:eef0:2a8b with SMTP id d6-20020a170902b70600b0014eeef02a8bmr28023508pls.9.1645614178017;
        Wed, 23 Feb 2022 03:02:58 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:18:efec::754])
        by smtp.gmail.com with ESMTPSA id t14sm24573027pgo.19.2022.02.23.03.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 03:02:57 -0800 (PST)
Message-ID: <b172898d-0464-054a-9182-1110297f3629@gmail.com>
Date:   Wed, 23 Feb 2022 19:02:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/4] x86/hyperv: Add missing ARCH_HAS_CC_PLATFORM
 dependency
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jmattson@google.com,
        seanjc@google.com, thomas.lendacky@amd.com, brijesh.singh@amd.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
 <20220222185740.26228-2-kirill.shutemov@linux.intel.com>
 <YhVCoveTwsDZXE5G@zn.tnic> <4769a3c0-449b-184a-5c61-a0e155f9c5b4@gmail.com>
 <YhYPPHKZFsGzaI2U@zn.tnic> <bcdbd534-a077-3bb3-3d37-c9eb2a048854@gmail.com>
 <YhYS00FywnE8g4Um@zn.tnic>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YhYS00FywnE8g4Um@zn.tnic>
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

On 2/23/2022 6:56 PM, Borislav Petkov wrote:
> On Wed, Feb 23, 2022 at 06:43:40PM +0800, Tianyu Lan wrote:
>> Hyper-V code check cpuid during runtime and there is no Hyper-V
>> isolation VM option.
> 
> So how does "Current Hyper-V Isolation VM requires AMD_MEM_ENCRYPT" work
> exactly?
> 
> Please explain in detail and not in piecemeal sentences.
>
The kernel in the image needs to select AMD_MEM_ENCRYPT option
otherwise the kernel can't boot up due to missing SEV support and
sev_es_ghcb_hv_call() always return error.


