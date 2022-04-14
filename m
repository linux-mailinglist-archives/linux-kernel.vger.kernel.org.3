Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0D6501A34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbiDNRnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343599AbiDNRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:43:02 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12905E2F5C;
        Thu, 14 Apr 2022 10:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649958017; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=U+BOK0yxGmhzsUrcSNrdl8S9x/AIthHTs84EHPilgjRUcemeuyVKL7l72czvLAiCnREv3BbNI+s3Q3nvNdKzYymN84kzxCTK2TTFHXtTVQejHUZYjS+ETbCwIhmA6NQO8apoY09E733FzkjXx94LtMB+t9IUVJ2kMnLzpjlsNy0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649958017; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=MB5zzWcylEqjeE5qy26s0JEc3WbeD8CfHOfbrOz2uqg=; 
        b=LaUhHkZaOcKqsul/1EEsbvJi12DxU9iy+qBpGaCMCe7gLHE/WB4zWyXaQhj6pFnMMaDeuEkARslw9gqn7576DiNogzZhoKxU/XJerJ5anx3/CAqzspiYEtJaWnpxJmpfzgOMnR9Vmjl5hzuQUheZoa28hXxwEWaZTsGITxssbEw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649958017;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=MB5zzWcylEqjeE5qy26s0JEc3WbeD8CfHOfbrOz2uqg=;
        b=YgK/x8W5mq8eWD0Eieec2lIx0O75cEFl+70SeV2AFXeIKp85fPGtf36M4GGLnjIK
        Grv805/J9goufe4gdKXvynUSsOK6p/nHKNvqabbMqnAC99nvl0EfKvPFbk261pxX97p
        fYJ4XKqRIqtIBO1CH82DBM7WscUHh+nTHSGeDUts=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 164995801641693.13202580357915; Thu, 14 Apr 2022 10:40:16 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 09/14] mips: dts: ralink: mt7621: use the new compatible string for MT7621 pinctrl
Date:   Thu, 14 Apr 2022 20:39:11 +0300
Message-Id: <20220414173916.5552-10-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414173916.5552-1-arinc.unal@arinc9.com>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
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

Each subdriver needs to have a different compatible string. We don't want
the same compatible string to match a different subdriver's pinmux data as
it's not for our SoC.

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

