Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D974C4C108F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbiBWKoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbiBWKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:44:15 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AC058E7D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:43:48 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 75so19537536pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=izF6/BOlFRf0GfvXEkyLgXWuNg7Bc9Mpe7Dcz3gCT68=;
        b=chEEFmEPoDo1VPyqjA70d68X5C0NptFBYwl6Fv98rSsbuKhE52Mm+kdu7Y0K1UC9s/
         gWvQYWdgPqCLZ3Y9s9DYNIq7MB5k0G+LHybr0m/C66JhLpYnLIz7WN3PLXZzaGVTzBBu
         x15MYb5DoaJ+qKOCionM/Eui/pQVJwfiAEs5dN43wwvz7q98oYNbeQecYKUqECKepIYc
         f/KzPBSLD7bw8oJmh7/Xtu6Wnof8hjcjnmmjvw2woSk11pTbR50yfBT/HJH6H5lSfFCa
         05a/mcUYQjJLNlki0D9QPXdX/hcGm0jKahKEiay9QhyYQkyUomG7wS21+M7kgJZZJYBF
         VJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=izF6/BOlFRf0GfvXEkyLgXWuNg7Bc9Mpe7Dcz3gCT68=;
        b=Q/inwAJaeUwJK+WYifXfw4pTV12yCHthobxdIxn63xKhMoBWAycbFSh92WS31wrs9Y
         jQ9Y0PYllrKk5LBuPx796oUvv1Yx3Ao3NrtALxYrJ0ec4M9vMQhSlDvlLdt4zJP5PlA+
         r1xa3i7bvVhj6HISKFC5gfWr+S0LM8kVt7TAojfnNFqd0mfi01dB9zZwGnIcANmP09Jn
         1csFpE+Pjd4px8rTeFOR5niFLwstEryjjeP7hTiGk604KTSNSOn5u55Oht/CAA+ohftJ
         VTNAthulILJAmJXqBM3KnVYuQwuNpqkIxqAdi9aRjb+l1ru54PO0ZC6LQavg43wIwWsV
         A1FA==
X-Gm-Message-State: AOAM533cfgM4bA6ip9q46A1vKbIOijajUgPrmXGRd2wUfOY3a+SU2aPI
        mBnhA3a8nB0VA8vc1k45nfo=
X-Google-Smtp-Source: ABdhPJysu9zb0UfI2rxfNbgv89NTLiU+G0srjigNHQKvLWHK3KsehgF7WzK+S2uETXCc1AcZNxngbA==
X-Received: by 2002:a63:e604:0:b0:373:8aca:846e with SMTP id g4-20020a63e604000000b003738aca846emr23003518pgh.406.1645613027806;
        Wed, 23 Feb 2022 02:43:47 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:1a:efea::754])
        by smtp.gmail.com with ESMTPSA id ms7sm2494784pjb.56.2022.02.23.02.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 02:43:47 -0800 (PST)
Message-ID: <bcdbd534-a077-3bb3-3d37-c9eb2a048854@gmail.com>
Date:   Wed, 23 Feb 2022 18:43:40 +0800
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
 <YhYPPHKZFsGzaI2U@zn.tnic>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YhYPPHKZFsGzaI2U@zn.tnic>
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



On 2/23/2022 6:41 PM, Borislav Petkov wrote:
> On Wed, Feb 23, 2022 at 03:04:41PM +0800, Tianyu Lan wrote:
>>        Current Hyper-V Isolation VM requires AMD_MEM_ENCRYPT option which
> 
> Where is that isolation VM option? Out of tree?
> 
> Because
> 
> $ git grep AMD_MEM_ENCRYPT | grep Kconfig
> arch/x86/Kconfig:1540:config AMD_MEM_ENCRYPT
> arch/x86/Kconfig:1553:config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
> arch/x86/Kconfig:1555:  depends on AMD_MEM_ENCRYPT
> 
> and those ain't it.

Hyper-V code check cpuid during runtime and there is no Hyper-V
isolation VM option.


