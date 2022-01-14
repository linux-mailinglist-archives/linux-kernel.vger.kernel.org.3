Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64F48EE27
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbiANQdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:33:12 -0500
Received: from out203-205-221-202.mail.qq.com ([203.205.221.202]:54060 "EHLO
        out203-205-221-202.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230447AbiANQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1642177987;
        bh=0j32JuMop2U4KO0U8qwSEoYqP8J6+Y6JiG/cAsMzIg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Jk2h3aV63rZMj7zCN/0u6Eghm9JiC7L1QIPIlyJDAPy64I8lm9/dK1ekmdYF6VJBJ
         yK0tSqnxL0iI/nAAlYX2pu3BFoD+dO1sO+tAKiyEz6MYS+ijGBakQPrCw4PvbN2KaU
         v0IuXHh2nm1gLECITYp8VJUG6ECASQHVLpVVibd4=
Received: from fedora.. ([119.32.47.91])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id 7F1958D8; Sat, 15 Jan 2022 00:31:49 +0800
X-QQ-mid: xmsmtpt1642177911tb0po5546
Message-ID: <tencent_B6059C6C031E46EFCB05D5A5015B1C4DE608@qq.com>
X-QQ-XMAILINFO: N0opbxSOYLeWzqvft+TpXhGhY6nT9rcHnbbMRjE5KBqQT3bInUhyc+VIVfFYaN
         MSoLiD0Z1ZJbqLczdxRFIpT+AFs/4K9ap91Pjf7DCuoKs/H/szpIIF5hBYm5XKYSIgruJYoFqTDd
         E85QNeVqIGPZVRWmSkTDLnECdryOSyi5ecBo0M7oRmSt8UeUV2a0wadGIDJ0EAlwWrl9/bZsY50F
         6+eMBtv4FIcU4AWfufsgs75oh/72N23S1WaASt1qtYjn+Ou2hct4dlNgzGgZBtVq90uKhXlDnmND
         1NWspg9TSQ/aSXq3Yz1wfgkWp6FaDUQYLuJ+215pQYbUvHsAJK5x2WdaanuZ3462miulb15WZyAX
         d3BsdlyVcnudxjlUGsbgtxn6jmEufxE2RnhHgLq55wuwR36U27pJiHnsWZpTjMhOndduCu+nzvb8
         yBSa8imTUApwBdicnkHpJUE5kzixs82lodWdWuTCMIl3bs6FwQCvyq/Rp3KyTqjZqxfdKZ45poxF
         v97Zr7DG7hgFye6KMbUwTJuI5A9CU0PYVhpy589NPGqZ5XV2xThjQTlAgeEWb2V1MSQ5b7E8OQ4M
         BYF+Uz9SzRPDZMT4ijPi35/bmzd9bOqm8bwYu+MymCEWIckxgCY8natcyY5tMf3DgUgzeZL7IHJM
         4lYMx0wXK1bvWvKkVgYPVABlOddKqp5Oc3qQsQ1j55EYy07mtDiDzelnqkXT9OKiLW+t8kD7wAKl
         bgC55IpN6H+qA2DOBeDKHeYsxpl7Z+oKu8aWArQwwVzVjsT3CJ9xCXVpPWEKeF8jGAPdkltrCrO4
         aO2q3AMBxWlqtLYvtCf2RQhE40xttSCnYdkbOjEl8JfoGXAqesGUZwVW+TUy/CHE8d/+eByOYHK2
         6qKLwgORIvY+wqA4Vr8NxT5ocs1Pfcc+UIvW+zuuyUCzyVeJzTJKM=
From:   Conley Lee <conleylee@foxmail.com>
To:     maxime@cerno.tech, mripard@kernel.org, wens@csie.org,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, conley <conleylee@foxmail.com>
Subject: [PATCH v4 2/2] dt-bindings: arm: sunxi: add haoyu,a20-marsboard
Date:   Sat, 15 Jan 2022 00:31:48 +0800
X-OQ-MSGID: <20220114163148.2854265-2-conleylee@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114163148.2854265-1-conleylee@foxmail.com>
References: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
 <20220114163148.2854265-1-conleylee@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: conley <conleylee@foxmail.com>

add haoyu,a20-marsboard dt-bindings

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

