Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78E047EE23
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 11:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352382AbhLXKBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 05:01:53 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47761 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343894AbhLXKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 05:01:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V.cRDq9_1640340105;
Received: from 30.240.100.46(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.cRDq9_1640340105)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Dec 2021 18:01:47 +0800
Message-ID: <ed4ec4f9-9ede-8718-811c-8eae92c220bb@linux.alibaba.com>
Date:   Fri, 24 Dec 2021 18:01:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v3 0/6] Introduce x86 assembly accelerated implementation
 for SM3 algorithm
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211223043547.32297-1-tianjia.zhang@linux.alibaba.com>
 <YcRPYHg3SMezrfiX@zn.tnic>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <YcRPYHg3SMezrfiX@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 12/23/21 6:28 PM, Borislav Petkov wrote:
> On Thu, Dec 23, 2021 at 12:35:41PM +0800, Tianjia Zhang wrote:
>> This series of patches creates an stand-alone library for SM3 hash
>> algorithm in the lib/crypto directory, and makes the implementations
>> that originally depended on sm3-generic depend on the stand-alone SM3
>> library, which also includes sm3-generic itself.
>>
>> On this basis, the AVX assembly acceleration implementation of SM3
>> algorithm is introduced, the main algorithm implementation based on
>> SM3 AES/BMI2 accelerated work by libgcrypt at:
>> https://gnupg.org/software/libgcrypt/index.html
>>
>>  From the performance benchmark data, the performance improvement of
>> SM3 algorithm after AVX optimization can reach up to 38%.
>>
>> ---
>> v3 changes:
>>   - update git commit message for patch 01
>>
>> v2 changes:
>>   - x86/sm3: Change K macros to signed decimal and use LEA and 32-bit offset
> 
> So you sent v2 yesterday. One day later, you're spamming again.
> 
> So we have those process rules for a reason - use the time to read them
> before sending again a day later please.
> 
> Documentation/process/submitting-patches.rst:
> 
> "Don't get discouraged - or impatient
> ------------------------------------
> 
> After you have submitted your change, be patient and wait.  Reviewers are
> busy people and may not get to your patch right away.
> 
> Once upon a time, patches used to disappear into the void without comment,
> but the development process works more smoothly than that now.  You should
> receive comments within a week or so; if that does not happen, make sure
> that you have sent your patches to the right place.  Wait for a minimum of
> one week before resubmitting or pinging reviewers - possibly longer during
> busy times like merge windows."
> 

I'm sorry for the trouble to the community and reviews. Thanks for your 
reminder. I will control the time interval when sending patches in the 
future.

Merry Christmas Eve.

Tianjia
