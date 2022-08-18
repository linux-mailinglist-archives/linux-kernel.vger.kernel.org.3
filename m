Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA8598455
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbiHRNkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244911AbiHRNjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C256B8A;
        Thu, 18 Aug 2022 06:39:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87380B82189;
        Thu, 18 Aug 2022 13:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766E4C43470;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=VGsf+vOJizO37YNi0SVq139TGkjumGg6u2GlzchFHEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJNxeW9GnTkJT3cjHUJLuJcdqGlHqI0bKVgWZw2KMauxhdd5yy7tsq2HMQmmitZ8c
         ki1JBc6yKEawWYwzeP4MZ+9+12Htes4klyr9j06yaVKRr+oUoaFzcaUOj581tS3UwU
         oMK2MsqcA2P0qHCog3Q0JT216gBEhgY/HPciLzLJ3DuaaLvSI/P24PJ/Q/bLeVxK/w
         KDAkzt+d5qxBiaPduOQnmqc/VOwjKr7eAl7owE/Kj4vYgW+1BAYa78aH4KIY7jgkGr
         i5fm75KMiWf4mo5qsNFA8Z6ES5arh/wC2/I44O+kRwdbc/DaUV1KPOIvei1dkANN2s
         BaoUkpyKXcamQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY7d-FG;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] MAINTAINERS: fix wildcard for mfd da90* files
Date:   Thu, 18 Aug 2022 15:38:53 +0200
Message-Id: <bd86bebf0aef05a6591085205f50bbf89922de00.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660829433.git.mchehab@kernel.org>
References: <cover.1660829433.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this warning:

	Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/mfd/da90*.yaml

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..ae1a12b3f090 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6011,7 +6011,7 @@ W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
-F:	Documentation/devicetree/bindings/mfd/da90*.yaml
+F:	Documentation/devicetree/bindings/mfd/dlg,da90*.yaml
 F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
-- 
2.37.1

