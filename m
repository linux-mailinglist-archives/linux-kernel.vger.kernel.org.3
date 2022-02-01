Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEDD4A53DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiBAALK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiBAALI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:11:08 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3637BC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:11:08 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x11so13963545plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATL74pFESfBpBVkQXmsV4M2B6h+NphNUg0/LX0n/suU=;
        b=h3DcTNAWfgElvVoq8kYYU5k4CozfcdTudPNkViRPOW6T/plEnptuS9DhnNp9hD3+26
         /ubmJjU5uwzh+WhRIw0vAfFbbI9rnjJzmPMoguc2P6PRjFJHmaCIXtnbzAULIJknQRoh
         lUk0gnvImCcdWp26S3tOuuCQZ3IEfcBQ7ARkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATL74pFESfBpBVkQXmsV4M2B6h+NphNUg0/LX0n/suU=;
        b=OMXhooMRqFjLZD/OA9CrFM5OXB+adNH1Y9c3WrzdpGwbu/u+yeOF/5ZdgsLBtMn0Yt
         MQYLmZO6C72RE1U6kEmay1rsSFr0XqCbgKN2VN9N0HUN9wXQzURkp97TuDRKQHm0Uxn5
         BcuvYlbJl2L0ii8S1OvtmkYvjjgXLp8XC/5p8n/tXzxgmMpWwvikSJCzqPYt6vEJBP1m
         Fjxpg1ckwK2b0DXP+51+GQ05f4Ne/y7ClbKlCyGUwlUyXgRAtXMVW07ldzhz2k0Z2yRw
         jPYQl5VRrJixENyUiygM9xbOey+nRsEeotCHMFeevf8SU+yi3y9xj4xVaWmCeSzGh2l9
         3bgA==
X-Gm-Message-State: AOAM530dXKP6urUKAsc/Mi/oIQyH+e7ecTXdhsPYxE+NBem+A/xjXqef
        5WBRxH7MW0CZPZxQA7ka9G/oxQ==
X-Google-Smtp-Source: ABdhPJzhky1qBnKtaQyj3xSaMT0/Zj9SsDM2eX3bv60kHevdwHpSMajshCbIocivJ9mxXf2PiajP/Q==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14mr9962675pls.121.1643674267763;
        Mon, 31 Jan 2022 16:11:07 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:c47e:986d:769b:ead2])
        by smtp.gmail.com with ESMTPSA id oj5sm424024pjb.53.2022.01.31.16.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:11:07 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>, mka@chromium.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: qcom: sc7280-herobrine: Consistently add "-regulator" suffix
Date:   Mon, 31 Jan 2022 16:10:39 -0800
Message-Id: <20220131161034.2.I627e60c5488d54a45fd1482ca19f0f6e45192db2@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220201001042.3724523-1-dianders@chromium.org>
References: <20220201001042.3724523-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the fixed regulators were missing the "-regulator" suffix. Add
it to be consistent within the file and consistent with the fixed
regulators in sc7180-trogdor.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts  | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
index ad4fe288b53c..f159b5a6d7ef 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
@@ -177,7 +177,7 @@ pp3300_tp: pp3300-tp-regulator {
 		vin-supply = <&pp3300_z1>;
 	};
 
-	pp2850_uf_cam: pp2850-uf-cam {
+	pp2850_uf_cam: pp2850-uf-cam-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "pp2850_uf_cam";
 
@@ -192,7 +192,7 @@ pp2850_uf_cam: pp2850-uf-cam {
 		vin-supply = <&pp3300_cam>;
 	};
 
-	pp2850_vcm_wf_cam: pp2850-vcm-wf-cam {
+	pp2850_vcm_wf_cam: pp2850-vcm-wf-cam-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "pp2850_vcm_wf_cam";
 
@@ -207,7 +207,7 @@ pp2850_vcm_wf_cam: pp2850-vcm-wf-cam {
 		vin-supply = <&pp3300_cam>;
 	};
 
-	pp2850_wf_cam: pp2850-wf-cam {
+	pp2850_wf_cam: pp2850-wf-cam-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "pp2850_wf_cam";
 
@@ -251,7 +251,7 @@ pp1800_fp: pp1800-fp-regulator {
 		status = "disabled";
 	};
 
-	pp1800_uf_cam: pp1800-uf-cam {
+	pp1800_uf_cam: pp1800-uf-cam-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1800_uf_cam";
 
@@ -271,7 +271,7 @@ pp1800_uf_cam: pp1800-uf-cam {
 		vin-supply = <&pp1800_l19b>;
 	};
 
-	pp1800_wf_cam: pp1800-wf-cam {
+	pp1800_wf_cam: pp1800-wf-cam-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1800_wf_cam";
 
@@ -291,7 +291,7 @@ pp1800_wf_cam: pp1800-wf-cam {
 		vin-supply = <&pp1800_l19b>;
 	};
 
-	pp1200_wf_cam: pp1200-wf-cam {
+	pp1200_wf_cam: pp1200-wf-cam-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1200_wf_cam";
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

