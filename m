Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFCA4F1130
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiDDItX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbiDDItU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:20 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990EC3AA5A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:47:24 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DD4EBC0009;
        Mon,  4 Apr 2022 08:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649062042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hJ0vCytaTI0HqUjXr+swIRK6As2mValu0X3WcDyz8EE=;
        b=TkSpf/VOzEw9QZNfw2t3lr6Z4cC0H3IeOmv5WlXO9f0rSBgNHgsXndLJS8Tk4G2HPZPqc0
        qHEIF8+D3ETz/s2qJ9H3nVKlc6JlqAKk0cV+jcnV7a4TvgeDfp1h/Lk4ERZSBb5NeO7OY9
        9n5yd6nKETrqXqIc/qSgL5R54q/nZGuaWvVHmDXEt514WVucs/GcVH+j0z/eDudcP1bhVA
        WKr1EoVLGqEaxmHAMHDw/xrLAgRB+emNdC9Lu9yFwEUIsMdj1WYZFfib5uX6HP90gyMpmm
        GRQPEFczg/9XOloh80hIDDl7sVeE3G9c6edjWixnYvrWdaM8AtcC8xN3dD50Xg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Roese <sr@denx.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 2/5] mtd: spinand: gigadevice: add support for GD5FxGQ4xExxG
Date:   Mon,  4 Apr 2022 10:47:21 +0200
Message-Id: <20220404084721.1202925-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220320100001.247905-3-gch981213@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'573eec222bc82fb5e724586267fbbb1aed9ffd03'
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

On Sun, 2022-03-20 at 09:59:58 UTC, Chuanhong Guo wrote:
> Add support for:
>  GD5F1GQ4RExxG
>  GD5F2GQ4{U,R}ExxG
> 
> These chips differ from GD5F1GQ4UExxG only in chip ID, voltage
> and capacity.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
