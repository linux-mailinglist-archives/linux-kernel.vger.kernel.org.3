Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5A853EC61
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbiFFP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbiFFPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925C11C593C;
        Mon,  6 Jun 2022 08:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 165FC61518;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FECC341C0;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529148;
        bh=f5GPyT4Wrvw50UYYOX5bbPLNVeJEj/gQo8X23z90liU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bf6kn285w0XGREt9mNQLZkoWcwvtk22Kksz8/GMD40m1pQOLht3euzsCJPJ/2d0WH
         kHdrab9XIwHn/+tVI00MF9NWaaoSXDWKsvrTEWSVKkdQN1NISVT3Lp6CamXUwYemjw
         5EeuGCEf8tcYuqWRRqv5R/v+Hf1Ltntn06wsvgf9KzHwA6HE6lTPZElaA6jj4UFAU+
         TC69+3L8U9r6UGZe3asLMXB0P/pDHJ7EoBp4zwXE8QbtH/19KEpr8/cLchCX67Rya1
         7R9UVTerLA4xaTPvNVUaUY4s2/5N5KQM2JJvKrIc2VG8ZiURBhwYfC1ktgxGahYANn
         Ca8K46jBgdiuw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Oq-1i;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/23] dt-bindings: mfd: bd9571mwv: update rohm,bd9571mwv.yaml reference
Date:   Mon,  6 Jun 2022 16:25:23 +0100
Message-Id: <1906a4d935eab57c10ce09358eae02175ce4abb7.1654529011.git.mchehab@kernel.org>
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

Changeset 983b62975e90 ("dt-bindings: mfd: bd9571mwv: Convert to json-schema")
renamed: Documentation/devicetree/bindings/mfd/bd9571mwv.txt
to: Documentation/devicetree/bindings/mfd/rohm,bd9571mwv.yaml.

Update its cross-reference accordingly.

Fixes: 983b62975e90 ("dt-bindings: mfd: bd9571mwv: Convert to json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator b/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
index 42214b4ff14a..90596d8bb51c 100644
--- a/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
+++ b/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
@@ -26,6 +26,6 @@ Description:	Read/write the current state of DDR Backup Mode, which controls
 		     DDR Backup Mode must be explicitly enabled by the user,
 		     to invoke step 1.
 
-		See also Documentation/devicetree/bindings/mfd/bd9571mwv.txt.
+		See also Documentation/devicetree/bindings/mfd/rohm,bd9571mwv.yaml.
 Users:		User space applications for embedded boards equipped with a
 		BD9571MWV PMIC.
-- 
2.36.1

