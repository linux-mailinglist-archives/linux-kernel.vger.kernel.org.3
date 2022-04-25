Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E90A50D9C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiDYGwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiDYGwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:52:10 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319646D195;
        Sun, 24 Apr 2022 23:49:07 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4KmwbQ5KRkzDsMn;
        Sun, 24 Apr 2022 23:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1650869346; bh=X9r/gViEyERj3QdfbSpzf1vJ7D4I2koJWoEPclEgUyk=;
        h=From:To:Cc:Subject:Date:From;
        b=hU6Ht86PcVkEicT6g8dKFu+l8SWsrHNnWP11RbVrMgjVeoPwQpyObmWKp7VR80cx7
         zvUw5BItgetPee1YlfEBnZrP+hNxkOuiuHMENK2I4f69QQgVJwBR4Xhw9VHU59qN8A
         aTBAPqZS+yXt3s8VyJM8MLTSuR/W7d8INu9OutKA=
X-Riseup-User-ID: B99F5AF868D304E13E026E41E8363AE8632B12E80FB7D65A24F398B2BFEA6E64
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4KmwbN3mNBz5vTc;
        Sun, 24 Apr 2022 23:49:04 -0700 (PDT)
From:   Dang Huynh <danct12@riseup.net>
To:     Dang Huynh <danct12@riseup.net>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: pumpkin: Remove input-name property
Date:   Mon, 25 Apr 2022 13:48:51 +0700
Message-Id: <20220425064850.246228-1-danct12@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property doesn't seem to exist in the documentation nor
in source code, but for some reason it is defined in a bunch
of device trees.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
This patch is a split of this treewide patch [1] to ease the 
maintainers. 

[1]: https://patchwork.kernel.org/patch/12633497/

 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index fcddec14738d..7a717f926929 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -25,7 +25,6 @@ optee: optee@4fd00000 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		input-name = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
 
-- 
2.36.0

