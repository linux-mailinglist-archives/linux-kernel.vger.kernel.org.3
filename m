Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E0749726F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiAWPXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:23:42 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48211 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiAWPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:23:41 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 167BD20003;
        Sun, 23 Jan 2022 15:23:32 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: ingenic: Fix missing put_device in ingenic_ecc_get
Date:   Sun, 23 Jan 2022 16:23:32 +0100
Message-Id: <20220123152332.529757-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211230072751.21622-1-linmq006@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ece94312ff9b6bd0681d474606736410eccdbb8d'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-30 at 07:27:51 UTC, Miaoqian Lin wrote:
> If of_find_device_by_node() succeeds, ingenic_ecc_get() doesn't have
> a corresponding put_device(). Thus add put_device() to fix the exception
> handling.
> 
> Fixes: 15de8c6 ("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
