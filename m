Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC8749FFCE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242930AbiA1R5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiA1R5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:57:44 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1062C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:57:44 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id z7so6091951ilb.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=71w7hp/9pxq3OWpPEt+fr6pzk72moXbSFhLNj69p5Gc=;
        b=JOUFeVTTVbxykvWeZe3975fNFyii01VRwwe0Et/oKrD+vqXDViwHH3tq1DW/IRH5y/
         gM4K1Mp5UNoFTFJpIOtAutDsnmqeVh4IsoLz548NPWb4OBZuggFWo4XmV5elN2DbIBDZ
         ygdVRSSak/6C2v/8a1kqHLtoPukK/ScKWNGB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=71w7hp/9pxq3OWpPEt+fr6pzk72moXbSFhLNj69p5Gc=;
        b=qIDzaeC6pI+TzyaJ+QT3m+US6l4fSCgc0FNBsn6ljmOE69uqMmUG1jZmrhxEgvSWRj
         uY54A+9cJmhrx4EmnKvoHq7Egim0no1sfcm1ywIIGJJKjF25TsKTJzMWmk9ITj/p7RA9
         bXIUVSIXUI30Mm5j9WPIIbJKrCu/nDFC5nIUaOtfUn/Jxbe8WAXV+LYofgy8pkLsXJXU
         AmDymzOFRODiitNqc2H9/RyViObmCXmOZaxXDG8qYpdRYsr/wDXPvckRGo34I1gasIaT
         ZWXsiURlmGztvDKgmijB0YxcXMoXC29Zkghm/t1wdjqwPZ3Dbvl8gmBIUhnO1VPNOy8s
         1GXQ==
X-Gm-Message-State: AOAM533P0Ye0ggdOWq1HhfiuM0dJo1GJtjBuBgFBFd0ySLPQhhtyw8JX
        YqsJMcfQV2UGIB4FN/Hw83krxQ==
X-Google-Smtp-Source: ABdhPJx0SgoWYQZrhr841aQYRHdcYG2jST3CaeyEkaXR7nLgdiYdMx2XA4SIl+VHJTrcP1M1jYG36Q==
X-Received: by 2002:a05:6e02:1a21:: with SMTP id g1mr6630384ile.58.1643392664143;
        Fri, 28 Jan 2022 09:57:44 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4e31:d3a8:3801:7e36? ([2601:282:8200:4c:4e31:d3a8:3801:7e36])
        by smtp.gmail.com with ESMTPSA id p9sm13919577iln.61.2022.01.28.09.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:57:43 -0800 (PST)
Subject: Re: [tools headers UAPI] e2bcbd7769: kernel-selftests.ir.make_fail
To:     Sean Young <sean@mess.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220128075346.GG8421@xsang-OptiPlex-9020>
 <YfO39Q3mNHMQOkd4@gofer.mess.org>
 <CAADnVQJ3RCPUQ0k9nu2urrRK=U7SUetuPmY0_b17M_PD=j4fkw@mail.gmail.com>
 <e5b72f09-a208-a579-3e51-10935ccee1ff@linuxfoundation.org>
 <YfQqI2ryOYEDuvON@gofer.mess.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <347bae9f-f775-4976-3d27-b0c725211d78@linuxfoundation.org>
Date:   Fri, 28 Jan 2022 10:57:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YfQqI2ryOYEDuvON@gofer.mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 10:38 AM, Sean Young wrote:
> On Fri, Jan 28, 2022 at 10:27:52AM -0700, Shuah Khan wrote:
>> On 1/28/22 9:49 AM, Alexei Starovoitov wrote:
>>> On Fri, Jan 28, 2022 at 1:32 AM Sean Young <sean@mess.org> wrote:
>>>>
>>
>>>>> ir_loopback.c: In function ‘main’:
>>>>> ir_loopback.c:147:20: error: ‘RC_PROTO_RCMM32’ undeclared (first use in this function); did you mean ‘RC_PROTO_RC6_MCE’?
>>>>>       if (rc_proto == RC_PROTO_RCMM32 &&
>>>>>                       ^~~~~~~~~~~~~~~
>>>>>                       RC_PROTO_RC6_MCE
>>>>
>>>> So this commit removes the copy of lirc.h from tools/include/uapi/linux/lirc.h,
>>>> so now the test uses /usr/include/linux/lirc.h. It appears that this file
>>>> does not have RC_PROTO_RCMM32 defined on this system, which means it is a
>>>> kernel header from v5.1 or earlier (this was added in commit
>>>> 721074b03411327e7bf41555d4cc7c18f49313f7).
>>>>
>>>> It looks like this machine is redhat 8.3, which ships with kernel 4.18.
>>>>
>>>> I guess my change was far too optimistic; I had no ideal enterprise kernels
>>>> were so ancient.

> Hi Shuah,
> 
> I was thinking along the same lines, however RC_PROTO_RCMM32 is an enum
> value so a pre-processor #ifdef is not going to work. At the moment I haven't
> had any bright ideas other than doing a `#define RC_PROTO_RCMM32 26` at the
> top of the file.
> 

One more idea. Let's see if this works. Check for RC_PROTO_MAX if it existed
before this commit that RC_PROTO_RCMM32, you could define RC_PROTO_RCMM32
conditionally in the test scope. If not let's go woth your plan of defining
it at the top with some info.

thanks,
-- Shuah
