Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C437D484C92
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiAECrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:47:11 -0500
Received: from out203-205-221-202.mail.qq.com ([203.205.221.202]:60996 "EHLO
        out203-205-221-202.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230074AbiAECrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:47:10 -0500
X-Greylist: delayed 137887 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 21:47:10 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1641350828;
        bh=huROdnZmfMWXAJUy/2oiqghRor8DUtTKvc0ZLSGrPAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FVsBSKwD2L9b5I29Kx3vjOBkw9nfRlCMc2KREcw6RFPWG8QkgqpCRdXxQWF9us3ln
         yzHbrlUJpslsIDLYD91BiYVD5vjh8YRmyQyNB2nqRrUtN6MNmlknJtyCc+KGSzFvrJ
         gZsNMggW9FlxCNoB89SrVOgFptjSDW75K1yPMd0A=
Received: from fedora.. ([119.32.47.91])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id B750F492; Wed, 05 Jan 2022 10:45:53 +0800
X-QQ-mid: xmsmtpt1641350754te7axbw3d
Message-ID: <tencent_9A79E4BC3715D4948E6D69363916D4B26D0A@qq.com>
X-QQ-XMAILINFO: NSHyY+L3HkGiTpb//NFrQxgNe/Z8QeTd+2LxLqJDPr8berthVGTVHA2nUMHFkl
         vzxoPG7kp0Eg1yDu1Xf/ZrqAccFJu2KnPZ3nZ1wdyvl1EqR9/VP6xT8nRUdC8C1RnrPhpWo9XYw9
         TEm4/x+h7TqD1keblgsLDKRz+KEYqxsG7DiGpNBhizY8VtqIo9LvOorp3am2RSnKy70oa0gJyjuH
         gFUWNSmIRwxbagPEH8l5PcO4iCRFWft2yTJ7hLpOFOgsZRh6v0WxeIw7phpFZhO1SW+OMx7AdZxA
         +V2lCRBrw7M46uLuo+qTVXO0zlQqKIYidjJPGGaPF+stvkcSy+NJwmK9eBrVuylAMY6XC2874GbQ
         C0MLC+gKrdMDM8l3H6mFJPbvAEq65A6f91mUAsGmPP17aY+u1E1WqPKNDXRNyyWvflUQfDOpmFfK
         7Qr1XQKfqNQyR/eoKsnyKYpytUPYf3eMdMpr860JmEh6n03r+scIcN8I1/3yE4nmOZYx7jnXknwm
         deb/42XNt3LTa/iA0vddM0as14yKjBUBG6vjJvW5rg+mBdR8pIj/ZPVk85j571f25Kfzs7ass5zO
         cs6YnVWIQLE/tk3ob6vRWDyU2cQUudIK7mqJm4W6NqMv8FwhFzJZjasSHxZy5En8iF7SVzVHokRD
         qx8tvTl5aOGzjUfxF4vFN7g4qFXpbOganC7qJAVHzsCmHkNlm9gDcF9D8mXvaoTP7LsDaIeWhBgs
         P7cyrBtAO6uMRD+H27SLLJj0sTDSsfXkCoJQ6FtPu+Ft389PQVC8oihZHFNmm7WDUQKyGUAxinW5
         rcwYS746RSfwF2dJoMn6pnAD8JBkNiPr5o4kqSZ6tAiUrdNNAvswqMgKBG35Xs4iTFy6hRNAh40X
         W+iL8MNdWdjdjfBWfnH0EtC1ybL/YwCoKP5Cnqtbw3WCLbG717mqg=
From:   conleylee@foxmail.com
To:     robh@kernel.org, mripard@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, conley <conleylee@foxmail.com>
Subject: [PATCH v2 2/2] sunxi.yaml: add HAOYU Electronics Marsboard A20
Date:   Wed,  5 Jan 2022 10:45:51 +0800
X-OQ-MSGID: <20220105024551.807713-2-conleylee@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105024551.807713-1-conleylee@foxmail.com>
References: <YdS1GVkRopRSoD5S@robh.at.kernel.org>
 <20220105024551.807713-1-conleylee@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: conley <conleylee@foxmail.com>

Signed-off-by: conley <conleylee@foxmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 889128acf49a..4bd93ae26bd1 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -444,6 +444,11 @@ properties:
           - const: haoyu,a10-marsboard
           - const: allwinner,sun4i-a10
 
+      - description: HAOYU Electronics Marsboard A20
+        items:
+          - const: haoyu,a20-marsboard
+          - const: allwinner,sun7i-a20
+
       - description: MapleBoard MP130
         items:
           - const: mapleboard,mp130
-- 
2.31.1

