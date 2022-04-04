Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C58A4F112C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiDDItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiDDItH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:07 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B927E1659C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:47:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1FF51C000B;
        Mon,  4 Apr 2022 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649062030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYj0xUbR/390/lWkvin+TtsUFeDx/rVngOIwhFcGEg4=;
        b=UasxRTe509xU/K1YhL3DoCA7n6MSOjOI+4FkVLF/VrLLyNZ7VRZHMl/s1oSzm2LSwwCMmM
        uPFqVnYH4jDMGh/rTQLZjljXYDc2nljmbR1HlKPpGkhd9Y2H/bIkoeUK0pOxvcV+xVLqN9
        2HSe4gQrCW4v1XevCkzIOpQoxoDEmJgYgT6FYDke80GDjvlO8hL6SnS71xoNvMMFmDa6WA
        3wwFZx6gk7ebSpfbAWrHsI5nIVc2Amp4Uz/55vLdejIRhkMuTntLrJwB4uBCg2d04vK03K
        XRdQvU8JSN6TuCCyuTf1JTeJsmt1WViu06QTo9tvW3a0F+ent829GrZ3mqO+xw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Roese <sr@denx.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 5/5] mtd: spinand: gigadevice: add support for GD5FxGM7xExxG
Date:   Mon,  4 Apr 2022 10:47:07 +0200
Message-Id: <20220404084707.1202272-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220320100001.247905-6-gch981213@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'54647cd003c08b714474a5b599a147ec6a160486'
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

On Sun, 2022-03-20 at 10:00:01 UTC, Chuanhong Guo wrote:
> Add support for:
>  GD5F{1,2}GM7{U,R}ExxG
>  GD5F4GM8{U,R}ExxG
> 
> These are new 27nm counterparts for the GD5FxGQ4 chips from GigaDevice
> with 8b/512b on-die ECC capability.
> These chips (and currently supported GD5FxGQ5 chips) have QIO DTR
> instruction for reading page cache. It isn't added in this patch because
> I don't have a DTR spi controller for testing.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
