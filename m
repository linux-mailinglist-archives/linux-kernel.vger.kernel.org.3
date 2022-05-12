Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B98C525144
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355944AbiELP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355954AbiELP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:27:48 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783876FD3B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:27:46 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0BD18FF80F;
        Thu, 12 May 2022 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652369264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=so0UQipUdKDe8ooC1ldtUKaBqHHt2wI5r8cjBJFcJKM=;
        b=aFBXvEVBwohTzze5N6XsrVxq2wyQUP0l5BDHVk0yiodNk/xZfl2nrxxfWPOPWtxXTRyKWD
        MbEEvRzD1lsTnHoluE5edyGBPQW1+qItAoHUIQvIln4Bw5a53Jd3F8pGwZAU0+yd0Cgneh
        IMyi+8Q0a0iGuYcUQq+rlEZeGcfpPNU2RJiC3zW2ciG42RG10SwiAv/3UCHRKZoFWZUZiQ
        44qBY5YsFMgJb8bb0tRpsty4i6iexoe6OefVN3rVAxgPamkc0SLHhF6ZCGdol+ipyhUGko
        K7gDMA/Cs6ipAIuArg6gqPd+75K3fic9NEeJw2cfTkGMh9j9b5GCMaWsIA9LYA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: MTD_NAND_ECC_MEDIATEK should depend on ARCH_MEDIATEK
Date:   Thu, 12 May 2022 17:27:43 +0200
Message-Id: <20220512152743.245075-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To:  <bb9568e825d4bc7506870b03836baa91bcc4b725.1652104136.git.geert+renesas@glider.be>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'66d7a40beb413815a5b1adbc1558200f5b18d817'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-09 at 13:50:02 UTC, Geert Uytterhoeven wrote:
> The MediaTek Hardware ECC Engine is only present on MediaTek MT27xx and
> MT76xx SoCs.  The driver for this engine is a dependency for the
> MediaTek NAND controller (MTD_NAND_MTK) and the MediaTek SPI NAND Flash
> Interface (SPI_MTK_SNFI) drivers, both of which already depend on
> ARCH_MEDIATEK.
> 
> Hence add a dependency on ARCH_MEDIATEK to the Hardware ECC Engine
> driver, too, to prevent asking the user about this driver when
> configuring a kernel without MediaTek SoC support.
> 
> Fixes: 4fd62f15afa0d0da ("mtd: nand: make mtk_ecc.c a separated module")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
