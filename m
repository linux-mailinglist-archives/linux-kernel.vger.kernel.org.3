Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86864B1F25
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347650AbiBKHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:14:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbiBKHOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:14:21 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6350A10A4;
        Thu, 10 Feb 2022 23:14:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a8so20847551ejc.8;
        Thu, 10 Feb 2022 23:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/Q37Q6+RR2dveoR/2NMRAXYHb7wS8kwm6B1afPK3/I=;
        b=g3DRs0hxeXLgRMPGhKfi8RMEtZ057c3rsMDVudM1nzOamswQ1lC0qwM5k4Sen9KCN6
         RynF5Oe/P9tJhuPg7kbSm8nrFV8fkbqy7RrKirocHcDK7ceVy1cLAxEmkn5nP9PSMJOP
         Rf4Fh4TjkSnFDW/7gnVciv6LvOx0NPcXgzAfn/uyjtflnkBO8blVNcAwgRNUeMo0y09X
         pN12m0z8i6WY1UaKtSvuaC+OO3QYXQUzEN8Ih9bj0BKUj75LGxJI4P4C2mCRoByf4CIF
         IFf2mDVDJCBLbaIXVtxrH/pbfg9sm90ijC8kShRlHwZe5DT6ISVy85+jujQ/OQsX4saB
         L7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/Q37Q6+RR2dveoR/2NMRAXYHb7wS8kwm6B1afPK3/I=;
        b=W/EXjsCxLNJIlzX8W0SAZBzetkI5Y14BRaJGsMM/0Va5c2AtQmZVCKHTtsPt6t/HgU
         iaXR3FzQOm1fIRZdrRK7fsFbOjD1lD92vhkdKOFJVkxlT1lCZQBvWgtOK/macOVMQjxO
         rxfzAfaHmRZSw8o5qFI/tpFKBJ4Pv7TF4PgJ8IyFCjMz4gkwSE/CXAMIjY/YpIzzIdXg
         wV82NWzdFuKN8KL0MyisSj7IOFUSOu12hMdplHiuR7sPxAA2M+e7gxzslIzbluobh8aU
         EKZvrGkU2BMmfXjDF4ZiOR0QaffMXYpp22RgDKzpxWuKduAGhhYzkSbmd2jHo5ZAPQSN
         jCng==
X-Gm-Message-State: AOAM533VfqZGK/zF0EVtwsjZ+jwDGnzd0xWnHfcuhH6uvMaKlXCCqMSq
        KhLtcw5cPGNAw5c1kF7OipFol/hl6As=
X-Google-Smtp-Source: ABdhPJwas9ZB5I92u4PowwOoMZdiEpc3QwgD75Ye2plNUVl7KLTWW+kz2Rcxqc2di+FwX89Z0y51lQ==
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr270572ejc.758.1644563658696;
        Thu, 10 Feb 2022 23:14:18 -0800 (PST)
Received: from localhost.localdomain.at (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id q7sm4484784edv.93.2022.02.10.23.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 23:14:18 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     nm@ti.com, hnagalla@ti.com,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: k3-am64-main: Add ESM0 bus mapping
Date:   Fri, 11 Feb 2022 08:13:58 +0100
Message-Id: <20220211071403.56146-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the kernel repository is the source for dtsi files for other
projects like U-Boot it makes sense to add the ESM0 bus mapping,
even no Linux driver needs it (yet).

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index 84bd07cd1824..09ff14643ee6 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -66,6 +66,7 @@ cbass_main: bus@f4000 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x000f4000 0x00 0x000f4000 0x00 0x000002d0>, /* PINCTRL */
+			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
-- 
2.34.1

