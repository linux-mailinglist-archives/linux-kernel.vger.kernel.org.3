Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA6255B0B0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiFZJL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiFZJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471FD12A93;
        Sun, 26 Jun 2022 02:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6540BCE0F90;
        Sun, 26 Jun 2022 09:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BB0C341D2;
        Sun, 26 Jun 2022 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234671;
        bh=NCpiqd/D1JiRGRI6GFPpPviNDEw1WQaXUZZDjx551mU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHa/6D2/6MlyBB7kFaoPvwT7M37Z6+np2e4+K3s/u9VjR/vdduDG6/7u14eWpSQGh
         SYC6yxhxTc7fYwdUuNyYBSQMAYb+v+DkqP6qO3LwozKn3ALp8kEJP+XPCZMDrp8fPo
         50Q+XK5ZxnyjIwBpf/klBX8zsatXyUuy3R9Fn3qGZrpReBrOFhfMdI/SMCJ8Iahelj
         jNu3X+CIjQ5NznInR4r2eaCJ9oYAwuBdhXhKqB1URmLXYIu3Hb/NRQGgic0Z7bSEXb
         VAe8+TY2XgZ5MvNFm98kg79L3NmUuNIYPqJ+jE7vDYEm1USumqH1LxlUIXrqxvbPd3
         quB1Tf3lBhb/Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIO-001cpF-6v;
        Sun, 26 Jun 2022 10:11:08 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/20] dt-bindings: mfd: update dlg,da9063.yaml reference
Date:   Sun, 26 Jun 2022 10:11:04 +0100
Message-Id: <da459164d166d994b06f9ce8bf3a2108ccd0abd5.1656234456.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656234456.git.mchehab@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 441613662db7 ("dt-bindings: mfd: Convert da9063 to yaml")
renamed: Documentation/devicetree/bindings/mfd/da9063.txt
to: Documentation/devicetree/bindings/mfd/dlg,da9063.yaml.

Update its cross-reference accordingly.

Fixes: 441613662db7 ("dt-bindings: mfd: Convert da9063 to yaml")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

 Documentation/devicetree/bindings/input/da9062-onkey.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/da9062-onkey.txt b/Documentation/devicetree/bindings/input/da9062-onkey.txt
index 5f9fbc68e58a..e5eef59a93dc 100644
--- a/Documentation/devicetree/bindings/input/da9062-onkey.txt
+++ b/Documentation/devicetree/bindings/input/da9062-onkey.txt
@@ -2,7 +2,7 @@
 
 This module is part of the DA9061/DA9062/DA9063. For more details about entire
 DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
-For DA9063 see Documentation/devicetree/bindings/mfd/da9063.txt
+For DA9063 see Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
 
 This module provides the KEY_POWER event.
 
-- 
2.36.1

