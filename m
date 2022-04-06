Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41364F6A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiDFTyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbiDFTxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:53:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF22EC4FF;
        Wed,  6 Apr 2022 10:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85555B803F7;
        Wed,  6 Apr 2022 17:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F5BC385A1;
        Wed,  6 Apr 2022 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649266214;
        bh=TzTlpFZtH0J+36S9N9L4ND/H/yCs90y6P3aB8Lln2MI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDIGt5bbay39GvswOhiiR9x75f4CZ8870l7rpiON7ocOR7Me8MM0zEhEwZm/0UnWZ
         xb0eOyjBo1tE5/yrUkFFzNGfXk0IMQqFaXgvgQmgnx6t7Q/ieFGMllaRCJ0+/hmhAa
         OVI2CLkcS36qkpexDIETUelaifR4eghO4GfP5Ywwe29lEOvaVO1fe6+lhP3kUGCEun
         M9CkpTS01zPwawvH3vfQYBHxYkZOtnXmEJfzGPJaZAf5UF7vkoe77u2dcRQ06Zi/h+
         Lzf7r9aeghgL7ZPdLdOoLFa9eIAk2MUQfK6SeqnSay9Tbwd0nJRipOO2YEoIAW1THs
         3pqmcTIqow9Sg==
Received: by wens.tw (Postfix, from userid 1000)
        id 4A61B5F8E8; Thu,  7 Apr 2022 01:30:11 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add prefix for SINO WEALTH Eletronics Ltd.
Date:   Thu,  7 Apr 2022 01:29:53 +0800
Message-Id: <20220406172956.3953-2-wens@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220406172956.3953-1-wens@kernel.org>
References: <20220406172956.3953-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Add a vendor prefix entry for SINO WEALTH Eletronics Ltd.
(http://www.sinowealth.com).

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..79b72e370ade 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1130,6 +1130,8 @@ patternProperties:
     description: Sinlinx Electronics Technology Co., LTD
   "^sinovoip,.*":
     description: SinoVoip Co., Ltd
+  "^sinowealth,.*":
+    description: SINO WEALTH Electronic Ltd.
   "^sipeed,.*":
     description: Shenzhen Sipeed Technology Co., Ltd.
   "^sirf,.*":
-- 
2.34.1

