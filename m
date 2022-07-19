Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2E35794E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiGSII2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiGSII0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:08:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A13A1F2F1;
        Tue, 19 Jul 2022 01:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04F0FB8197F;
        Tue, 19 Jul 2022 08:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE45C341C6;
        Tue, 19 Jul 2022 08:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658218101;
        bh=Y1dwyG2xEl/XvFfnw4dxGYwQw6rsbdqsfPnpeqrw1Ls=;
        h=From:To:Cc:Subject:Date:From;
        b=FWCG2UJLO4j6PS8Yu2K7VBnrT06m6VWdsrqzbL0mQP3OLRnlhtVI6GPR7abTKhBjm
         RYO6LCw1Uap3FeDyDu6AMho+zfDxy/foUDxDmqbfBA93IrG149hY/15dZSylNrcud5
         N7aOtfYBnWNgaOQwKIC3Y3YZBC8lqPdRxmc0F8+V6SdyzXO41FBXDrQZClrD+7Gdck
         YuF56Qw/paVsu1M96Kc4iJLUpLvF2Ate3wloXv4Sz6wTSmru3PrUFcrXk4nC1z8VwO
         XBH5lK2upTuUWhCBFwIF8d5SAG5C5h4I06wWnnXAQ17KZsvGa/rKrgJ7T/BP10Fi1A
         ZDQnW5q2P3/cw==
Received: by pali.im (Postfix)
        id 8387BF3C; Tue, 19 Jul 2022 10:08:18 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew@lunn.ch>,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: arm: marvell: Add Orion codenames and archive homepage
Date:   Tue, 19 Jul 2022 10:08:07 +0200
Message-Id: <20220719080807.16729-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orion codenames are extracted from menuconfig ARCH_ORION5X and
old Orion homepage with 88F5182/88F5281 was found in web archive.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
In archived homepage are also links to erratas and other Orion documents
but apparently webarchive does not have backup copy of it :-( and Marvell
already removed all documentation from their web sites :-(
---
 Documentation/arm/marvell.rst | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index 2f41caa0096c..8540437f6a79 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -14,18 +14,20 @@ Orion family
 
   Flavors:
         - 88F5082
-        - 88F5181
-        - 88F5181L
-        - 88F5182
+        - 88F5181  a.k.a Orion-1
+        - 88F5181L a.k.a Orion-VoIP
+        - 88F5182  a.k.a Orion-NAS
 
                - Datasheet: https://web.archive.org/web/20210124231420/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-datasheet.pdf
                - Programmer's User Guide: https://web.archive.org/web/20210124231536/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-opensource-manual.pdf
                - User Manual: https://web.archive.org/web/20210124231631/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-usermanual.pdf
                - Functional Errata: https://web.archive.org/web/20210704165540/https://www.digriz.org.uk/ts78xx/88F5182_Functional_Errata.pdf
-        - 88F5281
+        - 88F5281  a.k.a Orion-2
 
                - Datasheet: https://web.archive.org/web/20131028144728/http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
-        - 88F6183
+        - 88F6183  a.k.a Orion-1-90
+  Homepage:
+        https://web.archive.org/web/20080607215437/http://www.marvell.com/products/media/index.jsp
   Core:
 	Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
   Linux kernel mach directory:
-- 
2.20.1

