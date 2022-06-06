Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5578853E992
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbiFFP01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240582AbiFFPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2885D1CD345;
        Mon,  6 Jun 2022 08:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 451B561523;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2201C341C7;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=o+mpM2DqLl7+5AG4aDqsNIzMwG1Drnb+xb/xV663Jwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oo+QdLL062Z3Ig+jleiOkwAl46SqyJl3PUJor7X7NWpN8UumT5uuOHTUALJs5oNPb
         PWsj1FBEoB1AFwK2dTa826vwlTxibvOyxe/jhrh7Pg/jwuN/nzMH51zbLzDbnT9V/D
         26RM4REyqcUCRw9PYJr2nqWUvJXOv0BGPBYwbeGBTJMxOYBjgqSGvkHItNFy/XxLbH
         NPpWPtjWp76zFiNNVUta4qe5WpFT8zTHmywIf9liwWRrg14RdBK7LK0xYfUmbcMgsV
         4OMxqnd6RlPZDZuGG34jt0uHQhBB0av9cQ0+XqdhV31d/VOWVHq1GPdBYtcHRx2JCB
         R+8a0uDxIyjNw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Ow-30;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/23] dt-bindings: arm: update vexpress-config.yaml references
Date:   Mon,  6 Jun 2022 16:25:25 +0100
Message-Id: <7020edd9e183652249fc95bf61a1055cc342a4dc.1654529011.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 7e8339b5162f ("dt-bindings: arm: convert vexpress-config to DT schema")
renamed: Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
to: Documentation/devicetree/bindings/arm/vexpress-config.yaml.

Update the cross-references accordingly.

Fixes: 7e8339b5162f ("dt-bindings: arm: convert vexpress-config to DT schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 Documentation/devicetree/bindings/hwmon/vexpress.txt     | 2 +-
 Documentation/devicetree/bindings/regulator/vexpress.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/vexpress.txt b/Documentation/devicetree/bindings/hwmon/vexpress.txt
index 9c27ed694bbb..4a4df4ffc460 100644
--- a/Documentation/devicetree/bindings/hwmon/vexpress.txt
+++ b/Documentation/devicetree/bindings/hwmon/vexpress.txt
@@ -9,7 +9,7 @@ Requires node properties:
 	"arm,vexpress-power"
 	"arm,vexpress-energy"
 - "arm,vexpress-sysreg,func" when controlled via vexpress-sysreg
-  (see Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
+  (see Documentation/devicetree/bindings/arm/vexpress-config.yaml
   for more details)
 
 Optional node properties:
diff --git a/Documentation/devicetree/bindings/regulator/vexpress.txt b/Documentation/devicetree/bindings/regulator/vexpress.txt
index d775f72487aa..1c2e92c7831e 100644
--- a/Documentation/devicetree/bindings/regulator/vexpress.txt
+++ b/Documentation/devicetree/bindings/regulator/vexpress.txt
@@ -4,7 +4,7 @@ Versatile Express voltage regulators
 Requires node properties:
 - "compatible" value: "arm,vexpress-volt"
 - "arm,vexpress-sysreg,func" when controlled via vexpress-sysreg
-  (see Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
+  (see Documentation/devicetree/bindings/arm/vexpress-config.yaml
   for more details)
 
 Required regulator properties:
-- 
2.36.1

