Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BD7467417
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbhLCJek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:34:40 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49129 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237826AbhLCJej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:34:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UzFsZ52_1638523871;
Received: from 30.22.113.200(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UzFsZ52_1638523871)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Dec 2021 17:31:13 +0800
Message-ID: <8dc8ec1c-3146-09fe-36ce-52999b06f6a0@linux.alibaba.com>
Date:   Fri, 3 Dec 2021 17:31:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH V6 00/49] x86/entry/64: Convert a bunch of ASM entry code
 into C code
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/26 18:11, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Changed from V5:
> 	Fix the code order of FENCE_SWAPGS_KERNEL_ENTRY in patch1 and
> 	change the new corresponding C entry code to match the asm code.
> 
> 	Squash the patch of removing stack-protector from traps.c into
> 	a later patch that uses C entry code for #DB and #MCE
> 
> 	Kill .Lgs_change and use the new asm_load_gs_index_gs_change in
> 	_ASM_EXTABLE
> 
> 	s/ETNRY/ENTRY/g for DEFINE_IDTENTRY_IST_ENTRY macros
> ----


Ping.

Thanks
Lai
