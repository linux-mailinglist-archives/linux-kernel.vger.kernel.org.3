Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9013A4BBAB6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiBROdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:33:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiBROdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:33:15 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BC25AE66
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:32:58 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A16FC10000A;
        Fri, 18 Feb 2022 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645194776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0DovIIcQK61e6vtfVFHZ8ExmWLz/vfcmAhthQ9qt5I=;
        b=NsnKIKpzvKlPr/ZTFjUZJBheVPeOCCD8tjVse3G7bQw5RYMZJla4IITMCmci7PSrHWBLH0
        LX05AS+xbTIUSusAzZ4TE5GARhU3Qo3m2G7sGaKRp/zM7+3i/eUdzmgI19XRvjBaNPKbpB
        f7ezJ2Wz5scXCcNkGN0eML4nEX/P63TR4cvIzdPzk7uvQt+gDq/JsrPgjalYII8VZ8vI3Q
        +jTAdh4wtN77Vmzcc/Kzb4sj38DFqxpX3/C4G4APYfmHPtpMPvjyShzN123kPW1APZX3Vq
        r0KjLZTGpj4fC2UpjeWYXTHvW667Rv+QzaECuqkT+0gh1q+Kb7FHVoedB97HCQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kernel-janitors@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] mtd: spear_smi: use GFP_KERNEL
Date:   Fri, 18 Feb 2022 15:32:55 +0100
Message-Id: <20220218143255.321991-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220210204223.104181-8-Julia.Lawall@inria.fr>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ccb7bc50177c5e94e0609126654abeb4f3b67819'
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

On Thu, 2022-02-10 at 20:42:21 UTC, Julia Lawall wrote:
> Platform_driver probe functions aren't called with locks held
> and thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.
> 
> Problem found with Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
