Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA749F3BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbiA1GgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:36:25 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48804 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242635AbiA1GgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:36:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V31BaWY_1643351778;
Received: from 30.240.99.245(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V31BaWY_1643351778)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Jan 2022 14:36:21 +0800
Message-ID: <948c7ddc-1a2d-aa38-1841-576ab85e63a4@linux.alibaba.com>
Date:   Fri, 28 Jan 2022 14:36:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v4 6/6] crypto: tcrypt - add asynchronous speed test for
 SM3
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220107120700.730-1-tianjia.zhang@linux.alibaba.com>
 <20220107120700.730-7-tianjia.zhang@linux.alibaba.com>
 <YfN0PsCAXYo0Hx9T@gondor.apana.org.au>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <YfN0PsCAXYo0Hx9T@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 1/28/22 12:42 PM, Herbert Xu wrote:
> On Fri, Jan 07, 2022 at 08:07:00PM +0800, Tianjia Zhang wrote:
>> tcrypt supports testing of SM3 hash algorithms that use AVX
>> instruction acceleration.
>>
>> In order to add the sm3 asynchronous test to the appropriate
>> position, shift the testcase sequence number of the multi buffer
>> backward and start from 450.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   crypto/tcrypt.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> This is not an issue with your patch but we should delete all
> the mb hash tests as the mb hash algorithm tself was removed
> in 2018.
> 
> Thanks,

Thanks for the reminder, I will add an extra patch to remove the mb hash 
tests.

Happy New Year.


Tianjia
