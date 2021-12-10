Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A5D470181
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhLJN1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbhLJN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:27:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD8C061746;
        Fri, 10 Dec 2021 05:24:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 08E981F4769D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639142644; bh=Vb5Bjd+fXKA+b0blXOHq5tV616m7oKW8StxQz1eT4Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLhuHjuwjxCogLotMu2ZNAPJXs1tST3lA6bbbPODF3ZM5jrxjW1DBuLolkmZeQL/0
         UcpjBFOrDC1eCN+DXal0JFmpckvfeNUHdHyumMYLt4nvWrZJtyCauKO6TBqUrdnFR9
         +N7tgdo7VMI6+yG4+vKVuWb6tQ85lgobmeo6A4S4jRdbfWqCCrzw99YoG7dZpe9A91
         0fFt5wcOCt1LNu9Zt6mUxeQsc+dmWtI6GBhx4xWcQKjs/d5Z6Lr1m25pQ6g7Yp+W1n
         Z6aoCS2GDZNxdkxPEJZMlnr2qbHnnDe298BMUyZ/hQZuAZAA+r+bJgSDY/tJqzfE7b
         ddkojMq3WcTBg==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     aisheng.dong@nxp.com, ariel.dalessandro@collabora.com,
        festevam@gmail.com, ioana.ciornei@nxp.com,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tharvey@gateworks.com, robh@kernel.org
Subject: [PATCH v4 4/5] dt-bindings: arm: fsl: Add BSH SMM-M2 IMX6ULZ SystemMaster board
Date:   Fri, 10 Dec 2021 10:23:18 -0300
Message-Id: <20211210132319.61196-5-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210132319.61196-1-ariel.dalessandro@collabora.com>
References: <20211210132319.61196-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for BSH SystemMaster (SMM) M2 IMX6ULZ board.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d49c4b786f09..461b9888812e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -632,6 +632,7 @@ properties:
       - description: i.MX6ULZ based Boards
         items:
           - enum:
+              - bsh,imx6ulz-bsh-smm-m2    # i.MX6 ULZ BSH SystemMaster
               - fsl,imx6ulz-14x14-evk     # i.MX6 ULZ 14x14 EVK Board
           - const: fsl,imx6ull # This seems odd. Should be last?
           - const: fsl,imx6ulz
-- 
2.30.2

