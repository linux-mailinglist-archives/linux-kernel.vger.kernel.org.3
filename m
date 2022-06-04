Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA653D71E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbiFDN4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiFDN40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:56:26 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84632EC3;
        Sat,  4 Jun 2022 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BmBmUf2v9Q9hYXdfwnJjZQULdKw68XYCi/mBaSZxjyM=; b=muBE82ZCLw9ZgRWspJFLn0MdF9
        /gZZe6vnsJp7iH3nTDkt1WB4AcB1dGpIkDe48Ct0S1Er5ux6fYce8fo2aOJoe5xz5M64vnFNfD9rw
        1LO/k+yAJjdHXTFxD+/Lc2h5dXkCKA10rt4t0zJafL6YYJxEY6mVxsfztO4J4EjlO8sI=;
Received: from p200300ccff3313001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff33:1300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1nxUGA-0007bO-Rj; Sat, 04 Jun 2022 15:56:11 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1nxUGA-002NzD-8V; Sat, 04 Jun 2022 15:56:10 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        marcel.ziswiler@toradex.com, alexander.stein@ew.tq-group.com,
        tharvey@gateworks.com, linux@rempel-privat.de,
        matthias.schiffer@ew.tq-group.com, cniedermaier@dh-electronics.com,
        sebastian.reichel@collabora.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolecrivain@gmail.com
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: add compatible string for Kobo Aura 2
Date:   Sat,  4 Jun 2022 15:52:59 +0200
Message-Id: <20220604135300.568754-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220604135300.568754-1-andreas@kemnade.info>
References: <20220604135300.568754-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a compatible string for the Kobo Aura 2 eBook reader.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..c8c1c6e54543 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -523,6 +523,7 @@ properties:
         items:
           - enum:
               - fsl,imx6sl-evk            # i.MX6 SoloLite EVK Board
+              - kobo,aura2
               - kobo,tolino-shine2hd
               - kobo,tolino-shine3
               - kobo,tolino-vision5
-- 
2.30.2

