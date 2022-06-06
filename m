Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D910C53E861
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbiFFP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240565AbiFFPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4751CD340;
        Mon,  6 Jun 2022 08:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1835261519;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BA9C341CA;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=HX77o3GbP6StQGsmQNWtxrZSPmAY70fcGW/50iB60UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9/yhptvDXGC62EWjCN9/23AE9//q71Xm8NvXmnBg+QHhBfORkclu0uFVDhhDrOmv
         vVRudrbYG0KpPqaKG3pSovGItwyqpIz4gAwxRwS/EMUOHz0+GGt3feFL93pM2MWf0g
         5aVmu7XR7MpRMn7+pkRO5dnib/Fapm94XG7tEvTcacoJqinocJdlG6T8vL7OoG89YE
         6TZ12UTAuVqrgjPUWURnPlwWBXA1HADxidBq54xvJhttueY7wQn27dYU+zrNjo+M0o
         f6MQ/P1oWpXLa1iCW/LbG8+vJN6DQt/sQWY2jZeLKg4L3FnAwfqs1rb0Klx15H1pQx
         eBmI2stxwjv1A==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Pp-Cy;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/23] MAINTAINERS: update dongwoon,dw9807-vcm.yaml reference
Date:   Mon,  6 Jun 2022 16:25:40 +0100
Message-Id: <89f11772dd4afe9700d6cbbb3da8749eb98b396a.1654529011.git.mchehab@kernel.org>
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

Changeset a1f4626b282d ("media: dt-bindings: Convert Dongwoon dw9807-vcm bindings to json-schema")
renamed: Documentation/devicetree/bindings/media/i2c/dongwoon,dw9807-vcm.txt
to: Documentation/devicetree/bindings/media/i2c/dongwoon,dw9807-vcm.yaml.

Update its cross-reference accordingly.

Fixes: a1f4626b282d ("media: dt-bindings: Convert Dongwoon dw9807-vcm bindings to json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e122b6946063..a11aa7ebb6af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6078,7 +6078,7 @@ M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/i2c/dongwoon,dw9807-vcm.txt
+F:	Documentation/devicetree/bindings/media/i2c/dongwoon,dw9807-vcm.yaml
 F:	drivers/media/i2c/dw9807-vcm.c
 
 DOUBLETALK DRIVER
-- 
2.36.1

