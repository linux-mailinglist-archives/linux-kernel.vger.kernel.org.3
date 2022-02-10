Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405A84B0EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242308AbiBJNls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:41:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiBJNlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:41:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD990E9D;
        Thu, 10 Feb 2022 05:41:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 566771F46487
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644500506;
        bh=5tPW/YqhYGMQLNvAF+hQaPwiACKlUkeaqqMZxviHvtc=;
        h=From:To:Cc:Subject:Date:From;
        b=W448nmFw8HNSbVxZAR2A51Rd/IldqxV6x12swftrWN1skn1vdP/a/LqokCZ8pva5O
         KjiLJ9ay3IJIsc/3pyILk0vgWoZKIcJKsrKSc01YW+IYa7aTwtLeP1oTIB04cLeZTG
         L/SxRfdvQfzF5Y+vP4At6gFyyXGPWij77LL+SGK0ejIaBHkUdEcjgs8VMWNtaUvF2a
         HQV8WeEIN7OW5u2YiqO/CYai14I97jb6PGdDM44eU/of0IgQN4rkZSpzx0O+4Z7+94
         CcXlf8bmun+VGUvlMsujIqEiecSDZ44+Tg3tvZSe8TycKdzYm6kNGJNmE+7hSqNVcj
         SvGxVMIxB1b3w==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org
Cc:     ariel.dalessandro@collabora.com, broonie@kernel.org,
        festevam@gmail.com, krzysztof.kozlowski@canonical.com,
        lgirdwood@gmail.com, michael@amarulasolutions.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v2 1/2] ASoC: bindings: fsl-asoc-card: Add compatible for tlv320aic31xx codec
Date:   Thu, 10 Feb 2022 10:40:48 -0300
Message-Id: <20220210134049.32576-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

