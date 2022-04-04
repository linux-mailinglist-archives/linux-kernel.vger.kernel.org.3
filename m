Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CDD4F1133
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbiDDIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbiDDItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:33 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628043B56E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:47:34 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C2C3E1BF209;
        Mon,  4 Apr 2022 08:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649062052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNAxKX1DSgvz6AgiA/E8PDeYrkr/tq8/0jpvO7zkYKA=;
        b=MWyMzEJux6rUSkSI4iNvYHWv4pptdpWTTAYtJtnj4JYhcFk2awEYuxWRvofXaFDY5GqpqL
        Reef/ZEeNPsMTmdf6OEp1/CI4ZnnCT3Xo3q2yyMks0DnOB/32eLObnJjQvkSk23aXOfmQW
        ycmRuTH3eR2LKXQ4xW09xx/nyP9krkRg/4XwZebyPwaW99ojZoquI4ENd5EeGF5axZF34x
        zTTvmOpzrSDFogMtxoFxCIV5uHrLPxpdgmggi1Jp6zxNk/tUF15cAmfaUdZqsToIOCrOr1
        WxgUAu52/YJpkI+bWj1Uh3XQjcqiN9pgYB5ppuVj3K1qxKntMg5X4c86gf0xhQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wang Weiyang <wangweiyang2@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, paul@crapouillou.net
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mtd: rawnand: davinci: Remove redundant unsigned comparison to zero
Date:   Mon,  4 Apr 2022 10:47:30 +0200
Message-Id: <20220404084730.1203812-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220317113907.96006-1-wangweiyang2@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6425dd136ddc40fc434156d1957a3adb367dd874'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-17 at 11:39:07 UTC, Wang Weiyang wrote:
> Since core_chipsel is uint32_t, comparison to zero is redundant
> 
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
