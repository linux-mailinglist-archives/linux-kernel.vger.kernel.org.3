Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3EE4FEF91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiDMGLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiDMGLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:11:08 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D734335DC7;
        Tue, 12 Apr 2022 23:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649830113; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=hpzg3wR0LpVH5X/8/57RA59bYRDXsf84Bb3hl8VxUS+hB2k2O+/zk+HDlD5suu+C+bcLWDcWGuHyjIG+6TSRp7R6T39s/HalBsEjYzn+Jc/gT7jkMTSrUAHrCtjHQ893ypQWS3o/LcGk0TzaBSl0VfUanYEUECHcEZB+BQzrw7k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649830113; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1BjrczZirfUF2dEXTl/cJGz/srxQHd03Uv9nvjAwYEU=; 
        b=dekgzskHx43z7DuUjdOyF3iGknQLw4InEb2ha1g5GyeBBOkHIEyFy5WEYVwS9GZ9zGhwZh3bpjYsHg4KKT9JukWT0cUD3A6b3OpcI9xSBF3KKKqLPt/mO+hTygn1klyw/Mdp2HBqIB+FpzomaPHWYc0E+F7VrpMKpzUwyrXAL6o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649830113;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=1BjrczZirfUF2dEXTl/cJGz/srxQHd03Uv9nvjAwYEU=;
        b=aBatCYOOIzcSb3fFkXcG8jq3VliSKO6ip08Rx0p9aK2EmP83Cqn33IzvZkDDYfLX
        AYBdr6uPE1664ca1RWoHNLxN036H8QSwAOaCIpuiTBTcu67J0tpoRsPfy5e1iZ7VBVz
        ZqLhN5WRAgqQvTDq6iP5Z3jb6P8TKWDUW6e5X/Fc=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649830111968178.63025992054952; Tue, 12 Apr 2022 23:08:31 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 09/14] mips: dts: ralink: mt7621: use the new compatible string for MT7621 pinctrl
Date:   Wed, 13 Apr 2022 09:07:24 +0300
Message-Id: <20220413060729.27639-10-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413060729.27639-1-arinc.unal@arinc9.com>
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new compatible string "ralink,mt7621-pinctrl" for the Ralink MT7621
pinctrl subdriver on mt7621.dtsi.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 3222684915ac..ee2ec78c8952 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -151,7 +151,7 @@ spi0: spi@b00 {
 	};
 
 	pinctrl: pinctrl {
-		compatible = "ralink,rt2880-pinmux";
+		compatible = "ralink,mt7621-pinctrl";
 
 		i2c_pins: i2c0-pins {
 			pinmux {
-- 
2.25.1

