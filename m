Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F4050D13C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiDXKsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbiDXKsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:48:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC701A804
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:45:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z30so4330508pfw.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZYZZokAYbHkoKNpRYcwId0oz7EL0chjkDT9m64Fs88=;
        b=qN5AP1svMW7jIvuJ8Q5CJy6NrbX2K1Z1BSUZqSJm1WocHUzV1dNZqEBQ8x1zC8uTMt
         2bIQhcnbS2AM92sqVj8/TQlCGC78fWde3/PiB1bY+r0gFs79ttYzhvBWeHEhbHHfIk9B
         BGirz+cY5s3VM6t+cJBAv28vupLecDbTh8AQRHN9fSnNHqKL/mUTNl/JqOv1i50NTP2u
         3NReAkarqGfyKgiIQO36228zgcIjlaVCBmWFkCGibz4Q+iHiTDsqGr8JTGBR1q9cTLN/
         qQb4z2EYFJb5xSNsUNRKgzUFPa5V2iTtMqoQC6zvbJBtlvogn8aWHEPUdWdzQJZq1LzJ
         yRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZYZZokAYbHkoKNpRYcwId0oz7EL0chjkDT9m64Fs88=;
        b=l+33pehW+qnM+37FpD3oD331PoTL1Dz0pbT3g2QsWrE2xHWc6yKmCO7M4jrJj8tRHR
         H+KyWJV1OhlPcfIq2W1Qd42JfamWOzMsG8mw9gGHPeBERIYw/wAuUZLR9dR9gNz2z33c
         zOy/tJxV1392ltvwYmh6X3eZOpAsSSzsTtrHFf/3oJIl5KinZE+tnc10w4Vv0QHmahwo
         falkty4xsmofyxNRLLpMlwJxESTGvn7DeB2n1KMDTcBM9vRIgzpO9Tw8OA5lsGwEOi7g
         4wcpgFqDF1rdUpSaly40jLgA7OD5XNpyq+V/2P5cZfXOZlOydUZc3Ge9XbdbMnBelyXw
         CqUQ==
X-Gm-Message-State: AOAM533tfy1ZwY0TXSi4zy2fD31bLW6gJNI/LcLOHIerTs23wrvC7ER1
        szQ341w6pCMFUmw3RlUZgeoy9A==
X-Google-Smtp-Source: ABdhPJybb5u79Rbo4xWJV/NXrG26SqZ6A85hpfGQ2sn65t8mv0Y5qVs6QIf2X45l1qDo7jjS18pPqA==
X-Received: by 2002:a05:6a00:1816:b0:50c:7c7b:c06 with SMTP id y22-20020a056a00181600b0050c7c7b0c06mr13728675pfa.49.1650797140411;
        Sun, 24 Apr 2022 03:45:40 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm8287295pfi.86.2022.04.24.03.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 03:45:39 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 1/5] virtio-crypto: change code style
Date:   Sun, 24 Apr 2022 18:41:36 +0800
Message-Id: <20220424104140.44841-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220424104140.44841-1-pizhenwei@bytedance.com>
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use temporary variable to make code easy to read and maintain.
	/* Pad cipher's parameters */
        vcrypto->ctrl.u.sym_create_session.op_type =
                cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
        vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
                vcrypto->ctrl.header.algo;
        vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
                cpu_to_le32(keylen);
        vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
                cpu_to_le32(op);
-->
	sym_create_session = &ctrl->u.sym_create_session;
	sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
	sym_create_session->u.cipher.para.algo = ctrl->header.algo;
	sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
	sym_create_session->u.cipher.para.op = cpu_to_le32(op);

The new style shows more obviously:
- the variable we want to operate.
- an assignment statement in a single line.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 .../virtio/virtio_crypto_akcipher_algs.c      | 40 ++++++-----
 .../virtio/virtio_crypto_skcipher_algs.c      | 72 +++++++++----------
 2 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index f3ec9420215e..20901a263fc8 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -106,23 +106,27 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 	unsigned int inlen;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_session_input *input;
 
 	pkey = kmemdup(key, keylen, GFP_ATOMIC);
 	if (!pkey)
 		return -ENOMEM;
 
 	spin_lock(&vcrypto->ctrl_lock);
-	memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
-	memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
-	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+	ctrl = &vcrypto->ctrl;
+	memcpy(&ctrl->header, header, sizeof(ctrl->header));
+	memcpy(&ctrl->u, para, sizeof(ctrl->u));
+	input = &vcrypto->input;
+	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 
-	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr_sg;
 
 	sg_init_one(&key_sg, pkey, keylen);
 	sgs[num_out++] = &key_sg;
 
-	sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
+	sg_init_one(&inhdr_sg, input, sizeof(*input));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
@@ -134,12 +138,12 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
+	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	ctx->session_id = le64_to_cpu(vcrypto->input.session_id);
+	ctx->session_id = le64_to_cpu(input->session_id);
 	ctx->session_valid = true;
 	err = 0;
 
@@ -149,7 +153,7 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 
 	if (err < 0)
 		pr_err("virtio_crypto: Create session failed status: %u\n",
-			le32_to_cpu(vcrypto->input.status));
+			le32_to_cpu(input->status));
 
 	return err;
 }
@@ -161,23 +165,27 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	unsigned int num_out = 0, num_in = 0, inlen;
 	int err;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_inhdr *ctrl_status;
 
 	spin_lock(&vcrypto->ctrl_lock);
 	if (!ctx->session_valid) {
 		err = 0;
 		goto out;
 	}
