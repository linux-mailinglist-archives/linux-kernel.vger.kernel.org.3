Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8814453EBDC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbiFFP0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbiFFPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E621CD35F;
        Mon,  6 Jun 2022 08:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B18AAB81A99;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE69C341C5;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529148;
        bh=xBGosraEKFDvlEvVzHl4N9rATzwTfAcB7t6s+0VGeFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fiDerU78PUo1aGbGscYWQhmP5Dz5G1/CIK8SjjjdLf8+Yt0WMO/FMD/LVSQgOmSws
         5SczbvxJr57J/FoP2KOZD539AVkh2rMI1ugTvoImHZsisEM/h0vRRIjh8wi0LQYMGa
         BtLTWl+qxHp8MhLvYvlVzixrFufhtwbC7Q+JDFAwULaufg0AJuFhlE+J7IqkqdlPRI
         WQkT1OaW2+F5BqAcQ7e9z01hX8975Bu1oKl5iG87Hwpdk4mBLeQ7ih0dfoGZIOEuLK
         M8yp80aystS5AompHnODjLUcKfrvxi6k2CNvynCU42Cx/8d5JWI3Hd390aNvnjF3H7
         QZBUeIJX+0KQg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Ps-Dc;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 19/23] MAINTAINERS: update maxim,max77693.yaml reference
Date:   Mon,  6 Jun 2022 16:25:41 +0100
Message-Id: <6a87dfb278765465d82ad4641a42ae4de0ded392.1654529011.git.mchehab@kernel.org>
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

Changeset b38213c6118b ("dt-bindings: mfd: maxim,max77693: Convert to dtschema")
renamed: Documentation/devicetree/bindings/mfd/max77693.txt
to: Documentation/devicetree/bindings/mfd/maxim,max77693.yaml.

Update its cross-reference accordingly.

Fixes: b38213c6118b ("dt-bindings: mfd: maxim,max77693: Convert to dtschema")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a11aa7ebb6af..dc64a23d0bdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12118,7 +12118,7 @@ F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
-F:	Documentation/devicetree/bindings/mfd/max77693.txt
+F:	Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
 F:	drivers/*/*max77843.c
 F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
-- 
2.36.1

