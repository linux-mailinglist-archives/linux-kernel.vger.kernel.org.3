Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D76521DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbiEJPMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345339AbiEJPLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:11:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D169B4C;
        Tue, 10 May 2022 07:45:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c12so12834095edv.10;
        Tue, 10 May 2022 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cviL3lmIYw/HkQPfXBpg2Ad3NY9GzMPeGBFFoRKwMlQ=;
        b=Xp5x5HjouRwxA3WTb4Y4k5B5FFuVFgUZnJBvYRFhNYagsTxkvVst4HILGHD5EYLNzH
         kmkUvGprkk4d/vz38/+ckDGtnR5jpmkeYY42sTynRyBk/mWbh1ETbuPA6S+f2yQXb+Cu
         qeONylgSs0tQgA/RKli/cxjAeeqBpX1zvZzYTct39albJuDK0e38A4H22p7er6kCuEMc
         Wr5/20TGbEf9A+koioveWlZXOd6TFnzPTqibQV7AsAHAJeY7aWxYEHC6NSlgqbgY2U/l
         0FoGPbd2fNxO/+IMfa1nPSDShsxhzT5n2vMmBTE3bm5G702g7U5d11Y3fc87/l6jJIMk
         9WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cviL3lmIYw/HkQPfXBpg2Ad3NY9GzMPeGBFFoRKwMlQ=;
        b=Bx+c3DBaZiv7QXoYoieP0oTGJrNhBygOKyX3/JI0lWdodsQO0Fu2CjUsCUJvXI7Xq0
         S3Mf0Ia9/ufYJ1Bj5IkZJn0sFxVEYne96N15l626nj6K5aYEgdXs/ClBlzhlkjE+LktB
         dl0J/Fg6VAr5UyKC2HvEHbWXSx3qCzUNgqeiMgBNOlfb9adq6Z+0Ivnbvh03BQOiCVxm
         nQW0cT3Rja8LxTUhe+r70FLYSzZM3rsNlwfBAnetZU/D/iBl/LBEsSO0WabcCcpcHy1v
         r4kn//m6WSehMRmFnjIazoxefudmIrGou2qphzh1z5e8/PakvXnuYNGdrT98ibG/uled
         KnrA==
X-Gm-Message-State: AOAM530+OHnLo/OU9ujozJCex2Wn6p62X+Ji2mopx6CHo1ux4d4FONzT
        y7TaskXh64uhRXpPlF9ZWAw=
X-Google-Smtp-Source: ABdhPJzHOoz8+9ti+fXbuPpKkTiz74mWvVEvuIU555+bb83colNPFTAkvWeWhIiw1aBFqx9YNvR3Sw==
X-Received: by 2002:a05:6402:3456:b0:425:ab60:1b00 with SMTP id l22-20020a056402345600b00425ab601b00mr23902968edc.71.1652193931804;
        Tue, 10 May 2022 07:45:31 -0700 (PDT)
Received: from localhost.localdomain (89-38-99-188.hosted-by-worldstream.net. [89.38.99.188])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906241000b006fb6d9d25bfsm829652eja.22.2022.05.10.07.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 07:45:31 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 1/2] remoteproc: qcom: Report last event on SSR notifier registration
Date:   Tue, 10 May 2022 18:42:18 +0400
Message-Id: <20220510144219.806391-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510144219.806391-1-y.oudjana@protonmail.com>
References: <20220510144219.806391-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Keep track of the last SSR event of a remoteproc, then report it
to each newly registered notifier block. This prevents drivers
from waiting indefinitely for an event that has already happened
before they registered their notifier blocks.

Fixes: a899d324863a3 ("slimbus: qcom-ngd-ctrl: add Sub System Restart support")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/remoteproc/qcom_common.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 4b91e3c9eafa..ff85ea564129 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -85,6 +85,7 @@ struct qcom_ssr_subsystem {
 	const char *name;
 	struct srcu_notifier_head notifier_list;
 	struct list_head list;
+	enum qcom_ssr_notify_type current_state;
 };
 
 static LIST_HEAD(qcom_ssr_subsystem_list);
@@ -392,6 +393,9 @@ void *qcom_register_ssr_notifier(const char *name, struct notifier_block *nb)
 
 	srcu_notifier_chain_register(&info->notifier_list, nb);
 
+	/* Notify newly registered notifier block of current remoteproc state */
+	nb->notifier_call(nb, info->current_state, NULL);
+
 	return &info->notifier_list;
 }
 EXPORT_SYMBOL_GPL(qcom_register_ssr_notifier);
@@ -420,8 +424,9 @@ static int ssr_notify_prepare(struct rproc_subdev *subdev)
 		.crashed = false,
 	};
 
+	ssr->info->current_state = QCOM_SSR_BEFORE_POWERUP;
 	srcu_notifier_call_chain(&ssr->info->notifier_list,
-				 QCOM_SSR_BEFORE_POWERUP, &data);
+				 ssr->info->current_state, &data);
 	return 0;
 }
 
@@ -433,8 +438,9 @@ static int ssr_notify_start(struct rproc_subdev *subdev)
 		.crashed = false,
 	};
 
+	ssr->info->current_state = QCOM_SSR_AFTER_POWERUP;
 	srcu_notifier_call_chain(&ssr->info->notifier_list,
-				 QCOM_SSR_AFTER_POWERUP, &data);
+				 ssr->info->current_state, &data);
 	return 0;
 }
 
@@ -446,8 +452,9 @@ static void ssr_notify_stop(struct rproc_subdev *subdev, bool crashed)
 		.crashed = crashed,
 	};
 
+	ssr->info->current_state = QCOM_SSR_BEFORE_SHUTDOWN;
 	srcu_notifier_call_chain(&ssr->info->notifier_list,
-				 QCOM_SSR_BEFORE_SHUTDOWN, &data);
+				 ssr->info->current_state, &data);
 }
 
 static void ssr_notify_unprepare(struct rproc_subdev *subdev)
@@ -458,8 +465,9 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
 		.crashed = false,
 	};
 
+	ssr->info->current_state = QCOM_SSR_AFTER_SHUTDOWN;
 	srcu_notifier_call_chain(&ssr->info->notifier_list,
-				 QCOM_SSR_AFTER_SHUTDOWN, &data);
+				 ssr->info->current_state, &data);
 }
 
 /**
@@ -484,6 +492,7 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
 	}
 
 	ssr->info = info;
+	ssr->info->current_state = QCOM_SSR_BEFORE_POWERUP;
 	ssr->subdev.prepare = ssr_notify_prepare;
 	ssr->subdev.start = ssr_notify_start;
 	ssr->subdev.stop = ssr_notify_stop;
-- 
2.36.0

