Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0451520CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiEJEdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiEJEbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:31:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA73255099;
        Mon,  9 May 2022 21:27:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d22so15687471plr.9;
        Mon, 09 May 2022 21:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3fqvQ3B2e4Jfl0iz3GRolUCBYJvQ9lqVFwmUIWfWd7Y=;
        b=qnGCBaEYK367xZ1eAYI6+LLPhIq5OrOC6tUVYCrOxpre7uW8ekX+CMakaeuz1UVqyd
         TectHU6QsvpR50yVyYaeKk7h5h+s2aYfdkdTAhnPS9zffRxPDKoQvN1rU7dklJfWxova
         I/ldPFfE3b5gbTvzZay7FyWJK7W6z3a12SFhfLxGuv5t2zDWt2n5y0yuarCbp11MRLXW
         QTK5rYxv2fBJ34tOkoHjFt/bNPyutuujD8NF1u2lg47j+JGmaARATx+4p7tdnRV0KA9t
         uJeL4CwyP0Ima0AKFjSA0dswRk38mJ6Ncq+D7Mzf5K8jRow7L08wS/OJjXUE2E0XX1TO
         hlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fqvQ3B2e4Jfl0iz3GRolUCBYJvQ9lqVFwmUIWfWd7Y=;
        b=Lq9d6Tr9VbXwpFWtBsUYnCHVNPWpDgjMoXDR8Ckf8mkpzSpfCMak4P76gQmtbBmRri
         UW+HkJEQJTyKZrKoWbWiBsLOfFVIECWRjgRfwJFIW9YMHFRVyKTvOr95xGfGQJJN1yOh
         7+0EbIsIi9g9KfjqFMlB3w6ew6LUeQA/m2kWMAhdSPXJUI6Pmca2bw97lGlbXry+o0Nu
         +vVDQdMfPk37AUOybLS59vc/UavXuOBAN6ESnjO7ntUGsj54iJ+jj7MhTliTGWbK9Awu
         Fl1oUAEPaYyBT5xMm5Il4qP5sGaLP1I80bkKcXFQXncipHigK9YSolp77yQlQzHUyHoh
         ovaA==
X-Gm-Message-State: AOAM533Zblv+JBRdgdiPVn7TgbWy8sFTHgMSIw8ijUk8nwWLpLSULRGQ
        BzQG6XMYl4ePuiy064zZHlLfplv5Z4nUgg==
X-Google-Smtp-Source: ABdhPJxIie1pCr/tmPsDQ9H3w67WWAhPJGg0hqYxGcy/AwcuMSO/PgjddGDmJ3g5glskXx3C8Rgv7g==
X-Received: by 2002:a17:902:bf0a:b0:15c:df1b:f37d with SMTP id bi10-20020a170902bf0a00b0015cdf1bf37dmr18665939plb.90.1652156854032;
        Mon, 09 May 2022 21:27:34 -0700 (PDT)
Received: from skynet-linux.local ([2401:4900:33a2:808d:da42:4e61:10ad:478d])
        by smtp.googlemail.com with ESMTPSA id x4-20020a1709028ec400b0015e8d4eb2aesm741263plo.248.2022.05.09.21.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 21:27:33 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     bjorn.andersson@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] arm64: dts: qcom: msm8916: Fix typo in pronto remoteproc node
Date:   Tue, 10 May 2022 09:56:54 +0530
Message-Id: <20220510042654.71152-3-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510042654.71152-1-sireeshkodali1@gmail.com>
References: <20220510042654.71152-1-sireeshkodali1@gmail.com>
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

The smem-state properties for the pronto node were incorrectly labelled,
reading `qcom,state*` rather than `qcom,smem-state*`. Fix that, allowing
the stop state to be used.

Fixes: 88106096cbf8 ("ARM: dts: msm8916: Add and enable wcnss node")

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e34963505e07..7ecd747dc624 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1758,8 +1758,8 @@ pronto: remoteproc@a21b000 {
 					<&rpmpd MSM8916_VDDMX>;
 			power-domain-names = "cx", "mx";
 
-			qcom,state = <&wcnss_smp2p_out 0>;
-			qcom,state-names = "stop";
+			qcom,smem-states = <&wcnss_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&wcnss_pin_a>;
-- 
2.36.0

