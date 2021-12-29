Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F84817C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 00:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhL2Xgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 18:36:33 -0500
Received: from mx4.wp.pl ([212.77.101.12]:53998 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233173AbhL2Xgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 18:36:31 -0500
Received: (wp-smtpd smtp.wp.pl 20575 invoked from network); 30 Dec 2021 00:36:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1640820988; bh=Y0bGhXdA3OCCw3SGzpE2xChPnT34j9pd/MATnp0FXmg=;
          h=From:To:Subject;
          b=CHgBCQ9YzX/pUQXY9O3zLDWKBWA++/E/bwZ4oHecpWD2HxT3k0L+eEhbfQBlRtLQP
           wzRRBs8lqv7eMbACHuKS/FuD49Dl120SzTOeLrO/scEnRVcXJnK8udYWPUsRrelLJ4
           48n080yHK29ADA2nkQulVPTD1lW7OYE6ZkYgEaKc=
Received: from riviera.nat.ds.pw.edu.pl (HELO LAPTOP-OLEK.lan) (olek2@wp.pl@[194.29.137.1])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 30 Dec 2021 00:36:28 +0100
From:   Aleksander Jan Bajkowski <olek2@wp.pl>
To:     davem@davemloft.net, kuba@kernel.org, olek2@wp.pl, jgg@ziepe.ca,
        rdunlap@infradead.org, arnd@arndb.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: lantiq_etop: remove multiple assignments
Date:   Thu, 30 Dec 2021 00:36:26 +0100
Message-Id: <20211229233626.4952-1-olek2@wp.pl>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: b4f0a1f4eb84c22c020eeb761172e62d
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IZPU]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/coding-style.rst says (in line 88)
"Don't put multiple assignments on a single line either."

This patch fixes the coding style issue reported by checkpatch.pl.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/ethernet/lantiq_etop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 072391c494ce..d96cc8ef3039 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -270,7 +270,8 @@ ltq_etop_hw_init(struct net_device *dev)
 		int irq = LTQ_DMA_CH0_INT + i;
 		struct ltq_etop_chan *ch = &priv->ch[i];
 
-		ch->idx = ch->dma.nr = i;
+		ch->dma.nr = i;
+		ch->idx = ch->dma.nr;
 		ch->dma.dev = &priv->pdev->dev;
 
 		if (IS_TX(i)) {
-- 
2.30.2

