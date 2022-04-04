Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E054F1F01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380284AbiDDWHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380660AbiDDUuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:50:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9454ABE3D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:48:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c42so5143723edf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xP9jxTSak01lxmiakKDzw6tCWTqu+z8FWoXYBzz+at4=;
        b=omy2AIuqVywXHaB1TgVBQfaL9aXT1m5LbFuwW9cXRgAPQqqhmvl76Inrg9qaryawnM
         esujdaeCCX8Sc53UgzDu89sgMls/ZD1WNjF+YjzI/gaIvUjnxX7KZnYoZDK0M0lUl+Mv
         YjjT2wenD9tsKUjynE0FVjcvyzXWeqGwQb9jNs0Rgu4OMMjiSWFQpcimHPG3rNwIvCCH
         QHIvEe4EEWAhJaC5xKejr/7hr3d/Ccd9Qoi782kpfWQnCDZVE6oG7oR1J2LAHHOfQXBn
         M2f58A16NVleW2/g0wz+Hkf1J7USZghZBUnj4i4trrMP5460NIfHF+SoI/m1i6+yM0s2
         hwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xP9jxTSak01lxmiakKDzw6tCWTqu+z8FWoXYBzz+at4=;
        b=5cRaWHVQkxKQW6U1RkakoF4kpDIPE9uGjBkCV5Wm17LxEX9VS4GT/KFFOZL/WS0A0F
         hzFHdsHw183Ihhsha2iQX/BTmBVIPw8C3m9N19CBE0Fe0rdhh7y5gPXwgN36yeHAF7VB
         1oSkEcpVnf8dYUh7823rdnF2coUdw0r7Il5xDyqJLGgMYQ68USE1uECjsEQNGEeG7EXV
         3xdtS4oPe9eL72Sm02IO86da3fUx7tDIlGvQoLwDR2gxhQEvgV9esRw8ziwy5hT6rj9E
         TctEhAwh4qo2mZsjJaN25+cqjbfVqUmQhXESYdyE8f16yMBCnYW5dOEoJkNcnIme+TPY
         pcBA==
X-Gm-Message-State: AOAM533Yk8qHRspgDNzRhyNlf99LmUCsOWGCDm4ynmCNStgv78OuknU2
        ax5euf3EFmKQur5ByP12pRs=
X-Google-Smtp-Source: ABdhPJylTVfzbgmKB6QFg2/UzA2mS8DmKOyUftLfYwf62WUoAAVvOesuayHErRHSY6zVeeaPkb5P7A==
X-Received: by 2002:a05:6402:43cc:b0:419:2486:6cd2 with SMTP id p12-20020a05640243cc00b0041924866cd2mr4973edc.334.1649105325066;
        Mon, 04 Apr 2022 13:48:45 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id n27-20020a1709062bdb00b006da975173bfsm4843522ejg.170.2022.04.04.13.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:48:44 -0700 (PDT)
Date:   Mon, 4 Apr 2022 22:48:42 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] staging: vt6655: Rename constant definitions with
 CamelCase
Message-ID: <19cfb3ec78eaba8e839578b1ea5a6eb09e8c09be.1649103348.git.philipp.g.hortmann@gmail.com>
References: <cover.1649103348.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649103348.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename constant definitions with CamelCase in mac.h as
they are not accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: This patch was 3/7 and is now 2/6
---
 drivers/staging/vt6655/mac.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index a1576e006d69..6221351c6400 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -261,18 +261,18 @@
 #define TFTCTL_TSFCNTREN    0x01
 
 /* Bits in the EnhanceCFG register */
-#define EnCFG_BarkerPream   0x00020000
-#define EnCFG_NXTBTTCFPSTR  0x00010000
-#define EnCFG_BcnSusClr     0x00000200
-#define EnCFG_BcnSusInd     0x00000100
-#define EnCFG_CFP_ProtectEn 0x00000040
-#define EnCFG_ProtectMd     0x00000020
-#define EnCFG_HwParCFP      0x00000010
-#define EnCFG_CFNULRSP      0x00000004
-#define EnCFG_BBType_MASK   0x00000003
-#define EnCFG_BBType_g      0x00000002
-#define EnCFG_BBType_b      0x00000001
-#define EnCFG_BBType_a      0x00000000
+#define ENCFG_BARKERPREAM   0x00020000
+#define ENCFG_NXTBTTCFPSTR  0x00010000
+#define ENCFG_BCNSUSCLR     0x00000200
+#define ENCFG_BCNSUSIND     0x00000100
+#define ENCFG_CFP_PROTECTEN 0x00000040
+#define ENCFG_PROTECTMD     0x00000020
+#define ENCFG_HWPARCFP      0x00000010
+#define ENCFG_CFNULRSP      0x00000004
+#define ENCFG_BBTYPE_MASK   0x00000003
+#define ENCFG_BBTYPE_G      0x00000002
+#define ENCFG_BBTYPE_B      0x00000001
+#define ENCFG_BBTYPE_A      0x00000000
 
 /* Bits in the Page1Sel register */
 #define PAGE1_SEL           0x01
@@ -497,7 +497,7 @@
 #define MAC_LB_INTERNAL     0x01
 #define MAC_LB_NONE         0x00
 
-#define Default_BI              0x200
+#define DEFAULT_BI          0x200
 
 /* MiscFIFO Offset */
 #define MISCFIFO_KEYETRY0       32
@@ -698,7 +698,7 @@ do {									\
 do {									\
 	unsigned long dwOrgValue;					\
 	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
-	dwOrgValue = dwOrgValue | EnCFG_ProtectMd;			\
+	dwOrgValue = dwOrgValue | ENCFG_PROTECTMD;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
@@ -706,7 +706,7 @@ do {									\
 do {									\
 	unsigned long dwOrgValue;					\
 	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
-	dwOrgValue = dwOrgValue & ~EnCFG_ProtectMd;			\
+	dwOrgValue = dwOrgValue & ~ENCFG_PROTECTMD;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
@@ -714,7 +714,7 @@ do {									\
 do {									\
 	unsigned long dwOrgValue;					\
 	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
-	dwOrgValue = dwOrgValue | EnCFG_BarkerPream;			\
+	dwOrgValue = dwOrgValue | ENCFG_BARKERPREAM;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
@@ -722,7 +722,7 @@ do {									\
 do {									\
 	unsigned long dwOrgValue;					\
 	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
-	dwOrgValue = dwOrgValue & ~EnCFG_BarkerPream;			\
+	dwOrgValue = dwOrgValue & ~ENCFG_BARKERPREAM;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
@@ -730,7 +730,7 @@ do {									\
 do {									\
 	unsigned long dwOrgValue;					\
 	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
-	dwOrgValue = dwOrgValue & ~EnCFG_BBType_MASK;			\
+	dwOrgValue = dwOrgValue & ~ENCFG_BBTYPE_MASK;			\
 	dwOrgValue = dwOrgValue | (unsigned long)byTyp;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
-- 
2.25.1

