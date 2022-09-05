Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0975ACBB9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiIEHCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiIEHCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:02:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA30225EA1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:02:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t3so2601008ply.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=juny/qDxxbHj10tAvOIcrujtgWXLCZ306cupBH57+sM=;
        b=bqN8i55+/L2zQF8KoE/BmRlSaKSDrBoTmBpws52H6HyNikxZZBsK7XkxkevBumpqt9
         qC2GqDOIQ93gQ3kTZMEHAEVJToQ1oxn4PxUz+/v+WVlxeGuGgg7/QBzC60JjHmGLxOHe
         NqytJ4fDcyQQqw9cTA0z6RB2lhAdB7MNKnVkGyOUuNE2wlPC6QdNTMPV3qOHGwwJqPQ9
         yEqytibVS+oEXXzatoguJ0siiqWxyTnj//eLJzK9nMbm3CyJIqxnlqNs/kyeaLF26GYK
         Fom9UsHl6mnb8JatiIPVtB1wY6e6lfo4sn04KfEWq6ZRUQqWNUj77WoEzx5LOPtUQAia
         seyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=juny/qDxxbHj10tAvOIcrujtgWXLCZ306cupBH57+sM=;
        b=V7gD67RqQVojw/Yn6Zo+sZu6zzR4mN7kmONqCQE8PCALKmRMSEtKCUqKHjxHjOcaQL
         MyFU62zKCjN3Wbe286ZZ4JJX9tc+1TXCqO2jAZVEYOwjUraUMnw4cm8J0UZ5bea3iED/
         qQtoLpaNjn5+sVzq5+e3UZUW9zTlxkOalwpqTYDyNS6Ao11+kDBAEg3TSRO41qai6QdW
         KAA+epkFDtoi5FYyQqtH3ZIBILCN5OsMEK/W1m/in4G01gyYp0jnr3Ex5Twt9OinM85h
         VONayVI2ljSeBwKRR464rXWlpPQKOT1o+aZgFtCyhtEphRXJbu8HQCbdB6xcnU0XuU3R
         DOjQ==
X-Gm-Message-State: ACgBeo3PpCKKKkW8m6vYHukDShY3aLYthhKa1D5aDHRtk+UG/6DVvSJB
        NR8YJRRMZR8un7yK+j59kXte+w==
X-Google-Smtp-Source: AA6agR6/Cw79qS0TTy2V0ep3kJodE9Vq+8pkdci/M9n4QtZ2WVFWqpzGFA3WTgLHdtQMUXSPvQlPZA==
X-Received: by 2002:a17:902:788f:b0:170:8b18:8812 with SMTP id q15-20020a170902788f00b001708b188812mr47050902pll.1.1662361371102;
        Mon, 05 Sep 2022 00:02:51 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id lw12-20020a17090b180c00b001fe0ed3cb2asm28673858pjb.3.2022.09.05.00.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 00:02:50 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, agross@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v2] arm64: dts: qcom: sc8280xp-pmics: Remove reg entry & use correct node name for pmc8280c_lpg node
Date:   Mon,  5 Sep 2022 12:32:40 +0530
Message-Id: <20220905070240.1634997-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
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

Commit eeca7d46217c ("arm64: dts: qcom: pm8350c: Drop PWM reg declaration")
dropped PWM reg declaration for pm8350c pwm(s), but there is a leftover
'reg' entry inside the lpg/pwm node in sc8280xp dts file. Remove the same.

While at it, also remove the unused unit address in the node
label.

Also, since dt-bindings expect LPG/PWM node name to be "pwm",
use correct node name as well, to fix the following
error reported by 'make dtbs_check':

  'lpg' does not match any of the regexes

Fixes: eeca7d46217c ("arm64: dts: qcom: pm8350c: Drop PWM reg declaration")
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
- v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220903084440.1509562-1-bhupesh.sharma@linaro.org/
- Fixed the review comments shared by Krzysztof.


 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index ae90b97aecb8..24836b6b9bbc 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -60,9 +60,8 @@ pmc8280c_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 
-		pmc8280c_lpg: lpg@e800 {
+		pmc8280c_lpg: pwm {
 			compatible = "qcom,pm8350c-pwm";
-			reg = <0xe800>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.37.1