-	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
-	vcrypto->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
-	vcrypto->ctrl.header.queue_id = 0;
+	ctrl_status = &vcrypto->ctrl_status;
+	ctrl_status->status = VIRTIO_CRYPTO_ERR;
+	ctrl = &vcrypto->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
+	ctrl->header.queue_id = 0;
 
-	destroy_session = &vcrypto->ctrl.u.destroy_session;
+	destroy_session = &ctrl->u.destroy_session;
 	destroy_session->session_id = cpu_to_le64(ctx->session_id);
 
-	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr_sg;
 
-	sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status, sizeof(vcrypto->ctrl_status.status));
+	sg_init_one(&inhdr_sg, &ctrl_status->status, sizeof(ctrl_status->status));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
@@ -189,7 +197,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
+	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -201,7 +209,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	spin_unlock(&vcrypto->ctrl_lock);
 	if (err < 0) {
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-			vcrypto->ctrl_status.status, destroy_session->session_id);
+			ctrl_status->status, destroy_session->session_id);
 	}
 
 	return err;
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index a618c46a52b8..e3c5bc8d6112 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -123,6 +123,9 @@ static int virtio_crypto_alg_skcipher_init_session(
 	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_session_input *input;
+	struct virtio_crypto_sym_create_session_req *sym_create_session;
 
 	/*
 	 * Avoid to do DMA from the stack, switch to using
@@ -135,24 +138,22 @@ static int virtio_crypto_alg_skcipher_init_session(
 
 	spin_lock(&vcrypto->ctrl_lock);
 	/* Pad ctrl header */
-	vcrypto->ctrl.header.opcode =
-		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
-	vcrypto->ctrl.header.algo = cpu_to_le32(alg);
+	ctrl = &vcrypto->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
+	ctrl->header.algo = cpu_to_le32(alg);
 	/* Set the default dataqueue id to 0 */
-	vcrypto->ctrl.header.queue_id = 0;
+	ctrl->header.queue_id = 0;
 
-	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+	input = &vcrypto->input;
+	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 	/* Pad cipher's parameters */
-	vcrypto->ctrl.u.sym_create_session.op_type =
-		cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
-		vcrypto->ctrl.header.algo;
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
-		cpu_to_le32(keylen);
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
-		cpu_to_le32(op);
-
-	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sym_create_session = &ctrl->u.sym_create_session;
+	sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
+	sym_create_session->u.cipher.para.algo = ctrl->header.algo;
+	sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
+	sym_create_session->u.cipher.para.op = cpu_to_le32(op);
+
+	sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr;
 
 	/* Set key */
@@ -160,7 +161,7 @@ static int virtio_crypto_alg_skcipher_init_session(
 	sgs[num_out++] = &key_sg;
 
 	/* Return status and session id back */
-	sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
+	sg_init_one(&inhdr, input, sizeof(*input));
 	sgs[num_out + num_in++] = &inhdr;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
@@ -180,20 +181,18 @@ static int virtio_crypto_alg_skcipher_init_session(
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
+	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
 		spin_unlock(&vcrypto->ctrl_lock);
 		pr_err("virtio_crypto: Create session failed status: %u\n",
-			le32_to_cpu(vcrypto->input.status));
+			le32_to_cpu(input->status));
 		kfree_sensitive(cipher_key);
 		return -EINVAL;
 	}
 
 	if (encrypt)
-		ctx->enc_sess_info.session_id =
-			le64_to_cpu(vcrypto->input.session_id);
+		ctx->enc_sess_info.session_id = le64_to_cpu(input->session_id);
 	else
-		ctx->dec_sess_info.session_id =
-			le64_to_cpu(vcrypto->input.session_id);
+		ctx->dec_sess_info.session_id = le64_to_cpu(input->session_id);
 
 	spin_unlock(&vcrypto->ctrl_lock);
 
@@ -211,30 +210,30 @@ static int virtio_crypto_alg_skcipher_close_session(
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_inhdr *ctrl_status;
 
 	spin_lock(&vcrypto->ctrl_lock);
-	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
+	ctrl_status = &vcrypto->ctrl_status;
+	ctrl_status->status = VIRTIO_CRYPTO_ERR;
 	/* Pad ctrl header */
-	vcrypto->ctrl.header.opcode =
-		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
+	ctrl = &vcrypto->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
 	/* Set the default virtqueue id to 0 */
-	vcrypto->ctrl.header.queue_id = 0;
+	ctrl->header.queue_id = 0;
 
-	destroy_session = &vcrypto->ctrl.u.destroy_session;
+	destroy_session = &ctrl->u.destroy_session;
 
 	if (encrypt)
-		destroy_session->session_id =
-			cpu_to_le64(ctx->enc_sess_info.session_id);
+		destroy_session->session_id = cpu_to_le64(ctx->enc_sess_info.session_id);
 	else
-		destroy_session->session_id =
-			cpu_to_le64(ctx->dec_sess_info.session_id);
+		destroy_session->session_id = cpu_to_le64(ctx->dec_sess_info.session_id);
 
-	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr;
 
 	/* Return status and session id back */
-	sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
-		sizeof(vcrypto->ctrl_status.status));
+	sg_init_one(&status_sg, &ctrl_status->status, sizeof(ctrl_status->status));
 	sgs[num_out + num_in++] = &status_sg;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
@@ -249,11 +248,10 @@ static int virtio_crypto_alg_skcipher_close_session(
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
+	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		spin_unlock(&vcrypto->ctrl_lock);
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-			vcrypto->ctrl_status.status,
-			destroy_session->session_id);
+			ctrl_status->status, destroy_session->session_id);
 
 		return -EINVAL;
 	}
-- 
2.20.1

