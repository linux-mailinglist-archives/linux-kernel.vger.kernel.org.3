Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE74950995A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385886AbiDUHiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385852AbiDUHif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:38:35 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204EE65E8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:35:45 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C6D43FF807;
        Thu, 21 Apr 2022 07:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650526544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6B9/vGKb6GFVKIWK870M2LhRzeaUO9FQsN+gmFY9sY=;
        b=GRibdnYBVDXPW0Cl4BbygZ/1rlhXSIeVzPv3qr9b6qSpiDlIQYgl3JSNeEEfbOR4iquXLy
        hp+ZZkS9OdfUwg0KkpXWwODHe6bP/mD6GnxFNbyu0xt8zKRejak4ILQnjFs4nDLx0SeCra
        Ge+8nyQ6ziBduTgpX6vhMJ641H9RfFKPQemZVo74qN07317SjHl9HqaczJMtkscRixHBCu
        h51M++fl/zUDbSJ1//OdSFtHI0Y9nYuNgB7zjyspKWU/yb5CLOF78CiIDXprbtTF6RUcNE
        k9KtDz4F3b0Y0WLXXNaGrqGiwHFC9xQvgaCJ25CxGbPnL2hFFq/yyZpZq8sKtA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mtd: mtdoops: Add a timestamp to the mtdoops header.
Date:   Thu, 21 Apr 2022 09:35:43 +0200
Message-Id: <20220421073543.71887-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415001321.252848-4-jmeurin@google.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f812679fab605b3d5b853ed24a81dabb222ea23a'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-15 at 00:13:21 UTC, Jean-Marc Eurin wrote:
> On some systems, the oops only has relative time from boot.
> 
> Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
