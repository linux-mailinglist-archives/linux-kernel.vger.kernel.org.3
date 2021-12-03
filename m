Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F32466EA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377915AbhLCAo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:28 -0500
Received: from smtpweb150.aruba.it ([62.149.158.150]:36301 "EHLO
        smtpweb150.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377853AbhLCAoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:13 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswd6mQfXG; Fri, 03 Dec 2021 01:40:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492048; bh=Rx+SBMUqsTnKXcpfkgcnkciqI0OV1H64qQy6HsIaVjs=;
        h=From:To:Subject:Date:MIME-Version;
        b=Cae5GpEWsBQf2nzaOeTXKc6E/TBB6ubvfrMCzPGVFlfJYt8eK0SCKVgwRoFdROlrv
         1ULJLImYqE/nmBdM6iZ4Jrb3Y7cnFvd4taoE2Q7AduRtr6bq0C5e38C1Upo8ld8kj8
         R779UwCPO6SO92Td8l/1OmwLeO7Zjk9Z83AkbbQZ7Cng+QuuyWcBG43i5z/eUc7GIu
         mzakKcGO/DWEOKotfjOA8gC3L3zwUP4Sdcc9sMl5sKfvmTceGFOXZ9kfUQditk1E+r
         3wdNgtvJ+PlASd2b2C86ljE6WMXOjWk4PTVKQhEvhfhOprS8UcuL3KpBSXy97aKdOs
         4roWzdy57QhCg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 16/17] ARM: dts: imx6qdl: drop "fsl,imx-ckil"
Date:   Fri,  3 Dec 2021 01:40:38 +0100
Message-Id: <20211203004039.48752-17-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
References: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAiWziBfIx7zabEMPiQAK1wc4rZloyjtz/paPEYmY8OQ0gQL88A9ICSxGHXLhL07wGtFVLHDq8mC7mbRbrAJruLjQPEDB1BZrRg1FQgfuZlHNoTXUgH4
 atUJPbheVAx23k1F7kUu0i6Kw1ahp/D9ybORgDD8t/sPai2SBkAi2jojN0H9wfazzmjViOh0Mr6lN3/43R4iS5lzn2NfPLtub9fL7x5gkYXVV5tFqJeo1V9k
 xDrGTXooPK8CywEx4GWqH0gcaKI+pErfyCqZ8LryVTjJG2SvMxEfyPVNNudY9d/4hqCxcOl8JKgwpFqQRgNf0nVY76Y9Sc80Bp66Yzdp6iENQJSvKLbWlAPj
 mnRldO39Y3+mdhIM+1jKlclhBAwIYiuhqfIPC+JpPgzrX0Nc56F2CmnlHBac2sToi5Xs7i69YrjfCz+jM0Ou8HeGtPGTyZeWmKXBUNvFDFe5aXh8Gu0k8Sum
 vijngrxv86PvT7/QIAVhKuc6CE4AXoa3+O9MtR9kYkb65IihSd7fPtyhPOFr7QsvD6o7Y7yWN0/Kgm6xjgnnCWoCEbrvN8CmHLaa63Sepw3fM7/IhXoYK73N
 TUI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,imx-ckil" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 7470a0f1fd2f..215e835a9b93 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -55,7 +55,7 @@ aliases {
 
 	clocks {
 		ckil {
-			compatible = "fsl,imx-ckil", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
-- 
2.25.1

