Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28756C910
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiGIKpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGIKpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:45:33 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Jul 2022 03:45:28 PDT
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72D8412744;
        Sat,  9 Jul 2022 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qgm8L
        5GfoMjn1SLXXzkxNTtfLePSZbzN6buCz/YPB/g=; b=dYbHC6dT/YtbHBzBgHSos
        R1DYlkCB1ubszKhBzQh3wQYH9PxrI3QRHHMRDUX9pXhrzFLa+PGYe6LDoHJTELxf
        0UU7qmu4Rrx5RXBKWH0HXbyFxpSX2Zye9muUSYBxbhjD6UW+/3RkJbr/bGVBCTZ3
        A0y8SdLLQJXVTqfasJvQSo=
Received: from ProDesk.. (unknown [58.22.7.114])
        by smtp5 (Coremail) with SMTP id HdxpCgCH__aqWMli71YENQ--.601S2;
        Sat, 09 Jul 2022 18:30:07 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add EAIDK-610
Date:   Sat,  9 Jul 2022 18:30:01 +0800
Message-Id: <20220709103001.2753992-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220709102902.2753851-1-andyshrk@163.com>
References: <20220709102902.2753851-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgCH__aqWMli71YENQ--.601S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1DCFyfAF4fCw1rJFWrXwb_yoWDtrXE9w
        1xAwn8CFWFyFyYq3Z0v3WxGry5Aw1IkFnrA3WjvF1DA3s0y3y5GFZ5t34IyF1fCr17urn3
        Crs2krWUJFnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRAdb1tUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0g85XmEjce7TZwAAsT
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EAIDK-610 is a rk3399 based board from OPEN AI LAB
and popularly used by university students.

Specification:
- Rockchip RK3399
- LPDDR3 4GB
- TF sd scard slot
- eMMC
- AP6255 for WiFi + BT
- Gigabit ethernet
- HDMI out
- 40 pin header
- USB 2.0 x 2
- USB 3.0 x 1
- USB 3.0 Type-C x 1
- 12V DC Power supply

Signed-off-by: Andy Yan <andyshrk@163.com>
---

(no changes since v1)

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index cf9eb1e8326a..f1dd87b1544e 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -470,6 +470,11 @@ properties:
           - const: netxeon,r89
           - const: rockchip,rk3288
 
+      - description: OPEN AI LAB EAIDK-610
+        items:
+          - const: openailab,eaidk-610
+          - const: rockchip,rk3399
+
       - description: Orange Pi RK3399 board
         items:
           - const: rockchip,rk3399-orangepi
-- 
2.34.1

