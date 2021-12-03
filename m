Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D2146748C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379782AbhLCKOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:14:14 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43651 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238002AbhLCKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:14:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UzGMWSM_1638526247;
Received: from 30.22.113.200(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UzGMWSM_1638526247)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Dec 2021 18:10:48 +0800
Message-ID: <3a4e3ba6-0ee1-b65f-f2b8-744d4dded6f8@linux.alibaba.com>
Date:   Fri, 3 Dec 2021 18:10:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH V6 00/49] x86/entry/64: Convert a bunch of ASM entry code
 into C code
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
 <8dc8ec1c-3146-09fe-36ce-52999b06f6a0@linux.alibaba.com>
 <Yanl1HeO1m2TNbyv@zn.tnic>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
In-Reply-To: <Yanl1HeO1m2TNbyv@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/3 17:39, Borislav Petkov wrote:
> On Fri, Dec 03, 2021 at 05:31:11PM +0800, Lai Jiangshan wrote:
>> Ping.
> 
> Can you explain to me what's with all the pinging?
> 
> Does your patchset contain anything urgent that needs immediate review
> and handling or is it something which is a nice idea but needs to be
> reviewed very carefully because it is asm entry code which is always a
> pain and careful review cannot be done when rushing people?
> 

Hello

It is not urgent nor it is something should be put in cold cellar.
Please consider queuing the first three patches at least.

It is cold for a week, I think a ping is proper than a resending.

The asm entry code is always a pain and this patchset gives a start in
future with reduced asm code and pain because some future changes might
be redirected from asm to the C hopefully.

Thanks
Lai
