Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CEF5A283A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245296AbiHZNFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243071AbiHZNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:05:22 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4671AD8E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:05:20 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id BCB39E000F;
        Fri, 26 Aug 2022 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661519119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7OyRZY4g5kfDW1iLqZHViQBpjSFTcT287Hu+3zMoQc4=;
        b=OUSyqvciYGKzqnWJUGNawWa7610VpLhozz0S0q36TbUBpYvGzzKYwagspJS/Qe/x2aBGab
        1+Rj5Yu1qsXaI2xFECA1AK0UBTU1kz5OirupxyBP9JFmiW1g7lTtDWbXvp4MH9pceTG0ls
        9bp2Lad6o89gCvSvPb9GluhdH+lzz/VzmllHoqGXz3sAvXn2+m1NsoDraULKiB8Z2zlp2G
        Z4euqpEMzm/8UU5Mjw5MqWN/PCDuhgLzXsArkos2Sk1dqOMZwXpteu4bqE8DyMpCb55M/q
        PH1Ncgwj2/XTQYlNYyTzfObs2HfHRnNA988RId5cxCI5j6KgumlRwwdgoPMUWg==
From:   luca.ceresoli@bootlin.com
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Atish Patra <atishp@atishpatra.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] .mailmap: update Luca Ceresoli's e-mail address
Date:   Fri, 26 Aug 2022 15:05:15 +0200
Message-Id: <20220826130515.3011951-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

My Bootlin address is preferred from now on.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 38255d412f0b..0ea9b684134b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -253,6 +253,7 @@ Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
 Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
 Lorenzo Pieralisi <lpieralisi@kernel.org> <lorenzo.pieralisi@arm.com>
+Luca Ceresoli <luca.ceresoli@bootlin.com> <luca@lucaceresoli.net>
 Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
 Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
 Maciej W. Rozycki <macro@orcam.me.uk> <macro@linux-mips.org>
-- 
2.34.1

