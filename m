Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5CE46CF8C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhLHI7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:59:45 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:33126 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLHI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:59:43 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru A692C20E8F18
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <faadff42-e769-cc8b-5ae2-793b2c006b91@omp.ru>
Date:   Wed, 8 Dec 2021 11:55:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] MIPS: Loongson64: Use three arguments for slti
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
References: <20211207170129.578089-1-nathan@kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211207170129.578089-1-nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 07.12.2021 20:01, Nathan Chancellor wrote:

> LLVM's integrated assembler does not support 'stli <reg>, <imm>':

    Perhaps slti (as below)?

> <instantiation>:16:12: error: invalid operand for instruction
>   slti $12, (0x6300 | 0x0008)
>             ^
> arch/mips/kernel/head.S:86:2: note: while in macro instantiation
>   kernel_entry_setup # cpu specific setup
>   ^
> <instantiation>:16:12: error: invalid operand for instruction
>   slti $12, (0x6300 | 0x0008)
>             ^
> arch/mips/kernel/head.S:150:2: note: while in macro instantiation
>   smp_slave_setup
>   ^
> 
> To increase compatibility with LLVM's integrated assembler, use the full
> form of 'stli <reg>, <reg>, <imm>', which matches the rest of

    Again, slti?

> arch/mips/. This does not result in any change for GNU as.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1526
> Reported-by: Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
[...]

MBR, Sergey
