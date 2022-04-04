Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACCF4F1132
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiDDItb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbiDDItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:24 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BBD3AA74
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:47:28 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1D7D2C0003;
        Mon,  4 Apr 2022 08:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649062047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CN1L5JMzqSJ+k18AcK0l2a4ZU5bLh8AcVNfN1XQQ0W4=;
        b=R2ej3LROgUy4NFcFjYBZBe2JlZHew4uPRHPCJlb2E68dnyM+RBSvtzwT9tPskEi98Tbibu
        vrft3h3fLHaYKyX+KGKE4CfjkrycZ+8JFJRPXLgPD60tHCWmd0TH3F+SAprzbCvuZgUlYl
        donTKVzKkGCKUP/GYI+h+FYB3zbbZXrqGplqfV3Xzk3VpSyLOyG7dQ92GefsWOp1xOQO6o
        KtzZibzzT6a+rWbnehPL3qtoSh8tu4/YVc7CJ6sN/fnMyYsejLp6fI1KI5UyVXZSpGucvO
        /QT3O9Yboc0UX6tx61vmLOc0UFWCU5pL5zjM4teo+ovuS0kIVQCpZZglzkKsgQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Roese <sr@denx.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 1/5] mtd: spinand: gigadevice: fix Quad IO for GD5F1GQ5UExxG
Date:   Mon,  4 Apr 2022 10:47:25 +0200
Message-Id: <20220404084725.1203270-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220320100001.247905-2-gch981213@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a4f9dd55c5e1bb951db6f1dee20e62e0103f3438'
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

On Sun, 2022-03-20 at 09:59:57 UTC, Chuanhong Guo wrote:
> Read From Cache Quad IO (EBH) uses 2 dummy bytes on this chip according
> to page 23 of the datasheet[0].
> 
> [0]: https://www.gigadevice.com/datasheet/gd5f1gq5xexxg/
> 
> Fixes: 469b99248985 ("mtd: spinand: gigadevice: Support GD5F1GQ5UExxG")
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
