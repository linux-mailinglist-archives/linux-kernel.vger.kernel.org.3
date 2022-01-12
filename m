Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB12C48BD93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349105AbiALDPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:15:10 -0500
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210]:42933 "EHLO
        out162-62-57-210.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345682AbiALDPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1641957304;
        bh=yD1+HnweGuASmWcBMTr/tuOJ+2830tkElTWGis7dnco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZWlAp/xyaFhQe8YgV4u2SCwjsApcuIaYoTAfm9F5PC9PMFbbvxmEhVQ7IHhvfzqRW
         FrH/GUndns8ONqyEIFznHNHh4YboZaF0ywfG5LAlifaxg057ObfExWcrif5OeWw/7o
         yH+1DkyfR0Srh+7eFdqs97+Awt5eEI9eE08VUWF8=
Received: from fedora.. ([119.32.47.91])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 3711B294; Wed, 12 Jan 2022 11:13:49 +0800
X-QQ-mid: xmsmtpt1641957233t4gn71klx
Message-ID: <tencent_A92DC943F79DB360AE14672BB749BFE08A05@qq.com>
X-QQ-XMAILINFO: Nn+88S7+9wlcKPHjr17hA4IryKRVfFFdIl4J/dQgzAR928cTS85t7LVkbZBZpe
         MPyKdLNe2s8ki1cjpjJEHN8LgOlfx9kzJmlGWuZQ7rZ7xXFsQ82fGi5+wYYQI7qSL7JSbhh5O0VH
         HA30dzKay8hNXsEMc6Ht57HwY5q4zqwwthwaLTU0PldvjIj29KxYHzwxbGtQMiftVMvoMCuc8hv8
         eg11XjsVstzN+yOpSKcItZ1UqDUJ0fML1HntoB3mLx6xiXwGheMfjoE6LfAh81KREx20a0pUTjj9
         V/jC0aolwFzZ5frC43/vdyuytFRC6WBWJb7nMBzU97Ubm/BJZbNuvUvBxGH3RNVIud0lWv08xiVO
         ojfB0tozJHFIe51pJYlhdHgrXOANN7CKSoQuqB6Rr8gs6te9233nv6H1tfZw/aBjRRaqjY62zr1U
         D0juHTGsieLh6KmCXmqubzh9m+aVNgqDPheN1RokcVSLvZpnfrlDqlDd58IvEPRL1yR5VkGfvKEc
         2zSVw2+6hVs4Au3HlamuNtqi3itpipFx5fv7dW1G20GBR5JGXKAcof7mT0u388p66ZRwibbce2+S
         mnES+g8dIIx/+nrI42GuBZdNGrIpzAK/wfjCfnK9pxG8mE2LYLyac6+T4xiKFAZpor9cNGrIm1xl
         bS3q49wvwDenV8IoJFRkYHzfw1EdNwdUqSUeOd/ZTU81NwGYw4Pa7lGAzd2UVvOF94nb392EubaM
         rc8Box4W0YYZ2mvlwDJw3SSrAt3W38eLHe2ZuX874kriEInfc3S/ElEyy74MXRey/b1SCvkiOTPB
         K/2TY+fBWZiBePyXgrGOE5WKEivoC7jz/x+QtjhZf1CKkgBOLj8t4oBkMfzQeV4h1uGIpUhJzQ1j
         DhkFCW4Yo0
From:   Conley Lee <conleylee@foxmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conley Lee <conleylee@foxmail.com>
Subject: [PATCH v3 2/2] sunxi.yaml: add HAOYU Electronics Marsboard A20
Date:   Wed, 12 Jan 2022 11:13:47 +0800
X-OQ-MSGID: <20220112031347.2492813-3-conleylee@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112031347.2492813-1-conleylee@foxmail.com>
References: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
 <20220112031347.2492813-1-conleylee@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add haoyu,a20-marsboard bindings

Signed-off-by: Conley Lee <conleylee@foxmail.com>
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

