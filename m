Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21AE466EA6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377895AbhLCAoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:30 -0500
Received: from smtpweb150.aruba.it ([62.149.158.150]:43625 "EHLO
        smtpweb150.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377849AbhLCAoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:12 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswd5mQfWy; Fri, 03 Dec 2021 01:40:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492048; bh=RJS2i0M8zKnI9Lsdi2zK0pDrPuDMLsiMLi2A/PbcU3s=;
        h=From:To:Subject:Date:MIME-Version;
        b=FDNlpxkjoTnqS0lmayCmM2hJE2bP2PIThARt2jk9iS7KfYXXu6v1y1elW+qY7W3Oa
         uB3FzN4Up8fOtmDbap6IZ0zGAqnZky4N3qVp9plDFXeDyLPgcAkZkLf49Z7dba/HwR
         6+sKPZ8Yg7/+Qzb1D/d1fbDkHjNwB3idYPcZQUTenS2mUzLeTuo69XHuv2X0dI/Q6o
         7JmKMP3tVaSmvxiKBDd4C1KO0P3t9Ngr+eq9TeVMAO8WcxZ/1yh7p49SgJQCLthPgc
         8qs0NUtlXZOwO3A4MLJ6n4FhKA4VMh68mI+xIQo3lE8vMk7p+RSAo5VzyZwlFdCxwU
         fYnZ+3NztRckw==
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
Subject: [PATCH 15/17] ARM: dts: imx6qdl: drop "fsl,imx-osc"
Date:   Fri,  3 Dec 2021 01:40:37 +0100
Message-Id: <20211203004039.48752-16-giulio.benetti@benettiengineering.com>
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

"fsl,imx-osc" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index f5de5def876d..7470a0f1fd2f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -67,7 +67,7 @@ ckih1 {
 		};
 
 		osc {
-			compatible = "fsl,imx-osc", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
-- 
2.25.1

