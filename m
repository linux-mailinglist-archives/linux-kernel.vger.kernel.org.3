Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA1247F478
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 22:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhLYVJQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Dec 2021 16:09:16 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:36842 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhLYVJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 16:09:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 11A0662DA5FC;
        Sat, 25 Dec 2021 22:09:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Bg8XwaZeuqhX; Sat, 25 Dec 2021 22:09:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6657B62DA5FE;
        Sat, 25 Dec 2021 22:09:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mw8hxNWzmAu2; Sat, 25 Dec 2021 22:09:13 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3CB8762DA5FC;
        Sat, 25 Dec 2021 22:09:13 +0100 (CET)
Date:   Sat, 25 Dec 2021 22:09:13 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     s921975628@gmail.com
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2117882647.202013.1640466553090.JavaMail.zimbra@nod.at>
In-Reply-To: <20211225100607.118932-1-s921975628@gmail.com>
References: <20211225100607.118932-1-s921975628@gmail.com>
Subject: Re: [PATCH 1/3] mtd: rawnand: nandsim: Replace overflow check with
 kzalloc to single kcalloc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: rawnand: nandsim: Replace overflow check with kzalloc to single kcalloc
Thread-Index: CqwQUojoaEMANy6nm1uPcdApakVc/w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: s921975628@gmail.com
> An: "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "RinHizakura"
> <s921975628@gmail.com>
> Gesendet: Samstag, 25. Dezember 2021 11:06:07
> Betreff: [PATCH 1/3] mtd: rawnand: nandsim: Replace overflow check with kzalloc to single kcalloc

> From: RinHizakura <s921975628@gmail.com>
> 
> Instead of self-checking overflow and allocating an array of specific size
> by counting the total required space handy, we already have existed kernel
> API which responses for all these works.
> 
> Signed-off-by: RinHizakura <s921975628@gmail.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
