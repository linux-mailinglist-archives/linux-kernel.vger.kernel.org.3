Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAF5473D97
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhLNHX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:23:56 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41226 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231425AbhLNHXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:23:49 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EB1752001A1;
        Tue, 14 Dec 2021 08:23:48 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AF752200CEF;
        Tue, 14 Dec 2021 08:23:48 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 326D540576;
        Tue, 14 Dec 2021 00:23:48 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 05/10] dt-bindings: PCI: layerscape: Add LX2160A rev2 PCIe RC compatible string
Date:   Tue, 14 Dec 2021 01:23:37 -0600
Message-Id: <20211214072342.22692-6-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211214072342.22692-1-leoyang.li@nxp.com>
References: <20211214072342.22692-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe RC mode compatible string "fsl,lx2160ar2-pcie" which is
compatible with "fsl,ls2088a-pcie".

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index f36efa73a470..1a601d51fbec 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -22,6 +22,7 @@ Required properties:
         "fsl,ls1043a-pcie"
         "fsl,ls1012a-pcie"
         "fsl,ls1028a-pcie"
+	"fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie"
   EP mode:
 	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
 	"fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep"
-- 
2.25.1

