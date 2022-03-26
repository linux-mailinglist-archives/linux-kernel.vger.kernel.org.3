Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B064E835E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 19:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiCZSjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiCZSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:39:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CAE3D4AD;
        Sat, 26 Mar 2022 11:37:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:b:56bb:4cb:3227:231:99f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8E8FF1F44FBF;
        Sat, 26 Mar 2022 18:37:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648319847;
        bh=WpL5M5afvaRsyjt0vRxenuQV7lPtr9e1e85YRMq7SAA=;
        h=From:To:Cc:Subject:Date:From;
        b=Uk2D1+Imn20vogs40ccSplHiNLeC30QWIOdqXIs7d0op/I5zuUfGGD+wI+bsKdp3F
         FL6bsNC+dWEnbAeAYhrMWl1vdKO1o/9cpsSob+6XtM9gGMv9TS1Ip5KenNU+754A16
         SlZof0zX8yTygNIzAlBcguTUljY8WSlpqGu8QtEQkUQtbSGvRNC+qhT+wf+w0yEF0B
         LFgBN7HMln972t7lRetmVZhaq8zmgARpPCV1CTBwUJZ8s3waugqPfv6el8EqxT5s+V
         TbWRBZdbcwy6QTjr1gZm6Es9guU2/HFBCW46ibBCeNvfXwuGJp+sxrAKVG51jllyBT
         J+C7G+WUCAQIA==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rockchip@lists.infradead.org (open list:HANTRO VPU CODEC DRIVER),
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: media: hantro: Update TODO list
Date:   Sat, 26 Mar 2022 19:37:15 +0100
Message-Id: <20220326183715.67332-1-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VP8 has been added to the uABI by 363240ce1c08
VP9 has been added to the uABI by b88dbe38dca8
H264 has been added to the uABI by 46a309d27517

The last remaining codec to be added to the uABI is HEVC.
Highlight these changes in the TODO list.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/hantro/TODO | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/hantro/TODO b/drivers/staging/media/hantro/TODO
index 1d7fed936019..8483ff482146 100644
--- a/drivers/staging/media/hantro/TODO
+++ b/drivers/staging/media/hantro/TODO
@@ -1,6 +1,2 @@
-* Support for VP8, VP9 and H264 is planned for this driver.
-
-  Given the V4L controls for those CODECs will be part of
-  the uABI, it will be required to have the driver in staging.
-
-  For this reason, we are keeping this driver in staging for now.
+The V4L controls for the HEVC CODEC are not yet part of the stable uABI,
+we are keeping this driver in staging until the HEVC uABI has been merged.
-- 
2.25.1

