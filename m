Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A1853E7C7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbiFFP2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbiFFPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE427EBC9;
        Mon,  6 Jun 2022 08:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EBD2B81AC0;
        Mon,  6 Jun 2022 15:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F44C341D3;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=VN1Fhxv3NChNyRcDGXrZz/owsXumLTufKW8uyhjLG1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eW8JzV9+YELrmoS98gF/BoBErSuC3U+PbTu6kE8Nhoc1pqVC0uyC+nkJ0BoP1QLfx
         IINmpniOx4BRG/01X0eIFK/NGMPDTPxm8MWFggm1VTXALogWnO1zqxls4y0fuZZIuD
         2Qs7ldGLiC/NUA7p3irgXPcnyk9VP9zPjQer8Zv8cj5PjHxa/A7/qU3o5fZ6x83hvG
         U+WEjy7hoyMHVnuOrPDjnp3VxAHy3DFy61cGD3Ld1czPdCsBFyErguAxzgltVgBcDN
         nssoZ2WRhkzHs7MupjkRYLFa2AfO9aHxEJWyNPYo5m8pBJPnI5w3dLZ6ntMVzY6J/V
         7PplLihP+gjRQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Pl-CR;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 17/23] MAINTAINERS: update cortina,gemini-ethernet.yaml reference
Date:   Mon,  6 Jun 2022 16:25:39 +0100
Message-Id: <d27b5d508fb757147b720bf573ce5a2e3fc5920e.1654529011.git.mchehab@kernel.org>
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

Changeset 208b65f7b5cc ("dt-bindings: net: convert net/cortina,gemini-ethernet to yaml")
renamed: Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
to: Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml.

Update its cross-reference accordingly.

Fixes: 208b65f7b5cc ("dt-bindings: net: convert net/cortina,gemini-ethernet to yaml")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91b3ed8ef420..e122b6946063 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2009,7 +2009,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://github.com/ulli-kroll/linux.git
 F:	Documentation/devicetree/bindings/arm/gemini.yaml
-F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
+F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
 F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
 F:	arch/arm/boot/dts/gemini*
-- 
2.36.1

