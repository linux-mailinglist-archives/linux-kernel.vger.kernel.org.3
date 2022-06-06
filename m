Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DD553E97E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbiFFP0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbiFFPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958BA1CD356;
        Mon,  6 Jun 2022 08:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EE25B81A88;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC0DC34115;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529148;
        bh=CWKvRxVJEPNnkZuKvwuAotxoLsRKd2ZdPiOn4+Y3dXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUiWbhzd2oW4FU2k1AAzQfAjDWWc9dpVWluuxBuRlIg6QMG6f6NeGh1NpnaZLc3m9
         FGizPPKZgYhRxwDRLt2/8fmqILgFRap+BU2lpj6w33JVaahSn31Hyq+gxyVA/2tm+R
         bKkmdWk3cq2SsKVDf5Fof3S7Q8knxxQjUg9rUVZGWEuvZdopY4bk+wCRjsvSf1ZmSv
         Fbt5PV0nwtiC5SL9VUjLaf10BybRGjM7dUdYz7N6Yh8IRnxNOmLLpNQViSCDPVQd4I
         ytTtXZkX0FxrpeWxHAYmlU6FwLiwbEVKLrJoHnlbPlG0XK8aiy9Cwv2VPYrzeo4CoL
         kpovps62vytIw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Pe-BY;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 16/23] MAINTAINERS: update arm,malidp.yaml reference
Date:   Mon,  6 Jun 2022 16:25:38 +0100
Message-Id: <191336fcb78d93bcd46ebf425e382e4c78824e03.1654529011.git.mchehab@kernel.org>
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

Changeset 2c8b082a3ab1 ("dt-bindings: display: convert Arm Mali-DP to DT schema")
renamed: Documentation/devicetree/bindings/display/arm,malidp.txt
to: Documentation/devicetree/bindings/display/arm,malidp.yaml.

Update its cross-reference accordingly.

Fixes: 2c8b082a3ab1 ("dt-bindings: display: convert Arm Mali-DP to DT schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aba64cae8f68..91b3ed8ef420 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1564,7 +1564,7 @@ M:	Brian Starkey <brian.starkey@arm.com>
 L:	Mali DP Maintainers <malidp@foss.arm.com>
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/display/arm,malidp.txt
+F:	Documentation/devicetree/bindings/display/arm,malidp.yaml
 F:	Documentation/gpu/afbc.rst
 F:	drivers/gpu/drm/arm/
 
-- 
2.36.1

