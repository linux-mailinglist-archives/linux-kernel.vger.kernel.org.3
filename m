Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A74482B71
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiABNdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:33:00 -0500
Received: from elvis.franken.de ([193.175.24.41]:52741 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbiABNcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:32:54 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n40yi-0002m7-04; Sun, 02 Jan 2022 14:32:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 5F522C0A4B; Sun,  2 Jan 2022 14:29:19 +0100 (CET)
Date:   Sun, 2 Jan 2022 14:29:19 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] MIPS: Loongson64: Add Loongson-2K1000 reset
 platform driver
Message-ID: <20220102132919.GE3468@alpha.franken.de>
References: <20211126015216.26605-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126015216.26605-1-zhangqing@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 09:52:14AM +0800, Qing Zhang wrote:
> Add power management register operations to support reboot and poweroff.
> 
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
> v8-v9:
> No change
> ---
>  drivers/platform/mips/Kconfig      |  6 ++++
>  drivers/platform/mips/Makefile     |  1 +
>  drivers/platform/mips/ls2k-reset.c | 53 ++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 drivers/platform/mips/ls2k-reset.c

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
