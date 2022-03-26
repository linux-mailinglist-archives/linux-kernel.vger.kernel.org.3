Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335144E7EE8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 05:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiCZEZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 00:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiCZEZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 00:25:20 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D563AA60;
        Fri, 25 Mar 2022 21:23:45 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bc27so7995028pgb.4;
        Fri, 25 Mar 2022 21:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y3lKwUZ3g3mmZbBW6jWldu/ZLBfDQ2HUmQZ0fDeopes=;
        b=FaasoctGiouHOE0MA/LUKa748CgeOP2TlJM6wXIvSsASql9CAlx4+CamguYHXQK7hk
         /RJrOqO9LXkT76eVNE7zo+VK/VKAW8n41Igm+WzHOQf/F5vPTokBaBWTV7Darc6J2e5P
         Igx2bsJ4YrnqhQYF7i9W/ljzOQrqv73f0dTUAmg/o9g/8R2PDY+y7oeaOfo1bmOAERyO
         r06fvbfoUlHlvBVvS3hS6we0VvT9UYS4f8ZEqlMUwkutSPNz/12XKnVtGZE8LwkLrIfK
         NjIQeLZyATOj8hb4jVFjhyvTRPLvJCxqSiMd8ZqZKwa3ihwee7MmQYQwhRYYaYRy/GHx
         LvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3lKwUZ3g3mmZbBW6jWldu/ZLBfDQ2HUmQZ0fDeopes=;
        b=KONH5ch3bM1V3batQBfT2CBjaV3DqdCuU1DvA3LO3c6r5rLKN9gXfspMhi8Lwn9PSj
         /Zvcjinooq7zwJUnE3QlK5ye+j2t/aUS6AXjroyytHCEpppzslq0QX6m/ml9U0rwb7ab
         hd/K61+R1aF/QwD0rr06iZfZ2/cDpzsm7kzojO7cJvLC2ldgp6eTcrLset0v1Tq4wc/+
         9G/Tyr+9ZcqNE84UtGv3g3dohVlC8sPqPDt1bSysKKoWE4WGgo76jvRW8AICNqcdIpnK
         wGt7ZlAes+Z7TqdydW1h69n28tgJBP242hW0M0qgXLboFFizfNFrSqv9PK8MwLaykHej
         qJ4A==
X-Gm-Message-State: AOAM532jD5R1C3R90HGgP4lzrWlFBqCdfEscpxNflbXt6OrtBVpeqYHI
        mjpZK2ZG+feeYFAGZBD+mJQ=
X-Google-Smtp-Source: ABdhPJzIcDTFErfbXl6zCRYc7bTn9Iqx+4ylY1p9ch27jmCBgv6Aw6vwfVal2J2KHK34DwOPBkaRsg==
X-Received: by 2002:a65:6093:0:b0:373:9c75:19ec with SMTP id t19-20020a656093000000b003739c7519ecmr2211430pgu.539.1648268624930;
        Fri, 25 Mar 2022 21:23:44 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id gd10-20020a17090b0fca00b001c75d6a4b18sm7457544pjb.14.2022.03.25.21.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 21:23:44 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: spear1340: Update serial node properties
Date:   Sat, 26 Mar 2022 09:53:10 +0530
Message-Id: <20220326042313.97862-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220326042313.97862-1-singh.kuldeep87k@gmail.com>
References: <20220326042313.97862-1-singh.kuldeep87k@gmail.com>
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

Reorder dma and dma-names property for serial node to make it compliant
with bindings.

Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm/boot/dts/spear1340.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 827e887afbda..13e1bdb3ddbf 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -134,9 +134,9 @@ serial@b4100000 {
 				reg = <0xb4100000 0x1000>;
 				interrupts = <0 105 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 12 0 1>,
-					<&dwdma0 13 1 0>;
-				dma-names = "tx", "rx";
+				dmas = <&dwdma0 13 0 1>,
+					<&dwdma0 12 1 0>;
+				dma-names = "rx", "tx";
 			};
 
 			thermal@e07008c4 {
-- 
2.25.1

