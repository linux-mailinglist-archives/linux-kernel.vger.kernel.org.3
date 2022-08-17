Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA08597A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbiHQXMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiHQXMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:12:51 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B5ACA14
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:12:46 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u14so16944775oie.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=LxMzn+ge/kAscik4k/Skya/rcppy5TB3UPJbRHjbmNw=;
        b=ZMSivDnXniEMASu3EBBX5BtUdFu4EVPmkeRJ3ee78RxKEGYOeUwGbBAy6U3fZ7z8sD
         dCkQpMha8IsiWTvB7Rl4yB6DRBQ6FvXLbGCjsi4LpRSmj7P9X6AvKdeSBJDqAOORhyYA
         CDWGHTW+8SbGHp5llGjo8P1prJ0z77XOhbjkE4aqahu+Dszq19ujEa9z/oIzL2p1cgRc
         NtJ49iUae0YiYX+wEIwWAO/lCXUWgeV5VACFMu07v8lTam+5u/fcQhrePmNd4L0CuE5F
         1axW9WWzIcIcD2SUcdUVDp7iMhJY4Nck4VEQqs9gPD9GGTj7aYFdz+2GNjuXXVbtSib8
         zkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=LxMzn+ge/kAscik4k/Skya/rcppy5TB3UPJbRHjbmNw=;
        b=zKQQQ+yfcL9GSnyWOFR6N1hkebfl/WDhEbNmixZh4PT7IwHma0oxROzMN/zC3tE5aP
         o3biNmahmN0TJtg9R8PiDgqA2dH/UIzE/M5TbfuwfLO3jAeByDREIq5OM/PsizMypwyL
         lKk1H37YylpUIIq4KD29jjw6qvy2IE42pBteA8BzTOucUSlWElWZLPx18i949tPMi/En
         cEDg4zrznnEXg8/WpOA273TF7PaIEw8Zp0AeHO/Pr93rBKFw46rzDpWxCwN6CS90xAYj
         E3Jj9Ip3YstQIjO5U8JBaNeUjdy0fvoKniq7BEEsF5Rz09hLZo+t5auzXjDCYKLpCnC6
         Ra5Q==
X-Gm-Message-State: ACgBeo3lPejyGBEuVNCIwzImsTy1IyAPBJqPBlmckiehiUFsi9gJK5Le
        nSC93ItzmmeXtAt/ML5bCFxVdg==
X-Google-Smtp-Source: AA6agR4RjZMSD+HLFmCEXKwPeOCg2lasV4sKuV5KudXbS/qHB1uOaK5nsyrZUGjNTa/U1Egwg+auWA==
X-Received: by 2002:aca:1b13:0:b0:344:d3f5:4df0 with SMTP id b19-20020aca1b13000000b00344d3f54df0mr159322oib.209.1660777965456;
        Wed, 17 Aug 2022 16:12:45 -0700 (PDT)
Received: from localhost (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id t2-20020a9d7f82000000b00637032a39a3sm18537otp.6.2022.08.17.16.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:12:44 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     steev@kali.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: thinkpad-x13s: Fix firmware location
Date:   Wed, 17 Aug 2022 18:12:36 -0500
Message-Id: <20220817231236.3971-1-steev@kali.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware for the Lenovo Thinkpad X13s has been submitted, accepted
and merged upstream, so update to the correct path.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 84dc92dda0b8..e07cc9d1ff27 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -235,13 +235,13 @@ keyboard@68 {
 };
 
 &remoteproc_adsp {
-	firmware-name = "qcom/sc8280xp/qcadsp8280.mbn";
+	firmware-name = "qcom/LENOVO/21BX/qcadsp8280.mbn";
 
 	status = "okay";
 };
 
 &remoteproc_nsp0 {
-	firmware-name = "qcom/sc8280xp/qccdsp8280.mbn";
+	firmware-name = "qcom/LENOVO/21BX/qccdsp8280.mbn";
 
 	status = "okay";
 };
-- 
2.34.1

