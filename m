Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7935684F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiGFKMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiGFKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:11:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D082BAE5D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:11:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l68so8530559wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJUbjFqLiGSB5OjmspqHgctiZDrpEvVdOgFv+mnyDrY=;
        b=WUiC/qR++dreygxO/e5FRN1CcpN48p4tSY0P3vPUGsauO1pAEx6jDr0A8eokLWrG1W
         jrIrpAPVAHsTWn91clYJVshV+gNDkkrhrGn0Z1b6vpXKxOlGxZq2ML9xnNhzCvIdCuNc
         V3ETf2fDEu7KQkLdm+ebJMkZ5vOnCU/xe+B0XIhV8YUca7Owof4BnKBAT7zlgJAEIFBz
         C/I11L6HdARba0CqmTYnIZ/YHrL1lKlq3Citidw6ZNl5iGzxlzE4HVJTLetmUKvEzhQG
         cRRGLGa+KGymeV+f6ge5TwpvrouuCipDxd7DRplqE0mL0jzMrWt9NUe/JKZ2GtHBMo1F
         bjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJUbjFqLiGSB5OjmspqHgctiZDrpEvVdOgFv+mnyDrY=;
        b=wd8v1PTY6pz4iUXx6HZdIuSdAV0qUepvhazABKYqJdBdDgDnoTr26REvSp44lb+rAF
         m0SiDTIktGG12o4dm9XRzYnvftgNqQj2W3pQLCUtlb/BvI+M02BuymH7t948qDZCJgXg
         eftjFXePh0i/WqVgrcCl5AfKw06UscagWZwCSkMYAiUI2irk1/BvcMnG/XdgcBpd6v3b
         DA0Zc6+tjPl/8PaFP2/ZPLGftPK3Vy9DBWZvLuON/Eub//0H4we7MBCxlCSOnmRY6kjt
         fNBXY/2ut6uYZYNQlZyk9KJri6qZiMbeXCjxqDmkuR9wH4HgNGGJYQK/64/69VNAx49a
         9Djg==
X-Gm-Message-State: AJIora8ydMAUc3eFp9tQ7u6px4T+a/DqwLB9VxgkRj8iAfvzPLd2C/x4
        oQlb8Va2otE9fVqxpduJ9vYFwLpwZqsseo8t
X-Google-Smtp-Source: AGRyM1tnZ48LVi0raQWKxaPw6jvbXxt/O0eYPo3FcUYIjSpzVDVCDnIfbvP6vdCRtw0FpKZG9xRqfA==
X-Received: by 2002:a05:600c:3399:b0:3a1:967a:78af with SMTP id o25-20020a05600c339900b003a1967a78afmr23429233wmp.29.1657102316406;
        Wed, 06 Jul 2022 03:11:56 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm24826620wmj.35.2022.07.06.03.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:11:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] slimbus: messaging: fix typos in comments
Date:   Wed,  6 Jul 2022 11:11:31 +0100
Message-Id: <20220706101131.6934-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706101131.6934-1-srinivas.kandagatla@linaro.org>
References: <20220706101131.6934-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@inria.fr>

Spelling mistakes (triple letters) in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index e5ae26227bdb..4ce0cb61e481 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -79,7 +79,7 @@ int slim_alloc_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 EXPORT_SYMBOL_GPL(slim_alloc_txn_tid);
 
 /**
- * slim_free_txn_tid() - Freee tid of txn
+ * slim_free_txn_tid() - Free tid of txn
  *
  * @ctrl: Controller handle
  * @txn: transaction whose tid should be freed
@@ -101,7 +101,7 @@ EXPORT_SYMBOL_GPL(slim_free_txn_tid);
  * @txn: Transaction to be sent over SLIMbus
  *
  * Called by controller to transmit messaging transactions not dealing with
- * Interface/Value elements. (e.g. transmittting a message to assign logical
+ * Interface/Value elements. (e.g. transmitting a message to assign logical
  * address to a slave device
  *
  * Return: -ETIMEDOUT: If transmission of this message timed out
-- 
2.25.1

