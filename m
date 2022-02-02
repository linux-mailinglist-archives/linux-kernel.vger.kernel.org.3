Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D974A7A56
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347523AbiBBVZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347680AbiBBVYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:24:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A9BC061401
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:24:26 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i17so384952pfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QSQlZvmcfCUBtm2+1cc0/YI7EprizXuuLYmIUMgnJ1M=;
        b=aIwkVjBccvew/dDC0tK8r+6HvM9pbDPy/F/NTIwKQJAj5sMk4Gc71ec4/KSRn/Nznw
         g3QkUWrXL8l//0rXWVbGFu8idgrevedB4BZ87PnimGoJCFNuJwVXEGCBtJ8QKEhIc26q
         wP3xGCxgBwYEUIAUU6jvYmcS6WVY7KcroNQlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QSQlZvmcfCUBtm2+1cc0/YI7EprizXuuLYmIUMgnJ1M=;
        b=SH1YnFDN2voEdxkgXorP19WXkwQ1iph/150bU29m3hfCoEK58V8jfg9wujrLmFS+Iu
         5TUT5W2YWJpL36CL9qhnhKLZfwpEb2o1/eAGu6L/o7Ay09ZIT13/I016U4PZrDDl3T1K
         IEtCejJ1QndDj4Pa99QPzq12vdWeFMjwfyffQ5BIIc3jOMsFqs/CXrVsCZuW8+a70ujq
         3Ilr2Ns7Ila3QQGBPz6HakV8eTAYd/ouCsZoihRDkU+jQF7889S8gYC6FoIj47uLfeO1
         eD2nIVaMGBeYVeqgBn9gV5yjUbai749JDpU2e5msfZvCfelzAcoDgym91TcI7qCCBFpt
         Cftw==
X-Gm-Message-State: AOAM532ypKnjyr3Fc+OoEJ4sNDzko9D0xtd0wWxalJmqdnkAXQdgiNXF
        Fb7O0Gc5kr3cGpEofMETB1Rqpg==
X-Google-Smtp-Source: ABdhPJxOSvm1ORQ5ZJ7OP5XJCoTg2tk65Q/XaLvG6ggqU47X2hPk6pzL+R3Xrc7ROOeCOlcT33ITaw==
X-Received: by 2002:a63:85c3:: with SMTP id u186mr25500220pgd.199.1643837066067;
        Wed, 02 Feb 2022 13:24:26 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f1c4:10b6:b4ef:16e5])
        by smtp.gmail.com with ESMTPSA id on9sm7627983pjb.16.2022.02.02.13.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:24:25 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     pmaliset@codeaurora.org, mka@chromium.org,
        quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/14] arm64: dts: qcom: sc7280: Add a blank line in the dp node
Date:   Wed,  2 Feb 2022 13:23:45 -0800
Message-Id: <20220202132301.v3.11.Iecb7267402e697a5cfef4cd517116ea5b308ac9e@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202212348.1391534-1-dianders@chromium.org>
References: <20220202212348.1391534-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's weird that there's a blank line between the two port nodes but
not between the attributes and the first port node. Add an extra blank
line to make it look right.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("Add a blank line in the dp node") new for v3.

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 1776523e169a..618ae0407cd6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3147,6 +3147,7 @@ mdss_dp: displayport-controller@ae90000 {
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
+
 					port@0 {
 						reg = <0>;
 						dp_in: endpoint {
-- 
2.35.0.rc2.247.g8bbb082509-goog

