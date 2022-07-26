Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AFB58132C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbiGZMcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiGZMca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:32:30 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4BB1A393
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=KLSWWkj5p/9aNi8xEecUTDY/28fCiwtrJb5KmQYidEI=;
        b=jbrHO2Ijju3Tn/o8kVFgZT745vpc6iFK6E/zG9xzkZAkyUFMeqlwT7xiBZnzxX3y6or68pbBuUtA3
         31CfAE8HrnvfW4taV2kvSmcYk/t/R5CFtzakqFVYEkr53djralM2sz8VrDwQNsJqXcwtysIf3nMbCH
         oIbTe+VvpfqaU8zIng8ZgCGa6DYrm04GZPUSXQ6sgbG08gX9ctTWSGXVCTQB6xqQiJjhhfYMRWeX5R
         lsMoS7vqbBSc1Uuk3CSmnvxsGLHMSowFWm6L0MXilOfz/3uVl5dRtEqzuVOzK1zhsZcMor1gU5S4n3
         HBJYl8t/P/CE0zv4LGBvZYSywWs9ezg==
X-MSG-ID: 00d891f8-0cdf-11ed-8a45-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH v2 0/2] arm: dts: imx6qdl-vicut1.dtsi: Add backlight-isb node
Date:   Tue, 26 Jul 2022 14:32:20 +0200
Message-Id: <20220726123222.1074876-1-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the backlight-isb node and fixes existing backlight_led
node name.

---
v2:
 - Fix node names to use minus character instead of underscore.

David Jander (2):
  arm: dts: imx6qdl-vicut1.dtsi: Add backlight-isb node
  arm: dts: imx6qdl-vicut1.dtsi: Fix node name backlight_led

 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

-- 
2.32.0

