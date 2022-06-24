Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27F955A109
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiFXStC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiFXStA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:49:00 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5723D7FD06;
        Fri, 24 Jun 2022 11:48:57 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A292BE0003;
        Fri, 24 Jun 2022 18:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656096535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OC0E38DGSJ88bMMABVq43rclBj3366a/y9FHzujzrXc=;
        b=gwbbaW1FT+HPQnB7ec4UXITIj46QVtADiUtWESYmQzeyY9RfT87ujfWoiWOaMAMFXU6WbA
        5Eon7Drs4MnSG4Xa7z26QBjx3u72J+oA463lnkYv7cQS1lqdIp0Qo0rz/hJLY4e6XgrK7A
        WzeHeJIdv41ze2DecUptKbzGk+JYWm+Ch1WraAkf2AITmVp1TjIO55Jh5FMxeqmPS3sZ+g
        sy/a/n5itcDLVKYGydFgMg6jDvEd6e5iQtFxeFDySWDoSxssVd8N9xmOsuexYJh6edoeIx
        GW5OPnvNe7IzVP3WhAwVgWmcvvkgrMD44Eqdx5+F2oVwdccjlHQSGXcp/ecexg==
From:   miquel.raynal@bootlin.com
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: hyperbus: rpc-if: Fix RPM imbalance in probe error path
Date:   Fri, 24 Jun 2022 20:48:53 +0200
Message-Id: <20220624184853.1888023-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <f3070e1af480cb252ae183d479a593dbbf947685.1655457790.git.geert+renesas@glider.be>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c223a38d62e57aa60a890ea7247e3c58a54478e6'
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

On Fri, 2022-06-17 at 09:26:51 UTC, Geert Uytterhoeven wrote:
> If rpcif_hw_init() fails, Runtime PM is left enabled.
> 
> Fixes: b04cc0d912eb80d3 ("memory: renesas-rpc-if: Add support for RZ/G2L")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
