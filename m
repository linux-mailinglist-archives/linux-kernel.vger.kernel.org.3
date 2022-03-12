Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E064D6E81
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiCLLk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiCLLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:40:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E4C20D8BF;
        Sat, 12 Mar 2022 03:39:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n2so9799086plf.4;
        Sat, 12 Mar 2022 03:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZduGRZNyhDNsymd0zgLH7cxoFknPff8y88HuU+Z6oU=;
        b=VqOgqA4WyH/Ryo/Wg0AnzvAnVn1iagCenqTlIolYVGyoGwO5sU4/nSD2hDok58McJ+
         RrrDhj1HmWHa0t3yV1YpoCxEPSYzZ5NZ7l3rh1fZAXt2tJAYGEEAqis55fEQdUrmN0tV
         bS1oojHndu3Zeolh0U5HzoZqs/r+DkxuII9Fa3vDv5Ciza/UNRhWk0BogrLPmZFL16bC
         YmycnfHZzI1lGOT3BGZV3ceiVM6MY2bBL17R1pRSJaR75zaF6QjcwzScwWRWoxHoaHcD
         Z+t76p++wj02WhW5TOY7fq9gqkdY9S4EFe5QdPCuuJo8p34GoNesK61yjxMPXcVRUbfq
         2RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZduGRZNyhDNsymd0zgLH7cxoFknPff8y88HuU+Z6oU=;
        b=QHpcN24u5tFEwQjxvwVPcQk3IKBRnFN5P7YPc8wlA0zR/aY/8VU4Wv5Hg+F8AXu/aF
         7cHsbMT4ve7rFybpqyjeQfZd5ASEUt/EV3jn0Kqn7SHpKMidgA00WM2eV4nLBWuUMq4E
         5d140l7ukMTmN5wMd8lUPI1d2TLmdfVH8s2n+aCRDITAyrulcmuKvLUvXtDEhK4Zsf6q
         1/YLPQc/trL79/r6Ott2Eb3dMv727m/qMJzh0CtiBKXaYa4z0RdwYS6S9davmCl92tsr
         kVQuX2ej4eDjYdYdrR8NWXGAwcKy6MK5rAFfoWqLdU+chG3vvt/5ImuHH8hX+Cx82Ig/
         KgZA==
X-Gm-Message-State: AOAM532BouCEbUYGsxtWMLeHUIHw9KeI4AmGLUFMYXnaYc7iB4Q9J0HL
        tBJoDvAFZd5wC5inOZS7gkA=
X-Google-Smtp-Source: ABdhPJz0kIMcIp9Z4XzlmuVD7OiSi8RmL0XGXQQChz7qqVhcyCCRcLaxj8KR+4c0kd/9GxKkxewVsQ==
X-Received: by 2002:a17:90b:4b4d:b0:1c5:c908:8645 with SMTP id mi13-20020a17090b4b4d00b001c5c9088645mr4112859pjb.133.1647085150754;
        Sat, 12 Mar 2022 03:39:10 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id h6-20020a636c06000000b00363a2533b17sm11065191pgc.8.2022.03.12.03.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 03:39:10 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: dts: ste-dbx: Update spi clock-names property
Date:   Sat, 12 Mar 2022 17:08:53 +0530
Message-Id: <20220312113853.63446-5-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
References: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
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

Now that spi pl022 binding only accept "sspclk" as clock name, ST
ericsson platform with "SSPCLK" clock name start raising dtbs_check
warnings. Make necessary changes to update this property in order to
make it compliant with binding.

clock-names:0: 'sspclk' was expected

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v3:
- Reword commit message

v2:
- Split patches as per platform

 arch/arm/boot/dts/ste-dbx5x0.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index dc0bcc7020f1..c28b32640254 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -755,7 +755,7 @@ ssp0: spi@80002000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&prcc_kclk 3 1>, <&prcc_pclk 3 1>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 8 0 0x2>, /* Logical - DevToMem */
 			       <&dma 8 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -772,7 +772,7 @@ ssp1: spi@80003000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&prcc_kclk 3 2>, <&prcc_pclk 3 2>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 9 0 0x2>, /* Logical - DevToMem */
 			       <&dma 9 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -790,7 +790,7 @@ spi0: spi@8011a000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 8>, <&prcc_pclk 2 8>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 0 0 0x2>, /* Logical - DevToMem */
 			       <&dma 0 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -807,7 +807,7 @@ spi1: spi@80112000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 2>, <&prcc_pclk 2 2>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 35 0 0x2>, /* Logical - DevToMem */
 			       <&dma 35 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -824,7 +824,7 @@ spi2: spi@80111000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 1>, <&prcc_pclk 2 1>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 33 0 0x2>, /* Logical - DevToMem */
 			       <&dma 33 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -841,7 +841,7 @@ spi3: spi@80129000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 1 7>, <&prcc_pclk 1 7>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 40 0 0x2>, /* Logical - DevToMem */
 			       <&dma 40 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
-- 
2.25.1

