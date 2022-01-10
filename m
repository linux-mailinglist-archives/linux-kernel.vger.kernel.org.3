Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A0489850
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbiAJMNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:13:09 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:36744 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235772AbiAJMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:13:02 -0500
X-UUID: 179ec19712d345d59e3d4d68b1dc6a93-20220110
X-UUID: 179ec19712d345d59e3d4d68b1dc6a93-20220110
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 923755758; Mon, 10 Jan 2022 20:12:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Jan 2022 20:12:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 20:12:57 +0800
Message-ID: <0f3836a37d36dece52213d4b33e2b666cb187fc2.camel@mediatek.com>
Subject: Re: GPL-1.0-licensed code for files
 drivers/clk/mediatek/clk-mt7986* included with commit ec97d23c8e22 ("clk:
 mediatek: add mt7986 clock support")
From:   Sam Shih <sam.shih@mediatek.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ryder Lee <ryder.lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-spdx@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Jan 2022 20:12:57 +0800
In-Reply-To: <CAKXUXMy8ywQXqqmOvvm9wKL_ikixRJOFgCcgu4OdPUPhjq6MhA@mail.gmail.com>
References: <CAKXUXMy8ywQXqqmOvvm9wKL_ikixRJOFgCcgu4OdPUPhjq6MhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luka/Stephen,

This is my mistake, I seem to use an old license header on it.
Just like "clk-mt7986-eth.c" in the same patch series,


https://lore.kernel.org/all/20211217121148.6753-4-sam.shih@mediatek.com/

I intend to license "clk-mt7986-apmixed.c", "clk-mt7986-infracfg.c",
and "clk-mt7986-topckgen" under the kernel's standard GPL-2.0.

Should I need to resend this patch?
Or I can just send a follow-up patch to fix it?

Regards,
Sam


On Mon, 2022-01-10 at 10:56 +0100, Lukas Bulwahn wrote:
> Dear Sam,
> 
> 
> Thanks for contributing the mt7986 clock support to the kernel
> repository with commit ec97d23c8e22 ("clk: mediatek: add mt7986 clock
> support").
> 
> You have marked the files below with the GPL-1.0 License, which
> ./scripts/spdxcheck.py identifies and warns about:
> 
> drivers/clk/mediatek/clk-mt7986-apmixed.c: 1:28 Invalid License ID:
> GPL-1.0
> drivers/clk/mediatek/clk-mt7986-infracfg.c: 1:28 Invalid License ID:
> GPL-1.0
> drivers/clk/mediatek/clk-mt7986-topckgen.c: 1:28 Invalid License ID:
> GPL-1.0
> 
> The kernel's licensing rules are described here:
> 
> 
https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/process/license-rules.html*kernel-licensing__;Iw!!CTRNKA9wMg0ARbw!3vjYIYa2VqgzRgsUxjx-mwtOtidbamcTDphKaMUo-7ql0YlaB4Qi_Xc-1vDpFfju$
>  
> 
> The GPL-1.0 is a deprecated license in the kernel repository.
> 
> Driver code that is licensed with GPL-1.0 might not be compatible
> with
> GPL-2.0. I am not a lawyer, and we probably do not want to require
> all
> users of your driver code to needlessly involve a lawyer to get such
> a
> statement on license compatibility.
> 
> Do you really intend to license this code under GPL-1.0 and are you
> aware of all the consequences for other developers and users? Or is
> this a mistake and you intend to license it under the kernel's
> standard GPL-2.0 license?
> 
> 
> Best regards,
> 
> Lukas

