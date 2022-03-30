Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBBF4ECD06
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350685AbiC3TLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350584AbiC3TK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:10:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CF52AE3B;
        Wed, 30 Mar 2022 12:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD56461469;
        Wed, 30 Mar 2022 19:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21167C34114;
        Wed, 30 Mar 2022 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648667345;
        bh=IMGRYL4762RuYiDXn6s/1D+8F+g1tetqqyWpwo+gfbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9twGcLsm9cZmNGNFmP/AU/sES2pORGckjk0YHsHiSkLME17uayzqMKrWDdg6OmvP
         xCQ6C91sh+i7/W5hp8PwCSAW3yttC3mPYEQI+Il0ho+SXTnLEeY26jPF7ICctp8Pkv
         LRP0Y9B/ixzv4yYPtwA8pfStwRS2nmVe2x8tKCH9KuVHt7HX4zMMsnFbHkHA0qjeMb
         V5Wu0URZfqtTWEBPFKQtanAf3tUl1EFTt9AzTYJrBg5q8t3OrYSUKYCEANYeYo0qk1
         NHhSUiLVcfdfrRjaSIzQnP44ikUoJD1wRWWjAdPIefSOvZ6PfTSr6SHLdF5mdhAwxv
         bZfxApeaRBcfw==
Received: by wens.tw (Postfix, from userid 1000)
        id 187C95F899; Thu, 31 Mar 2022 03:09:02 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add prefix for SINO WEALTH Eletronics Ltd.
Date:   Thu, 31 Mar 2022 03:08:43 +0800
Message-Id: <20220330190846.13997-2-wens@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330190846.13997-1-wens@kernel.org>
References: <20220330190846.13997-1-wens@kernel.org>
MIME-Version: 1.0
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
index 01430973ecec..bb4ae59a3c89 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1128,6 +1128,8 @@ patternProperties:
     description: Cypress Semiconductor Corporation (Simtek Corporation)
   "^sinlinx,.*":
     description: Sinlinx Electronics Technology Co., LTD
+  "^sinowealth,.*":
+    description: SINO WEALTH Electronic Ltd.
   "^sinovoip,.*":
     description: SinoVoip Co., Ltd
   "^sipeed,.*":
-- 
2.34.1

