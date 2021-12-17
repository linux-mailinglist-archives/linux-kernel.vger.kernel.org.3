Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB8C478B41
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhLQMTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:19:22 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:57247 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbhLQMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:19:21 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 2A341240009;
        Fri, 17 Dec 2021 12:19:19 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     cgel.zte@gmail.com, miquel.raynal@bootlin.com
Cc:     chi.minghao@zte.com.cn, han.xu@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, vigneshr@ti.com, zealci@zte.com.cn
Subject: Re: [PATCH v3 nand-next] mtd: rawnand: gpmi: remove unneeded variable
Date:   Fri, 17 Dec 2021 13:19:18 +0100
Message-Id: <20211217121918.327550-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211213112627.436745-1-chi.minghao@zte.com.cn>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'35a441eea7032d08844b6466ac490a92446045fd'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-13 at 11:26:27 UTC, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return status directly from function called.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
