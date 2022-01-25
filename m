Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34C49B048
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455864AbiAYJb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573004AbiAYJSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:18:36 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7419EC061401;
        Tue, 25 Jan 2022 01:14:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so1285648wms.3;
        Tue, 25 Jan 2022 01:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRD6qyOpLvPcbfxyrO55uccAQnyiA9egM9CuSrcd7Oc=;
        b=pxDtXbN4xMP3UQSMn75sFL/SaeutiFSKz3kyKW6caQJyCeyRxcWrn7GX9HpWclAX7Z
         dOIbygVko6RUJ/wt6z/a095spH8ZQrmCIPD7+FxqN+rexXZo86O9CQyYthLZ4/37WKN3
         RIEOsH+MByBUUHXUyyl+eVy7OlEWbgjzuOs6QI7e0OXOlacH5EaTneJZHG0gNex2UHOt
         sUaTXry+PvodKcsJNnvv6exMgY6eos/9VZOhdIMFMf2UTnH+coNJ8RoHHjKxCqC886p2
         uy8HF9SmsVkV70U6Vvd81B6fE8yREd+3EaFq6CirH1obIK0hImClV0TNBLZqGnugmzdk
         7b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRD6qyOpLvPcbfxyrO55uccAQnyiA9egM9CuSrcd7Oc=;
        b=JvxoIiIheczynPHFlHGx2hyComFCMJpfK1IQNTcTxCwfDvitVMe4CjimEjJ+X4Ht35
         dCTNO//CMhL6Y3fXyXeFYCr+k6pz/2rfyt9pwCWVxFbwm1nDxWT4rD0PP6FxgNzORoUS
         SZ8H5uay6yii6uE5RKanXw7FSpQBCA0ItNP2OzDpBRziGxXrnZm9rObv7PhNNpL1lHq0
         T/E9jwkfHUKW8z4HTz28F5ILjb57eSII8MPUJxEwOYDGkt1VXZsGUp9J+3jYR2M+mV3X
         tRBioCHpQ/2i3OwfE72ITmfWiNjPrV1OsFVqkSDNnLQF2g10dgtYNMj983dYUMKKxyMS
         bZ6A==
X-Gm-Message-State: AOAM531NEbna1KYqxTOnsMcHnOr+QQmlZHc8GvffVcjGWIMpOn5fV4Cq
        x/kVc0rtBSodvoNcg6Pf7Js=
X-Google-Smtp-Source: ABdhPJxzyKb03iquT0LFx2oqC90sGv/+nQr+qE2QH5pD8+5O0GEBKjf4WlPRN0eo54vLAvnnDr0wuA==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr2038528wmk.125.1643102040934;
        Tue, 25 Jan 2022 01:14:00 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l4sm3859839wrs.6.2022.01.25.01.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 01:14:00 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        John Harrison <John.C.Harrison@Intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/guc: fix spelling mistake "notificaion" -> "notification"
Date:   Tue, 25 Jan 2022 09:13:59 +0000
Message-Id: <20220125091359.350918-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a drm_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 1331ff91c5b0..1ae3d1f259e3 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -3942,7 +3942,7 @@ static void guc_handle_context_reset(struct intel_guc *guc,
 		guc_context_replay(ce);
 	} else {
 		drm_err(&guc_to_gt(guc)->i915->drm,
-			"Invalid GuC engine reset notificaion for 0x%04X on %s: banned = %d, blocked = %d",
+			"Invalid GuC engine reset notification for 0x%04X on %s: banned = %d, blocked = %d",
 			ce->guc_id.id, ce->engine->name, intel_context_is_banned(ce),
 			context_blocked(ce));
 	}
-- 
2.33.1

