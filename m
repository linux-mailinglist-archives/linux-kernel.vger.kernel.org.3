Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82934D88A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiCNQAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiCNQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:00:49 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4B6369DB;
        Mon, 14 Mar 2022 08:59:38 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 343C1100003;
        Mon, 14 Mar 2022 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647273575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YCLrsONXQ1StYZSTmk+RDGt9dvHeLr+NavdIziVYykA=;
        b=mg2UgiMuVibybCKpDD7L4INsKkLbnH5YQHu31g+/9eh7COfqfDdDQBV1wg7GDd3fO5eTbo
        Gbvrg25OkAsnwS7RZbKzqrgkoWRxMUEAz/XQasK28fywrQu07bEGJtskuDmJe+xsQ+vzYO
        eHItl8lK+B+DlzXAvlqtxD6LpxYtZcYQN9FxBrOaGhCZM4t3vS4ClHKCXIjgEa0vQ7xmNB
        yKd1ZgkmzGX7s+XkeMbXfKkQoacaHhk639nhPmiI2T3sGsLYXPjvKTGMnSqRpizDJFo+mp
        ZnNJ+bcMFwDqCER53U8PGTqCg8OnLISu3ZJtAhwQiEkcrkQYSHpG7Z43FzWr1Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: nand: mxic-ecc: make two read-only arrays static const
Date:   Mon, 14 Mar 2022 16:59:33 +0100
Message-Id: <20220314155933.77142-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307230940.169235-1-colin.i.king@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'12e0b9742cc735aa317e8273b98c8575cc0bd444'
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

On Mon, 2022-03-07 at 23:09:40 UTC, Colin Ian King wrote:
> Don't populate the read-only arrays possible_strength and
> spare_size on the stack but instead make them static
> const. Also makes the object code a little smaller.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
