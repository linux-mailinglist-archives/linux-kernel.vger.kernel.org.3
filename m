Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2CA4A354A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 10:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354428AbiA3JE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 04:04:58 -0500
Received: from gloria.sntech.de ([185.11.138.130]:51874 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346840AbiA3JE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 04:04:56 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nE68j-0000Id-R8; Sun, 30 Jan 2022 10:04:53 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the rockchip tree
Date:   Sun, 30 Jan 2022 10:04:52 +0100
Message-ID: <14086734.IJ1KOUGyn7@diego>
In-Reply-To: <20220130102302.698a7551@canb.auug.org.au>
References: <20220130102302.698a7551@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Am Sonntag, 30. Januar 2022, 00:23:02 CET schrieb Stephen Rothwell:
> Hi all,
> 
> In commit
> 
>   8c318aaa2000 ("arm64: dts: rockchip: fix Quartz64-A ddr regulator voltage")
> 
> Fixes tag
> 
>   Fixes: b33a22a1e7c4 ("arm64: dts: rockchip: add basic dts for Pine64
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags over more than one line.  Also, keep all
> the commit message tags together at the end of the commit message.

sorry about that. I've corrected the commit now to not split the fixes tag.

Thanks for catching that
Heiko



