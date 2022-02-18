Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104DB4BBAA8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiBROdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:33:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiBROdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:33:06 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE825AE66
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:32:48 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E6FF96000C;
        Fri, 18 Feb 2022 14:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645194766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XqG26Ms+nCyJQFkDdv7qdOPbNCR+/tuROMVYtpDW7X4=;
        b=D9LPwQKnluzG9sWIJTQvS/yM99Bi7XXgV4WtxL32zDgenwVACaov8tBREYwdK044wrla7n
        7dfuUePlqtvliEq7+wYmRHVa0UXDs3LfvM/OPKOMLgKuZrKyL5F+lZdKpmSTESgcfb6gyZ
        MI7Y/U9VeopddbrHwJvoC/mI947YsRKxZ7B6fh2exVYph+0ZQjwcupmw1bfOm02c6o9TLA
        gZ8C+h4ZOwP6NNFo02P9OmquhuDzbQaRClzOGm2Xv4ssHJl0PiuSbIZGJO9j0x8pt2d1bX
        cW43r+5UnHEUQ6ERpNZxO7swdmxu48HFEGAPSvRR3zIwM8cEmy0XKXnQSh6eCQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     rafal@milecki.pl, baruch@tkos.co.il, hauke@hauke-m.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: trx: allow to use on MediaTek MIPS SoCs
Date:   Fri, 18 Feb 2022 15:32:44 +0100
Message-Id: <20220218143244.321862-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220213064045.1781-1-musashino.open@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2365f91c861cbfeef7141c69842848c7b2d3c2db'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-02-13 at 06:40:44 UTC, INAGAKI Hiroshi wrote:
> Buffalo sells some router devices which have trx-formatted firmware,
> based on MediaTek MIPS SoCs. To use parser_trx on those devices, add
> "RALINK" to dependency and allow to compile for MediaTek MIPS SoCs.
> 
> examples:
> 
> - WCR-1166DS  (MT7628)
> - WSR-1166DHP (MT7621)
> - WSR-2533DHP (MT7621)
> 
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
