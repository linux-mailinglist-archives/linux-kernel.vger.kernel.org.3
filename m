Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBBA57B913
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbiGTPA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbiGTPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:00:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C0B1F60C;
        Wed, 20 Jul 2022 08:00:19 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c30a:1501:bcb3:2103:84e3:6894])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B05C66015C6;
        Wed, 20 Jul 2022 16:00:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658329218;
        bh=bHMGrDzgFhOP0mAFpBoRWfNvLfjmmxPHTVuEZXKxVwg=;
        h=From:To:Cc:Subject:Date:From;
        b=mSfMgApMJpVzIpLIwrY6UVppZ9rHNsidPGorP5vq6LLj04AIW/NnH4LdXYqAQN9VH
         MIq52IqUCwA8XVEqlBdXo51NeK5mmk2fwbXSJiK8t4Pnyzs41/Bgpo85fH1YK3y+75
         WlhGtEwjtFQ1HjoazSaMPIkel0dckRN/bjIH0Sw/LxDWHMVcKGPPXRJcsm5tjXz4Zc
         XDv31p4sFhnUvylyO0hPPq3shWphrCv9v6Ss8FVRP+f0VThbHwu3VITUjQQnwbSgyq
         atuPyNQ2sLEfKUOtyeoCLJcOsnVslW26wh5LZuhXvlLTr0jjA1eiukAPvoXVEwmC3r
         Po7ICEy7LMGHA==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add MSC Technologies
Date:   Wed, 20 Jul 2022 16:00:03 +0100
Message-Id: <20220720150007.2168051-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "msc" vendor prefix for MSC Technologies GmbH
(https://www.msc-technologies.eu).

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Changes in v2:
  - New addition

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0496773a3c4d..1658357bc1c4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -816,6 +816,8 @@ patternProperties:
   "^mrvl,.*":
     description: Marvell Technology Group Ltd.
     deprecated: true
+  "^msc,.*":
+    description: MSC Technologies GmbH.
   "^mscc,.*":
     description: Microsemi Corporation
   "^msi,.*":
-- 
2.35.1

