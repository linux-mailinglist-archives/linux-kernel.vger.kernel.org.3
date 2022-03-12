Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7533E4D7066
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiCLSnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCLSnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:43:16 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D326A019;
        Sat, 12 Mar 2022 10:42:10 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g17so20484517lfh.2;
        Sat, 12 Mar 2022 10:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuqg1BCHR8jyJiR0saNeZmDLCOyYBw2/8GqF2Qylz9Q=;
        b=fxNA1THozvIQG3ZA7C1TAg7j+N2GP5bYf1CSczFvph4SqnYyyL15FCom8LeAdtw3Hq
         D/qTyWsz+ocLsysShoisIXHLiTOYIdIvB6z79O+r19edsiSV6d1Y0ptB5KwAcyvGM3N0
         EpGtE88Yw190eX4LcQlb1uxd9fsJnduvJBFFhPsmzxpD843+wwQomnjClpN+4L6gDmsK
         bc+WqMtdof8+MmpKZq0Q+AV5EyzWNZhM1XRgAlDXCdPZl6UTg8UEuRprBPxx89t4OiZy
         dvmAwbIniOnBK18SM/5dOxc26q4TR3/G4tsZheOoFIGmxa6Vl5ppTbkKOtRPK5U4j1YZ
         t0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuqg1BCHR8jyJiR0saNeZmDLCOyYBw2/8GqF2Qylz9Q=;
        b=THVl+KxnRB7dZZ8Pg7muqofw4Fs2+oFMkTMhTMZnNLSRqrcElPOkA4L+18PL2J4U1E
         PS6tw0OAOKdFBFddkXYbHs1EVEILG8lMrg38R3EMgPh7bub4s5JThYKQDxeTH7ONt7hq
         Y1wIfeNUPitudpvNxPVWnTdKFjZ0207LB68bYF7Rrg5R54rPcB31cUICqp63ZRVQ4+Xe
         csfYZoTpev7ymDBJuKJFKGymIeo/0gRfOrbHAXu8wyXm9PqRW5O294+qFlsyHQubkFUK
         OMc+lMM26CtEpS3YJw332K0Tzvi8eyKyXQS4SEyoFelWy8GPXRbxbacp2Eey4TyJuXn4
         PUuw==
X-Gm-Message-State: AOAM530QZ1CZVBGbW4fhSnb2UFuPBONVXfKL9tTIC5IB9BM1yYZLB9Ob
        Z8wnRUNBWim8vCvBI56RcTkzKwxOOa4e1SqI
X-Google-Smtp-Source: ABdhPJxkW13aKF4nAnEeGLYbnDbBM8SD+QZ04cSOG0mjKD5rBygN61ANadBtB7hpcqDH8rvtpyrnlQ==
X-Received: by 2002:a05:6512:c01:b0:448:6aec:65c5 with SMTP id z1-20020a0565120c0100b004486aec65c5mr6934738lfu.193.1647110528767;
        Sat, 12 Mar 2022 10:42:08 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id b1-20020ac247e1000000b0044842b76861sm2311236lfp.140.2022.03.12.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 10:42:08 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos-upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: extcon: bindings for SM5703
Date:   Sat, 12 Mar 2022 20:41:53 +0200
Message-Id: <20220312184156.24912-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220312184156.24912-1-markuss.broks@gmail.com>
References: <20220312184156.24912-1-markuss.broks@gmail.com>
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

This patch adds device-tree bindings for Silicon Mitus SM5703 MUIC.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
index fd2e55088888..7a224b2f0977 100644
--- a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
+++ b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
@@ -20,11 +20,12 @@ properties:
     enum:
       - siliconmitus,sm5502-muic
       - siliconmitus,sm5504-muic
+      - siliconmitus,sm5703-muic
 
   reg:
     maxItems: 1
-    description: I2C slave address of the device. Usually 0x25 for SM5502,
-      0x14 for SM5504.
+    description: I2C slave address of the device. Usually 0x25 for SM5502
+      and SM5703, 0x14 for SM5504.
 
   interrupts:
     maxItems: 1
-- 
2.35.1

