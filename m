Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784EC50332A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiDPCJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiDPCGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:32 -0400
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51335183BF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1650074523;
        bh=MRhdO0cz7cxp9uoazzUTQIFzQSvjWuvNyJYajb1r9is=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W5uB/Ds1oVQ4J6kkjBT+5KY45ZBuZ9PLGTWIzX7ao8DXahUAzzmTvIInMDLBecTAC
         dlW+fR0NsnuDVTqQn38BzDYrHT5jta+RSw+bH6Hv41St8TAxJ5aERW4C/uezRHHRLa
         cFL+RwQzbzkNdqGWrPh6fttb4g1Xm4BtsZeRsvSw=
Received: from [IPv6:240e:362:47d:9500:6527:51dc:8ce2:179e] ([240e:362:47d:9500:6527:51dc:8ce2:179e])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id 798346B3; Sat, 16 Apr 2022 09:30:24 +0800
X-QQ-mid: xmsmtpt1650072624trb9mmb58
Message-ID: <tencent_C8A588B7ED0135E6A6CB349F06AE0EB44107@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70QpzxApsWPM1NiJ2tyeChvdwskY/HojDIOHIeQ0wZc6DtJaB77C
         qxEIDkoQ3uTCgYYP6ee+dDWikpW+roqtweBaIiIoWtjSq4FYdXqgyKlh1W+X3La4Fm52vtXAHZtN
         QGTtG1RGhbFN1Beh1Gvvwb/4/bNgqE7dUd/HtnmAl9miMe8o0PhKi2Td8y0g6KCLZI2/pJuICMXz
         dnjGjTzPdhORuURiOksZgiPHNP9JAUHDWW1r+OPS9QwFIP54qQr0+UHN8aGidXfVRritM8e7PP1N
         R5LyQCRyan35JxttaPmLvptA0qyw5yPWFu32XQJ35apnA6zefnmaTG+WdQKcX+axk8bx65Ova19j
         4sGwFsa2d8a87btvtEfkwuWh5Y+0+s2aItiBGm2i8aO/oqKMTJPHnJX9UKV2VlhkRc4gTY9Vm88c
         9hA7KOMDjnU27aGpB1MDlb9xsXyi0R1mzsFVefiNbo+YvY/QSf8tIPPiTv3HgR4teG6SPboOKetE
         LDXtHUOUAun46pBGkPuCIQkcZei51Ddm7yNS+DaTxhjuZOhyZi63OUzymAIWJzRAScAeLyh3kIwM
         fsNthC9bD73kiUx22wxEvi4Q1z5/PjwDK5ksK9mzgONMdD7kQmd6UGcxLuFGrzc9gyeW2XCX4yuB
         ojC/oAmxC3vBwQ1hyA6eYW9FIA8gJLqtIKftoStNYDup+MHOeESwgJpEjllVnj9GeF0Rafxawzyg
         GY3RRyJ+/h2Bb49MZ1M4v1OtyvfDCZ385DVdO8Giy0MtsJfx/Myd19ZKXJOV2CLjCd3C+X9PkF9j
         dtbMCzek2zsz+UuQje9bwlDnHjfXsNP4CWz4KdJVeJTTCZ/gIIEFQ/nLuEY5B5a6TiIRw2GSgKb1
         IuK2uEJ7zCVPN4ZY0MJqwYJvHqlA7dG61k1q1cZNAVu2p6grqa1NAy2ZP/VkteQ6TsjM/1i1neey
         1w/VaxJUdXnxVCxYyFJBB4i25C04vT
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
 <YllnAPUlh3KHwjXq@fyu1.sc.intel.com>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <06436154-03dc-96c3-4e75-b7d982832d8a@foxmail.com>
Date:   Sat, 16 Apr 2022 09:30:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YllnAPUlh3KHwjXq@fyu1.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/15 下午8:37, Fenghua Yu wrote:
> Hi, Zhangfei,
>
> On Fri, Apr 15, 2022 at 07:52:03PM +0800, zhangfei.gao@foxmail.com wrote:
>>
>> On 2022/4/15 下午6:50, Fenghua Yu wrote:
>>> Hi, Zhangfei,
>>>
>>> On Fri, Apr 15, 2022 at 06:14:09PM +0800, zhangfei.gao@foxmail.com wrote:
>>> I download this patch from:
>>> https://lore.kernel.org/lkml/YllADL6uMoLllzQo@fyu1.sc.intel.com/raw
>>> git am to either v5.18-rc2 or the latest upstream without any issue.
>> It is my copy paste issue.
>>
>> I have tested, nginx woks well.
> Great!
>
>> Other than the following issue,
>> Each time /sbin/nginx will alloc ioasid but not free.
>> which I think it maybe nginx issue or the mis-usage, will ask there.
> Which nginx/openssl function is supposed to call kernel sva_unbind? I couldn't
> find the function in nginx tree.
>
> If nginx doesn't free ioasid, it will cause ioasid leak and memory leak.
Yes

In my case, sva_bind/unbind is from openssl_engine, bind_fn, not in 
nginx itself
nginx will use openssl -> openssl engine.

nginx:
src/core/nginx.c
main
ngx_ssl_init(log);

OPENSSL_init_ssl(OPENSSL_INIT_LOAD_CONFIG, NULL)


openssl_engine
IMPLEMENT_DYNAMIC_BIND_FN(bind_fn)
bind_fn
sva_bind

destroy
sva_unbind

But destroy seems not called in sbin/nginx -s quit.


Thanks


