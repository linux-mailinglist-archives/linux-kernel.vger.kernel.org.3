Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3604E8B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiC1BYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiC1BYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:24:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B34F455;
        Sun, 27 Mar 2022 18:22:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B6C925C00DF;
        Sun, 27 Mar 2022 21:22:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 27 Mar 2022 21:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; bh=yEJO//k7VFhFrahKidO0x8PMYk2Dpf2cUnMzGo6EOKU=; b=B75mo
        T+vSPJdV+27dtbB2hrUMO+99edMO+c2w4JakllN88EqlnYj8sb9Xlh8Iplyt5ZGn
        2pHzztQ/04VzuONHdjK67gNbv/445svfA8+eUMJMJ1m3tIzE4Mar5vZphFX8UQw5
        MsLNseP1nBYN+OGPLIEMJ3HWtFHQ81urGmKUx+O/LqnVixHVBpjeGhypoUpGlwVU
        5+aPntpEicUMQGok4izXPamkEfmIL3/jK+E2JAQfY7e9tismDQmqDfJH4g63J7SL
        pS6UB21YnHqXs/UZfJftgMg2RY6WIHxP+4kPi0EzhxgOaJpYRCb8Ar2GM4h4E4nQ
        3clxTUoVLnSYNSAaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=yEJO//k7VFhFrahKidO0x8PMYk2Dp
        f2cUnMzGo6EOKU=; b=FAdrmKzrEoHdPmqz5XoPKu7VkCm1dDUh/3z29XiGsxpTi
        44Qbvf84tyeMoKd9oZopVrsRZCK5XNvvlAHSw12CpUisexygY9qr/PJEHhNYnknT
        BX/okJjZjs9FvW4XzuaR+zs0bk7JxBZ2nbUWAm6P64z2BQrjLLR9looO/QCu9HY2
        7orZrApc0OMYF4r4T6frsHND2U/rSRQlfeW3FYYRRW3qRzyiSFdYv4IB2n1YH7bK
        yL71tkIOaVoFWrsVy0AwbpT4NIeyDxeq0kKLcMsiOPdap+MeEWKcA30g26IjtHCI
        ylbISJnq6VARPfZp7Vm4RRi+UlJpJs7E/cfn9HEcg==
X-ME-Sender: <xms:yQ1BYqbTBdESdIWAu6-BMOCzQCb4kHI0gouTyaApxT6LH4prDg-9BQ>
    <xme:yQ1BYtZdoJTZzwHleTSpClzTgYEUFJ4SjOqENFpAXHQlPizZti-92X-M38owGZlgJ
    uF7bNXV5XPFUHCWwQ>
X-ME-Received: <xmr:yQ1BYk-QPmk9d3NkVd7F3cyiPpuInuneKiDa77AnH9dp-cQB1Pv1L35nvqqYLnpDIVePtNWAA0Ui1k2O57sGbLmhRJYotux7vUkcVnrFgQ5qlTsCj05UUNy3gQ61qKSgJh3ZA-Yo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehiedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuggftrfgrthhtvghrnhepieetheduveelhfdvvdejleeuhfelteevhe
    ffgfeitdefgeekjeefieevgfehhefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:yQ1BYsrXAdX0Ze1HgG1ILjZZS1FNDZMDoxe_L-R2LPQpkrexNKjrQg>
    <xmx:yQ1BYlohJLCZWngt62OJzy634itwmH_hXZ3FmZ-Qd7QOXlwKg0U5pg>
    <xmx:yQ1BYqSrN8HTCHl56c6Y77LbiYNo9064lxLvC16yC8nKoH1paz0quw>
    <xmx:yQ1BYuDedaL5p3itJGbFL9MscFTDzASDNSJP_PlpWOpuqBGZ_K3rNg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Mar 2022 21:22:14 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-leds@vger.kernel.org
Cc:     pavel@ucw.cz, jacek.anaszewski@gmail.com, clg@kaod.org,
        joel@jms.id.au, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] leds: pca955x: Remove unused pca95xx_num_led_regs()
Date:   Mon, 28 Mar 2022 11:52:05 +1030
Message-Id: <20220328012205.91454-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 561099a1a2e9 ("leds: pca955x: add GPIO support") removed the
remaining use of pca95xx_num_led_regs(). Recently the kernel test robot
started complaining about the unused symbol after some patches to the
driver were merged[1]. Drop the unused function.

[1] https://lore.kernel.org/all/202203260634.OFB2IPFf-lkp@intel.com/

Fixes: 561099a1a2e9 ("leds: pca955x: add GPIO support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/leds/leds-pca955x.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 81aaf21212d7..33ec4543fb4f 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -145,12 +145,6 @@ static inline int pca95xx_num_input_regs(int bits)
 	return (bits + 7) / 8;
 }
 
-/* 4 bits per LED selector register */
-static inline int pca95xx_num_led_regs(int bits)
-{
-	return (bits + 3)  / 4;
-}
-
 /*
  * Return an LED selector register value based on an existing one, with
  * the appropriate 2-bit state value set for the given LED number (0-3).
-- 
2.32.0

