Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682D448AC63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349421AbiAKL0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:26:06 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:30484 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238606AbiAKL0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1641900364; x=1673436364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tE56ejiaXvisyCzKIBi27BtjK5MCBMyU1d242DcfKqU=;
  b=qZ18CR3f5Qs3DSzyMmZt/2xCb6hLiC4p1bx2BFzKecAHYuJvKxbwf3rm
   D21vwQcG9XLmdXRQab5AHoKDPZnuuxTBAc5kHGwXfnK4scHBgKfY550Td
   UOQeMtnG5NTWQ/W0q/Sc/zxWe1m4B/jjEBUUPSRkc1Iym8SN+Ev4diEHr
   KXVp8ULhW4wD4e5z2Mljj4ebJQV6GRnkIfJbsRYgcDOrgD2526Za/mxha
   p31Ry1nIihguO1qotrUiYk49ostWUjpaTM9blX55A8+cJvCJLsMA5Viwg
   SNBNfP8RtOdh4fBBbKUj15FRxLKlu+Hh5HIHNJTUyQSRyepCat7jxIiEt
   A==;
X-IronPort-AV: E=Sophos;i="5.88,279,1635199200"; 
   d="scan'208";a="21428427"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Jan 2022 12:26:01 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 11 Jan 2022 12:26:01 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 11 Jan 2022 12:26:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1641900361; x=1673436361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tE56ejiaXvisyCzKIBi27BtjK5MCBMyU1d242DcfKqU=;
  b=AOwKM+sfwRZrJKDKQWcIu/7yrH1CvBS8LaWEPQaCY3e0UlwxHaDrvBM6
   u/UAm2Y5YhdA3/W0Zj2NU1VRNls2qHVUgpvM554JEq1oROzdri2kgYoiG
   /YMEft81WNadzIVeechjnG0x/WdVVHJVk9AWeuJLt6UspDevgOHjJd8jU
   S3iGwbXcPzY4/uNdMpqUz9hicrRU986bOXpfhCGyAafAsmGVvEC3dRaiR
   rhP1LSC2bpuezf5iW1DQ1JsycgBrrpxmMZRHM9Nlz6nc2lmCrOjTHWXql
   5pNj45v4CCFJUpREpBcflYbcRttzbAF2fXjzsCG3sernMYJjV++X1U4py
   w==;
X-IronPort-AV: E=Sophos;i="5.88,279,1635199200"; 
   d="scan'208";a="21428426"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Jan 2022 12:26:01 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.201.138])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id E2FEC280075;
        Tue, 11 Jan 2022 12:26:00 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jan.kiszka@siemens.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am65*: remove #address-cells/#size-cells from flash nodes
Date:   Tue, 11 Jan 2022 12:25:30 +0100
Message-Id: <6e245e545a2927d2bd4bbc7df9197e6669ccce93.1641900122.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5beef188724ef42b0c2147ca9bf6e6ca25c75dec.1641900122.git.matthias.schiffer@ew.tq-group.com>
References: <5beef188724ef42b0c2147ca9bf6e6ca25c75dec.1641900122.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specifying partitions directly in the flash node is deprecated, a
fixed-partitions node should be used instead. Therefore, it doesn't make
sense to have these properties in the flash nodes.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 --
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 8 ++------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 873c123c611e..7eca697e1ca1 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -623,8 +623,6 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <2>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 821ee7f2eff0..9c06da9d6d8f 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -340,14 +340,12 @@ &main_spi0 {
 	ti,pindir-d0-out-d1-in;
 	status = "okay";
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 		spi-max-frequency = <48000000>;
-		#address-cells = <1>;
-		#size-cells= <1>;
 	};
 };
 
@@ -442,7 +440,7 @@ &ospi0 {
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
 	status = "okay";
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -453,8 +451,6 @@ flash@0{
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 	};
 };
 
-- 
2.25.1

