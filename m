Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91657478B45
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbhLQMTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:19:33 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:49393 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbhLQMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:19:31 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A2889200003;
        Fri, 17 Dec 2021 12:19:28 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        richard@nod.at
Cc:     vigneshr@ti.com, kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mtd: rawnand: omap2: fix force_8bit flag behaviour for DMA mode
Date:   Fri, 17 Dec 2021 13:19:28 +0100
Message-Id: <20211217121928.327685-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211209090458.24830-6-rogerq@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4695a3cf004a44a8d196d7c2f23d46efca0f92e3'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-09 at 09:04:57 UTC, Roger Quadros wrote:
> In DMA mode we were not considering the force_8bit flag.
> 
> Fix it by using regular non-DMA 8-bit I/O if force_8bit flag is set.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
