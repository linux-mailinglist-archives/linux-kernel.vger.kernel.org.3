Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912DE4AC6A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357094AbiBGQ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357152AbiBGQvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:51:02 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4C7C0401D3;
        Mon,  7 Feb 2022 08:51:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id B17CF1F4304F
From:   Apertis package maintainers <packagers@lists.apertis.org>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org
Cc:     ariel.dalessandro@collabora.com, broonie@kernel.org,
        festevam@gmail.com, krzysztof.kozlowski@canonical.com,
        lgirdwood@gmail.com, michael@amarulasolutions.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH 1/2] ASoC: bindings: fsl-asoc-card: Add compatible for tlv320aic31xx codec
Date:   Mon,  7 Feb 2022 13:49:45 -0300
Message-Id: <20220207164946.558862-1-packagers@lists.apertis.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Commit 8c9b9cfb7724 ("ASoC: fsl-asoc-card: Support
fsl,imx-audio-tlv320aic31xx codec")' added support for tlv320aic31xx
codec to fsl-asoc-card, but missed the related device-tree compatible
string documentation. Fix this.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index b219626a5403..8b4f4015cfe4 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -40,6 +40,8 @@ The compatible list for this generic sound card currently:
 
  "fsl,imx-audio-tlv320aic32x4"
 
+ "fsl,imx-audio-tlv320aic31xx"
+
  "fsl,imx-audio-si476x"
 
  "fsl,imx-audio-wm8958"
-- 
2.34.1

