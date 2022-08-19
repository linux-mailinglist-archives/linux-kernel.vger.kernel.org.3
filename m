Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964E159A62F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351271AbiHSTRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351197AbiHSTRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:17:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823E911232E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0C2A614FA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B44CC433C1;
        Fri, 19 Aug 2022 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660936624;
        bh=rKQ3+23rwRCyvKdPvoD48Z1ZJB9nDvd07zcLWzoAHuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNcbtq+NDhxyFCb2kO1Ybh5XNmCEeYoVpro0ouE5AC7RTdyYV884eYADONaMhw8os
         4FrAj2bq0Dz2R0Ylik42OTiXE/U+fHNC3dnFRma/MsH/3WPQTBOzqnWEIxQw5aa3RC
         uulwhsXDIigNKpwdiJlebJI5yt5T4GV+u7v5JuLmjz4YJ4PK/UXvyMftAHMgChro6d
         efb8P2hCaJYX+NDV38gTP+mLooB7YJWGUTBxH1l6Frv5aUfJUGQxhuXTDmOh9pNdtg
         6FYnJpzK7VELF7TOf0MfoaBNGBqdZUO95zFKjnSvaUX79U1prkU+ucypkJiv3B4Sgf
         DG0e26bSgT+Uw==
Received: by pali.im (Postfix)
        id E8CA6761; Fri, 19 Aug 2022 21:17:03 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sinan Akman <sinan@writeme.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] powerpc: dts: turris1x.dts: Remove "fsl,P2020RDB-PC" compatible string
Date:   Fri, 19 Aug 2022 21:15:57 +0200
Message-Id: <20220819191557.28116-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819191557.28116-1-pali@kernel.org>
References: <20220819191557.28116-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,P2020RDB-PC" compatible string was present in Turris 1.x DTS file just
because Linux kernel required it for proper detection of P2020 processor
during boot.

This was quite a hack as CZ,NIC Turris 1.x is not compatible with
Freescale P2020-RDB-PC board.

Now when kernel has generic unified support for boards with P2020
processors, there is no need to have this "hack" in turris1x.dts file.

So remove incorrect "fsl,P2020RDB-PC" compatible string from turris1x.dts.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/dts/turris1x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index 12e08271e61f..69c38ed8a3a5 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -15,7 +15,7 @@
 
 / {
 	model = "Turris 1.x";
-	compatible = "cznic,turris1x", "fsl,P2020RDB-PC"; /* fsl,P2020RDB-PC is required for booting Linux */
+	compatible = "cznic,turris1x";
 
 	aliases {
 		ethernet0 = &enet0;
-- 
2.20.1

