Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796274F3DCE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355968AbiDEUXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443197AbiDEPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:39:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3197147AE3;
        Tue,  5 Apr 2022 06:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60F6AB81C6D;
        Tue,  5 Apr 2022 13:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109E2C385A8;
        Tue,  5 Apr 2022 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649166904;
        bh=t8pTv4fue03rDbmW0c2vFERKy3L8DUcOeDN48ij1fxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=flP9kT021gG4aSMIHS2JnxoXJiVwTz6Iy6PYbfItKeTEaEJLs/X4FSzl3/T7l3d3b
         TZLzN8JBylLtsg7zih/IWefEfixHHNkyHIdsBmJlxa1N7uva7JIMx+5hD+R8rG7NMy
         TSw0vo82sfIOY7r7olBbRXsErixaEMktVaZj9hf8NpOy/USUXOM4910eE98E6Xqlv0
         dIUwMvhzGEt6GwF4SqMoaZ2MPDgXo57dxaaGIJXO4flUS3dcZefpNNOM/vAlcVLGyw
         jWQe8aydmCs3ogiiyh9/PB5rSbNddZyQ5kGxmF0xx2XY0Frf9RLVXOUS3N2ZLgFzxD
         hg+JeeiTZVpjw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nbjeA-001q4g-0J; Tue, 05 Apr 2022 14:55:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: [PATCH v2 09/10] gpio: Update TODO to mention immutable irq_chip structures
Date:   Tue,  5 Apr 2022 14:54:43 +0100
Message-Id: <20220405135444.199295-10-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405135444.199295-1-maz@kernel.org>
References: <20220405135444.199295-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, jeffrey.l.hugo@gmail.com, tglx@linutronix.de, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5 drivers are converted, a few hundred to go. Definitely worth of
a TODO entry, in the hope that someone will notice it and do
a bulk update.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpio/TODO | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index b8b1473a5b1e..f87ff3fa8a53 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -178,3 +178,22 @@ discussed but the idea is to provide a low-level access point
 for debugging and hacking and to expose all lines without the
 need of any exporting. Also provide ample ammunition to shoot
 oneself in the foot, because this is debugfs after all.
+
+
+Moving over to immutable irq_chip structures
+
+Most of the gpio chips implementing interrupt support rely on gpiolib
+intercepting some of the irq_chip callbacks, preventing the structures
+from being made read-only and forcing duplication of structures that
+should otherwise be unique.
+
+The solution is to call into the gpiolib code when needed (resource
+management, enable/disable or unmask/mask callbacks), and to let the
+core code know about that by exposing a flag (IRQCHIP_IMMUTABLE) in
+the irq_chip structure. The irq_chip structure can then be made unique
+and const.
+
+A small number of drivers have been converted (pl061, tegra186, msm,
+amd, apple), and can be used as examples of how to proceed with this
+conversion. Note that drivers using the generic irqchip framework
+cannot be converted yet, but watch this space!
-- 
2.34.1

