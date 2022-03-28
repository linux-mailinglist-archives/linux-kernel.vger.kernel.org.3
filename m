Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E66A4E8B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiC1BCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiC1BCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:02:31 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC2424ECDC;
        Sun, 27 Mar 2022 18:00:50 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net [81.96.50.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 627B4140197;
        Mon, 28 Mar 2022 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1648428630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGfRjZnta91pDqb00FS0IyJHpRVsoSTogbe12bpoSb4=;
        b=X2zG46B5pNwGoT2nQfsdZaf9YtNrhXf8GJcEiWdevtF2Cm6PHVN0aslA0XeQHeQsnXffpP
        4zkZbszn7nISfJH8uRfhYZzXd0xZvY/eliL/ukQjDWcLR7igIDsWkSD0QOynje6lLG/y0n
        yp2Q+GNFhUsOWbUasS1mqbuZYZfeYUM=
From:   Caleb Connolly <kc@postmarketos.org>
To:     Caleb Connolly <kc@postmarketos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martijn@brixit.nl,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH 4/4] arm64: dts: rockchip: rk3399: add an input enable pinconf
Date:   Mon, 28 Mar 2022 01:50:05 +0100
Message-Id: <20220328005005.72492-5-kc@postmarketos.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328005005.72492-1-kc@postmarketos.org>
References: <20220328005005.72492-1-kc@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pinconf to configure pins as input-enable.

Signed-off-by: Caleb Connolly <kc@postmarketos.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 080457a68e3c..9b111bd89f0a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2188,6 +2188,22 @@ pcfg_output_low: pcfg-output-low {
 			output-low;
 		};
 
+		pcfg_input_enable: pcfg-input-enable {
+			input-enable;
+		};
+
+		pcfg_input_pull_up: pcfg-input-pull-up {
+			input-enable;
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		pcfg_input_pull_down: pcfg-input-pull-down {
+			input-enable;
+			bias-pull-down;
+			drive-strength = <2>;
+		};
+
 		clock {
 			clk_32k: clk-32k {
 				rockchip,pins = <0 RK_PA0 2 &pcfg_pull_none>;
-- 
2.35.1

