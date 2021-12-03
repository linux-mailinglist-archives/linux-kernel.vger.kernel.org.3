Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C035467E40
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382885AbhLCTgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343888AbhLCTgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:36:36 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EAAC061751;
        Fri,  3 Dec 2021 11:33:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u1so7726681wru.13;
        Fri, 03 Dec 2021 11:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KkMqjzOv91kbEWcmfuXNAzPB98rsPnz33Du8jXmQo/4=;
        b=DcmSX6dV1UHFCCY4ITz0D8zPXxmPFsUvlxPe6iW6SIA514KGHV5HhGZj+Eno5vldj2
         7zefU34oP+H57TIKPBUoqNJOruzEoEDTlsxKPkUu5PQj/XhPbpLvqK6Rx6RPHNwvloVW
         O/0ZuqWN5JG0qtzhgjlPD6TVGJbE+0kWVI22BMzPnjno2IVrQ7g0nZCy+iVJJzbr45vp
         pGb8w3izUT+HzEyRBiT7OPBOaeWWzvr4V43d+3YtPMFC5FrLieJFZ1ZISwRyUNjD8ULL
         Jzy+XjE5NPeRlTbLgYCLYz8BqVoxGQgDhjVrQlX99lQbS4WYmZ9yhUsRMZabT/22Koqj
         wOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KkMqjzOv91kbEWcmfuXNAzPB98rsPnz33Du8jXmQo/4=;
        b=67XR64mwLE6TZgiUhWk5YTmCjq7RYjsbgxzMcxjF5kCaqtO8nTN3UW43gIaqCOSkQu
         sX/Piyhuk0qF0Uh/0TTMdP5sCAJ9OnFm4wEB+D/Iz2jWNeQeD2YKCbKLa4WysZnJan5d
         aZMuTV8L3T88/HqoyevfKzYPZHxtOYnK0TdI7yLD6fBYuI2HjsHeZKEZinCVUbfT7+D4
         KcyK2peDOQHw7JWjohx1e1euOHih4SoGWsaYutkvwYpz9WHYHBJCekDo35mAluRw50pH
         8rWeZXt30ngv3fbEwEEgBogP5KIlw7W1OTnfeIdgW5v2SzQiqbAQJHOhDTGPRsCInRFk
         Kqxw==
X-Gm-Message-State: AOAM530QkJ3UR2YWpqoSzhuUHnYsXDE8vRgIW+JyKpYuv1NygbqSFh9B
        o1ZT73Me5K7rjEmxa6LtYVo=
X-Google-Smtp-Source: ABdhPJwHkNocAxLPzcMPDuZ0QZvaPbQ/NHuFjMokG9Q5PoIIqWCWDfe347YQd6kuqYE2q3PRf3CMPg==
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr23415302wrs.581.1638559990224;
        Fri, 03 Dec 2021 11:33:10 -0800 (PST)
Received: from localhost.localdomain ([39.48.194.133])
        by smtp.gmail.com with ESMTPSA id l5sm4815155wrs.59.2021.12.03.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:33:09 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, amhamza.mgc@gmail.com
Subject: [PATCH v2] drm/msm/dpu: removed logically dead code
Date:   Sat,  4 Dec 2021 00:32:53 +0500
Message-Id: <20211203193253.108813-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ffdf9007-d2cc-2437-684c-66c00bb0ceda@linaro.org>
References: <ffdf9007-d2cc-2437-684c-66c00bb0ceda@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coverity warning by removing the dead code

Addresses-Coverity: 1494147 ("Logically dead code")

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>

---
Changes in v2:
removed the 'fail' part completely by moving DPU_ERROR and return statement in place of corresponding goto statements.
---
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c    | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 185379b18572..ddd9d89cd456 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -698,17 +698,17 @@ struct dpu_encoder_phys *dpu_encoder_phys_vid_init(
 {
 	struct dpu_encoder_phys *phys_enc = NULL;
 	struct dpu_encoder_irq *irq;
-	int i, ret = 0;
+	int i;
 
 	if (!p) {
-		ret = -EINVAL;
-		goto fail;
+		DPU_ERROR("failed to create encoder due to invalid parameter\n");
+		return ERR_PTR(-EINVAL);
 	}
 
 	phys_enc = kzalloc(sizeof(*phys_enc), GFP_KERNEL);
 	if (!phys_enc) {
-		ret = -ENOMEM;
-		goto fail;
+		DPU_ERROR("failed to create encoder due to memory allocation error\n");
+		return ERR_PTR(-ENOMEM);
 	}
 
 	phys_enc->hw_mdptop = p->dpu_kms->hw_mdp;
@@ -748,11 +748,4 @@ struct dpu_encoder_phys *dpu_encoder_phys_vid_init(
 	DPU_DEBUG_VIDENC(phys_enc, "created intf idx:%d\n", p->intf_idx);
 
 	return phys_enc;
-
-fail:
-	DPU_ERROR("failed to create encoder\n");
-	if (phys_enc)
-		dpu_encoder_phys_vid_destroy(phys_enc);
-
-	return ERR_PTR(ret);
 }
-- 
2.25.1

