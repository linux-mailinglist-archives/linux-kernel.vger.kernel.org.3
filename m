Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427A453E911
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbiFFPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbiFFPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68201C592C;
        Mon,  6 Jun 2022 08:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BEA46150D;
        Mon,  6 Jun 2022 15:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE67C3411F;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529148;
        bh=x0uXsLwTwFEBoP5Y4DzIg5PaJ2+JUPnZLKqBkqVTUMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vke6M47fqUm7VYR6UmDGcA+tvqYqLIYqhnvzzkaF+a/m0SLTwO13NeNjOLytmswri
         AdBRm0/svrkxEm9j/9stuQ4YdtwynSd94CIga8MsoLUpFQg7T26FWPitDyo6i5/mNK
         uBUE+I8Djq13ahPSj5wAX5pXjhPcrfYxMBU/BgBFkCrsXMzTt2z+hyBTnB/4x2exLR
         sNvAm8kpuQC4e7qnLqpyJ64TSKI42MYsd4c0AFn6RxKi6RXhNk6AcbmlW6Gg1RSfQK
         S1ZlvDuxBPSYe0Umaix+oOhKO/CqQoWH68gKPEakFqZQQNz/+yYzxGeWp3NyL8LOVm
         Ap8/FyyuLp2LQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012P2-4L;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/23] dt-bindings: mfd: rk808: update rockchip,rk808.yaml reference
Date:   Mon,  6 Jun 2022 16:25:27 +0100
Message-Id: <417281c270e098eefed763859480014bec75c883.1654529011.git.mchehab@kernel.org>
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

Changeset 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")
renamed: Documentation/devicetree/bindings/mfd/rk808.txt
to: Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml.

Update its cross-reference accordingly.

Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt
index cbcbd31e3ce8..939cb5b6ffea 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt
@@ -27,7 +27,7 @@ Required properties:
 - pins: List of pins. Valid values of pins properties are: gpio0, gpio1.
 
 First 2 properties must be added in the RK805 PMIC node, documented in
-Documentation/devicetree/bindings/mfd/rk808.txt
+Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
 
 Optional properties:
 -------------------
-- 
2.36.1

