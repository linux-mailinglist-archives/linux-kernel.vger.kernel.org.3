Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A0653EA50
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiFFP1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbiFFPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE801CD36C;
        Mon,  6 Jun 2022 08:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E155961545;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13A5C341D1;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=QMD8XSxVTt5rMt1QS7PnIMdO/7mrai1uKEVRc/zSrng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pkhb51qqLs419Rmod7Jvmn+fG8oFjkUt34SQDdy8Lp8zxyEz2PVawgQmePW5czFn6
         L46wfDpGrSQqegZX+WWdcVTbXXOnik+jXuEEEuJmcGHalj5q2p2IS969zhjBnrcPB1
         qMrFwiJ7X1IUknEMW2363ri672vyF5fK8ot5DdD0uJ9WZPgrrfOq+IFyJmG/XzJHZS
         CKwurPxtDZ9WKFqwqV827zh50nGPXFr2I38RZfhGKzAsNBUChqNu7s8zvBjk0NeKZm
         awaa9WafXrNRUHmG/CL0sPIFIhD9Gb5TrG4UIn7onmV2QYupi1i2TJCMGEbYGFHVPL
         QbVFhV6u+FIVg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Oz-3f;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 04/23] dt-bindings: reset: update st,stih407-powerdown.yaml references
Date:   Mon,  6 Jun 2022 16:25:26 +0100
Message-Id: <debdd5a9a1bfa0cf1c7e9c45da32edbc2ac2d10a.1654529011.git.mchehab@kernel.org>
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

Changeset 2ca065dc9468 ("dt-bindings: reset: st,sti-powerdown: Convert to yaml")
renamed: Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
to: Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml.

Update the cross-references accordingly.

Fixes: 2ca065dc9468 ("dt-bindings: reset: st,sti-powerdown: Convert to yaml")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 Documentation/devicetree/bindings/phy/phy-stih407-usb.txt | 2 +-
 Documentation/devicetree/bindings/usb/dwc3-st.txt         | 2 +-
 Documentation/devicetree/bindings/usb/ehci-st.txt         | 2 +-
 Documentation/devicetree/bindings/usb/ohci-st.txt         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt b/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
index de6a706abcdb..35f03df00130 100644
--- a/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
+++ b/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
@@ -9,7 +9,7 @@ Required properties:
 - resets		: list of phandle and reset specifier pairs. There should be two entries, one
 			  for the whole phy and one for the port
 - reset-names		: list of reset signal names. Should be "global" and "port"
-See: Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
+See: Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml
 See: Documentation/devicetree/bindings/reset/reset.txt
 
 Example:
diff --git a/Documentation/devicetree/bindings/usb/dwc3-st.txt b/Documentation/devicetree/bindings/usb/dwc3-st.txt
index bf73de0d5b4a..4aa368447b1e 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-st.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3-st.txt
@@ -13,7 +13,7 @@ Required properties:
  - resets	: list of phandle and reset specifier pairs. There should be two entries, one
 		  for the powerdown and softreset lines of the usb3 IP
  - reset-names	: list of reset signal names. Names should be "powerdown" and "softreset"
-See: Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
+See: Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml
 See: Documentation/devicetree/bindings/reset/reset.txt
 
  - #address-cells, #size-cells : should be '1' if the device has sub-nodes
diff --git a/Documentation/devicetree/bindings/usb/ehci-st.txt b/Documentation/devicetree/bindings/usb/ehci-st.txt
index 065c91d955ad..d6f2bdee20fc 100644
--- a/Documentation/devicetree/bindings/usb/ehci-st.txt
+++ b/Documentation/devicetree/bindings/usb/ehci-st.txt
@@ -17,7 +17,7 @@ See: Documentation/devicetree/bindings/clock/clock-bindings.txt
  - resets		: phandle + reset specifier pairs to the powerdown and softreset lines
 			  of the USB IP
  - reset-names		: should be "power" and "softreset"
-See: Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
+See: Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml
 See: Documentation/devicetree/bindings/reset/reset.txt
 
 Example:
diff --git a/Documentation/devicetree/bindings/usb/ohci-st.txt b/Documentation/devicetree/bindings/usb/ohci-st.txt
index 44c998c16f85..1c735573abc0 100644
--- a/Documentation/devicetree/bindings/usb/ohci-st.txt
+++ b/Documentation/devicetree/bindings/usb/ohci-st.txt
@@ -15,7 +15,7 @@ See: Documentation/devicetree/bindings/clock/clock-bindings.txt
 
  - resets		: phandle to the powerdown and reset controller for the USB IP
  - reset-names		: should be "power" and "softreset".
-See: Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
+See: Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml
 See: Documentation/devicetree/bindings/reset/reset.txt
 
 Example:
-- 
2.36.1

