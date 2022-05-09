Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC64851F829
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiEIJcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiEIJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:30:23 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616431C3465;
        Mon,  9 May 2022 02:26:29 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C332200E7E;
        Mon,  9 May 2022 11:26:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 35FE9200E85;
        Mon,  9 May 2022 11:26:28 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 81BD6180031E;
        Mon,  9 May 2022 17:26:26 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: dt-bindings: fsl,micfil: Add compatible string for imx8mp
Date:   Mon,  9 May 2022 17:14:23 +0800
Message-Id: <1652087663-1908-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652087663-1908-1-git-send-email-shengjiu.wang@nxp.com>
References: <1652087663-1908-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for imx8mp, which has micfil module

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,micfil.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,micfil.txt b/Documentation/devicetree/bindings/sound/fsl,micfil.txt
index 53e227b15277..1ea05d4996c7 100644
--- a/Documentation/devicetree/bindings/sound/fsl,micfil.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,micfil.txt
@@ -6,6 +6,7 @@ microphone bitstream in a configurable output sampling rate.
 Required properties:
 
   - compatible		: Compatible list, contains "fsl,imx8mm-micfil"
+			  or "fsl,imx8mp-micfil"
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.17.1

