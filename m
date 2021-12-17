Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70C4478B47
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhLQMTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:19:37 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:32867 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbhLQMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:19:35 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0A3BC240009;
        Fri, 17 Dec 2021 12:19:32 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        richard@nod.at
Cc:     vigneshr@ti.com, kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] mtd: rawnand: omap2: Add compatible for AM64 SoC
Date:   Fri, 17 Dec 2021 13:19:32 +0100
Message-Id: <20211217121932.327752-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211209090458.24830-5-rogerq@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'0137c74ad87316305599df8ada54de5273d868ec'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-09 at 09:04:56 UTC, Roger Quadros wrote:
> AM64 SoC contains the GPMC NAND controller. Add compatible for it.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
