Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3093F576355
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiGOOD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiGOODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:03:22 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E8E24941
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:03:19 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id vS3J270064C55Sk06S3JUd; Fri, 15 Jul 2022 16:03:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oCLuX-003gpX-Ke; Fri, 15 Jul 2022 16:03:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oCLuX-00EDeU-80; Fri, 15 Jul 2022 16:03:17 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] of: overlay: Miscellaneous improvements
Date:   Fri, 15 Jul 2022 16:03:13 +0200
Message-Id: <cover.1657893306.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

While performing the long-overdue rebase of my topic/overlays branch[1]
on top of the overlay rework in v5.19-rc1, I identified a few areas for
improvement in the upstream code.

Thanks for your comments!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/overlays

Geert Uytterhoeven (2):
  of: overlay: Move devicetree_corrupt() check up
  of: overlay: Simplify of_overlay_fdt_apply() tail

 drivers/of/overlay.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
