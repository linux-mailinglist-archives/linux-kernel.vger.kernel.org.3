Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290B556051E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiF2QBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiF2QAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538C1E3D3;
        Wed, 29 Jun 2022 09:00:23 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7DFDD66019A7;
        Wed, 29 Jun 2022 17:00:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518422;
        bh=WwpPbFWF71BcviKH9+5zJIkujt+1e+ShgiMHmhnibhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REkGP/3Av9tLCsMI1k+M+ZSrjZOnpWOzu8IjqUxciTUidm02mtNHXYb9iQvTKLTG8
         FHRh+Uo2peZRsqaTmGqkr8uGsXH8HeHl7QpQBCFMFDKTMir9LuLq+WTs0hhNrqj+Pp
         OlvXOMI9IzIT2vjEedlAKEZ4pFAwQsZPJI1fCMxUaTJiUh7FkQLsDvRjmiO5l7m30p
         qQci6w3RY76KTQ2S5+7G7x2fdK8dzJJfSli85eMHtFaR+RcDqs9udMgu/8jcykC1PX
         1Jcn64IAaQ/RrvuaV41+HdfaZnmWcypdwrGUgShdISMXgBng4QrK2fLG6HZBsZtAj7
         HU1pF1JSe+xSA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 13/19] arm64: dts: mediatek: asurada: Enable XHCI
Date:   Wed, 29 Jun 2022 11:59:50 -0400
Message-Id: <20220629155956.1138955-14-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629155956.1138955-1-nfraprado@collabora.com>
References: <20220629155956.1138955-1-nfraprado@collabora.com>
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

Enable XHCI controller on the Asurada platform. This allows the use of
the USB ports, and therefore a rootfs can be loaded and a usable shell
reached from a live USB image.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

(no changes since v2)

Changes in v2:
- Added this patch

 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 6eace280c14a..69bb43f7b346 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -579,5 +579,13 @@ &uart0 {
 	status = "okay";
 };
 
+&xhci {
+	status = "okay";
+
+	wakeup-source;
+	vusb33-supply = <&pp3300_g>;
+	vbus-supply = <&pp5000_a>;
+};
+
 #include <arm/cros-ec-keyboard.dtsi>
 #include <arm/cros-ec-sbs.dtsi>
-- 
2.36.1

