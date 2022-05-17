Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208AE52AC05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiEQTdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352778AbiEQTdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:33:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0063F522CE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:33:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q4so18203300plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5mBbynL6gMveM8Z9JZinN28MMyvflON2/SNJvg83S1s=;
        b=evYKYoCnXM9GXViETG+uO9hzdeRJhj6wULFI5sSjWoDfXEk81+FkXZo9Zjb8KPTa/5
         pVMH4x8AgnoHuwUaNVut5zlX3DziAjVlRk8QokH9Nyhnd0ajtyuCIrLu1/VIK189jkv9
         X05W1a+4DmY0kMrhfz9GdzzyhTWskoutn5jFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5mBbynL6gMveM8Z9JZinN28MMyvflON2/SNJvg83S1s=;
        b=MzV1Ldlvs4/j0YFUr4pvzAlE/XM/tLIn92QTi1JcV6M+OSmkTjqH88WbU+ZI3uxxv8
         SGg7bvlQIWHHH82KAbhCxbubUKKehfg3/zKJaagvtjq+iLTi7+XOr2ZnpT+F+4ELyXaG
         pVEM096dypaNO62vn5DElmk8fQQCGBGSCVyTtDaFwdwbPzvP+6kB+wk5u8HnabIp6fRA
         GH4l0MLZS1nXIY4Fnm2katVIkkmNim67pUPKXKlYx9m3n0nYu/Y9NzqV/ffuTZipxnqy
         0sN+2ZduPSZZ4Wn+9WvHb/V0JOVs/NpNuSH4FSlepzgXjn549U8EFfOigP92QRLYiGmC
         IiLQ==
X-Gm-Message-State: AOAM533r9JwGT+Lz5bLaLK6+c5IleYlRtLYFisOaOwgN4t5/ESi1Oyxw
        iHa2NT0Zlwt0yeFd7GUBddcQ7Q==
X-Google-Smtp-Source: ABdhPJz+InTpwao5BILrfEs/xt20Ptzv3WuyXYsmjCrmujsuTd5RN/o+uzVFXDnJXEfLPqpaRb7P2w==
X-Received: by 2002:a17:902:b70c:b0:156:16f0:cbfe with SMTP id d12-20020a170902b70c00b0015616f0cbfemr23730222pls.152.1652815988531;
        Tue, 17 May 2022 12:33:08 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:be81:6c26:5643:b3d9])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902714800b0015e8d4eb281sm7680858plm.203.2022.05.17.12.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 12:33:08 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7180: Remove ipa_fw_mem node on trogdor
Date:   Tue, 17 May 2022 12:33:07 -0700
Message-Id: <20220517193307.3034602-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't use this carveout on trogdor boards, and having it defined in
the sc7180 SoC file causes an overlap message to be printed at boot.

 OF: reserved mem: OVERLAP DETECTED!
 memory@86000000 (0x0000000086000000--0x000000008ec00000) overlaps with memory@8b700000 (0x000000008b700000--0x000000008b710000)

Delete the node in the trogdor dtsi file to fix the overlap problem and
remove the error message.

Cc: Alex Elder <elder@linaro.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Fixes: 310b266655a3 ("arm64: dts: qcom: sc7180: define ipa_fw_mem node")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 732e1181af48..262224504921 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -42,6 +42,7 @@ charger-crit {
  */
 
 /delete-node/ &hyp_mem;
+/delete-node/ &ipa_fw_mem;
 /delete-node/ &xbl_mem;
 /delete-node/ &aop_mem;
 /delete-node/ &sec_apps_mem;

base-commit: 42226c989789d8da4af1de0c31070c96726d990c
-- 
https://chromeos.dev

