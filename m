Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C8C4D88A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242824AbiCNQAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242820AbiCNQAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:00:51 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C3C41317
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:59:41 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 384F510000A;
        Mon, 14 Mar 2022 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647273579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JwmrT3N51UDTQkNWAqjGH3nBXGvEDGlQeAp5osaeVWQ=;
        b=V4xzRvvcGOB5PuDXj1eyj1s05tnQqZIpJ5D7ScqLr1ew6OoCwNNjk/PrkR41+Rj7NzEmWF
        lJ+OFE4E2N3Q1ITLXeM9PEnhJ6pnun0YoXQtx/bJ9aGOaafqNQUCv1tV6LZAu8BZOOaFsD
        0pAugptAbHv+4bBZ9RJp4ki6rgLqpmLvIweIpZ3fpuvgQiGdftKg2C5mln9FFhhBj5s0le
        1R4XYg2NkIPhxLOtyz6QAeJPHcxSkzb/nFtIaLs5FResPZQqRemi2Co2EWPmVjpwquK9Ku
        otEui5sspGBtCYGf3pEE9K4mlnzEgZWnAOms6RpZr2Mf8yKP8NfwtVjcpI6L0Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: hyperbus: HBMC_AM654 should depend on ARCH_K3
Date:   Mon, 14 Mar 2022 16:59:38 +0100
Message-Id: <20220314155938.77206-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To:  <9fd6b975adba710158f28aa603cf87a6d189a418.1646655894.git.geert+renesas@glider.be>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'572ff6514b7d7179bc2c227c5ce1483f664564e5'
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

On Mon, 2022-03-07 at 12:27:02 UTC, Geert Uytterhoeven wrote:
> The AM65x HyperBus controller is only present on Texas Instruments AM65x
> SoCs.  Hence add a dependency on ARCH_K3, to prevent asking the user
> about this driver when configuring a kernel without support for the
> Texas Instruments Inc. K3 multicore SoC architecture.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
