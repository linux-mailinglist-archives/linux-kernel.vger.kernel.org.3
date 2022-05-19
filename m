Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B353152CD2B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiESHeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiESHeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:34:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8CA939DC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:34:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e4so4654842ljb.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ld3tNTOnejY2gRdAkG0gU54wZRhtwNMujkvL4qvMwkI=;
        b=uVhNzYLoSIE1Q9t8tJmJL12I3Cm4x9BG9luOeDhB9VLhFK3mkwvFc/z3CCe11suOux
         Wb0u8LQNWoPbikl+QQONfDCMn+bgq0BmOUOnVR913Wxgo2uHIbvbr+KJ5SvvMXlJYECH
         63eCCRaz9p1pkEqEGE7LuT9op0BVY5/5A6kXtFz9qVwMM0x+i4Msz/avddlxOKmbHPNW
         7Q7WIbHY6F3EsYL3KaBriWyFmHL3t9XEfHC+m8cpHgPvB6PV0q28i1gJYaQ5pCvFLwiB
         NPxC+pWdqHVlJoAvxwV8eG2TreRRIV8bIOgEf3sOo0Zk5yEsZZkXgBN7B+sPvShPpWXO
         lMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ld3tNTOnejY2gRdAkG0gU54wZRhtwNMujkvL4qvMwkI=;
        b=SWxP/x7hRfHwN+OPbLTxVheQP79u2a9q2rQjcdB462zwV93iZO6y0Y36IsunMPn/Gy
         8dB+dQPT5UPzt5yYf80ndEEelqfUxdUtZnp1bmUj6VrcVuYz5wFarsYwp1IXGaL4x4cF
         JUl8zwIKIBHWPLbYC2wpRTnQ33v1rZ/LuV2b59mbfXPsJZZLEuZmUIvp0XJ2vbmvQuW6
         dUdTf2V7nUVcGEgwGpxHOeViTOgv62ZA+KnwRJZtntXfBoepTwxDlI6FgN1CKrVP2V4g
         DPkfowGPMzbRTAgLmhj6jVCffcALNqUzqoPbbsZjecm0biA4glt39xZtfKqDCJsjbZiK
         o1JA==
X-Gm-Message-State: AOAM532Tqqb1b8PASCh+7ltBzwzkpsQcarAP88YTlVvS2CE1qbs0e4dr
        OIxSK8AuzHSh4XLds4iqIojkLQ==
X-Google-Smtp-Source: ABdhPJy5Ys+LYqZCN8u/Dc32BrKJ8PhvyCAatBFQj27NKp+j/2marUinA+vOpac2dpQockG3zQaMaQ==
X-Received: by 2002:a05:651c:399:b0:24f:18d:5bbd with SMTP id e25-20020a05651c039900b0024f018d5bbdmr1824315ljp.481.1652945653930;
        Thu, 19 May 2022 00:34:13 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w8-20020ac24428000000b0047255d2113csm187708lfl.107.2022.05.19.00.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:34:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] firmware: qcom_scm-legacy: correct kerneldoc
Date:   Thu, 19 May 2022 09:34:10 +0200
Message-Id: <20220519073410.7358-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct kerneldoc warnings like:

  drivers/firmware/qcom_scm-legacy.c:133:
    warning: Function parameter or member 'dev' not described in 'scm_legacy_call'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Split series per subsystem.
2. Correct argument description (Stephen).
---
 drivers/firmware/qcom_scm-legacy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/qcom_scm-legacy.c b/drivers/firmware/qcom_scm-legacy.c
index 1829ba220576..9f918b9e6f8f 100644
--- a/drivers/firmware/qcom_scm-legacy.c
+++ b/drivers/firmware/qcom_scm-legacy.c
@@ -120,6 +120,9 @@ static void __scm_legacy_do(const struct arm_smccc_args *smc,
 /**
  * scm_legacy_call() - Sends a command to the SCM and waits for the command to
  * finish processing.
+ * @dev:	device
+ * @desc:	descriptor structure containing arguments and return values
+ * @res:        results from SMC call
  *
  * A note on cache maintenance:
  * Note that any buffers that are expected to be accessed by the secure world
@@ -211,6 +214,7 @@ int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 /**
  * scm_legacy_call_atomic() - Send an atomic SCM command with up to 5 arguments
  * and 3 return values
+ * @unused: device, legacy argument, not used, can be NULL
  * @desc: SCM call descriptor containing arguments
  * @res:  SCM call return values
  *
-- 
2.32.0

