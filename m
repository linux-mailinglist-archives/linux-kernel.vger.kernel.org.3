Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AB347F47D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 22:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhLYVK6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Dec 2021 16:10:58 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:36890 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhLYVK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 16:10:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DDCEC62DA5F2;
        Sat, 25 Dec 2021 22:10:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2nHCJFw-JoPn; Sat, 25 Dec 2021 22:10:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 79A5962DA600;
        Sat, 25 Dec 2021 22:10:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IUBUKu06XHCJ; Sat, 25 Dec 2021 22:10:56 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5427962DA5F2;
        Sat, 25 Dec 2021 22:10:56 +0100 (CET)
Date:   Sat, 25 Dec 2021 22:10:56 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     s921975628@gmail.com
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1212908852.202017.1640466656269.JavaMail.zimbra@nod.at>
In-Reply-To: <20211225100648.119011-1-s921975628@gmail.com>
References: <20211225100648.119011-1-s921975628@gmail.com>
Subject: Re: [PATCH 2/3] mtd: rawnand: nandsim: Merge repeat codes in
 ns_switch_state
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: rawnand: nandsim: Merge repeat codes in ns_switch_state
Thread-Index: fv0rjzqWWQR1xTfN26WhgafFcDHqNw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: s921975628@gmail.com
> An: "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "RinHizakura"
> <s921975628@gmail.com>
> Gesendet: Samstag, 25. Dezember 2021 11:06:48
> Betreff: [PATCH 2/3] mtd: rawnand: nandsim: Merge repeat codes in ns_switch_state

> From: RinHizakura <s921975628@gmail.com>
> 
> The moving block of codes is shared between both 'if' and 'else' condition,
> we can move it out to reduce the duplication.
> 
> Signed-off-by: RinHizakura <s921975628@gmail.com>
> ---
> drivers/mtd/nand/raw/nandsim.c | 19 ++++++-------------
> 1 file changed, 6 insertions(+), 13 deletions(-)

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
