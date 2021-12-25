Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA2247F481
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 22:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhLYVRb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Dec 2021 16:17:31 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:36982 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLYVRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 16:17:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4490962DA5F2;
        Sat, 25 Dec 2021 22:17:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ER1zF47diept; Sat, 25 Dec 2021 22:17:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B70D962DA600;
        Sat, 25 Dec 2021 22:17:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KSE9GrPRarJd; Sat, 25 Dec 2021 22:17:28 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8D66062DA5F2;
        Sat, 25 Dec 2021 22:17:28 +0100 (CET)
Date:   Sat, 25 Dec 2021 22:17:28 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     s921975628@gmail.com
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <812386103.202031.1640467048454.JavaMail.zimbra@nod.at>
In-Reply-To: <20211225100713.119089-1-s921975628@gmail.com>
References: <20211225100713.119089-1-s921975628@gmail.com>
Subject: Re: [PATCH 3/3] mtd: rawnand: nandsim: Add NS_PAGE_BYTE_SHIFT macro
 to replace the repeat pattern
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: rawnand: nandsim: Add NS_PAGE_BYTE_SHIFT macro to replace the repeat pattern
Thread-Index: 61fjJvrGx171vI1AaR1kcOjcbGH3ZA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: s921975628@gmail.com
> An: "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "RinHizakura"
> <s921975628@gmail.com>
> Gesendet: Samstag, 25. Dezember 2021 11:07:13
> Betreff: [PATCH 3/3] mtd: rawnand: nandsim: Add NS_PAGE_BYTE_SHIFT macro to replace the repeat pattern

> From: RinHizakura <s921975628@gmail.com>
> 
> The (ns->regs.column + ns->regs.off) pattern repeats a lot which
> represents the byte shift in next page to access. We can replace it
> with a macro to improve the readability.
> 
> Signed-off-by: RinHizakura <s921975628@gmail.com>
> ---
> drivers/mtd/nand/raw/nandsim.c | 19 +++++++++++--------
> 1 file changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
