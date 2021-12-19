Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA047A12A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 16:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbhLSPeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 10:34:17 -0500
Received: from fallback20.mail.ru ([185.5.136.252]:47382 "EHLO
        fallback20.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbhLSPeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 10:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=TtROKgMbo8kfwZokexEi1qH487IPn2N9DkbB2biMGos=;
        t=1639928054;x=1640533454; 
        b=DisEQ6+9Aa6BKQvAZR9xaDtAO0FtacHNSpYfzhk8AWuTfaTB1NTVj9rR5pDubSDzzEOwlNVZwbZNIiNFAW7ywsyLInUjZ3upiAwj7LmsglMzVY0Cp/0+b6+/pcIhT2CsMvPsEMKBXx1k/uSMozy+Nyh1ujm+BZteSpvkqBsslx4=;
Received: from [10.161.55.49] (port=59394 helo=smtpng1.i.mail.ru)
        by fallback20.m.smailru.net with esmtp (envelope-from <gtk3@inbox.ru>)
        id 1myyCS-00064g-94; Sun, 19 Dec 2021 18:34:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=TtROKgMbo8kfwZokexEi1qH487IPn2N9DkbB2biMGos=;
        t=1639928052;x=1640533452; 
        b=ic2OwEm5qV1VoyoH7qc2taqqvJoz4xqU+BD2QESIoiYn6IcLgNLrAxURu1VoXDw52HKNC1maL30i91GVZBEiBFd5sS4SDUxZ+eDOoH0cDkQgtL3UBBxPdMTogyHGJniCSYLwDYnE9KnZejqkD+qfqaJ+F0VXVT2RedobTGvcWVKRtO4JJAVJUGlQgvS3SETqPlZaQeSdaho8pPkopIbGShuJQySgcrI4AvWvCVaBakS7+l78bk5KylegX5IMiqLUvjK4AweuByTQJas78z/H/eSeoIqJVhz8J08AVg6Il9hBJlKf1XLyb7kFe0IFUrGI/oPZG4QeCk6Dhb09Hmk07w==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <gtk3@inbox.ru>)
        id 1myyCE-0000Gy-QR; Sun, 19 Dec 2021 18:33:59 +0300
From:   Maxim Kutnij <gtk3@inbox.ru>
To:     linux-mediatek@lists.infradead.org
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Kutnij <gtk3@inbox.ru>
Subject: [PATCH 3/3] This adds a DT binding documentation for the MT6582 SoC
Date:   Sun, 19 Dec 2021 23:31:34 +0500
Message-Id: <20211219183134.3849-3-gtk3@inbox.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219183134.3849-1-gtk3@inbox.ru>
References: <20211219183134.3849-1-gtk3@inbox.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9B5397E24C93BDA67728EE92B76C34EA93F43F472DF252270182A05F5380850408E2C77D129F0B5C164BFB4DDAAC7B9549365909DBC60B572A5A01CF329A45F8B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BC756B860944890FEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006373F9BB84380CC00728638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D845F50ADDCC460C1ACFC8D82FC99E57F96F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7FA587F4160EEFA029FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751FF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637028599BB38096F4F389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE493EFA58DFCB7B0AE11C8D5298E42E60C1FC4224003CC83647689D4C264860C145E
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975CFFD95778845B350B31DBFF92B5B027D8773C971C4292EC4D9C2B6934AE262D3EE7EAB7254005DCED7532B743992DF240BDC6A1CF3F042BAD6DF99611D93F60EF6EFF71F1B3C06F72699F904B3F4130E343918A1A30D5E7FCCB5012B2E24CD356
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D343C45ADCD169245FAF9473002471058ADABE5E9B5ACFDAA2FD907000E865807EB7C67CE4D7BE20C461D7E09C32AA3244C27CA708908193D0012EEF1F21BF40143A95CA90A1D8AC565DCA3B3C10BC03908
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojYItFUluOT4t9s6ayP29iYg==
X-Mailru-Sender: 689FA8AB762F7393C37E3C1AEC41BA5D159C0F68C27BC24DE62B72BA6983DE788F8182784CE3FA142B2697F7A04D759B04FC54F637BA925032C609A2DC06202998FD9B05CC386A12349DB15C680E247222B820C1B2086D890DA7A0AF5A3A8387
X-Mras: Ok
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4EBBC8B825784C22D375C245C831A3DFC8B927E6F72610821049FFFDB7839CE9E9E1E85326BB3F3D8E776973C881C6DBA9C533BD6F586FD17007F53A1B77D5EA2
X-7FA49CB5: 0D63561A33F958A53F9DBED60DD1387052FE93DEC65639E6D192708505B6DB1DCACD7DF95DA8FC8BD5E8D9A59859A8B605968FE12AFC105ACC7F00164DA146DAFE8445B8C89999728AA50765F7900637DC24B783B16D3BB1389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8EDC5C53491350371F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE77A602377AE384D0C731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975CFFD95778845B350B814BFDCF8E1DDEBE6067563181E8D44D9C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojYItFUluOT4tG73ysneZQMw==
X-Mailru-MI: 2000000000800
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a DT binding documentation for the MT6582 SoC.

Signed-off-by: Maxim Kutnij <gtk3@inbox.ru>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml           | 4 ++++
 .../devicetree/bindings/timer/mediatek,mtk-timer.txt          | 1 +
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 0fa55497b96..fedce0d0f3f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -26,6 +26,10 @@ properties:
           - enum:
               - mediatek,mt2712-evb
           - const: mediatek,mt2712
+      - items:
+          - enum:
+              - prestigio,pmt5008-3g
+          - const: mediatek,mt6582
       - items:
           - enum:
               - mediatek,mt6580-evbp1
diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index e5c57d6e018..62acdb11aff 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -11,6 +11,7 @@ Required properties:
 - compatible should contain:
 	For those SoCs that use GPT
 	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
+	* "mediatek,mt6582-timer" for MT6582 compatible timers (GPT)
 	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
 	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
 	* "mediatek,mt7623-timer" for MT7623 compatible timers (GPT)
diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index 0114871f887..a97418c74f6 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -8,6 +8,7 @@ Required properties:
 - compatible should contain:
 	"mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
 	"mediatek,mt2712-wdt": for MT2712
+	"mediatek,mt6582-wdt", "mediatek,mt6589-wdt": for MT6582
 	"mediatek,mt6589-wdt": for MT6589
 	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
 	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
-- 
2.34.1

