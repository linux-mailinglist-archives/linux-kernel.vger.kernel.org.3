Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD750F28F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbiDZHgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiDZHgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:36:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43311331AF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:33:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j4so5857812lfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+iLRC4aU4qXf7p4vZnxdbVNl0iSUfIahtx7crMn/woE=;
        b=wWqeoszwG81V7Cfq+HpRlPMkW7tnD6rpM3BEEetOC2ei+RyCz+ccC+yCWN+wD2AWRX
         pjaNFtvWPL8ZCQSBvTtr7mmsyV8mk4wSvyomfmtbE5PUYElZ+jfVVyJlTQADMMB6LNmd
         xe5iR0FpRsWHsiaG8Jnb7QhJC2nddq5AzB3ARL1HolFH8JtH4m+HFKllFsKCeCjk1e0e
         7Oz6qIkKDJAzo8S/9uC/kvZwd2tkcx4Zucujp9CBvxmtEFfXm6Rxqg1FbqzJHRUQuF6Z
         KFdhlK4YeanpLUTWI1mm+qWgxN0SdkRBZmGObil/l5Tv+vYl+wBXCx0cRKOpR61S2RAB
         625w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+iLRC4aU4qXf7p4vZnxdbVNl0iSUfIahtx7crMn/woE=;
        b=H6FbB6hugASlKNF7mryGyg+CDXxwh4caVrBsFBW5LME+HBb3C93bNnCGwjAUI7SG/p
         B47jvVu96eL5ZuRFlEwBzonJPxrLz0MF570jZ9zw9kt5niEuh1A/qjT5KBJtIAGh4X8i
         adi4yI+r6B4AIiR6a/STJEfBtWNV5fD8CUto9zxWmcmlLZZuq/CMGiTYi2sim227AiP0
         MMwF3xVsPsz44cmInARgZYzZ0Qs1Kb8/E+Kl0IreBYDVNEjD472QWYHKM6jFWD23Yq0p
         CI8wRZLHtWNjUfPF5Wks7CRXf/c8OEB3J2N4NlpULgylEpqCEBPyaALkki2AhnwRdpIu
         yigg==
X-Gm-Message-State: AOAM531grrDBlxIAmQY4uY4JW/KzQwQWE324ePcD887KeK04+JBffwWY
        3U9E3/ps9QTTyGBXoOBkz++7xbvzBmA2aA==
X-Google-Smtp-Source: ABdhPJxo4B68tJERJrz5wzn553yH8TsOsLDYhLlCMLE+e7ixlID2L9QNinhzU18z0GfqT+VMM3z03A==
X-Received: by 2002:a05:6512:3b81:b0:471:8f4f:51e6 with SMTP id g1-20020a0565123b8100b004718f4f51e6mr16612657lfv.374.1650958422827;
        Tue, 26 Apr 2022 00:33:42 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id s11-20020a2e9c0b000000b0024ace83744asm1430491lji.116.2022.04.26.00.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:33:42 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 1/4] optee: rename rpc_arg_count to rpc_param_count
Date:   Tue, 26 Apr 2022 09:33:35 +0200
Message-Id: <20220426073338.3048192-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220426073338.3048192-1-jens.wiklander@linaro.org>
References: <20220426073338.3048192-1-jens.wiklander@linaro.org>
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

Renames the field rpc_arg_count in struct optee to rpc_param_count.
Function parameter names and local variables are also renamed to match.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          |  6 +++---
 drivers/tee/optee/ffa_abi.c       | 10 +++++-----
 drivers/tee/optee/optee_private.h |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index bd49ec934060..a9a237d20c61 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -113,12 +113,12 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
 	struct optee_msg_arg *ma;
 
 	/*
-	 * rpc_arg_count is set to the number of allocated parameters in
+	 * rpc_param_count is set to the number of allocated parameters in
 	 * the RPC argument struct if a second MSG arg struct is expected.
 	 * The second arg struct will then be used for RPC.
 	 */
-	if (optee->rpc_arg_count)
-		sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_arg_count);
+	if (optee->rpc_param_count)
+		sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_param_count);
 
 	shm = tee_shm_alloc_priv_buf(ctx, sz);
 	if (IS_ERR(shm))
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index a5eb4ef46971..7686f7020616 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -678,7 +678,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 
 static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 				    const struct ffa_dev_ops *ops,
-				    unsigned int *rpc_arg_count)
+				    unsigned int *rpc_param_count)
 {
 	struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
 	int rc;
@@ -693,7 +693,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 		return false;
 	}
 
-	*rpc_arg_count = (u8)data.data1;
+	*rpc_param_count = (u8)data.data1;
 
 	return true;
 }
@@ -772,7 +772,7 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
 static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
 	const struct ffa_dev_ops *ffa_ops;
-	unsigned int rpc_arg_count;
+	unsigned int rpc_param_count;
 	struct tee_shm_pool *pool;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
@@ -788,7 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
 		return -EINVAL;
 
-	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_arg_count))
+	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param_count))
 		return -EINVAL;
 
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
@@ -805,7 +805,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee->ops = &optee_ffa_ops;
 	optee->ffa.ffa_dev = ffa_dev;
 	optee->ffa.ffa_ops = ffa_ops;
-	optee->rpc_arg_count = rpc_arg_count;
+	optee->rpc_param_count = rpc_param_count;
 
 	teedev = tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
 				  optee);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index e77765c78878..e80c5d9b62ec 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -143,7 +143,7 @@ struct optee_ops {
  * @notif:		notification synchronization struct
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
- * @rpc_arg_count:	If > 0 number of RPC parameters to make room for
+ * @rpc_param_count:	If > 0 number of RPC parameters to make room for
  * @scan_bus_done	flag if device registation was already done.
  * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
  * @scan_bus_work	workq to scan optee bus and register optee drivers
@@ -161,7 +161,7 @@ struct optee {
 	struct optee_notif notif;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
-	unsigned int rpc_arg_count;
+	unsigned int rpc_param_count;
 	bool   scan_bus_done;
 	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
-- 
2.31.1

