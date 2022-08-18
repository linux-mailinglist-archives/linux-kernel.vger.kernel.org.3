Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57CB598466
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245282AbiHRNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244905AbiHRNjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B19C5C35F;
        Thu, 18 Aug 2022 06:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CF20B8218A;
        Thu, 18 Aug 2022 13:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C61C43141;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=upBcvo3t5W/BE4EQxlNY6X7rXZFVscfzwvp+ClKoClE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Evo4jsj8TJpyGCvqd/F9Q3Typ3GV4aGlInDAHthaTfRUu/Ipir8Opm5NLbsGuw42N
         ahUtlS4UH+9gPFkfmGN63ztvsio8td5/ASNQC6EBbBL1t9W/9uPOPPINPVXcGgW4IS
         NimgkxOokYJxdeHNktZmKTJTQOM9GXihhCzDcznLhfyKqzDxgvZ8cv0JpoeDR6CRnM
         Tk3a3lcYB0qw+ue3Uj44dzlDMCDWsRLwZcv++D3JO75Fyy02qkr/Q+lgEvA/veoW6c
         XmgJwYtyyMnvmc8gNWfsWw5vguZ1MVTwEN8Uyw23yM3q3cFe/ZIvbgkwT43u2Ct68c
         jV/bfhgmFrrCw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY7h-GO;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] MAINTAINERS: fix a typo for hpe,gxp-spifi.yaml
Date:   Thu, 18 Aug 2022 15:38:54 +0200
Message-Id: <e3b8444a65fc698d639e1f75eff04786796b210e.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660829433.git.mchehab@kernel.org>
References: <cover.1660829433.git.mchehab@kernel.org>
MIME-Version: 1.0
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

The entry has hpe,gxp-spi.yaml instead, causing this warning:

	Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/spi/hpe,gxp-spi.yaml

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae1a12b3f090..c27a875f52b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2178,7 +2178,7 @@ M:	Jean-Marie Verdun <verdun@hpe.com>
 M:	Nick Hawkins <nick.hawkins@hpe.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
-F:	Documentation/devicetree/bindings/spi/hpe,gxp-spi.yaml
+F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
-- 
2.37.1

