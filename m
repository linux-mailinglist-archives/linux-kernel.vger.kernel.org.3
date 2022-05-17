Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5DC529819
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbiEQD2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbiEQD2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:28:11 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDE3FD8C;
        Mon, 16 May 2022 20:28:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id k2so13534977qtp.1;
        Mon, 16 May 2022 20:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BHjrg3q7IuLMPxNlV7eKLyKxXshoC3lJb+FmpZ+1H1U=;
        b=Q3rn8TdtlPSL3S5ahcv4y75S96cAvnvFIKB5bEIun052L1yZFBfs97bC/VC5GgufYZ
         O/gYzJBjLN/BGZohN5QlU8I/HESIqLXUo4qi8kPtV3Ar571hoHj91kX/RBlt+rfZMRR4
         2ORaRHCYJ7x7poizPlycNQ0JbHL9U9sdhzj/ng0QScbPt6Ye9h48V0u1n+Y3i164+g3e
         GEV7qafRInSOf2WmprSrCpRzRj7WwF6ruo9IDSwHos/Q/oGmFPrI3hjNurXP1XYM/XI/
         kVs51cJdSGxZP7a9wTgCmDyq5UwDXPyadRzx5cIy2yq/mx4k2cxyhMdMGIqAnWsO1oOv
         XKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHjrg3q7IuLMPxNlV7eKLyKxXshoC3lJb+FmpZ+1H1U=;
        b=EKzY47Pv0ZsYtu96Jmm/mrg3J7hnpdy+aZJLUgAEl4/Or9u22xeYytXfcfcFgF9rBt
         ef1RbnKCx5S9z+tXj4kSO8GfQz91vq1J7dUAxyO0bSAa7W1hGZXUjY98ULzmiaeixh5n
         5n8sOyIbaZVwuwgQKQQaBW9ioIRH4euxgBo6cOucZgAdHrqKi5xJ3RMREU+unQIJnefy
         3HfEwB4IVX6NT7sbANJyMV/MTOwfELSl97u3K2lnbcrm2/8z5YLsTzWf1Ko1Ln38JAo4
         8xsGfRWf+vQpij7BSCT8E9zTAfVcskqKbUo88oalOUmYK02XGax0Evgnbx5PHLWiStw9
         FNhQ==
X-Gm-Message-State: AOAM531YL1u8S8u1fGfYU+ovfKqzwy3YPI6Qu9ASSgnI/h4X8ywlTU3s
        hFzfAW4OwpU6RaffDoifSX6kPO6EdfE=
X-Google-Smtp-Source: ABdhPJzvUfbBzlEineKFbQ/653J8dRyajRuGOGPejuR0OmpMPEq7c5A3aRDJGFXYahUEawkdn0N/og==
X-Received: by 2002:ac8:5c85:0:b0:2f3:db73:3298 with SMTP id r5-20020ac85c85000000b002f3db733298mr17927028qta.514.1652758090015;
        Mon, 16 May 2022 20:28:10 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id a19-20020a376613000000b006a098381abcsm7079535qkc.114.2022.05.16.20.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:28:09 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 05/15] dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
Date:   Mon, 16 May 2022 23:27:52 -0400
Message-Id: <20220517032802.451743-4-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
References: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MXRT1170 compatible string to Documentation.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V1 -> V2:
 - New commit to fix dtbs_check
V2 -> V3:
 - Nothing done
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 30eaa62e1aed..d988d93eb5e6 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -21,6 +21,7 @@ properties:
           - fsl,ls1028a-lpuart
           - fsl,imx7ulp-lpuart
           - fsl,imx8qxp-lpuart
+          - fsl,imx8qm-lpuart
           - fsl,imxrt1050-lpuart
       - items:
           - enum:
@@ -32,6 +33,9 @@ properties:
               - fsl,imx8qm-lpuart
               - fsl,imx8dxl-lpuart
           - const: fsl,imx8qxp-lpuart
+      - items:
+          - const: fsl,imxrt1170-lpuart
+          - const: fsl,imxrt1050-lpuart
 
   reg:
     maxItems: 1
-- 
2.36.1

