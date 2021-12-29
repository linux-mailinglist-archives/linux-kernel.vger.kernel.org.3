Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7752F4814E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbhL2QKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:10:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51678 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhL2QKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:10:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87385B8184F;
        Wed, 29 Dec 2021 16:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FAEC36AEC;
        Wed, 29 Dec 2021 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640794242;
        bh=a4p7i+M3B0mX5lOuDxu5vbuMPAdTfD4pboT6oM4zW2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXmDnhlIhhtZfrdcLmEels1ScTSsokNhMDZH3Wljs/CXn9B/LcH4ZDbVdLbqDHRL1
         S4JQciPJoRTRBRYY4fIWWDYAqgia3obhKfg8aWQJU5kSDbI1Up1qb+09f8LVmj5TuD
         L21DN+voVXpVYmsI41DcbwqsJJVqOigmqXdbHlFD9VtGg+qzTIxKAX/B7ZKpLSbQxE
         sbjN7mv1+kdBC+yqJPt7LqSUTgte7s1mb1yngyP1QcufKMa+YCdkHHOarbk6SOizOO
         ZXahWIWkbPwEcSG5RHPphDjq2m/TsIsT1fkrNc7AeI7/s/NhRwADAEwTFnwkkQhXyP
         fyaPDTlhr6T9w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 1/7] ARM: dts: ls1021a: remove unused num-viewport from pcie nodes
Date:   Thu, 30 Dec 2021 00:02:39 +0800
Message-Id: <20211229160245.1338-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229160245.1338-1-jszhang@kernel.org>
References: <20211229160245.1338-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 281f1f99cf3a("PCI: dwc: Detect number of iATU windows"),
the number of iATU windows is detected at runtime, what's more,
the 'num-viewport' property parsing has been removed, so remove the
unused num-viewport from pcie nodes.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm/boot/dts/ls1021a.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 2e69d6eab4d1..1adc1771b454 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -814,7 +814,6 @@ pcie@3400000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000>, /* downstream I/O */
 				 <0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -838,7 +837,6 @@ pcie@3500000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000>, /* downstream I/O */
 				 <0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-- 
2.34.1

