Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681974FEE55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 06:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiDMElc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 00:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiDMElX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:41:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0424952
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:39:03 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d71so543930qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WErFaGsZeydU2G+yqS+vuepSAgxDO/xhmvr6tbUUEKs=;
        b=LgxEj98Ue+g5tZSw7pySZKcC+mlOTyCjF2bv1rvWqw6PGnNi2GVJ5cpx+jrwapHcM/
         PV/bXRZy+w6MedYIUuVPY4LgKFXnxZUmG7cpwqgTs2jKKRFDmS1AhZmIlypjvT+J7pTM
         7oP5PTIvF00mvMNY4oQHnPDoXmX8v0pZ071h/n9lKPulEJVzg10H2def68+nn0gh91oe
         GquCSuwKEWYxcXymRDx5pLKHst+rNIiyHX7fJIipX1VDX8WTAEre6BAIXDI73ciXgd6F
         jHCjVzkxB1H9WbaEbXj6i1lfp/VQVMKxAWTfyAqvgKs6EQbzJSNYJZ1yze9d/1Mm4+gc
         3EmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WErFaGsZeydU2G+yqS+vuepSAgxDO/xhmvr6tbUUEKs=;
        b=Z8XAcjF0EDZijuJakTL58NRK/UE2r1rvIfCJ19mCD64dwCqu/3ycmietodDZ8HnSsN
         wy8FPJaL8vdCz6JUAxGfgNytyxFOvWlRM8OxkqhN/niS3g7SORovCDBxYKYlqTjhem4h
         cDcXF6pghOZXVzY9VyjNf5SGDEEJ/PgqiCL5bTH5K7VIfKeLGMIIKX2xRInPq+4TLSJJ
         UG08KmaUtnR/BjKyM3skg4cTazeq+F/e4aC0mufYHQuU3EGJcBUZD/zP2HtExTyb/Wom
         Uzgnr7T/dsUkGX/Cr4EbxfEusegLz/h8gboPRYprQlRPZgyUlD+IUTOxRAwcQxpIMi6X
         H0wA==
X-Gm-Message-State: AOAM531vRAmPunUEfF9ZlLiosQtdwPVoICaOjS3gYs9RgQ4egZ4iaryY
        lSy8A3r0QdL3mRBV/AuIlKI=
X-Google-Smtp-Source: ABdhPJzMUjmFOWMutAiPHFw3TfOyB6lPTD/Bv8L4/M11SKvSvx8jIlR/T0XmQ2lqWc+oLQYEgEL3sg==
X-Received: by 2002:a37:4349:0:b0:680:f1f5:23b0 with SMTP id q70-20020a374349000000b00680f1f523b0mr5388159qka.530.1649824742805;
        Tue, 12 Apr 2022 21:39:02 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:50fb:900e:5e57:caff:f44b:33f4])
        by smtp.gmail.com with ESMTPSA id d126-20020a37b484000000b0067e60283d08sm21984056qkf.40.2022.04.12.21.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 21:39:02 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        jhpark1013@gmail.com, Alex Elder <elder@linaro.org>
Subject: [PATCH v3 1/2] staging: greybus: correct typo in comment
Date:   Wed, 13 Apr 2022 00:38:51 -0400
Message-Id: <2feb03de97ca4dbd27c22cf40f8e185f7dfaae29.1649824370.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649824370.git.jhpark1013@gmail.com>
References: <cover.1649824370.git.jhpark1013@gmail.com>
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

Correct a spelling typo from 'Atleast' to 'At least' in comment.
Issue found by checkpatch.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/greybus/arche-apb-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index bbf3ba744fc4..45afa208d004 100644
--- a/drivers/staging/greybus/arche-apb-ctrl.c
+++ b/drivers/staging/greybus/arche-apb-ctrl.c
@@ -445,7 +445,7 @@ static int __maybe_unused arche_apb_ctrl_suspend(struct device *dev)
 static int __maybe_unused arche_apb_ctrl_resume(struct device *dev)
 {
 	/*
-	 * Atleast for ES2 we have to meet the delay requirement between
+	 * At least for ES2 we have to meet the delay requirement between
 	 * unipro switch and AP bridge init, depending on whether bridge is in
 	 * OFF state or standby state.
 	 *
-- 
2.25.1

