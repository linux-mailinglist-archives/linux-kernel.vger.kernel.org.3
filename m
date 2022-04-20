Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008FE508B94
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380027AbiDTPKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380004AbiDTPKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:10:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909DF3B546
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:07:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i27so4133595ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CYSvm5V1sdHDF+1DOOdhxzb/TbaE3N1T5V45Q/q3iU=;
        b=iV+BX8J6eiPQ0Gr87b0pPAjxgYpB4lc6lLb3KhBPZ1hggG7okxyTKJaLZBI7/zntK0
         tHCsOyJsKdx1AI17e26HVTluagsC5VMmoWCTohidXYxfQin6AG8pWnvjsAHGsW6IMNUy
         uPVed7xYqc8l9Hewe0bsM63jkv2AHvlJ9rSIM2wXTJNJJ4DOdSq4wE3jb6uEi9AYgmo9
         rLgdkkRKBhYePnJsuJ8UREeGpBJyQxJS4ZJ9IefoKFhQMHZUSEWoGhAPXpTzO0/bwEgV
         J3bEjD74nJ3thpCRrLthBqZng1I94ukmrWIi9lC9GqHvMZOijlazQTjloqHVB8eiR+P2
         FC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CYSvm5V1sdHDF+1DOOdhxzb/TbaE3N1T5V45Q/q3iU=;
        b=5t9+bKo6uCu80jaBG5t7EGe/LV29AR+UZsSe7yAseNudVlWwb9259ZLb3a1U27Lj5S
         CT8MnKFU1PM1A0KgYSWQB8ENKYlDzqll3LiiPzPweIGTAHR1d1edg4+ebPzKQK/U8rJI
         G5mJQI15JlCdf7Ul5Hkiwf1H2uWBr9NPOha3Og6iLXnUv9kDJZpqDnXIxjLRkHc6eu8z
         tjAWHmu5Le3Qfe8l1o/WYI79m+dAGWheRXZhrdl0GeOoN8iJzvwpHSPrElWB5qs6+QCO
         UA73KmGanqu0FWY1wJE+WjqVyrX2kk+fTbrLQ/Ywap7l+t1qSKDvDODhKwOjs1czof55
         3SgA==
X-Gm-Message-State: AOAM532FfcR/6Hb1cORv0Fo1jLmUt3g7R9c4pPvwsk4rmvZHxUTFUbd9
        a5uRdGBY0i3fvz+yk6Y2+g8eMA==
X-Google-Smtp-Source: ABdhPJzOsn82ao1iPnKZtrbVAqHHfpL0MGaWxzcxfFTPHm+ghb7aB2icWW2mAmJo8Uw0uka/xUUGZQ==
X-Received: by 2002:a17:906:948d:b0:6e8:bf62:baee with SMTP id t13-20020a170906948d00b006e8bf62baeemr18751790ejx.456.1650467241156;
        Wed, 20 Apr 2022 08:07:21 -0700 (PDT)
Received: from localhost.localdomain (hst-208-209.medicom.bg. [84.238.208.209])
        by smtp.gmail.com with ESMTPSA id zk19-20020a17090733d300b006f00e918483sm415262ejb.84.2022.04.20.08.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:07:20 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     linux-arm-msm@vger.kernel.org, ezequiel@collabora.com,
        stanimir.varbanov@linaro.org, quic_vgarodia@quicinc.com,
        quic_majja@quicinc.com, quic_jdas@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v6 2/2] venus: venc: Add support for intra-refresh type
Date:   Wed, 20 Apr 2022 18:07:04 +0300
Message-Id: <20220420150704.144000-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420150704.144000-1-stanimir.varbanov@linaro.org>
References: <20220420150704.144000-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

Add support for intra-refresh type v4l2 control.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h       | 1 +
 drivers/media/platform/qcom/venus/venc.c       | 6 +++++-
 drivers/media/platform/qcom/venus/venc_ctrls.c | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index c3023340d95c..d33825553edc 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -261,6 +261,7 @@ struct venc_controls {
 
 	u32 header_mode;
 	bool aud_enable;
+	u32 intra_refresh_type;
 	u32 intra_refresh_period;
 
 	struct {
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index adea4c3b8c20..86918aea1d24 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -893,8 +893,12 @@ static int venc_set_properties(struct venus_inst *inst)
 				mbs++;
 			mbs /= ctr->intra_refresh_period;
 
-			intra_refresh.mode = HFI_INTRA_REFRESH_RANDOM;
 			intra_refresh.cir_mbs = mbs;
+			if (ctr->intra_refresh_type ==
+			    V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC)
+				intra_refresh.mode = HFI_INTRA_REFRESH_CYCLIC;
+			else
+				intra_refresh.mode = HFI_INTRA_REFRESH_RANDOM;
 		}
 
 		ptype = HFI_PROPERTY_PARAM_VENC_INTRA_REFRESH;
diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index ea5805e71c14..ed44e5800759 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -316,6 +316,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:
 		ctr->mastering = *ctrl->p_new.p_hdr10_mastering;
 		break;
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:
+		ctr->intra_refresh_type = ctrl->val;
+		break;
 	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:
 		ctr->intra_refresh_period = ctrl->val;
 		break;
@@ -582,6 +585,11 @@ int venc_ctrl_init(struct venus_inst *inst)
 				   V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY,
 				   v4l2_ctrl_ptr_create(NULL));
 
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE,
+			       V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC,
+			       0, V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM);
+
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,
 			  ((4096 * 2304) >> 8), 1, 0);
-- 
2.25.1

