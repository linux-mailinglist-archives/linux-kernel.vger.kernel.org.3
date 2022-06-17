Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970FB5500CD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383707AbiFQXcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiFQXcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:32:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D00766F9F;
        Fri, 17 Jun 2022 16:32:01 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E2CD66017DD;
        Sat, 18 Jun 2022 00:31:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655508720;
        bh=nIpAmQ9qPs2TwbqhrUmn9gsTTFLPJRRk9xBahMemHjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oozUUfD3UffUQZwHuB2+M1iZ+3Ch+qEgieLytLLvI9yMSJJpEBBZCT1b3tzK7mC8A
         QKQ9WRQbhIPXXcfo+mHW0g1FryTBU6JulOWp3dKVlEx5cMaveNlywPh+oqWXH8NkJ+
         MXFHNSVoOkt7iDczhlz5GlUbovLN9rf8IDWuszQChIdM77kM/G8tfivQsl8Je/uOZA
         XQYUM9a2y60siCyWOMA7QNIzS+CXADx9lTeRjMWgwFoC6a40BFzJuE/XnSIJDwiasN
         VCUb8QpvMO5gptarMIkgFD0cnaVsQ+vfmnqpWECza9c6hUlQNKkrZ+u5tUY0HOPcD6
         9DFfd17exuMxw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, James Liao <jamesjj.liao@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] arm64: dts: mt8192: Fix idle-states entry-method
Date:   Fri, 17 Jun 2022 19:31:50 -0400
Message-Id: <20220617233150.2466344-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617233150.2466344-1-nfraprado@collabora.com>
References: <20220617233150.2466344-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entry-method property of the idle-states node should be "psci" as
described in the idle-states binding, since this is already the value of
enable-method in the CPU nodes. Fix it to get rid of a dtbs_check
warning.

Fixes: 9260918d3a4f ("arm64: dts: mt8192: Add cpu-idle-states")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index c739e910883a..d5cae38c842a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -172,7 +172,7 @@ l3_0: l3-cache {
 		};
 
 		idle-states {
-			entry-method = "arm,psci";
+			entry-method = "psci";
 			cpu_sleep_l: cpu-sleep-l {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x00010001>;
-- 
2.36.1

