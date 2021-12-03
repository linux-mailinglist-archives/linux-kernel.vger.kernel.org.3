Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D984467884
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381105AbhLCNj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:39:26 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:36165 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352598AbhLCNjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:39:25 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 038B5200007;
        Fri,  3 Dec 2021 13:35:56 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: mpc5121: Remove unused variable in ads5121_select_chip()
Date:   Fri,  3 Dec 2021 14:35:56 +0100
Message-Id: <20211203133556.1372731-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211122132138.3899138-1-geert@linux-m68k.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'33a0da68fb073360d36ce1a0e852f75fede7c21e'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-22 at 13:21:38 UTC, Geert Uytterhoeven wrote:
> drivers/mtd/nand/raw/mpc5121_nfc.c: In function ‘ads5121_select_chip’:
> drivers/mtd/nand/raw/mpc5121_nfc.c:294:19: warning: unused variable ‘mtd’ [-Wunused-variable]
>   294 |  struct mtd_info *mtd = nand_to_mtd(nand);
>       |                   ^~~
> 
> Fixes: 758b56f58b66bebc ("mtd: rawnand: Pass a nand_chip object to chip->select_chip()")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
