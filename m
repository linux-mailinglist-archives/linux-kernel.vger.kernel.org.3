Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F2C56C903
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGIKaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGIKaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:30:09 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 540A25B7BA;
        Sat,  9 Jul 2022 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AlLIJ
        i7oVUaK9lCBexetGf1qqKXo8o8mgS/ZV/mMzlw=; b=SSgoJUvDnc3LCUI3JM+GU
        sJwZ6gEBAu8q0yMdimbHE6SV6mfxOMlnHiyPNKPUsI0I6+DwhYWXdhml6yJZbw2a
        pWtg1rxTEZhNXMuEYwaflkT2FeEi8UVzjkSf65yOFU59vEIi3bTMvUG4xw8DcjUV
        cffy2kFolLPAevZ5PU6vXA=
Received: from ProDesk.. (unknown [58.22.7.114])
        by smtp4 (Coremail) with SMTP id HNxpCgAHmLCXWMliQxqRNg--.616S2;
        Sat, 09 Jul 2022 18:29:48 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add OPEN AI LAB
Date:   Sat,  9 Jul 2022 18:29:42 +0800
Message-Id: <20220709102942.2753939-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220709102902.2753851-1-andyshrk@163.com>
References: <20220709102902.2753851-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgAHmLCXWMliQxqRNg--.616S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4rKFy7Kr48Xry7Ar1kZrb_yoW3uFg_Xa
        1xAr1DuFW5tF1F9F4qyF4xG345Aw12kr18u3Z8taykCFnrZrZxXa97t3yrur17CF429as3
        Ars7ArWqqrnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRAZ2atUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBsh45Xl75fWYcGgAAsx
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefixes for OPEN AI LAB.

Signed-off-by: Andy Yan <andyshrk@163.com>

---

(no changes since v1)

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0496773a3c4d..bc5011d79371 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -907,6 +907,8 @@ patternProperties:
     description: On Tat Industrial Company
   "^opalkelly,.*":
     description: Opal Kelly Incorporated
+  "^openailab,.*":
+    description: openailab.com
   "^opencores,.*":
     description: OpenCores.org
   "^openembed,.*":
-- 
2.34.1

