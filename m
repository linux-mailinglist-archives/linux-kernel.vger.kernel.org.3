Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFDC53EAFF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiFFP1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240620AbiFFPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCE61CD361;
        Mon,  6 Jun 2022 08:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7038BB81AB4;
        Mon,  6 Jun 2022 15:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF272C341D2;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=x+zgkHojqbGSLbsNbvd/i9PJZ2MbJ86c+Jjf+G6oGa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYNG3nK8AHw5MqCJ5eFl1o5dhvPPLuwapxPjZueKKxTb39N+ffm6rdT747UwRLwPh
         /ZzZqdqv5iSBOaZDIrnQp1byf/gB9luz7Jy8Rv8ai/DxArgJTnRoudJCt5JkrM9pru
         zuYWYg08CVwDzOeFn04aqDvKIkoGJel2yoWD/Rcyuovo61dFemQHHxAIKX6Paes9WX
         iTsVXIyZ16cuDicOPHfWDBrEnuHVnXHof6rwsQ4zpImORGcUyrD2sZpFjo/JSf36OL
         rpNXPprnr8kCv/wz8gUMvEST5H/64DYkfNBaigUVqm2wFu5/DTyRydq973sBEusI0H
         bmoHMdN5hR7hQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Pb-Aw;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 15/23] MAINTAINERS: update arm,komeda.yaml reference
Date:   Mon,  6 Jun 2022 16:25:37 +0100
Message-Id: <64fde761c04edc287d397dae1be95ac1c2886c74.1654529011.git.mchehab@kernel.org>
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

Changeset 0f6983509ea1 ("dt-bindings: display: convert Arm Komeda to DT schema")
renamed: Documentation/devicetree/bindings/display/arm,komeda.txt
to: Documentation/devicetree/bindings/display/arm,komeda.yaml.

Update its cross-reference accordingly.

Fixes: 0f6983509ea1 ("dt-bindings: display: convert Arm Komeda to DT schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c20bd168d209..aba64cae8f68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1542,7 +1542,7 @@ M:	Mihail Atanassov <mihail.atanassov@arm.com>
 L:	Mali DP Maintainers <malidp@foss.arm.com>
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/display/arm,komeda.txt
+F:	Documentation/devicetree/bindings/display/arm,komeda.yaml
 F:	Documentation/gpu/komeda-kms.rst
 F:	drivers/gpu/drm/arm/display/include/
 F:	drivers/gpu/drm/arm/display/komeda/
-- 
2.36.1

